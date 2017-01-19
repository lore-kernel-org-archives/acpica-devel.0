Content-Type: multipart/mixed; boundary="===============1989654601584839764=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20170119 released
Date: Thu, 19 Jan 2017 17:09:10 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E55F6B5@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1989654601584839764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

19 January 2017. Summary of changes for version 20170119:

This release is available at https://acpica.org/downloads

1) General ACPICA software:

Entire source code base: Added the 2017 copyright to all source code =

legal/licensing module headers and utility/tool signons. This includes =

the standard Linux dual-license header. This affects virtually every file =

in the ACPICA core subsystem, iASL compiler, all ACPICA utilities, and =

the ACPICA test suite.


2) iASL Compiler/Disassembler and Tools:

iASL: Removed/fixed an inadvertent remark when a method argument =

containing a reference is used as a target operand within the method (and =

never used as a simple argument), as in the example below. Jeffrey Hugo.

    dsdt.asl   1507:    Store(0x1, Arg0)
    Remark   2146 -                ^ Method Argument is never used (Arg0)

All tools: Removed the bit width of the compiler that generated the tool =

from the common signon for all user space tools. This proved to be =

confusing and unnecessary. This includes similar removal of HARDWARE_NAME =

from the generic makefiles (Thomas Petazzoni). Example below.

    Old:
    ASL+ Optimizing Compiler version 20170119-32
    ASL+ Optimizing Compiler version 20170119-64

    New:
    ASL+ Optimizing Compiler version 20170119


--===============1989654601584839764==--

