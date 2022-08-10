Content-Type: multipart/mixed; boundary="===============8847482285359822502=="
MIME-Version: 1.0
From: Jeremy Linton <jeremy.linton at arm.com>
Subject: [Devel] Re: [PATCH v2 1/1] ACPI: CPPC: Disable FIE if registers in
 PCC regions
Date: Wed, 10 Aug 2022 13:04:20 -0500
Message-ID: <151b17e9-5342-69e0-aea3-ec5b14bf5d83@arm.com>
In-Reply-To: 64ba1dfb-a475-e667-b59d-57e5d1e5ff1f@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8847482285359822502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 8/10/22 09:32, Lukasz Luba wrote:
> =

> =

> On 8/10/22 15:08, Jeremy Linton wrote:
>> Hi,
>>
>> On 8/10/22 07:29, Lukasz Luba wrote:
>>> Hi Jeremy,
>>>
>>> +CC Valentin since he might be interested in this finding
>>> +CC Ionela, Dietmar
>>>
>>> I have a few comments for this patch.
>>>
>>>
>>> On 7/28/22 23:10, Jeremy Linton wrote:
>>>> PCC regions utilize a mailbox to set/retrieve register values used by
>>>> the CPPC code. This is fine as long as the operations are
>>>> infrequent. With the FIE code enabled though the overhead can range
>>>> from 2-11% of system CPU overhead (ex: as measured by top) on Arm
>>>> based machines.
>>>>
>>>> So, before enabling FIE assure none of the registers used by
>>>> cppc_get_perf_ctrs() are in the PCC region. Furthermore lets also
>>>> enable a module parameter which can also disable it at boot or module
>>>> reload.
>>>>
>>>> Signed-off-by: Jeremy Linton <jeremy.linton(a)arm.com>
>>>> ---
>>>> =C2=A0 drivers/acpi/cppc_acpi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
41 =

>>>> ++++++++++++++++++++++++++++++++++
>>>> =C2=A0 drivers/cpufreq/cppc_cpufreq.c | 19 ++++++++++++----
>>>> =C2=A0 include/acpi/cppc_acpi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 5 +++++
>>>> =C2=A0 3 files changed, 61 insertions(+), 4 deletions(-)
>>>
>>>
>>> 1. You assume that all platforms would have this big overhead when
>>> =C2=A0=C2=A0=C2=A0 they have the PCC regions for this purpose.
>>> =C2=A0=C2=A0=C2=A0 Do we know which version of HW mailbox have been imp=
lemented
>>> =C2=A0=C2=A0=C2=A0 and used that have this 2-11% overhead in a platform?
>>> =C2=A0=C2=A0=C2=A0 Do also more recent MHU have such issues, so we coul=
d block
>>> =C2=A0=C2=A0=C2=A0 them by default (like in your code)?
>>
>> Well, the mailbox nature of PCC pretty much assures its "slow", =

>> relative the alternative of providing an actual register.=C2=A0 If a =

>> platform provides direct access to say MHU registers, then of course =

>> they won't actually be in a PCC region and the FIE will remain on.
>>
>>
>>>
>>> 2. I would prefer to simply change the default Kconfig value to 'n' for
>>> =C2=A0=C2=A0=C2=A0 the ACPI_CPPC_CPUFREQ_FIE, instead of creating a run=
time
>>> =C2=A0=C2=A0=C2=A0 check code which disables it.
>>> =C2=A0=C2=A0=C2=A0 We have probably introduce this overhead for older p=
latforms with
>>> =C2=A0=C2=A0=C2=A0 this commit:
>>
>> The problem here is that these ACPI kernels are being shipped as =

>> single images in distro's which expect them to run on a wide range of =

>> platforms (including x86/amd in this case), and preform optimally on =

>> all of them.
>>
>> So the 'n' option basically is saying that the latest FIE code doesn't =

>> provide a befit anywhere?
> =

> How we define the 'benefit' here - it's a better task utilization.
> How much better it would be vs. previous approach with old-style FIE?
> =

> TBH, I haven't found any test results from the development of the patch
> set. Maybe someone could point me to the test results which bring
> this benefit of better utilization.
> =

> In the RFC I could find that statement [1]:
> =

> "This is tested with some hacks, as I didn't have access to the right
> hardware, on the ARM64 hikey board to check the overall functionality
> and that works fine."
> =

> There should be a rule that such code is tested on a real server with
> many CPUs under some stress-test.
> =

> Ionela do you have some test results where this new FIE feature
> introduces some better & meaningful accuracy improvement to the
> tasks utilization?
> =

> With this overhead measured on a real server platform I think
> it's not worth to keep it 'y' in default.
> =

> The design is heavy, as stated in the commit message:
> "=C2=A0=C2=A0=C2=A0 On an invocation of cppc_scale_freq_tick(), we schedu=
le an irq work
>  =C2=A0=C2=A0=C2=A0 (since we reach here from hard-irq context), which th=
en schedules a
>  =C2=A0=C2=A0=C2=A0 normal work item and cppc_scale_freq_workfn() updates=
 the per_cpu
>  =C2=A0=C2=A0=C2=A0 arch_freq_scale variable based on the counter updates=
 since the last
>  =C2=A0=C2=A0=C2=A0 tick.
> "
> =

> As you said Jeremy, this mailbox would always be with overhead. IMO
> untill we cannot be sure we have some powerful new HW mailbox, this
> feature should be disabled.


Right, the design of the feature would be completely different if it =

were a simple register read to get the delivered perf avoiding all the =

jumping around you quoted.

Which sorta implies that its not really fixable as is, which IMHO means =

that 'n' isn't really strong enough, it should probably be under =

CONFIG_EXPERT as well if such a change were made to discourage its use.

> =

> [1] =

> https://lore.kernel.org/lkml/cover.1594289009.git.viresh.kumar(a)linaro.o=
rg/

--===============8847482285359822502==--

