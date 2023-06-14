Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D3455417B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F87F404D5
MIME-Version: 1.0
References: <20230614162112.122816-1-cymi20@fudan.edu.cn>
In-Reply-To: <20230614162112.122816-1-cymi20@fudan.edu.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Jun 2023 18:40:39 +0200
Message-ID: <CAJZ5v0iZMHmgGE7ZTmOghHtWPXECx5HFt2a1NBNwABBX0CQBeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH] ACPICA: Fix missing check for return
	value of acpi_ns_get_attached_object()
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Chenyuan Mi <cymi20@fudan.edu.cn>
Cc: rafael.j.wysocki@intel.com, robert.moore@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, lenb@kernel.org

On Wed, Jun 14, 2023 at 6:21=E2=80=AFPM Chenyuan Mi <cymi20@fudan.edu.cn> w=
rote:
>
> The acpi_ns_get_attached_object() function may return
> NULL, which may cause null pointer deference, and most
> other callsites of acpi_ns_get_attached_object() do
> Null check. Add Null check for return value of
> acpi_ns_get_attached_object().

But may acpi_ex_prep_field_value() be called in a code path where
acpi_ns_get_attached_object(i) can return NULL?

I mean, if the given attached object is guaranteed to exist when this
function is called, NULL will not be returned, so the new check will
be redundant then.

> Found by our static analysis tool.
>
> Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
> ---
>  drivers/acpi/acpica/exprep.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
> index 08196fa17080..d9c006ec1ac8 100644
> --- a/drivers/acpi/acpica/exprep.c
> +++ b/drivers/acpi/acpica/exprep.c
> @@ -431,6 +431,13 @@ acpi_status acpi_ex_prep_field_value(struct acpi_cre=
ate_field_info *info)
>                 obj_desc->field.region_obj =3D
>                     acpi_ns_get_attached_object(info->region_node);
>
> +               if (!obj_desc->field.region_obj) {
> +                       ACPI_ERROR((AE_INFO,
> +                                   "Null Region Object during field prep=
"));
> +                       acpi_ut_delete_object_desc(obj_desc);
> +                       return_ACPI_STATUS(AE_AML_INTERNAL);
> +               }
> +
>                 /* Fields specific to generic_serial_bus fields */
>
>                 obj_desc->field.access_length =3D info->access_length;
> --
> 2.17.1
>
