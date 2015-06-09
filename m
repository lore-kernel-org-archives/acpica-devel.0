Content-Type: multipart/mixed; boundary="===============2355180885489292781=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH v2] acpi: update ACPI tables to match TCG ACPI
 specification.
Date: Tue, 09 Jun 2015 21:52:43 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F2E17@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 2072894.aM9r7alsAV@vostro.rjw.lan
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2355180885489292781==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Yes, we will do it in ACPICA first.


> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw(a)rjwysocki.net]
> Sent: Tuesday, June 09, 2015 3:16 PM
> To: Jarkko Sakkinen; Moore, Robert
> Cc: peterhuewe(a)gmx.de; Len Brown; Zheng, Lv; open list:ACPI; open
> list:ACPI COMPONENT AR...; open list
> Subject: Re: [PATCH v2] acpi: update ACPI tables to match TCG ACPI
> specification.
> =

> On Tuesday, June 09, 2015 07:25:25 PM Jarkko Sakkinen wrote:
> > Updated struct acpi_table_tpm2 and struct acpi_table_tcpa to match the
> > TCG ACPI specification.
> >
> > v2:
> >
> > - Do not remove struct acpi_tpm2_control
> >
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen(a)linux.intel.com>
> =

> Bob, I'm assuming that we'll be routing this one through upstream ACPICA.
> =

> If that's not the case and I should apply it directly, please let me know.
> =

> =

> > ---
> >  include/acpi/actbl2.h |  5 ++---
> >  include/acpi/actbl3.h | 17 +++++++++++++----
> >  2 files changed, 15 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> > cafdeb5..2f2b8a6 100644
> > --- a/include/acpi/actbl2.h
> > +++ b/include/acpi/actbl2.h
> > @@ -1071,14 +1071,13 @@ enum acpi_spmi_interface_types {
> >   * TCPA - Trusted Computing Platform Alliance table
> >   *        Version 1
> >   *
> > - * Conforms to "TCG PC Specific Implementation Specification",
> > - * Version 1.1, August 18, 2003
> > + * Conforms to "TCG ACPI Specification for Family 1.2 and 2.0" 19
> > + December 2014
> >   *
> >
> > **********************************************************************
> > ********/
> >
> >  struct acpi_table_tcpa {
> >  	struct acpi_table_header header;	/* Common ACPI table header */
> > -	u16 reserved;
> > +	u16 platform_class;	/* 0 for client and 1 for server platforms.
> */
> >  	u32 max_log_length;	/* Maximum length for the event log area */
> >  	u64 log_address;	/* Address of the event log area */
> >  };
> > diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h index
> > 440ca81..8dd625c 100644
> > --- a/include/acpi/actbl3.h
> > +++ b/include/acpi/actbl3.h
> > @@ -688,15 +688,24 @@ enum acpi_rasf_status {
> >   * TPM2 - Trusted Platform Module (TPM) 2.0 Hardware Interface Table
> >   *        Version 3
> >   *
> > - * Conforms to "TPM 2.0 Hardware Interface Table (TPM2)" 29 November
> > 2011
> > + * Conforms to "TCG ACPI Specification for Family 1.2 and 2.0" 19
> > + December 2014
> >   *
> >
> > **********************************************************************
> > ********/
> >
> > +/* How to notify that there is a command available for processing. */
> > +
> > +enum acpi_tpm2_start_method {
> > +	ACPI_TPM2_SM_ACPI =3D 2,
> > +	ACPI_TPM2_SM_CRB =3D 7,
> > +	ACPI_TPM2_SM_CRB_AND_ACPI =3D 8,
> > +};
> > +
> >  struct acpi_table_tpm2 {
> >  	struct acpi_table_header header;	/* Common ACPI table header */
> > -	u32 flags;
> > -	u64 control_address;
> > -	u32 start_method;
> > +	u16 platform_class;	/* 0 for client and 1 for server platforms
> */
> > +	u16 reserved;
> > +	u64 control_address;	/* Physical address of the control area */
> > +	u32 start_method;	/* Method to notify to start processing */
> >  };
> >
> >  /* Control area structure (not part of table, pointed to by
> > control_address) */
> >
> =

> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.

--===============2355180885489292781==--

