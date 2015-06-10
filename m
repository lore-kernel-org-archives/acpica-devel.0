Content-Type: multipart/mixed; boundary="===============0800927543639466202=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 1/1 linux-next] ACPICA: use swap() in
 acpi_ns_sort_list()
Date: Wed, 10 Jun 2015 16:48:26 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F327A@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 1433953975-24445-1-git-send-email-fabf@skynet.be
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0800927543639466202==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I don't think this is portable across operating systems. Which is a require=
ment for ACPICA.



> -----Original Message-----
> From: Fabian Frederick [mailto:fabf(a)skynet.be]
> Sent: Wednesday, June 10, 2015 9:33 AM
> To: linux-kernel(a)vger.kernel.org
> Cc: Julia Lawall; Fabian Frederick; Moore, Robert; Zheng, Lv; Wysocki,
> Rafael J; Len Brown; linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> Subject: [PATCH 1/1 linux-next] ACPICA: use swap() in acpi_ns_sort_list()
> =

> Use kernel.h macro definition.
> =

> Thanks to Julia Lawall for Coccinelle scripting support.
> =

> Signed-off-by: Fabian Frederick <fabf(a)skynet.be>
> ---
>  drivers/acpi/acpica/nsrepair2.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> =

> diff --git a/drivers/acpi/acpica/nsrepair2.c
> b/drivers/acpi/acpica/nsrepair2.c index c30672d..7513799 100644
> --- a/drivers/acpi/acpica/nsrepair2.c
> +++ b/drivers/acpi/acpica/nsrepair2.c
> @@ -904,7 +904,6 @@ acpi_ns_sort_list(union acpi_operand_object
> **elements,  {
>  	union acpi_operand_object *obj_desc1;
>  	union acpi_operand_object *obj_desc2;
> -	union acpi_operand_object *temp_obj;
>  	u32 i;
>  	u32 j;
> =

> @@ -920,11 +919,8 @@ acpi_ns_sort_list(union acpi_operand_object
> **elements,
>  			      obj_desc2->integer.value))
>  			    || ((sort_direction =3D=3D ACPI_SORT_DESCENDING)
>  				&& (obj_desc1->integer.value <
> -				    obj_desc2->integer.value))) {
> -				temp_obj =3D elements[j - 1];
> -				elements[j - 1] =3D elements[j];
> -				elements[j] =3D temp_obj;
> -			}
> +				    obj_desc2->integer.value)))
> +				swap(elements[j - 1], elements[j]);
>  		}
>  	}
>  }
> --
> 2.4.2


--===============0800927543639466202==--

