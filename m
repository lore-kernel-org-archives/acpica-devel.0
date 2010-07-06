Content-Type: multipart/mixed; boundary="===============5949465723855980342=="
MIME-Version: 1.0
From: malattia at linux.it
Subject: Re: [Devel] [patch 4/5] Fix aligment issues
Date: Tue, 06 Jul 2010 21:24:10 +0900
Message-ID: <20100706122410.GA5020@kamineko.org>
In-Reply-To: 1278379187.9540.39.camel@minggr.sh.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5949465723855980342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 06, 2010 at 09:19:47AM +0800, Lin Ming wrote:
> On Mon, 2010-07-05 at 20:03 +0800, malattia(a)linux.it wrote:
> > Add more platforms to the list of the ones requiring aligned memory acc=
ess. Also
> > fix callsites where wrong assumptions where made in terms of aligment.
...
> > Index: b/executer/exoparg2.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- a/executer/exoparg2.c	2010-07-02 21:42:26.477349196 +0900
> > +++ b/executer/exoparg2.c	2010-07-04 11:18:22.506529460 +0900
> > @@ -248,6 +248,8 @@
> >      ACPI_OPERAND_OBJECT     **Operand =3D &WalkState->Operands[0];
> >      ACPI_OPERAND_OBJECT     *ReturnDesc1 =3D NULL;
> >      ACPI_OPERAND_OBJECT     *ReturnDesc2 =3D NULL;
> > +    UINT64                  ReturnValue1 =3D 0;
> > +    UINT64                  ReturnValue2 =3D 0;
> >      ACPI_STATUS             Status;
> >  =

> > =

> > @@ -281,8 +283,10 @@
> >  =

> >          Status =3D AcpiUtDivide (Operand[0]->Integer.Value,
> >                                 Operand[1]->Integer.Value,
> > -                               &ReturnDesc1->Integer.Value,
> > -                               &ReturnDesc2->Integer.Value);
> > +                               &ReturnValue1, &ReturnValue2);
> =

> Why need to replace &ReturnDesc1->Integer.Value with &ReturnValue1?

I get this on sparc systems without these 2 hunks:

malattia(a)smetana:~/acpica-unix> ./compiler/iasl -tc -ps.hex tests/misc/gr=
ammar.asl

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20100528 [Jul  6 2010]
Copyright (c) 2000 - 2010 Intel Corporation
Supports ACPI Specification Revision 4.0a

[1]    28389 bus error  ./compiler/iasl -tc -ps.hex tests/misc/grammar.asl

it is caused by the pointer to the 64bit integer being aligned to 4
bytes instead of 8 bytes as required by the 64bit assigment inside
AcpiUtDivide when computing the result of the division:

        *OutQuotient =3D InDividend / InDivisor;

or at least that is my understanding of the problem.

Anyway, just using a temporary variable correctly aligned on the stack
and then assigning the result to Integer.Value afterwards works around
the problem.

Hope the explanation is understandable... otherwise I'll try harder :)
-- =

mattia
:wq!

--===============5949465723855980342==--

