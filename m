Content-Type: multipart/mixed; boundary="===============3031980184599937659=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20101013 released
Date: Wed, 13 Oct 2010 09:54:53 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858BBE58E68@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3031980184599937659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

13 October 2010. Summary of changes for version 20101013:

This release is available at www.acpica.org/downloads

1) ACPI CA Core Subsystem:

Added support to clear the PCIEXP_WAKE event. When clearing ACPI events, no=
w clear the PCIEXP_WAKE_STS bit in the ACPI PM1 Status Register, via HwClea=
rAcpiStatus. Original change from Colin King. ACPICA BZ 880.

Changed the type of the predefined namespace object _TZ from ThermalZone to=
 Device. This was found to be confusing to the host software that processes=
 the various thermal zones, since _TZ is not really a ThermalZone. However,=
 a Notify() can still be performed on it. ACPICA BZ 876. Suggestion from Ru=
i Zhang.

Added Windows Vista SP2 to the list of supported _OSI strings. The actual s=
tring is "Windows 2006 SP2".

Eliminated duplicate code in AcpiUtExecute* functions. Now that the nsrepai=
r code automatically repairs _HID-related strings, this type of code is no =
longer needed in Execute_HID, Execute_CID, and Execute_UID. ACPICA BZ 878.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 6.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  89.9K Code, 19.0K Data, 108.9K Total
    Debug Version:     166.3K Code, 52.1K Data, 218.4K Total
  Current Release:
    Non-Debug Version:  89.9K Code, 19.0K Data, 108.9K Total
    Debug Version:     166.3K Code, 52.1K Data, 218.4K Total

2) iASL Compiler/Disassembler and Tools:

iASL: Implemented additional compile-time validation for _HID strings. The =
non-hex prefix (such as "PNP" or "ACPI") must be uppercase, and the length =
of the string must be exactly seven or eight characters. For both _HID and =
_CID strings, all characters must be alphanumeric. ACPICA BZ 874.

iASL: Allow certain "null" resource descriptors. Some BIOS code creates des=
criptors that are mostly or all zeros, with the expectation that they will =
be filled in at runtime. iASL now allows this as long as there is a "resour=
ce tag" (name) associated with the descriptor, which gives the ASL a handle=
 needed to modify the descriptor. ACPICA BZ 873.

Added single-thread support to the generic Unix application OSL. Primarily =
for iASL support, this change removes the use of semaphores in the single-t=
hreaded ACPICA tools/applications - increasing performance. The _MULTI_THRE=
ADED option was replaced by the (reverse) ACPI_SINGLE_THREADED option. ACPI=
CA BZ 879.

AcpiExec: several fixes for the 64-bit version. Adds XSDT support and suppo=
rt for 64-bit DSDT/FACS addresses in the FADT. Lin Ming.

iASL: Moved all compiler messages to a new file, aslmessages.h.


--===============3031980184599937659==--

