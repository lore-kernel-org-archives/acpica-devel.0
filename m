Content-Type: multipart/mixed; boundary="===============3658534555680095297=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] AcpiOsReadPciConfiguration
Date: Fri, 16 Jul 2010 08:21:42 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858A1302E10@orsmsx503.amr.corp.intel.com>
In-Reply-To: 1279262193.2881.14.camel@minggr.sh.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3658534555680095297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It should be UINT64*. I am fixing acpiosxf.h for the next ACPICA release.

Thanks,
Bob


>-----Original Message-----
>From: Lin, Ming M
>Sent: Thursday, July 15, 2010 11:37 PM
>To: R=C3=BCdiger Ihle; Jung-uk Kim; Moore, Robert
>Cc: devel(a)acpica.org
>Subject: Re: [Devel] AcpiOsReadPciConfiguration
>
>On Fri, 2010-07-16 at 13:47 +0800, R=C3=BCdiger Ihle wrote:
>> Hi all,
>>
>>
>> what's the correct prototype for AcpiOsReadPciConfiguration ?
>>
>> The acpica-reference.pdf says:
>>
>> AcpiOsReadPciConfiguration (
>>     ACPI_PCI_ID             *PciId,
>>     UINT32                  Reg,
>>     UINT64                  *Value,
>>     UINT32                  Width);
>>
>>
>> while acpiosxf.h states:
>>
>>
>> AcpiOsReadPciConfiguration (
>>     ACPI_PCI_ID             *PciId,
>>     UINT32                  Reg,
>>     void                    *Value,
>>     UINT32                  Width);
>
>We may fix it with UINT64* or UINT32*.


--===============3658534555680095297==--

