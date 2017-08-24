Content-Type: multipart/mixed; boundary="===============0155035568087386964=="
MIME-Version: 1.0
From: John Garry <john.garry at huawei.com>
Subject: Re: [Devel] [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based
 HiSilicon erratum 161010801
Date: Thu, 24 Aug 2017 16:01:08 +0100
Message-ID: <9a40f823-4323-21fd-343c-83c412a23bf1@huawei.com>
In-Reply-To: 20170824143536.GA8904@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0155035568087386964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 24/08/2017 15:35, Will Deacon wrote:
>>>> > >>OK, seems reasonable.
>>>> > >>
>>>> > >>We would consider blacklisting the device, where/how to do is the =
question.
>>>> > >>
>>>> > >>So the errata is in the GICv3 ITS/PCI host controller, and we just=
 use the
>>>> > >>in-between SMMU (driver) to provide the workaround. So my initial =
impression
>>>> > >>is that the PCI host controller would have to be blacklisted IFF b=
ehind an
>>>> > >>IOMMU for DT firmware in pcie-hisi.c or pci quirks framework. How =
does it
>>>> > >>sound?
>>> > >
>>> > >If that avoids us running into the erratum, then fine by me. I'd obv=
iously
>>> > >prefer we work-around it since we know how to, but that's up to you.
>> >
>> > I'm surpsised that you may want more errata workaround code to maintai=
n.
>> >
>> > Anyway we'll check both approaches and show you how they look and go f=
rom
>> > there.
> Don't get me wrong, I don't dream about adding errata workarounds to the
> code, but our job as an operating system is to abstract the hardware from
> the user, which means dealing with its quirks whether we like it or not.
>

Fine, it's ok.

For our next platform, hip08, we will provide no DT FW support, so this =

whole DT grey area should not be an issue.

And hopefully no errata also.

Much appreciated,
John

> Thanks,
>
> Will



--===============0155035568087386964==--

