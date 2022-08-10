Content-Type: multipart/mixed; boundary="===============9132721194863593499=="
MIME-Version: 1.0
From: Jeremy Linton <jeremy.linton at arm.com>
Subject: [Devel] Re: [PATCH v2 1/1] ACPI: CPPC: Disable FIE if registers in
 PCC regions
Date: Wed, 10 Aug 2022 12:43:25 -0500
Message-ID: <167502fa-d0ac-c834-170f-0f0d4e912819@arm.com>
In-Reply-To: YvOpy69JkluN4ITK@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9132721194863593499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 8/10/22 07:51, Ionela Voinescu wrote:
> Hi folks,
> =

> On Wednesday 10 Aug 2022 at 13:29:08 (+0100), Lukasz Luba wrote:
>> Hi Jeremy,
>>
>> +CC Valentin since he might be interested in this finding
>> +CC Ionela, Dietmar
>>
>> I have a few comments for this patch.
>>
>>
>> On 7/28/22 23:10, Jeremy Linton wrote:
>>> PCC regions utilize a mailbox to set/retrieve register values used by
>>> the CPPC code. This is fine as long as the operations are
>>> infrequent. With the FIE code enabled though the overhead can range
>>> from 2-11% of system CPU overhead (ex: as measured by top) on Arm
>>> based machines.
>>>
>>> So, before enabling FIE assure none of the registers used by
>>> cppc_get_perf_ctrs() are in the PCC region. Furthermore lets also
>>> enable a module parameter which can also disable it at boot or module
>>> reload.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton(a)arm.com>
>>> ---
>>>    drivers/acpi/cppc_acpi.c       | 41 ++++++++++++++++++++++++++++++++=
++
>>>    drivers/cpufreq/cppc_cpufreq.c | 19 ++++++++++++----
>>>    include/acpi/cppc_acpi.h       |  5 +++++
>>>    3 files changed, 61 insertions(+), 4 deletions(-)
>>
>>
>> 1. You assume that all platforms would have this big overhead when
>>     they have the PCC regions for this purpose.
>>     Do we know which version of HW mailbox have been implemented
>>     and used that have this 2-11% overhead in a platform?
>>     Do also more recent MHU have such issues, so we could block
>>     them by default (like in your code)?
>>
>> 2. I would prefer to simply change the default Kconfig value to 'n' for
>>     the ACPI_CPPC_CPUFREQ_FIE, instead of creating a runtime
>>     check code which disables it.
>>     We have probably introduce this overhead for older platforms with
>>     this commit:
>>
>> commit 4c38f2df71c8e33c0b64865992d693f5022eeaad
>> Author: Viresh Kumar <viresh.kumar(a)linaro.org>
>> Date:   Tue Jun 23 15:49:40 2020 +0530
>>
>>      cpufreq: CPPC: Add support for frequency invariance
>>
>>
>>
>> If the test server with this config enabled performs well
>> in the stress-tests, then on production server the config may be
>> set to 'y' (or 'm' and loaded).
>>
>> I would vote to not add extra code, which then after a while might be
>> decided to bw extended because actually some HW is actually capable (so
>> we could check in runtime and enable it). IMO this create an additional
>> complexity in our diverse configuration/tunnable space in our code.
>>
> =

> I agree that having CONFIG_ACPI_CPPC_CPUFREQ_FIE default to no is the
> simpler solution but it puts the decision in the hands of platform
> providers which might result in this functionality not being used most
> of the times, if at all. This being said, the use of CPPC counters is
> meant as a last resort for FIE, if the platform does not have AMUs. This
> is why I recommended this to default to no in the review of the original
> patches.
> =

> But I don't see these runtime options as adding a lot of complexity
> and therefore agree with the idea of this patch, versus the config
> change above, with two design comments:
>   - Rather than having a check for fie_disabled in multiple init and exit
>     functions I think the code should be slightly redesigned to elegantly
>     bail out of most functions if cppc_freq_invariance_init() failed.

I'm not sure what that would look like, I will have to mess with it a =

bit more, but as you can see its really just the two init entry points =

(one for the module, and one for the registered cpufreq), and their =

associated exit's which I'm not sure I see a way to simplify that short =

of maybe creating a second cpufreq_driver table, which replaces the =

.init calls with ones which include cppc_cpufreq_cpu_fie_init. The =

alternative is runtime setting the .init to switch between an init with =

FIE and one without. I'm not sure that clarifies what is happening in =

the code, and I thought in general dynamic runtime dispatch was to be =

avoided in the ACPI code when possible. Neither choice of course affects =

actual runtime because they are both firing during module load/unload.


>   - Given the multiple options to disable this functionality (config,
>     PCC check), I don't see a need for a module parameter or runtime user
>     input, unless we make that overwrite all previous decisions, as in: if
>     CONFIG_ACPI_CPPC_CPUFREQ_FIE=3Dy, even if cppc_perf_ctrs_in_pcc(), if
>     the fie_disabled module parameter is no, then counters should be used
>     for FIE.

Tristating the module parameter with default=3Ddetect, ON, OFF is a =

reasonable idea, and one I considered, but ignored because in the hisi =

quirk case even with ON it will have to be OFF, so it really ends up =

with 4 states default=3Ddetect, request ON, ON, OFF.

I'm good with any of this if people feel strongly about it.

> =

> Thanks,
> Ionela.
> =

> =

>> When we don't compile-in this, we should fallback to old-style
>> FIE, which has been used on these old platforms.
>>
>> BTW (I have to leave it here) the first-class solution for those servers
>> is to implement AMU counters, so the overhead to retrieve this info is
>> really low.
>>
>> Regards,
>> Lukasz


Thanks for looking at this!
--===============9132721194863593499==--

