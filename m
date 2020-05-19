Content-Type: multipart/mixed; boundary="===============7738470154896451882=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPICA: Replace one-element array and use
 struct_size() helper
Date: Tue, 19 May 2020 12:25:13 +0200
Message-ID: <CAJZ5v0goZpvRQ6du214FqvFNQnqZHR9-kz=WhEgRsMJ3Zx0WiQ@mail.gmail.com>
In-Reply-To: 20200518222722.GA7791@embeddedor
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7738470154896451882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 12:22 AM Gustavo A. R. Silva
<gustavoars(a)kernel.org> wrote:
>
> The current codebase makes use of one-element arrays in the following
> form:
>
> struct something {
>     int length;
>     u8 data[1];
> };
>
> struct something *instance;
>
> instance =3D kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> instance->length =3D size;
> memcpy(instance->data, source, size);
>
> but the preferred mechanism to declare variable-length types such as
> these ones is a flexible array member[1][2], introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.

However, the ACPICA code in the kernel comes from an external project
and changes of this type are generally not applicable to it unless
accepted upstream.

I'll let Erik and Bob take over.

> Also, make use of the new struct_size() helper to properly calculate the
> size of struct acpi_pnp_device_id_list.
>
> This issue was found with the help of Coccinellea and, audited and
> fixed _manually_.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars(a)kernel.org>
> ---
>  drivers/acpi/acpica/utids.c | 4 +---
>  include/acpi/actypes.h      | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
> index 3bb06935a2ad3..c2f819a39424a 100644
> --- a/drivers/acpi/acpica/utids.c
> +++ b/drivers/acpi/acpica/utids.c
> @@ -262,9 +262,7 @@ acpi_ut_execute_CID(struct acpi_namespace_node *devic=
e_node,
>          * 2) Size of the CID PNP_DEVICE_ID array +
>          * 3) Size of the actual CID strings
>          */
> -       cid_list_size =3D sizeof(struct acpi_pnp_device_id_list) +
> -           ((count - 1) * sizeof(struct acpi_pnp_device_id)) +
> -           string_area_size;
> +       cid_list_size =3D struct_size(cid_list, ids, count) + string_area=
_size;
>
>         cid_list =3D ACPI_ALLOCATE_ZEROED(cid_list_size);
>         if (!cid_list) {
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index 4defed58ea338..c7bcda0ad366a 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -1145,7 +1145,7 @@ struct acpi_pnp_device_id {
>  struct acpi_pnp_device_id_list {
>         u32 count;              /* Number of IDs in Ids array */
>         u32 list_size;          /* Size of list, including ID strings */
> -       struct acpi_pnp_device_id ids[1];       /* ID array */
> +       struct acpi_pnp_device_id ids[];        /* ID array */
>  };
>
>  /*
> --
> 2.26.2
>
--===============7738470154896451882==--

