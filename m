Content-Type: multipart/mixed; boundary="===============5372898679763930488=="
MIME-Version: 1.0
From: Ross Zwisler <ross.zwisler at linux.intel.com>
Subject: Re: [Devel] [PATCH v3 0/3] create sysfs representation of ACPI HMAT
Date: Fri, 22 Dec 2017 14:46:13 -0700
Message-ID: <20171222214613.GA25711@linux.intel.com>
In-Reply-To: AT5PR8401MB0387011EAD8858CC99548ED2AB0D0@AT5PR8401MB0387.NAMPRD84.PROD.OUTLOOK.COM
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5372898679763930488==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2017 at 01:41:15AM +0000, Elliott, Robert (Persistent Memor=
y) wrote:
> =

> =

> > -----Original Message-----
> > From: Linux-nvdimm [mailto:linux-nvdimm-bounces(a)lists.01.org] On Beha=
lf Of
> > Ross Zwisler
> ...
> > =

> > On Wed, Dec 20, 2017 at 10:19:37AM -0800, Matthew Wilcox wrote:
> ...
> > > initiator is a CPU?  I'd have expected you to expose a memory control=
ler
> > > abstraction rather than re-use storage terminology.
> > =

> > Yea, I agree that at first blush it seems weird.  It turns out that
> > looking at it in sort of a storage initiator/target way is beneficial,
> > though, because it allows us to cut down on the number of data values
> > we need to represent.
> > =

> > For example the SLIT, which doesn't differentiate between initiator and
> > target proximity domains (and thus nodes) always represents a system
> > with N proximity domains using a NxN distance table.  This makes sense
> > if every node contains both CPUs and memory.
> > =

> > With the introduction of the HMAT, though, we can have memory-only
> > initiator nodes and we can explicitly associate them with their local =

> > CPU.  This is necessary so that we can separate memory with different
> > performance characteristics (HBM vs normal memory vs persistent memory,
> > for example) that are all attached to the same CPU.
> > =

> > So, say we now have a system with 4 CPUs, and each of those CPUs has 3
> > different types of memory attached to it.  We now have 16 total proximi=
ty
> > domains, 4 CPU and 12 memory.
> =

> The CPU cores that make up a node can have performance restrictions of
> their own; for example, they might max out at 10 GB/s even though the
> memory controller supports 120 GB/s (meaning you need to use 12 cores
> on the node to fully exercise memory).  It'd be helpful to report this,
> so software can decide how many cores to use for bandwidth-intensive work.
> =

> > If we represent this with the SLIT we end up with a 16 X 16 distance ta=
ble
> > (256 entries), most of which don't matter because they are memory-to-
> > memory distances which don't make sense.
> > =

> > In the HMAT, though, we separate out the initiators and the targets and
> > put them into separate lists.  (See 5.2.27.4 System Locality Latency and
> > Bandwidth Information Structure in ACPI 6.2 for details.)  So, this same
> > config in the HMAT only has 4*12=3D48 performance values of each type, =
all
> > of which convey meaningful information.
> > =

> > The HMAT indeed even uses the storage "initiator" and "target"
> > terminology. :)
> =

> Centralized DMA engines (e.g., as used by the "DMA based blk-mq pmem
> driver") have performance differences too.  A CPU might include
> CPU cores that reach 10 GB/s, DMA engines that reach 60 GB/s, and
> memory controllers that reach 120 GB/s.  I guess these would be
> represented as extra initiators on the node?

For both of your comments I think all of this comes down to how you want to
represent your platform in the HMAT.  The sysfs representation just shows y=
ou
what is in the HMAT.

Each initiator node is just a single NUMA node (think of it as a NUMA node
which has the characteristic that it can initiate memory requests), so I do=
n't
think there is a way to have "extra initiators on the node".  I think what
you're talking about is separating the DMA engines and CPU cores into separ=
ate
NUMA nodes, both of which are initiators.  I think this is probably fine as=
 it
conveys useful info.

I don't think the HMAT has a concept of increasing bandwidth for number of =
CPU
cores used - it just has a single bandwidth number (well, one for read and =
one
for write) per initiator/target pair.  I don't think we want to add this,
either - the HMAT is already very complex.

--===============5372898679763930488==--

