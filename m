Content-Type: multipart/mixed; boundary="===============9085764767283810919=="
MIME-Version: 1.0
From: Lorenzo Pieralisi <lorenzo.pieralisi at arm.com>
Subject: Re: [Devel] [PATCH v7 1/3] ACPI/IORT: Fixup SMMUv3 resource size for
 Cavium ThunderX2 SMMUv3 model
Date: Tue, 20 Jun 2017 11:31:46 +0100
Message-ID: <20170620103146.GB26908@red-moon>
In-Reply-To: 20170620085123.GF16981@rric.localdomain
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9085764767283810919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2017 at 10:51:23AM +0200, Robert Richter wrote:
> On 20.06.17 10:19:43, Robert Richter wrote:
> > On 30.05.17 17:33:39, Geetha sowjanya wrote:
> > > From: Linu Cherian <linu.cherian(a)cavium.com>
> =

> > > +	/*
> > > +	 * Override the size, for Cavium ThunderX2 implementation
> > > +	 * which doesn't support the page 1 SMMU register space.
> > > +	 */
> > > +	if (smmu->model =3D=3D ACPI_IORT_SMMU_CAVIUM_CN99XX)
> > =

> > Geetha,
> > =

> > please resubmit the series since the macro changed to
> > ACPI_IORT_SMMU_V3_CAVIUM_CN99XX:
> > =

> >  https://github.com/acpica/acpica/commit/d00a4eb86e64bb4fa70f57ab5e5ca0=
a4ca2ad8ef#diff-a572aac2ccc26fe4a901616d7fdba859R1053
> =

> Rafael, Bob,
> =

> btw, I haven't seen
> =

>  https://github.com/acpica/acpica/commit/d00a4eb86e64
> =

> yet in linux-pm:linux-next. We would like to see this in 4.13 also. Is
> it on the way already?

Yes it would be great to understand how we can make sure IORT and
related ACPICA changes can be kept in sync for this merge window, it
is -rc6 already so it is getting a bit late in the cycle.

Thanks,
Lorenzo

--===============9085764767283810919==--

