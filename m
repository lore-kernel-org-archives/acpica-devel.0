Content-Type: multipart/mixed; boundary="===============5506540639592428591=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPICA: Use fallthrough pseudo-keyword
Date: Mon, 10 May 2021 19:06:01 +0200
Message-ID: <CAJZ5v0hNXrh04yP3JA0OuvKx9v6b+BKROfX03RZYTC2-m4zkRg@mail.gmail.com>
In-Reply-To: 20210506124912.7725-1-jj251510319013@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5506540639592428591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, May 6, 2021 at 2:49 PM Wei Ming Chen <jj251510319013(a)gmail.com> w=
rote:
>
> Replace /* FALLTHROUGH */ comment with pseudo-keyword macro fallthrough[1]
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highli=
ght=3Dfallthrough#implicit-switch-case-fall-through
>
> Signed-off-by: Wei Ming Chen <jj251510319013(a)gmail.com>
> ---
>  drivers/acpi/acpica/utprint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
> index e37d612e8db5..0b511434b80b 100644
> --- a/drivers/acpi/acpica/utprint.c
> +++ b/drivers/acpi/acpica/utprint.c
> @@ -475,7 +475,7 @@ int vsnprintf(char *string, acpi_size size, const cha=
r *format, va_list args)
>                 case 'X':
>
>                         type |=3D ACPI_FORMAT_UPPER;
> -                       /* FALLTHROUGH */
> +                       fallthrough;
>
>                 case 'x':
>
> --

This is ACPICA material, so I'm leaving it to Erik and Bob.

Thanks!
--===============5506540639592428591==--

