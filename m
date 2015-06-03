Content-Type: multipart/mixed; boundary="===============6970442056448931654=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [RFC] proposed patch for some segfaults encountered
Date: Wed, 03 Jun 2015 20:36:29 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F1A72@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 556F5B5E.3040600@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6970442056448931654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As far as the segfault, this issue becomes very problematic as the disassem=
bler parse tree can become ill-formed and the results are somewhat unpredic=
table. However, we will continue to do what we can short of checking every =
single node in the parse tree for validity, which of course is a lot of wor=
k, CPU time, or both.  Obviously, we want to of course make the disassemble=
r as bulletproof as we can.



> -----Original Message-----
> From: Al Stone [mailto:ahs3(a)redhat.com]
> Sent: Wednesday, June 03, 2015 12:54 PM
> To: Moore, Robert; Zheng, Lv; devel(a)acpica.org
> Subject: Re: [Devel] [RFC] proposed patch for some segfaults encountered
> =

> Yup.  All true and duly noted.  Unfortunately, I could only pass on what
> I've been given from the bug report.  And, the warning was not showing up
> because of the segfault.  Now that it does, it should help some.
> =

> The Fedora BZ, if you're interested, is here:
> =

>    https://bugzilla.redhat.com/show_bug.cgi?id=3D1219341
> =

> =

