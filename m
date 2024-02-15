Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FBF139590
	for <acpica-devel@lists.linuxfoundation.org>; Thu, 15 Feb 2024 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024964; cv=none; b=ujc2wOXTlw27y52kzG76E6RAhMaJ31HO8y8UtgRbq6ttIWY6v2fo42WUrmoPk5j3QhwlidcLMl5wP6CQRBy4oD0ht1/is/4jRlPd9IIy7FWhkAm9/Rni7L7VVJ9/PFpkzT4Lxv0QsAgcQRwtBDw008ErqwiP1z36AUBTir8mnWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024964; c=relaxed/simple;
	bh=gCJhOtMnRU8UWRkUPUSVOlRb9/TApbJfHXnwR2CW2HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbNelhsX6vtG7ANtoij4RQq6qzUBvhuWJaF4NkkyWmVlQ5JCDhlMK9wPvPXiRLj/Di/qNHBAOL8M3zmN95UneQGcJQ6ST3VUT8doy5G47dl/cm+YJxKqrOX4I0p4Se4mz+U7R8OHjqFmKxjjFkIpHprxKBRjHUnO8RkPe0+dbDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E44141ED0
	for <acpica-devel@lists.linuxfoundation.org>; Thu, 15 Feb 2024 19:22:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.398
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GMKHASgKK1DZ
	for <acpica-devel@lists.linuxfoundation.org>;
	Thu, 15 Feb 2024 19:22:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.161.49; helo=mail-oo1-f49.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B060841ECF
Authentication-Results: smtp4.osuosl.org; dmarc=fail (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B060841ECF
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B060841ECF
	for <acpica-devel@lists.linuxfoundation.org>; Thu, 15 Feb 2024 19:22:41 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-59f9045d18dso29997eaf.0
        for <acpica-devel@lists.linuxfoundation.org>; Thu, 15 Feb 2024 11:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708024960; x=1708629760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atg7WI78HsTq5644XbnZluXts4d5OR/FFe0QfcIw1Ag=;
        b=Kp5Uor/9g6Si2Z/xkBv27aZ7WXLkoGGEPnY8i332x//uYA+EMfhxVyRHOIFR5MsRzD
         GuFzLO50TSR1IwkLloS7V0nQ1bhoAbYjdmJewYOnG1kgadXS+NO3VzDqPPFBx/BrP0Nd
         Z0y694N9CSuuq+rUr/DAI1KKExlkZu15R2GSPI92N8myHZSUQ9/Hv0h5JeGEYUQgtzN0
         vQSnu5+Y67IHXhRAIunFQFp971jKf+FDdVcOF9lSzpbm5n7zvkSjJMI7NxyOnWceFPo8
         pytqOCD+a2zzvcMdE1PcGjHPNiRd3CKSiGrx8uT5uvNhz5x5gLgN7/d4jLpLRBzFYmaW
         t2KA==
X-Forwarded-Encrypted: i=1; AJvYcCUjEVQd/H6cNVSlOvN3sKmRKvDfete0Fbo6HT8b60zN1DumrPiLW8cfwCUAvx+e3Jg7P2KMHKJviQsA28zeWTeyon3w1EiuX84hstnKpKZK6/MfXuRxQw==
X-Gm-Message-State: AOJu0YwHIrhjf3MQgBWMZ68qEzRAO2yKj38GWKfjdgIMCSOVEkjyHYwK
	NtCRnF2tmQDX1T6M69OIFl9q4GpTLpY7aeeRxJ+rZRQ/lKWb3pflMKRaLDfuwWZLMQCUZa7fbYE
	jUQlW7eY9NVJFmAR85SJD/wxEC2M=
X-Google-Smtp-Source: AGHT+IGH9nzxfJPZ0b9LL7NeSQVmLFmBC+x3c+fnaZmT/Dcf6w2GoSt64Z11xwqZfq7drVdSJDbhPxjptv1uaDnhYPo=
X-Received: by 2002:a05:6820:1f8d:b0:59c:d8cd:ecee with SMTP id
 eq13-20020a0568201f8d00b0059cd8cdeceemr110694oob.1.1708024960621; Thu, 15 Feb
 2024 11:22:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk> <E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Feb 2024 20:22:29 +0100
Message-ID: <CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from acpi_processor_get_info()
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, 
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	James Morse <james.morse@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 5:50=E2=80=AFPM Russell King <rmk+kernel@armlinux.o=
rg.uk> wrote:
>
> From: James Morse <james.morse@arm.com>
>
> To allow ACPI to skip the call to arch_register_cpu() when the _STA
> value indicates the CPU can't be brought online right now, move the
> arch_register_cpu() call into acpi_processor_get_info().
>
> Systems can still be booted with 'acpi=3Doff', or not include an
> ACPI description at all. For these, the CPUs continue to be
> registered by cpu_dev_register_generic().
>
> This moves the CPU register logic back to a subsys_initcall(),
> while the memory nodes will have been registered earlier.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC v2:
>  * Fixup comment in acpi_processor_get_info() (Gavin Shan)
>  * Add comment in cpu_dev_register_generic() (Gavin Shan)
> ---
>  drivers/acpi/acpi_processor.c | 12 ++++++++++++
>  drivers/base/cpu.c            |  6 +++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index cf7c1cca69dd..a68c475cdea5 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -314,6 +314,18 @@ static int acpi_processor_get_info(struct acpi_devic=
e *device)
>                         cpufreq_add_device("acpi-cpufreq");
>         }
>
> +       /*
> +        * Register CPUs that are present. get_cpu_device() is used to sk=
ip
> +        * duplicate CPU descriptions from firmware.
> +        */
> +       if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
> +           !get_cpu_device(pr->id)) {
> +               int ret =3D arch_register_cpu(pr->id);
> +
> +               if (ret)
> +                       return ret;
> +       }
> +
>         /*
>          *  Extra Processor objects may be enumerated on MP systems with
>          *  less than the max # of CPUs. They should be ignored _iff

This is interesting, because right below there is the following code:

    if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
        int ret =3D acpi_processor_hotadd_init(pr);

        if (ret)
            return ret;
    }

and acpi_processor_hotadd_init() essentially calls arch_register_cpu()
with some extra things around it (more about that below).

I do realize that acpi_processor_hotadd_init() is defined under
CONFIG_ACPI_HOTPLUG_CPU, so for the sake of the argument let's
consider an architecture where CONFIG_ACPI_HOTPLUG_CPU is set.

So why are the two conditionals that almost contradict each other both
needed?  It looks like the new code could be combined with
acpi_processor_hotadd_init() to do the right thing in all cases.

Now, acpi_processor_hotadd_init() does some extra things that look
like they should be done by the new code too.

1. It checks invalid_phys_cpuid() which appears to be a good idea to me.

2. It uses locking around arch_register_cpu() which doesn't seem
unreasonable either.

3. It calls acpi_map_cpu() and I'm not sure why this is not done by
the new code.

The only thing that can be dropped from it is the _STA check AFAICS,
because acpi_processor_add() won't even be called if the CPU is not
present (and not enabled after the first patch).

So why does the code not do 1 - 3 above?

> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 47de0f140ba6..13d052bf13f4 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -553,7 +553,11 @@ static void __init cpu_dev_register_generic(void)
>  {
>         int i, ret;
>
> -       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
> +       /*
> +        * When ACPI is enabled, CPUs are registered via
> +        * acpi_processor_get_info().
> +        */
> +       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES) || !acpi_disabled)
>                 return;

Honestly, this looks like a quick hack to me and it absolutely
requires an ACK from the x86 maintainers to go anywhere.

>
>         for_each_present_cpu(i) {
> --
