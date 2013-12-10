Content-Type: multipart/mixed; boundary="===============7045866485547841713=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] PCI/ACPI: Use PCIe segment in the ACPI HEST AER
 error sources
Date: Tue, 10 Dec 2013 00:29:45 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880249694C@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37C7B5522@ORSMSX103.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7045866485547841713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Bjorn

If you git clone the ACPICA git, there is a script in generate/linux.
Please find the commit ID you want through git log, then type:
generate/linux/gen-patch.sh <commit-id>
You can use this to "cherry pick" ACPICA commits.
It is equivalent to what you'll seen in the release process, except some "F=
rom: Signed-off-by:" fields.
I'll going to document this for Linux guys.

Thanks and best regards
-Lv

> -----Original Message-----
> From: Moore, Robert
> Sent: Tuesday, December 10, 2013 8:19 AM
> To: Bjorn Helgaas
> Cc: Betty Dall; rjw(a)rjwysocki.net; Zheng, Lv; devel(a)acpica.org
> Subject: RE: [PATCH] PCI/ACPI: Use PCIe segment in the ACPI HEST AER erro=
r sources
> =

> It will go out in the next ACPICA release, in a few days. Our git tree ca=
n be accessed via the acpica.org website, but the code is not in
> Linux format.
> =

> Bob
> =

> =

> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:bhelgaas(a)google.com]
> > Sent: Monday, December 09, 2013 3:34 PM
> > To: Moore, Robert
> > Cc: Betty Dall; rjw(a)rjwysocki.net; Zheng, Lv; devel(a)acpica.org
> > Subject: Re: [PATCH] PCI/ACPI: Use PCIe segment in the ACPI HEST AER er=
ror
> > sources
> >
> > On Thu, Dec 5, 2013 at 9:11 AM, Moore, Robert <robert.moore(a)intel.com>
> > wrote:
> > > Ok, I've picked up the ACPICA changes in actbl1.h
> >
> > Bob, when do you plan to ask Linus to pull the actbl1.h change?  Do you
> > have a public git tree with that commit in it?  If so, I could cherry-p=
ick
> > it and apply the PCI part on top of it.
> >
> > Bjorn
> >
> > >> -----Original Message-----
> > >> From: Betty Dall [mailto:betty.dall(a)hp.com]
> > >> Sent: Thursday, December 05, 2013 7:08 AM
> > >> To: lenb(a)kernel.org; rjw(a)rjwysocki.net; bhelgaas(a)google.com; M=
oore,
> > >> Robert; Zheng, Lv
> > >> Cc: linux-acpi(a)vger.kernel.org; linux-kernel(a)vger.kernel.org; li=
nux-
> > >> pci(a)vger.kernel.org; devel(a)acpica.org; Betty Dall
> > >> Subject: [PATCH] PCI/ACPI: Use PCIe segment in the ACPI HEST AER
> > >> error sources
> > >>
> > >> In the discussion for this set of patches:
> > >> https://lkml.org/lkml/2013/6/6/517,
> > >> Bjorn Helgaas pointed out that the ACPI HEST AER error sources do not
> > >> have the PCIe segment number associated with the bus. I worked with
> > >> the ACPI spec and got this change to definition of the "Bus" field
> > >> into the recently released ACPI Spec 5.0a section 18.3.2.3-5:
> > >>
> > >> "Identifies the PCI Bus and Segment of the device. The Bus is encoded
> > >> in bits 0-7. For systems that expose multiple PCI segment groups, the
> > >> segment number is encoded in bits 8-23 and bits 24-31 must be zero.
> > >> For systems that do not expose multiple PCI segment groups, bits 8-31
> > >> must be zero. If the GLOBAL flag is specified, this field is ignored=
."
> > >>
> > >> This patch makes use of the new definition in the only place in the
> > >> kernel that uses the acpi_hest_aer_common's bus field.
> > >>
> > >> Signed-off-by: Betty Dall <betty.dall(a)hp.com>
> > >> ---
> > >>
> > >>  drivers/pci/pcie/aer/aerdrv_acpi.c |    8 ++++----
> > >>  include/acpi/actbl1.h              |   11 ++++++++++-
> > >>  2 files changed, 14 insertions(+), 5 deletions(-)
> > >>
> > >>
> > >> diff --git a/drivers/pci/pcie/aer/aerdrv_acpi.c
> > >> b/drivers/pci/pcie/aer/aerdrv_acpi.c
> > >> index cf611ab..93f852b 100644
> > >> --- a/drivers/pci/pcie/aer/aerdrv_acpi.c
> > >> +++ b/drivers/pci/pcie/aer/aerdrv_acpi.c
> > >> @@ -23,10 +23,10 @@
> > >>  static inline int hest_match_pci(struct acpi_hest_aer_common *p,
> > >>                                struct pci_dev *pci)  {
> > >> -     return  (0           =3D=3D pci_domain_nr(pci->bus) &&
> > >> -              p->bus      =3D=3D pci->bus->number &&
> > >> -              p->device   =3D=3D PCI_SLOT(pci->devfn) &&
> > >> -              p->function =3D=3D PCI_FUNC(pci->devfn));
> > >> +     return   ACPI_HEST_SEGMENT(p->bus) =3D=3D pci_domain_nr(pci->b=
us) &&
> > >> +              ACPI_HEST_BUS(p->bus)     =3D=3D pci->bus->number &&
> > >> +              p->device                 =3D=3D PCI_SLOT(pci->devfn)=
 &&
> > >> +              p->function               =3D=3D PCI_FUNC(pci->devfn);
> > >>  }
> > >>
> > >>  static inline bool hest_match_type(struct acpi_hest_header
> > >> *hest_hdr, diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> > >> index 556c83ee..0c7428b 100644
> > >> --- a/include/acpi/actbl1.h
> > >> +++ b/include/acpi/actbl1.h
> > >> @@ -457,7 +457,7 @@ struct acpi_hest_aer_common {
> > >>       u8 enabled;
> > >>       u32 records_to_preallocate;
> > >>       u32 max_sections_per_record;
> > >> -     u32 bus;
> > >> +     u32 bus;                /* bus: bits 0-7; segment: bits 8-23 */
> > >>       u16 device;
> > >>       u16 function;
> > >>       u16 device_control;
> > >> @@ -473,6 +473,15 @@ struct acpi_hest_aer_common {
> > >>  #define ACPI_HEST_FIRMWARE_FIRST        (1)
> > >>  #define ACPI_HEST_GLOBAL                (1<<1)
> > >>
> > >> +/*
> > >> + * The segment/bus of the PCIe device is encoded in the bus field
> > >> + * of the acpi_hest_aer_common structure as follows:
> > >> + *      23:8 =3D segment
> > >> + *      7:0 =3D bus
> > >> + */
> > >> +#define ACPI_HEST_SEGMENT(bus)               (((bus) >> 8) & 0xFFFF)
> > >> +#define ACPI_HEST_BUS(bus)           ((bus) & 0xFF)
> > >> +
> > >>  /* Hardware Error Notification */
> > >>
> > >>  struct acpi_hest_notify {

--===============7045866485547841713==--

