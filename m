Content-Type: multipart/mixed; boundary="===============1968356358815065335=="
MIME-Version: 1.0
From: Sudeep Holla <sudeep.holla at arm.com>
Subject: [Devel] Re: [PATCH v1 1/5] ACPI: CPPC: Check _OSC for flexible
 address space
Date: Wed, 11 May 2022 15:17:31 +0100
Message-ID: <20220511141731.rjyjmgvux43lsj3x@bogus>
In-Reply-To: 20220511134559.1466925-1-pierre.gondois@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1968356358815065335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 11, 2022 at 03:45:55PM +0200, Pierre Gondois wrote:
> ACPI 6.2 Section 6.2.11.2 'Platform-Wide OSPM Capabilities':
>   Starting with ACPI Specification 6.2, all _CPC registers can be in
>   PCC, System Memory, System IO, or Functional Fixed Hardware address
>   spaces. OSPM support for this more flexible register space scheme is
>   indicated by the =E2=80=9CFlexible Address Space for CPPC Registers=E2=
=80=9D _OSC bit
> =

> Otherwise (cf ACPI 6.1, s8.4.7.1.1.X), _CPC registers must be in:
> - PCC or Functional Fixed Hardware address space if defined
> - SystemMemory address space (NULL register) if not defined
> =

> Add the corresponding _OSC bit and check it when parsing _CPC objects.
>

Looks good, other than a minor nit below. Feel free to ignore that or
check what is Rafael's preference. Otherwise,

Reviewed-by: Sudeep Holla <sudeep.holla(a)arm.com>

> Signed-off-by: Pierre Gondois <pierre.gondois(a)arm.com>
> ---
>  drivers/acpi/bus.c       | 18 ++++++++++++++++++
>  drivers/acpi/cppc_acpi.c |  9 +++++++++
>  include/linux/acpi.h     |  2 ++
>  3 files changed, 29 insertions(+)
>
[...]

> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d7136d13aa44..977d74d0465b 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -574,6 +574,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct a=
cpi_osc_context *context);
>  #define OSC_SB_OSLPI_SUPPORT			0x00000100
>  #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
>  #define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00002000
> +#define OSC_SB_CPC_FLEXIBLE_ADR_SP		0x00004000

I would prefer ADR_SPACE instead of ADR_SP.

-- =

Regards,
Sudeep
--===============1968356358815065335==--

