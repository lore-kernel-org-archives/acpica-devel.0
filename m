Content-Type: multipart/mixed; boundary="===============2611548657876015890=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20160527
Date: Fri, 27 May 2016 20:24:31 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E487CFC@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2611548657876015890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

27 May 2016. Summary of changes for version 20160527:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Temporarily reverted the new arbitrary bit length/alignment support in Acpi=
HwRead/AcpiHwWrite for the Generic Address Structure. There have been a num=
ber of regressions with the new code that need to be fully resolved and tes=
ted before this support can be finally integrated into ACPICA. Apologies fo=
r any inconveniences these issues may have caused.

The ACPI message macros are not configurable (ACPI_MSG_ERROR, ACPI_MSG_EXCE=
PTION, ACPI_MSG_WARNING, ACPI_MSG_INFO, ACPI_MSG_BIOS_ERROR, and ACPI_MSG_B=
IOS_WARNING). Lv Zheng.

Fixed a couple of GCC warnings associated with the use of the -Wcast-qual o=
ption. Adds a new return macro, return_STR. Junk-uk Kim.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version: 136.8K Code, 51.6K Data, 188.4K Total
    Debug Version:     201.5K Code, 82.2K Data, 283.7K Total
  Previous Release:
    Non-Debug Version: 137.4K Code, 52.6K Data, 190.0K Total
    Debug Version:     200.9K Code, 82.2K Data, 283.1K Total


--===============2611548657876015890==--

