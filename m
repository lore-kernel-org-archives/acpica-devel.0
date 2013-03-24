Content-Type: multipart/mixed; boundary="===============7878981642387154388=="
MIME-Version: 1.0
From: Andriy Gapon <avg at FreeBSD.org>
Subject: Re: [Devel] ref-counting races?
Date: Sun, 24 Mar 2013 13:10:13 +0200
Message-ID: <514EDF15.9070609@FreeBSD.org>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E88015C68A8@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7878981642387154388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

on 22/03/2013 06:28 Zheng, Lv said the following:
>> 1. Ensure that AcpiGetObjectInfo/AcpiUtExecute_HID/etc are never executed
>> concurrently on the same object at the OS level code (primarily in the b=
attery
>> driver).
>>
>> 2. Ensure that AcpiUtRemoveReference is always invoked under some lock.
>> Not sure
>> if it should be the Interpreter mutex or the Namespace mutex.  I believe=
 that
>> AcpiUtAddReference are always consistently called under a lock, but I ha=
ven't
>> verified all the code paths.  On the other hand, it is obvious that ther=
e are
>> many
>> places where AcpiUtRemoveReference is called without any protection, but=
 it is
>> hard to conclusively enumerate _all_ of them.
> =

> Hi, Andriy, your codes are using AcpiOsAcquireMutext to achieve this goal=
, it does not look like correct.
>

Perhaps it's not perfect/appropriate, but I am sure that it is not incorrec=
t.
In either case, I support using a spin-lock here.

>> 3. Introduce locking to AcpiUtUpdateRefCount to ensure that ReferenceCou=
nt
>> is
>> never modified concurrently.  Essentially this should give an equivalenc=
e of
>> atomicity for ReferenceCount manipulations.
>> Additionally, it would be a good idea to make ReferenceCount =3D=3D 0 ch=
eck more
>> strict (if not fatal).  Also, unused and dangerous REF_FORCE_DELETE shou=
ld
>> be removed.
> =

> It does not look good and sufficient.
> We need to add a "never-return error" mutex in OSL first then do many tes=
ts to see if there are regressions.

Well, I think that possibilities for ACPICA mutex to return an error are ve=
ry
well enumerated in the ACPICA reference manual.  So, if there is no timeout
specified and the lock parameter is definitely not NULL, then we should exp=
ect
that mutex lock and unlock never fail.

> There might be regressions if dead lock happens.

I do not see any possibility for a deadlock with the proposed new lock, bec=
ause
it is a leaf lock (it spans only basic operations and no function calls).

>> I like #3 the best because it provides the most guarantees while requiri=
ng the
>> least code inspection/verification efforts.
>> Of course, you know the code much better, so your assessment of the prob=
lem
>> and
>> possible solutions could be very different.
>>
>> Here is a quickly hacked together prototype patch that seems to have hel=
ped
>> the user:
>> http://people.freebsd.org/~avg/acpi-ref-count-2.diff
> =

> The code looks broken on Linux, it might be broken on freebsd. Isn't it?

It is not broken on FreeBSD.
What is broken on Linux?  If you mean the panic calls, then I've already sa=
id
that they are FreeBSD-specific and are only there to mark dangerous (fatal,
even) conditions that the current code simply ignores.

> Why don't we consider to have an AcpiAtomic implementation in every OSL?

AcpiAtomic could be useful for other things, but I do not see it being
_required_ here.

-- =

Andriy Gapon

--===============7878981642387154388==--

