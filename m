Content-Type: multipart/mixed; boundary="===============8933233314686050209=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [RFC v2 2/5] acpi: HMAT support in
 acpi_parse_entries_array()
Date: Fri, 07 Jul 2017 00:36:16 +0200
Message-ID: <CAJZ5v0g-j5MsDnOOR2KhPp-dtQLro0XGcPHneEvLV-Z1F4LB+g@mail.gmail.com>
In-Reply-To: 20170706222200.GA31795@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8933233314686050209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 7, 2017 at 12:22 AM, Ross Zwisler
<ross.zwisler(a)linux.intel.com> wrote:
> On Fri, Jul 07, 2017 at 12:13:54AM +0200, Rafael J. Wysocki wrote:
>> On Thu, Jul 6, 2017 at 11:52 PM, Ross Zwisler
>> <ross.zwisler(a)linux.intel.com> wrote:
>> > The current implementation of acpi_parse_entries_array() assumes that =
each
>> > subtable has a standard ACPI subtable entry of type struct
>> > acpi_sutbable_header.  This standard subtable header has a one byte le=
ngth
>> > followed by a one byte type.
>> >
>> > The HMAT subtables have to allow for a longer length so they have subt=
able
>> > headers of type struct acpi_hmat_structure which has a 2 byte type and=
 a 4
>> > byte length.
>> >
>> > Enhance the subtable parsing in acpi_parse_entries_array() so that it =
can
>> > handle these new HMAT subtables.
>> >
>> > Signed-off-by: Ross Zwisler <ross.zwisler(a)linux.intel.com>
>> > ---
>> >  drivers/acpi/numa.c   |  2 +-
>> >  drivers/acpi/tables.c | 52 ++++++++++++++++++++++++++++++++++++++++--=
---------
>> >  2 files changed, 42 insertions(+), 12 deletions(-)

[cut]

>> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> > index ff42539..7979171 100644
>> > --- a/drivers/acpi/tables.c
>> > +++ b/drivers/acpi/tables.c
>> > @@ -218,6 +218,33 @@ void acpi_table_print_madt_entry(struct acpi_subt=
able_header *header)
>> >         }
>> >  }
>> >
>> > +static unsigned long __init
>> > +acpi_get_entry_type(char *id, void *entry)
>> > +{
>> > +       if (!strncmp(id, ACPI_SIG_HMAT, 4))
>> > +               return ((struct acpi_hmat_structure *)entry)->type;
>> > +       else
>> > +               return ((struct acpi_subtable_header *)entry)->type;
>> > +}
>>
>> I slightly prefer to use ? : in similar situations.
>
> Hmm..that becomes rather long, and seems complex for the already hard to =
read
> ?: operator?  Let's see, this:
>
>         if (!strncmp(id, ACPI_SIG_HMAT, 4))
>                 return ((struct acpi_hmat_structure *)entry)->type;
>         else
>                 return ((struct acpi_subtable_header *)entry)->type;
>
> becomes
>
>         return strncmp(id, ACPI_SIG_HMAT, 4)) ?
>                 ((struct acpi_subtable_header *)entry)->type :
>                 ((struct acpi_hmat_structure *)entry)->type;
>
> Hmm...we only save one line, and I personally find that a lot harder to r=
ead,
> but that being said if you feel strongly about it I'll make the change.

Well, I said "slightly". :-)

Thanks,
Rafael

--===============8933233314686050209==--

