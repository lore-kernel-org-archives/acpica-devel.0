Content-Type: multipart/mixed; boundary="===============1447396631296198259=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: [Devel] Reserved method (_PLD) is a buffer instead of a package
Date: Mon, 05 Jul 2010 15:10:18 +0200
Message-ID: <201007051510.18302.trenn@suse.de>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1447396631296198259==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I found this when compiling the DSDT from this dump:
https://bugzilla.kernel.org/attachment.cgi?id=3D27016
from this bug:
https://bugzilla.kernel.org/show_bug.cgi?id=3D16072

The iasl error is:
DSDT.modif.dsl  6635:                         Name (_PLD, Buffer (0x10)
Error    4080 -       Invalid object type for reserved name, must be ^  (Pa=
ckage)


ACPI spec says (3.0b):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
6.1.6 _PLD (Physical Device Location)

The _PLD method returns data...

This method returns a package containing, a single
or multiple buffer entries. At least one buffer entry
must be returned using the bit definitions below.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

So I expect the BIOS (see code snippet below) is wrong, because it
returns a plain buffer, instead of a Package of buffer(s)?

I could get rid of the error by explicitly declaring the buffer and
returning it (which should still be wrong, because a Package of
buffer(s) should get returned?).

iasl should either:
  - complain about both (a named buffer is declared and the named
    object is returned or if simply a (unnamed) buffer is returned)
  - or if in case returning a plain buffer is accepted/workarounded,
    it should accept both versions.

Argl, it's hard to get this into words, best you just have a look at below
code snippets...

Be aware that this seem to be a rather new machine/BIOS.
It could be that neither Linux nor Windows make use of _PLD (don't know)
and these guys may have to fix that up anyway (return a package...).

It would be great to get a statement should fix this and if this is the cas=
e,
whether my patch at the very end of the mail is the correct way to do that.

Thanks,

      Thomas

The affected ASL code:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Name (_ADR, Zero)
                    Device (PRT1)
                    {
                        Name (_ADR, One)
                        Name (_UPC, Package (0x04)
                        {
                            0xFF, =

                            Zero, =

                            Zero, =

                            Zero
                        })
                        Name (_PLD, Buffer (0x10)
                        {
                            /* 0000 */    0x81, 0x00, 0x00, 0x00, 0x00, 0x0=
0, 0x00, 0x00, =

                            /* 0008 */    0x31, 0x1C, 0x00, 0x00, 0x00, 0x0=
0, 0x00, 0x00
                        })
                    }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The patch that fixes the error, but the code is still not correct (plain bu=
ffer is
returned instead of a package containing the buffer):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- DSDT.dsl	2010-07-05 13:14:20.945010000 +0200
+++ DSDT.modif.dsl	2010-07-05 13:56:56.478132000 +0200
@@ -6601,6 +6601,11 @@
                 Device (HU01)
                 {
                     Name (_ADR, Zero)
+		    Name (PLDB, Buffer (0x10)
+                    {
+                            /* 0000 */    0x81, 0x00, 0x00, 0x00, 0x00, 0x=
00, 0x00, 0x00, =

+                            /* 0008 */    0x31, 0x1C, 0x00, 0x00, 0x00, 0x=
00, 0x00, 0x00
+                    })
                     Device (PRT1)
                     {
                         Name (_ADR, One)
@@ -6611,11 +6616,10 @@
                             Zero, =

                             Zero
                         })
-                        Name (_PLD, Buffer (0x10)
+                        Method (_PLD, 0, NotSerialized)
                         {
-                            /* 0000 */    0x81, 0x00, 0x00, 0x00, 0x00, 0x=
00, 0x00, 0x00, =

-                            /* 0008 */    0x31, 0x1C, 0x00, 0x00, 0x00, 0x=
00, 0x00, 0x00
-                        })
+			    return (PLDB)
+                        }
                     }
 =

                     Device (PRT2)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The patch which works and should be the correct fix:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- DSDT.dsl	2010-07-05 13:14:20.945010000 +0200
+++ DSDT.modif.dsl	2010-07-05 14:34:23.335580000 +0200

@@ -6628,10 +6635,13 @@
                             Zero, =

                             Zero
                         })
-                        Name (_PLD, Buffer (0x10)
+                        Name (_PLD, Package (0x1)
                         {
-                            /* 0000 */    0x81, 0x00, 0x00, 0x00, 0x00, 0x=
00, 0x00, 0x00, =

-                            /* 0008 */    0x30, 0x1C, 0x00, 0x00, 0x00, 0x=
00, 0x00, 0x00
+                            Buffer (0x10)
+                            {
+                                /* 0000 */    0x81, 0x00, 0x00, 0x00, 0x00=
, 0x00, 0x00, 0x00, =

+                                /* 0008 */    0x30, 0x1C, 0x00, 0x00, 0x00=
, 0x00, 0x00, 0x00
+                            }
                         })
                     }
                 }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--===============1447396631296198259==--

