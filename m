Content-Type: multipart/mixed; boundary="===============0418706192110850048=="
MIME-Version: 1.0
From: Jeremy Linton <jeremy.linton at arm.com>
Subject: [Devel] Re: [PATCH v2 1/1] ACPI: CPPC: Disable FIE if registers in
 PCC regions
Date: Fri, 29 Jul 2022 10:20:46 -0500
Message-ID: <a0bdc45a-c5c6-65ba-1ab8-e52dd26652d7@arm.com>
In-Reply-To: 871qu4krb4.fsf@stealth
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0418706192110850048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 7/29/22 07:59, Punit Agrawal wrote:
> Hi Jeremy,
> =

> One comment / query below.
> =

> Jeremy Linton <jeremy.linton(a)arm.com> writes:
> =

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
>>   drivers/acpi/cppc_acpi.c       | 41 ++++++++++++++++++++++++++++++++++
>>   drivers/cpufreq/cppc_cpufreq.c | 19 ++++++++++++----
>>   include/acpi/cppc_acpi.h       |  5 +++++
>>   3 files changed, 61 insertions(+), 4 deletions(-)
>>
> =

> [...]
> =

>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufr=
eq.c
>> index 24eaf0ec344d..ed607e27d6bb 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
> =

> [...]
> =

>> @@ -229,7 +233,12 @@ static void __init cppc_freq_invariance_init(void)
>>   	};
>>   	int ret;
>>   =

>> -	if (cppc_cpufreq_driver.get =3D=3D hisi_cppc_cpufreq_get_rate)
>> +	if (cppc_perf_ctrs_in_pcc()) {
>> +		pr_debug("FIE not enabled on systems with registers in PCC\n");
> =

> The message should probably be promoted to a pr_info() and exposed as
> part of the kernel logs. It is a change in the default behaviour we've
> had until now. The message will provide some hint about why it was
> disabled.
> =

> Thoughts?

I personally flip flopped between making it pr_info or pr_debug and =

settled on debug because no one else was complaining about the cppc_fie =

consumption. Which to me, meant that the users of platforms utilizing =

PCC regions weren't sensitive to the problem, or weren't yet running a =

distro/kernel with it enabled, or any number of other reasons why the =

problem wasn't getting more attention. Mostly I concluded the FIE code =

hadn't shown up in "enterprise" distros yet..


But, yah, if no one is going to complain about the extra messages =

pr_info() is a better plan.

Thanks for looking at this!



--===============0418706192110850048==--

