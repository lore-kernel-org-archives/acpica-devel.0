Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A163A23ED60
	for <acpica-devel@lists.linux.dev>; Wed, 25 Mar 2026 01:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774403336; cv=pass; b=pWtTJ8r/HN5qcnLzOe7JlQvfvfSKFjqD1a5XLjW7oYpsFfUc8GNEodEPaIwKK9lYWV0LsFV05zDWry13CBlSIeCFlftMt+NCgJmCqMLm6h9mZUdBgTUC/5ghi4FqSNmNDsNW3FWTPNlpdnNATaiG7P8IwixPg8HkHF2XBkpR/0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774403336; c=relaxed/simple;
	bh=8j/1RkEqSK8cDEtrMb0SmRPLJt1HSounD9iRf5VcPkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wd9t5jChFcQW+C1gIihyvKPqu0xGdQkXCxEzmwncMdhdpLBJFpSjGekOG78JXJnFDWhz5hCblreyhNEvnXYcAHqvkr+E/1d4NWyJmdq4v2z4puUWTm7in+WSzZXQUR4WsNu5mAWiQVYmvGULlVHcFeU8kSzslCWwP5Bojq3frkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZhOdpcmQ; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZhOdpcmQ"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d9bba96f7dso1551589a34.1
        for <acpica-devel@lists.linux.dev>; Tue, 24 Mar 2026 18:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774403328; cv=none;
        d=google.com; s=arc-20240605;
        b=MAVH/NzJF4Un86n6xuoWga+Vybdtvl9NC7osWuyec3Q6iIQ9CsD793tW7zzHErkMR/
         fKuToUeZZaqyma/VmWytWB08kZLw5KxbyNO/MmHfQfbbK1mIZcqXsGTadqvrYVfsvly8
         tADvQBUYf44mkC6GpfSigM5nc52BxDOULSuDRdAcNKPbA7A4ACCH1r94U5yc5Qcl6ghs
         FBM5/e4Ta7AButzNMxlDEHs4MVCUoFacBjc+BIwoX91KYES0Wkqo1MVG1CPOKVrWGoHj
         TxUb0x25w9P7GuNLejexdc0dHrc/20R6F376MaCo1niUStivZIxcA8RQaRPXOGhWgjeh
         W8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vGfOtY7DNTv8x0CTjSLzY868SkapZdn6D7qzRjb9QRw=;
        fh=JsYy0CpnzbxSg3rZxkkGsVsVSrLE8DTNhyHHpiineQI=;
        b=gsAxACaADiv8V3hRfNPF0747TN+gPpkenurSDTy4aNzsa1vmsVmfFmr6mb7IRApcTx
         SsiVZj3A1miR/6NO77fmTDFM9iL1AvM93O75i2Wq86ySCYCFRwQe5P3WqTLZC4E2Sugn
         TMdM1qNVQvx1pwSBOrbgkngF8wzgDGWixiFAhjUoevY+qFfPhw0cvxvzGY3hz5Dmx6lE
         gmXJW8+IHZIrsiJkToeDTA85ULGLWWYpxe9JkRAcRjS9v30v8p6Owt7oxohBPIbpV65j
         89sqACdQJT3nKloPXnL/hjEfZLxuVF5U0UZEkjPuowtJY/SmnBveeQvPtvuURkkaPwk7
         Scjw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1774403328; x=1775008128; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGfOtY7DNTv8x0CTjSLzY868SkapZdn6D7qzRjb9QRw=;
        b=ZhOdpcmQFJqzk5nz1VB0F0FP7Yh0GT4fdvLiLZa2Eq0QzECqF0QDMREfKlAisgg+AL
         HrBrfNiKvazzxB6S0iKj1H4jE8+HqqLWJmBkGu66pnITnaIppjELmLfFuL3roC2ASTA1
         prxWurx8oYuTHls5WXadk2PZPGPALkmmJcf5go12PSIqncAgoWHkEc5XlP0YeKVU4YVq
         ukYD7M7mIJwx92lLbwhWelZYY6NT8yh8mxdAFNIm2LfuUXOfYjghqD1cQANs9P/v+rax
         n4bitziigpDy0YYROXSgl5MJn33uiAH4LDzdzV+8PpyqaAR0KVWe+H3vUku62YBVbbVu
         15ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774403328; x=1775008128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vGfOtY7DNTv8x0CTjSLzY868SkapZdn6D7qzRjb9QRw=;
        b=EQPxGOfSxAYpTVI4eKNN9nSOKQTkloctIDkyk13sZFSUNU1XY2OOp8ruutIqkkYxi/
         f76Y0t5jFO7miTGWHVN5GS/4TR1bDaWu9ZU3la6o1gGJKkx79thtKDvAveP/Xw/hxD1q
         MYMDzz9DMllnkhsEsUGU93BiF+9U5gozk6eowZtLD2DsXQ2+mRQQmBYmfXwrpA6+xZeZ
         msc7L20WYdxz2r4mwDjsrt3EmzcpM8PIa3QwS57b40KMrdV9oRLSY+OMMPuCj6lN9mUd
         1wIiIxm+H5uG1RJSOT02o6PeTCUyrMOEoBigf8UD2y5Ud680Ery24u5CPtl3V2ra5jfT
         7FEA==
