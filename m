Content-Type: multipart/mixed; boundary="===============1150730249937286583=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH]
 tools/power/acpi/os_specific/service_layers/osunixxf.c:remove unnecessary
 (void*) conversions
Date: Tue, 23 Aug 2022 19:12:52 +0200
Message-ID: <CAJZ5v0iQsmPS2F-hTKhhHho2+=UgAfag6jNs=m-WQY0CL6t=Lw@mail.gmail.com>
In-Reply-To: 20220822062420.4815-1-chuanjian@nfschina.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1150730249937286583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2022 at 8:24 AM Dong Chuanjian <chuanjian(a)nfschina.com> w=
rote:
>
> remove unnecessary void* type casting
>
> Signed-off-by: Dong Chuanjian <chuanjian(a)nfschina.com>

This is ACPICA code, so please submit changes against it to the
upstream ACPICA project on GitHub.  Thanks!

> diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/too=
ls/power/acpi/os_specific/service_layers/osunixxf.c
> index b3651a04d68c..a7e65fb95caf 100644
> --- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
> +++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
> @@ -679,7 +679,7 @@ acpi_os_create_semaphore(u32 max_units,
>
>  acpi_status acpi_os_delete_semaphore(acpi_handle handle)
>  {
> -       sem_t *sem =3D (sem_t *) handle;
> +       sem_t *sem =3D handle;
>
>         if (!sem) {
>                 return (AE_BAD_PARAMETER);
> @@ -715,7 +715,7 @@ acpi_status
>  acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 msec_timeout)
>  {
>         acpi_status status =3D AE_OK;
> -       sem_t *sem =3D (sem_t *) handle;
> +       sem_t *sem =3D handle;
>         int ret_val;
>  #ifndef ACPI_USE_ALTERNATE_TIMEOUT
>         struct timespec time;
> @@ -832,7 +832,7 @@ acpi_os_wait_semaphore(acpi_handle handle, u32 units,=
 u16 msec_timeout)
>
>  acpi_status acpi_os_signal_semaphore(acpi_handle handle, u32 units)
>  {
> -       sem_t *sem =3D (sem_t *) handle;
> +       sem_t *sem =3D handle;
>
>         if (!sem) {
>                 return (AE_BAD_PARAMETER);
> --
> 2.18.2
>
--===============1150730249937286583==--

