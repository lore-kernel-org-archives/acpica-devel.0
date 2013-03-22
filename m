Content-Type: multipart/mixed; boundary="===============8552181212561373664=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] ref-counting races?
Date: Fri, 22 Mar 2013 20:23:09 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36F48C23B@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 514B4C70.5050305@FreeBSD.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8552181212561373664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Andriy,

This will of course take a bit of time for us to completely sort out. You a=
re correct that there are unlocked calls to the reference count mechanism. =
This could be a result of some code restructuring sometime in the past, as =
I hope that this didn't happen as an oversight.

I want to investigate some older code as well as the original design of the=
 reference counts.

If we do need a separate lock for the reference count mechanism, perhaps a =
spin lock could be used instead of a mutex, as there is nothing that will b=
lock for any length of time. This may not make any difference on FreeBSD as=
 spinlocks may not be available, I'm not sure.

In the meantime, I have removed the REF_FORCE_DELETE option as per your sug=
gestion; it was implemented in case it was ever needed, which it has not.

Thanks,
Bob


> -----Original Message-----
> From: Andriy Gapon [mailto:avg(a)FreeBSD.org]
> Sent: Thursday, March 21, 2013 11:08 AM
> To: Moore, Robert
> Cc: devel(a)acpica.org; Zheng, Lv
> Subject: Re: [Devel] ref-counting races?
> =

> on 21/11/2012 17:18 Moore, Robert said the following:
> >> -----Original Message-----
> >> From: Andriy Gapon [mailto:avg(a)FreeBSD.org]
> [snip]
> >> AcpiUtUpdateRefCount handling of REF_DECREMENT && Count < 1 looks
> >> worrying.
> >> Not sure if that ever happens in practice, but since the code exists...
> >> The case is being treated as a minor event (judging from the
> >> debugging print), but we are already lucky if we see Count =3D=3D 0 th=
ere
> >> instead of some garbage or just plain crashing because the memory is
> already freed.
> >> Nevertheless we discard even that luck by happily continuing into
> >> potentially a repeated call to AcpiUtDeleteInternalObj.
> >
> > This code appears in order to essentially catch a case where an
> > attempt is made to delete an object twice. Admittedly, it doesn't
> > serve much purpose these days and should probably be removed. In
> > practice, we never, ever hit the (Count < 1) case that I know of. In
> > other words, I don't know of any cases where the acpica code ever
> attempts to delete an object twice.
> =

> With a help from a skilled user we've been able to catch a likely culprit
> of the FreeBSD + ACPICA heisenbugs, which all showed some relation to the
> FreeBSD battery driver.
> =

> Probably unlike other OSes FreeBSD liberally uses AcpiGetObjectInfo in the
> code that handles battery status queries from userland.  What's more,
> FreeBSD allows such queries to run in parallel and, thus,
> AcpiGetObjectInfo may be executed concurrently by more than one thread.
> In turn, AcpiGetObjectInfo calls functions like AcpiUtExecute_HID,
> AcpiUtExecute_UID, etc.  These functions are called without holding any
> lock and thus, for example, AcpiUtExecute_HID may run in parallel.
> =

> The above mentioned functions all follow the same template:
> {
>     Status =3D AcpiUtEvaluateObject (DeviceNode, METHOD_NAME__HID,
>                 ACPI_BTYPE_INTEGER | ACPI_BTYPE_STRING, &ObjDesc); ... do
> useful work ...
> =

> Cleanup:
> =

>     /* On exit, we must delete the return object */
> =

>     AcpiUtRemoveReference (ObjDesc);
>     return_ACPI_STATUS (Status);
> }
> =

> =

> It can be clearly seen that AcpiUtRemoveReference is called without
> protection of any lock.  Neither of AcpiUtRemoveReference ->
> AcpiUtUpdateObjectReference -> AcpiUtUpdateRefCount use any lock.
> =

> So, in the above code path ReferenceCount is decremented without holding
> any lock.
> Given that the decrement is performed in "highly" non-atomic fashion, it
> is open to races.
> =

> E.g. let's assume that we have some like this in ASL:
> Name (_HID, EisaId ("PNP0C0E"))
> =

> Creation of the _HID node would create a value object with reference count
> of 1.
> Let's assume that thread T1 executes AcpiUtExecute_HID.
> Then AcpiUtEvaluateObject would increment the count to 2.
> Let's assume that thread T2 then concurrently executes AcpiUtExecute_HID.
> It is possible that T1 and T2 would then concurrently call
> AcpiUtUpdateRefCount:
> T1 with REF_DECREMENT (via AcpiUtRemoveReference) and T2 with
> REF_INCREMENT (via AcpiUtEvaluateObject).
> Both would see the same reference count of 2 as a starting value.
> If T2 is quicker to write 3 into ReferenceCount, then T1 would overwrite
> it with 1.
> Then, when T2 calls AcpiUtRemoveReference, it would decrement
> ReferenceCount to zero and thus the value object would be freed while the
> node still has a pointer to its address.
> =

> Subsequent accesses to the _HID node would be accessing freed memory.
> =

> This description is very consistent with the problem reports from users.
> Taking the most recent example:
> http://thread.gmane.org/gmane.os.freebsd.devel.acpi/7707
> =

> The panic was preceded by the following messages:
> ACPI Error: No object attached to node 0xfffffe00094a51c0
> (20110527/exresnte-138) ACPI Error: Method execution failed
> [\_SB_.BAT0._UID] (Node 0xfffffe00094a51c0), AE_AML_NO_OPERAND
> (20110527/uteval-113)
> =

> The panic itself is consistent with corruption of ACPICA object cache:
> http://thread.gmane.org/gmane.os.freebsd.devel.acpi/7707/focus=3D7730
> =

> All the reports (some of which I mentioned at the start of this thread)
> follow the same pattern: a panic in object cache code, frequently preceded
> by various error messages related to battery device _UID/_HID/etc (such as
> missing object or wrong object type, etc).
> =

> I see several possibilities of fixing this problem.
> From worst to best:
> =

> 1. Ensure that AcpiGetObjectInfo/AcpiUtExecute_HID/etc are never executed
> concurrently on the same object at the OS level code (primarily in the
> battery driver).
> =

> 2. Ensure that AcpiUtRemoveReference is always invoked under some lock.
> Not sure if it should be the Interpreter mutex or the Namespace mutex.  I
> believe that AcpiUtAddReference are always consistently called under a
> lock, but I haven't verified all the code paths.  On the other hand, it is
> obvious that there are many places where AcpiUtRemoveReference is called
> without any protection, but it is hard to conclusively enumerate _all_ of
> them.
> =

> 3. Introduce locking to AcpiUtUpdateRefCount to ensure that ReferenceCount
> is never modified concurrently.  Essentially this should give an
> equivalence of atomicity for ReferenceCount manipulations.
> Additionally, it would be a good idea to make ReferenceCount =3D=3D 0 che=
ck
> more strict (if not fatal).  Also, unused and dangerous REF_FORCE_DELETE
> should be removed.
> =

> I like #3 the best because it provides the most guarantees while requiring
> the least code inspection/verification efforts.
> Of course, you know the code much better, so your assessment of the
> problem and possible solutions could be very different.
> =

> Here is a quickly hacked together prototype patch that seems to have
> helped the user:
> http://people.freebsd.org/~avg/acpi-ref-count-2.diff
> =

> The panic calls are to demonstrate various dangerous places in the current
> code.
> They were actually hit in testing before the locking was added.
> =

> --
> Andriy Gapon

--===============8552181212561373664==--

