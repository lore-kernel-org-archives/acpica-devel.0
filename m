Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510BB4C94
	for <acpica-devel@lists.linux.dev>; Tue,  5 Mar 2024 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709605862; cv=none; b=aL/IurGYaZeRk+NviTCsypkCxSkl/JfG883zVUJ4xN3fjE5DXOo+og9bt/XdVPc//OcEWv0DmuSKSa46uBvM5Z4No2i3Mo4gkcVpPEFWC57LxC9Iqmiyl9CiXlQPBzCpGbFXNRiq+E/TLZFejDG3r1vDrM1pZuM4WA6CLSLVw1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709605862; c=relaxed/simple;
	bh=pSsvsuUlut4jPJp7g2dGTj1A/pEOdbw7dEeVXx61AJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzxEaXZoFiKSrb/3bIprq78NSjH+SydhyZemaXnkBopAd9K1nkQA2acRlx5eFUSOHaDlWmqnpXht6ZhTN25RVn96Qbsv8uxArcPeXdFxkNM4hVTIs7d5bPE4HMIYN+M+b73qjBE/sOlt+FuPh1rwbjs/g8YDzfDeIbZXIZFPdmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGCOPyur; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGCOPyur"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512ed314881so4778927e87.2
        for <acpica-devel@lists.linux.dev>; Mon, 04 Mar 2024 18:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709605857; x=1710210657; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJxBJuXmvGHQUImyHIJdK0gOdBp3H9ixn+SkaIN8FCM=;
        b=EGCOPyuro6Tf/Iu6Ft025Sl6Qbei+n+yRzDphhLXRfSlCWOc62l4Qt/jOOi/ON4B5A
         g8C+o34FOL+1x6STwyv5IXFvGd0jDjvSLUyRuxlqMa9TkMcvrDITxHZiLaupst5f+YkC
         J4BEmF7+upRn2kAtRrSVMFwWyoXsArTHkmeMDzTbjmsV+UZvZnfG+cdMHQI8ceMZ24uu
         rdY57tfhUUCYCMab1wKU10EpW/OkBtQzjNY9HLTbb8GHtczo/uQ44b7vEf+tar1zfgGY
         QZhjU8Nkrybe5v+/DA6+tiCVwTqpzTSWR3OsU1jjR3yCp8H5jC8dKlbVzCm6eNELfa7z
         e6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709605857; x=1710210657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJxBJuXmvGHQUImyHIJdK0gOdBp3H9ixn+SkaIN8FCM=;
        b=ACDM/gIcx8PYOSrPZWvkbU0YKb57NiFhf0qXmltWaIFL48Ea0uT7OrBh3XNNKw35Em
         OHQbIir3emDKiX8rZ9VwRFnjRaTFHsTqWw9cPJNN7L96o/IWU6MBkadlzrGw2qHY0Lw+
         krLIIX/amvRY1ZSVexkwW3dxGMCXwlUzo0PSJ+LKxH4DqsX2lUt1DohIA2rtDRqPlmBO
         Ctj/2w2YWlNn6xvjUu0o7WCiyPZj2816X95nIj50gVKdqDtWHRhp3xx7fxjPlNptRJJY
         wmB/FgvBRy1NfiQJoxxYvR6vQ77LVv8cHTGhC5F/9GeMptZ8Lp/Ef7+oRcMef6gytMZu
         j4Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXx2j5VgfG3cJUeykbexapqVWf1Nxdotg0lgEq3Qw1+sSehPC/oUPIIUqfeOorwWpsa/we9KpxPITrnS3htoWsztpHtGU460iT/zQYe
X-Gm-Message-State: AOJu0YxsNLCprqXDLknfZEjCZ+Mhf171PlHcEQtb5PcCAyJdMjV/srUd
	pZZKGhMjteHgxJdA7HTL3gsewwM0V5V3h5p/FblcgfQSkz1Gq6sp/rJgzzGtlVVVPz5M+GaofZi
	sWlLT8e/RZQWFM1oniSjSOzUmEXQ=
X-Google-Smtp-Source: AGHT+IGdw1R5rJC4pZeyLtaquozmyyYFWlB0fEy+eGf175BBa5M1tKyVDX4YV/pAnGtKDEywU6f1ZMxAAXweNheWd18=
X-Received: by 2002:a05:6512:36d0:b0:512:e220:d3ab with SMTP id
 e16-20020a05651236d000b00512e220d3abmr275796lfs.65.1709605857043; Mon, 04 Mar
 2024 18:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1706603678.git.haibo1.xu@intel.com>
In-Reply-To: <cover.1706603678.git.haibo1.xu@intel.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Tue, 5 Mar 2024 10:30:45 +0800
Message-ID: <CAJve8o=H+VVyQH6crAvnTUSjRV2pFDmEpy4ykpFBYSB3pOeiZQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add ACPI NUMA support for RISC-V
To: Haibo Xu <haibo1.xu@intel.com>
Cc: ajones@ventanamicro.com, sunilvl@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Anup Patel <apatel@ventanamicro.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Jisheng Zhang <jszhang@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Baoquan He <bhe@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Chen Jiahao <chenjiahao16@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	James Morse <james.morse@arm.com>, Evan Green <evan@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunil,

