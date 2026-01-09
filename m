Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E3135FF4A
	for <acpica-devel@lists.linux.dev>; Fri,  9 Jan 2026 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969451; cv=none; b=FM8+yZN6spYs1YnnXMEaDFwPY2ZWF3hkB8jIipIebGyg/TnPDO1lO+Cx8GeP/7g4FiU88+geXx8xtNxGM79BQ3YzeYNq5DJSwAT7WPzY7CZ8I2iJR20NS/P6MgScA924Vh+grnFT0U5VkbgRHUSB1i+K8Lk4vDijRG06Duq+8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969451; c=relaxed/simple;
	bh=dsYdNgsl+vlBqYNhq51V/s6LnUw3bm0i40vFYzGlwMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I10wiPJINenlD7jrwWJ+123ue1a8MorKY0U0MiQcidBnfroboLwpeEfSWsYk2t+cNCOSddr9yo9ImSyo9d8crak1K0zI+zF8WM5rkqb3O8LXgBUPEfe4+8kurNvFT9dV+q9wX9qRJ1HxPkM9+/mfaJOeYIpcRkGr+jo1M45gy8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mTGzVf2n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vpui/Mrk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mTGzVf2n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vpui/Mrk"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6098Seoh3727823
	for <acpica-devel@lists.linux.dev>; Fri, 9 Jan 2026 14:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=+ysgsKTq/m9T0qhX5590PZF3RQ4Mh0B8PnSQRpVzqAQ=; b=mT
	GzVf2nDhMw4o6/3HLd/DbZ7cczaTSnz2ZaiG/2pJV6UDzpW3OqY1qBbje3xrOi8R
	8ByOpa44LCArRRWtS1jP3uWpgU9alL3VBNqfyRH5N9YdeYovPczZpjSAsH1PvITI
	MA1mzUkPdDqNiwMaL6upiKH3H8/LsqiJERwe2xVyKracA7mMoZQMknrCqXRc2Crb
	/Lr/SMIWfcRgD8XUz7emNhMQ4wyopgqnF0z2Ynk6zeXhzz8iFZr+M+Ydn7Z6EIN5
	aTDv3ERyfgeBQn7tRQ+AEwJWL3opQf8xboU9aNpHtgBI2uUSb+4TDEeD5iuPWNrh
	QOnnVaxSk40hAztYMxGw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjpmkjcep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 14:37:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8bb3a245d0cso1052994785a.2
        for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 06:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767969446; x=1768574246; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+ysgsKTq/m9T0qhX5590PZF3RQ4Mh0B8PnSQRpVzqAQ=;
        b=Vpui/MrkypmFSdC+hR4oQYrEC59zgqbanxxvTGYMWtEx30pDFaW4LUZ20u4g3lenKF
         cr3wSf0lAvUb0Oc/LHMgpUbNrNvug8XjbAF7RpcIuxNlBdvESOxznWmpl15FrQDDz5vP
         rX2s0DR9pUwsDTTFlmbZnb37NS2QaCY1MZ0CjWMJXANCSR0C2Asq+cZrihA0OrxQaiG8
         duxvsVu9tO1rOgh//bV8kHet+dq6rkICL8HUL0Zz8uu0cFOPYRjU1N87IbcYaKBfUk1l
         ncSwfFRiC6L6VxBe8d5diLeGUnzJkVuNXX9QhpCxxsTjIxL4Vaxsj1IdciIYwnX0iVbX
         DWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767969446; x=1768574246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ysgsKTq/m9T0qhX5590PZF3RQ4Mh0B8PnSQRpVzqAQ=;
        b=wcuC/eGMrdmZAV1wmazYGQLQpKmyb6l7Tn6Fmu1tRGDvVODiZBlWF+DjBTP7LG2oCE
         f4m65YrrnNgivH7Xy3vWZPXshZ+QJnwJCsotZTO8RLbxPJubMtoE+Ql2Apsw7PyIgm6c
         DC/XLxqg5vwgb+mzCCERlfSA2FtAkezqAAQ8fSyWAM+UrtmonEQpdcCXVZM39Z1fWspU
         vYycsuKzfLT65u4KeGsv4ltz8hasoVHxvHQiMVN5ZsPj7xDepLv5j0e1XNSjwNiJwmzJ
         4BcQ2HpzA8p+sGemwNoEz9BSi4rlwZAwGSyNeHWkYmloq1AJMXdO4MSAyrCbd5pzkoee
         /XzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSsCmygVv4ntzlz5aJeG5+6BvMTkRE2cCvsBL+M37VcO/j4/7BcIEj5rSwWNTs4tyPbuLRsNkco+vMlow=@lists.linux.dev
X-Gm-Message-State: AOJu0YyBNcXGfJ+QgcMRPjBdiksTPFT9Y8MBmwlY8t3n+yuRV7geqPkR
	UcDnpd2AAbl8GpkVer1DdruN6xaxfx3Gz08qY/L9yfbJxeAe0T1JQo0KWF7F+zgy9uO7C4Dbjh2
	GPOLeSWcXvD69+KrFIyfkiInI0Unhfvto2VqmY6/YbUj9Vq7B4s9zitIHun/C4rmq5uakjoGn+V
	NS3wCcqVVxcFyydWaHNDKWlWSfNLHjDn1yvbwJMqvXVw==