> On 06/03/2015 08:57 AM, Moore, Robert wrote:
> > And of course, the warning message should be taken to heart:
> >
> >     /*
> >      * iASL Warning: There were 4 external control methods found during
> >      * disassembly, but additional ACPI tables to resolve these
> externals
> >      * were not specified. This resulting disassembler output file may
> not
> >      * compile because the disassembler did not know how many arguments
> >      * to assign to these methods. To specify the tables needed to
> resolve
> >      * external control method references, the -e option can be used to
> >      * specify the filenames. Note: SSDTs can be dynamically loaded at
> >      * runtime and may or may not be available via the host OS.
> >      * Example iASL invocations:
> >      *     iasl -e ssdt1.aml ssdt2.aml ssdt3.aml -d dsdt.aml
> >      *     iasl -e dsdt.aml ssdt2.aml -d ssdt1.aml
> >      *     iasl -e ssdt*.aml -d dsdt.aml
> >      *
> >      * In addition, the -fe option can be used to specify a file
> containing
> >      * control method external declarations with the associated method
> >      * argument counts. Each line of the file must be of the form:
> >      *     External (<method pathname>, MethodObj, <argument count>)
> >      * Invocation:
> >      *     iasl -fe refs.txt -d dsdt.aml
> >      *
> >      * The following methods were unresolved and many not compile
> properly
> >      * because the disassembler had to guess at the number of arguments
> >      * required for each:
> >      */
> >
> >
> >> -----Original Message-----
> >> From: Zheng, Lv
> >> Sent: Tuesday, June 02, 2015 5:38 PM
> >> To: Moore, Robert; Al Stone; devel(a)acpica.org
> >> Subject: RE: [Devel] [RFC] proposed patch for some segfaults
> >> encountered
> >>
> >> Hi,
> >>
> >>> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Moore,
> >>> Robert
> >>> Sent: Wednesday, June 03, 2015 4:06 AM
> >>>
> >>> It looks to me that the disassembler has to start guessing at the
> >>> number of arguments for the various external control methods, and it
> >> begins to get seriously confused.
> >>>
> >>> Just FYI, here is a full description of the problem:
> >>>
> >>> 4.4.1	Disassembly of Control Method Invocations
> >>>
> >>> Summary of the external control method problem:
> >>> When the -e option is used with disassembly, the various SSDTs are
> >>> simply loaded into a global namespace for the disassembler to use in
> >> order to resolve control method references (invocations).
> >>> The disassembler tracks any such references, and will emit an
> >>> External() statement for these types of methods, with the proper
> >>> number
> >> of arguments .
> >>> Without the SSDTs, the AML does not contain enough information to
> >>> properly disassemble the control method invocation -- because the
> >> disassembler does not know how many arguments to parse.
> >>> An example: Assume we have two control methods. ABCD has one
> >>> argument, and EFGH has zero arguments. Further, we have two
> >>> additional control
> >> methods that invoke ABCD and EFGH, named T1 and T2:
> >>>
> >>>     Method (ABCD, 1)
> >>>     {
> >>>     }
> >>>     Method (EFGH, 0)
> >>>     {
> >>>     }
> >>>     Method (T1)
> >>>     {
> >>>         ABCD (Add (2, 7, Local0))
> >>>     }
> >>>     Method (T2)
> >>>     {
> >>>         EFGH ()
> >>>         Add (2, 7, Local0)
> >>>     }
> >>>
> >>> Here is the AML code that is generated for T1 and T2:
> >>>
> >>>      185:      Method (T1)
> >>>
> >>> 0000034C:  14 10 54 31 5F 5F 00 ...    "..T1__."
> >>>
> >>>      186:      {
> >>>      187:          ABCD (Add (2, 7, Local0))
> >>>
> >>> 00000353:  41 42 43 44 ............    "ABCD"
> >>> 00000357:  72 0A 02 0A 07 60 ......    "r....`"
> >>>
> >>>      188:      }
> >>>
> >>>      190:      Method (T2)
> >>>
> >>> 0000035D:  14 10 54 32 5F 5F 00 ...    "..T2__."
> >>>
> >>>      191:      {
> >>>      192:          EFGH ()
> >>>
> >>> 00000364:  45 46 47 48 ............    "EFGH"
> >>>
> >>>      193:          Add (2, 7, Local0)
> >>>
> >>> 00000368:  72 0A 02 0A 07 60 ......    "r....`"
> >>>      194:      }
> >>>
> >>> Note that the AML code for T1 and T2 is essentially identical. When
> >>> disassembling this code, the methods ABCD and EFGH must be known to
> >>> the
> >> disassembler, otherwise it does not know how to handle the method
> >> invocations.
> >>
> >> This is the problem in ACPI specification since DSDT 1.0:
> >> MethodInvocation :=3D NameString TermArgList TermObj :=3D
> >> NameSpaceModifierObj
> >> | NamedObj | Type1Opcode | Type2Opcode TermList :=3D Nothing | <TermObj
> >> TermList> There is no number of arguments defined in the grammer.
> >>
> >>> In other words, if ABCD and EFGH are actually external control
> >>> methods appearing in an SSDT, the disassembler does not know what to
> >>> do unless
> >> the owning SSDT has been loaded via the -e option.
> >>
> >> Normally  I will use the following command to decompile:
> >> # iasl -e dsdt.dat -e ssdt*.dat -d ssdt9.dat Which loads all tables
> >> in the same order as the OSPM (may still face issue if there is
> "Load/LoadTable"
> >> invoked during the table loading).
> >> If this still failed, this was either a BIOS bug or an DSDT 2.0
> >> compatible problem.
> >>
> >> Thanks and best regards
> >> -Lv
> >>
> >>>
> >>> 4.4.1.1	ACPI 6.0 Solution - External() AML Opcode
> >>> In ACPI 6.0, a new AML opcode was defined to help with this problem.
> >>> The opcode is not intended for execution by AML interpreters; its
> >>> only
> >> purpose is to assist the disassembler with the control method
> >> argument count problem.
> >>>
> >>>
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Moore,
> >>>> Robert
> >>>> Sent: Tuesday, June 02, 2015 12:06 PM
> >>>> To: Al Stone; devel(a)acpica.org
> >>>> Subject: Re: [Devel] [RFC] proposed patch for some segfaults
> >>>> encountered
> >>>>
> >>>> I'll need to disassemble with the DSDT and all SSDTs.
> >>>>
> >>>> Do you have an acpidump for the machine? Otherwise, the binary
> >>>> files will be ok.
> >>>>
> >>>> There are a lot of externals to other tables, and this may be a
> >>>> part of the problem.
> >>>>
> >>>>
> >>> _______________________________________________
> >>> Devel mailing list
> >>> Devel(a)acpica.org
> >>> https://lists.acpica.org/mailman/listinfo/devel
> =

> =

> --
> ciao,
> al
> -----------------------------------
> Al Stone
> Software Engineer
> Red Hat, Inc.
> ahs3(a)redhat.com
> -----------------------------------

--===============6970442056448931654==--

