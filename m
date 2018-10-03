Content-Type: multipart/mixed; boundary="===============6851339471163461756=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20181003 released
Date: Wed, 03 Oct 2018 14:31:18 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B9507B9C@ORSMSX108.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6851339471163461756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

03 October 2018. Summary of changes for version 20181003:

This release is available at https://acpica.org/downloads


2) iASL Compiler/Disassembler and Tools:

Fixed a regression introduced in version 20180927 that could cause the comp=
iler to fault, especially with NamePaths containing one or more carats (^).=
 Such as: ^^_SB_PCI0

Added a new remark for the Sleep() operator when the sleep time operand is =
larger than one second. This is a very long time for the ASL/BIOS code and =
may not be what was intended by the ASL writer.



--===============6851339471163461756==--

