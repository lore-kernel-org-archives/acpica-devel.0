Content-Type: multipart/mixed; boundary="===============1910896640521966493=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v2 0/2] cpufreq: intel_pstate: Base frequency
 attribute
Date: Fri, 12 Oct 2018 10:20:13 +0200
Message-ID: <CAJZ5v0i3_2pxX48iZOwm+AyuU12E2g-bEnxNEaFURUsXyJpX3w@mail.gmail.com>
In-Reply-To: 20181009214633.16390-1-srinivas.pandruvada@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1910896640521966493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 9, 2018 at 11:46 PM Srinivas Pandruvada
<srinivas.pandruvada(a)linux.intel.com> wrote:
>
> This series presents base frequency to cpufreq sysfs when intel_pstate
> is in use in HWP mode.
>
> Changes:
> v2
> - Removed guaranteed attribute addition to acpi_cppc sysfs
> - Using the cppc_acpi interface to get base frequency and present

The code changes are fine by me, but what about documenting the new sysfs a=
ttr?

Thanks,
Rafael

--===============1910896640521966493==--