X-Forwarded-Encrypted: i=1; AJvYcCWsq8MCOBsiRrN2kX/qnmLTBWRZWg0orx80rOnfsQpdr/TTHpAUFw/wZPvVicguipid3arc9S4931TipYY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+BoJQGtAv8NDsIsxpT8e2fBLgFrQ3mQ1LOyRhjTVLQAoEbsFw
	P4RuwF1K8Ys15sWCSDHGkiR86X/Ln9z9u0IRgCzgQ7imyBcjVq+ioH4kLRpWJPmwl390wfQT+AJ
	Lg1IJsivIbB4TzGiqhK+WPzJ5NuXnMcLVtZppzsH6Yw==
X-Gm-Gg: ATEYQzygjBVbCvhsvOWWNBNWTBrVB8BgdGjGzsYwUhuV5sZdw0C8OBN2ohIRavvCqgd
	kzCwXkSz9iV4ltrAY+DZyquYkNQ3AFhaGDIosta3tghG88+Iu3O3MZsX6uxudShVx6bBVKEBvpm
	h+WrlSXFUW/FOamWxgTtb5HK2aezsdYELNAUigwY+NDfv1W2EvSYnuDyUSiBETJnpz9/jmkx/Zo
	VfIRT98MbcG7DOgRfbIXFLcVtaBe1ZPwy0iKSgk4SdzNir8Blt8/I8F9s3P8/h6SM1N/rLextzb
	ecMKmlM6JcrKbw==
X-Received: by 2002:a05:6830:44a4:b0:7d7:cb13:3fe9 with SMTP id
 46e09a7af769-7d9d66ebce6mr746710a34.19.1774403328448; Tue, 24 Mar 2026
 18:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org> <20260128-ssqosid-cbqri-v2-14-dca586b091b9@kernel.org>
In-Reply-To: <20260128-ssqosid-cbqri-v2-14-dca586b091b9@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 25 Mar 2026 09:48:37 +0800
X-Gm-Features: AaiRm50a2XpCtEI0EunEN7ujOM94GRAQRhXw7yAPEIMaeAZSdyGXWlKvSXA68yk
Message-ID: <CAEEQ3wnhvV03FYfqBqz8ihyFCcxKS5ztdvCHDF789ubSQAMw1A@mail.gmail.com>
Subject: Re: [External] [PATCH RFC v2 14/17] include: acpi: actbl2: Add
 structs for RQSC table
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Adrien Ricciardi <aricciardi@baylibre.com>, 
	Nicolas Pitre <npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
	Atish Patra <atish.patra@linux.dev>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
	Chen Pei <cp0613@linux.alibaba.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Weiwei Li <liwei1518@gmail.com>, guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
	Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Peter Newman <peternewman@google.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, 
	Ben Horgan <ben.horgan@arm.com>, Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org, 
	Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Drew,

On Thu, Jan 29, 2026 at 4:28=E2=80=AFAM Drew Fustini <fustini@kernel.org> w=
rote:
>
> Add structs for the RQSC table which describes the properties of the
> RISC-V QoS controllers (CBQRI) in the system. The table also describes
> the topological arrangement of the QoS controllers and resources in the
> system. The topology is expressed in terms of the location of the
> resources within the system and the relation between the QoS Controller
> and the resource it manages.
>
> Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> Link: https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/chapter2.=
adoc
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  include/acpi/actbl2.h | 92 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 92 insertions(+)
>
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index f726bce3eb84..7367990349ee 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -53,6 +53,7 @@
>  #define ACPI_SIG_RGRT           "RGRT" /* Regulatory Graphics Resource T=
able */
>  #define ACPI_SIG_RHCT           "RHCT" /* RISC-V Hart Capabilities Table=
 */
