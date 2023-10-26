Return-Path: <dietmar.eggemann@arm.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7078E612FF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A2EB612E7
Message-ID: <c000f7a3-caeb-4d75-8c88-40ed02950ec1@arm.com>
Date: Thu, 26 Oct 2023 13:19:49 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-7-vincent.guittot@linaro.org>
 <ZTbebQrK3K+JwWxR@arm.com>
 <CAKfTPtA0KBE8TFifOEXddF9d_wqDjb4QUvgK8c0DTtyLrX0atA@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtA0KBE8TFifOEXddF9d_wqDjb4QUvgK8c0DTtyLrX0atA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Acpica-devel] [RFC v3 6/6] arm64/amu: use capacity_ref_freq to
	set AMU ratio
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Vincent Guittot <vincent.guittot@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>
Cc: juri.lelli@redhat.com, peterz@infradead.org, catalin.marinas@arm.com, robert.moore@intel.com, bsegall@google.com, conor.dooley@microchip.com, pierre.gondois@arm.com, linux-riscv@lists.infradead.org, will@kernel.org, acpica-devel@lists.linuxfoundation.org, vschneid@redhat.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, mingo@redhat.com, mgorman@suse.de, lftan@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org, aou@eecs.berkeley.edu, linux-pm@vger.kernel.org, rostedt@goodmis.org, paul.walmsley@sifive.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, palmer@dabbelt.com, sudeep.holla@arm.com, suagrfillet@gmail.com, ajones@ventanamicro.com, bristot@redhat.com, lukasz.luba@arm.com

On 24/10/2023 11:58, Vincent Guittot wrote:
> On Mon, 23 Oct 2023 at 22:58, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>>
>> Hi,
>>
>> On Wednesday 18 Oct 2023 at 18:25:40 (+0200), Vincent Guittot wrote:
>>> Use the new capacity_ref_freq to set the ratio that is used by AMU for
>>> computing the arch_scale_freq_capacity().
>>> This helps to keep everything aligned using the same reference for
>>> computing CPUs capacity.
>>>
>>> The default value of the ratio ensures that arch_scale_freq_capacity()
>>> returns max capacity until it is set to its correct value with the
>>> cpu capacity and capacity_ref_freq.

Nitpick: Could you mention that arch_max_freq_scale is the default value
for this ratio? Took me a while to recreate the (not so simple) story
for this change, i.e. make the connection between ratio and
arch_max_freq_scale.

init_cpu_capacity_callback()

  freq_inv_set_max_ratio()

    u64 ratio
    ...
    per_cpu(arch_max_freq_scale, cpu) = (unsigned long)ratio
            ^^^^^^^^^^^^^^^^^^^


static struct scale_freq_data amu_sfd = {
        .set_freq_scale = amu_scale_freq_tick,
}

#define arch_scale_freq_tick topology_scale_freq_tick

topology_scale_freq_tick()

  sfd->set_freq_scale()


amu_scale_freq_tick()

  ...
  scale *= this_cpu_read(arch_max_freq_scale)
                         ^^^^^^^^^^^^^^^^^^^
  ...
  this_cpu_write(arch_freq_scale, (unsigned long)scale);


#define arch_scale_freq_capacity topology_get_freq_scale

topology_get_freq_scale(cpu)

  return per_cpu(arch_freq_scale, cpu)

[...]

