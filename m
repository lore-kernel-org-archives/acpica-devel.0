Content-Type: multipart/mixed; boundary="===============1451115809947876555=="
MIME-Version: 1.0
From: Rudi <r.ihle at s-t.de>
Subject: Re: [Devel] Error in documentation of AcpiOsDerivePciId?
Date: Sun, 01 Aug 2010 13:31:17 +0200
Message-ID: <4C555B05.9020708@s-t.de>
In-Reply-To: q2yefbf743b1004230544l5f8afbachb4e75ba38cd0d5d@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1451115809947876555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

is that still in the agenda ? Also, what is the reason why the last
parameter of AcpiOsDerivePciId() is "ACPI_PCI_ID **" and not just
"ACPI_PCI_ID *" ? Are there any situations, where AcpiOsDerivePciId
would want to reallocate PciId ?




Lin Ming wrote:
> 2010/4/22 Gr=C3=A9goire Sutre <gregoire.sutre(a)gmail.com>:
>> Hi Lin,
>>
>> Many thanks for your explanantion, I understand now why the second
>> argument passed to AcpiOsDerivePciId is a handle to the (PCI_Config)
>> operation region.
>>
>> But regarding the first argument of AcpiOsDerivePciId: the ACPICA
>> programmer reference says that: it is a handle to _the PCI device_.
>>
>> My question is: which PCI device?
>>
>> In my (possibly wrong) interpretation of the documentation, _the PCI
>> device_ is the device for which AcpiOsDerivePciId shall return an
>> updated Pci id.
>>
>> However, as far as I understand the code of AcpiEvPciConfigRegionSetup
>> (in file evrgnini.c), _the PCI device_ turns out to be an ancestor of
>> the device for which AcpiOsDerivePciId shall return an updated Pci id.
>> This ancestor being the upstream PCI root bridge (or the ACPI root node
>> if none was found).  This interpretation of _the PCI device_ is also
>> consistent with my understanding of the Linux implementation of
>> AcpiOsDerivePciId, which finds the updated PCI id by ``traversing'' the
>> PCI-to-PCI bridges that are on the branch from AcpiOsDerivePciId's first
>> argument to its second argument.
> =

> You are right, the first argument is the PCI root node.
> We may need to update the doc to figure out this.
> =

> Thanks,
> Lin Ming
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> http://lists.acpica.org/listinfo/devel
> =

> To: gregoire.sutre(a)gmail.com
> Cc: devel(a)acpica.org

-- =


Ruediger "Rudi" Ihle

"There's a fine line between wrong and visionary. Unfortunately
 you have to be a visionary to see it." - Sheldon Cooper, Ph.D.

--===============1451115809947876555==--

