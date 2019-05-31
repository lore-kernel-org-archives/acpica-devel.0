Content-Type: multipart/mixed; boundary="===============9184428560723510545=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: Re: [Devel] [PATCH] tools/power/acpi: exclude tools/* from .gitignore
 pattern
Date: Fri, 31 May 2019 11:23:57 +0200
Message-ID: <7038880.DppijN9Y0u@kreacher>
In-Reply-To: 1556549106-16119-1-git-send-email-yamada.masahiro@socionext.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9184428560723510545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Monday, April 29, 2019 4:45:06 PM CEST Masahiro Yamada wrote:
> tools/power/acpi/.gitignore has the following entries:
> =

>   acpidbg
>   acpidump
>   ec
> =

> They are intended to ignore the following build artifacts:
> =

>   tools/power/acpi/acpidbg
>   tools/power/acpi/acpidump
>   tools/power/acpi/ec
> =

> However, those .gitignore entries are effective not only for the
> current directory, but also for any sub-directories.
> =

> So, the following directories are also considered to be ignored:
> =

>   tools/power/acpi/tools/acpidbg
>   tools/power/acpi/tools/acpidump
>   tools/power/acpi/tools/ec
> =

> They are obviously version-controlled, so should be excluded from the
> .gitignore patterns.
> =

> You can fix it by prefixing the patterns with '/', which means they
> are only effective in the current directory.
> =

> I also prefixed the "include" consistently. IMHO, '/' prefixing is
> safer when you intend to ignore specific files or directories.
> =

> Signed-off-by: Masahiro Yamada <yamada.masahiro(a)socionext.com>
> ---
> =

>  tools/power/acpi/.gitignore | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/tools/power/acpi/.gitignore b/tools/power/acpi/.gitignore
> index cba3d99..f698a0e 100644
> --- a/tools/power/acpi/.gitignore
> +++ b/tools/power/acpi/.gitignore
> @@ -1,4 +1,4 @@
> -acpidbg
> -acpidump
> -ec
> -include
> +/acpidbg
> +/acpidump
> +/ec
> +/include/
> =


Applied, thanks!





--===============9184428560723510545==--

