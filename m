Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6D33DBAB
	for <acpica-devel@lists.linux.dev>; Wed,  6 Dec 2023 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-58de9deec94so561448eaf.0
        for <acpica-devel@lists.linux.dev>; Wed, 06 Dec 2023 08:35:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880551; x=1702485351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnltdkPvqiE0SLkWecJ3YZb5+WkHMQll5p7sUNdf2Nw=;
        b=gbEDkJSJeYXo1yfCA5QXXGQlc5IJJETl6EhFYoSD7oMS21uldfiAVdcthQkllpEOuZ
         6Hq7HrrVadCYdsi3x5o/KbQu87VELN5Sl05Mo5+dVc/V2wUJolggnakJOS+YxScJe0i6
         VwipgblK+DORJbRpFLr4Nzo4PPQtcPq28Ddb2MBu2RL/cNYo5jjkmFEwY7FcnAECulH1
         raBKxbX1k3SwCKqT5Fu47SQ1Nd29M2aINJHto3jX3QNhYLlid3EpjYnBl1F+H+zy+SL6
         ZKbItGK/odP8viN6UzF43CJe52cNCgBdtF5BFanG4UwXvDsUwSoI7XDPgfMtR2SJOaet
         ImBQ==
X-Gm-Message-State: AOJu0Yz9/sY5v6COZ8bUzPh3tHYt3SERupsREpx4qoQpQdKrg91kNFvn
	4jWTH6n1K9EQPk5foEOMCkc1MuRU/JlHpn8+kZc=
X-Google-Smtp-Source: AGHT+IFpMFlVK/t1b9fMj+2PJaVuQaOhHx6XBFAUEimHYj1Jk1xeQUg3ZGuroBcDfz+Jv7tTpUepQpBmwwfHs/85uO4=
X-Received: by 2002:a05:6870:b4a0:b0:1fb:5e42:5096 with SMTP id
 y32-20020a056870b4a000b001fb5e425096mr1917272oap.5.1701880551180; Wed, 06 Dec
 2023 08:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231115091612.580685-1-LeoLiu-oc@zhaoxin.com> <20231115091612.580685-2-LeoLiu-oc@zhaoxin.com>
In-Reply-To: <20231115091612.580685-2-LeoLiu-oc@zhaoxin.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 17:35:38 +0100
Message-ID: <CAJZ5v0ig2+uv4kF0SjAByvcmBF9auhY_1OVrJvjKTVJK23=cSg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI/APEI: Add hest_parse_pcie_aer()
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, 
	tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com, 
	robert.moore@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	acpica-devel@lists.linux.dev, CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, 
	ErosZhang@zhaoxin.com, LeoLiu@zhaoxin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 10:16=E2=80=AFAM LeoLiu-oc <LeoLiu-oc@zhaoxin.com> =
