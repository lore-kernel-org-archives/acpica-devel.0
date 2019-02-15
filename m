Content-Type: multipart/mixed; boundary="===============9056491480776738399=="
MIME-Version: 1.0
From: Will Deacon <will.deacon at arm.com>
Subject: Re: [Devel] [RFC 2/3] arm_pmu: acpi: spe: Add initial MADT/SPE probing
Date: Fri, 15 Feb 2019 15:00:15 +0000
Message-ID: <20190215150015.GA6803@fuggles.cambridge.arm.com>
In-Reply-To: c740a06e-d5d3-3e42-d19b-fbfea02ac0e7@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9056491480776738399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 12:03:57PM -0600, Jeremy Linton wrote:
> On 2/14/19 11:11 AM, Will Deacon wrote:
> > On Fri, Feb 08, 2019 at 06:47:17PM -0600, Jeremy Linton wrote:
> > > +/*
> > > + * For lack of a better place, hook the normal PMU MADT walk
> > > + * and create a SPE device if we detect a recent MADT with
> > > + * a homogeneous PPI mapping.
> > > + */
> > > +static int arm_spe_acpi_parse_irqs(void)
> > > +{
> > > +	int cpu, ret, irq;
> > > +	u16 gsi =3D 0;
> > > +	bool first =3D true;
> > > +
> > > +	struct acpi_madt_generic_interrupt *gicc;
> > > +
> > > +	/*
> > > +	 * sanity check all the GICC tables for the same interrupt number
> > > +	 * for now we only support homogeneous ACPI/SPE machines.
> > > +	 */
> > > +	for_each_possible_cpu(cpu) {
> > > +		gicc =3D acpi_cpu_get_madt_gicc(cpu);
> > > +
> > > +		if (gicc->header.length < ACPI_MADT_GICC_SPE)
> > > +			return -ENODEV;
> > > +
> > > +		if (first) {
> > > +			gsi =3D gicc->spe_overflow_interrupt;
> > > +			if (!gsi)
> > > +				return -ENODEV;
> > > +			first =3D false;
> > > +		} else if (gsi !=3D gicc->spe_overflow_interrupt) {
> > > +			pr_warn("ACPI: SPE must have homogeneous interrupts\n");
> > > +			return -EINVAL;
> > > +		}
> > =

> > Unfortunately, I don't think this is sufficient to detect a homogeneous
> > system: we'll have to check the MIDRs instead, which is nasty. I would
> > personally be in favour of enforcing homogeneity for ACPI systems when =
we
> > bring up secondary CPUs, but I suspect others would disagree.
> =

> Given that all the SPE capable machines i'm aware of at the moment are
> homogeneous, are we ok with just doing an online CPU MIDR check for now, =
and
> cleaning that up if/when someone builds a machine and complains?

Yeah, I think we added a new bit to the PPTT to tell you that the machine is
homogenous, so just check that first and bail if it's not set.

Will

--===============9056491480776738399==--

