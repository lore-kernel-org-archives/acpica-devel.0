Content-Type: multipart/mixed; boundary="===============1608833734842853504=="
MIME-Version: 1.0
From: Lin Ming <ming.m.lin at intel.com>
Subject: Re: [Devel] Name object change produces unexpected errors.
Date: Mon, 08 Mar 2010 09:38:44 +0800
Message-ID: <1268012324.3356.7.camel@minggr.sh.intel.com>
In-Reply-To: 508889.22399.qm@web62005.mail.re1.yahoo.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1608833734842853504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 2010-03-07 at 16:43 +0800, master chief wrote:
> I was kind of expecting this to happen:
> =

> ----------------------------------------------------------------------
> ssdt.dsl    80:             Name (_ADR, Zero)
> Error    4080 -                            ^ Invalid object type for rese=
rved name, must be (Integer)
> =

> ssdt.dsl    81:             Name (_SUN, One)
> Error    4080 -                           ^ Invalid object type for reser=
ved name, must be (Integer)
> =

> ASL Input:  ssdt.dsl - 328 lines, 9645 bytes, 79 keywords
> Compilation complete. 2 Errors, 0 Warnings, 0 Remarks, 0 Optimizations
> ----------------------------------------------------------------------
> =

> But aren't the constants 'Zero' and 'One' supposed to be of type integer =
already?

Yes, they are integer.
There is a bug in the latest release(20100304).

> =

> We can't use 0x00 and 0x01 here, because then we are stuck with two "Opti=
mizations".  That is a no go since I have to deliver a product without erro=
rs, warnings and optimizations.  I am confused.  What are we supposed to us=
e now?
> =


Would you please apply this patch or use the old release?

diff --git a/compiler/aslpredef.c b/compiler/aslpredef.c
index 04cd2d4..30d33d5 100644
--- a/compiler/aslpredef.c
+++ b/compiler/aslpredef.c
@@ -535,6 +535,9 @@ ApCheckObjectType (
     switch (Op->Asl.ParseOpcode)
     {
     case PARSEOP_INTEGER:
+    case PARSEOP_ZERO:
+    case PARSEOP_ONE:
+    case PARSEOP_ONES:
         ReturnBtype =3D ACPI_RTYPE_INTEGER;
         break;
 =

---
Lin Ming


--===============1608833734842853504==--

