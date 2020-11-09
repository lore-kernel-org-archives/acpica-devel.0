Content-Type: multipart/mixed; boundary="===============6981920484856454187=="
MIME-Version: 1.0
From: Sami Mujawar <Sami.Mujawar at arm.com>
Subject: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node
 parsing
Date: Mon, 09 Nov 2020 12:29:39 +0000
Message-ID: <
 <DB7PR08MB3097062CEEDB4635BF3F694784EA0@DB7PR08MB3097.eurprd08.prod.outlook.com>>
In-Reply-To: d414a22fbae9575e6c04f4a557ae49a2cd8eac57.camel@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6981920484856454187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

-----Original Message-----
From: David E. Box <david.e.box(a)linux.intel.com> =

Sent: 28 October 2020 06:44 PM
To: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>; linux-arm-ke=
rnel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org; iommu(a)lists.lin=
ux-foundation.org; devel(a)acpica.org
Cc: linuxarm(a)huawei.com; Lorenzo Pieralisi <Lorenzo.Pieralisi(a)arm.com>;=
 joro(a)8bytes.org; Robin Murphy <Robin.Murphy(a)arm.com>; wanghuiqiang(a)h=
uawei.com; jonathan.cameron(a)huawei.com
Subject: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node pa=
rsing

Hi,

On Tue, 2020-10-27 at 11:26 +0000, Shameer Kolothum wrote:

...

> @@ -1647,6 +1667,100 @@ static void __init iort_enable_acs(struct
> acpi_iort_node *iort_node)
>  #else
>  static inline void iort_enable_acs(struct acpi_iort_node *iort_node)
> { }
>  #endif
> +static int iort_rmr_desc_valid(struct acpi_iort_rmr_desc *desc)
> +{
> +	struct iort_rmr_entry *e;
> +	u64 end, start =3D desc->base_address, length =3D desc->length;
> +
> +	if ((!IS_ALIGNED(start, SZ_64K)) || (length % SZ_64K !=3D 0))

You could just do:

if ((!IS_ALIGNED(start, SZ_64K)) || (length % SZ_64K))

[SAMI] In my opinion, the following may be better:
	if (!IS_ALIGNED(start, SZ_64K) || !IS_ALIGNED(length, SZ_64K)) =

[/SAMI]

Regards,

Sami Mujawar

David
_______________________________________________
Devel mailing list -- devel(a)acpica.org
To unsubscribe send an email to devel-leave(a)acpica.org
%(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
--===============6981920484856454187==--

