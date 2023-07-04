Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD54D8198D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC30E817ED
MIME-Version: 1.0
References: <20230703122450.951704-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20230703122450.951704-1-ben.dooks@codethink.co.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Jul 2023 19:06:13 +0200
Message-ID: <CAJZ5v0jXBZNXKJGuMFp7Oh7K6ndnKqruWvAVdiRB4c0LYv48Sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH] ACPI: fix undeclared symbols from saprse
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, robert.moore@intel.com, lenb@kernel.org

On Mon, Jul 3, 2023 at 2:24=E2=80=AFPM Ben Dooks <ben.dooks@codethink.co.uk=
> wrote:
>
> The building of drivers/acpi/acpica/utglobal.o is throwing
> a number of sparse warnins about undeclared symbols. This is
> due to defining DEFINE_ACPI_GLOBALS then making the macro
> ACPI_INIT_GLOBAL() define it but never declaring the fact this
> is an extern declared varible.
>
> This is some of the sparse warnings that are being fixed here:
>
> drivers/acpi/acpica/utglobal.c: note: in included file (through include/a=
cpi/acpi.h):
> ./include/acpi/acpixf.h:104:1: warning: symbol 'acpi_gbl_enable_interpret=
er_slack' was not declared. Should it be static?
> ./include/acpi/acpixf.h:113:1: warning: symbol 'acpi_gbl_auto_serialize_m=
ethods' was not declared. Should it be static?
> ./include/acpi/acpixf.h:120:1: warning: symbol 'acpi_gbl_create_osi_metho=
d' was not declared. Should it be static?
> ./include/acpi/acpixf.h:126:1: warning: symbol 'acpi_gbl_use_default_regi=
ster_widths' was not declared. Should it be static?
> ./include/acpi/acpixf.h:136:1: warning: symbol 'acpi_gbl_enable_table_val=
idation' was not declared. Should it be static?
> ./include/acpi/acpixf.h:141:1: warning: symbol 'acpi_gbl_enable_aml_debug=
_object' was not declared. Should it be static?
> ./include/acpi/acpixf.h:149:1: warning: symbol 'acpi_gbl_copy_dsdt_locall=
y' was not declared. Should it be static?
> ./include/acpi/acpixf.h:157:1: warning: symbol 'acpi_gbl_do_not_use_xsdt'=
 was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Note, if this isn't the correct place to fix, where should this be
> going?

This file belongs to ACPICA.  As a general rule, ACPICA changes should
be submitted as pull requests to the upstream ACPICA project on
GitHub, from where they are backported (semi-automatically) to Linux.

However, if an upstream ACPICA pull request has been submitted, a
corresponding Linux patch can be posted with a Link: tag pointing to
that pull request.

Thanks!

> ---
>  include/acpi/acpixf.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
> index 9ffdc0425bc2..8d69d1e39cd9 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -37,6 +37,7 @@
>         type name
>
>  #define ACPI_INIT_GLOBAL(type,name,value) \
> +       extern type name; \
>         type name=3Dvalue
>
>  #else
> --
> 2.40.1
>
