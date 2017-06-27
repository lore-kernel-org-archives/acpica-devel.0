Content-Type: multipart/mixed; boundary="===============7824213499187207597=="
MIME-Version: 1.0
From: Robert Richter <robert.richter at cavium.com>
Subject: Re: [Devel] [RESEND PATCH v9 3/3] iommu/arm-smmu-v3: Add workaround
 for Cavium ThunderX2 erratum #126
Date: Tue, 27 Jun 2017 17:18:01 +0200
Message-ID: <20170627151801.GT31368@rric.localdomain>
In-Reply-To: CANHdaibSGtbdQfZ2kv1E9t4eE+JY2wtsDP7=rEw-mj059yhyHA@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7824213499187207597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 27.06.17 20:28:14, Geetha Akula wrote:
> On Tue, Jun 27, 2017 at 7:36 PM, Will Deacon <will.deacon(a)arm.com> wrot=
e:
> > On Tue, Jun 27, 2017 at 03:56:10PM +0200, Robert Richter wrote:
> >> On 23.06.17 19:04:36, Geetha sowjanya wrote:
> >> > From: Geetha Sowjanya <geethasowjanya.akula(a)cavium.com>
> >> >
> >> > Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have uniq=
ue irq
> >> > lines for gerror, eventq and cmdq-sync.
> >> >
> >> > New named irq "combined" is set as a errata workaround, which allows=
 to
> >> > share the irq line by register single irq handler for all the interr=
upts.
> >> >
> >> > Signed-off-by: Geetha sowjanya <gakula(a)caviumnetworks.com>
> >> > ---
> >> >  Documentation/arm64/silicon-errata.txt             |    1 +
> >> >  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    6 +
> >> >  drivers/acpi/arm64/iort.c                          |   57 ++++++++-=
--
> >> >  drivers/iommu/arm-smmu-v3.c                        |  100 +++++++++=
+++++-----
> >> >  4 files changed, 121 insertions(+), 43 deletions(-)
> >>
> >> > +static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> >> > +{
> >> > +   int ret, irq;
> >> > +   u32 irqen_flags =3D IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
> >> > +
> >> > +   /* Disable IRQs first */
> >> > +   ret =3D arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
> >> > +                                 ARM_SMMU_IRQ_CTRLACK);
> >> > +   if (ret) {
> >> > +           dev_err(smmu->dev, "failed to disable irqs\n");
> >> > +           return ret;
> >> > +   }
> >> > +
> >> > +   irq =3D smmu->combined_irq;
> >> > +   if (irq) {
> >> > +           /*
> >> > +            * Cavium ThunderX2 implementation doesn't not support u=
nique
> >> > +            * irq lines. Use single irq line for all the SMMUv3 int=
errupts.
> >> > +            */
> >> > +           ret =3D devm_request_threaded_irq(smmu->dev, irq,
> >> > +                                   arm_smmu_combined_irq_handler,
> >> > +                                   arm_smmu_combined_irq_thread,
> >> > +                                   IRQF_ONESHOT,
> >>
> >> Without the IRQF_SHARED flag set I see the following on a dual node
> >> system now:
> Node1 SMMU interrupts are programmed wrong in the firmware.
> Node 0 and Node1 SMMU do not share interrupts.
> I have verified the patch on dual node with correct interrupt numbers
> programmed in firmware.

Ah, ok, will update to latest fw.

Thanks,

-Robert

--===============7824213499187207597==--

