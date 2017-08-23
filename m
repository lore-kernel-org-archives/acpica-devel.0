Content-Type: multipart/mixed; boundary="===============3613515555437567231=="
MIME-Version: 1.0
From: John Garry <john.garry at huawei.com>
Subject: Re: [Devel] [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based
 HiSilicon erratum 161010801
Date: Wed, 23 Aug 2017 14:17:24 +0100
Message-ID: <c6b7c641-b839-1388-7982-366e796e6ba9@huawei.com>
In-Reply-To: 5FC3163CFD30C246ABAA99954A238FA8383CC287@FRAEML521-MBX.china.huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3613515555437567231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi(a)huawei.com>
>>> ---
>>>  drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++-----
>>>  1 file changed, 22 insertions(+), 5 deletions(-)
>>
>> Please can you also add a devicetree binding with corresponding
>> documentation to enable this workaround on non-ACPI based systems too?
>> It should be straightforward if you update the arm_smmu_options table.
>
> As I mentioned before, devicetree was a lower priority and we would defin=
itely
> submit patch to support that. Even if we update the arm_smmu_options table
> with DT binding, the generic function to retrieve the MSI address regions=
 only
> works on ACPI/IORT case now.
>

Hi Will,

Can you confirm your stance on supporting this workaround for DT as well =

as ACPI?

For us, we now only "officially" support ACPI FW, and DT support at this =

point is patchy/limited. To me, adding DT support is just more errata =

workaround code to maintain with little useful gain.

Thanks very much,
John

> Moreover I am on holidays starting tomorrow, and really appreciate if thi=
s series
> can go through now.
>
> Please let me know.
>
> Thanks,
> Shameer
>
> .
>



--===============3613515555437567231==--

