Content-Type: multipart/mixed; boundary="===============0325866019717906625=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: Re: [Devel] [PATCH 5/6] acpi/cppc: Add support for optional CPPC
 registers
Date: Sat, 30 Mar 2019 00:02:12 +0100
Message-ID: <1774302.IF6vfKfJ7U@aspire.rjw.lan>
In-Reply-To: SN6PR12MB26399489011DD026910B6049F85A0@SN6PR12MB2639.namprd12.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0325866019717906625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday, March 29, 2019 9:18:04 PM CET Ghannam, Yazen wrote:
> > -----Original Message-----
> > From: linux-acpi-owner(a)vger.kernel.org <linux-acpi-owner(a)vger.kerne=
l.org> On Behalf Of Pandruvada, Srinivas
> > Sent: Wednesday, March 27, 2019 10:48 AM
> > To: linux-kernel(a)vger.kernel.org; devel(a)acpica.org; Natarajan, Jana=
karajan <Janakarajan.Natarajan(a)amd.com>; linux-
> > acpi(a)vger.kernel.org; linux-pm(a)vger.kernel.org
> > Cc: Ghannam, Yazen <Yazen.Ghannam(a)amd.com>; lenb(a)kernel.org; viresh=
.kumar(a)linaro.org; Moore, Robert
> > <robert.moore(a)intel.com>; Schmauss, Erik <erik.schmauss(a)intel.com>;=
 rjw(a)rjwysocki.net
> > Subject: Re: [PATCH 5/6] acpi/cppc: Add support for optional CPPC regis=
ters
> > =

> > On Fri, 2019-03-22 at 20:26 +0000, Natarajan, Janakarajan wrote:
> > > From: Yazen Ghannam <Yazen.Ghannam(a)amd.com>
> > >
> > > Newer AMD processors support a subset of the optional CPPC registers.
> > > Create show, store and helper routines for supported CPPC registers.
> > >
> > > Signed-off-by: Yazen Ghannam <Yazen.Ghannam(a)amd.com>
> > > [ carved out into a patch, cleaned up, productized ]
> > > Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan(a)amd.com>
> > >
> > =

> > [..]
> > =

> > > +	/* desired_perf is the only mandatory value in perf_ctrls */
> > > +	if (cpc_read(cpu, desired_reg, &desired))
> > > +		ret =3D -EFAULT;
> > > +
> > > +	if (CPC_SUPPORTED(max_reg) && cpc_read(cpu, max_reg, &max))
> > > +		ret =3D -EFAULT;
> > > +
> > We should create and use different macro other than CPPC_SUPPORTED.
> > CPC_SUPPORTED doesn't validate the correctness of object type for a
> > field. For example "Maximum Performance Register" can only be buffer
> > not integer. In this way invalid field definitions can be ignored.
> > =

> =

> So create something like "CPPC_SUPPORTED_BUFFER" for buffer-only register=
s?
> =

> And then buffer/integer registers will continue to use "CPPC_SUPPORTED".
> =

> These seem to be the only two cases at this time. Is this okay?

Yes, something like that.

Thanks,
Rafael


--===============0325866019717906625==--

