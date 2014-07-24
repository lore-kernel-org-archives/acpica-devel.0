Content-Type: multipart/mixed; boundary="===============5150828300288857740=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20140724 released
Date: Thu, 24 Jul 2014 17:53:18 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D1CD75F@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5150828300288857740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

24 July 2014. Summary of changes for version 20140724:

This release is available at https://acpica.org/downloads

The ACPI 5.1 specification has been released and is available at: http://ue=
fi.org/specs/access


0) ACPI 5.1 support in ACPICA:

ACPI 5.1 is fully supported in ACPICA as of this release.

New predefined names. Support includes iASL and runtime ACPICA validation.
    _CCA (Cache Coherency Attribute).
    _DSD (Device-Specific Data). David Box.

Modifications to existing ACPI tables. Support includes headers, iASL Data =
Table compiler, disassembler, and the template generator.
    FADT - New fields and flags. Graeme Gregory.
    GTDT - One new subtable and new fields. Tomasz Nowicki.
    MADT - Two new subtables. Tomasz Nowicki.
    PCCT - One new subtable.

Miscellaneous.
    New notification type for System Resource Affinity change events.


1) ACPICA kernel-resident subsystem:

Fixed a regression introduced in 20140627 where a fault can happen during t=
he deletion of Alias AML namespace objects. The problem affected both the c=
ore ACPICA and the ACPICA tools including iASL and AcpiExec.

Implemented a new GPE public interface, AcpiMarkGpeForWake. Provides a simp=
le mechanism to enable wake GPEs that have no associated handler or control=
 method. Rafael Wysocki.

Updated the AcpiEnableGpe interface to disallow the enable if there is no h=
andler or control method associated with the particular GPE. This will help=
 avoid meaningless GPEs and even GPE floods. Rafael Wysocki.

Updated GPE handling and dispatch by disabling the GPE before clearing the =
status bit for edge-triggered GPEs. Lv Zheng.

Added Timer() support to the AML Debug object. The current timer value is n=
ow displayed with each invocation of (Store to) the debug object to enable =
simple generation of execution times for AML code (method execution for exa=
mple.) ACPICA BZ 1093.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version:  98.7K Code, 27.3K Data, 126.0K Total
    Debug Version:     192.0K Code, 79.7K Data, 271.7K Total
  Previous Release:
    Non-Debug Version:  98.7K Code, 27.2K Data, 125.9K Total
    Debug Version:     191.7K Code, 79.6K Data, 271.3K Total


2) iASL Compiler/Disassembler and Tools:

Fixed an issue with the recently added local printf implementation, concern=
ing width/precision specifiers that could cause incorrect output. Lv Zheng.=
 ACPICA BZ 1094.

Disassembler: Added support to detect buffers that contain UUIDs and disass=
emble them to an invocation of the ToUUID operator. Also emit commented des=
criptions of known ACPI-related UUIDs.

AcpiHelp: Added support to display known ACPI-related UUIDs. New option, -u=
. Adds three new files.

iASL: Update table compiler and disassembler for DMAR table changes that we=
re introduced in September 2013. With assistance by David Woodhouse.


--===============5150828300288857740==--

