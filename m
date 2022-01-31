Content-Type: multipart/mixed; boundary="===============9131251858795607177=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPICA: cleanup double word in comment
Date: Mon, 31 Jan 2022 19:51:00 +0100
Message-ID: <CAJZ5v0g5Xxd9kBPUdsC6D4fVHfZafKiGgkTONo2mpqvfgoFDgw@mail.gmail.com>
In-Reply-To: 20220131133337.1556355-1-trix@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9131251858795607177==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 31, 2022 at 2:33 PM <trix(a)redhat.com> wrote:
>
> From: Tom Rix <trix(a)redhat.com>
>
> Remove the second 'know'.
>
> Signed-off-by: Tom Rix <trix(a)redhat.com>

This is ACPICA material, so it needs to be submitted to the upstream
project via https://github.com/acpica/acpica/

Also, it would be good to combine all of the analogous changes in one patch.

> ---
>  drivers/acpi/acpica/exfldio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
> index bdc7a30d1217c..b92605df3872c 100644
> --- a/drivers/acpi/acpica/exfldio.c
> +++ b/drivers/acpi/acpica/exfldio.c
> @@ -104,7 +104,7 @@ acpi_ex_setup_region(union acpi_operand_object *obj_d=
esc,
>  #ifdef ACPI_UNDER_DEVELOPMENT
>         /*
>          * If the Field access is any_acc, we can now compute the optimal
> -        * access (because we know know the length of the parent region)
> +        * access (because we know the length of the parent region)
>          */
>         if (!(obj_desc->common.flags & AOPOBJ_DATA_VALID)) {
>                 if (ACPI_FAILURE(status)) {
> --
> 2.26.3
>
--===============9131251858795607177==--

