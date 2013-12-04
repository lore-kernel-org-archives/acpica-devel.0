Content-Type: multipart/mixed; boundary="===============2330038060668437419=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] GPE blocks in reduced hardware mode
Date: Wed, 04 Dec 2013 15:51:42 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37C7A634E@ORSMSX103.amr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37C7A6077@ORSMSX103.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2330038060668437419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some text pulled from the ACPI 5.0 Spec:


5.6 ACPI Event Programming Model
The ACPI event programming model is based on the SCI interrupt and General-=
Purpose Event (GPE) register. ACPI provides an extensible method to raise a=
nd handle the SCI interrupt, as described in this section.
Hardware-reduced ACPI platforms (Section 4.1) use GPIO Interrupt Connection=
s to signal ACPI Events, described in Section 5.6.5.


5.6.1 ACPI Event Programming Model Components
The components of the ACPI event programming model are the following:
* OSPM
* FADT
* PM1a_STS, PM1b_STS and PM1a_EN, PM1b_EN fixed register blocks
* GPE0_BLK and GPE1_BLK register blocks
* GPE register blocks defined in GPE block devices


5.6.5 GPIO-signaled ACPI Events
On Hardware-reduced ACPI platforms, ACPI events are signaled when a GPIO In=
terrupt is received by OSPM,


7.2.13 PRW (Power Resources for Wake)
For HW-Reduced ACPI platforms, the GpeInfo structure is ignored by OSPM.


>> Hardware-reduced ACPI platforms (Section 4.1) use GPIO Interrupt Connect=
ions to signal ACPI Events.

I think this sentence says that on hardware-reduced ACPI platforms, there a=
re no GPEs, period.
Bob


> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Moore, Robert
> Sent: Tuesday, December 03, 2013 10:28 PM
> To: Al Stone; devel(a)acpica.org
> Subject: Re: [Devel] GPE blocks in reduced hardware mode
> =

> =

> =

> > -----Original Message-----
> > From: Al Stone [mailto:ahs3(a)redhat.com]
> > Sent: Tuesday, December 03, 2013 5:39 PM
> > To: Moore, Robert; devel(a)acpica.org
> > Subject: Re: [Devel] GPE blocks in reduced hardware mode
> >
> > On 12/03/2013 05:18 PM, Moore, Robert wrote:
> > > The first thing is that there are no GPE block devices in the field,
> > never have been. I don't think ACPICA actually supports them fully. It
> > is a bit of an "orphan" feature of ACPI.
> >
> > I see.  Yeah, I did find GPE block device support confusing in the code.
> > It seems like the infrastructure to handle them is present, but there
> > is no code to handle the "ACPI0006" ID anywhere I can find (that may
> > be a Linux limitation, though).
> =

> =

> Correct. There needs to be a linux driver that is loaded upon detection of
> an _HID of ACPI0006. This does not exist. Thus, there is no support for
> this feature in Linux.
> =

> The GPE block device was a bit of a fantasy that never materialized in any
> hardware that I know of. And one could certainly conclude with some high
> degree of probability that nobody is going to implement custom hardware to
> support a GPE block device on a (ahem) "hardware reduced platform".
> =

> Bob
> =

> =

> =

> =

> >
> > > I'll have to take a look closer at the spec for an exact reference,
> > > but
> > basically one of the things that ACPI_REDUCED_HARDWARE means is no
> > GPEs, IIRC.
> >
> > Right -- that's what ACPI_REDUCED_HARDWARE means in the ACPICA code;
> > that seems pretty clear.  I just can't seem to find anything that
> > clear in the spec :/...
> >
> > I'll continue to look in the spec but if you find something before I
> > do, do let me know.
> >
> > Thanks!
> >
> > >> -----Original Message-----
> > >> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Al Stone
> > >> Sent: Tuesday, December 03, 2013 2:38 PM
> > >> To: devel(a)acpica.org
> > >> Subject: [Devel] GPE blocks in reduced hardware mode
> > >>
> > >> Howdy.
> > >>
> > >> I've been trying to do some clean-up on the Linux ACPI driver with
> > >> regard to the reduced hardware profile introduced in ACPI 5.0.
> > >>
> > >> In thinking about GPE block devices, I was looking through the
> > >> functions in source/components/events/evxfgpe.c and noticed that
> > >> they are all #ifdef'd out for ACPI_REDUCED_HARDWARE.  When I look
> > >> back through the specification, however, I cannot find any place
> > >> where they
> > are prohibited.
> > >>
> > >> Clearly, the gpe0/1 blocks in the FADT are not to be used; this is
> > >> explicitly stated in section 5.2.9 of the spec.  Could someone
> > >> please point me to a similar statement for a GPE block device?  I
> > >> just cannot seem to find it.
> > >>
> > >> The closest thing I can find is section 9.10 implying that a GPE
> > >> block device is an extension of the gpe0/1 blocks from the FADT,
> > >> but there is no explicit statement there so it is ambiguous to me.
> > >>
> > >> Thanks in advance for any pointers; I'm just puzzled at this point
> > >> and trying to understand how the conclusion came to be.
> > >>
> > >> --
> > >> ciao,
> > >> al
> > >> -----------------------------------
> > >> Al Stone
> > >> Software Engineer
> > >> Red Hat, Inc.
> > >> ahs3(a)redhat.com
> > >> -----------------------------------
> > >> _______________________________________________
> > >> Devel mailing list
> > >> Devel(a)acpica.org
> > >> https://lists.acpica.org/mailman/listinfo/devel
> >
> >
> > --
> > ciao,
> > al
> > -----------------------------------
> > Al Stone
> > Software Engineer
> > Red Hat, Inc.
> > ahs3(a)redhat.com
> > -----------------------------------
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============2330038060668437419==--

