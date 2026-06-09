Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E4B3E92BD
	for <acpica-devel@lists.linux.dev>; Tue,  9 Jun 2026 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992129; cv=pass; b=VxpUpSqrf9aJkFkjOPNZyfennjBjKvzvD0ccUbjiCYdbbgdRIDGgVI7nTKyn7pHSKRMcscG8d4Skw9Yz4mZy8IYeGPrgWEB/mQfPbm24VVQaUL9EVLdYmTBP4u+RjZqLsGfAc5ZHz/vqTXxO9QnLD5DOV55U2QuipVbRTNGSNq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992129; c=relaxed/simple;
	bh=+1EOZR2wB1otcZ/6xEuFv8g9neuOi9MSaHh/ECdDfgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3L4N857uPcVdVdksBvm+/ACNGRIuCYQMKbEQadL2JHGcBATpijCFQoFTX2IID6gxOntmsr+dE6JkWsnXoBrj1D/m/dR90hXt6NpOl+cwtvCMNdlZHQKgvYyKKjucv8mBY8Y6hToY9hQ+c9PV2oD7wD3CEHIyCYKIXyOcbk6xQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L46jW91n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bEoRwJTf; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L46jW91n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bEoRwJTf"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rfm52026030
	for <acpica-devel@lists.linux.dev>; Tue, 9 Jun 2026 08:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=ppbxYWmUe+n14dBjJKXE7EunGdgOizVvORmJjhi9sIQ=; b=L4
	6jW91n3danqpMZpLno/pXbgGWSanIfmO9hon068Tpnm9qha7YtcdgtUzxQJoyeYg
	RWTBu5aL53Flz1LEpv5Rygv6Q2Ra30dpOwmmC2GHNZ1pb/hVJCVKGKbhKYN0RNra
	CUenh4IG4t2Fe+PdEeZ1oZZ3R1Ve2CtA/UVCtAYCrbsuuoI2FmP/S+7rdgETGz/j
	7KksS3/qVrZX8vSzYARaeFDUe3TgFThzKaUGNMWM2DJOCJUOD6PyC3W+h0x6cgPj
	hE9I05HmCv/r0kpqpEb9uvq81wreomdAmQZhnkgVanDQ3qc4qw6tGaLprPO7dZXB
	U6X/A5CsUnA3KoCQID7g==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun8n6rv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Tue, 09 Jun 2026 08:02:06 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7ebbaaf1679so102779737b3.0
        for <acpica-devel@lists.linux.dev>; Tue, 09 Jun 2026 01:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780992126; cv=none;
        d=google.com; s=arc-20240605;
        b=Q3Pc/EOv0K2+gxkAOYbU561KVyXkf49NJjiVviDSX4BmpZSulIaPDsFNpCCvTIGZoX
         LFf5iUii9GHCl6nwfYVoUJPR/Fcs/UEFE5NRMo8tktXfYPgfXAnMl41zdSIZhQIe7ryi
         19yyVQx+vZ4rdySWxqYTJjSG/HwPnh3+WGMYWtYYVgSX5r9HU+Mpu+TpAyRTwcxd1ftK
         yS+ceCExniBiTCFA12dIJkrtZpCU8TFTq7o9MClsGsXxoJ6MQYYXO2ReSzpavsU3BcE3
         qUwdbMmEyPPcnfJEIraonEjrIXhTGK5/z3FPgX6cNaWQBbCRL3HYxMX1AWRVk6OZRGib
         +wTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=ppbxYWmUe+n14dBjJKXE7EunGdgOizVvORmJjhi9sIQ=;
        fh=1VP7isPggPaZvvgihYTj/ibRzcjNfjWgcc/94rrS8jU=;
        b=IUI9AA0pKPuNjrfQ0v207nC1KfSdn2Jq8w6evQt2ZYs+6zjFL4LfIf/g6wJDJsqs6i
         dXeHEJTfauvBUyaxGUANDAhOglDFc+HWfqPyYqlujwoNBbe0NbU6SjPh+JFxU4Adv5DB
         9ZpYCUO8IJ5sC4HsMC9gouKjvtpxjF+OPkus/uv4wkrp4KeKmtXbo+OTMLX0rSrpFmS5
         eeSmV/bD+olBX0Ejf4P4DXbRCiCQq6FzJ5oyiqC9DD7O8CTNW2daBNp7qxwx9Jietk5Q
         KhoQ4CrBi9cQuh11dFwO35EgtTFUVG1HzRGP1zvTLJVhRgInB1EO4eu7DnUcJlJsg27W
         eGQQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780992126; x=1781596926; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ppbxYWmUe+n14dBjJKXE7EunGdgOizVvORmJjhi9sIQ=;
        b=bEoRwJTfSw+7REK8qA9zAAcdh+lKjG6cu8KFRtDv3Uaoap2M2/UdqlVD7/+GbHfiE3
         gByTIOayCJq5UbllH9htpcK8Fs9w1yLziP57lyHpxWKqC0pbf72UMr6Bg13bM5401h7W
         Rg4BLalMeWzckToWf8dn8nCXfipg3QcnXwqs5Ve1KKKLANIrPEiv14MiBbMXu2jCxsD2
         WnvHWzzJJU5QNL0ke7F/6r60fHcZDFngljjk/D5TAV1LLKvYWo1DG95v3toVsLAlyJfn
         TpabkVunAlsm3mKem+Mnd7Z6oEFiBI3E3F40cpLr8WDnLNx+KHxWaVtyfes2bGkhG1HR
         VKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780992126; x=1781596926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppbxYWmUe+n14dBjJKXE7EunGdgOizVvORmJjhi9sIQ=;
        b=DsmANAWGWcdTeemeh/4V8W27CIn6qxNEEbKopnZAG7FFJTEdNePWM/I4s2M7YLOrSA
         MW93pVOhDBDs40lY1Gm7LhE8VST73ob3Mhr71+PZW04K9UP2aRTdxbyi6nINSH8CONpf
         9HZ8rtdaJvDtGJOPO38RB7XA+cuDqcyrhzYEMCEANUkHNIyTapbOQ9KNoUyZEdYIRkDX
         hILCxPHT6ULk3cuCLSPgYY1/3Ait5BczvUMYz2SeONiI7fSZmhBO/8ymnJhm6kSWJlEe
         W/n3nirkleEsL0T4xlN6PVd3/M+AOTvGOrNAUn2KiiDTbAi+obivfzBoPm8tWHKs9EBb
         GDUg==
