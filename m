Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D181A6811
	for <acpica-devel@lists.linux.dev>; Wed, 25 Mar 2026 01:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774403004; cv=pass; b=TKlUCLBxOqEC6AlLgatLgpox7cIkKJuDfgptiJZECwwvOMXGToX6PlJnUWxuTOOmZloQQ2nelMijyIxbS8/fpqfZ8eSOlViP0arR/psfP4girubnihzebwruXm1oetLcLJlCfYClJoWX1ld+AJhD18zbwgRdvV2+H/4jlLYq78I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774403004; c=relaxed/simple;
	bh=7Z+kIRVbQ7WV37i1YmClsJWUkbW+slAO1Y2IpTQEZ3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqPYtF7+kXtk3fLfgBD8tz4B1Ul9SUCUdBFpu2w8Z2AUyS002OUDpsQcYHcy7t+GMJ2kGzFzkSkTP4Ltiar+PU0hD2QI45jg2BmC5ej5Q1qbCCtJgsn5saThCSjFd8/BKBGNgumhwNbhGq8yex6lIqobxgShpko9jBiYPYZ5HU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D80QoUYi; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D80QoUYi"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-466ec4c6852so966055b6e.3
        for <acpica-devel@lists.linux.dev>; Tue, 24 Mar 2026 18:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774402998; cv=none;
        d=google.com; s=arc-20240605;
        b=DfV2C9P98yzmx5TBzi5T5QoZeWNfx60wFh+6tTWXeNwdjicfeNoV0nTA8V+/oUI83P
         BpFuV/6t3EtXyVPrIS+jAWbF7dPFmsmItIoIuWSX59lJbioqkTfrni8ELRxRQWdVR5nq
         V/UdF3xTrbDo8uojIZvHkl0gaK8XkoKA0y1bUXa1cKxefScK5mXTrbewXvCHwauJK93g
         ThMoe/fLivvRgAbbn3Xvws5G6tpsqKvj7OLqQEX89C7+ATpx6BaDFGzEN20vjuSVVYHs
         1tbzaLTYw+SZDS9YdE+/pANa1bH0tS87Zu5ehLmtn1ju19I1SG23bawpYYhobJo1ntlW
         MYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BVjPu0rHHBy1UzY463CDPxiXdA8El4sI25AORgmrANA=;
        fh=KkW2moKMmtvDZ0gl2JcJcxlZn6y4umtzC+fd+55rHY4=;
        b=ODt3Fu/7oJBymJRqE/QSda5iy5bziwqzupUD1HNRnlrbmDftY3z8Pgh4tWUISfxdUB
         WWoRmD1nFL6W1TXeBojoeWlYZ3Nj26GfZseAYnPC2oE33GetW5BN+ofuhOeGjwM1oRM5
         qJ3wM5DM8XzeJs0K+aaCnTw9y9RDZ3vVQXOYULx+ltTnsdScn9fQrKERYzOx2IzRV7M9
         nyn5509ptS/wpNTtEXI24FlMOXx7WZ7U4+OOChpYTiLhErF7MjV4ux6kk49O1Tss71oz
         DWYw4SLCHsuWL4aYKeG4XVNVCqze5puFCyuwjml49pS5EGWcTFbbR93AlQUVBBMj2fxj
         8iQg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1774402998; x=1775007798; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVjPu0rHHBy1UzY463CDPxiXdA8El4sI25AORgmrANA=;
        b=D80QoUYirmhnnZNB9B97q9uUe0z9pd63Mgycz0pyEpJUWzjQ1B8RZYD9ehFvhVETul
         PnxEnJRmTjVP+hNhg9tRBevMAfkrlLZhCtZqCahPStgVRhNWIa67wzFGKqt04iC3Qhkg
         Gwg8A6jNuWFBG9tyzNtCHAhdMyoZoD9d24i7hJ6hYiQsqezsASQq+VaiUpJIPhJuQSlD
         ukBBQq6XBNPiM9uxhPSxFiMPQPrh0gYUwoQKHE3KkNEDu2KVSUk9XXYCFNoDuTvpuJ58
         QHuSRPPYKSfym+NuB6O15o9B/E9LqrF13c28ZLpVihRzRHpU9Hij7wZBcTk3au4vJCYA
         LofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774402998; x=1775007798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BVjPu0rHHBy1UzY463CDPxiXdA8El4sI25AORgmrANA=;
        b=Fwg3Ta9VXKKA9N07m5yTHcZuzsT5Cz5ChlxhasDVpVdO9rdCPcSGMqJOkfcUkG+cwY
         Wim3WA+S0Ei9aSAnIcF6NGHrs0DT7fKHOWK43XPZB3W8R5tf729crfPEZ4dnqPcP725+
         /FtG8f6sc+FbPKQRW5+dEDehapwNpssG42Eo2tM6OdF6HXcx6/FlepHifzgAL6y5C+ql
         TBI9M0U/pOC1lh9LDd1CC7sW4bSHc1Ct6Mfwwhzh30amUb1LHBLeycI7z4tcc4Aox7Td
         FeMoK1zf6jrEK+SjRsPV6S9v3i1st/9U9hZAEhfzy2LcGIeiQXzoHuhiY4EZbTdQxFtG
         pGQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7K5n+FAFn+4WHeGqvdaxMSY/+Bs/UGakF1YbcGoeni4jolpx2eKeZrxQDgn/UuQR0AsebA6hxB4DQEd8=@lists.linux.dev
X-Gm-Message-State: AOJu0YyqHJXpFk9M7SeeaJ3pV5x9uYFVqmrqnEOtTiAMpp4f0Lij57vE
	tbdPUzzS7uNc17DHns9yppnHAtA0D484CzHu0KSSChVRbr6ZVLOitxVacG+ZTbED+EBZjZBfd8E
	ZbaQRE0BqQKG1pZsLazvJVcG2/KvsyyO0Qb3JHMfL5w==
X-Gm-Gg: ATEYQzzHd8nXPZNGqx+6xZHTEOZlXQZ8NOg2VWz3W/KjuVhma3iP3uecfMZ5RceoKWZ
	Q62DYWB6HL1YZM+LLT4IirBka21cAhhffMT1qfAnXLTKFvhfpBqpwDahJVqdGCpGdhcOo4Yni38
	s/mKmxLcpt633qO+4Rn8R5mMUwrlMJRu5A7h/4ltQMIh2UH7OsfRcxoj9oT6X9wQvGJa3Xgd2M/
	gSINeLZRtYGqiIb2moPP6WT1pSDnuWBj0y5BqzfSWjs7372K5tkZEIc5CTjmpDmwXaTQa0RghHk
	2ZXotBkN+i/Qag==
X-Received: by 2002:a05:6808:c222:b0:467:26e4:728e with SMTP id
 5614622812f47-46a5c7a4ecbmr851588b6e.49.1774402998286; Tue, 24 Mar 2026
 18:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org> <20260128-ssqosid-cbqri-v2-14-dca586b091b9@kernel.org>
In-Reply-To: <20260128-ssqosid-cbqri-v2-14-dca586b091b9@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 25 Mar 2026 09:43:07 +0800
X-Gm-Features: AaiRm519bl_Rt9ja-VV8uGqhbXi9qjWu8MIOxUSwOQfzA4YoBDggIUB3VQtcL08
Message-ID: <CAEEQ3wm4vGcOChkj+z58nP3mjG8hvQmAhQLcLxqxwdvoo_8q6Q@mail.gmail.com>
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

Is a fixed array f[6] appropriate here ?

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

ACPI_RQSC_MMU_TYPE_SV57 =3D 2  ?

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
