Content-Type: multipart/mixed; boundary="===============8598743723813805149=="
MIME-Version: 1.0
From: Lin Ming <ming.m.lin at intel.com>
Subject: Re: [Devel] Error in documentation of AcpiOsDerivePciId?
Date: Wed, 21 Apr 2010 23:33:08 +0000
Message-ID: <1271892788.7939.9.camel@localhost>
In-Reply-To: 4BCDD134.5060508@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8598743723813805149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-04-21 at 00:07 +0800, Gr=C3=A9goire Sutre wrote:
> Hi Robert,
> =

> First I want to thank you for your answer.
> =

> > It looks to me that the documentation (ACPICA programmer reference) is =
correct.
> > =

> > However, the acpiosxf.h file uses names that don't match the documentat=
ion and are not very descriptive.
> > =

> > The ACPICA code uses a variable named "PciRootNode" for the "DeviceHand=
le" parameter, that is ok.
> =

> The call to AcpiOsDerivePciId that I mentioned is performed in the
> function AcpiEvPciConfigRegionSetup of events/evrgnini.c.  Looking at
> this function (from acpica unix source code release 20100331), I see
> that:
> =

> - RegionObj->Region.Node is the PCI device node that we are interested

No, RegionObj->Region.Node is the region's containing namespace node,
for example below ASL code

Device(D000)
{
	OperationRegion (PMIO, SystemIO, 0x1000, 0x80)
}

RegionObj->Region.Node is the node of "PMIO".
Region object is RegionObj->Region.Node->Object

>    in.  This is confirmed by the part that finds the parent device
>    object, which starts with:
>    PciDeviceNode =3D RegionObj->Region.Node;

385     PciDeviceNode =3D RegionObj->Region.Node;
386     while (PciDeviceNode && (PciDeviceNode->Type !=3D ACPI_TYPE_DEVICE))
387     {
388         PciDeviceNode =3D AcpiNsGetParentNode (PciDeviceNode);
389     }

See, it gets the parent node.
As above example, the parent node of PMIO is D000

> =

> - PciRootNode is the PCI root bridge upstream of the PCI device node
>    that we are interested in.  Indeed, there is a while-loop that walks
>    the ancestors of the PCI device node until a PCI root bridge is found,
>    iteratively assigning PciRootNode to these ancestors.  See lines 312
>    to 360.
> =

> This is the reason why I believe that in the call
> =

> AcpiOsDerivePciId (PciRootNode, RegionObj->Region.Node, &PciId);
> =

> - PciRootNode is not a handle to the PCI device, it is a handle to its
>    upstream PCI root bridge, and
> - RegionObj->Region.Node is a handle to the PCI device.
> =

> >> So it seems to me that the correct arguments for AcpiOsDerivePciId are:
> > =

> >> AcpiOsDerivePciId(
> >>    ACPI_HANDLE		PciRootHandle
> >>    ACPI_HANDLE		DeviceHandle
> >>    ACPI_PCI_ID		**PciId)
> > =

> > =

> > No, I don't think so. The second parameter is a handle to a region obje=
ct.
> =

> In the above call to AcpiOsDerivePciId, the second parameter, which is
> RegionObj->Region.Node, is of type (ACPI_NAMESPACE_NODE *).  I'm not
> familiar with all the ACPI types, but I guess that this type is not for
> region objects.

Region has a node and the "object" is attached under the node.

> =

> Note that the implementation of AcpiOsDerivePciId in the linux kernel
> (as well as in the freebsd and netbsd kernels) seem to understand its
> interface in the same way as I did.
> =

> http://lxr.linux.no/#linux+v2.6.33/drivers/acpi/osl.c#L689

 632 static void acpi_os_derive_pci_id_2(acpi_handle rhandle,        /* upp=
er bound  */
 633                                     acpi_handle chandle,        /* cur=
rent node */
 634                                     struct acpi_pci_id **id,
 635                                     int *is_bridge, u8 * bus_number)
 636 {
 637         acpi_handle handle;
 638         struct acpi_pci_id *pci_id =3D *id;
 639         acpi_status status;
 640         unsigned long long temp;
 641         acpi_object_type type;
 642 =

 643         acpi_get_parent(chandle, &handle);
 644         if (handle !=3D rhandle) {
 645                 acpi_os_derive_pci_id_2(rhandle, handle, &pci_id, is_b=
ridge,
 646                                         bus_number);

Check Linux code, chandle is the region node.
See line 643, it gets the parent node of region node first and then go
on...

Lin Ming

> =

> Best regards,
> =

> Gr=C3=A9goire
> =

> >> -----Original Message-----
> >> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] O=
n Behalf
> >> Of Gr=C3=A9goire Sutre
> >> Sent: Tuesday, April 20, 2010 2:46 AM
> >> To: devel(a)acpica.org
> >> Subject: [Devel] Error in documentation of AcpiOsDerivePciId?
> >>
> >> Hi list,
> >>
> >> According to the ACPICA Programmer Reference, the function
> >> AcpiOsDerivePciId takes as arguments:
> >>
> >> AcpiOsDerivePciId(
> >>    ACPI_HANDLE		DeviceHandle
> >>    ACPI_HANDLE		PciRegionHandle
> >>    ACPI_PCI_ID		**PciId)
> >>
> >> with:
> >> - DeviceHandle:		a handle to the PCI device.
> >> - PciRegionHandle:	a handle the PCI configuration space operation
> >>                         region.
> >>
> >>
> >> However, the only call to AcpiOsDerivePciId in the ACPICA code, in
> >> events/evrgnini.c, is:
> >>
> >> AcpiOsDerivePciId (PciRootNode, RegionObj->Region.Node, &PciId);
> >>
> >> Moreover, the file include/acpiosxf.h contains:
> >>
> >> /*
> >>  * Interim function needed for PCI IRQ routing
> >>  */
> >> void
> >> AcpiOsDerivePciId(
> >>     ACPI_HANDLE             Rhandle,
> >>     ACPI_HANDLE             Chandle,
> >>     ACPI_PCI_ID             **PciId);
> >>
> >>
> >> So it seems to me that the correct arguments for AcpiOsDerivePciId are:
> >>
> >> AcpiOsDerivePciId(
> >>    ACPI_HANDLE		PciRootHandle
> >>    ACPI_HANDLE		DeviceHandle
> >>    ACPI_PCI_ID		**PciId)
> >>
> >> with:
> >> - PciRootHandle:	a handle the PCI root bridge upstream of the PCI
> >>                         device (or to the name space root node if no
> >>                         PCI root bridge was found in the ancestors).
> >> - DeviceHandle:		a handle to the PCI device.
> >>
> >>
> >> Is that correct?
> >>
> >> Thanks for your help,
> >>
> >> Gr=C3=A9goire
> >> _______________________________________________
> >> Devel mailing list
> >> Devel(a)acpica.org
> >> http://lists.acpica.org/listinfo/devel
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> http://lists.acpica.org/listinfo/devel



--===============8598743723813805149==--

