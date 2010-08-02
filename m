Content-Type: multipart/mixed; boundary="===============1194686087363330718=="
MIME-Version: 1.0
From: Lin Ming <ming.m.lin at intel.com>
Subject: Re: [Devel] Error in documentation of AcpiOsDerivePciId?
Date: Mon, 02 Aug 2010 08:29:11 +0800
Message-ID: <1280708951.20797.153.camel@minggr.sh.intel.com>
In-Reply-To: 4C555B05.9020708@s-t.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1194686087363330718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 2010-08-01 at 19:31 +0800, Rudi wrote:
> Hi all,
> =

> is that still in the agenda ? Also, what is the reason why the last
> parameter of AcpiOsDerivePciId() is "ACPI_PCI_ID **" and not just
> "ACPI_PCI_ID *" ? Are there any situations, where AcpiOsDerivePciId
> would want to reallocate PciId ?

Yes, this is in agenda.

Currently, AcpiOsDerivePciId is implemented by OS, but actually this
function can be OS independent. So we are implementing it in ACPICA,
once for every OS.

Any yes, the last parameter should be better to be "ACPI_PCI_ID *".
Thanks for the catch.

Lin Ming

> Lin Ming wrote:
> > 2010/4/22 Gr=C3=A9goire Sutre <gregoire.sutre(a)gmail.com>:
> >> Hi Lin,
> >>
> >> Many thanks for your explanantion, I understand now why the second
> >> argument passed to AcpiOsDerivePciId is a handle to the (PCI_Config)
> >> operation region.
> >>
> >> But regarding the first argument of AcpiOsDerivePciId: the ACPICA
> >> programmer reference says that: it is a handle to _the PCI device_.
> >>
> >> My question is: which PCI device?
> >>
> >> In my (possibly wrong) interpretation of the documentation, _the PCI
> >> device_ is the device for which AcpiOsDerivePciId shall return an
> >> updated Pci id.
> >>
> >> However, as far as I understand the code of AcpiEvPciConfigRegionSetup
> >> (in file evrgnini.c), _the PCI device_ turns out to be an ancestor of
> >> the device for which AcpiOsDerivePciId shall return an updated Pci id.
> >> This ancestor being the upstream PCI root bridge (or the ACPI root node
> >> if none was found).  This interpretation of _the PCI device_ is also
> >> consistent with my understanding of the Linux implementation of
> >> AcpiOsDerivePciId, which finds the updated PCI id by ``traversing'' the
> >> PCI-to-PCI bridges that are on the branch from AcpiOsDerivePciId's fir=
st
> >> argument to its second argument.
> > =

> > You are right, the first argument is the PCI root node.
> > We may need to update the doc to figure out this.
> > =

> > Thanks,
> > Lin Ming
> > _______________________________________________
> > Devel mailing list
> > Devel(a)acpica.org
> > http://lists.acpica.org/listinfo/devel
> > =

> > To: gregoire.sutre(a)gmail.com
> > Cc: devel(a)acpica.org
> =




--===============1194686087363330718==--

