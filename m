Content-Type: multipart/mixed; boundary="===============4907131457676150064=="
MIME-Version: 1.0
From: Ross Zwisler <ross.zwisler at linux.intel.com>
Subject: Re: [Devel] [PATCH v3 0/3] create sysfs representation of ACPI HMAT
Date: Fri, 22 Dec 2017 16:22:31 -0700
Message-ID: <20171222232231.GA26715@linux.intel.com>
In-Reply-To: CAPcyv4j9shdJFrvADa=qW4L-jPJJ4S_TJc_c=aRoW3EmSCCChQ@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4907131457676150064==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2017 at 02:53:42PM -0800, Dan Williams wrote:
> On Thu, Dec 21, 2017 at 12:31 PM, Brice Goglin <brice.goglin(a)gmail.com>=
 wrote:
> > Le 20/12/2017 =C3=A0 23:41, Ross Zwisler a =C3=A9crit :
> [..]
> > Hello
> >
> > I can confirm that HPC runtimes are going to use these patches (at least
> > all runtimes that use hwloc for topology discovery, but that's the vast
> > majority of HPC anyway).
> >
> > We really didn't like KNL exposing a hacky SLIT table [1]. We had to
> > explicitly detect that specific crazy table to find out which NUMA nodes
> > were local to which cores, and to find out which NUMA nodes were
> > HBM/MCDRAM or DDR. And then we had to hide the SLIT values to the
> > application because the reported latencies didn't match reality. Quite
> > annoying.
> >
> > With Ross' patches, we can easily get what we need:
> > * which NUMA nodes are local to which CPUs? /sys/devices/system/node/
> > can only report a single local node per CPU (doesn't work for KNL and
> > upcoming architectures with HBM+DDR+...)
> > * which NUMA nodes are slow/fast (for both bandwidth and latency)
> > And we can still look at SLIT under /sys/devices/system/node if really
> > needed.
> >
> > And of course having this in sysfs is much better than parsing ACPI
> > tables that are only accessible to root :)
> =

> On this point, it's not clear to me that we should allow these sysfs
> entries to be world readable. Given /proc/iomem now hides physical
> address information from non-root we at least need to be careful not
> to undo that with new sysfs HMAT attributes.

This enabling does not expose any physical addresses to userspace.  It only
provides performance numbers from the HMAT and associates them with existing
NUMA nodes.  Are you worried that exposing performance numbers to non-root
users via sysfs poses a security risk?

> Once you need to be root for this info, is parsing binary HMAT vs sysfs a
> blocker for the HPC use case?
> =

> Perhaps we can enlist /proc/iomem or a similar enumeration interface
> to tell userspace the NUMA node and whether the kernel thinks it has
> better or worse performance characteristics relative to base
> system-RAM, i.e. new IORES_DESC_* values. I'm worried that if we start
> publishing absolute numbers in sysfs userspace will default to looking
> for specific magic numbers in sysfs vs asking the kernel for memory
> that has performance characteristics relative to base "System RAM". In
> other words the absolute performance information that the HMAT
> publishes is useful to the kernel, but it's not clear that userspace
> needs that vs a relative indicator for making NUMA node preference
> decisions.

--===============4907131457676150064==--

