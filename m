Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5481F4CB7
	for <acpica-devel@lists.linux.dev>; Mon,  5 May 2025 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746448335; cv=none; b=Z3b0HElST1A3FK3zLfQV59WgDdSUiOGVTLeNhEZ118LEugT+yuGUTYzsmvJH9pK6VxkRlU8xOq728L48eQQa6D1uew1QYdvWh8TvMTZzKo32/MgXgSO62P4bb+qCLKRgniodnoaE2FCN/6PKmd3yehbtUJFhmAgTBptKzAJGTuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746448335; c=relaxed/simple;
	bh=z9yc6YZ8/bzyIza72DBETn31TjUPwyUy4wMzJdbZb6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOlfmjnMsZHA7IR1mdnfKajQzH70egESd1MysXCNgZcbzVi65w0idFdbApJKgeaMGrAejmy/JEvxHwvYrEIp0KTta19mxXP/pazQGn8DzlYdKJMJO35q3YxNwg8b50oO41qoG1GPUB1pDK+eB/AhCgbeoFgpUM6Pas56d6ZgnLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=gGDoQWrP; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="gGDoQWrP"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d7f4cb7636so14216235ab.3
        for <acpica-devel@lists.linux.dev>; Mon, 05 May 2025 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1746448333; x=1747053133; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ROvQBGSdDBOd+A03xhzhhLZdwd+Yr3g8998GOj2eyg=;
        b=gGDoQWrPKQfHcC7GfBtPcjcTt8k29sykESpV+YIMXSy7qsG4N/N1FVbjlo0ejIfCyG
         TexnLNsCc4D5YdHp5Wpz+m6K9b0w7ySb0G6UfdI9wI9QXU7v99uXvI/n6WtwY8mGg+yA
         AAUQFRjinsffHBE8l9xSgev9mz7w7foNSJoRJWfVfWLNdaZSAP7yASjOzLNc9xTFUkes
         Rx67MYIjhzoi9eYeyeTV2Vp2ZNQJx27tMOfqNxgHfUElcsvhBqdZ7ZRBiQDvvg0p/iXr
         NZ2UmbYCRtNqTRlLTn3HI2Mgaz67uEmxU9R4bqu+sVdmgulcNsr7PlEegx0O9TTX4Gcc
         OsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746448333; x=1747053133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ROvQBGSdDBOd+A03xhzhhLZdwd+Yr3g8998GOj2eyg=;
        b=CnJSwyU9o4nNmlC9tA6aLmL4pdOwnoLv61ispHkuuPTIGTiYLE4OgwXRCmc2Ohvifc
         +2xWF6RNnN1xCHHVPzoHRyklJKHcp4YOi+1N2+w3SiEEOmT1XCsYyFTMGQEmpp5psGhh
         aytB4eSW6N9dM4JFDAoA8STuVdzPufjm7Qz7xcI1IjePap9PvJ22/ACUyudz/H+K+WDs
         hbMzrz77C9HHQkxM4uTZKP9upgBRn9+eH436hF9kT7tzhBh1QbRMB2xEGUz2vD5ldPnb
         ArnLBte4RhT2+qLkTyjDVbaaDTgkc00Ai4CPSsxHKtciGNptUxd6OjPuUOQdMFa0rJil
         dp7g==
X-Forwarded-Encrypted: i=1; AJvYcCWejoX97htNqm/itsTXgBzjwQp8wC3DRfVrq7oWqyXGwa+8EGyHHfm2AuAd1D2CJ6n1HPRBvqkLWRsHjkA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4oF1LANloIKJMo3DFjJuYAAZjAGKT8oiByT711StHIEd2bDQ+
	D+eMAFU1L70VlBui/EuYVNKBWyQy9vEN9U64norlNb7XwsORuOVPvAJfa7DOs+xHZ6QfYBqI5UN
	1G1TrTFZx5GMFcoatYpd9kkba6thueBavhssDSd7MahjMlRb808M=
X-Gm-Gg: ASbGncv7z/wKRyR0aL63EwuGO1IQ/RyM6ldiAade5S5kQnxc0/55i9SlMTy50CnlyGa
	PuYqPmQpR6F2DbjtdIqWZZA8k8Jo3FMpDBS6TIJ2GGDihJokSDq/2zkcZFZwz5opwLGKTgayJUK
	uWGhSOMhRR9g7/dR+KI9Yvgi8=
X-Google-Smtp-Source: AGHT+IGKfyVuSpXvhyCqr3MzLrMWyvS/DXDaTYYmrBeFPlCthPJdi1/XEIr6vTapFuhwTG/+VDZdp44YaLe79OiDUvE=
X-Received: by 2002:a92:ca4e:0:b0:3d8:2023:d048 with SMTP id
 e9e14a558f8ab-3da569fc0fdmr78214885ab.22.1746448332626; Mon, 05 May 2025
 05:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com> <20250227123628.2931490-2-hchauhan@ventanamicro.com>
In-Reply-To: <20250227123628.2931490-2-hchauhan@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 5 May 2025 18:02:03 +0530
X-Gm-Features: ATxdqUH3w6mQ0qSoQ0tXhdBpHdmtraVQBLRXb-lEZsWxpb787pmCQYQjNjM4yWg
Message-ID: <CAAhSdy1bupf80qpio6-HpwzC53MW3UguKj+zxd3Zmduxay4rpg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/10] riscv: Define ioremap_cache for RISC-V
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com, ardb@kernel.org, 
	conor@kernel.org, cleger@rivosinc.com, robert.moore@intel.com, 
	sunilvl@ventanamicro.com, apatel@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 6:08=E2=80=AFPM Himanshu Chauhan
<hchauhan@ventanamicro.com> wrote:
>
> bert and einj drivers use ioremap_cache for mapping entries
> but ioremap_cache is not defined for RISC-V.
>
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  arch/riscv/include/asm/io.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index 1c5c641075d2..e23a4901e928 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -30,6 +30,9 @@
>  #define PCI_IOBASE             ((void __iomem *)PCI_IO_START)
>  #endif /* CONFIG_MMU */
>
> +#define ioremap_cache(addr, size)                                      \
> +       ((__force void *)ioremap_prot((addr), (size), _PAGE_KERNEL))
> +

There is a compile error observed with this patch applied
on the latest Linux-6.15-rcX kernel.

To fix compile error, we need the following change:
s/_PAGE_KERNEL/PAGE_KERNEL/

Regards,
Anup
