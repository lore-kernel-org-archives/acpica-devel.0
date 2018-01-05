Content-Type: multipart/mixed; boundary="===============2399799367182009000=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20180105 released
Date: Fri, 05 Jan 2018 17:00:39 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B7502010@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2399799367182009000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

05 January 2018. Summary of changes for version 20180105:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Updated all copyrights to 2018. This affects all source code modules.

Fixed a possible build error caused by an unresolved reference to the AcpiU=
tSafeStrncpy function.

Removed NULL pointer arithmetic in the various pointer manipulation macros.=
 All "(void *) NULL" constructs are converted to "(void *) 0". This elimina=
tes warnings/errors in newer C compilers. Jung-uk Kim.

Added support for A32 ABI compilation, which uses the ILP32 model. Anuj Mit=
tal.


2) iASL Compiler/Disassembler and Tools:

ASLTS: Updated all copyrights to 2018.

Tools: Updated all signon copyrights to 2018.

AcpiXtract: Fixed a regression related to ACPI table signatures where the s=
ignature was truncated to 3 characters (instead of 4).

AcpiExec: Restore the original terminal mode after the use of the -v and -v=
d options.

ASLTS: Deployed the iASL __METHOD__ macro across the test suite.


--===============2399799367182009000==--

