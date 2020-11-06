Content-Type: multipart/mixed; boundary="===============8265306687657887231=="
MIME-Version: 1.0
From: Robin Murphy <robin.murphy at arm.com>
Subject: [Devel] Re: [RFC PATCH 0/4] ACPI/IORT: Support for IORT RMR node
Date: Fri, 06 Nov 2020 17:09:19 +0000
Message-ID: <fa51fe8a-9c69-6800-7ccc-9b7f6ef52790@arm.com>
In-Reply-To: 5ce01d8d-c2dc-8c13-0f48-b3b35254c810@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8265306687657887231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2020-11-06 16:26, Steven Price wrote:
> On 06/11/2020 16:17, Shameerali Kolothum Thodi wrote:
>>
>>
>>> -----Original Message-----
>>> From: Steven Price [mailto:steven.price(a)arm.com]
>>> Sent: 06 November 2020 15:22
>>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>;
>>> linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
>>> iommu(a)lists.linux-foundation.org; devel(a)acpica.org
>>> Cc: lorenzo.pieralisi(a)arm.com; joro(a)8bytes.org; Jonathan Cameron
>>> <jonathan.cameron(a)huawei.com>; Linuxarm <linuxarm(a)huawei.com>;
>>> Guohanjun (Hanjun Guo) <guohanjun(a)huawei.com>; Sami Mujawar
>>> <Sami.Mujawar(a)arm.com>; robin.murphy(a)arm.com; wanghuiqiang
>>> <wanghuiqiang(a)huawei.com>
>>> Subject: Re: [RFC PATCH 0/4] ACPI/IORT: Support for IORT RMR node
>>>
>>> On 28/10/2020 18:24, Shameerali Kolothum Thodi wrote:
>>>> Hi Steve,
>>>>
>>>>> -----Original Message-----
>>>>> From: Steven Price [mailto:steven.price(a)arm.com]
>>>>> Sent: 28 October 2020 16:44
>>>>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com=
>;
>>>>> linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
>>>>> iommu(a)lists.linux-foundation.org; devel(a)acpica.org
>>>>> Cc: lorenzo.pieralisi(a)arm.com; joro(a)8bytes.org; Jonathan Cameron
>>>>> <jonathan.cameron(a)huawei.com>; Linuxarm <linuxarm(a)huawei.com>;
>>>>> Guohanjun (Hanjun Guo) <guohanjun(a)huawei.com>;
>>> robin.murphy(a)arm.com;
>>>>> wanghuiqiang <wanghuiqiang(a)huawei.com>; Sami Mujawar
>>>>> <Sami.Mujawar(a)arm.com>
>>>>> Subject: Re: [RFC PATCH 0/4] ACPI/IORT: Support for IORT RMR node
>>>>>
>>>>> On 27/10/2020 11:26, Shameer Kolothum wrote:
>>>>>> The series adds support to IORT RMR nodes specified in IORT
>>>>>> Revision E -ARM DEN 0049E[0]. RMR nodes are=C2=A0used to=C2=A0descri=
be memory
>>>>>> ranges that are used by endpoints and require a unity mapping
>>>>>> in SMMU.
>>>>>
>>>>> Hi Shameer,
>>>>>
>>>>> I've also been taking a look at RMR, and Sami is helping me get set up
>>>>> so that I can do some testing. We're hoping to be able to test an EFI
>>>>> framebuffer or splash screen - which has the added complication of the
>>>>> unity mapping becoming redundant if a native display driver takes over
>>>>> the display controller.
>>>>>
>>>>> I've looked through your series and the code looks correct to me.
>>>>
>>>> Thanks for taking a look and the details.
>>>>
>>>>> Hopefully I'll be able to give it some testing soon.
>>>>
>>>> Cool. Please update once you get a chance run the tests.
>>>
>>> Hi Shameer,
>>
>> Hi Steve,
>>
>>> Just to update on this, for the EFI framebuffer use case I hit exactly
>>> the issue that Robin has mentioned in another thread - the RMR is
>>> effectively ignored because the display controller isn't being handled
>>> by Linux (so there's no device to link it to).
>>
>> Thanks for the update. Here, by "ignored "you meant get_resv_regions()
>> is not called or not?
> =

> get_resv_regions() isn't called.

Right, AIUI the EFI framebuffer "device" pretty much just represents a =

magic region of RAM, whose existence is based on EFI services - see =

register_gop_device() - regardless of whether the underlying physical =

hardware is described in DSDT and IORT such that a tangential =

iommu_probe_device() call might happen at all.

Robin.

>> =C2=A0 The splash screen might
>>> similarly flicker as the SMMU reset will initially block the traffic
>>> before the RMR region is enabled.
>>
>> Does that mean you somehow managed to make the unity
>> mapping but there was flicker during the SMMU reset to
>> unity mapping setup period. Sorry I am trying to understand
>> the exact behavior observed in this case.
> =

> I haven't yet got this completely working (on the board which I'm =

> testing the display controller doesn't have any existing ACPI bindings). =

> However from what I understand the SMMU reset would block all memory =

> access for the display controller before the RMR region would be setup. =

> I'm going to try to get the display controller working with ACPI so I =

> can test this properly.
> =

> Steve
--===============8265306687657887231==--

