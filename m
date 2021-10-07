Content-Type: multipart/mixed; boundary="===============4011094571327859299=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPI: tools: fix compilation error
Date: Thu, 07 Oct 2021 19:19:53 +0200
Message-ID: <CAJZ5v0h7OVzjJNP9BXw5XucL3JQ7tY9wHLD8TZXjAKx_gxiDtA@mail.gmail.com>
In-Reply-To: 20211006051318.117094-1-miguel.bernal.marin@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4011094571327859299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 6, 2021 at 7:13 AM Miguel Bernal Marin
<miguel.bernal.marin(a)linux.intel.com> wrote:
>
> When acpi tools are compiled the following error is showed:
>
>    $ cd tools/power/acpi
>    $ make
>      DESCEND tools/acpidbg
>      MKDIR    include
>      CP       include
>      CC       tools/acpidbg/acpidbg.o
>    In file included from /home/linux/tools/power/acpi/include/acpi/platfo=
rm/acenv.h:152,
>                     from /home/linux/tools/power/acpi/include/acpi/acpi.h=
:22,
>                     from acpidbg.c:9:
>    /home/linux/tools/power/acpi/include/acpi/platform/acgcc.h:25:10: fata=
l error: linux/stdarg.h: No such file or directory
>       29 | #include <linux/stdarg.h>
>          |          ^~~~~~~~~~~~~~~~
>    compilation terminated.
>
> Keep the same logic from ACPICA, just identify when is used inside kernel
> or by acpi tool.
>
> Fixes: c0891ac15f04 ("isystem: ship and use stdarg.h")
> Signed-off-by: Miguel Bernal Marin <miguel.bernal.marin(a)linux.intel.com>
> ---
>  include/acpi/platform/acgcc.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
> index fb172a03a753..20ecb004f5a4 100644
> --- a/include/acpi/platform/acgcc.h
> +++ b/include/acpi/platform/acgcc.h
> @@ -22,9 +22,14 @@ typedef __builtin_va_list va_list;
>  #define va_arg(v, l)            __builtin_va_arg(v, l)
>  #define va_copy(d, s)           __builtin_va_copy(d, s)
>  #else
> +#ifdef __KERNEL__
>  #include <linux/stdarg.h>
> -#endif
> -#endif
> +#else
> +/* Used to build acpi tools */
> +#include <stdarg.h>
> +#endif /* __KERNEL__ */
> +#endif /* ACPI_USE_BUILTIN_STDARG */
> +#endif /* ! va_arg */
>
>  #define ACPI_INLINE             __inline__
>
> --

Applied as 5.16 material, thanks!
--===============4011094571327859299==--

