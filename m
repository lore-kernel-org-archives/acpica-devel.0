Content-Type: multipart/mixed; boundary="===============1542121052126789561=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPICA: Fix typo in comments
Date: Thu, 11 Aug 2022 18:25:08 +0200
Message-ID: <CAJZ5v0gRUmMu7zGgH3F32C8DB6RsOqnNPw+L8023A89Tiqy-qw@mail.gmail.com>
In-Reply-To: 20220811154357.18674-1-dengshaomin@cdjrlc.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1542121052126789561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 11, 2022 at 5:53 PM Shaomin Deng <dengshaomin(a)cdjrlc.com> wro=
te:
>
> Delete the repeated word "method" in comments.
>
> Signed-off-by: Shaomin Deng <dengshaomin(a)cdjrlc.com>

Please note that the ACPICA changes need to be submitted to the
upstream ACPICA project on github.  If your change is applicable to
that code base, please consider submitting a pull request for it on
github.

> ---
>  drivers/acpi/acpica/psparse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
> index ba93f359760a..b0faab1e6d3f 100644
> --- a/drivers/acpi/acpica/psparse.c
> +++ b/drivers/acpi/acpica/psparse.c
> @@ -508,7 +508,7 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state =
*walk_state)
>                         }
>
>                         /*
> -                        * If the transfer to the new method method call =
worked,
> +                        * If the transfer to the new method call worked,
>                          * a new walk state was created -- get it
>                          */
>                         walk_state =3D acpi_ds_get_current_walk_state(thr=
ead);
> --
> 2.35.1
>
--===============1542121052126789561==--

