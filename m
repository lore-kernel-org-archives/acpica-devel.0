Content-Type: multipart/mixed; boundary="===============3757105351064235743=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] tools/power/acpi: Fix the compile error when
 output directory is specified
Date: Wed, 08 Dec 2021 15:12:49 +0100
Message-ID: <CAJZ5v0h6Hka8P9Ba9cYrWSwzfWtH=-prLXjOKBe+1-vEU6rH0A@mail.gmail.com>
In-Reply-To: 20211123132330.1008671-1-yu.c.chen@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3757105351064235743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 23, 2021 at 2:24 PM Chen Yu <yu.c.chen(a)intel.com> wrote:
>
> Compiling the tool when output directory parameter is specified would
> trigger the following error:
>
> make O=3D/data/test/tmp/ -C tools/power/acpi/
>
> make: Entering directory '/data/src/kernel/linux/tools/power/acpi'
>   DESCEND tools/acpidbg
> make[1]: Entering directory '/data/src/kernel/linux/tools/power/acpi/tool=
s/acpidbg'
>   MKDIR    include
>   CP       include
>   CC       tools/acpidbg/acpidbg.o
> Assembler messages:
> Fatal error: can't create /data/test/tmp/tools/power/acpi/tools/acpidbg/a=
cpidbg.o: No such file or directory
> make[1]: *** [../../Makefile.rules:24: /data/test/tmp/tools/power/acpi/to=
ols/acpidbg/acpidbg.o] Error 1
> make[1]: Leaving directory '/data/src/kernel/linux/tools/power/acpi/tools=
/acpidbg'
> make: *** [Makefile:18: acpidbg] Error 2
> make: Leaving directory '/data/src/kernel/linux/tools/power/acpi'
>
> This is because the output directory has not been created yet. Fix this i=
ssue by
> creating the output directory before compiling.
>
> Reported-by: Andy Shevchenko <andriy.shevchenko(a)intel.com>
> Signed-off-by: Chen Yu <yu.c.chen(a)intel.com>
> ---
>  tools/power/acpi/Makefile.config | 1 +
>  tools/power/acpi/Makefile.rules  | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile=
.config
> index 331f6d30f472..cd7106876a5f 100644
> --- a/tools/power/acpi/Makefile.config
> +++ b/tools/power/acpi/Makefile.config
> @@ -69,6 +69,7 @@ KERNEL_INCLUDE :=3D $(OUTPUT)include
>  ACPICA_INCLUDE :=3D $(srctree)/../../../drivers/acpi/acpica
>  CFLAGS +=3D -D_LINUX -I$(KERNEL_INCLUDE) -I$(ACPICA_INCLUDE)
>  CFLAGS +=3D $(WARNINGS)
> +MKDIR =3D mkdir
>
>  ifeq ($(strip $(V)),false)
>         QUIET=3D@
> diff --git a/tools/power/acpi/Makefile.rules b/tools/power/acpi/Makefile.=
rules
> index 2a6c170b57cd..1d7616f5d0ae 100644
> --- a/tools/power/acpi/Makefile.rules
> +++ b/tools/power/acpi/Makefile.rules
> @@ -21,6 +21,7 @@ $(KERNEL_INCLUDE):
>
>  $(objdir)%.o: %.c $(KERNEL_INCLUDE)
>         $(ECHO) "  CC      " $(subst $(OUTPUT),,$@)
> +       $(QUIET) $(MKDIR) -p $(objdir) 2>/dev/null
>         $(QUIET) $(CC) -c $(CFLAGS) -o $@ $<
>
>  all: $(OUTPUT)$(TOOL)
> --

Applied (with some edits in the subject and changelog) as 5.16-rc material.

Thanks!
--===============3757105351064235743==--

