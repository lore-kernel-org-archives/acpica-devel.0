Content-Type: multipart/mixed; boundary="===============2900247239565801685=="
MIME-Version: 1.0
From: Ross Zwisler <ross.zwisler at linux.intel.com>
Subject: Re: [Devel] [RFC v2 3/5] hmem: add heterogeneous memory sysfs support
Date: Fri, 07 Jul 2017 10:32:13 -0600
Message-ID: <20170707163213.GC22856@linux.intel.com>
In-Reply-To: 9ea40a37-3549-2294-8605-036b37aec023@nvidia.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2900247239565801685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 10:53:39PM -0700, John Hubbard wrote:
> On 07/06/2017 02:52 PM, Ross Zwisler wrote:
> [...]
> > diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> > index b1aacfc..31e3f20 100644
> > --- a/drivers/acpi/Makefile
> > +++ b/drivers/acpi/Makefile
> > @@ -72,6 +72,7 @@ obj-$(CONFIG_ACPI_PROCESSOR)	+=3D processor.o
> >  obj-$(CONFIG_ACPI)		+=3D container.o
> >  obj-$(CONFIG_ACPI_THERMAL)	+=3D thermal.o
> >  obj-$(CONFIG_ACPI_NFIT)		+=3D nfit/
> > +obj-$(CONFIG_ACPI_HMEM)		+=3D hmem/
> >  obj-$(CONFIG_ACPI)		+=3D acpi_memhotplug.o
> >  obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) +=3D ioapic.o
> >  obj-$(CONFIG_ACPI_BATTERY)	+=3D battery.o
> =

> Hi Ross,
> =

> Following are a series of suggestions, intended to clarify naming just
> enough so that, when Jerome's HMM patchset lands, we'll be able to
> tell the difference between the two types of Heterogeneous Memory.

Sure, these all seem sane to me, thanks.  I'll fix this up in v3.

--===============2900247239565801685==--

