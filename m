Content-Type: multipart/mixed; boundary="===============8154751252391721093=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Possible issue with iasl on big endian machines.
Date: Thu, 20 Mar 2014 18:41:52 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37C7FC6E7@ORSMSX103.amr.corp.intel.com>
In-Reply-To: 532B29E8.2020405@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8154751252391721093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Please file whatever changes are needed for iASL to run on big-endian machi=
nes on the ACPICA bugzilla and we will integrate them.

bugs.acpica.org

Thanks,
Bob


> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Al Stone
> Sent: Thursday, March 20, 2014 10:48 AM
> To: Marcel Apfelbaum
> Cc: devel(a)acpica.org
> Subject: Re: [Devel] Possible issue with iasl on big endian machines.
> =

> On 03/20/2014 11:24 AM, Marcel Apfelbaum wrote:
> > On Thu, 2014-03-20 at 11:19 -0600, Al Stone wrote:
> >> On 03/20/2014 11:03 AM, Marcel Apfelbaum wrote:
> >>> Hi,
> >>>
> >>> Should iasl running on a big endian machine be able to disassemble a
> >>> DSDT(and any other acpi table) taken from a little endian machine?
> >>>
> >>> I tried to do it and I receive:
> >>> Error [...] TableHeader length [0xBB040000] greater than the input
> file size [0x4BB].
> >>> As you can see the length bytes are swapped.
> >>>
> >>> The question is, shouldn't it work, ACPI protocol being always little-
> endian?
> >>>
> >>> Thanks,
> >>> Marcel
> >>>
> >>>
> >>> _______________________________________________
> >>> Devel mailing list
> >>> Devel(a)acpica.org
> >>> https://lists.acpica.org/mailman/listinfo/devel
> >>>
> >>
> >> Which version of iasl are you using?  If you're using the version
> >> straight from ACPICA, it needs patching to handle big-endian.
> >>
> >> If you're using one of the recent Fedora/Debian versions, they have
> >> been patched for big-endian support, but of course there could be an
> >> issue with those patches.
> >>
> >> Regardless, the ACPI data _should_ be in little-endian form.
> >>
> > Hi Al,
> > Thanks for the prompt reply.
> >
> > I am using acpica-tools-20130823-5.fc19.ppc64 (The one that comes with
> > Fedora 19 on a big endian ppc64 machine) Should I file a bug?
> >
> > Thanks,
> > Marcel
> >
> =

> Yup, please file a BZ and I'll get to it as soon as I can.
> =

> BTW, I just pushed 20131115 to F19 stable, so you may want to try that
> version.  F20/21 are at 20140214.
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
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============8154751252391721093==--

