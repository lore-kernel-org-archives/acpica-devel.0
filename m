Content-Type: multipart/mixed; boundary="===============6704040557483777294=="
MIME-Version: 1.0
From: =?utf-8?q?Gr=C3=A9goire_Sutre_=3Cgregoire=2Esutre_at_gmail=2Ecom=3E?=
Subject: [Devel] Error in documentation of AcpiOsDerivePciId?
Date: Tue, 20 Apr 2010 11:45:50 +0200
Message-ID: <4BCD77CE.6050601@gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6704040557483777294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi list,

According to the ACPICA Programmer Reference, the function
AcpiOsDerivePciId takes as arguments:

AcpiOsDerivePciId(
    ACPI_HANDLE		DeviceHandle
    ACPI_HANDLE		PciRegionHandle
    ACPI_PCI_ID		**PciId)

with:
- DeviceHandle:		a handle to the PCI device.
- PciRegionHandle:	a handle the PCI configuration space operation
                         region.


However, the only call to AcpiOsDerivePciId in the ACPICA code, in
events/evrgnini.c, is:

AcpiOsDerivePciId (PciRootNode, RegionObj->Region.Node, &PciId);

Moreover, the file include/acpiosxf.h contains:

/*
  * Interim function needed for PCI IRQ routing
  */
void
AcpiOsDerivePciId(
     ACPI_HANDLE             Rhandle,
     ACPI_HANDLE             Chandle,
     ACPI_PCI_ID             **PciId);


So it seems to me that the correct arguments for AcpiOsDerivePciId are:

AcpiOsDerivePciId(
    ACPI_HANDLE		PciRootHandle
    ACPI_HANDLE		DeviceHandle
    ACPI_PCI_ID		**PciId)

with:
- PciRootHandle:	a handle the PCI root bridge upstream of the PCI
                         device (or to the name space root node if no
                         PCI root bridge was found in the ancestors).
- DeviceHandle:		a handle to the PCI device.


Is that correct?

Thanks for your help,

Gr=C3=A9goire

--===============6704040557483777294==--

