Content-Type: multipart/mixed; boundary="===============0432524936605552398=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: Re: [Devel] [PATCH v2] tools/power/acpi: exclude tools/* from
 .gitignore pattern
Date: Fri, 31 May 2019 11:24:47 +0200
Message-ID: <67810452.HO43NzBsMe@kreacher>
In-Reply-To: 1556718785-4417-1-git-send-email-yamada.masahiro@socionext.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0432524936605552398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, May 1, 2019 3:53:05 PM CEST Masahiro Yamada wrote:
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

> So, from the point of .gitignore grammar, the following check-in
> directories are also considered to be ignored:
> =

>   tools/power/acpi/tools/acpidbg
>   tools/power/acpi/tools/acpidump
>   tools/power/acpi/tools/ec
> =

> As the manual gitignore(5) says "Files already tracked by Git are not
> affected", this is not a problem as far as Git is concerned.
> =

> However, Git is not the only program that parses .gitignore because
> .gitignore is useful to distinguish build artifacts from source files.
> =

> For example, tar(1) supports the --exclude-vcs-ignore option. As of
> writing, this option does not work perfectly, but it intends to create
> a tarball excluding files specified by .gitignore.
> =

> So, I believe it is better to fix this issue.
> =

> You can fix it by prefixing the pattern with a slash; the leading slash
> means the specified pattern is relative to the current directory.
> =

> I also prefixed the "include" consistently. IMHO, it is safer when you
> intend to ignore specific files or directories.
> =

> Signed-off-by: Masahiro Yamada <yamada.masahiro(a)socionext.com>
> ---
> =

> Changes in v2:
>   - Add more information to the commit log to clarify my main motivation
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


I actually have applied this one, not the v1, sorry for the confusion.





--===============0432524936605552398==--

