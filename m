Content-Type: multipart/mixed; boundary="===============7094812041101786766=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20180927 released
Date: Thu, 27 Sep 2018 14:32:21 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B94FED2E@ORSMSX108.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7094812041101786766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

27 September 2018. Summary of changes for version 20180927:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Updated the GPE support to clear the status of all ACPI events when enterin=
g any/all sleep states in order to avoid premature wakeups. In theory, this=
 may cause some wakeup events to be missed, but the likelihood of this is s=
mall. This change restores the original behavior of the ACPICA code in orde=
r to fix a regression seen from the previous "Stop unconditionally clearing=
 ACPI IRQs during suspend/resume" change. This regression could cause some =
systems to incorrectly wake immediately.

Updated the execution of the _REG methods during initialization and namespa=
ce loading to bring the behavior into closer conformance to the ACPI specif=
ication and other ACPI implementations:

From the ACPI specification 6.2A, section 6.5.4 "_REG (Region):
    "Control methods must assume all operation regions are inaccessible unt=
il the _REG(RegionSpace, 1) method is executed"

    "The exceptions to this rule are:
1.  OSPM must guarantee that the following operation regions are always acc=
essible:
    SystemIO operation regions.
    SystemMemory operation regions when accessing memory returned by the Sy=
stem Address Map reporting interfaces."

Since the state of both the SystemIO and SystemMemory address spaces are de=
fined by the specification to never change, this ACPICA change ensures that=
 now _REG is never called on them. This solves some problems seen in the fi=
eld and provides compatibility with other ACPI implementations. An update t=
o the upcoming new version of the ACPI specification will help clarify this=
 behavior.

Updated the implementation of support for the Generic Serial Bus. For the "=
bidirectional" protocols, the internal implementation now automatically cre=
ates a return data buffer of the maximum size (255). This handles the worst=
-case for data that is returned from the serial bus handler, and fixes some=
 problems seen in the field. This new buffer is directly returned to the AS=
L. As such, there is no true "bidirectional" buffer, which matches the ACPI=
 specification. This is the reason for the "double store" seen in the examp=
le ASL code in the specification, shown below:

Word Process Call (AttribProcessCall):
    OperationRegion(TOP1, GenericSerialBus, 0x00, 0x100)
    Field(TOP1, BufferAcc, NoLock, Preserve)
    {
        FLD1, 8, // Virtual register at command value 1.
    }

    Name(BUFF, Buffer(20){})          // Create GenericSerialBus data buffe=
r as BUFF
    CreateWordField(BUFF, 0x02, DATA) // DATA =3D Data (Word)

    Store(0x5416, DATA)               // Save 0x5416 into the data buffer
    Store(Store(BUFF, FLD1), BUFF)    // Invoke a write/read Process Call t=
ransaction
                                      // This is the "double store". The wr=
ite to
                                      // FLD1 returns a new buffer, which i=
s stored
                                      // back into BUFF with the second Sto=
re.


2) iASL Compiler/Disassembler and Tools:

iASL: Implemented detection of extraneous/redundant uses of the Offset() op=
erator within a Field Unit list. A remark is now issued for these. For exam=
ple, the first two of the Offset() operators below are extraneous. Because =
both the compiler and the interpreter track the offsets automatically, thes=
e Offsets simply refer to the current offset and are unnecessary. Note, whe=
n optimization is enabled, the iASL compiler will in fact remove the redund=
ant Offset operators and will not emit any AML code for them.

    OperationRegion (OPR1, SystemMemory, 0x100, 0x100)
    Field (OPR1)
    {
        Offset (0),     // Never needed
        FLD1, 32,
        Offset (4),     // Redundant, offset is already 4 (bytes)
        FLD2, 8,
        Offset (64),    // OK use of Offset.
        FLD3, 16,
    }
dsdt.asl     14:         Offset (0),
Remark   2158 -                 ^ Unnecessary/redundant use of Offset opera=
tor

dsdt.asl     16:         Offset (4),
Remark   2158 -                 ^ Unnecessary/redundant use of Offset opera=
tor




--===============7094812041101786766==--