wrote:
>
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
>
> The purpose of the function apei_hest_parse_aer() is used to parse and
> extract register value from HEST PCIe AER structures.
>
> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
> ---
>  drivers/acpi/apei/hest.c | 77 ++++++++++++++++++++++++++++++++++++++--
>  include/acpi/actbl1.h    |  7 ++++
>  include/acpi/apei.h      |  8 +++++
>  3 files changed, 90 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index 6aef1ee5e1bd..7fb797fdc1b1 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -22,6 +22,7 @@
>  #include <linux/kdebug.h>
>  #include <linux/highmem.h>
>  #include <linux/io.h>
> +#include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <acpi/apei.h>
>  #include <acpi/ghes.h>
> @@ -86,9 +87,81 @@ static int hest_esrc_len(struct acpi_hest_header *hest=
_hdr)
>         return len;
>  };
>
> -typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void =
*data);
> +#ifdef CONFIG_ACPI_APEI
> +static bool hest_match_pci_devfn(struct acpi_hest_aer_common *p,
> +                               struct pci_dev *dev)
> +{
> +       return ACPI_HEST_SEGMENT(p->bus) =3D=3D pci_domain_nr(dev->bus) &=
&
> +               ACPI_HEST_BUS(p->bus) =3D=3D dev->bus->number &&
> +               p->device =3D=3D PCI_SLOT(dev->devfn) &&
> +               p->function =3D=3D PCI_FUNC(dev->devfn);
> +}
> +
> +static bool hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr,
> +                               struct pci_dev *dev)
> +{
> +       u16 hest_type =3D hest_hdr->type;
> +       u8 pcie_type =3D pci_pcie_type(dev);
> +       struct acpi_hest_aer_common *common;
> +
> +       common =3D (struct acpi_hest_aer_common *)(hest_hdr + 1);
> +
> +       switch (hest_type) {
> +       case ACPI_HEST_TYPE_AER_ROOT_PORT:
> +               if (pcie_type !=3D PCI_EXP_TYPE_ROOT_PORT)
> +                       return false;
> +       break;
> +       case ACPI_HEST_TYPE_AER_ENDPOINT:
> +               if (pcie_type !=3D PCI_EXP_TYPE_ENDPOINT)
> +                       return false;
> +       break;
> +       case ACPI_HEST_TYPE_AER_BRIDGE:
> +               if (pcie_type !=3D PCI_EXP_TYPE_PCI_BRIDGE &&
> +                   pcie_type !=3D PCI_EXP_TYPE_PCIE_BRIDGE)
> +                       return false;
> +       break;
> +       default:
> +               return false;
> +       break;
> +       }
> +
> +       if (common->flags & ACPI_HEST_GLOBAL)
> +               return true;
> +
> +       if (hest_match_pci_devfn(common, dev))
> +               return true;
> +
> +       return false;
> +}
> +
> +int hest_parse_pcie_aer(struct acpi_hest_header *hest_hdr, void *data)
> +{
> +       struct hest_parse_aer_info *info =3D data;
> +
> +       if (!hest_source_is_pcie_aer(hest_hdr, info->pci_dev))
> +               return 0;
> +
> +       switch (hest_hdr->type) {
> +       case ACPI_HEST_TYPE_AER_ROOT_PORT:
> +               info->hest_aer_root_port =3D (struct acpi_hest_aer_root *=
)hest_hdr;
> +               return 1;
> +       break;
> +       case ACPI_HEST_TYPE_AER_ENDPOINT:
> +               info->hest_aer_endpoint =3D (struct acpi_hest_aer *)hest_=
hdr;
> +               return 1;
> +       break;
> +       case ACPI_HEST_TYPE_AER_BRIDGE:
> +               info->hest_aer_bridge =3D (struct acpi_hest_aer_bridge *)=
hest_hdr;
> +               return 1;
> +       break;
> +       default:
> +               return 0;
> +       break;
> +       }
> +}
> +#endif
>
> -static int apei_hest_parse(apei_hest_func_t func, void *data)
> +int apei_hest_parse(apei_hest_func_t func, void *data)
>  {
>         struct acpi_hest_header *hest_hdr;
>         int i, rc, len;
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index a33375e055ad..90c27dc5325f 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h

This is an ACPICA header and it cannot be modified just like this.

The way to do that is to submit a pull request with the desired change
to the upstream ACPICA project on GitHub and add a Link tag pointing
to the upstream PR to the corresponding Linux patch.  Then, the Linux
patch can only be applied after the corresponding upstream PR has been
merged.

Thanks!

> @@ -1629,6 +1629,13 @@ struct acpi_hest_generic_status {
>         u32 error_severity;
>  };
>
> +struct hest_parse_aer_info {
> +       struct pci_dev *pci_dev;
> +       struct acpi_hest_aer *hest_aer_endpoint;
> +       struct acpi_hest_aer_root *hest_aer_root_port;
> +       struct acpi_hest_aer_bridge *hest_aer_bridge;
> +};
> +
>  /* Values for block_status flags above */
>
>  #define ACPI_HEST_UNCORRECTABLE             (1)
> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
> index dc60f7db5524..d12e6b6c4546 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -33,10 +33,18 @@ void __init acpi_ghes_init(void);
>  static inline void acpi_ghes_init(void) { }
>  #endif
>
> +typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void =
*data);
> +int apei_hest_parse(apei_hest_func_t func, void *data);
> +
>  #ifdef CONFIG_ACPI_APEI
>  void __init acpi_hest_init(void);
> +int hest_parse_pcie_aer(struct acpi_hest_header *hest_hdr, void *data);
>  #else
>  static inline void acpi_hest_init(void) { }
> +static inline int hest_parse_pcie_aer(struct acpi_hest_header *hest_hdr,=
 void *data)
> +{
> +       return 0;
> +}
>  #endif
>
>  int erst_write(const struct cper_record_header *record);
> --
> 2.34.1
>
