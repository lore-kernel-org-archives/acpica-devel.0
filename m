Content-Type: multipart/mixed; boundary="===============0031144979904969848=="
MIME-Version: 1.0
From: Sudeep Holla <sudeep.holla at arm.com>
Subject: [Devel] Re: [PATCH v1 4/5] cpufreq: CPPC: Enable fast_switch
Date: Wed, 11 May 2022 15:41:16 +0100
Message-ID: <20220511144116.ir2wyfqwdpnhkldx@bogus>
In-Reply-To: 20220511134559.1466925-4-pierre.gondois@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0031144979904969848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 11, 2022 at 03:45:58PM +0200, Pierre Gondois wrote:
> From: Pierre Gondois <Pierre.Gondois(a)arm.com>
> =

> The communication mean of the _CPC desired performance can be
> PCC, System Memory, System IO, or Functional Fixed Hardware.
> =

> commit b7898fda5bc7 ("cpufreq: Support for fast frequency switching")
> fast_switching is 'for switching CPU frequencies from interrupt
> context'.
> Writes to SystemMemory and SystemIo are fast and suitable this.
> This is not the case for PCC and might not be the case for FFH.
> =

> Enable fast_switching for the cppc_cpufreq driver in above cases.
> =

> Add cppc_allow_fast_switch() to check the desired performance
> register address space and set fast_switching accordingly.
>

Reviewed-by: Sudeep Holla <sudeep.holla(a)arm.com>

-- =

Regards,
Sudeep
--===============0031144979904969848==--

