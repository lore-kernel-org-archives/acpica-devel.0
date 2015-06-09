Content-Type: multipart/mixed; boundary="===============3206387465387930667=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] acpi: update struct acpi_table_tpm2
Date: Tue, 09 Jun 2015 14:21:12 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F2BE7@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 20150609091757.GB4968@jsakkine-mobl1
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3206387465387930667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ACPICA usually defines any "related" data structures, just for user conveni=
ence.

> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen(a)linux.intel.com]
> Sent: Tuesday, June 09, 2015 2:18 AM
> To: Moore, Robert
> Cc: Zheng, Lv; Wysocki, Rafael J; Len Brown; open list:ACPI COMPONENT
> AR...; open list:ACPI COMPONENT AR...; open list
> Subject: Re: [PATCH] acpi: update struct acpi_table_tpm2
> =

> On Mon, Jun 08, 2015 at 08:52:02PM +0000, Moore, Robert wrote:
> > It looks like there is a change to the TCPA table also.
> =

> Right. I'll update that too.
> =

> I strongly think that the struct acpi_tpm2_control should not be in
> actbl3.h. It is not defined in the TCG ACPI specification. It is defined
> in
> =

> http://www.trustedcomputinggroup.org/resources/pc_client_platform_tpm_prof
> ile_ptp_specification
> =

> FIFO control structures are internal for to the TPM subsystem and so
> should be CRB control structures (and we have already inside tpm_crb.c).
> =

> The structure ended up there probably because it was combined with the
> TPM2 table in that Microsoft specification.
> =

> /Jarkko

--===============3206387465387930667==--

