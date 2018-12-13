Content-Type: multipart/mixed; boundary="===============5162225132145043347=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 2018123 released
Date: Thu, 13 Dec 2018 16:50:23 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B9533CF3@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5162225132145043347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

13 December 2018. Summary of changes for version 20181213:

This release is available at https://acpica.org/downloads


1) ACPICA Kernel-resident Subsystem:

Fixed some buffer length issues with the GenericSerialBus, related to two o=
f the bidirectional protocols: AttribRawProcessBytes and AttribRawBytes, wh=
ich are rarely seen in the field. For these, the LEN field of the ASL buffe=
r is now ignored. Hans de Goede

Implemented a new object evaluation trace mechanism for control methods and=
 data objects. This includes nested control methods. It is particularly use=
ful for examining the ACPI execution during system initialization since the=
 output is relatively terse. The flag below enables the output of the trace=
 via the ACPI_DEBUG_PRINT_RAW interface:
   #define ACPI_LV_EVALUATION          0x00080000

Examples:
   Enter evaluation       :  _SB.PCI0._INI (Method)
   Exit evaluation        :  _SB.PCI0._INI
   Enter evaluation       :  _OSI (Method)
   Exit evaluation        :  _OSI
   Enter evaluation       :  _SB.PCI0.TEST (Method)
   Nested method call     :     _SB.PCI0.NST1
   Exit nested method     :     _SB.PCI0.NST1
   Exit evaluation        :  _SB.PCI0.TEST

Added two recently-defined _OSI strings. See https://docs.microsoft.com/en-=
us/windows-hardware/drivers/acpi/winacpi-osi.
   "Windows 2018"
   "Windows 2018.2"

Update for buffer-to-string conversions via the ToHexString ASL operator. A=
 "0x" is now prepended to each of the hex values in the output string. This=
 provides compatibility with other ACPI implementations. The ACPI specifica=
tion is somewhat vague on this issue.
   Example output string after conversion: "0x01,0x02,0x03,0x04,0x05,0x06"

Return a run-time error for TermArg expressions within individual package e=
lements. Although this is technically supported by the ASL grammar, other A=
CPI implementations do not support this either. Also, this fixes a fault if=
 this type of construct is ever encountered (it never has been).


2) iASL Compiler/Disassembler and Tools:

iASL: Implemented a new compile option (-ww) that will promote individual w=
arnings and remarks to errors. This is intended to enhance the firmware bui=
ld process.

AcpiExec: Implemented a new command-line option (-eo) to support the new ob=
ject evaluation trace mechanism described above.

Disassembler: Added support to disassemble OEMx tables as AML/ASL tables in=
stead of a "unknown table" message.

AcpiHelp: Improved support for the "special" predefined names such as _Lxx,=
 _Exx, _EJx, _T_x, etc. For these, any legal hex value can now be used for =
"xx" and "x".



--===============5162225132145043347==--