X-Forwarded-Encrypted: i=1; AFNElJ/yFzlRgybWnH0MzpA2XihZZn5ijwB/X8AtP/d0mmWZ8kQH09aaqtQAaTdtDw5oTLoB3GGQHUEyTTiXt8E=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxo8LRaaOCrBETf6fziio9DBY/6HDIiGFEqfBX1JhfoAGav5YhC
	ts3C+XTJqZjY8iqa5diYwIInRpag/V5Nz+m4IhqtaahaU2t1FhakOkspkDHlYAC7Qaf+JQaPz0Q
	uR4gFW1X6+DgVzKOp/T2RZYPNFFQ4K8q/nnJexoHtihZqSw5O6W4vcVijnWuHk6NLma5YbVRy2w
	h/h+DRo5Um/UNFyuMf1S/OwwLmbB3KAEM6F03loIYzsA==
X-Gm-Gg: Acq92OGg5d1EncpAtoWOyKtWo2I+erCwa2qNMhCHAqxQ3LgKq/csa+pbyGdPOdJ728+
	Yr0A/qRJ5mCgwAyOZ7nx9J+x2n43fVX9be5MEiVMsFsI65me19d+SC+NCuHoTrTk1amAWurFAnp
	ETQ+5TV0hZKrbjilfCqv6e0OeWP30HsTRUBykmDYfNTCk7hL382aSoZB00FiPsOE9kDtVk6X350
	3SbTJe2zkrR4vDzCg==
X-Received: by 2002:a05:690e:4144:b0:660:a653:4495 with SMTP id 956f58d0204a3-66106e01386mr16440746d50.4.1780992126064;
        Tue, 09 Jun 2026 01:02:06 -0700 (PDT)
X-Received: by 2002:a05:690e:4144:b0:660:a653:4495 with SMTP id
 956f58d0204a3-66106e01386mr16440721d50.4.1780992125662; Tue, 09 Jun 2026
 01:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com> <20260513084325.2176952-3-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260513084325.2176952-3-himanshu.chauhan@oss.qualcomm.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 13:31:54 +0530
