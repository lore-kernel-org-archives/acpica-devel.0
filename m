Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C4389118
	for <acpica-devel@lists.linux.dev>; Wed,  3 Jun 2026 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469090; cv=pass; b=ZJtVU02ufXHVpSBnxTumXSU2E6X3aE0EZScjDefJOoEdi0+KGAkBq6gMWnVEN5+lSULkWDnCkaOQoU4SFAWbX434QgmU+DyxXxfHbH5/x4H+Ow523/xOi9FDW+ol7mrtUNSSXJKlL6ZJuDEW4w8F7Ehpjj/Fchrjnc1swAXvPdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469090; c=relaxed/simple;
	bh=56G+6KSF26fnjlqQuQaSxXvZtnVr1hBfZPPvTYbNb3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIuT/rcnP62SCQxp1msWrBsskcdyVUVqhuvMKOx7zRCLl4HPIPlUEJhFgf4pPp1E5pNH/p8qO4A0ay169/RFDeu32LI7LDUkXASxleCyWFmFPy8DedQNnTMTE8vC3wmsZnhFGJlebaTRjxj22h8TtAhwmgIoO6MDK4/sV3PIHMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=GTAkC2kp; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="GTAkC2kp"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69e50fe0919so31593eaf.1
        for <acpica-devel@lists.linux.dev>; Tue, 02 Jun 2026 23:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780469087; cv=none;
        d=google.com; s=arc-20240605;
        b=AuERzUC/03E8sp2RxQagh5oelX8MZGY9rQh3GX8vRMW74jM8026YrbG0ANsz9R+des
         clcQea/pKee21zW/A3l/enH+EnmzObgB56sSPPOW4kTUZbJzJC5dRB0FN1/TPSch9NHG
         +UUGCkw/f16iMNwgNcSPHB3nt3JTZ98Chi00Sn1vUDIuw4jz+/63KleERm8lHbjLckax
         5Ep9JraA+7zNLmH7aC4s1LaXfIA3+x8XJaN/WGfsAJqZ64/qvmT8ML2b2dg9UnEexhFu
         kydkStkAFFhMMlDB1tujATwgLjKpG/bfg1yvvhjKaBBRR7Dm35IDCjtT/zp9b49gRLjt
         Mh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vguV3vMU4h/2CSVTFHkBd4daU9WvVPcYCYkqg5eye6Q=;
        fh=UMWzjSIG+41jB+7C/Cxq8KvQC32nOEsGM5uraoDaK/E=;
        b=PPVzNj/Cq64Pzfy86iiyOXWS9nFlCmPRdCbQUrBDYzYGqht2ZVntfxSOB+QCBnXjKm
         Cs+bJDNMcggw1sz+7EA3modcscTeWr51hLq3cPA8xBdhF0+H8ufSiUEgKQjP1pmtUIJt
         yZsB8CwXFCEAqz/wCmL98O3Ptu7GmxSa7m3oK8MGo5Be6B91oY+6lKa73x8W6I+JETa1
         OLEH2/a7F0tu3r5sGBJ4Vkqp2O5yN8A+aTFGnZP8AAPPi3/l20nS1no/gB2U2He+iiCS
         cr44cUjetnBEhRip7RPbpU1dYyVtJbqAYeX7zwX/h/tGbkV6IdbGAW1uxlvfSVHmiQiS
         Ozew==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780469087; x=1781073887; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vguV3vMU4h/2CSVTFHkBd4daU9WvVPcYCYkqg5eye6Q=;
        b=GTAkC2kp5Pf2Rlsyfee4x0GvWRGtaaYb/ON1APEHZ+Z9osbCotzuYYpPfo7tDqtiMe
         FOizPG1M41NM60B3pDl3Fa3qZP7/5KBow2jF4xBLiV2oMsuDkNEmgyRJfH4cCbmo5rWr
         JRCkZ3E6PE6Xammb+Pem4xQ8Llw6jB+KB11iJKmL5amKAxNApQlL9Rdzw4R+rCkZIK5N
         Dw+TVk00cyiaO3fjChdp5KV6kEqBWLBbUOwLhKimA2PEDV5p7qnvyFY5NZO9X1m4q2cF
         jCfT9095q4iI23ZbtRqISxiW2mM7fCVvc0hTq8/kQMDAW2mnlm+TVCo8mNHj7LYXg4Bg
         74Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780469087; x=1781073887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vguV3vMU4h/2CSVTFHkBd4daU9WvVPcYCYkqg5eye6Q=;
        b=enNk+SMVuIEq61Mdylg3r4nSnwvR+wQdRVrjLxHkWe9DrAqqR1ovt2CnYvOykXbD0d
         DsJ3NV56dfmHp/2q/4YeIeT/KjdKHZP3Utcji61lsBJ6giJ1LygK4peCy9+rVVK4Ct+m
         AHwm0WGfKmt3cGe8S9ftNJ5SqiIKHb6MFzac/RLM1VTSNdmQPK0uZbzxRThwNevQbKtv
         1xe3mdbnfhD4DPFMhgyGtlhrKp8qamToi/0jrJ71YgHmctjkpdCeQF8kM4PhC4FQ1h9d
         24zIV11GDdODlq24mDEe/KqxvE/ByAx+NsdMhxyhoTMets1gDShxHyiNaQjIQuG9gVan
         m0gw==