>  #define ACPI_SIG_RIMT           "RIMT" /* RISC-V IO Mapping Table */
> +#define ACPI_SIG_RQSC           "RQSC" /* RISC-V RISC-V Quality of Servi=
ce Controller */
>  #define ACPI_SIG_SBST           "SBST" /* Smart Battery Specification Ta=
ble */
>  #define ACPI_SIG_SDEI           "SDEI" /* Software Delegated Exception I=
nterface Table */
>  #define ACPI_SIG_SDEV           "SDEV" /* Secure Devices table */
> @@ -3165,6 +3166,97 @@ enum acpi_rgrt_image_type {
>         ACPI_RGRT_TYPE_RESERVED =3D 2     /* 2 and greater are reserved *=
/
>  };
>
> +/***********************************************************************=
********
> + *
> + * RQSC - RISC-V Quality of Service Controller
> + *        Version 1
> + *
> + ***********************************************************************=
*******/
> +
> +struct acpi_table_rqsc_fields_res {
> +       u8 type;        // 1
> +       u8 resv;        // 1
> +       u16 length;     // 2
> +       u16 flags;      // 2
> +       u8 resv2;       // 1
> +       u8 id_type;     // 1
> +       u64 id1;        // 8
> +       u32 id2;        // 4
> +};
> +
> +struct acpi_table_rqsc_fields {
> +       u8 type;        //  1
> +       u8 resv;        //  1
> +       u16 length;     //  2
> +       u32 reg[3];     // 12
> +       u32 rcid;       //  4
> +       u32 mcid;       //  4

The spec appears to specify a length of 2 bytes for this field?


> +       u16 flags;      //  2
> +       u16 nres;       //  2
> +       struct acpi_table_rqsc_fields_res res; // 20
> +};
> +
> +struct acpi_table_rqsc {
> +       struct acpi_table_header header;        /* Common ACPI table head=
er */
> +       u32 num;
> +       struct acpi_table_rqsc_fields f[6];
> +};
> +
> +/* RQSC Flags */
> +#define ACPI_RQSC_TIMER_CANNOT_WAKEUP_CPU       (1)
> +
> +/*
> + * RQSC subtables
> + */
> +struct acpi_rqsc_node_header {
> +       u16 type;
> +       u16 length;
> +       u16 revision;
> +};
> +
> +/* Values for RQSC subtable Type above */
> +enum acpi_rqsc_node_type {
> +       ACPI_RQSC_NODE_TYPE_ISA_STRING =3D 0x0000,
> +       ACPI_RQSC_NODE_TYPE_CMO =3D 0x0001,
> +       ACPI_RQSC_NODE_TYPE_MMU =3D 0x0002,
> +       ACPI_RQSC_NODE_TYPE_RESERVED =3D 0x0003,
> +       ACPI_RQSC_NODE_TYPE_HART_INFO =3D 0xFFFF,
> +};
> +
> +/*
> + * RQSC node specific subtables
> + */
> +
> +/* ISA string node structure */
> +struct acpi_rqsc_isa_string {
> +       u16 isa_length;
> +       char isa[];
> +};
> +
> +struct acpi_rqsc_cmo_node {
> +       u8 reserved;            /* Must be zero */
> +       u8 cbom_size;           /* CBOM size in powerof 2 */
> +       u8 cbop_size;           /* CBOP size in powerof 2 */
> +       u8 cboz_size;           /* CBOZ size in powerof 2 */
> +};
> +
> +struct acpi_rqsc_mmu_node {
> +       u8 reserved;            /* Must be zero */
> +       u8 mmu_type;            /* Virtual Address Scheme */
> +};
> +
> +enum acpi_rqsc_mmu_type {
> +       ACPI_RQSC_MMU_TYPE_SV39 =3D 0,
> +       ACPI_RQSC_MMU_TYPE_SV48 =3D 1,
> +       ACPI__MMU_TYPE_SV57 =3D 2
> +};
> +
> +/* Hart Info node structure */
> +struct acpi_rqsc_hart_info {
> +       u16 num_offsets;
> +       u32 uid;                /* ACPI processor UID */
> +};
> +
>  /***********************************************************************=
********
>   *
>   * RHCT - RISC-V Hart Capabilities Table
>
> --
> 2.43.0
>

Thanks,
Yunhui
