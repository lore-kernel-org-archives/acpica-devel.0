Content-Type: multipart/mixed; boundary="===============3776142447256984313=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Coverity CID 134632: acpi_hw_build_pci_list() memory leak
Date: Thu, 03 Apr 2014 18:39:53 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37C7FF18B@ORSMSX103.amr.corp.intel.com>
In-Reply-To: CAErSpo7hZUQsLQw7WHes=_Sb-+Hv_aCZTix+NdpjfkEUAartEg@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3776142447256984313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas(a)google.com]
> Sent: Thursday, April 03, 2014 10:28 AM
> To: Moore, Robert
> Cc: Zheng, Lv; Wysocki, Rafael J; Box, David E; linux-
> acpi(a)vger.kernel.org; devel(a)acpica.org
> Subject: Re: Coverity CID 134632: acpi_hw_build_pci_list() memory leak
> =

> On Thu, Apr 3, 2014 at 11:03 AM, Moore, Robert <robert.moore(a)intel.com>
> wrote:
> > On second thought, did you notice that the caller always deletes the
> list, regardless of the return status?
> =

> Hmm, no, I didn't notice that, and obviously Coverity didn't either.
> So I guess there's no actual bug, as long as every caller deletes the list
> regardless of status.  And there's only one caller.
> =

> I wouldn't hold it up as good style, but I guess it's safe :)


Yes, no real leak. But we will change it anyway on principle.
Thanks,
Bob



> =

> >     /* Build a list of PCI devices, from PciRegion up to RootPciDevice
> > */
> >
> >     Status =3D AcpiHwBuildPciList (RootPciDevice, PciRegion, &ListHead);
> >     if (ACPI_SUCCESS (Status))
> >     {
> >         /* Walk the list, updating the PCI device/function/bus numbers
> > */
> >
> >         Status =3D AcpiHwProcessPciList (PciId, ListHead);
> >     }
> >
> >     /* Always delete the list */
> >
> >     AcpiHwDeletePciList (ListHead);
> >     return_ACPI_STATUS (Status);
> >
> >> -----Original Message-----
> >> From: Bjorn Helgaas [mailto:bhelgaas(a)google.com]
> >> Sent: Thursday, April 03, 2014 9:22 AM
> >> To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J
> >> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> >> Subject: Coverity CID 134632: acpi_hw_build_pci_list() memory leak
> >>
> >> Coverity complains that acpi_hw_build_pci_list() leaks memory when it
> >> returns here:
> >>
> >> 201                if (!list_element) {
> >>
> >> CID 134632 (#1 of 2): Resource leak (RESOURCE_LEAK) 13. leaked_storage:
> >> Variable list_head going out of scope leaks the storage it points to.
> >> 202                        return (AE_NO_MEMORY);
> >> 203                }
> >>
> >> We're building up a list, and if we fail to allocate another element,
> >> we return failure without deallocating the already built-up list.
> >>
> >> This is CID 134632.
> >>
> >> Bjorn

--===============3776142447256984313==--

