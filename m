Content-Type: multipart/mixed; boundary="===============1353175800401827099=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v2 0/7] CPPC optional registers AMD support
Date: Tue, 16 Apr 2019 11:34:07 +0200
Message-ID: <CAJZ5v0jh0Yn1fy5bO3wett5AsjBA55_Z-8L_M8eRyy5cePqwaw@mail.gmail.com>
In-Reply-To: d44f4893-0b67-4993-2942-6e03d29dffa1@amd.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1353175800401827099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 12:35 AM Janakarajan Natarajan <jnataraj(a)amd.com>=
 wrote:
>
> On 4/4/19 4:25 PM, Natarajan, Janakarajan wrote:
> > CPPC (Collaborative Processor Performance Control) offers optional
> > registers which can be used to tune the system based on energy and/or
> > performance requirements.
> >
> > Newer AMD processors add support for a subset of these optional CPPC
> > registers, based on ACPI v6.1.
> >
> > The following are the supported CPPC registers for which sysfs entries
> > are created:
> > * enable                (NEW)
> > * max_perf              (NEW)
> > * min_perf              (NEW)
> > * energy_perf
> > * lowest_perf
> > * nominal_perf
> > * desired_perf          (NEW)
> > * feedback_ctrs
> > * auto_sel_enable       (NEW)
> > * lowest_nonlinear_perf
> >
> > The CPPC driver is updated to enable the OSPM and the userspace to
> > access
> > the newly supported registers.
> >
> > The purpose of exposing the registers via the sysfs entries is to allow
> > the userspace to:
> > * Tweak the values to fit its workload.
> > * Apply a profile from AMD's optimization guides.
> >
> > Profiles will be documented in the performance/optimization guides.
> >
> > Note:
> > * AMD systems will not have a policy applied in the kernel at this time.
> > * By default, acpi_cpufreq will still be used.
> >
> > TODO:
> > * Create a linux userspace tool that will help users generate a CPPC
> > * profile
> >    for their target workload.
> > * Create or update a driver to apply a general CPPC policy in the
> > * kernel.
> >
> > v1->v2:
> > * Add macro to ensure BUFFER only registers have BUFFER type.
> > * Add support macro to make the right check based on register type.
> > * Remove support checks for registers which are mandatory.
>
>
> Are there any concerns regarding this patchset?

Yes, there are.

Unfortunately, it is generally problematic.

First off, the behavior of existing sysfs files cannot be changed at
will, as there may be users of them out there already depending on the
current behavior.

Second, at least some CPPC control registers are used by cpufreq
drivers (cppc_cpufreq and intel_pstate), so modifying them behind the
drivers' backs is not a good idea in general.  For this reason, adding
new sysfs attributes to allow user space to do that is quite
questionable.

Thanks,
Rafael

--===============1353175800401827099==--