X-Gm-Features: AVVi8Cdab09nLFiWsiig7vANHBJNBVR0v6HSRzUvHph-SxzBxVhm2UenvmNafPY
Message-ID: <CAB19ukExADA6W1pXDqVdA13BGLrtbG1nkfNKVwKyCd4yrNtdMg@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] riscv: Define arch_apei_get_mem_attribute for RISC-V
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com,
        anup.patel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NSBTYWx0ZWRfX4CTA/xfWjZNB
 IK3a9aSE7Kf5GVD4l/4Q87rzcgsC69Dt89yaU2mG1ctHxe6ygbbloxNYmMbcDr0p/Jf5/DsTyc5
 oyFktYlr0r6W7KuQmbqJci4ocClRaU6y3zJ6/jLLhr75Lkjh/aidmrSPIIko8TXj1Xn5VVdT7R5
 3DrIP3Baxa90WdunpcqMp4djkOKM5cgTpC8jQizMsMuq0iWHKUgwHfwRa0PpO7oaN5FYMFjqvYp
 Ua5of+47bOkS0sTtK6rSHkmtSlo/HLAXRw52pPTv9JMm1VTV7SG5WhMFXe3r7EUbvywJ8byTKIY
 0PQRtAiZmZew3fccd3hyuLPluU5d2MLX7VLjNNGwxOOrPd2ViQDhafP+9jTbAI1b0P0e/UIyzrV
 C6Jlot9JzkXl//dlq9Hw1xevjomhp56t5AMbUR57MuuB1hVco73pww9afUEXSjSBbkEbfIT/7X1
 GvI5Mx5NM9bYTn21BGA==
X-Proofpoint-ORIG-GUID: xp37se-TES9lhhIsbNCl4IVQSK_ypTnq
X-Proofpoint-GUID: xp37se-TES9lhhIsbNCl4IVQSK_ypTnq
X-Authority-Analysis: v=2.4 cv=Z7rc2nRA c=1 sm=1 tr=0 ts=6a27c87e cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=lDU5pCILgqd7k7drH44A:9
 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090075

On Wed, May 13, 2026 at 2:13=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> ghes_map function uses arch_apei_get_mem_attribute to get the
> protection bits for a given physical address. These protection
> bits are then used to map the physical address.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  arch/riscv/include/asm/acpi.h | 16 ++++++++++++++++
>  arch/riscv/kernel/acpi.c      | 12 ++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.=
h
> index 26ab37c171bc..c142db9f81a7 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -14,6 +14,7 @@
>
>  /* Basic configuration for ACPI */
>  #ifdef CONFIG_ACPI
> +pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
>
>  typedef u64 phys_cpuid_t;
>  #define PHYS_CPUID_INVALID INVALID_HARTID
> @@ -27,6 +28,21 @@ extern int acpi_disabled;
>  extern int acpi_noirq;
>  extern int acpi_pci_disabled;
>
> +#ifdef CONFIG_ACPI_APEI
> +/*
> + * acpi_disable_cmcff to disable IA-32 Corrected Machine Check (CMC)
> + * Firmware-First mode. It is not required in RISC-V architecture
> + * and is present for compatibility
> + */
> +#define acpi_disable_cmcff 1
> +static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
> +{
> +       return  __acpi_get_mem_attribute(addr);
> +}
> +#else /* CONFIG_ACPI_APEI */
> +#define acpi_disable_cmcff 0
> +#endif /* !CONFIG_ACPI_APEI */
> +
>  static inline void disable_acpi(void)
>  {
>         acpi_disabled =3D 1;
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index 068e0b404b6f..7a6770697999 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -204,6 +204,18 @@ struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int =
cpu)
>         return &cpu_madt_rintc[cpu];
>  }
>
> +pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
> +{
> +       u64 attr;
> +
> +       attr =3D efi_mem_attributes(addr);
> +       if (attr & EFI_MEMORY_WB)
> +               return PAGE_KERNEL;
> +       if ((attr & EFI_MEMORY_WC) || (attr & EFI_MEMORY_WT))
> +               return pgprot_writecombine(PAGE_KERNEL);
> +       return PAGE_KERNEL;
> +}
> +
>  /*
>   * __acpi_map_table() will be called before paging_init(), so early_iore=
map()
>   * or early_memremap() should be called here to for ACPI table mapping.
>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
