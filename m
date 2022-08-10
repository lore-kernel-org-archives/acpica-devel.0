Content-Type: multipart/mixed; boundary="===============8811582470295423193=="
MIME-Version: 1.0
From: Jeremy Linton <jeremy.linton at arm.com>
Subject: [Devel] Re: [PATCH v2 1/1] ACPI: CPPC: Disable FIE if registers in
 PCC regions
Date: Wed, 10 Aug 2022 09:08:14 -0500
Message-ID: <6f565c2d-e7cb-f5a2-0b38-995c9cd2deec@arm.com>
In-Reply-To: 3a5e7abd-9361-11ba-978d-8e8bae00ea31@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8811582470295423193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 8/10/22 07:29, Lukasz Luba wrote:
> Hi Jeremy,
> =

> +CC Valentin since he might be interested in this finding
> +CC Ionela, Dietmar
> =

> I have a few comments for this patch.
> =

> =

> On 7/28/22 23:10, Jeremy Linton wrote:
>> PCC regions utilize a mailbox to set/retrieve register values used by
>> the CPPC code. This is fine as long as the operations are
>> infrequent. With the FIE code enabled though the overhead can range
>> from 2-11% of system CPU overhead (ex: as measured by top) on Arm
>> based machines.
>>
>> So, before enabling FIE assure none of the registers used by
>> cppc_get_perf_ctrs() are in the PCC region. Furthermore lets also
>> enable a module parameter which can also disable it at boot or module
>> reload.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton(a)arm.com>
>> ---
>> =C2=A0 drivers/acpi/cppc_acpi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 41=
 ++++++++++++++++++++++++++++++++++
>> =C2=A0 drivers/cpufreq/cppc_cpufreq.c | 19 ++++++++++++----
>> =C2=A0 include/acpi/cppc_acpi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 5 +++++
>> =C2=A0 3 files changed, 61 insertions(+), 4 deletions(-)
> =

> =

> 1. You assume that all platforms would have this big overhead when
>  =C2=A0=C2=A0 they have the PCC regions for this purpose.
>  =C2=A0=C2=A0 Do we know which version of HW mailbox have been implemented
>  =C2=A0=C2=A0 and used that have this 2-11% overhead in a platform?
>  =C2=A0=C2=A0 Do also more recent MHU have such issues, so we could block
>  =C2=A0=C2=A0 them by default (like in your code)?

Well, the mailbox nature of PCC pretty much assures its "slow", relative =

the alternative of providing an actual register.  If a platform provides =

direct access to say MHU registers, then of course they won't actually =

be in a PCC region and the FIE will remain on.


> =

> 2. I would prefer to simply change the default Kconfig value to 'n' for
>  =C2=A0=C2=A0 the ACPI_CPPC_CPUFREQ_FIE, instead of creating a runtime
>  =C2=A0=C2=A0 check code which disables it.
>  =C2=A0=C2=A0 We have probably introduce this overhead for older platform=
s with
>  =C2=A0=C2=A0 this commit:

The problem here is that these ACPI kernels are being shipped as single =

images in distro's which expect them to run on a wide range of platforms =

(including x86/amd in this case), and preform optimally on all of them.

So the 'n' option basically is saying that the latest FIE code doesn't =

provide a befit anywhere?


> =

> commit 4c38f2df71c8e33c0b64865992d693f5022eeaad
> Author: Viresh Kumar <viresh.kumar(a)linaro.org>
> Date:=C2=A0=C2=A0 Tue Jun 23 15:49:40 2020 +0530
> =

>  =C2=A0=C2=A0=C2=A0 cpufreq: CPPC: Add support for frequency invariance
> =

> =

> =

> If the test server with this config enabled performs well
> in the stress-tests, then on production server the config may be
> set to 'y' (or 'm' and loaded).
> =

> I would vote to not add extra code, which then after a while might be
> decided to bw extended because actually some HW is actually capable (so
> we could check in runtime and enable it). IMO this create an additional
> complexity in our diverse configuration/tunnable space in our code.
> =

> When we don't compile-in this, we should fallback to old-style
> FIE, which has been used on these old platforms.
> =

> BTW (I have to leave it here) the first-class solution for those servers
> is to implement AMU counters, so the overhead to retrieve this info is
> really low.
> =

> Regards,
> Lukasz

--===============8811582470295423193==--