X-Forwarded-Encrypted: i=1; AFNElJ8V+U00XGLwIc7Znj68b0jTCxxOpWv6XZoFeszwDBxGToDYnYnROAWE1fA7nECw5ILllGZnqNPUVgSWdno=@lists.linux.dev
X-Gm-Message-State: AOJu0YzqbRVTXsentUo1tnbahKB2wz2MJ+exeoI8gqeRUfJMtwsgP3xN
	hNX85sQ9cePMYFAf1Fczl6DAXCsC+avEYzWAqlh3c36V8WwPDGqqYrAxUrqTTzFE+xx0xCnHfjZ
	mti0CZz3dlx4H8tRWrp+zk514tA1VEtqLE8mP3Y/0lQ==
X-Gm-Gg: Acq92OEJFOE4btAudpgogazaWcb5zpckvjm+xg06TZzS9YzkDKCDknEOCSLiLgF9HMD
	pcRuS+85SHVIOyxQ2WFbb4Db1eEstSKVYTO2WvfwlXZgOgoQdyVIIHpmmnITLFGnYcCWJIGQDUI
	y69Doio01OF6fWi7NVlbO8sF3ibUUN3DfIFfUTR5hI7tvGn+5fr9SrDBNQRykN2RL/eZ7ny4hpU
	uBgI1w68K1cIQ+I4wIVZIr6eOm+LEUXtWQb319bJ11v2SD6vzoOzayKrWUhsjiSTrX60eEyYCxm
	pOsVCSc8A8sB5RH62ZBYawG6Jt66OUAbKxHL7vZRucMK9rRmz160XgUjVQKxCp/wBZcCTX3TbOs
	pFXn1jNZgMafDut8oVWzzLGWXDUDp0cXuKr/0+Q==
X-Received: by 2002:a05:6820:f014:b0:694:8fe0:152e with SMTP id
 006d021491bc7-69e48cf5960mr936756eaf.31.1780469087406; Tue, 02 Jun 2026
 23:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260526145240.1627200-1-anup.patel@oss.qualcomm.com> <89e1334f-e7c2-4992-ba39-0d23f5605275@arm.com>
In-Reply-To: <89e1334f-e7c2-4992-ba39-0d23f5605275@arm.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 3 Jun 2026 12:14:36 +0530
X-Gm-Features: AVHnY4JmV0zm-0tTvkp_o34WcjHkNEMQ2AMhT0fQwQmHlV9bWdR1bNfsmtDJXa0
Message-ID: <CAAhSdy0dOeCrH2YEkEyrNQU2nyO-41AT3m4-BaYJuQ3GbocqmQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: platform: Setup device MSI domain just
 before driver probe
