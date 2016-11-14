Content-Type: multipart/mixed; boundary="===============8177946368847622427=="
MIME-Version: 1.0
From: scole_mail <scole_mail at gmx.com>
Subject: [Devel] patch request for tbxfload.c
Date: Mon, 14 Nov 2016 08:58:57 -0800
Message-ID: <87poly0zhq.fsf@gmx.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8177946368847622427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I was hoping this patch could be added.  I am trying to run
netbsd/ia64 on a simulator (ski).  Without the patch, I get a
segfault.  With it, I get the same messages as previous acpica
versions with no seg-faulting.

I'm not sure if it is a just a ia64/ski issue, but it seems like
AcpiGbl_DsdtIndex is never getting set.  It looks like only
AcpiTbInstallFixedTable() sets it, but I'm not seeing that called.
AcpiTbInstallTableWithOverride() has a comment saying it sets it, but
I don't see AcpiGbl_DsdtIndex passed to it either.

Output with the patch is below.

Thanks

*** ./acpica-unix-20160930/source/components/tables/tbxfload.c.orig	Mon Nov=
 14 08:44:43 2016
--- ./acpica-unix-20160930/source/components/tables/tbxfload.c	Mon Nov 14 0=
8:47:04 2016
***************
*** 236,241 ****
--- 236,250 ----
      (void) AcpiUtAcquireMutex (ACPI_MTX_TABLES);
  =

      /*
+      * If AcpiGbl_DsdtIndex uninitialized, give up.
+      */
+     if (AcpiGbl_DsdtIndex =3D=3D ACPI_INVALID_TABLE_INDEX)
+     {
+         Status =3D AE_NO_ACPI_TABLES;
+         goto UnlockAndExit;
+     }
+     =

+     /*
       * Load the namespace. The DSDT is required, but any SSDT and
       * PSDT tables are optional. Verify the DSDT.
       */

ACPI: RSDP 0x0000000000120420 00002C (v02 FBSD  )
ACPI: XSDT 0x0000000000120444 00002C (v00 FBSD   SKI      00000000 FBSD 000=
00000)
ACPI BIOS Warning (bug): Incorrect checksum in table [APIC] - 0x00, should =
be 0x0C (20160930/tbprint-233)
ACPI: APIC 0x0000000000120470 000080 (v00 FBSD   SKI      00000000 FBSD 000=
00000)
ACPI Exception: AE_NO_ACPI_TABLES, While loading namespace from ACPI tables=
 (20160930/tbxfload-111)
ACPI Warning: AcpiEnable failed (20160930/utxfinit-184)
acpi_probe: failed to enable subsystem
ACPI Error: Could not remove SCI handler (20160930/evmisc-312)
acpi0 at mainbus0: Intel ACPICA 20160930
acpi0: X/RSDT: OemId <  FBSD,     SKI,00000000>, AslId <FBSD,00000000>
ACPI Warning: AcpiEnable failed (20160930/utxfinit-184)
acpi_attach: failed to initialize ACPI: AE_NO_ACPI_TABLES

--===============8177946368847622427==--

