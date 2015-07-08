Content-Type: multipart/mixed; boundary="===============7313649825134656517=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Comment //* generates error
Date: Wed, 08 Jul 2015 15:27:22 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D30A987@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 20E136AF98049A48A90A7417B4343D5EAB1E6A66C3@BUNGLE.Emea.Arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7313649825134656517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I could send you a test compiler if you would like (windows binary)


> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Alexei Fedor=
ov
> Sent: Friday, July 03, 2015 7:27 AM
> To: devel(a)acpica.org
> Subject: [Devel] Comment //* generates error
> =

> Hi all,
> =

> User Guide states that "comments can be either traditional /*..*/ style or
> // style" but having star * symbol just after // comment, like
> //*<any_text_here> will generate an error. This is broken in #20150619
> build but used to work in #20150515.
> =

> Alexei.
> =

> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of devel-
> request(a)acpica.org
> Sent: 02 July 2015 04:36
> To: devel(a)acpica.org
> Subject: Devel Digest, Vol 56, Issue 1
> =

> Send Devel mailing list submissions to
>         devel(a)acpica.org
> =

> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.acpica.org/mailman/listinfo/devel
> or, via email, send a message with subject or body 'help' to
>         devel-request(a)acpica.org
> =

> You can reach the person managing the list at
>         devel-owner(a)acpica.org
> =

> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Devel digest..."
> =

> =

> Today's Topics:
> =

>    1. ACPICA version 20150616 released (Moore, Robert)
>    2. ACPICA version 20150619 released (Moore, Robert)
>    3. Re: ACPICA version 20150619 released (Dean Nelson)
>    4. Re: ACPICA version 20150619 released (Moore, Robert)
>    5. Re: [PATCH] ACPICA: Delete an unnecessary check before the
>       function call "acpi_ds_delete_walk_state" (Moore, Robert)
>    6. [PATCH] AcpiXtract: fix warning on int printed with %u
>       specifier (Colin King)
>    7. Re: [PATCH] ACPI, Repair of outdated variable (Moore, Robert)
> =

> =

> ----------------------------------------------------------------------
> =

> Message: 1
> Date: Tue, 16 Jun 2015 19:11:22 +0000
> From: "Moore, Robert" <robert.moore(a)intel.com>
> To: "devel(a)acpica.org" <devel(a)acpica.org>
> Subject: [Devel] ACPICA version 20150616 released
> Message-ID:
> =

> <94F2FBAB4432B54E8AACC7DFDE6C92E37D300481(a)ORSMSX112.amr.corp.intel.com>
> =

> Content-Type: text/plain; charset=3D"us-ascii"
> =

> 16 June 2015. Summary of changes for version 20150616:
> =

> This release is available at https://acpica.org/downloads
> =

> 1) ACPICA kernel-resident subsystem:
> =

> Across the entire ACPICA source code base, the various macros for the C
> library functions (such as ACPI_STRLEN, etc.) have been removed and
> replaced by the standard C library names (strlen, etc.) The original
> purpose for these macros is no longer applicable. This simplification
> reduces the number of macros used in the ACPICA source code significantly,
> improving readability and maintainability.
> =

> Implemented support for a new ACPI table, the OSDT. This table, the
> "override" SDT, can be loaded directly by the host OS at boot time. It
> enables the replacement of existing namespace objects that were installed
> via the DSDT and/or SSDTs. The primary purpose for this is to replace
> buggy or incorrect ASL/AML code obtained via the BIOS. The OSDT is slated
> for inclusion in a future version of the ACPI Specification. Lv Zheng/Bob
> Moore.
> =

> Added support for systems with (improperly) two FACS tables -- a "32-bit"
> table (via FADT 32-bit legacy field) and a "64-bit" table (via the 64-bit
> X field). This change will support both automatically. There continues to
> be systems found with this issue. This support requires a change to the
> AcpiSetFirmwareWakingVector interface. Also, a public global variable has
> been added to allow the host to select which FACS is desired
> (AcpiGbl_Use32BitFacsAddresses). See the ACPICA reference for more details
> Lv Zheng.
> =

> Added a new feature to allow for systems that do not contain an FACS.
> Although this is already supported on hardware-reduced platforms, the
> feature has been extended for all platforms. The reasoning is that we do
> not want to abort the entire ACPICA initialization just because the system
> is seriously buggy and has no FACS.
> =

> Fixed a problem where the GUID strings for NFIT tables (in acuuid.h) were
> not correctly transcribed from the ACPI specification in ACPICA version
> 20150515.
> =

> Implemented support for the _CLS object in the AcpiGetObjectInfo external
> interface.
> =

> Updated the definitions of the TCPA and TPM2 ACPI tables to the more
> recent TCG ACPI Specification, December 14, 2014. Table disassembler and
> compiler also updated. Note: The TCPA "server" table is not supported by
> the disassembler/table-compiler at this time.
> =

> ACPI 6.0: Added definitions for the new GIC version field in the MADT.
> =

> Example Code and Data Size: These are the sizes for the OS-independent
> acpica.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The
> debug version of the code includes the debug output trace mechanism and
> has a much larger code and data size.
> =

>   Current Release:
>     Non-Debug Version: 100.6K Code, 27.6K Data, 128.2K Total
>     Debug Version:     196.2K Code, 81.0K Data, 277.2K Total
>   Previous Release:
>     Non-Debug Version:  99.9K Code, 27.5K Data, 127.4K Total
>     Debug Version:     195.2K Code, 80.8K Data, 276.0K Total
> =

> =

> 2) iASL Compiler/Disassembler and Tools:
> =

