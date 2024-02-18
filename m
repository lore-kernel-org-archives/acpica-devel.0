Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB51C63A9
	for <acpica-devel@lists.linux.dev>; Sun, 18 Feb 2024 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708240735; cv=none; b=mnIPJaztp95uEg2eL3RTREv85SgQr9PUfL2gsWkg/Gm/d9vuiiO8qsCauo3VvFAn05aeWGK/m4V8dmdo8qmJwp+YREwNVnoKRpBJfhmA38x6xtQkOhhsMdvIVE8o7fJ3Mjf+WV+jtjHkJetrLkB58TGl8+70ltAsoDFVrVrrPTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708240735; c=relaxed/simple;
	bh=LZqwQjxc3WNdVwQL0IszZ+L7hR2FgLuF54Fz0u8hoCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9Q6nUQ2KyRQExTv4V/5i1JgVRh1sNFecZdwaIq2MQ/17+7eiHZk8kWWr/q+F4vPbbGkgekMHvpS9P5XpZeobiisNlYhjm9Bl/G2tlJh+UAMcwk30oCygBJ+TmI7QPYVT4uqFAbNoIZVLj5LPXuW5WzPo3VNfKzFcSwqtLAnu10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebd0+jTS; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebd0+jTS"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d208be133bso26877281fa.2
        for <acpica-devel@lists.linux.dev>; Sat, 17 Feb 2024 23:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708240732; x=1708845532; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoMtWxcRWAYRMgAR64TH67exXWHzzjC76RrscHy/AZU=;
        b=ebd0+jTSKM/xXPbyOUOyTP0CTkDSFlzYYA82oKLslJV1VmWnRfEkBSctlnZerQF/4R
         JuZZ1Q/uf2fizPUTXGgfnxiink8pG1rPy+R+u6FVOQgaQ4k5X7zNygFyTnGs0t42wEoD
         /SonOfnhKf3BB4DIh3Z/nIe3qlP1rEu/m62iVp6cuImUy882mjn20zBb7Y57QH+UFytn
         /VPOzO59K1ezza2mHyV+c0wHq2u08g7ujUOdI37CJ7GSW24QFMCyVH1bD/KD84hETBI+
         C+gK/Hlh+orUOPZxYNDYsLrBtty8IvqgIem3UYsYXQJ8yTctCh4zxTaUd8GuV+g9/O6l
         lAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708240732; x=1708845532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoMtWxcRWAYRMgAR64TH67exXWHzzjC76RrscHy/AZU=;
        b=MoRuRdYQfbMjOrh2SCTuETnGOw0xamqf+Goq1IxH+YALtNo5QfFus7CzLNLzI3lggU
         FOxG1TtlaYqz3YHK9+xhpVBt1YfXsKdy0+Zoszw455oaWDyRZ81D0RoGa0bC4yHHmoqp
         JTtP+5puKvtjGkPSBy8vfl4piLPM7bnzl66quLzLZXQ8Gd+UgB+vppvqo9y05rh5ymDh
         5oNsNdH0pQKOmFs1RN2sfUiIEAeSkB1CJueYk4euOu5xnkVCul4LvIe+BaDBRKyehSic
         ZWBRL+nIQXvDp24rY2ke9sGoMzgOxjk9HW1WZHPJzwjEBM/gegR8PxiuXfLgenOOn29S
         Z0HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcB6rZiEqL9yKnd6w3SrrufLPtZ4VxIefudaor0+RTOJx8tMhbzvhj/Ii5svgqNumCfIKokUQCTB6BWuEZ26PO1Vc6+MaHzX8q5FRX
X-Gm-Message-State: AOJu0YyQ+qU8GHLXAqQ5YzM5dkaBc7AamBA7xhMAbDP4l3x8iAqIlktK
	AZTckRjhhbAfMV+ap3Gn8hI2PYZB/S8V7OG5WCOYK1DqWBiW5BAAvAOUflr5YE16ZCs08VaHnWu
	lG+9iGKJbWzKdFGF8DTiFBOxKdE0=
