Content-Type: multipart/mixed; boundary="===============2964462142444711137=="
MIME-Version: 1.0
From: Marc Zyngier <marc.zyngier at arm.com>
Subject: Re: [Devel] [PATCH v8 3/3] iommu/arm-smmu-v3: Add workaround for
 Cavium ThunderX2 erratum #126
Date: Wed, 21 Jun 2017 10:30:39 +0100
Message-ID: <2e334fe2-864e-d2b9-1699-20aee5d26007@arm.com>
In-Reply-To: 20170621090835.GD3768@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2964462142444711137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 21/06/17 10:08, Will Deacon wrote:
> Hi Geetha,
> =

> On Wed, Jun 21, 2017 at 12:09:45PM +0530, Geetha Akula wrote:
>> On Tue, Jun 20, 2017 at 11:30 PM, Will Deacon <will.deacon(a)arm.com> wr=
ote:
>>> On Tue, Jun 20, 2017 at 07:47:39PM +0530, Geetha sowjanya wrote:
>>>> From: Geetha Sowjanya <geethasowjanya.akula(a)cavium.com>
>>>>
>>>> Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique=
 irq
>>>> lines for gerror, eventq and cmdq-sync.
>>>>
>>>> SHARED_IRQ option is set as a errata workaround, which allows to share=
 the irq
>>>> line by register single irq handler for all the interrupts.
>>>>
>>>> Signed-off-by: Geetha sowjanya <gakula(a)caviumnetworks.com>
>>>> ---
>>>>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    5 ++
>>>>  drivers/iommu/arm-smmu-v3.c                        |   73 +++++++++++=
+++++----
>>>>  2 files changed, 64 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b=
/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>>>> index 6ecc48c..44b40e0 100644
>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>>>> @@ -55,6 +55,11 @@ the PCIe specification.
>>>>                     Set for Caviun ThunderX2 silicon that doesn't supp=
ort
>>>>                     SMMU page1 register space.
>>>>
>>>> +- cavium,cn9900-broken-unique-irqline
>>>> +                    : Use single irq line for all the SMMUv3 interrup=
ts.
>>>> +                   Set for Caviun ThunderX2 silicon that doesn't supp=
ort
>>>> +                   MSI and also doesn't have unique irq lines for ger=
ror,
>>>> +                   eventq and cmdq-sync.
>>>
>>> I think we're better off just supporting a new (optional) named interru=
pt
>>> as "combined", and then allowing that to be used instead of the others.
>>
>> Are you suggesting to have new name irq "combined" like gerror ?
>> If yes, then this won't be possible with apci. We need to update iort sp=
ec to
>> add new name irq.
> =

> I'm mainly talking about the DT binding here, but I don't see why you
> can't hack drivers/acpi/arm64/iort.c like you did for the other erratum a=
nd
> have it register a single interrupt called "combined" based on the model
> number.
> =

>>>> +                                     arm_smmu_shared_irq_thread,
>>>> +                                     IRQF_ONESHOT | IRQF_SHARED,
>>>
>>> Why do you need IRQF_SHARED here?
>>
>>
>> +devm_request_threaded_irq(smmu->dev, irq,
>> +                                       arm_smmu_combined_irq_handler,
>> +                                       arm_smmu_combined_irq_thread,
>> +                                       IRQF_SHARED,
>> +                                       "arm-smmu-v3-combined-irq", smmu=
);
>>
>> On multi-node system, node1 SMMU's share irq lines with node0 SMMU's.
> =

> How does that work? Are these really MSIs under the hood? If so, why didn=
't
> you just build them as... MSIs?

More specifically, I suspect that they are made out of message-signalled
SPIs, targeting the GIC distributor directly... That's the only way I
can imagine it has been built... If I'm right, we probably have the
firmware programming the same SPI number in both nodes.

But of course, that's pure speculation.

	M.
-- =

Jazz is not dead. It just smells funny...

--===============2964462142444711137==--

