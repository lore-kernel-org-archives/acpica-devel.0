Content-Type: multipart/mixed; boundary="===============5299628586393830348=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPICA: Linuxize: Fix a NULL pointer dereference
 in acpi_db_convert_to_package()
Date: Thu, 27 Jan 2022 20:58:39 +0100
Message-ID: <CAJZ5v0iVEQVMn4K6007jUaiJ1CNhaCTePhLSBrX=mONswM98-g@mail.gmail.com>
In-Reply-To: 20220124164014.51658-1-zhou1615@umn.edu
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5299628586393830348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 24, 2022 at 5:45 PM Zhou Qingyang <zhou1615(a)umn.edu> wrote:
>
> In acpi_db_convert_to_package(), the variable elements is assigned by
> ACPI_ALLOCATE_ZEROED() and passes its address to
> acpi_db_convert_to_object(). In that function we may have a dereference
> of elements without checks. ACPI_ALLOCATE_ZEROED() would return NULL on
> failure, which may lead to NULL pointer dereference.
>
> Fix this bug by adding a NULL check of elements.
>
> This bug was found by a static analyzer.
>
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
>
> Fixes: 995751025572 ("ACPICA: Linuxize: Export debugger files to Linux")
> Signed-off-by: Zhou Qingyang <zhou1615(a)umn.edu>

This is ACPICA material and so it should be submitted as a change
against the upstream code via https://github.com/acpica/acpica

Thanks!

> ---
> The analysis employs differential checking to identify inconsistent
> security operations (e.g., checks or kfrees) between two code paths
> and confirms that the inconsistent operations are not recovered in the
> current function or the callers, so they constitute bugs.
>
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
>
>  drivers/acpi/acpica/dbconvert.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconv=
ert.c
> index 2b84ac093698..8dbab6932049 100644
> --- a/drivers/acpi/acpica/dbconvert.c
> +++ b/drivers/acpi/acpica/dbconvert.c
> @@ -174,6 +174,8 @@ acpi_status acpi_db_convert_to_package(char *string, =
union acpi_object *object)
>         elements =3D
>             ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
>                                  sizeof(union acpi_object));
> +       if (!elements)
> +               return (AE_NO_MEMORY);
>
>         this =3D string;
>         for (i =3D 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
> --
> 2.25.1
>
--===============5299628586393830348==--

