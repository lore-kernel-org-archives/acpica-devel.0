Content-Type: multipart/mixed; boundary="===============2892923254978824915=="
MIME-Version: 1.0
From: =?utf-8?q?Gr=C3=A9goire_Sutre_=3Cgregoire=2Esutre_at_gmail=2Ecom=3E?=
Subject: Re: [Devel] Error in documentation of AcpiOsDerivePciId?
Date: Thu, 22 Apr 2010 14:50:20 +0200
Message-ID: <4BD0460C.9080504@gmail.com>
In-Reply-To: 1271892788.7939.9.camel@localhost
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2892923254978824915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lin,

Many thanks for your explanantion, I understand now why the second
argument passed to AcpiOsDerivePciId is a handle to the (PCI_Config)
operation region.

But regarding the first argument of AcpiOsDerivePciId: the ACPICA
programmer reference says that: it is a handle to _the PCI device_.

My question is: which PCI device?

In my (possibly wrong) interpretation of the documentation, _the PCI
device_ is the device for which AcpiOsDerivePciId shall return an
updated Pci id.

However, as far as I understand the code of AcpiEvPciConfigRegionSetup
(in file evrgnini.c), _the PCI device_ turns out to be an ancestor of
the device for which AcpiOsDerivePciId shall return an updated Pci id.
This ancestor being the upstream PCI root bridge (or the ACPI root node
if none was found).  This interpretation of _the PCI device_ is also
consistent with my understanding of the Linux implementation of
AcpiOsDerivePciId, which finds the updated PCI id by ``traversing'' the
PCI-to-PCI bridges that are on the branch from AcpiOsDerivePciId's first
argument to its second argument.

Thanks for your help,

Gr=C3=A9goire


--===============2892923254978824915==--

