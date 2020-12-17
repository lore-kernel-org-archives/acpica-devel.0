Content-Type: multipart/mixed; boundary="===============4840473205009002334=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20201217 released
Date: Thu, 17 Dec 2020 21:28:27 +0000
Message-ID: <BYAPR11MB3256FAD9C20A842C02C1CD3887C40@BYAPR11MB3256.namprd11.prod.outlook.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4840473205009002334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

17 December 2020. Summary of changes for version 20201217:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Note: The implementation of ACPI 6.4 is underway, and is expected to be mos=
tly finished next month, when ACPI 6.4 is released.

From qzed:- fixed-ae-class-macros. Fix exception code class checks. Added s=
everal new macros, such as ACPI_CNTL_EXCEPTION(Status) in order to enable t=
his.

AcpiExec/iASL/AcpiHelp: Added a few changes for support of GCC 10.2.0. Thes=
e included a few casts, as well as a null pointer check.

Fix -Wfallthrough: GCC 7.1 gained -Wimplicit-fallthrough to warn on implici=
t fallthrough, as well as __attribute__((__fallthrough__)) and comments to =
explicitly denote that cases of fallthrough were intentional. Clang also su=
pports this warning and statement attribute, but not the comment form. Adde=
d a new macro, ACPI_FALLTHROUGH to support this feature of GCC. With assist=
ance from @nickdesaulniers. =


2) iASL Compiler/Disassembler and ACPICA tools: =


Added improvement to method call analysis by saving the return type and rel=
axing certain cases of type checking.

iASL Table Compiler: Improved info messages. Added a message to the -T opti=
on for when the default template (DSDT) is used.
Also added a note for when multiple SSDTs are created with a DSDT that the =
SSDTs are created in the same file as the DSDT.

--===============4840473205009002334==--

