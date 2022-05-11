Content-Type: multipart/mixed; boundary="===============5578968998453665485=="
MIME-Version: 1.0
From: Sudeep Holla <sudeep.holla at arm.com>
Subject: [Devel] Re: [PATCH v1 3/5] ACPI: CPPC: Assume no transition latency
 if no PCCT
Date: Wed, 11 May 2022 15:30:01 +0100
Message-ID: <20220511143001.ewba7sovabinnajz@bogus>
In-Reply-To: 20220511134559.1466925-3-pierre.gondois@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5578968998453665485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 11, 2022 at 03:45:57PM +0200, Pierre Gondois wrote:
> From: Pierre Gondois <Pierre.Gondois(a)arm.com>
> =

> The transition_delay_us (struct cpufreq_policy) is currently defined
> as:
>   Preferred average time interval between consecutive invocations of
>   the driver to set the frequency for this policy.  To be set by the
>   scaling driver (0, which is the default, means no preference).
> The transition_latency represents the amount of time necessary for a
> CPU to change its frequency.
> =

> A PCCT table advertises mutliple values:
> - pcc_nominal: Expected latency to process a command, in microseconds
> - pcc_mpar: The maximum number of periodic requests that the subspace
>   channel can support, reported in commands per minute. 0 indicates no
>   limitation.
> - pcc_mrtt: The minimum amount of time that OSPM must wait after the
>   completion of a command before issuing the next command,
>   in microseconds.
> cppc_get_transition_latency() allows to get the max of them.
> =

> commit d4f3388afd48 ("cpufreq / CPPC: Set platform specific
> transition_delay_us") allows to select transition_delay_us based on
> the platform, and fallbacks to cppc_get_transition_latency()
> otherwise.
> =

> If _CPC objects are not using PCC channels (no PPCT table), the
> transition_delay_us is set to CPUFREQ_ETERNAL, leading to really long
> periods between frequency updates (~4s).
> =

> If the desired_reg, where performance requests are written, is in
> SystemMemory or SystemIo ACPI address space, there is no delay
> in requests. So return 0 instead of CPUFREQ_ETERNAL, leading to
> transition_delay_us being set to LATENCY_MULTIPLIER us (1000 us).
> =

> This patch also adds two macros to check the address spaces.
> =

> Signed-off-by: Pierre Gondois <pierre.gondois(a)arm.com>
> ---
>  drivers/acpi/cppc_acpi.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 6f09fe011544..cc932ec1b613 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -100,6 +100,16 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_pt=
r);
>  				(cpc)->cpc_entry.reg.space_id =3D=3D	\
>  				ACPI_ADR_SPACE_PLATFORM_COMM)
>  =

> +/* Check if a CPC register is in SystemMemory */
> +#define CPC_IN_SM(cpc) ((cpc)->type =3D=3D ACPI_TYPE_BUFFER &&		\
> +				(cpc)->cpc_entry.reg.space_id =3D=3D	\
> +				ACPI_ADR_SPACE_SYSTEM_MEMORY)
> +

Again my taste or preference: s/SM/SYS_MEM or SYSTEM_MEM

> +/* Check if a CPC register is in SystemIo */
> +#define CPC_IN_SIO(cpc) ((cpc)->type =3D=3D ACPI_TYPE_BUFFER &&		\
> +				(cpc)->cpc_entry.reg.space_id =3D=3D	\
> +				ACPI_ADR_SPACE_SYSTEM_IO)
> +

Ditto, s/SM/SYS_IO or SYSTEM_IO

I need not refer back to the macro when reading the code. SM/SIO is too
short and makes it hard to infer from the name in general.

>  /* Evaluates to True if reg is a NULL register descriptor */
>  #define IS_NULL_REG(reg) ((reg)->space_id =3D=3D  ACPI_ADR_SPACE_SYSTEM_=
MEMORY && \
>  				(reg)->address =3D=3D 0 &&			\
> @@ -1456,6 +1466,9 @@ EXPORT_SYMBOL_GPL(cppc_set_perf);
>   * transition latency for performance change requests. The closest we ha=
ve
>   * is the timing information from the PCCT tables which provides the info
>   * on the number and frequency of PCC commands the platform can handle.
> + *
> + * If desired_reg is in the SystemMemory or SystemIo ACPI address space,
> + * then assume there is no latency.
>   */
>  unsigned int cppc_get_transition_latency(int cpu_num)
>  {
> @@ -1481,7 +1494,9 @@ unsigned int cppc_get_transition_latency(int cpu_nu=
m)
>  		return CPUFREQ_ETERNAL;
>  =

>  	desired_reg =3D &cpc_desc->cpc_regs[DESIRED_PERF];
> -	if (!CPC_IN_PCC(desired_reg))
> +	if (CPC_IN_SM(desired_reg) || CPC_IN_SIO(desired_reg))
> +		return 0;
> +	else if (!CPC_IN_PCC(desired_reg))
>  		return CPUFREQ_ETERNAL;

Apart from the above,

Reviewed-by: Sudeep Holla <sudeep.holla(a)arm.com>

-- =

Regards,
Sudeep
--===============5578968998453665485==--

