Content-Type: multipart/mixed; boundary="===============5832531508431299723=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPICA: DEBUGGER: Add return value check to
 acpi_db_walk_for_fields()
Date: Thu, 30 Dec 2021 17:31:49 +0100
Message-ID: <CAJZ5v0jef5a=3w6bsh6CwEYixTwVgTaT6BBwYym3Sut6KToJsg@mail.gmail.com>
In-Reply-To: 20211229174058.11350-1-shenzijun@kylinos.cn
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5832531508431299723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 29, 2021 at 10:41 AM shenzijun <shenzijun(a)kylinos.cn> wrote:
>
> From: Zijun Shen <shenzijun(a)kylinos.cn>
>
> The function acpi_db_walk_for_fields frees buffer.pointer by the
> first ACPI_FREE. And then uses the second ACPI_FREE to free
> buffer.pointer which may assigns again in acpi_evaluate_object.
> It's necessary to make sure that buffer.pointer get a block of
> memory in acpi_evaluate_object and acpi_evaluate_object return 0.
>
> Signed-off-by: Zijun Shen <shenzijun(a)kylinos.cn>
> ---
>  drivers/acpi/acpica/dbnames.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
> index 3615e1a6efd8..7a2d980cb2b8 100644
> --- a/drivers/acpi/acpica/dbnames.c
> +++ b/drivers/acpi/acpica/dbnames.c
> @@ -550,7 +550,10 @@ acpi_db_walk_for_fields(acpi_handle obj_handle,
>         ACPI_FREE(buffer.pointer);
>
>         buffer.length =3D ACPI_ALLOCATE_LOCAL_BUFFER;
> -       acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
> +       status =3D acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
> +       if (ACPI_FAILURE(status)) {
> +               return (AE_OK);
> +       }
>
>         /*
>          * Since this is a field unit, surround the output in braces
> --


This is ACPICA material, so please submit it to the upstream ACPICA
project via https://github.com/acpica/acpica/

Thanks!
--===============5832531508431299723==--

