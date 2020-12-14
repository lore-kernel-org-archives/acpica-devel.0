Content-Type: multipart/mixed; boundary="===============2759639477141533369=="
MIME-Version: 1.0
From: Robin Murphy <robin.murphy at arm.com>
Subject: [Devel] Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
Date: Mon, 14 Dec 2020 12:33:45 +0000
Message-ID: <8f92d0b3-360b-5d47-10a7-83d09e75d993@arm.com>
In-Reply-To: 67cb563d19114f609348dc9f8b4307e9@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2759639477141533369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2020-12-14 10:55, Shameerali Kolothum Thodi wrote:
> Hi Steve,
> =

>> -----Original Message-----
>> From: Steven Price [mailto:steven.price(a)arm.com]
>> Sent: 10 December 2020 10:26
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>;
>> linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
>> iommu(a)lists.linux-foundation.org; devel(a)acpica.org
>> Cc: Linuxarm <linuxarm(a)huawei.com>; lorenzo.pieralisi(a)arm.com;
>> joro(a)8bytes.org; robin.murphy(a)arm.com; wanghuiqiang
>> <wanghuiqiang(a)huawei.com>; Guohanjun (Hanjun Guo)
>> <guohanjun(a)huawei.com>; Jonathan Cameron
>> <jonathan.cameron(a)huawei.com>; Sami.Mujawar(a)arm.com
>> Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
>>
>> On 19/11/2020 12:11, Shameer Kolothum wrote:
>>> RFC v1 --> v2:
>>>   =C2=A0- Added a generic interface for IOMMU drivers to retrieve all t=
he
>>>   =C2=A0 =C2=A0RMR info associated with a given IOMMU.
>>>   =C2=A0- SMMUv3 driver gets the RMR list during probe() and installs
>>>   =C2=A0=C2=A0 bypass STEs for all the SIDs in the RMR list. This is to=
 keep
>>>    =C2=A0 the ongoing traffic alive(if any) during SMMUv3 reset. This is
>>>      based on the suggestions received for v1 to take care of the
>>>      EFI framebuffer use case. Only sanity tested for now.
>>
>> Hi Shameer,
>>
>> Sorry for not looking at this before.
>>
>> Do you have any plans to implement support in the SMMUv2 driver? The
>> platform I've been testing the EFI framebuffer support on has the
>> display controller behind SMMUv2, so as it stands this series doesn't
>> work. I did hack something up for SMMUv2 so I was able to test the first
>> 4 patches.
> =

> Thanks for taking a look. Sure, I can look into adding the support for SM=
MUv2.
> =

>>
>>>   =C2=A0- During the probe/attach device, SMMUv3 driver reserves any
>>>   =C2=A0 =C2=A0RMR region associated with the device such that there is=
 a unity
>>>   =C2=A0 =C2=A0mapping for them in SMMU.
>>
>> For the EFI framebuffer use case there is no device to attach so I
>> believe we are left with just the stream ID in bypass mode - which is
>> definitely an improvement (the display works!)
> =

> Cool. That=E2=80=99s good to know.
> =

>   but not actually a unity
>> mapping of the RMR range. I'm not sure whether it's worth fixing this or
>> not, but I just wanted to point out there's still a need for a driver
>> for the device before the bypass mode is replaced with the unity mapping.
> =

> I am not sure either. My idea was we will have bypass STE setup for all d=
evices
> with RMR initially and when the corresponding driver takes over(if that h=
appens)
> we will have the unity mapping setup properly for the RMR regions. And fo=
r cases
> like the above, it will remain in the bypass mode.
> =

> Do you see any problem(security?) if the dev streams remain in bypass mod=
e for
> this dev? Or is it possible to have a stub driver for this dev, so that w=
e will have
> the probe/attach invoked and everything will fall in place?

The downside is that if a driver never binds to that device, it remains =

bypassed. If some other externally-controlled malicious device could =

manage to spoof that device's requester ID, that could potentially be =

exploited.

> TBH, I haven't looked into creating a temp domain for these types of the =
devices
> and also not sure how we benefit from that compared to the STE bypass mod=
e.

That said, setting up temporary translation contexts that ensure any =

access can *only* be to RMR regions until a driver takes over is an =

awful lot more work. I'm inclined to be pragmatic here and say we should =

get things working at all with the simple bypass STE/S2CR method, then =

look at adding the higher-security effort on top.

Right now systems that need this are either broken (but effectively =

secure) or using default bypass with SMMUv2. People who prefer to =

maintain security over functionality in the interim can maintain that =

status quo by simply continuing to not describe any RMRs.

Robin.
--===============2759639477141533369==--

