Content-Type: multipart/mixed; boundary="===============6458649774726088249=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 1/4] acpi: exsystem: Add units to time variable
 names
Date: Tue, 01 Mar 2022 20:40:26 +0100
Message-ID: <CAJZ5v0iCwJ10gM0+LsOMU9X3X4ToN_OHBW=9vVsfEP3+cRpudQ@mail.gmail.com>
In-Reply-To: 20220224113807.91771-1-pmenzel@molgen.mpg.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6458649774726088249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 12:38 PM Paul Menzel <pmenzel(a)molgen.mpg.de> wrot=
e:
>
> `how_long` uses different units in both functions, so make it more
> clear, what unit they expect.
>
> Signed-off-by: Paul Menzel <pmenzel(a)molgen.mpg.de>
> ---
>  drivers/acpi/acpica/exsystem.c | 20 ++++++++++----------

As ACPICA material, this should be submitted to the upstream project
via https://github.com/acpica/acpica/.

This applies to the other patches in the series too.

>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsyste=
m.c
> index 1281c07112de..6bc5b46e6927 100644
> --- a/drivers/acpi/acpica/exsystem.c
> +++ b/drivers/acpi/acpica/exsystem.c
> @@ -107,7 +107,7 @@ acpi_status acpi_ex_system_wait_mutex(acpi_mutex mute=
x, u16 timeout)
>   *
>   * FUNCTION:    acpi_ex_system_do_stall
>   *
> - * PARAMETERS:  how_long        - The amount of time to stall,
> + * PARAMETERS:  how_long_us     - The amount of time to stall,
>   *                                in microseconds
>   *
>   * RETURN:      Status
> @@ -120,13 +120,13 @@ acpi_status acpi_ex_system_wait_mutex(acpi_mutex mu=
tex, u16 timeout)
>   *
>   ***********************************************************************=
*******/
>
> -acpi_status acpi_ex_system_do_stall(u32 how_long)
> +acpi_status acpi_ex_system_do_stall(u32 how_long_us)
>  {
>         acpi_status status =3D AE_OK;
>
>         ACPI_FUNCTION_ENTRY();
>
> -       if (how_long > 255) {   /* 255 microseconds */
> +       if (how_long_us > 255) {        /* 255 microseconds */
>                 /*
>                  * Longer than 255 usec, this is an error
>                  *
> @@ -134,10 +134,10 @@ acpi_status acpi_ex_system_do_stall(u32 how_long)
>                  * order to support existing BIOSs)
>                  */
>                 ACPI_ERROR((AE_INFO,
> -                           "Time parameter is too large (%u)", how_long)=
);
> +                           "Time parameter is too large (%u)", how_long_=
us));
>                 status =3D AE_AML_OPERAND_VALUE;
>         } else {
> -               acpi_os_stall(how_long);
> +               acpi_os_stall(how_long_us);
>         }
>
>         return (status);
> @@ -147,7 +147,7 @@ acpi_status acpi_ex_system_do_stall(u32 how_long)
>   *
>   * FUNCTION:    acpi_ex_system_do_sleep
>   *
> - * PARAMETERS:  how_long        - The amount of time to sleep,
> + * PARAMETERS:  how_long_ms     - The amount of time to sleep,
>   *                                in milliseconds
>   *
>   * RETURN:      None
> @@ -156,7 +156,7 @@ acpi_status acpi_ex_system_do_stall(u32 how_long)
>   *
>   ***********************************************************************=
*******/
>
> -acpi_status acpi_ex_system_do_sleep(u64 how_long)
> +acpi_status acpi_ex_system_do_sleep(u64 how_long_ms)
>  {
>         ACPI_FUNCTION_ENTRY();
>
> @@ -168,11 +168,11 @@ acpi_status acpi_ex_system_do_sleep(u64 how_long)
>          * For compatibility with other ACPI implementations and to preve=
nt
>          * accidental deep sleeps, limit the sleep time to something reas=
onable.
>          */
> -       if (how_long > ACPI_MAX_SLEEP) {
> -               how_long =3D ACPI_MAX_SLEEP;
> +       if (how_long_ms > ACPI_MAX_SLEEP) {
> +               how_long_ms =3D ACPI_MAX_SLEEP;
>         }
>
> -       acpi_os_sleep(how_long);
> +       acpi_os_sleep(how_long_ms);
>
>         /* And now we must get the interpreter again */
>
> --
> 2.35.1
>
--===============6458649774726088249==--

