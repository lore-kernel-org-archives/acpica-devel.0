Content-Type: multipart/mixed; boundary="===============4687502943221958675=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] include: acpi: Correct spelling in the file
 acoutput.h is optimzation to optimization
Date: Fri, 05 Feb 2021 13:49:11 +0100
Message-ID: <CAJZ5v0i63RqvJNT1xfeX2yRvLkraj+89DW8z0XUZ2jHp0Bt40w@mail.gmail.com>
In-Reply-To: 20210203154437.15949-1-unixbhaskar@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4687502943221958675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 3, 2021 at 4:45 PM Bhaskar Chowdhury <unixbhaskar(a)gmail.com> =
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
> index c5d900c0ecda..1ba212372e79 100644
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

The file being updated is part of ACPICA, so I'm leaving this to Erik
& Bob, thanks!
--===============4687502943221958675==--

