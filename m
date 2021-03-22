Content-Type: multipart/mixed; boundary="===============1006460229984528415=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] acpi: avoid -Wempty-body warnings
Date: Mon, 22 Mar 2021 14:27:23 +0100
Message-ID: <CAJZ5v0jbKmkWxV0CFpQ+3q5GOJVVx5QfzLVu-Mvo-subYdjuPA@mail.gmail.com>
In-Reply-To: 20210322105805.1498602-1-arnd@kernel.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1006460229984528415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2021 at 11:59 AM Arnd Bergmann <arnd(a)kernel.org> wrote:
>
> From: Arnd Bergmann <arnd(a)arndb.de>
>
> The acpi drivers produce a number of avoidable warnings for empty macros
> when building with 'make W=3D1':
>
> drivers/acpi/acpi_processor.c: In function 'acpi_processor_errata_piix4':
> drivers/acpi/acpi_processor.c:133:95: error: suggest braces around empty =
body in an 'if' statement [-Werror=3Dempty-body]
>   133 |                                   "Bus master activity detection =
(BM-IDE) erratum enabled\n"));
>       |                                                                  =
                             ^
> drivers/acpi/acpi_processor.c:136:82: error: suggest braces around empty =
body in an 'if' statement [-Werror=3Dempty-body]
>   136 |                                   "Type-F DMA livelock erratum (C=
3 disabled)\n"));
>       |                                                                  =
                ^
> drivers/acpi/acpi_processor.c: In function 'acpi_processor_get_info':
> drivers/acpi/acpi_processor.c:251:77: error: suggest braces around empty =
body in an 'else' statement [-Werror=3Dempty-body]
>   251 |                                   "No bus mastering arbitration c=
ontrol\n"));
>       |                                                                  =
           ^
> drivers/acpi/processor_pdc.c: In function 'acpi_processor_eval_pdc':
> drivers/acpi/processor_pdc.c:136:79: error: suggest braces around empty b=
ody in an 'if' statement [-Werror=3Dempty-body]
>   136 |                     "Could not evaluate _PDC, using legacy perf. =
control.\n"));
>       |                                                                  =
             ^
>
> I tried making these call no_printk() instead, which would add proper
> format string checking, but that turned out to be a rather invasive
> change, so just shut up the warning by turning the macros into empty
> "do {} while (0)" statements.

This is part of ACPICA, so handing it to Erik and Bob.


> Signed-off-by: Arnd Bergmann <arnd(a)arndb.de>
> ---
>  include/acpi/acoutput.h | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
> index 1538a6853822..b5484ef31f27 100644
> --- a/include/acpi/acoutput.h
> +++ b/include/acpi/acoutput.h
> @@ -433,23 +433,23 @@
>   * This is the non-debug case -- make everything go away,
>   * leaving no executable debug code!
>   */
> -#define ACPI_DEBUG_PRINT(pl)
> -#define ACPI_DEBUG_PRINT_RAW(pl)
> -#define ACPI_DEBUG_EXEC(a)
> -#define ACPI_DEBUG_ONLY_MEMBERS(a)
> -#define ACPI_FUNCTION_NAME(a)
> -#define ACPI_FUNCTION_TRACE(a)
> -#define ACPI_FUNCTION_TRACE_PTR(a, b)
> -#define ACPI_FUNCTION_TRACE_U32(a, b)
> -#define ACPI_FUNCTION_TRACE_STR(a, b)
> -#define ACPI_FUNCTION_ENTRY()
> -#define ACPI_DUMP_STACK_ENTRY(a)
> -#define ACPI_DUMP_OPERANDS(a, b, c)
> -#define ACPI_DUMP_ENTRY(a, b)
> -#define ACPI_DUMP_PATHNAME(a, b, c, d)
> -#define ACPI_DUMP_BUFFER(a, b)
> +#define ACPI_DEBUG_PRINT(pl)                   do { } while (0)
> +#define ACPI_DEBUG_PRINT_RAW(pl)               do { } while (0)
> +#define ACPI_DEBUG_EXEC(a)                     do { } while (0)
> +#define ACPI_DEBUG_ONLY_MEMBERS(a)             do { } while (0)
> +#define ACPI_FUNCTION_NAME(a)                  do { } while (0)
> +#define ACPI_FUNCTION_TRACE(a)                 do { } while (0)
> +#define ACPI_FUNCTION_TRACE_PTR(a, b)          do { } while (0)
> +#define ACPI_FUNCTION_TRACE_U32(a, b)          do { } while (0)
> +#define ACPI_FUNCTION_TRACE_STR(a, b)          do { } while (0)
> +#define ACPI_FUNCTION_ENTRY()                  do { } while (0)
> +#define ACPI_DUMP_STACK_ENTRY(a)               do { } while (0)
> +#define ACPI_DUMP_OPERANDS(a, b, c)            do { } while (0)
> +#define ACPI_DUMP_ENTRY(a, b)                  do { } while (0)
> +#define ACPI_DUMP_PATHNAME(a, b, c, d)         do { } while (0)
> +#define ACPI_DUMP_BUFFER(a, b)                 do { } while (0)
>  #define ACPI_IS_DEBUG_ENABLED(level, component) 0
> -#define ACPI_TRACE_POINT(a, b, c, d)
> +#define ACPI_TRACE_POINT(a, b, c, d)           do { } while (0)
>
>  /* Return macros must have a return statement at the minimum */
>
> --
> 2.29.2
>
--===============1006460229984528415==--

