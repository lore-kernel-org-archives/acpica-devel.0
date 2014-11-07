Content-Type: multipart/mixed; boundary="===============6000120940842210357=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20141107 released
Date: Fri, 07 Nov 2014 20:07:19 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D21FB84@ORSMSX112.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6000120940842210357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

07 November 2014. Summary of changes for version 20141107:

This release is available at https://acpica.org/downloads

This release introduces and implements language extensions to ASL that prov=
ide support for symbolic ("C-style") operators and expressions. These langu=
age extensions are known collectively as ASL+.


1) iASL Compiler/Disassembler and Tools:

Disassembler: Fixed a problem with disassembly of the UartSerialBus macro. =
Changed "StopBitsNone" to the correct "StopBitsZero". David E. Box.

Disassembler: Fixed the Unicode macro support to add escape sequences. All =
non-printable ASCII values are emitted as escape sequences, as well as the =
standard escapes for quote and backslash. Ensures that the disassembled mac=
ro can be correctly recompiled.

iASL: Added Printf/Fprintf macros for formatted output. These macros are tr=
anslated to existing AML Concatenate and Store operations. Printf writes to=
 the ASL Debug object. Fprintf allows the specification of an ASL name as t=
he target. Only a single format specifier is required, %o, since the AML in=
terpreter dynamically converts objects to the required type. David E. Box.

    (old)    Store (Concatenate (Concatenate (Concatenate (Concatenate
                 (Concatenate (Concatenate (Concatenate ("", Arg0),
                 ": Unexpected value for "), Arg1), ", "), Arg2),
                 " at line "), Arg3), Debug)

    (new)    Printf ("%o: Unexpected value for %o, %o at line %o",
                 Arg0, Arg1, Arg2, Arg3)

    (old)    Store (Concatenate (Concatenate (Concatenate (Concatenate
                 ("", Arg1), ": "), Arg0), " Successful"), STR1)

    (new)    Fprintf (STR1, "%o: %o Successful", Arg1, Arg0)

iASL: Added debug options (-bp, -bt) to dynamically prune levels of the ASL=
 parse tree before the AML code is generated. This allows blocks of ASL cod=
e to be removed in order to help locate and identify problem devices and/or=
 code. David E. Box.

AcpiExec: Added support (-fi) for an optional namespace object initializati=
on file. This file specifies initial values for namespace objects as necess=
ary for debugging and testing different ASL code paths that may be taken as=
 a result of BIOS options.


2) Overview of symbolic operator support for ASL (ASL+)
-------------------------------------------------------

As an extension to the ASL language, iASL implements support for symbolic (=
C-style) operators for math and logical expressions. This can greatly simpl=
ify ASL code as well as improve both readability and maintainability. These=
 language extensions can exist concurrently with all legacy ASL code and ex=
pressions.

The symbolic extensions are 100% compatible with existing AML interpreters,=
 since no new AML opcodes are created. To implement the extensions, the iAS=
L compiler transforms the symbolic expressions into the legacy ASL/AML equi=
valents at compile time.

Full symbolic expressions are supported, along with the standard C preceden=
ce and associativity rules.

Full disassembler support for the symbolic expressions is provided, and cre=
ates an automatic migration path for existing ASL code to ASL+ code via the=
 disassembly process. By default, the disassembler now emits ASL+ code with=
 symbolic expressions. An option (-dl) is provided to force the disassemble=
r to emit legacy ASL code if desired.

Below is the complete list of the currently supported symbolic operators wi=
th examples. See the iASL User Guide for additional information.


ASL+ Syntax      Legacy ASL Equivalent
-----------      ---------------------

    // Math operators

