Content-Type: multipart/mixed; boundary="===============5826635960736535075=="
MIME-Version: 1.0
From: Ross Zwisler <ross.zwisler at linux.intel.com>
Subject: Re: [Devel] [RFC v2 2/5] acpi: HMAT support in
 acpi_parse_entries_array()
Date: Thu, 06 Jul 2017 16:22:00 -0600
Message-ID: <20170706222200.GA31795@linux.intel.com>
In-Reply-To: CAJZ5v0gUA4d+NFqEdsXPVktXf+2AX9MurEQAiCFGxU_eaoYE5A@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5826635960736535075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2017 at 12:13:54AM +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 6, 2017 at 11:52 PM, Ross Zwisler
> <ross.zwisler(a)linux.intel.com> wrote:
> > The current implementation of acpi_parse_entries_array() assumes that e=
ach
> > subtable has a standard ACPI subtable entry of type struct
> > acpi_sutbable_header.  This standard subtable header has a one byte len=
gth
> > followed by a one byte type.
> >
> > The HMAT subtables have to allow for a longer length so they have subta=
ble
> > headers of type struct acpi_hmat_structure which has a 2 byte type and =
a 4
> > byte length.
> >
> > Enhance the subtable parsing in acpi_parse_entries_array() so that it c=
an
> > handle these new HMAT subtables.
> >
> > Signed-off-by: Ross Zwisler <ross.zwisler(a)linux.intel.com>
> > ---
> >  drivers/acpi/numa.c   |  2 +-
> >  drivers/acpi/tables.c | 52 ++++++++++++++++++++++++++++++++++++++++---=
--------
> >  2 files changed, 42 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> > index edb0c79..917f1cc 100644
> > --- a/drivers/acpi/numa.c
> > +++ b/drivers/acpi/numa.c
> > @@ -443,7 +443,7 @@ int __init acpi_numa_init(void)
> >          * So go over all cpu entries in SRAT to get apicid to node map=
ping.
> >          */
> >
> > -       /* SRAT: Static Resource Affinity Table */
> > +       /* SRAT: System Resource Affinity Table */
> >         if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
> >                 struct acpi_subtable_proc srat_proc[3];
> >
> =

> This change is unrelated to the rest of the patch.
> =

> Maybe send it separately?

Sure, will do.

> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> > index ff42539..7979171 100644
> > --- a/drivers/acpi/tables.c
> > +++ b/drivers/acpi/tables.c
> > @@ -218,6 +218,33 @@ void acpi_table_print_madt_entry(struct acpi_subta=
ble_header *header)
> >         }
> >  }
> >
> > +static unsigned long __init
> > +acpi_get_entry_type(char *id, void *entry)
> > +{
> > +       if (!strncmp(id, ACPI_SIG_HMAT, 4))
> > +               return ((struct acpi_hmat_structure *)entry)->type;
> > +       else
> > +               return ((struct acpi_subtable_header *)entry)->type;
> > +}
> =

> I slightly prefer to use ? : in similar situations.

Hmm..that becomes rather long, and seems complex for the already hard to re=
ad
?: operator?  Let's see, this:

	if (!strncmp(id, ACPI_SIG_HMAT, 4))
		return ((struct acpi_hmat_structure *)entry)->type;
	else
		return ((struct acpi_subtable_header *)entry)->type;

becomes

	return strncmp(id, ACPI_SIG_HMAT, 4)) ?
		((struct acpi_subtable_header *)entry)->type :
		((struct acpi_hmat_structure *)entry)->type;

Hmm...we only save one line, and I personally find that a lot harder to rea=
d,
but that being said if you feel strongly about it I'll make the change.

--===============5826635960736535075==--

