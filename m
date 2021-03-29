Content-Type: multipart/mixed; boundary="===============4736549448102378110=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPICA: Fix a typo
Date: Mon, 29 Mar 2021 14:48:03 +0200
Message-ID: <CAJZ5v0izUkL=7NSFuefNYcqdq2vSxseDCCLKUTOZGC82WjJNPg@mail.gmail.com>
In-Reply-To: 20210326001922.4767-1-unixbhaskar@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4736549448102378110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 26, 2021 at 1:22 AM Bhaskar Chowdhury <unixbhaskar(a)gmail.com>=
 wrote:
>
>
> s/optimzation/optimization/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar(a)gmail.com>
> ---
>  include/acpi/acoutput.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
> index 1538a6853822..1b4c45815695 100644
> --- a/include/acpi/acoutput.h
> +++ b/include/acpi/acoutput.h
> @@ -362,7 +362,7 @@
>   *
>   * A less-safe version of the macros is provided for optional use if the
>   * compiler uses excessive CPU stack (for example, this may happen in the
> - * debug case if code optimzation is disabled.)
> + * debug case if code optimization is disabled.)
>   */
>
>  /* Exit trace helper macro */
> --

Erik, could you pick up this patch, please?  It is simple enough IMV ...
--===============4736549448102378110==--

