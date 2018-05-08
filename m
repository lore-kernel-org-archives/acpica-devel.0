Content-Type: multipart/mixed; boundary="===============2872582198738246916=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20180508 released
Date: Tue, 08 May 2018 16:37:19 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B75E4494@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2872582198738246916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

8 May 2018. Summary of changes for version 20180508:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Completed the new (recently deployed) package resolution mechanism for the =
Load and LoadTable ASL/AML operators. This fixes a regression that was intr=
oduced in version 20180209 that could result in an AE_AML_INTERNAL exceptio=
n during the loading of a dynamic ACPI/AML table (SSDT) that contains packa=
ge objects.


2) iASL Compiler/Disassembler and Tools:

AcpiDump and AcpiXtract: Implemented support for ACPI tables larger than 1 =
MB. This change allows for table offsets within the acpidump file to be up =
to 8 characters. These changes are backwards compatible with existing acpid=
ump files.



--===============2872582198738246916==--

