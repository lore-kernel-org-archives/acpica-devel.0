Content-Type: multipart/mixed; boundary="===============1274260464470784356=="
MIME-Version: 1.0
From: Marcel Apfelbaum <marcel.a at redhat.com>
Subject: Re: [Devel] Possible issue with iasl on big endian machines.
Date: Thu, 20 Mar 2014 19:24:09 +0200
Message-ID: <1395336249.3100.10.camel@localhost.localdomain>
In-Reply-To: 532B233D.3040608@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1274260464470784356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2014-03-20 at 11:19 -0600, Al Stone wrote:
> On 03/20/2014 11:03 AM, Marcel Apfelbaum wrote:
> > Hi,
> >
> > Should iasl running on a big endian machine be able to
> > disassemble a DSDT(and any other acpi table) taken from a
> > little endian machine?
> >
> > I tried to do it and I receive:
> > Error [...] TableHeader length [0xBB040000] greater than the input file=
 size [0x4BB].
> > As you can see the length bytes are swapped.
> >
> > The question is, shouldn't it work, ACPI protocol being always little-e=
ndian?
> >
> > Thanks,
> > Marcel
> >
> >
> > _______________________________________________
> > Devel mailing list
> > Devel(a)acpica.org
> > https://lists.acpica.org/mailman/listinfo/devel
> >
> =

> Which version of iasl are you using?  If you're using the version
> straight from ACPICA, it needs patching to handle big-endian.
> =

> If you're using one of the recent Fedora/Debian versions, they have
> been patched for big-endian support, but of course there could be an
> issue with those patches.
> =

> Regardless, the ACPI data _should_ be in little-endian form.
> =

Hi Al,
Thanks for the prompt reply.

I am using acpica-tools-20130823-5.fc19.ppc64 (The one that comes with Fedo=
ra 19 on a big endian ppc64 machine)
Should I file a bug?

Thanks,
Marcel


--===============1274260464470784356==--