To: Robin Murphy <robin.murphy@arm.com>
Cc: Anup Patel <anup.patel@oss.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Tomasz Jeznach <tomasz.jeznach@linux.dev>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Saket Dumbre <saket.dumbre@intel.com>, Rahul Pathak <rahul@summations.net>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	driver-core@lists.linux.dev, iommu@lists.linux.dev, 
	acpica-devel@lists.linux.dev, Sunil V L <sunilvl@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 8:53=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 26/05/2026 3:52 pm, Anup Patel wrote:
> > On RISC-V, the MSI controller (aka RISC-V IMSIC) is probed as a regular
> > platform device and MSI client drivers are always probed after the MSI
> > controller driver using fw_devlink. Unfortunately, this is not sufficie=
nt
> > to ensure device MSI domain is set for MSI client devices before driver
> > probe because OF framework sets device MSI domain at the time of platfo=
rm
> > device creation whereas ACPI framework expects arch specific code to se=
t
> > the device MSI domain at the time of platform device creation.
> >
> > Currently, to work-around the problem of missing device MSI domain,
> > various RISC-V MSI client drivers explicitly set device MSI domain
> > in the driver probe function using below code pattern:
> >
> >       /*
> >        * The device MSI domain for platform devices on RISC-V architect=
ure
> >        * is only available after the MSI controller driver is probed so=
,
> >        * explicitly configure here.
> >        */
> >       if (!dev_get_msi_domain(dev)) {
> >               /*
> >                * The device MSI domain for OF devices is only set at th=
e
> >                * time of populating/creating OF device. If the device M=
SI
> >                * domain is discovered later after the OF device is crea=
ted
> >                * then we need to set it explicitly before using any pla=
tform
> >                * MSI functions.
> >                */
> >               if (is_of_node(fwnode)) {
> >                       of_msi_configure(dev, dev_of_node(dev));
> >               } else if (is_acpi_device_node(fwnode)) {
> >                       struct irq_domain *msi_domain;
> >                       msi_domain =3D irq_find_matching_fwnode(imsic_acp=
i_get_fwnode(dev),
> >                                                             DOMAIN_BUS_=
PLATFORM_MSI);
> >                       dev_set_msi_domain(dev, msi_domain);
> >               }
> >
> >               if (!dev_get_msi_domain(dev))
> >                       return -EPROBE_DEFER;
> >       }
> >
> > Instead of the above approach, extend the platform_dma_configure() to s=
et
> > device MSI domain for both OF and ACPI based platform devices before dr=
iver
> > probe and remove the duplicate code pattern from RISC-V MSI client driv=
ers.
> >
> > Co-developed-by: Sunil V L <sunilvl@oss.qualcomm.com>
> > Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
> > Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
> > ---
> >   drivers/acpi/riscv/irq.c                | 13 +++++++++++
> >   drivers/acpi/scan.c                     | 10 +++++++++
> >   drivers/base/platform.c                 |  4 ++++
> >   drivers/iommu/riscv/iommu-platform.c    |  9 --------
> >   drivers/irqchip/irq-riscv-aplic-msi.c   | 27 -----------------------
> >   drivers/irqchip/irq-riscv-rpmi-sysmsi.c | 29 ------------------------=
-
> >   drivers/mailbox/riscv-sbi-mpxy-mbox.c   | 29 ------------------------=
-
> >   include/acpi/acpi_bus.h                 |  1 +
> >   include/linux/acpi.h                    | 10 +++++++++
> >   9 files changed, 38 insertions(+), 94 deletions(-)
> >
> > diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
> > index 9b88d0993e88..17fa5dcdd2c0 100644
> > --- a/drivers/acpi/riscv/irq.c
> > +++ b/drivers/acpi/riscv/irq.c
> > @@ -5,8 +5,11 @@
> >    */
> >
> >   #include <linux/acpi.h>
> > +#include <linux/device.h>
> >   #include <linux/sort.h>
> >   #include <linux/irq.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/irqchip/riscv-imsic.h>
> >
> >   #include "init.h"
> >
> > @@ -397,6 +400,16 @@ static u32 riscv_acpi_add_irq_dep(acpi_handle hand=
le)
> >       return count;
> >   }
> >
> > +void acpi_arch_msi_configure(struct device *dev)
> > +{
> > +     struct irq_domain *msi_domain;
> > +
> > +     msi_domain =3D irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev=
),
> > +                                           DOMAIN_BUS_PLATFORM_MSI);
> > +     if (msi_domain)
> > +             dev_set_msi_domain(dev, msi_domain);
> > +}
> > +
> >   u32 arch_acpi_add_auto_dep(acpi_handle handle)
> >   {
> >       if (acpi_has_method(handle, "_PRT"))
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 530547cda8b2..e50e5d246a54 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -1648,6 +1648,16 @@ static int acpi_iommu_configure_id(struct device=
 *dev, const u32 *id_in)
> >
> >   #endif /* !CONFIG_IOMMU_API */
> >
> > +/**
> > + * acpi_msi_configure - Set-up MSI domain for the device.
> > + * @dev: The pointer to the device
> > + */
> > +void acpi_msi_configure(struct device *dev)
> > +{
> > +     acpi_arch_msi_configure(dev);
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_msi_configure);
> > +
> >   /**
> >    * acpi_dma_configure_id - Set-up DMA configuration for the device.
> >    * @dev: The pointer to the device
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index a19dd22deef2..225e33080bc6 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -1470,8 +1470,12 @@ static int platform_dma_configure(struct device =
*dev)
> >       int ret =3D 0;
> >
> >       if (is_of_node(fwnode)) {
> > +             if (!dev_get_msi_domain(dev))
> > +                     of_msi_configure(dev, dev->of_node);
> >               ret =3D of_dma_configure(dev, to_of_node(fwnode), true);
> >       } else if (is_acpi_device_node(fwnode)) {
> > +             if (!dev_get_msi_domain(dev))
> > +                     acpi_msi_configure(dev);
>
> But surely this needs to handle the deferral case that's being removed
> from some of the users below?

The deferral cases removed by this patch are redundant because:
1) For device tree, the fw_devlink support in Linux DD core takes
case of probe ordering and individual driver don't need to explicitly
do EPROBE_DEFER
2) For ACPI, the _DEP objects helps us ensure probe ordering.

In other words, the issue of probe ordering or deferral is already
handled for both device tree and ACPI.

The only problem which remains is msi_domain pointer not set
in struct device before the driver is probed. This happens because
MSI controller driver is a regular platform driver hence MSI domain
pointer is not set when platform devices are created.

>
> Also I'm not really convinced about bundling it into dma_configure,
> since it's mroe about IRQs than DMA. I wonder if overall it wouldn't be

Using platform_dma_configure() to update the MSI domain
in struct device is appropriate because:
1) MSIs are device initiated writes just like DMA writes
    initiated by the device.
2) The iommu_device_use_default_domain() called by
   platform_dma_configure() will override MSI domain
   in struct device for architectures (such as x86 and
   RISC-V) where IOMMU driver implements a IRQ
   remap MSI domain for MSI capable devices.

> better with a flow closer to regular request_irq(), with
> msi_create_device_irq_domain() growing the ability to distingush between
> "there is no domain" and "there is no domain now, but could be if we try
> again later", such that drivers can handle deferral at the point where
> they request MSI vectors?

Like mentioned above, the problem is not about probe deferral
(aka returning EPROBE_DEFER) from request_irq() or
msi_create_device_irq_domain() rather about updating the
MSI domain pointer in struct device before driver probe.

Regards,
Anup
