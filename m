Content-Type: multipart/mixed; boundary="===============0225463438630228271=="
MIME-Version: 1.0
From: =?utf-8?q?Gr=C3=A9goire_Sutre_=3Cgregoire=2Esutre_at_gmail=2Ecom=3E?=
Subject: Re: [Devel] Error in documentation of AcpiOsDerivePciId?
Date: Tue, 20 Apr 2010 18:07:16 +0200
Message-ID: <4BCDD134.5060508@gmail.com>
In-Reply-To: 4911F71203A09E4D9981D27F9D830858622A0AB2@orsmsx503.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0225463438630228271==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robert,

First I want to thank you for your answer.

> It looks to me that the documentation (ACPICA programmer reference) is co=
rrect.
> =

> However, the acpiosxf.h file uses names that don't match the documentatio=
n and are not very descriptive.
> =

> The ACPICA code uses a variable named "PciRootNode" for the "DeviceHandle=
" parameter, that is ok.

The call to AcpiOsDerivePciId that I mentioned is performed in the
function AcpiEvPciConfigRegionSetup of events/evrgnini.c.  Looking at
this function (from acpica unix source code release 20100331), I see
that:

- RegionObj->Region.Node is the PCI device node that we are interested
   in.  This is confirmed by the part that finds the parent device
   object, which starts with:
   PciDeviceNode =3D RegionObj->Region.Node;

- PciRootNode is the PCI root bridge upstream of the PCI device node
   that we are interested in.  Indeed, there is a while-loop that walks
   the ancestors of the PCI device node until a PCI root bridge is found,
   iteratively assigning PciRootNode to these ancestors.  See lines 312
   to 360.

This is the reason why I believe that in the call

AcpiOsDerivePciId (PciRootNode, RegionObj->Region.Node, &PciId);

- PciRootNode is not a handle to the PCI device, it is a handle to its
   upstream PCI root bridge, and
- RegionObj->Region.Node is a handle to the PCI device.

>> So it seems to me that the correct arguments for AcpiOsDerivePciId are:
> =

>> AcpiOsDerivePciId(
>>    ACPI_HANDLE		PciRootHandle
>>    ACPI_HANDLE		DeviceHandle
>>    ACPI_PCI_ID		**PciId)
> =

> =

> No, I don't think so. The second parameter is a handle to a region object.

In the above call to AcpiOsDerivePciId, the second parameter, which is
RegionObj->Region.Node, is of type (ACPI_NAMESPACE_NODE *).  I'm not
familiar with all the ACPI types, but I guess that this type is not for
region objects.

Note that the implementation of AcpiOsDerivePciId in the linux kernel
(as well as in the freebsd and netbsd kernels) seem to understand its
interface in the same way as I did.

http://lxr.linux.no/#linux+v2.6.33/drivers/acpi/osl.c#L689

Best regards,

Gr=C3=A9goire

>> -----Original Message-----
>> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On =
Behalf
>> Of Gr=C3=A9goire Sutre
>> Sent: Tuesday, April 20, 2010 2:46 AM
>> To: devel(a)acpica.org
>> Subject: [Devel] Error in documentation of AcpiOsDerivePciId?
>>
>> Hi list,
>>
>> According to the ACPICA Programmer Reference, the function
>> AcpiOsDerivePciId takes as arguments:
>>
>> AcpiOsDerivePciId(
>>    ACPI_HANDLE		DeviceHandle
>>    ACPI_HANDLE		PciRegionHandle
>>    ACPI_PCI_ID		**PciId)
>>
>> with:
>> - DeviceHandle:		a handle to the PCI device.
>> - PciRegionHandle:	a handle the PCI configuration space operation
>>                         region.
>>
>>
>> However, the only call to AcpiOsDerivePciId in the ACPICA code, in
>> events/evrgnini.c, is:
>>
>> AcpiOsDerivePciId (PciRootNode, RegionObj->Region.Node, &PciId);
>>
>> Moreover, the file include/acpiosxf.h contains:
>>
>> /*
>>  * Interim function needed for PCI IRQ routing
>>  */
>> void
>> AcpiOsDerivePciId(
>>     ACPI_HANDLE             Rhandle,
>>     ACPI_HANDLE             Chandle,
>>     ACPI_PCI_ID             **PciId);
>>
>>
>> So it seems to me that the correct arguments for AcpiOsDerivePciId are:
>>
>> AcpiOsDerivePciId(
>>    ACPI_HANDLE		PciRootHandle
>>    ACPI_HANDLE		DeviceHandle
>>    ACPI_PCI_ID		**PciId)
>>
>> with:
>> - PciRootHandle:	a handle the PCI root bridge upstream of the PCI
>>                         device (or to the name space root node if no
>>                         PCI root bridge was found in the ancestors).
>> - DeviceHandle:		a handle to the PCI device.
>>
>>
>> Is that correct?
>>
>> Thanks for your help,
>>
>> Gr=C3=A9goire
>> _______________________________________________
>> Devel mailing list
>> Devel(a)acpica.org
>> http://lists.acpica.org/listinfo/devel


--===============0225463438630228271==--

