Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C88076082
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 18 Dec 2023 20:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AE9CA40AA3
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 18 Dec 2023 20:31:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE9CA40AA3
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.398
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2EkFZOOoODN4
	for <acpica-devel@lists.linuxfoundation.org>;
	Mon, 18 Dec 2023 20:31:02 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E849E408D7
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 18 Dec 2023 20:31:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E849E408D7
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-203aa9c19ceso242195fac.0
        for <acpica-devel@lists.linuxfoundation.org>; Mon, 18 Dec 2023 12:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702931461; x=1703536261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tAlFGdRk7dsOpEqAvR+OuH9VoSVkSPM03m6WEM5ITU=;
        b=RlQUep+qmXLUL1ZlIcOoviW4o121FXRGMGAGcWdhewrIDoRvB151DfUFF9yiAGp19Q
         KcpAyyTRkCk7ECRb0YTeXgEN3QIr5Vdr6GZviXkemSPWagua0YrVIkyKfak2Kd0H1W3B
         SvzCiSrR0QHF8dYv1MzS7KzlDHmbnpul1H3wiZstk+5HmpZuEsNfpZdn9XU2PrOWzHpz
         kdNDCCsG67bKOZduX4GzKxXcWfZ1v9XGn5hgk057cEzeJqcupGZSbU/aiUtSMpI5eN3p
         Y2TymslJL+yaW63joyhU3gaTm/E24/sf1EnrL8cwKhIfb5KzkFjy8Kd0Hzmbk8q/yo/U
         tp/Q==
X-Gm-Message-State: AOJu0YyREUxbgdO8cSiweU2vKTA5LL8QDvH2Ih1MOtTeggzs6a8cZNgF
	4kl4sdN8O0n9KeXskyg0K9gjdFDP/b7TFYm++UI=
X-Google-Smtp-Source: AGHT+IH2/Xcl6oIvnSfLcxllKujvsfBDeafZqBXfGcoJ6ZYuhTDpjdkrOr2cBBTAZn748hcGAPQjloWIL3tDogLMDwE=
X-Received: by 2002:a05:6870:420d:b0:1fb:5d05:685e with SMTP id
 u13-20020a056870420d00b001fb5d05685emr31445963oac.2.1702931460922; Mon, 18
 Dec 2023 12:31:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOg7-00Dvjq-VZ@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rDOg7-00Dvjq-VZ@rmk-PC.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Dec 2023 21:30:50 +0100
Message-ID: <CAJZ5v0je=-oVnSumZs=dzcyVuVUeVeTgO7yOnjGg1igyrS7EHQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 04/21] ACPI: processor: Register all CPUs from acpi_processor_get_info()
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, 
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@armlinux.o=
rg.uk> wrote:
>
> From: James Morse <james.morse@arm.com>
>
> To allow ACPI to skip the call to arch_register_cpu() when the _STA
> value indicates the CPU can't be brought online right now, move the
> arch_register_cpu() call into acpi_processor_get_info().

This kind of looks backwards to me and has a potential to become
super-confusing.

I would instead add a way for the generic code to ask the platform
firmware whether or not the given CPU is enabled and so it can be
registered.

> Systems can still be booted with 'acpi=3Doff', or not include an
> ACPI description at all. For these, the CPUs continue to be
> registered by cpu_dev_register_generic().
>
> This moves the CPU register logic back to a subsys_initcall(),
> while the memory nodes will have been registered earlier.

Isn't this somewhat risky?

> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
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
> index 0511f2bc10bc..e7ed4730cbbe 100644
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
>
>         for_each_present_cpu(i) {
> --
> 2.30.2
>
>
