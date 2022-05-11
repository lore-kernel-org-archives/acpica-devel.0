Content-Type: multipart/mixed; boundary="===============2764006065698033015=="
MIME-Version: 1.0
From: Sudeep Holla <sudeep.holla at arm.com>
Subject: [Devel] Re: [PATCH v1 5/5] cpufreq: CPPC: Enable
 dvfs_possible_from_any_cpu
Date: Wed, 11 May 2022 15:50:53 +0100
Message-ID: <20220511145053.mszsbcqsytf6tmfh@bogus>
In-Reply-To: 20220511134559.1466925-5-pierre.gondois@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2764006065698033015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 11, 2022 at 03:45:59PM +0200, Pierre Gondois wrote:
> From: Pierre Gondois <Pierre.Gondois(a)arm.com>
> =

> The communication mean of the _CPC desired performance can be
> PCC, System Memory, System IO, or Functional Fixed Hardware (FFH).
> =

> PCC, SystemMemory and SystemIo address spaces are available from any
> CPU. Thus, dvfs_possible_from_any_cpu should be enabled in such case.
> For FFH, let the FFH implementation do smp_call_function_*() calls.
>

Fair enough. I just thought it would be good to check if this is already
taken care for Arm platforms and found that we don't support it yet. So all
is fine :).

> Signed-off-by: Pierre Gondois <pierre.gondois(a)arm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufre=
q.c
> index 000a0c610c30..ad1535fbf389 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -558,6 +558,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_polic=
y *policy)
>  	}
>  =

>  	policy->fast_switch_possible =3D cppc_allow_fast_switch();
> +	policy->dvfs_possible_from_any_cpu =3D true;
>

Reviewed-by: Sudeep Holla <sudeep.holla(a)arm.com>

-- =

Regards,
Sudeep
--===============2764006065698033015==--

