Content-Type: multipart/mixed; boundary="===============6028900483322071408=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] acpi: update struct acpi_table_tpm2
Date: Tue, 09 Jun 2015 16:16:14 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F2CA6@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 20150609151919.GA4453@jsakkine-mobl1
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6028900483322071408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Looking at the TCG ACPI Specification today, it looks like there are major =
changes to the TCPA table. There is a whole bunch of new stuff after the Lo=
g Area Start Address.

Perhaps I missed or didn't get part of your proposed change.


> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen(a)linux.intel.com]
> Sent: Tuesday, June 09, 2015 8:19 AM
> To: Moore, Robert
> Cc: Zheng, Lv; Wysocki, Rafael J; Len Brown; open list:ACPI COMPONENT
> AR...; open list:ACPI COMPONENT AR...; open list
> Subject: Re: [PATCH] acpi: update struct acpi_table_tpm2
> =

> On Tue, Jun 09, 2015 at 02:21:12PM +0000, Moore, Robert wrote:
> > ACPICA usually defines any "related" data structures, just for user
> > convenience.
> =

> If you want to keep it, it's fine for me but we still probably use the
> internal structure for it in tpm_crb driver (as tpm_tis uses internal
> structure for CRB).
> =

> Do other updates look fine? I'm looking into migrating to tpm_crb driver
> to use actbl3.h.
> =

> /Jarkko
> =

> >
> > > -----Original Message-----
> > > From: Jarkko Sakkinen [mailto:jarkko.sakkinen(a)linux.intel.com]
> > > Sent: Tuesday, June 09, 2015 2:18 AM
> > > To: Moore, Robert
> > > Cc: Zheng, Lv; Wysocki, Rafael J; Len Brown; open list:ACPI
> > > COMPONENT AR...; open list:ACPI COMPONENT AR...; open list
> > > Subject: Re: [PATCH] acpi: update struct acpi_table_tpm2
> > >
> > > On Mon, Jun 08, 2015 at 08:52:02PM +0000, Moore, Robert wrote:
> > > > It looks like there is a change to the TCPA table also.
> > >
> > > Right. I'll update that too.
> > >
> > > I strongly think that the struct acpi_tpm2_control should not be in
> > > actbl3.h. It is not defined in the TCG ACPI specification. It is
> > > defined in
> > >
> > > http://www.trustedcomputinggroup.org/resources/pc_client_platform_tp
> > > m_prof
> > > ile_ptp_specification
> > >
> > > FIFO control structures are internal for to the TPM subsystem and so
> > > should be CRB control structures (and we have already inside
> tpm_crb.c).
> > >
> > > The structure ended up there probably because it was combined with
> > > the
> > > TPM2 table in that Microsoft specification.
> > >
> > > /Jarkko

--===============6028900483322071408==--

