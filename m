Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3782238E8BF
	for <acpica-devel@lists.linux.dev>; Mon, 12 Oct 2026 07:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791789670; cv=none; b=MmRz8lohaHacX0iOC+rJ7I7U43bxKPiLLXmwUBk7B921Zvz6xJ2kBgJsCkgCuoh9aDWG0URh7GKHpDBrK6/IwRKxz3ifhIKIb0kQewXGyCYCFOJnfcADf6Dyw03Vl1wsBg16CaOgAn7UlXA9NqpJyIbQ6IuAq6s479RDhcUU/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791789670; c=relaxed/simple;
	bh=GlPJFBH/QQaGpWj2HTUaP+XhfB/ILKkWcWTtXLgnGnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVoccqGsHPaFKXkhsaVtMvn/SBShODA+Dp6+Aumoph0qlCOJqSzmqV0RFie6uotki8u8guS3/QJ2NeEkSVVkar1goQ/TxXCk9Vb8quO3rMO07i+9ELCttDeds7apvEs4d5FFqFZigf+XVV5yvzQKIu44vt333omD9WexBSYHbXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEQCAMjh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEQCAMjh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7E41F0089D
	for <acpica-devel@lists.linux.dev>; Mon, 12 Oct 2026 07:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791789668;
	bh=E1EzNNVWzoVsaQJ5ysflzUxIgWV051RNj1SflKkQXWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nEQCAMjhJMMRYRi7lufiAtDkkhT+qIu3gPV/N7IiWsPWDOL0yN9fMJk8emM/5q8ct
	 9aC/NGlKonKiI2MiBLGerMkxqSb3Cs+QUCJCC08MK2ZGtUd/zCs+4dD5/254rCsU/d
	 cz9SC0iLm5h7/OrnXZPRH1aYJltz1bbX22EXE9Oqfaf+a0tCTIMMWeBhAhED1iqutM
	 j4X8OIveu8bpiImQlpqZMigJDdLC2am/Q10JhVJK6yPlPELKKVwt6mn9azrcnYyBqY
	 E2MzFK+PJ69/OA4LMjPptW20LRL8d05mxI5soqWyzPbo83IOLm3jfVDch5/mQJ6P4M
	 G+P268KtC9E6g==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c31745ad205so578345766b.0
        for <acpica-devel@lists.linux.dev>; Mon, 12 Oct 2026 00:21:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxZ4IegArUprmjeJDPplfxEBjIr4wy98S2Crkt/1DD/pSLDHpRxZyP5Xw1zVHvU6T8YH9qxqwJcyUJae/w=@lists.linux.dev
X-Gm-Message-State: AFq9FYJlqwUzc7vY5+XhwPie/eoyLxIpieC7SlJXQaVagY/YC5aj2N+M
	UVq2yShmTFkHJkQJvNhh4FPQKBkS4Rk1ONXHNqQebhCC+qimoa9pDjbhXmTj7NO2BneHaiCqgsw
	PjFScxauIMy7949CkAjNZ6W68fFAK3Ag=
X-Received: by 2002:a17:907:c8c4:b0:c2d:c0ce:8465 with SMTP id
 a640c23a62f3a-c31a6999fe9mr871638766b.0.1791789667484; Mon, 12 Oct 2026
 00:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260922121058.972734-2-maobibo@loongson.cn> <10bd45f8-2d37-42f0-b7d2-a4a84933c9b3@loongson.cn>
In-Reply-To: <10bd45f8-2d37-42f0-b7d2-a4a84933c9b3@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 12 Oct 2026 15:20:57 +0800
X-Gmail-Original-Message-ID: <CAAhV-H40TW01vpaNSDgm86DVM4Mwf0sUvnAt2KEwUB=pPFhhqw@mail.gmail.com>
X-Gm-Features: AclHuK8x62gs_C5UF1Qg2VLiQQD2G3P5vBVPyCdu0AvLT7ob8451ejbWRTFvLCM
Message-ID: <CAAhV-H40TW01vpaNSDgm86DVM4Mwf0sUvnAt2KEwUB=pPFhhqw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] ACPICA: actbl2.h: Add bit constants of the Flags
 field in the IOVT IOMMU structure
To: Bibo Mao <maobibo@loongson.cn>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, lenb@kernel.org, linux-kernel@vger.kernel.org, 
	lixianglai@loongson.cn, loongarch@lists.linux.dev, 
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 3:16=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> This change is already merged in acpica tree.
>
> slightly ping.
I will merge the last three patches once the acpica changes are synced
to git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git.

Huacai

>
> On Tue, Sep 22, 2026 at 08:10:55PM +0800, Bibo Mao wrote:
>  > According to the IOVT specification, define macros for each bit of the
>  > Flags field in the IOVT IOMMU structure.
>  >
>  > Link: https://github.com/open-acpica/acpica/commit/352f750e4cc0
>  > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>  > ---
>  >  include/acpi/actbl2.h | 7 +++++++
>  >  1 file changed, 7 insertions(+)
>  >
>  > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>  > index baef525367b5..76e4a5bc79b4 100644
>  > --- a/include/acpi/actbl2.h
>  > +++ b/include/acpi/actbl2.h
>  > @@ -919,6 +919,13 @@ struct acpi_iovt_iommu {
>  >       u32 device_entry_offset;
>  >  };
>  >
>  > +/* Masks for Flags field above */
>  > +#define ACPI_IOVT_IOMMU_PCI_DEVICE           (1<<0)
>  > +#define ACPI_IOVT_IOMMU_PXM_VALID            (1<<1)
>  > +#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT    (1<<2)
>  > +#define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT               (1<<3)
>  > +#define ACPI_IOVT_IOMMU_MSI_INT_BYPASS               (1<<4)
>  > +
>  >  struct acpi_iovt_device_entry {
>  >       u8 type;
>  >       u8 length;
>  > --
>  > 2.39.3
>  >
>
