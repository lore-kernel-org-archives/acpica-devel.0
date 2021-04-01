Content-Type: multipart/mixed; boundary="===============8606365690218765620=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20210331 released
Date: Thu, 01 Apr 2021 20:25:15 +0000
Message-ID: <BYAPR11MB3256674E208EC828B488AD3D877B9@BYAPR11MB3256.namprd11.prod.outlook.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8606365690218765620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

31 March 2021. Summary of changes for version 20210331:

This release is available at https://acpica.org/downloads, and includes all=
 ACPI 6.4 support

1) ACPICA kernel-resident subsystem:
ACPI 6.4: iASL: deprecate DDBHandleObj keyword
Always create namespace nodes using AcpiNsCreateNode(). ACPICA is allocatin=
g an object using kmalloc(), but then frees it
using kmem_cache_free(<"Acpi-Namespace" kmem_cache>). This is wrong.
Fixed a race condition in generic serial bus operation region handler. Fixe=
d by Hans de Goede.

2) iASL Compiler/Disassembler and ACPICA tools:

ACPI 6.4: NFIT: add Location Cookie field
ACPI 6.4: HMAT: add new fields/flags
ACPI 6.4: Add new flags in SRAT
ACPI 6.4: add SDEV secure access components
ACPI 6.4: add Csi2Bus resource template
ACPI 6.4: add support for PHAT table
ACPI 6.4: add support for PMTT table
Add disassembly support for the IVRS table. Compilation of the table is not=
 yet complete.
Fixed a potential infinite loop due to type mismatch. The for-loop is using=
 a UINT8 counter and comparing the upper
limit against a UINT32 AslGbl_ExpectedMessagesIndex maximum. In
the case where AslGbl_ExpectedMessagesIndex is > 255 the counter i
will wrap around to zero and the loop will never exit. I suspect
the AslGbl_ExpectedMessagesIndex is never that high, but fixing
this does future proof the code and cleans up static analysis
warnings.Colin King.
iASL/TableCompiler: update it with IORT table E.b revision changes.
iASL/TableCompiler: Add compilation support for the VIOT table. Signed-off-=
by: Jean-Philippe Brucker.
iASL/TableCompiler: Add compilation support for CEDT table. Also, update th=
e CEDT template.

--===============8606365690218765620==--

