Content-Type: multipart/mixed; boundary="===============2681355874989892173=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] ACPICA version 20150619 released
Date: Fri, 19 Jun 2015 15:08:21 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D3038C9@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 5584277A.7030509@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2681355874989892173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Dean Nelson [mailto:dnelson(a)redhat.com]
> Sent: Friday, June 19, 2015 7:30 AM
> To: Moore, Robert
> Cc: acpica.org list
> Subject: Re: [Devel] ACPICA version 20150619 released
> =

> On 06/19/2015 09:15 AM, Moore, Robert wrote:
> > 19 June 2015. Summary of changes for version 20150619:
> >
> > This release is available at https://acpica.org/downloads
> =

> Please excuse my ignorance, but why are the download files named
> *.tar_0.gz ? Why the '_0' ?
> =


Yes, the website software did this. I'm working on fixing it.



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
> source/compiler/asllookup.c by the git-diff file that I've attached. But I
> don't see that patch mentioned in the git-repo.
> So where did those changes come from? And do they really belong in the
> tarballs? And if yes, why aren't they in the git-repo?
> =

> Thanks,
> Dean
>

Yes, this is in fact a problem, thanks for reporting it.

Fix for both problems is underway.



> =

> >
> > Two regressions in version 20150616 have been addressed:
> >
> > Fixes some problems/issues with the C library macro removal
> > (ACPI_STRLEN, etc.) This update changes ACPICA to only use the
> > standard headers for functions, or
> > (optionally) the local prototypes for the local versions of the C
> library functions.
> > Across the source code, this required some additional casts for some
> > Clib invocations for portability. Moved all local prototypes to a new
> > file, acclib.h
> >
> > Fixes several problems with recent changes to the handling of the FACS
> > table that could cause some systems not to boot.
> >
> >
> > _______________________________________________
> > Devel mailing list
> > Devel(a)acpica.org
> > https://lists.acpica.org/mailman/listinfo/devel
> >


--===============2681355874989892173==--

