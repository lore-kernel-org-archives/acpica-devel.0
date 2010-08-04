Content-Type: multipart/mixed; boundary="===============5555541484093426592=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Error in documentation of AcpiOsDerivePciId?
Date: Wed, 04 Aug 2010 14:36:35 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858AC59CE99@orsmsx503.amr.corp.intel.com>
In-Reply-To: 4C555B05.9020708@s-t.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5555541484093426592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Yes, there is a reason for ACPI_PCI_ID **.

From the ACPI Component Architecture User Guide and Programmer Reference:


AcpiOsDerivePciId
-----------------

PciId	=


Input: The full PCI ID (The full PCI configuration space address, consistin=
g of a segment number, bus number, device number, and function number) as o=
btained from control methods within the BIOS ACPI tables.

Output: Where the derived PCI ID is returned. Some or all of the PCI ID sub=
fields may be updated by this function.



This function derives a full PCI ID for a PCI device, consisting of a Segme=
nt number, a Bus number, and a Device number.

The PCI hardware dynamically configures PCI bus numbers depending on the bu=
s topology discovered during system initialization. The AcpiOsDerivePciId f=
unction is invoked by the ACPICA subsystem during configuration of a PCI_Co=
nfig Operation Region in order to (possibly) update the Bus number in the P=
ciId with the actual Bus number as determined by the hardware and operating=
 system configuration.

The PciId parameter is initially populated by the ACPICA subsystem during t=
he Operation Region initialization. ACPICA then calls AcpiOsDerivePciId, wh=
ich is expected to make any necessary modifications to the Segment, Bus, or=
 Device number PCI ID subfields as appropriate for the current hardware and=
 OS configuration.



>-----Original Message-----
>From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On Be=
half
>Of Rudi
>Sent: Sunday, August 01, 2010 4:31 AM
>Cc: devel(a)acpica.org
>Subject: Re: [Devel] Error in documentation of AcpiOsDerivePciId?
>
>Hi all,
>
>is that still in the agenda ? Also, what is the reason why the last
>parameter of AcpiOsDerivePciId() is "ACPI_PCI_ID **" and not just
>"ACPI_PCI_ID *" ? Are there any situations, where AcpiOsDerivePciId
>would want to reallocate PciId ?
>
>
>
>
>Lin Ming wrote:
>> 2010/4/22 Gr=C3=A9goire Sutre <gregoire.sutre(a)gmail.com>:
>>> Hi Lin,
>>>
>>> Many thanks for your explanantion, I understand now why the second
>>> argument passed to AcpiOsDerivePciId is a handle to the (PCI_Config)
>>> operation region.
>>>
>>> But regarding the first argument of AcpiOsDerivePciId: the ACPICA
>>> programmer reference says that: it is a handle to _the PCI device_.
>>>
>>> My question is: which PCI device?
>>>
>>> In my (possibly wrong) interpretation of the documentation, _the PCI
>>> device_ is the device for which AcpiOsDerivePciId shall return an
>>> updated Pci id.
>>>
>>> However, as far as I understand the code of AcpiEvPciConfigRegionSetup
>>> (in file evrgnini.c), _the PCI device_ turns out to be an ancestor of
>>> the device for which AcpiOsDerivePciId shall return an updated Pci id.
>>> This ancestor being the upstream PCI root bridge (or the ACPI root node
>>> if none was found).  This interpretation of _the PCI device_ is also
>>> consistent with my understanding of the Linux implementation of
>>> AcpiOsDerivePciId, which finds the updated PCI id by ``traversing'' the
>>> PCI-to-PCI bridges that are on the branch from AcpiOsDerivePciId's first
>>> argument to its second argument.
>>
>> You are right, the first argument is the PCI root node.
>> We may need to update the doc to figure out this.
>>
>> Thanks,
>> Lin Ming
>> _______________________________________________
>> Devel mailing list
>> Devel(a)acpica.org
>> http://lists.acpica.org/listinfo/devel
>>
>> To: gregoire.sutre(a)gmail.com
>> Cc: devel(a)acpica.org
>
>--
>
>Ruediger "Rudi" Ihle
>
>"There's a fine line between wrong and visionary. Unfortunately
> you have to be a visionary to see it." - Sheldon Cooper, Ph.D.
>_______________________________________________
>Devel mailing list
>Devel(a)acpica.org
>http://lists.acpica.org/listinfo/devel

--===============5555541484093426592==--

