Content-Type: multipart/mixed; boundary="===============1539097219953786456=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] ACPICA version 20171214 released
Date: Fri, 15 Dec 2017 17:10:25 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B74FD9A3@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 22f43a2b-2c63-6a1f-d422-ef5ccf4a9ea8@canonical.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1539097219953786456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixed


> -----Original Message-----
> From: Alex Hung [mailto:alex.hung(a)canonical.com]
> Sent: Thursday, December 14, 2017 6:14 PM
> To: Moore, Robert <robert.moore(a)intel.com>; acpica.org list
> <devel(a)acpica.org>
> Subject: Re: [Devel] ACPICA version 20171214 released
> =

> On 2017-12-15 06:13 AM, Moore, Robert wrote:
> > 14 December 2017. Summary of changes for version 20171214:
> >
> > This release is available at https://acpica.org/downloads
> >
> >
> > 1) ACPICA kernel-resident subsystem:
> >
> > Fixed a regression in the external (public) AcpiEvaluateObjectTyped
> interface where the optional "pathname" argument had inadvertently
> become a required argument returning an error if omitted (NULL pointer
> argument).
> >
> > Fixed two possible memory leaks related to the recently developed
> "late resolution" of reference objects within ASL Package Object
> definitions.
> >
> > Added two recently defined _OSI strings: "Windows 2016" and "Windows
> 2017". Mario Limonciello.
> >
> > Implemented and deployed a safer version of the C library function
> strncpy:  AcpiUtSafeStrncpy. The intent is to at least prevent the
> creation of unterminated strings as a possible result of a standard
> strncpy.
> =

> =

> Hi Robert,
> =

> I downloaded the source code by "git clone
> https://github.com/acpica/acpica", and installed utility by "make
> install" but the acpixtract does not work properly as below:
> =

> Note: this also affects source code from https://acpica.org/downloads
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> $ iasl -v
> =

> Intel ACPI Component Architecture
> ASL+ Optimizing Compiler/Disassembler version 20171214
> Copyright (c) 2000 - 2017 Intel Corporation
> =

> $ acpixtract acpi.log
> =

> Intel ACPI Component Architecture
> ACPI Binary Table Extraction Utility version 20171214 Copyright (c) 2000
> - 2017 Intel Corporation
> =

> Table [DSD] was not found in acpi.log
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> "git bisect" points to the following commit:
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> $ git bisect good
> 64ad9c69a1bd534a466e060a33c0bbf5fc9e189c is the first bad commit commit
> 64ad9c69a1bd534a466e060a33c0bbf5fc9e189c
> Author: Robert Moore <Robert.Moore(a)intel.com>
> Date:   Fri Dec 8 07:35:29 2017 -0800
> =

>      Create and deploy safe version of strncpy. No functional change
> =

>      AcpiUtSafeStrncpy - copy and terminate string. Strncpy is not
>      guaranteed to terminate the copied string if the input is longer
>      than the length of the target.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> Especially, it is the following change that causes problems:
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/source/tools/acpixtract/acpixtract.c
> b/source/tools/acpixtract/acpixtract.c
> index ea78846..fe1ace9 100644
> --- a/source/tools/acpixtract/acpixtract.c
> +++ b/source/tools/acpixtract/acpixtract.c
> @@ -204,8 +204,7 @@ AxExtractTables (
> =

>       if (Signature)
>       {
> -        strncpy (UpperSignature, Signature, 4);
> -        UpperSignature[4] =3D 0;
> +        AcpiUtSafeStrncpy (UpperSignature, Signature, ACPI_NAME_SIZE);
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> and it can fixed by adding +1 after ACPI_NAME_SIZE such as
> AcpiUtSafeStrncpy (UpperSignature, Signature, ACPI_NAME_SIZE + 1);
> =

> >
> > Cleaned up and restructured the global variable file (acglobal.h).
> There are many changes, but no functional changes.
> >
> >
> > 2) iASL Compiler/Disassembler and Tools:
> >
> > iASL Table Compiler: Fixed a problem with the DBG2 ACPI table where
> the optional OemData field at the end of the table was incorrectly
> required for proper compilation. It is now correctly an optional field.
> >
> > ASLTS: The entire suite was converted from standard ASL to the ASL+
> language, using the ASL-to-ASL+ converter which is integrated into the
> iASL compiler. A binary compare of all output files has verified the
> correctness of the conversion.
> >
> > iASL: Fixed the source code build for platforms where "char" is
> unsigned. This affected the iASL lexer only. Jung-uk Kim.
> >
> >
> > _______________________________________________
> > Devel mailing list
> > Devel(a)acpica.org
> > https://lists.acpica.org/mailman/listinfo/devel
> >
> =

> =

> --
> Cheers,
> Alex Hung

--===============1539097219953786456==--

