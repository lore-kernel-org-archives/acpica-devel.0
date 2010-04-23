Content-Type: multipart/mixed; boundary="===============6630169853808384569=="
MIME-Version: 1.0
From: Lin Ming <lin at ming.vg>
Subject: Re: [Devel] Error in documentation of AcpiOsDerivePciId?
Date: Fri, 23 Apr 2010 12:44:21 +0000
Message-ID: <q2yefbf743b1004230544l5f8afbachb4e75ba38cd0d5d@mail.gmail.com>
In-Reply-To: 4BD0460C.9080504@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6630169853808384569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/4/22 Gr=C3=A9goire Sutre <gregoire.sutre(a)gmail.com>:
> Hi Lin,
>
> Many thanks for your explanantion, I understand now why the second
> argument passed to AcpiOsDerivePciId is a handle to the (PCI_Config)
> operation region.
>
> But regarding the first argument of AcpiOsDerivePciId: the ACPICA
> programmer reference says that: it is a handle to _the PCI device_.
>
> My question is: which PCI device?
>
> In my (possibly wrong) interpretation of the documentation, _the PCI
> device_ is the device for which AcpiOsDerivePciId shall return an
> updated Pci id.
>
> However, as far as I understand the code of AcpiEvPciConfigRegionSetup
> (in file evrgnini.c), _the PCI device_ turns out to be an ancestor of
> the device for which AcpiOsDerivePciId shall return an updated Pci id.
> This ancestor being the upstream PCI root bridge (or the ACPI root node
> if none was found). =C2=A0This interpretation of _the PCI device_ is also
> consistent with my understanding of the Linux implementation of
> AcpiOsDerivePciId, which finds the updated PCI id by ``traversing'' the
> PCI-to-PCI bridges that are on the branch from AcpiOsDerivePciId's first
> argument to its second argument.

You are right, the first argument is the PCI root node.
We may need to update the doc to figure out this.

Thanks,
Lin Ming

--===============6630169853808384569==--

