Content-Type: multipart/mixed; boundary="===============8258077409054068563=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Error in documentation of AcpiOsDerivePciId?
Date: Tue, 20 Apr 2010 07:51:23 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858622A0AB2@orsmsx503.amr.corp.intel.com>
In-Reply-To: 4BCD77CE.6050601@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8258077409054068563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It looks to me that the documentation (ACPICA programmer reference) is corr=
ect.

However, the acpiosxf.h file uses names that don't match the documentation =
and are not very descriptive.

The ACPICA code uses a variable named "PciRootNode" for the "DeviceHandle" =
parameter, that is ok.


>So it seems to me that the correct arguments for AcpiOsDerivePciId are:

>AcpiOsDerivePciId(
>    ACPI_HANDLE		PciRootHandle
>    ACPI_HANDLE		DeviceHandle
>    ACPI_PCI_ID		**PciId)


No, I don't think so. The second parameter is a handle to a region object.



>-----Original Message-----
>From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On Be=
half
>Of Gr=C3=A9goire Sutre
>Sent: Tuesday, April 20, 2010 2:46 AM
>To: devel(a)acpica.org
>Subject: [Devel] Error in documentation of AcpiOsDerivePciId?
>
>Hi list,
>
>According to the ACPICA Programmer Reference, the function
>AcpiOsDerivePciId takes as arguments:
>
>AcpiOsDerivePciId(
>    ACPI_HANDLE		DeviceHandle
>    ACPI_HANDLE		PciRegionHandle
>    ACPI_PCI_ID		**PciId)
>
>with:
>- DeviceHandle:		a handle to the PCI device.
>- PciRegionHandle:	a handle the PCI configuration space operation
>                         region.
>
>
>However, the only call to AcpiOsDerivePciId in the ACPICA code, in
>events/evrgnini.c, is:
>
>AcpiOsDerivePciId (PciRootNode, RegionObj->Region.Node, &PciId);
>
>Moreover, the file include/acpiosxf.h contains:
>
>/*
>  * Interim function needed for PCI IRQ routing
>  */
>void
>AcpiOsDerivePciId(
>     ACPI_HANDLE             Rhandle,
>     ACPI_HANDLE             Chandle,
>     ACPI_PCI_ID             **PciId);
>
>
>So it seems to me that the correct arguments for AcpiOsDerivePciId are:
>
>AcpiOsDerivePciId(
>    ACPI_HANDLE		PciRootHandle
>    ACPI_HANDLE		DeviceHandle
>    ACPI_PCI_ID		**PciId)
>
>with:
>- PciRootHandle:	a handle the PCI root bridge upstream of the PCI
>                         device (or to the name space root node if no
>                         PCI root bridge was found in the ancestors).
>- DeviceHandle:		a handle to the PCI device.
>
>
>Is that correct?
>
>Thanks for your help,
>
>Gr=C3=A9goire
>_______________________________________________
>Devel mailing list
>Devel(a)acpica.org
>http://lists.acpica.org/listinfo/devel

--===============8258077409054068563==--

