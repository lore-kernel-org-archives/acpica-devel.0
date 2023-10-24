Return-Path: <vincent.guittot@linaro.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 38C7D4EB95
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29C254EB92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698141418; x=1698746218;
 darn=lists.linuxfoundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ZmQw87wWu1ilebiZdLFiZTY4pr7HbiJ8vUC+a+GPRs=;
 b=a5hvPY4/mRwqwBEZ5GBLyr8TCjG4YMwg7vTkk11T/MSsZ5IAyRZ1WXzGRrMnV6JbDA
 IE7K7xBgUOxF2r/2jOcU05AsfkrapgHIaiK8DcTQUfxiiAAfP7VRsqmjp5ZEIM/hf5rW
 aVl5+yVYFFyghvTixAqbAEDvXTg41yvVqT0OqcXm0P8wfL81uBvZvYWMsONbTO+Y1Vxn
 MrAHHRffkp8sZApGZAJs5wY+aIzQl3ADNwfm4EJ4YZOtPdU5WKVUQ3gQso4LEV5rxs28
 brrFvRt5Me8gjs3ZV0bplGgZyFKF8mGME23rRV0zVCA+UmXMF1+rf3cJn9ICFo4vKB97
 nEyA==
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-6-vincent.guittot@linaro.org>
 <CAJZ5v0hS7bdUv=-k4ut2Fw0LYfB7Hb1_rro7UOVTRq4=JLNchg@mail.gmail.com>
 <60497d6d-dfe3-4edc-9553-311fdd9c63d0@arm.com>
In-Reply-To: <60497d6d-dfe3-4edc-9553-311fdd9c63d0@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 24 Oct 2023 11:56:46 +0200
Message-ID: <CAKfTPtCogPYyfe2aoNQE4BLRM+++3ezdx-3NsVFFMBKnZNWfiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH v3 5/6] cpufreq/cppc: set the frequency
 used for computing the capacity
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: juri.lelli@redhat.com, peterz@infradead.org, catalin.marinas@arm.com, robert.moore@intel.com, bsegall@google.com, conor.dooley@microchip.com, linux-riscv@lists.infradead.org, will@kernel.org, acpica-devel@lists.linuxfoundation.org, vschneid@redhat.com, ajones@ventanamicro.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, mingo@redhat.com, bristot@redhat.com, lftan@kernel.org, viresh.kumar@linaro.org, mgorman@suse.de, aou@eecs.berkeley.edu, linux-pm@vger.kernel.org, rostedt@goodmis.org, paul.walmsley@sifive.com, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, palmer@dabbelt.com, sudeep.holla@arm.com, suagrfillet@gmail.com, lenb@kernel.org, ionela.voinescu@arm.com, lukasz.luba@arm.com

On Fri, 20 Oct 2023 at 18:05, Pierre Gondois <pierre.gondois@arm.com> wrote=
:
>
> Hello Vincent,
>
> On 10/18/23 19:26, Rafael J. Wysocki wrote:
> > On Wed, Oct 18, 2023 at 6:25=E2=80=AFPM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> >>
> >> Save the frequency associated to the performance that has been used wh=
en
> >> initializing the capacity of CPUs.
> >> Also, cppc cpufreq driver can register an artificial energy model. In =
such
> >> case, it needs the frequency for this compute capacity.
> >> We moved and renamed cppc_perf_to_khz and cppc_perf_to_khz to use them
> >> outside cppc_cpufreq in topology_init_cpu_capacity_cppc().
> >>
> >> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >
> > For the changes in drivers/acpi/cppc_acpi.c :
> >
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> >
> >> ---
> >>   drivers/acpi/cppc_acpi.c       |  93 ++++++++++++++++++++++
> >>   drivers/base/arch_topology.c   |  15 +++-
> >>   drivers/cpufreq/cppc_cpufreq.c | 141 ++++++-------------------------=
--
> >>   include/acpi/cppc_acpi.h       |   2 +
> >>   4 files changed, 133 insertions(+), 118 deletions(-)
> >>
>
> [snip]
>
> >> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology=
.c
> >> index 9a073c2d2086..2372ce791bb4 100644
> >> --- a/drivers/base/arch_topology.c
> >> +++ b/drivers/base/arch_topology.c
> >> @@ -350,6 +350,7 @@ bool __init topology_parse_cpu_capacity(struct dev=
ice_node *cpu_node, int cpu)
> >>   void topology_init_cpu_capacity_cppc(void)
> >>   {
> >>          struct cppc_perf_caps perf_caps;
> >> +       u64 capacity, capacity_scale;
>
> I think capacity_scale should be initialized to 0 here,
> since it is used to find the max value of raw_capacity[cpu].

yes

>
> >>          int cpu;
> >>
> >>          if (likely(!acpi_cpc_valid()))
> >> @@ -365,6 +366,10 @@ void topology_init_cpu_capacity_cppc(void)
> >>                      (perf_caps.highest_perf >=3D perf_caps.nominal_pe=
rf) &&
> >>                      (perf_caps.highest_perf >=3D perf_caps.lowest_per=
f)) {
> >>                          raw_capacity[cpu] =3D perf_caps.highest_perf;
> >> +                       capacity_scale =3D max_t(u64, capacity_scale, =
raw_capacity[cpu]);
> >> +
> >> +                       per_cpu(capacity_ref_freq, cpu) =3D cppc_perf_=
to_khz(&perf_caps, raw_capacity[cpu]);
>
> I think capacity_ref_freq in in Hz, so the freq should be multiplied by 1=
000 .

yes, I forgot the *1000. I'm going to add * HZ_PER_KHZ

>
> With these two modifications, the patches worked well on a cppc-based pla=
tform.
>
> Sorry I forgot to detail what it was. It's a modified Juno with CPPC enab=
led. AMUs are not
> enabled, so the CPPC performance counters are not handled correctly and F=
IE cannot be enabled,
> but it is possible to change frequencies.
>
> The _CPC objects are setup as:
> little CPUs:
> - lowest_freq =3D 450 (MHz)
> - nominal_freq =3D 800 (MHz)
> - highest_perf =3D 383 * 1000
> - nominal_perf =3D 322 * 1000
> - lowest_perf =3D 181 * 1000
> - lowest_nonlinear_perf =3D 181 * 1000
>
> big CPUs:
> - lowest_freq =3D 600 (MHz)
> - nominal_freq =3D 1200 (MHz)
> - highest_perf =3D 1024 * 1000
> - nominal_perf =3D 833 * 1000
> - lowest_perf =3D 512 * 1000
> - lowest_nonlinear_perf =3D 512 * 1000
>
> As a remainder, available frequencies are:
> - little CPUs: 450, 800, 950 MHz
> - big CPUs: 600, 1000, 1200 Mhz
> So the platform is setup to have the last frequency as a boost frequency =
(for testing).
>
> ----
>
> Just to make a note of 2 potential side-issues for later (independent fro=
m these patches):
>
> - When testing with boosted/non-bossted frequencies, it didn't seem that =
cpu_overutilized()
>    was taking the maximum frequency into consideration. This might mean t=
hat when lowering the
>    maximum frequency of a policy, the maximum capacity of the CPUs of thi=
s policy is used
>    to detect over-utilization.
>    I would have thought that the over-utilization threshold would be lowe=
red at the same time.

No it's not, It will be part of a next step patchset. This patchset
aims to consolidate and use the same reference so we can then easily
propagate changes if needed

>
> - Similarly for EAS, the energy computation doesn't take into account the=
 maximum frequency
>    of the policy. This should mean that EAS is taking into consideration =
frequencies that
>    are not actually available.
>
>
> Regards,
> Pierre
