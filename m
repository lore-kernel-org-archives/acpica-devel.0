Content-Type: multipart/mixed; boundary="===============6232454474590384922=="
MIME-Version: 1.0
From: Ross Zwisler <ross.zwisler at linux.intel.com>
Subject: Re: [Devel] [PATCH v3 0/3] create sysfs representation of ACPI HMAT
Date: Wed, 20 Dec 2017 15:41:05 -0700
Message-ID: <20171220224105.GA27258@linux.intel.com>
In-Reply-To: CAPcyv4gTknp=0yQnVrrB5Ui+mJE_x-wdkV86UD4hsYnx3CAjfA@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6232454474590384922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2017 at 02:29:56PM -0800, Dan Williams wrote:
> On Wed, Dec 20, 2017 at 1:24 PM, Ross Zwisler
> <ross.zwisler(a)linux.intel.com> wrote:
> > On Wed, Dec 20, 2017 at 01:16:49PM -0800, Matthew Wilcox wrote:
> >> On Wed, Dec 20, 2017 at 12:22:21PM -0800, Dave Hansen wrote:
> >> > On 12/20/2017 10:19 AM, Matthew Wilcox wrote:
> >> > > I don't know what the right interface is, but my laptop has a set =
of
> >> > > /sys/devices/system/memory/memoryN/ directories.  Perhaps this is =
the
> >> > > right place to expose write_bw (etc).
> >> >
> >> > Those directories are already too redundant and wasteful.  I think w=
e'd
> >> > really rather not add to them.  In addition, it's technically possib=
le
> >> > to have a memory section span NUMA nodes and have different performa=
nce
> >> > properties, which make it impossible to represent there.
> >> >
> >> > In any case, ACPI PXM's (Proximity Domains) are guaranteed to have
> >> > uniform performance properties in the HMAT, and we just so happen to
> >> > always create one NUMA node per PXM.  So, NUMA nodes really are a go=
od fit.
> >>
> >> I think you're missing my larger point which is that I don't think this
> >> should be exposed to userspace as an ACPI feature.  Because if you do,
> >> then it'll also be exposed to userspace as an openfirmware feature.
> >> And sooner or later a devicetree feature.  And then writing a portable
> >> program becomes an exercise in suffering.
> >>
> >> So, what's the right place in sysfs that isn't tied to ACPI?  A new
> >> directory or set of directories under /sys/devices/system/memory/ ?
> >
> > Oh, the current location isn't at all tied to acpi except that it happe=
ns to
> > be named 'hmat'.  When it was all named 'hmem' it was just:
> >
> > /sys/devices/system/hmem
> >
> > Which has no ACPI-isms at all.  I'm happy to move it under
> > /sys/devices/system/memory/hmat if that's helpful, but I think we still=
 have
> > the issue that the data represented therein is still pulled right from =
the
> > HMAT, and I don't know how to abstract it into something more platform
> > agnostic until I know what data is provided by those other platforms.
> >
> > For example, the HMAT provides latency information and bandwidth inform=
ation
> > for both reads and writes.  Will the devicetree/openfirmware/etc versio=
n have
> > this same info, or will it be just different enough that it won't trans=
late
> > into whatever I choose to stick in sysfs?
> =

> For the initial implementation do we need to have a representation of
> all the performance data? Given that
> /sys/devices/system/node/nodeX/distance is the only generic
> performance attribute published by the kernel today it is already the
> case that applications that need to target specific memories need to
> go parse information that is not provided by the kernel by default.
> The question is can those specialized applications stay special and go
> parse the platform specific data sources, like raw HMAT, directly, or
> do we expect general purpose applications to make use of this data? I
> think a firmware-id to numa-node translation facility
> (/sys/devices/system/node/nodeX/fwid) is a simple start that we can
> build on with more information as specific use cases arise.

We don't represent all the performance data, we only represent the data for
local initiator/target pairs.  I do think that this is useful to have in sy=
sfs
because it provides a way to easily answer the most commonly asked questions
(or at least what I'm guessing will be the most commmonly asked queststions=
),
i.e. "given a CPU, what are the speeds of the various types of memory attac=
hed
to it", and "given a chunk of memory, how fast is it and to which CPU is it
local"?  By providing this base level of information I'm hoping to prevent
most applications from having to parse the HMAT directly.

The question of whether or not to include this local performance information
was one of the main questions of the initial RFC patch series, and I did get
feedback (albiet off-list) that the local performance information was
valuable to at least some users.  I did intentionally structure my (now very
short) set so that the performance information was added as a separate patc=
h,
so we can get to the place you're talking about where we only provide firmw=
are
id <=3D> proximity domain mappings by just leaving off the last patch in the
series.

I'm personally still of the opinion though that this last patch does add
value.

--===============6232454474590384922==--

