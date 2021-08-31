Content-Type: multipart/mixed; boundary="===============7203499450237231554=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v2] x86/acpi: Don't add CPUs that are not online
 capable
Date: Tue, 31 Aug 2021 20:51:26 +0200
Message-ID: <CAJZ5v0ibUsBCoaz=BRpe42TuiVvSy68wj4VKs+H3Q6uKxCycJQ@mail.gmail.com>
In-Reply-To: b116a84b-c099-5bf4-6c25-f62cea856f45@amd.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7203499450237231554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sorry for the delay.

On Tue, Aug 17, 2021 at 8:41 PM Limonciello, Mario
<mario.limonciello(a)amd.com> wrote:
>
> On 8/16/2021 09:04, Rafael J. Wysocki wrote:
> > On Fri, Aug 13, 2021 at 6:19 PM Mario Limonciello
> > <mario.limonciello(a)amd.com> wrote:
> >>
> >> A number of systems are showing "hotplug capable" CPUs when they
> >> are not really hotpluggable.  This is because the MADT has extra
> >> CPU entries to support different CPUs that may be inserted into
> >> the socket with different numbers of cores.
> >>
> >> Starting with ACPI 6.3 the spec has an Online Capable bit in the
> >> MADT used to determine whether or not a CPU is hotplug capable
> >> when the enabled bit is not set.
> >>
> >> Link: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fuefi.org%2Fhtmlspecs%2FACPI_Spec_6_4_html%2F05_ACPI_Software_Programmin=
g_Model%2FACPI_Software_Programming_Model.html%3F%23local-apic-flags&amp;da=
ta=3D04%7C01%7Cmario.limonciello%40amd.com%7Ce6a384bf25274f88b49508d960bee4=
0a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637647195281368169%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;sdata=3D3MWJ5NcRVJ7TP4tJH6uQRbqfZKSqe5RHjGxGbQEP13E%3D&a=
mp;reserved=3D0
> >> Signed-off-by: Mario Limonciello <mario.limonciello(a)amd.com>
> >> ---
> >>   arch/x86/kernel/acpi/boot.c | 10 ++++++++++
> >>   include/acpi/actbl2.h       |  1 +
> >>   2 files changed, 11 insertions(+)
> >>
> >> Changes from v1->v2:
> >>   * Check the revision field in MADT to determine if it matches the
> >>     bump from ACPI 6.3 as suggested by Hanjun Guo
> >>   * Update description
> >>
> >> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> >> index e55e0c1fad8c..bfa69a5c9c0b 100644
> >> --- a/arch/x86/kernel/acpi/boot.c
> >> +++ b/arch/x86/kernel/acpi/boot.c
> >> @@ -53,6 +53,8 @@ int acpi_ioapic;
> >>   int acpi_strict;
> >>   int acpi_disable_cmcff;
> >>
> >> +bool acpi_support_online_capable;
> >
> > Missing static?
>
> Ack, thanks.
>
> >
> >> +
> >>   /* ACPI SCI override configuration */
> >>   u8 acpi_sci_flags __initdata;
> >>   u32 acpi_sci_override_gsi __initdata =3D INVALID_ACPI_IRQ;
> >> @@ -138,6 +140,8 @@ static int __init acpi_parse_madt(struct acpi_tabl=
e_header *table)
> >>
> >>                  pr_debug("Local APIC address 0x%08x\n", madt->address=
);
> >>          }
> >> +       if (madt->header.revision >=3D 5)
> >> +               acpi_support_online_capable =3D true;
> >>
> >>          default_acpi_madt_oem_check(madt->header.oem_id,
> >>                                      madt->header.oem_table_id);
> >> @@ -239,6 +243,12 @@ acpi_parse_lapic(union acpi_subtable_headers * he=
ader, const unsigned long end)
> >>          if (processor->id =3D=3D 0xff)
> >>                  return 0;
> >>
> >> +       /* don't register processors that can not be onlined */
> >> +       if (acpi_support_online_capable &&
> >> +           !(processor->lapic_flags & ACPI_MADT_ENABLED) &&
> >> +           !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
> >> +               return 0;
> >> +
> >>          /*
> >>           * We need to register disabled CPU as well to permit
> >>           * counting disabled CPUs. This allows us to size
> >> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> >> index 2069ac38a4e2..fae45e383987 100644
> >> --- a/include/acpi/actbl2.h
> >> +++ b/include/acpi/actbl2.h
> >
> > The one below is an ACPICA change and I'd prefer it to be integrated
> > via the upstream ACPICA.
> >
> > Could you prepare an ACPICA pull request for just the bit below and
> > send it via GitHub?
>
> Sure thing.
> http://github.com/acpica/acpica/pull/708/
>
> They said they would take it later this month or next month.
>
> Given that, how do you want to proceed with the first part of this?
>
> Should I send a 2 patch series that will add the MADT bit to actbl2.h in
> advance of their next release, or should I wait to resubmit until after
> their next release and you've brought it into your tree?

If you want this to go into 5.15, I would suggest going for the first optio=
n.

Knowing that the ACPICA patch is going to reach upstream at one point,
I can put it into Linux in advance.

> >
> >> @@ -808,6 +808,7 @@ struct acpi_madt_multiproc_wakeup_mailbox {
> >>   /* MADT Local APIC flags */
> >>
> >>   #define ACPI_MADT_ENABLED           (1)        /* 00: Processor is u=
sable if set */
> >> +#define ACPI_MADT_ONLINE_CAPABLE    (2)        /* 01: System HW suppo=
rts enabling processor at runtime */
> >>
> >>   /* MADT MPS INTI flags (inti_flags) */
> >>
> >> --
>
--===============7203499450237231554==--

