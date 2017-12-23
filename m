Content-Type: multipart/mixed; boundary="===============0120476879443612132=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v3 0/3] create sysfs representation of ACPI HMAT
Date: Sat, 23 Dec 2017 02:14:41 +0100
Message-ID: <CAJZ5v0j22oRwsO7uULdeamUK-BwQAYq_v6h1LUZw3vpwqCLunQ@mail.gmail.com>
In-Reply-To: CAPcyv4j95rWmFM5NDvoRJakwVE5YUgcipQW2Ju+40+FD6vYs+Q@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0120476879443612132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2017 at 12:57 AM, Dan Williams <dan.j.williams(a)intel.com>=
 wrote:
> On Fri, Dec 22, 2017 at 3:22 PM, Ross Zwisler
> <ross.zwisler(a)linux.intel.com> wrote:
>> On Fri, Dec 22, 2017 at 02:53:42PM -0800, Dan Williams wrote:
>>> On Thu, Dec 21, 2017 at 12:31 PM, Brice Goglin <brice.goglin(a)gmail.co=
m> wrote:
>>> > Le 20/12/2017 =C3=A0 23:41, Ross Zwisler a =C3=A9crit :
>>> [..]
>>> > Hello
>>> >
>>> > I can confirm that HPC runtimes are going to use these patches (at le=
ast
>>> > all runtimes that use hwloc for topology discovery, but that's the va=
st
>>> > majority of HPC anyway).
>>> >
>>> > We really didn't like KNL exposing a hacky SLIT table [1]. We had to
>>> > explicitly detect that specific crazy table to find out which NUMA no=
des
>>> > were local to which cores, and to find out which NUMA nodes were
>>> > HBM/MCDRAM or DDR. And then we had to hide the SLIT values to the
>>> > application because the reported latencies didn't match reality. Quite
>>> > annoying.
>>> >
>>> > With Ross' patches, we can easily get what we need:
>>> > * which NUMA nodes are local to which CPUs? /sys/devices/system/node/
>>> > can only report a single local node per CPU (doesn't work for KNL and
>>> > upcoming architectures with HBM+DDR+...)
>>> > * which NUMA nodes are slow/fast (for both bandwidth and latency)
>>> > And we can still look at SLIT under /sys/devices/system/node if really
>>> > needed.
>>> >
>>> > And of course having this in sysfs is much better than parsing ACPI
>>> > tables that are only accessible to root :)
>>>
>>> On this point, it's not clear to me that we should allow these sysfs
>>> entries to be world readable. Given /proc/iomem now hides physical
>>> address information from non-root we at least need to be careful not
>>> to undo that with new sysfs HMAT attributes.
>>
>> This enabling does not expose any physical addresses to userspace.  It o=
nly
>> provides performance numbers from the HMAT and associates them with exis=
ting
>> NUMA nodes.  Are you worried that exposing performance numbers to non-ro=
ot
>> users via sysfs poses a security risk?
>
> It's an information disclosure that's not clear we need to make to
> non-root processes.
>
> I'm more worried about userspace growing dependencies on the absolute
> numbers when those numbers can change from platform to platform.
> Differentiated memory on one platform may be the common memory pool on
> another.
>
> To me this has parallels with storage device hinting where
> specifications like T10 have a complex enumeration of all the
> performance hints that can be passed to the device, but the Linux
> enabling effort aims for a sanitzed set of relative hints that make
> sense. It's more flexible if userspace specifies a relative intent
> rather than an absolute performance target. Putting all the HMAT
> information into sysfs gives userspace more information than it could
> possibly do anything reasonable, at least outside of specialized apps
> that are hand tuned for a given hardware platform.

That's a valid point IMO.

It is sort of tempting to expose everything to user space verbatim,
especially early in the enabling process when the kernel has not yet
found suitable ways to utilize the given information, but the very act
of exposing it may affect what can be done with it in the future.

User space interfaces need to stay around and be supported forever, at
least potentially, so adding every one of them is a serious
commitment.

Thanks,
Rafael

--===============0120476879443612132==--

