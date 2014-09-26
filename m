Content-Type: multipart/mixed; boundary="===============4803251286414954729=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20140926 released
Date: Fri, 26 Sep 2014 19:53:39 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D209773@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4803251286414954729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

26 September 2014. Summary of changes for version 20140926:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Updated the GPIO operation region handler interface (GeneralPurposeIo). In =
order to support GPIO Connection objects with multiple pins, along with the=
 related Field objects, the following changes to the interface have been ma=
de: The Address is now defined to be the offset in bits of the field unit f=
rom the previous invocation of a Connection. It can be viewed as a "Pin Num=
ber Index" into the connection resource descriptor. The BitWidth is the exa=
ct bit width of the field. It is usually one bit, but not always. See the A=
CPICA reference guide (section 8.8.6.2.1) for additional information and ex=
amples.

GPE support: During ACPICA/GPE initialization, ensure that all GPEs with co=
rresponding _Lxx/_Exx methods are disabled (they may have been enabled by t=
he firmware), so that they cannot fire until they are enabled via AcpiUpdat=
eAllGpes. Rafael J. Wysocki.

Added a new return flag for the Event/GPE status interfaces -- AcpiGetEvent=
Status and AcpiGetGpeStatus. The new ACPI_EVENT_FLAGS_HAS_HANDLER flag is u=
sed to indicate that the event or GPE currently has a handler associated wi=
th it, and can thus actually affect the system. Lv Zheng.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version:  99.1K Code, 27.3K Data, 126.4K Total
    Debug Version:     192.8K Code, 79.9K Data, 272.7K Total
  Previous Release:
    Non-Debug Version:  98.8K Code, 27.3K Data, 126.1K Total
    Debug Version:     192.1K Code, 79.8K Data, 271.9K Total

2) iASL Compiler/Disassembler and Tools:

iASL: Fixed a memory allocation/free regression introduced in 20140828 that=
 could cause the compiler to crash. This was introduced inadvertently durin=
g the effort to eliminate compiler memory leaks. ACPICA BZ 1111, 1113.

iASL: Removed two error messages that have been found to create false posit=
ives, until they can be fixed and fully validated (ACPICA BZ 1112):
1) Illegal forward reference within a method
2) Illegal reference across two methods

iASL: Implemented a new option (-lm) to create a hardware mapping file that=
 summarizes all GPIO, I2C, SPI, and UART connections. This option works for=
 both the compiler and disassembler. See the iASL compiler user guide for a=
dditional information and examples (section 6.4.6).

AcpiDump: Added support for the version 1 (ACPI 1.0) RSDP in addition to ve=
rsion 2. This corrects the AE_BAD_HEADER exception seen on systems with a v=
ersion 1 RSDP. Lv Zheng ACPICA BZ 1097.

AcpiExec: For Unix versions, don't attempt to put STDIN into raw mode unles=
s STDIN is actually a terminal. Assists with batch-mode processing. ACPICA =
BZ 1114.

Disassembler/AcpiHelp: Added another large group of recognized _HID values.


--===============4803251286414954729==--

