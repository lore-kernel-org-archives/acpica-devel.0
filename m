Content-Type: multipart/mixed; boundary="===============4575207420683739884=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [LKP] Re: [cpufreq] 909c0e9cc1: fwq.fwq.med 210.0%
 improvement
Date: Tue, 10 Mar 2020 09:45:57 +0100
Message-ID: <CAJZ5v0hdAnN-mu8b9g19cM8AqYGXDbs1qVxLu-qE-3P6fP1=XA@mail.gmail.com>
In-Reply-To: 87imjez5rl.fsf@yhuang-dev.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4575207420683739884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2020 at 2:17 AM Huang, Ying <ying.huang(a)intel.com> wrote:
>
> "Rafael J. Wysocki" <rafael(a)kernel.org> writes:
>
> > On Fri, Mar 6, 2020 at 4:29 AM Huang, Ying <ying.huang(a)intel.com> wro=
te:
> >>
> >> Hi, Rafael,
> >>
> >> "Rafael J. Wysocki" <rafael(a)kernel.org> writes:
> >>
> >> > On Thu, Mar 5, 2020 at 9:18 AM Rong Chen <rong.a.chen(a)intel.com> w=
rote:
> >> >>
> >> >>
> >> >>
> >> >> On 3/5/20 3:50 PM, Rafael J. Wysocki wrote:
> >> >> > On 3/5/2020 2:35 AM, kernel test robot wrote:
> >> >> >> Greeting,
> >> >> >>
> >> >> >> FYI, we noticed a 210.0% improvement of fwq.fwq.med due to commi=
t:
> >> >> >
> >> >> > Well, that sounds impressive. :-)
> >> >> >
> >> >> >
> >> >> >>
> >> >> >> commit: 909c0e9cc11ba39fa5a660583b25c2431cf54deb ("cpufreq:
> >> >> >> intel_pstate: Use passive mode by default without HWP")
> >> >> >> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git
> >> >> >> intel_pstate-passive
> >> >> >>
> >> >> >> in testcase: fwq
> >> >> >> on test machine: 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz
> >> >> >> with 48G memory
> >> >> >> with following parameters:
> >> >> >>
> >> >> >>     nr_task: 100%
> >> >> >>     samples: 100000ss
> >> >> >>     iterations: 18x
> >> >> >>     cpufreq_governor: powersave
> >> >> >
> >> >> > The governor should be schedutil, though, unless it is explicitly=
 set
> >> >> > to powersave in the test environment.
> >> >> >
> >> >> > Is that the case?
> >> >> >
> >> >> >
> >> >>
> >> >> Hi Rafael,
> >> >>
> >> >> Yes, we set to powersave for this test.
> >> >
> >> > I wonder why this is done?  Is there any particular technical reason
> >> > for doing that?
> >>
> >> fwq is a noise benchmark to measure the hardware and software noise
> >> level.  More information could be found in the following document.
> >>
> >> https://asc.llnl.gov/sequoia/benchmarks/FTQ_summary_v1.1.pdf
> >>
> >> In 0day, to measure the noise introduced by power management, we will
> >> run fwq with the performance and powersave governors.  Do you think th=
is
> >> is reasonable?  Or we should use some other governors?
> >
> > I think that the schedutil governor should be tested too if present.
> >
> > Also note that for the intel_pstate driver "powersave" may mean
> > different things depending on the current operation mode of the
> > driver.  If scaling_driver is "intel_pstate", then "powersave" is the
> > driver's built-in algorithm.  If scaling_driver is "intel_cpufreq",
> > though, "powersave" means running at the minimum frequency all the
> > time.
>
> Thanks for your guidance.  We will test schedutil governor in the future
> too.
>
> As for powersave, should we stop testing it?

You cannot stop testing it, because it is the default governor
algorithm for intel_pstate working in the active mode.

>  Or just pay attention to the possible issue you pointed out?

Yes, please!

Basically, I would recommend to test the following configurations by defaul=
t:

(1) scaling_driver =3D intel_pstate + scaling_governor =3D powersave

(2) scaling_driver =3D intel_cpufreq + scaling_governor =3D schedutil

The other ones are kind of less interesting.

[Note that in order to switch over from intel_pstate to intel_cpufreq,
you need to write "passive" into
/sys/devices/system/cpu/intel_pstate/status and if that write fails,
configuration (2) is not available and may be skipped.]

> Should we add ondemand governor?

Not necessarily, maybe as a reference only if you have spare cycles.

Thanks!
--===============4575207420683739884==--

