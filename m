Content-Type: multipart/mixed; boundary="===============7926216665334689044=="
MIME-Version: 1.0
From: David E. Box <david.e.box at linux.intel.com>
Subject: [Devel] Re: [RFC PATCH 2/4] ACPI/IORT: Add support for RMR node
 parsing
Date: Wed, 28 Oct 2020 11:43:48 -0700
Message-ID: <d414a22fbae9575e6c04f4a557ae49a2cd8eac57.camel@linux.intel.com>
In-Reply-To: 20201027112646.44680-3-shameerali.kolothum.thodi@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7926216665334689044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

David

--===============7926216665334689044==--

