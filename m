Content-Type: multipart/mixed; boundary="===============2209992767264025684=="
MIME-Version: 1.0
From: Geetha Akula <geethasowjanya.akula at gmail.com>
Subject: Re: [Devel] [RESEND PATCH v9 3/3] iommu/arm-smmu-v3: Add workaround
 for Cavium ThunderX2 erratum #126
Date: Tue, 27 Jun 2017 20:28:14 +0530
Message-ID: <CANHdaibSGtbdQfZ2kv1E9t4eE+JY2wtsDP7=rEw-mj059yhyHA@mail.gmail.com>
In-Reply-To: 20170627140559.GK14041@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2209992767264025684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2017 at 7:36 PM, Will Deacon <will.deacon(a)arm.com> wrote:
> On Tue, Jun 27, 2017 at 03:56:10PM +0200, Robert Richter wrote:
>> On 23.06.17 19:04:36, Geetha sowjanya wrote:
>> > From: Geetha Sowjanya <geethasowjanya.akula(a)cavium.com>
>> >
>> > Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique=
 irq
>> > lines for gerror, eventq and cmdq-sync.
>> >
>> > New named irq "combined" is set as a errata workaround, which allows to
>> > share the irq line by register single irq handler for all the interrup=
ts.
>> >
>> > Signed-off-by: Geetha sowjanya <gakula(a)caviumnetworks.com>
>> > ---
>> >  Documentation/arm64/silicon-errata.txt             |    1 +
>> >  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    6 +
>> >  drivers/acpi/arm64/iort.c                          |   57 ++++++++---
>> >  drivers/iommu/arm-smmu-v3.c                        |  100 +++++++++++=
+++-----
>> >  4 files changed, 121 insertions(+), 43 deletions(-)
>>
>> > +static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>> > +{
>> > +   int ret, irq;
>> > +   u32 irqen_flags =3D IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
>> > +
>> > +   /* Disable IRQs first */
>> > +   ret =3D arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
>> > +                                 ARM_SMMU_IRQ_CTRLACK);
>> > +   if (ret) {
>> > +           dev_err(smmu->dev, "failed to disable irqs\n");
>> > +           return ret;
>> > +   }
>> > +
>> > +   irq =3D smmu->combined_irq;
>> > +   if (irq) {
>> > +           /*
>> > +            * Cavium ThunderX2 implementation doesn't not support uni=
que
>> > +            * irq lines. Use single irq line for all the SMMUv3 inter=
rupts.
>> > +            */
>> > +           ret =3D devm_request_threaded_irq(smmu->dev, irq,
>> > +                                   arm_smmu_combined_irq_handler,
>> > +                                   arm_smmu_combined_irq_thread,
>> > +                                   IRQF_ONESHOT,
>>
>> Without the IRQF_SHARED flag set I see the following on a dual node
>> system now:
Node1 SMMU interrupts are programmed wrong in the firmware.
Node 0 and Node1 SMMU do not share interrupts.
I have verified the patch on dual node with correct interrupt numbers
programmed in firmware.


Thanks,
Geetha.
>
> We asked about that before:
>
> https://marc.info/?l=3Dlinux-arm-kernel&m=3D149803613513068&w=3D2
> https://marc.info/?l=3Dlinux-acpi&m=3D149803744713475&w=3D2
>
> and Geetha didn't reply, but the next version of the patch dropped the fl=
ag.
> Is it just that firmware is misprogramming something here, or something
> more fundamental?
>
> Will

--===============2209992767264025684==--