X-Google-Smtp-Source: AGHT+IHXsKbUAnLaswlubkUVSjxcVITALdr6/5cxflDhuJ4pVB97a4rXUaqRixc+Hik3Kiz0Skp1uw1ULPxi43uK5xw=
X-Received: by 2002:a2e:a686:0:b0:2d0:9324:aab3 with SMTP id
 q6-20020a2ea686000000b002d09324aab3mr5869682lje.30.1708240731756; Sat, 17 Feb
 2024 23:18:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1706603678.git.haibo1.xu@intel.com> <6473e0bb42524e4f29112290a92539d1a800eb69.1706603678.git.haibo1.xu@intel.com>
 <CAJZ5v0hC7gxoJK0kszw9GgRjxjrKgh7q0sC1L1FdVfOb-TCSRw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hC7gxoJK0kszw9GgRjxjrKgh7q0sC1L1FdVfOb-TCSRw@mail.gmail.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Sun, 18 Feb 2024 15:18:40 +0800
Message-ID: <CAJve8omH2NvqnTu2a2V=wwrQCiQrP=uzu3ttO1VkjJN0ZyRjMA@mail.gmail.com>
Subject: Re: [PATCH 1/4] ACPICA: SRAT: Add RISC-V RINTC affinity structure
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, sunilvl@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Anup Patel <apatel@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Baoquan He <bhe@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Chen Jiahao <chenjiahao16@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	James Morse <james.morse@arm.com>, Evan Green <evan@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Marc Zyngier <maz@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 9:31=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Jan 31, 2024 at 3:18=E2=80=AFAM Haibo Xu <haibo1.xu@intel.com> wr=
ote:
> >
> > ACPICA commit 93caddbf2f620769052c59ec471f018281dc3a24
>
> Not really.
>
> > Add definition of RISC-V Interrupt Controller(RINTC)
> > affinity structure which was approved by UEFI forum
> > and will be part of next ACPI spec version(6.6).
> >
> > Link: https://github.com/acpica/acpica/commit/93caddbf
>
> And this doesn't point to an upstream ACPICA PR.
>

Hi Rafael,

This patch was generated by the acpica/generate/linux/gen-patch.sh and
should be merged
through the ACPICA project. To include it in this series is just to
serve as a reference.

BTW, the corresponding ACPICA patch is still under review and please
refer to the following
link for the status.

https://github.com/acpica/acpica/pull/926

Regards,
Haibo

> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  include/acpi/actbl3.h | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> > index c080d579a546..5202e3fc9b41 100644
> > --- a/include/acpi/actbl3.h
> > +++ b/include/acpi/actbl3.h
> > @@ -192,7 +192,8 @@ enum acpi_srat_type {
> >         ACPI_SRAT_TYPE_GIC_ITS_AFFINITY =3D 4,    /* ACPI 6.2 */
> >         ACPI_SRAT_TYPE_GENERIC_AFFINITY =3D 5,    /* ACPI 6.3 */
> >         ACPI_SRAT_TYPE_GENERIC_PORT_AFFINITY =3D 6,       /* ACPI 6.4 *=
/
> > -       ACPI_SRAT_TYPE_RESERVED =3D 7     /* 7 and greater are reserved=
 */
> > +       ACPI_SRAT_TYPE_RINTC_AFFINITY =3D 7,      /* ACPI 6.6 */
> > +       ACPI_SRAT_TYPE_RESERVED =3D 8     /* 8 and greater are reserved=
 */
> >  };
> >
> >  /*
> > @@ -296,6 +297,21 @@ struct acpi_srat_generic_affinity {
> >  #define ACPI_SRAT_GENERIC_AFFINITY_ENABLED     (1)     /* 00: Use affi=
nity structure */
> >  #define ACPI_SRAT_ARCHITECTURAL_TRANSACTIONS   (1<<1)  /* ACPI 6.4 */
> >
> > +/* 7: RINTC Affinity (ACPI 6.6) */
> > +
> > +struct acpi_srat_rintc_affinity {
> > +       struct acpi_subtable_header header;
> > +       u16 reserved;           /* Reserved, must be zero */
> > +       u32 proximity_domain;
> > +       u32 acpi_processor_uid;
> > +       u32 flags;
> > +       u32 clock_domain;
> > +};
> > +
> > +/* Flags for struct acpi_srat_rintc_affinity */
> > +
> > +#define ACPI_SRAT_RINTC_ENABLED     (1)        /* 00: Use affinity str=
ucture */
> > +
> >  /*********************************************************************=
**********
> >   *
> >   * STAO - Status Override Table (_STA override) - ACPI 6.0
> > --
> > 2.34.1
> >