> Disassembler: Fixed a problem with the new symbolic operator disassembler
> where incorrect ASL code could be emitted in some cases for the "non-
> commutative" operators -- Subtract, Divide, Modulo, ShiftLeft, and
> ShiftRight. The actual problem cases seem to be rather unusual in common
> ASL code, however. David Box.
> =

> Modified the linux version of acpidump to obtain ACPI tables from not just
> /dev/mem (which may not exist) and /sys/firmware/acpi/tables. Lv Zheng.
> =

> iASL: Fixed a problem where the user preprocessor output file (.i)
> contained extra data that was not expected. The compiler was using this
> file as a temporary file and passed through #line directives in order to
> keep compiler error messages in sync with the input file and line number
> across multiple include files. The (.i) is no longer a temporary file as
> the compiler uses a new, different file for the original purpose.
> =

> iASL: Fixed a problem where comments within the original ASL source code
> file were not passed through to the preprocessor output file, nor any
> listing files.
> =

> iASL: Fixed some issues for the handling of the "#include" preprocessor
> directive and the similar (but not the same) "Include" ASL operator.
> =

> iASL: Add support for the new OSDT in both the disassembler and compiler.
> =

> iASL: Fixed a problem with the constant folding support where a Buffer
> object could be incorrectly generated (incorrectly formed) during a
> conversion to a Store() operator.
> =

> AcpiHelp: Updated for new NFIT GUIDs, "External" AML opcode, and new
> description text for the _REV predefined name. _REV now permanently
> returns 2, as per the ACPI 6.0 specification.
> =

> Debugger: Enhanced the output of the Debug ASL object for references
> produced by the Index operator. For Buffers and strings, only output the
> actual byte pointed to by the index. For packages, only print the single
> package element decoded by the index. Previously, the entire
> buffer/string/package was emitted.
> =

> iASL/Table-compiler: Fixed a regression where the "generic" data types
> were no longer recognized, causing errors.
> =

> =

> =

> =

> ------------------------------
> =

> Message: 2
> Date: Fri, 19 Jun 2015 14:15:23 +0000
> From: "Moore, Robert" <robert.moore(a)intel.com>
> To: acpica.org list <devel(a)acpica.org>
> Subject: [Devel] ACPICA version 20150619 released
> Message-ID:
> =

> <94F2FBAB4432B54E8AACC7DFDE6C92E37D3037D9(a)ORSMSX112.amr.corp.intel.com>
> =

> Content-Type: text/plain; charset=3D"us-ascii"
> =

> 19 June 2015. Summary of changes for version 20150619:
> =

> This release is available at https://acpica.org/downloads
> =

> Two regressions in version 20150616 have been addressed:
> =

> Fixes some problems/issues with the C library macro removal (ACPI_STRLEN,
> etc.) This update changes ACPICA to only use the standard headers for
> functions, or (optionally) the local prototypes for the local versions of
> the C library functions. Across the source code, this required some
> additional casts for some Clib invocations for portability. Moved all
> local prototypes to a new file, acclib.h
> =

> Fixes several problems with recent changes to the handling of the FACS
> table that could cause some systems not to boot.
> =

> =

> =

> =

> ------------------------------
> =

> Message: 3
> Date: Fri, 19 Jun 2015 09:30:18 -0500
> From: Dean Nelson <dnelson(a)redhat.com>
> To: "Moore, Robert" <robert.moore(a)intel.com>
> Cc: "acpica.org list" <devel(a)acpica.org>
> Subject: Re: [Devel] ACPICA version 20150619 released
> Message-ID: <5584277A.7030509(a)redhat.com>
> Content-Type: text/plain; charset=3D"windows-1252"; Format=3D"flowed"
> =

> On 06/19/2015 09:15 AM, Moore, Robert wrote:
> > 19 June 2015. Summary of changes for version 20150619:
> >
> > This release is available at https://acpica.org/downloads
> =

> Please excuse my ignorance, but why are the download files named
> *.tar_0.gz ? Why the '_0' ?
> =

> Also I noticed that the git-repo with the latest commit being...
> =

>    commit d7a940bb308d001b5d2b196174fee36c7daa61d6
>    Author:     Robert Moore <Robert.Moore(a)intel.com>
>    AuthorDate: Thu Jun 18 08:13:39 2015 -0700
>    Commit:     Robert Moore <Robert.Moore(a)intel.com>
>    CommitDate: Thu Jun 18 08:13:39 2015 -0700
>        Update version to 20150619.
> =

> differs from the two source code tarballs with regard to
> source/compiler/asllookup.c by the git-diff file that I've
> attached. But I don't see that patch mentioned in the git-repo.
> So where did those changes come from? And do they really belong
> in the tarballs? And if yes, why aren't they in the git-repo?
> =

> Thanks,
> Dean
> =

> =

> >
> > Two regressions in version 20150616 have been addressed:
> >
> > Fixes some problems/issues with the C library macro removal
> (ACPI_STRLEN, etc.)
> > This update changes ACPICA to only use the standard headers for
> functions, or
> > (optionally) the local prototypes for the local versions of the C
> library functions.
> > Across the source code, this required some additional casts for some
> Clib invocations
> > for portability. Moved all local prototypes to a new file, acclib.h
> >
> > Fixes several problems with recent changes to the handling of the FACS
> table that
> > could cause some systems not to boot.
> >
> >
> > _______________________________________________
> > Devel mailing list
> > Devel(a)acpica.org
> > https://lists.acpica.org/mailman/listinfo/devel
> >
> =

>=20
--===============7313649825134656517==--