X-Gm-Gg: AY/fxX6l5Qma86Iz9kiMl2jGijVGkDshfs319wK6tQd+cnhuwwX0TyIwR5JX8aUDb/S
	hVgsn/2UFvWIcbDMZzFur22DeXe5c3HqyhOheKYd4czPrA9PEzcj8mbzd6igiCup5XVz7ofSLPd
	B2B3L7dOVwaw6CQjBAhfz8Dp7/iHhD5wjW2nQZPPCx+L8b36q8peoeNW+fuXVnyovoJiY=
X-Received: by 2002:a05:620a:318a:b0:85e:24c3:a612 with SMTP id af79cd13be357-8c3893b2c4emr1367492085a.32.1767969446151;
        Fri, 09 Jan 2026 06:37:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5/7nOlDZo5viCDFcqB59VO553vPiFD2t5yij1MhIo9Az81+Uf2uPVbDkTkMomisRCSbRk6+fPaS1p9QPc/VM=
X-Received: by 2002:a05:620a:318a:b0:85e:24c3:a612 with SMTP id
 af79cd13be357-8c3893b2c4emr1367486685a.32.1767969445611; Fri, 09 Jan 2026
 06:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com> <20260109090224.3105465-3-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260109090224.3105465-3-himanshu.chauhan@oss.qualcomm.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 20:07:14 +0530
X-Gm-Features: AZwV_Qi5BjfSLxD-fWr--rIzTe5eMh_UeAHuI8CxS4Y_6Lnfr3xI3R8vXnjfma0
Message-ID: <CAB19ukHDigCSgubLBxq0Pq6XuOfg3gEM7TWse3sNH4EkqqAcGw@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] riscv: Define arch_apei_get_mem_attribute for RISC-V
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
X-Authority-Analysis: v=2.4 cv=YNiSCBGx c=1 sm=1 tr=0 ts=696112a7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=lVw1crRH7-GITBzhd7oA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: X4T7JVsI1wOnZOtddc9YRkyFvEHs8Z1A
X-Proofpoint-ORIG-GUID: X4T7JVsI1wOnZOtddc9YRkyFvEHs8Z1A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDEwOSBTYWx0ZWRfX3kjKfQ5wRNcY
 yk1dBb8Q7SKArPsenTG8XinGowx4mGcDmHnQyrf1PfjJTreq7lr41FthZ/jbeVP2xy0AvqZgyNh
 eSybrEugR4uWUM3e2UaLE9WRYjTNg+mGib6Pr0yPGNXRTmDHA38aAwkBF/l8I91Ww2M3ox4zdc9
 kYCU/LWREfSj2sidz4Iyam0guBkrE5QBSN83LvuTa4xaJAhsuXXv138XjmiHlleqhvqtpuPSwHu
 BagUQ7dFa5u1NnwmWSDO+ihuxXNQOeyjwjTFdopDQyC2D2dNPb14zYFRMvu1f6oVrPUklTYyVKa
 67ZdNaVkW/7zBaYOPlB2OcErO7yvCvAiFW5qmfpJ2cAxHYq4E1cmXx0y1Rj55VSjRnOrPxM5EAA
 9ENfHEWVkhqzx/MYJtfJKvnWfObNeg0LWGfQ9eTQD6xQeFVHZFkTpgyIxFMH/NmiS3UXeOkMsYX
 Yr/uhCFIRpbIrVjo3bA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090109

Hi Himanshu,

On Fri, Jan 9, 2026 at 2:32=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> ghes_map function uses arch_apei_get_mem_attribute to get the
> protection bits for a given physical address. These protection
> bits are then used to map the physical address.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  arch/riscv/include/asm/acpi.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.=
h
> index 6e13695120bc..0c599452ef48 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -27,6 +27,26 @@ extern int acpi_disabled;
>  extern int acpi_noirq;
>  extern int acpi_pci_disabled;
>
> +#ifdef CONFIG_ACPI_APEI
> +/*
> + * acpi_disable_cmcff is used in drivers/acpi/apei/hest.c for disabling
> + * IA-32 Architecture Corrected Machine Check (CMC) Firmware-First mode
> + * with a kernel command line parameter "acpi=3Dnocmcoff". But we don't
> + * have this IA-32 specific feature on ARM64, this definition is only
> + * for compatibility.
> + */
This comment needs to be updated.

> +#define acpi_disable_cmcff 1
> +static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
> +{
> +       /*
> +        * Until we have a way to look for EFI memory attributes.
> +        */
I am not sure I understand this comment. We should be able to get the
attributes of the EFI memory regions. Do you mean the memory region
attribute will be the same and currently don't support non-cacheable?

> +       return PAGE_KERNEL;
> +}
> +#else /* CONFIG_ACPI_APEI */
> +#define acpi_disable_cmcff 0
Why is this change required?

Regards,
Sunil
