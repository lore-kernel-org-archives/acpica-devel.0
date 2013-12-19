Content-Type: multipart/mixed; boundary="===============5488721783321173144=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] ACPICA version 20131218 released
Date: Thu, 19 Dec 2013 15:43:53 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37C7BA7FE@ORSMSX103.amr.corp.intel.com>
In-Reply-To: 2981258.iZuWaPFBlD@skinner
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5488721783321173144==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixed the build script to add this.
Thanks,
Bob


> -----Original Message-----
> From: Thomas Renninger [mailto:trenn(a)suse.de]
> Sent: Thursday, December 19, 2013 1:18 AM
> To: devel(a)acpica.org
> Cc: Moore, Robert
> Subject: Re: [Devel] ACPICA version 20131218 released
> =

> Hi,
> =

> On Wednesday, December 18, 2013 09:44:47 PM Moore, Robert wrote:
> > 18 December 2013. Summary of changes for version 20131218:
> >
> > This release is available at https://acpica.org/downloads
> ...
> > Example ACPICA code (source/tools/examples): Updated the example code
> > so that it builds to an actual working program, not just example code.
> > Added ACPI tables and execution of an example control method in the
> > DSDT. Added makefile support for Unix generation.
> =

> I expect there is a bug which may be restricted to the dual license
> download tarball (I did not test the other one).
> =

> The bug is that generate/unix/acpiexamples/Makefile
> does not show up in the tarball.
> =

> This is related to commit da63493b9792be01c6ee5a1d5e97d9084b86b77c
> where the examples directory and binary got added to:
> generate/unix/Makefile.config
> (this change shows up in the tarball), but acpiexamples/Makefile is
> missing.
> =

> As a result, make ends up in an endless loop here.
> =

> Don't know how the tarballs are generated, I guess it's an easy fix for
> someone who does.
> =

> Thanks,
> =

>      Thomas

--===============5488721783321173144==--

