Content-Type: multipart/mixed; boundary="===============1492117212544604398=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20140214 released
Date: Fri, 14 Feb 2014 22:43:56 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37C7D70EC@ORSMSX103.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1492117212544604398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

14 February 2014. Summary of changes for version 20140214:

This release is available at https://acpica.org/downloads

1) ACPICA kernel-resident subsystem:

Implemented a new mechanism to proactively prevent problems with ill-behave=
d reentrant control methods that create named ACPI objects. This behavior i=
s illegal as per the ACPI specification, but is nonetheless frequently seen=
 in the field. Previously, this could lead to an AE_ALREADY_EXISTS exceptio=
n if the method was actually entered by more than one thread. This new mech=
anism detects such methods at table load time and marks them "serialized" t=
o prevent reentrancy. A new global option, AcpiGbl_AutoSerializeMethods, ha=
s been added to disable this feature if desired. This mechanism and global =
option obsoletes and supersedes the previous AcpiGbl_SerializeAllMethods op=
tion.

Added the "Windows 2013" string to the _OSI support. ACPICA will now respon=
d TRUE to _OSI queries with this string. It is the stated policy of ACPICA =
to add new strings to the _OSI support as soon as possible after they are d=
efined. See the full ACPICA _OSI policy which has been added to the utiliti=
es/utosi.c file.

Hardened/updated the _PRT return value auto-repair code:
1) Do not abort the repair on a single subpackage failure, continue to chec=
k all subpackages.
2) Add check for the minimum subpackage length (4).
3) Properly handle extraneous NULL package elements.

Added support to avoid the possibility of infinite loops when traversing ob=
ject linked lists. Never allow an infinite loop, even in the face of corrup=
ted object lists.

ACPICA headers: Deployed the use of #pragma pack(push) and #pragma pack(pop=
) directives to ensure that the ACPICA headers are independent of compiler =
settings or other host headers.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version:  96.5K Code, 27.2K Data, 123.7K Total
    Debug Version:     188.6K Code, 79.0K Data, 267.6K Total
  Previous Release:
    Non-Debug Version:  96.2K Code, 27.0K Data, 123.2K Total
    Debug Version:     187.5K Code, 78.3K Data, 265.8K Total


2) iASL Compiler/Disassembler and Tools:

iASL/Table-compiler: Fixed a problem with support for the SPMI table. The f=
irst reserved field was incorrectly forced to have a value of zero. This ch=
ange correctly forces the field to have a value of one. ACPICA BZ 1081.

Debugger: Added missing support for the "Extra" and "Data" subobjects when =
displaying object data.

Debugger: Added support to display entire object linked lists when displayi=
ng object data.

iASL: Removed the obsolete -g option to obtain ACPI tables from the Windows=
 registry. This feature has been superseded by the acpidump utility.


--===============1492117212544604398==--

