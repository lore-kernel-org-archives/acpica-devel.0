Content-Type: multipart/mixed; boundary="===============8193054610086668814=="
MIME-Version: 1.0
From: Robert Richter <rric at kernel.org>
Subject: Re: [Devel] [PATCH v4 2/2] acpi, gicv3-its,
 numa: Adding numa node mapping for gic-its units
Date: Mon, 26 Jun 2017 19:45:01 +0200
Message-ID: <20170626174501.GB10237@rric.localdomain>
In-Reply-To: 76d94864-d121-1d7a-bc23-00ac57cd7fb2@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8193054610086668814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 26.06.17 18:43:47, Marc Zyngier wrote:
> On 26/06/17 18:38, Robert Richter wrote:
> > On 22.06.17 15:49:25, Marc Zyngier wrote:
> >> On 22/06/17 07:10, Ganapatrao Kulkarni wrote:
> >>> Add code to parse SRAT ITS Affinity sub table as defined in ACPI 6.2.
> >>> Later in per device probe, ITS devices are mapped to numa node using
> >>> ITS Id to proximity domain mapping.
> >>>
> >>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni(a)cavium.com>
> >>> ---
> >>>  drivers/irqchip/irq-gic-v3-its.c | 75 ++++++++++++++++++++++++++++++=
+++++++++-
> >>>  1 file changed, 74 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-g=
ic-v3-its.c
> >>> index 45ea1933..1c21e01 100644
> >>> --- a/drivers/irqchip/irq-gic-v3-its.c
> >>> +++ b/drivers/irqchip/irq-gic-v3-its.c
> >>> @@ -1833,6 +1833,77 @@ static int __init its_of_probe(struct device_n=
ode *node)
> >>>  =

> >>>  #define ACPI_GICV3_ITS_MEM_SIZE (SZ_128K)
> >>>  =

> >>> +#ifdef CONFIG_ACPI_NUMA
> >>
> >> So given that there is a dependency issue between the irqchip and apci=
ca
> >> trees, I plan on taking this patch with the following change:
> >>
> >> #if defined(CONFIG_ACPI_NUMA) && (ACPI_CA_VERSION >=3D 0x20170531)
> > =

> > The struct name was changed :/
> > =

> >  s/acpi_srat_its_affinity/acpi_srat_gic_its_affinity/
> > =

> > You need to update this too.
> =

> I changed it when I applied the patch. See
> =

> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/com=
mit/?h=3Dirq/irqchip-4.13&id=3Ddbd2b826723319eb6e4bee5214f8901e336c06be
> =

> Which is also in tip/irq/core.

Great, thanks for the pointer.

-Robert

--===============8193054610086668814==--

