Content-Type: multipart/mixed; boundary="===============4282801564048459221=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPI/ACPICA: Check for NULL pointer after calling
 alloc
Date: Fri, 14 Jan 2022 19:09:18 +0100
Message-ID: <CAJZ5v0j5LVV_gV_K45YqFPqtBcS423VP0x_Uos7MtKBeqWkg5A@mail.gmail.com>
In-Reply-To: 20220114101546.1368163-1-jiasheng@iscas.ac.cn
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4282801564048459221==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 14, 2022 at 11:16 AM Jiasheng Jiang <jiasheng(a)iscas.ac.cn> wr=
ote:
>
> As the possible failure of the allocation, object_info could be NULL
> pointer.
> Therefore, it should be better to check it in order to avoid the
> dereference of the NULL pointer.
> If fails, we should return 'AE_NON_MEMORY' and the caller
> acpi_db_command_dispatch() will deal with the return status of
> acpi_db_display_objects().
> Also, the comment of the acpi_db_display_objects() is wrong.
> So we need to correct it too.
>
> Fixes: 995751025572 ("ACPICA: Linuxize: Export debugger files to Linux")
> Signed-off-by: Jiasheng Jiang <jiasheng(a)iscas.ac.cn>

This is ACPICA material, so it needs to be submitted to the upstream
ACPICA project via https://github.com/acpica/acpica, thanks!

> ---
>  drivers/acpi/acpica/dbnames.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
> index 3615e1a6efd8..d8e5852fadb1 100644
> --- a/drivers/acpi/acpica/dbnames.c
> +++ b/drivers/acpi/acpica/dbnames.c
> @@ -632,7 +632,7 @@ acpi_db_walk_for_specific_objects(acpi_handle obj_han=
dle,
>   * PARAMETERS:  obj_type_arg        - Type of object to display
>   *              display_count_arg   - Max depth to display
>   *
> - * RETURN:      None
> + * RETURN:      Status
>   *
>   * DESCRIPTION: Display objects in the namespace of the requested type
>   *
> @@ -651,6 +651,8 @@ acpi_status acpi_db_display_objects(char *obj_type_ar=
g, char *display_count_arg)
>         if (!obj_type_arg) {
>                 object_info =3D
>                     ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_object_info));
> +               if (!object_info)
> +                       return (AE_NO_MEMORY);
>
>                 /* Walk the namespace from the root */
>
> --
> 2.25.1
>
--===============4282801564048459221==--