Could you help review this patch set?

Thanks,
Haibo

On Wed, Jan 31, 2024 at 10:18=E2=80=AFAM Haibo Xu <haibo1.xu@intel.com> wro=
te:
>
> This patch series enable RISC-V ACPI NUMA support which was based on
> the recently approved ACPI ECR[1].
>
> Patch 1/4 is generated from the acpica PR[2] and should be merged through
> the acpica project. Due to this dependency, other 3 patches can only be
> merged after the corresponding ACPICA patch was pulled into linux.
>
> Patch 2/4 add the common SRAT RINTC affinity structure handler.
> Patch 3/4 add RISC-V specific acpi_numa.c file to parse NUMA information
> from SRAT and SLIT ACPI tables.
> Patch 4/4 add corresponding ACPI_NUMA config for RISC-V Kconfig.
>
> Based-on: https://github.com/linux-riscv/linux-riscv/tree/for-next
>
> [1] https://mantis.uefi.org/mantis/view.php?id=3D2433
> [2] https://github.com/acpica/acpica/pull/926
>
> Testing:
> Since the ACPI AIA/PLIC support patch set is still under upstream review,
> hence it is tested using the poll based HVC SBI console and RAM disk.
> 1) Build latest Qemu with the following patch backported
>    https://lore.kernel.org/all/20240129094200.3581037-1-haibo1.xu@intel.c=
om/
>    https://github.com/vlsunil/qemu/commit/42bd4eeefd5d4410a68f02d54fee406=
d8a1269b0
>
> 2) Build latest EDK-II
>    https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README=
.md
>
> 3) Build Linux with the following configs enabled
>    CONFIG_RISCV_SBI_V01=3Dy
>    CONFIG_SERIAL_EARLYCON_RISCV_SBI=3Dy
>    CONFIG_HVC_RISCV_SBI=3Dy
>
> 4) Build buildroot rootfs.cpio
>
> 5) Launch the Qemu machine
>    qemu-system-riscv64 -nographic \
>    -machine virt,pflash0=3Dpflash0,pflash1=3Dpflash1 -smp 4 -m 8G \
>    -blockdev node-name=3Dpflash0,driver=3Dfile,read-only=3Don,filename=3D=
RISCV_VIRT_CODE.fd \
>    -blockdev node-name=3Dpflash1,driver=3Dfile,filename=3DRISCV_VIRT_VARS=
.fd \
>    -object memory-backend-ram,size=3D4G,id=3Dm0 \
>    -object memory-backend-ram,size=3D4G,id=3Dm1 \
>    -numa node,memdev=3Dm0,cpus=3D0-1,nodeid=3D0 \
>    -numa node,memdev=3Dm1,cpus=3D2-3,nodeid=3D1 \
>    -numa dist,src=3D0,dst=3D1,val=3D30 \
>    -kernel linux/arch/riscv/boot/Image \
>    -initrd buildroot/output/images/rootfs.cpio \
>    -append "root=3D/dev/ram ro console=3Dhvc0 earlycon=3Dsbi"
>
> [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000-0x17fffffff]
> [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x180000000-0x27fffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x17fe3bc40-0x17fe3cfff]
> [    0.000000] NUMA: NODE_DATA [mem 0x27fff4c40-0x27fff5fff]
> ...
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> HARTID 0x0 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> HARTID 0x1 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> HARTID 0x2 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> HARTID 0x3 -> Node 1
>
> Haibo Xu (4):
>   ACPICA: SRAT: Add RISC-V RINTC affinity structure
>   ACPI: NUMA: Add handler for SRAT RINTC affinity structure
>   ACPI: RISCV: Add NUMA support based on SRAT and SLIT
>   ACPI: RISCV: Enable ACPI based NUMA
>
>  arch/riscv/Kconfig            |   1 +
>  arch/riscv/include/asm/acpi.h |  15 +++-
>  arch/riscv/kernel/Makefile    |   1 +
>  arch/riscv/kernel/acpi.c      |   5 --
>  arch/riscv/kernel/acpi_numa.c | 133 ++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/setup.c     |   4 +-
>  arch/riscv/kernel/smpboot.c   |   2 -
>  drivers/acpi/numa/Kconfig     |   2 +-
>  drivers/acpi/numa/srat.c      |  35 ++++++++-
>  include/acpi/actbl3.h         |  18 ++++-
>  include/linux/acpi.h          |   7 ++
>  11 files changed, 209 insertions(+), 14 deletions(-)
>  create mode 100644 arch/riscv/kernel/acpi_numa.c
>
> --
> 2.34.1
>
