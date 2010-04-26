Content-Type: multipart/mixed; boundary="===============7470539493375941759=="
MIME-Version: 1.0
From: Jung-uk Kim <jkim at FreeBSD.org>
Subject: Re: [Devel] interpretter
Date: Mon, 26 Apr 2010 16:32:52 -0400
Message-ID: <201004261632.54716.jkim@FreeBSD.org>
In-Reply-To: 201004262156.19102.trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7470539493375941759==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Monday 26 April 2010 03:56 pm, Thomas Renninger wrote:
> On Monday 26 April 2010 08:12:52 pm webczat(a)nullroute.eu.org wrote:
> > I just want to write full acpi support in my os.
>
> You should try to take acpica sources and integrate them.
>
> > I mean, myself.
>
> Oops, better you hire someone :)
>
> > At least basic support.
>
> Even basic support, propably ends up in quite some work.
> You may want to start with fetching the ACPI tables.
> And look at Linux or other OSes (AFAIK all use acpica sources,
> only Windows has their own solution/interpreter).

OpenBSD does not use ACPICA:

http://www.openbsd.org/cgi-bin/cvsweb/src/sys/dev/acpi/

See dsdt.c, for example.

Jung-uk Kim

--===============7470539493375941759==--

