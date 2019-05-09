Content-Type: multipart/mixed; boundary="===============5454242201873834287=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20190509 released
Date: Thu, 09 May 2019 22:25:49 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B958D1E9@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5454242201873834287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

09 May 2019. Summary of changes for version 20190509:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Revert commit  6c43e1a ("ACPICA: Clear status of GPEs before enabling them"=
) that causes problems with Thunderbolt controllers to occur if a dock devi=
ce is connected at init time (the xhci_hcd and thunderbolt modules crash wh=
ich prevents peripherals connected through them from working). Commit 6c43e=
1a effectively causes commit ecc1165b8b74 ("ACPICA: Dispatch active GPEs at=
 init time") to get undone, so the problem addressed by commit ecc1165b8b74=
 appears again as a result of it.


2) iASL Compiler/Disassembler and ACPICA tools:

Reverted iASL: Additional forward reference detection. This change reverts =
forward reference detection for field declarations. The feature unintention=
ally emitted AML bytecode with incorrect package lengths for some ASL code =
related to Fields and OperationRegions. This malformed AML can cause system=
s to crash
during boot. The malformed AML bytecode is emitted in iASL version 20190329=
 and 20190405.

iASL: improve forward reference detection. This change improves forward ref=
erence detection for named objects inside of scopes. If a parse object has =
the OP_NOT_FOUND_DURING_LOAD set, it means that Op is a reference to a name=
d object that is declared later in the AML bytecode. This is allowed if the=
 reference is inside of a method and the declaration is outside of a method=
 like so:

DefinitionBlock(...)
{
    Method (TEST)
    {
        Return (NUM0)
    }
    Name (NUM0,0)
}

However, if the declaration and reference are both in the same method or ou=
tside any methods, this is a forward reference and should be marked as an e=
rror because it would result in runtime errors.

DefinitionBlock(...)
{
    Name (BUFF, Buffer (NUM0) {}) // Forward reference
    Name (NUM0, 0x0)

    Method (TEST)
    {
        Local0 =3D NUM1
        Name (NUM1, 0x1) // Forward reference
        return (Local0)
    }
}

iASL: Implemented additional buffer overflow analysis for BufferField decla=
rations. Check if a buffer index argument to a create buffer field operatio=
n is beyond the end of the target buffer.

This affects these AML operators:
 =

   AML_CREATE_FIELD_OP
   AML_CREATE_BIT_FIELD_OP
   AML_CREATE_BYTE_FIELD_OP
   AML_CREATE_WORD_FIELD_OP
   AML_CREATE_DWORD_FIELD_OP
   AML_CREATE_QWORD_FIELD_OP

 There are three conditions that must be satisfied in order to allow this v=
alidation at compile time:
 =

   1) The length of the target buffer must be an integer constant
   2) The index specified in the create* must be an integer constant
   3) For CreateField, the bit length argument must be non-zero.

Example:
    Name (BUF1, Buffer() {1,2})
    CreateField (BUF1, 7, 9, CF03)  // 3: ERR

dsdt.asl     14:     CreateField (BUF1, 7, 9, CF03)  // 3: ERR
Error    6165 -                           ^ Buffer index beyond end of targ=
et buffer



--===============5454242201873834287==--

