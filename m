Content-Type: multipart/mixed; boundary="===============0541369219545283092=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [RFC] proposed patch for some segfaults encountered
Date: Tue, 02 Jun 2015 20:05:43 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F14A7@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37D2F1418@ORSMSX112.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0541369219545283092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It looks to me that the disassembler has to start guessing at the number of=
 arguments for the various external control methods, and it begins to get s=
eriously confused.

Just FYI, here is a full description of the problem:

4.4.1	Disassembly of Control Method Invocations

Summary of the external control method problem: =

When the -e option is used with disassembly, the various SSDTs are simply l=
oaded into a global namespace for the disassembler to use in order to resol=
ve control method references (invocations). =

The disassembler tracks any such references, and will emit an External() st=
atement for these types of methods, with the proper number of arguments . =

Without the SSDTs, the AML does not contain enough information to properly =
disassemble the control method invocation -- because the disassembler does =
not know how many arguments to parse. =

An example: Assume we have two control methods. ABCD has one argument, and =
EFGH has zero arguments. Further, we have two additional control methods th=
at invoke ABCD and EFGH, named T1 and T2: =


    Method (ABCD, 1)
    {
    }
    Method (EFGH, 0)
    {
    }
    Method (T1)
    {
        ABCD (Add (2, 7, Local0))
    }
    Method (T2)
    {
        EFGH ()
        Add (2, 7, Local0)
    }

Here is the AML code that is generated for T1 and T2:

     185:      Method (T1)

0000034C:  14 10 54 31 5F 5F 00 ...    "..T1__."

     186:      {
     187:          ABCD (Add (2, 7, Local0))

00000353:  41 42 43 44 ............    "ABCD"
00000357:  72 0A 02 0A 07 60 ......    "r....`"

     188:      }

     190:      Method (T2)

0000035D:  14 10 54 32 5F 5F 00 ...    "..T2__."

     191:      {
     192:          EFGH ()

00000364:  45 46 47 48 ............    "EFGH"

     193:          Add (2, 7, Local0)

00000368:  72 0A 02 0A 07 60 ......    "r....`"
     194:      }

Note that the AML code for T1 and T2 is essentially identical. When disasse=
mbling this code, the methods ABCD and EFGH must be known to the disassembl=
er, otherwise it does not know how to handle the method invocations. =

In other words, if ABCD and EFGH are actually external control methods appe=
aring in an SSDT, the disassembler does not know what to do unless the owni=
ng SSDT has been loaded via the -e option. =


4.4.1.1	ACPI 6.0 Solution - External() AML Opcode
In ACPI 6.0, a new AML opcode was defined to help with this problem. The op=
code is not intended for execution by AML interpreters; its only purpose is=
 to assist the disassembler with the control method argument count problem.




> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Moore, Robert
> Sent: Tuesday, June 02, 2015 12:06 PM
> To: Al Stone; devel(a)acpica.org
> Subject: Re: [Devel] [RFC] proposed patch for some segfaults encountered
> =

> I'll need to disassemble with the DSDT and all SSDTs.
> =

> Do you have an acpidump for the machine? Otherwise, the binary files will
> be ok.
> =

> There are a lot of externals to other tables, and this may be a part of
> the problem.
> =

>=20

--===============0541369219545283092==--