Z =3D X + Y        Add (X, Y, Z)
Z =3D X - Y        Subtract (X, Y, Z)
Z =3D X * Y        Multiply (X, Y, Z)
Z =3D X / Y        Divide (X, Y, , Z)
Z =3D X % Y        Mod (X, Y, Z)
Z =3D X << Y       ShiftLeft (X, Y, Z)
Z =3D X >> Y       ShiftRight (X, Y, Z)
Z =3D X & Y        And (X, Y, Z)
Z =3D X | Y        Or (X, Y, Z)
Z =3D X ^ Y        Xor (X, Y, Z)
Z =3D ~X           Not (X, Z)
X++              Increment (X)
X--              Decrement (X)

    // Logical operators

(X =3D=3D Y)         LEqual (X, Y)
(X !=3D Y)         LNotEqual (X, Y)
(X < Y)          LLess (X, Y)
(X > Y)          LGreater (X, Y)
(X <=3D Y)         LLessEqual (X, Y)
(X >=3D Y)         LGreaterEqual (X, Y)
(X && Y)         LAnd (X, Y)
(X || Y)         LOr (X, Y)
(!X)             LNot (X)

    // Assignment and compound assignment operations

X =3D Y           Store (Y, X)
X +=3D Y          Add (X, Y, X)
X -=3D Y          Subtract (X, Y, X)
X *=3D Y          Multiply (X, Y, X)
X /=3D Y          Divide (X, Y, , X)
X %=3D Y          Mod (X, Y, X)
X <<=3D Y         ShiftLeft (X, Y, X)
X >>=3D Y         ShiftRight (X, Y, X)
X &=3D Y          And (X, Y, X)
X |=3D Y          Or (X, Y, X)
X ^=3D Y          Xor (X, Y, X)


3) ASL+ Examples:
-----------------

Legacy ASL:
        If (LOr (LOr (LEqual (And (R510, 0x03FB), 0x02E0), LEqual (
            And (R520, 0x03FB), 0x02E0)), LOr (LEqual (And (R530, 0x03FB), =

            0x02E0), LEqual (And (R540, 0x03FB), 0x02E0))))
        {
            And (MEMB, 0xFFFFFFF0, SRMB)
            Store (MEMB, Local2)
            Store (PDBM, Local1)
            And (PDBM, 0xFFFFFFFFFFFFFFF9, PDBM)
            Store (SRMB, MEMB)
            Or (PDBM, 0x02, PDBM)
        }

ASL+ version:
        If (((R510 & 0x03FB) =3D=3D 0x02E0) ||
            ((R520 & 0x03FB) =3D=3D 0x02E0) ||
            ((R530 & 0x03FB) =3D=3D 0x02E0) || =

            ((R540 & 0x03FB) =3D=3D 0x02E0))
        {
            SRMB =3D (MEMB & 0xFFFFFFF0)
            Local2 =3D MEMB
            Local1 =3D PDBM
            PDBM &=3D 0xFFFFFFFFFFFFFFF9
            MEMB =3D SRMB
            PDBM |=3D 0x02
        }

Legacy ASL:
        Store (0x1234, Local1)
        Multiply (Add (Add (Local1, TEST), 0x20), Local2, Local3)
        Multiply (Local2, Add (Add (Local1, TEST), 0x20), Local3)
        Add (Local1, Add (TEST, Multiply (0x20, Local2)), Local3)
        Store (Index (PKG1, 0x03), Local6)
        Store (Add (Local3, Local2), Debug)
        Add (Local1, 0x0F, Local2)
        Add (Local1, Multiply (Local2, Local3), Local2)
        Multiply (Add (Add (Local1, TEST), 0x20), ToBCD (Local1), Local3)

ASL+ version:
        Local1 =3D 0x1234
        Local3 =3D (((Local1 + TEST) + 0x20) * Local2)
        Local3 =3D (Local2 * ((Local1 + TEST) + 0x20))
        Local3 =3D (Local1 + (TEST + (0x20 * Local2)))
        Local6 =3D Index (PKG1, 0x03)
        Debug =3D (Local3 + Local2)
        Local2 =3D (Local1 + 0x0F)
        Local2 =3D (Local1 + (Local2 * Local3))
        Local3 =3D (((Local1 + TEST) + 0x20) * ToBCD (Local1))



--===============6000120940842210357==--

