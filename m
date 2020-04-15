Content-Type: multipart/mixed; boundary="===============8815918035980587649=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPICA: make acpi_protocol_lengths static
Date: Wed, 15 Apr 2020 11:24:09 +0200
Message-ID: <CAJZ5v0ie67VHR40GjHnnAmW3fnO0V3ypLvsy9HSnq9_zR1bEMA@mail.gmail.com>
In-Reply-To: 20200415084933.6251-1-yanaijie@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8815918035980587649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 10:23 AM Jason Yan <yanaijie(a)huawei.com> wrote:
>
> Fix the following sparse warning:
>
> drivers/acpi/acpica/exfield.c:25:10: warning: symbol
> 'acpi_protocol_lengths' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci(a)huawei.com>
> Signed-off-by: Jason Yan <yanaijie(a)huawei.com>

Erik, Bob, this one is yours. :-)

> ---
>  drivers/acpi/acpica/exfield.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
> index e85eb31e5075..3323a2ba6a31 100644
> --- a/drivers/acpi/acpica/exfield.c
> +++ b/drivers/acpi/acpica/exfield.c
> @@ -22,7 +22,7 @@ ACPI_MODULE_NAME("exfield")
>   */
>  #define ACPI_INVALID_PROTOCOL_ID        0x80
>  #define ACPI_MAX_PROTOCOL_ID            0x0F
> -const u8 acpi_protocol_lengths[] =3D {
> +static const u8 acpi_protocol_lengths[] =3D {
>         ACPI_INVALID_PROTOCOL_ID,       /* 0 - reserved */
>         ACPI_INVALID_PROTOCOL_ID,       /* 1 - reserved */
>         0x00,                   /* 2 - ATTRIB_QUICK */
> --
> 2.21.1
>
--===============8815918035980587649==--

