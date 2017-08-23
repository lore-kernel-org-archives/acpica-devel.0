Content-Type: multipart/mixed; boundary="===============6845773924116998767=="
MIME-Version: 1.0
From: John Garry <john.garry at huawei.com>
Subject: Re: [Devel] [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based
 HiSilicon erratum 161010801
Date: Wed, 23 Aug 2017 15:29:46 +0100
Message-ID: <77b6c97f-f2d2-fd14-e83e-345addc5ea71@huawei.com>
In-Reply-To: 20170823132430.GB634@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6845773924116998767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 23/08/2017 14:24, Will Deacon wrote:
> On Wed, Aug 23, 2017 at 02:17:24PM +0100, John Garry wrote:
>>>>> Signed-off-by: Shameer Kolothum
>>>> <shameerali.kolothum.thodi(a)huawei.com>
>>>>> ---
>>>>> drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++-----
>>>>> 1 file changed, 22 insertions(+), 5 deletions(-)
>>>>
>>>> Please can you also add a devicetree binding with corresponding
>>>> documentation to enable this workaround on non-ACPI based systems too?
>>>> It should be straightforward if you update the arm_smmu_options table.
>>>
>>> As I mentioned before, devicetree was a lower priority and we would def=
initely
>>> submit patch to support that. Even if we update the arm_smmu_options ta=
ble
>>> with DT binding, the generic function to retrieve the MSI address regio=
ns only
>>> works on ACPI/IORT case now.
>>>
>>
>> Hi Will,
>>
>> Can you confirm your stance on supporting this workaround for DT as well=
 as
>> ACPI?
>>
>> For us, we now only "officially" support ACPI FW, and DT support at this
>> point is patchy/limited. To me, adding DT support is just more errata
>> workaround code to maintain with little useful gain.
>
> I basically don't like the idea of a driver that only works for one of
> ACPI or DT yet claims to support both. I'm less fussed about functionality
> differences (feature X is only available with firmware Y), but not working
> around a hardware erratum that we know about is just lazy.
>
> So I'd prefer that we handle this in both cases, or blacklist affected
> devices when booting with DT. Continuing as though there isn't an erratum
> is the worst thing we can do.

OK, seems reasonable.

We would consider blacklisting the device, where/how to do is the question.

So the errata is in the GICv3 ITS/PCI host controller, and we just use =

the in-between SMMU (driver) to provide the workaround. So my initial =

impression is that the PCI host controller would have to be blacklisted =

IFF behind an IOMMU for DT firmware in pcie-hisi.c or pci quirks =

framework. How does it sound?

Please also note that in our SoC we have other devices behind the same =

SMMU, like storage controller, which are not affected or related to the =

Errata.

BTW, ignoring DT support, are you happy with this patchset?

Regards,
John

>
> Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo(a)vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> .
>



--===============6845773924116998767==--

