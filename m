Content-Type: multipart/mixed; boundary="===============0070853751034751235=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] ref-counting races?
Date: Fri, 22 Mar 2013 04:28:06 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88015C68A8@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 514B4C70.5050305@FreeBSD.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0070853751034751235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> 1. Ensure that AcpiGetObjectInfo/AcpiUtExecute_HID/etc are never executed
> concurrently on the same object at the OS level code (primarily in the ba=
ttery
> driver).
> =

> 2. Ensure that AcpiUtRemoveReference is always invoked under some lock.
> Not sure
> if it should be the Interpreter mutex or the Namespace mutex.  I believe =
that
> AcpiUtAddReference are always consistently called under a lock, but I hav=
en't
> verified all the code paths.  On the other hand, it is obvious that there=
 are
> many
> places where AcpiUtRemoveReference is called without any protection, but =
it is
> hard to conclusively enumerate _all_ of them.

Hi, Andriy, your codes are using AcpiOsAcquireMutext to achieve this goal, =
it does not look like correct.

> 3. Introduce locking to AcpiUtUpdateRefCount to ensure that ReferenceCount
> is
> never modified concurrently.  Essentially this should give an equivalence=
 of
> atomicity for ReferenceCount manipulations.
> Additionally, it would be a good idea to make ReferenceCount =3D=3D 0 che=
ck more
> strict (if not fatal).  Also, unused and dangerous REF_FORCE_DELETE should
> be removed.

It does not look good and sufficient.
We need to add a "never-return error" mutex in OSL first then do many tests=
 to see if there are regressions.
There might be regressions if dead lock happens.

> I like #3 the best because it provides the most guarantees while requirin=
g the
> least code inspection/verification efforts.
> Of course, you know the code much better, so your assessment of the probl=
em
> and
> possible solutions could be very different.
> =

> Here is a quickly hacked together prototype patch that seems to have help=
ed
> the user:
> http://people.freebsd.org/~avg/acpi-ref-count-2.diff

The code looks broken on Linux, it might be broken on freebsd. Isn't it?
Why don't we consider to have an AcpiAtomic implementation in every OSL?

Thanks and best regards
-Lv

--===============0070853751034751235==--

