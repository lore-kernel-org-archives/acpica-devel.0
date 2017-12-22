Content-Type: multipart/mixed; boundary="===============3584464407775001216=="
MIME-Version: 1.0
From: Ross Zwisler <ross.zwisler at linux.intel.com>
Subject: Re: [Devel] [PATCH v3 0/3] create sysfs representation of ACPI HMAT
Date: Fri, 22 Dec 2017 15:31:54 -0700
Message-ID: <20171222223154.GC25711@linux.intel.com>
In-Reply-To: 2d6420f7-0a95-adfe-7390-a2aea4385ab2@linux.vnet.ibm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3584464407775001216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2017 at 08:39:41AM +0530, Anshuman Khandual wrote:
> On 12/14/2017 07:40 AM, Ross Zwisler wrote:
<>
> > We solve this issue by providing userspace with performance information=
 on
> > individual memory ranges.  This performance information is exposed via
> > sysfs:
> > =

> >   # grep . mem_tgt2/* mem_tgt2/local_init/* 2>/dev/null
> >   mem_tgt2/firmware_id:1
> >   mem_tgt2/is_cached:0
> >   mem_tgt2/local_init/read_bw_MBps:40960
> >   mem_tgt2/local_init/read_lat_nsec:50
> >   mem_tgt2/local_init/write_bw_MBps:40960
> >   mem_tgt2/local_init/write_lat_nsec:50
<>
> We will enlist properties for all possible "source --> target" on the sys=
tem?

Nope, just 'local' initiator/target pairs.  I talk about the reasoning for
this in the cover letter for patch 3:

https://lists.01.org/pipermail/linux-nvdimm/2017-December/013574.html

> Right now it shows only bandwidth and latency properties, can it accommod=
ate
> other properties as well in future ?

We also have an 'is_cached' attribute for the memory targets if they are
involved in a caching hierarchy, but right now those are all the things we
expose.  We can potentially expose whatever we want that is present in the
HMAT, but those seemed like a good start.

I noticed that in your presentation you had some other examples of attribut=
es
you cared about:

 * reliability
 * power consumption
 * density

The HMAT doesn't provide this sort of information at present, but we
could/would add them to sysfs if the HMAT ever grew support for them.

> > This allows applications to easily find the memory that they want to us=
e.
> > We expect that the existing NUMA APIs will be enhanced to use this new
> > information so that applications can continue to use them to select the=
ir
> > desired memory.
> =

> I had presented a proposal for NUMA redesign in the Plumbers Conference t=
his
> year where various memory devices with different kind of memory attributes
> can be represented in the kernel and be used explicitly from the user spa=
ce.
> Here is the link to the proposal if you feel interested. The proposal is
> very intrusive and also I dont have a RFC for it yet for discussion here.
> =

> https://linuxplumbersconf.org/2017/ocw//system/presentations/4656/origina=
l/Hierarchical_NUMA_Design_Plumbers_2017.pdf
> =

> Problem is, designing the sysfs interface for memory attribute detection
> from user space without first thinking about redesigning the NUMA for
> heterogeneous memory may not be a good idea. Will look into this further.

I took another look at your presentation, and overall I think that if/when a
NUMA redesign like this takes place ACPI systems with HMAT tables will be a=
ble
to participate.  But I think we are probably a ways away from that, and lik=
e I
said in my previous mail ACPI systems with memory-only NUMA nodes are going=
 to
exist and need to be supported with the current NUMA scheme.  Hence I don't
think that this patch series conflicts with your proposal.

--===============3584464407775001216==--

