Content-Type: multipart/mixed; boundary="===============8113615667167149707=="
MIME-Version: 1.0
From: Andriy Gapon <avg at FreeBSD.org>
Subject: Re: [Devel] ref-counting races?
Date: Sun, 24 Mar 2013 12:54:52 +0200
Message-ID: <514EDB7C.8040202@FreeBSD.org>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E36F48C23B@ORSMSX101.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8113615667167149707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

on 22/03/2013 22:23 Moore, Robert said the following:
> Andriy,
> =

> This will of course take a bit of time for us to completely sort out. You=
 are
> correct that there are unlocked calls to the reference count mechanism. T=
his
> could be a result of some code restructuring sometime in the past, as I h=
ope
> that this didn't happen as an oversight.
> =

> I want to investigate some older code as well as the original design of t=
he
> reference counts.

Thank you!

> If we do need a separate lock for the reference count mechanism, perhaps a
> spin lock could be used instead of a mutex, as there is nothing that will
> block for any length of time. This may not make any difference on FreeBSD=
 as
> spinlocks may not be available, I'm not sure.

I agree that a spinlock would be more appropriate.  Just in case, FreeBSD d=
oes
provide ACPICA spinlock implementation.

> In the meantime, I have removed the REF_FORCE_DELETE option as per your
> suggestion; it was implemented in case it was ever needed, which it has n=
ot.

Thank you again.

Do you perhaps have an advice on an interim solution for FreeBSD users who =
seem
to keep bumping into this issue?
I will have a look into trying to prevent concurrency at the battery driver
level.  To, at least, reduce the chances of hitting the problem.

In fact, I'll ask the user who helped me, kron24(a)gmail.com, to test the
following (rather coarse) patch:
--- a/sys/dev/acpica/acpi_battery.c
+++ b/sys/dev/acpica/acpi_battery.c
@@ -360,6 +360,8 @@ acpi_battery_ioctl(u_long cmd, caddr_t addr, void *arg)
     int error, unit;
     device_t dev;

+    mtx_lock(&Giant);
+
     /* For commands that use the ioctl_arg struct, validate it first. */
     error =3D ENXIO;
     unit =3D 0;
@@ -417,6 +419,7 @@ acpi_battery_ioctl(u_long cmd, caddr_t addr, void *arg)
 	error =3D EINVAL;
     }

+    mtx_unlock(&Giant);
     return (error);
 }


-- =

Andriy Gapon

--===============8113615667167149707==--

