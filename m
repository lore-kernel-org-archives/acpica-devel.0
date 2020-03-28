Content-Type: multipart/mixed; boundary="===============9111697317316938783=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH -next] ACPICA: Make acpi_protocol_lengths static
Date: Sat, 28 Mar 2020 10:14:01 +0100
Message-ID: <CAJZ5v0ikZoo5bgrfUsGic7FTCZQu7m_EYLDH1LMcMGNwNjtvqw@mail.gmail.com>
In-Reply-To: 20200328034706.17840-1-yuehaibing@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9111697317316938783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2020 at 4:47 AM YueHaibing <yuehaibing(a)huawei.com> wrote:
>
> Fix sparse warning:
>
> drivers/acpi/acpica/exfield.c:25:10: warning:
>  symbol 'acpi_protocol_lengths' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing(a)huawei.com>

Bob, Erik, I'm leaving this one to you.

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
> 2.17.1
>
>
--===============9111697317316938783==--

