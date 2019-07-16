Content-Type: multipart/mixed; boundary="===============0516459883301454466=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH 00/10] cpufreq: Migrate users of policy notifiers
 to QoS requests
Date: Tue, 16 Jul 2019 12:06:08 +0200
Message-ID: <CAJZ5v0iqYHNt6NQy3Fi1B=XtjNOm2x0mX3+7eWBREgFZRpUS+w@mail.gmail.com>
In-Reply-To: cover.1563269894.git.viresh.kumar@linaro.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0516459883301454466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2019 at 11:49 AM Viresh Kumar <viresh.kumar(a)linaro.org> w=
rote:
>
> Hello,
>
> Now that cpufreq core supports taking QoS requests for min/max cpu
> frequencies, lets migrate rest of the users to using them instead of the
> policy notifiers.

Technically, this still is linux-next only. :-)

> The CPUFREQ_NOTIFY and CPUFREQ_ADJUST events of the policy notifiers are
> removed as a result, but we have to add CPUFREQ_CREATE_POLICY and
> CPUFREQ_REMOVE_POLICY events to it for the acpi stuff specifically. So
> the policy notifiers aren't completely removed.

That's not entirely accurate, because arch_topology is going to use
CPUFREQ_CREATE_POLICY now too.

> Boot tested on my x86 PC and ARM hikey board. Nothing looked broken :)
>
> This has already gone through build bot for a few days now.

So I'd prefer patches [5-8] to go right after the first one and then
do the cleanups on top of that, as somebody may want to backport the
essential changes without the cleanups.

--===============0516459883301454466==--

