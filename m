Content-Type: multipart/mixed; boundary="===============8230952615287504991=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [cpufreq] 909c0e9cc1: fwq.fwq.med 210.0% improvement
Date: Thu, 05 Mar 2020 10:05:48 +0100
Message-ID: <CAJZ5v0g2vzYQ04GyrpubLx2+B0O4SDbqoTDCvhnSyaj1j1xswA@mail.gmail.com>
In-Reply-To: cbe4887c-d54a-c4aa-e4bf-981b5fcc291d@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8230952615287504991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2020 at 9:18 AM Rong Chen <rong.a.chen(a)intel.com> wrote:
>
>
>
> On 3/5/20 3:50 PM, Rafael J. Wysocki wrote:
> > On 3/5/2020 2:35 AM, kernel test robot wrote:
> >> Greeting,
> >>
> >> FYI, we noticed a 210.0% improvement of fwq.fwq.med due to commit:
> >
> > Well, that sounds impressive. :-)
> >
> >
> >>
> >> commit: 909c0e9cc11ba39fa5a660583b25c2431cf54deb ("cpufreq:
> >> intel_pstate: Use passive mode by default without HWP")
> >> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git
> >> intel_pstate-passive
> >>
> >> in testcase: fwq
> >> on test machine: 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz
> >> with 48G memory
> >> with following parameters:
> >>
> >>     nr_task: 100%
> >>     samples: 100000ss
> >>     iterations: 18x
> >>     cpufreq_governor: powersave
> >
> > The governor should be schedutil, though, unless it is explicitly set
> > to powersave in the test environment.
> >
> > Is that the case?
> >
> >
>
> Hi Rafael,
>
> Yes, we set to powersave for this test.

I wonder why this is done?  Is there any particular technical reason
for doing that?
--===============8230952615287504991==--

