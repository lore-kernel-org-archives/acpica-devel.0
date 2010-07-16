Content-Type: multipart/mixed; boundary="===============1699208963105174799=="
MIME-Version: 1.0
From: Lin Ming <ming.m.lin at intel.com>
Subject: Re: [Devel] AcpiOsReadPciConfiguration
Date: Fri, 16 Jul 2010 14:36:33 +0800
Message-ID: <1279262193.2881.14.camel@minggr.sh.intel.com>
In-Reply-To: 4C3FF25D.3050008@s-t.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1699208963105174799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-07-16 at 13:47 +0800, R=C3=BCdiger Ihle wrote:
> Hi all,
> =

> =

> what's the correct prototype for AcpiOsReadPciConfiguration ?
> =

> The acpica-reference.pdf says:
> =

> AcpiOsReadPciConfiguration (
>     ACPI_PCI_ID             *PciId,
>     UINT32                  Reg,
>     UINT64                  *Value,
>     UINT32                  Width);
> =

> =

> while acpiosxf.h states:
> =

> =

> AcpiOsReadPciConfiguration (
>     ACPI_PCI_ID             *PciId,
>     UINT32                  Reg,
>     void                    *Value,
>     UINT32                  Width);

We may fix it with UINT64* or UINT32*.


--===============1699208963105174799==--

