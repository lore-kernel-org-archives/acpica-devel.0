Content-Type: multipart/mixed; boundary="===============5479078094505284510=="
MIME-Version: 1.0
From: Hanjun Guo <hanjun.guo at linaro.org>
Subject: Re: [Devel] [v6 2/3] iommu/arm-smmu-v3: Add workaround for Cavium
 ThunderX2 erratum #74
Date: Tue, 06 Jun 2017 17:38:37 +0800
Message-ID: <9ab6fba9-5270-a618-d149-2e4c11d4cbf6@linaro.org>
In-Reply-To: 5FC3163CFD30C246ABAA99954A238FA838351762@FRAEML521-MBX.china.huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5479078094505284510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2017/5/17 18:13, Shameerali Kolothum Thodi wrote:
>>   #ifdef CONFIG_ACPI
>> +static void acpi_smmu_get_options(u32 model, struct arm_smmu_device
>> +*smmu) {
>> +	if (model =3D=3D ACPI_IORT_SMMU_CAVIUM_CN99XX)
>> +		smmu->options |=3D ARM_SMMU_OPT_PAGE0_REGS_ONLY;
 >
> HiSIlicon hip06/07 boards have a similar existing option to enable,
> ARM_SMMU_OPT_SKIP_PREFETCH. I have just sent out a similar patch to enable
> It-" [PATCH] iommu/arm-smmu-v3: Enable ACPI based HiSilicon CMD_PREFETCH
>   quirk(erratum 161010701)".  May be it can be merged here, if this serie=
s goes through.
>   Not sure about the protocol though.

I think you can add a patch on top of Geetha's, and clarify
the dependency in the change log, then it will be easy for
maintainer to apply.

Thanks
Hanjun

--===============5479078094505284510==--

