Content-Type: multipart/mixed; boundary="===============7928448099424600945=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20100331 released
Date: Wed, 31 Mar 2010 12:41:24 -0700
Message-ID: <4911F71203A09E4D9981D27F9D83085861769D3F@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7928448099424600945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

31 March 2010. Summary of changes for version 20100331:

This release is available at www.acpica.org/downloads

1) ACPI CA Core Subsystem:

Completed a major update for the GPE support in order to improve support fo=
r shared GPEs and to simplify both host OS and ACPICA code. Added a referen=
ce count mechanism to support shared GPEs that require multiple device driv=
ers. Several external interfaces have changed. One external interface has b=
een removed. One new external interface was added. Most of the GPE external=
 interfaces now use the GPE spinlock instead of the events mutex (and the F=
lags parameter for many GPE interfaces has been removed.) See the updated A=
CPICA Programmer Reference for details. Matthew Garrett, Bob Moore, Rafael =
Wysocki. ACPICA BZ 831.

Changed:
    AcpiEnableGpe, AcpiDisableGpe, AcpiClearGpe, AcpiGetGpeStatus
Removed:
    AcpiSetGpeType
New:
    AcpiSetGpe

Implemented write support for DataTable operation regions. These regions ar=
e defined via the DataTableRegion() operator. Previously, only read support=
 was implemented. The ACPI specification allows DataTableRegions to be read=
/write, however.

Implemented a new subsystem option to force a copy of the DSDT to local mem=
ory. Optionally copy the entire DSDT to local memory (instead of simply map=
ping it.) There are some (albeit very rare) BIOSs that corrupt or replace t=
he original DSDT, creating the need for this option. Default is FALSE, do n=
ot copy the DSDT.

Implemented detection of a corrupted or replaced DSDT. This change adds sup=
port to detect a DSDT that has been corrupted and/or replaced from outside =
the OS (by firmware). This is typically catastrophic for the system, but ha=
s been seen on some machines. Once this problem has been detected, the DSDT=
 copy option can be enabled via system configuration. Lin Ming, Bob Moore.

Fixed two problems with AcpiReallocateRootTable during the root table copy.=
 When copying the root table to the new allocation, the length used was inc=
orrect. The new size was used instead of the current table size, meaning to=
o much data was copied. Also, the count of available slots for ACPI tables =
was not set correctly. Alexey Starikovskiy, Bob Moore.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 6.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  87.5K Code, 18.4K Data, 105.9K Total
    Debug Version:     163.4K Code, 51.1K Data, 214.5K Total
  Current Release:
    Non-Debug Version:  87.9K Code, 18.6K Data, 106.5K Total
    Debug Version:     163.5K Code, 51.3K Data, 214.8K Total

2) iASL Compiler/Disassembler and Tools:

iASL: Implement limited typechecking for values returned from predefined co=
ntrol methods. The type of any returned static (unnamed) object is now vali=
dated. For example, Return(1). ACPICA BZ 786.

iASL: Fixed a predefined name object verification regression. Fixes a probl=
em introduced in version 20100304. An error is incorrectly generated if a p=
redefined name is declared as a static named object with a value defined us=
ing the keywords "Zero", "One", or "Ones". Lin Ming.

iASL: Added Windows 7 support for the -g option (get local ACPI tables) by =
reducing the requested registry access rights. ACPICA BZ 842.

Disassembler: fixed a possible fault when generating External() statements.=
 Introduced in commit ae7d6fd: Properly handle externals with parent-prefix=
 (carat). Fixes a string length allocation calculation. Lin Ming.



--===============7928448099424600945==--

