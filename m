Content-Type: multipart/mixed; boundary="===============8223118532051526199=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v3 3/3] x86/acpi,
 x86/boot: Add multiprocessor wake-up support
Date: Mon, 10 May 2021 18:55:14 +0200
Message-ID: <CAJZ5v0gsqyXSr+Kw603333PZ=gnsBizNhyLAcu588OChEHT=AQ@mail.gmail.com>
In-Reply-To: 97e14cdc-ea98-18b8-0c89-db52440a7716@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8223118532051526199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, May 10, 2021 at 6:33 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy(a)linux.intel.com> wrote:
>
> Hi Rafael/Thomas,
>
> On 4/25/21 7:39 PM, Kuppuswamy Sathyanarayanan wrote:
> > As per ACPI specification r6.4, sec 5.2.12.19, a new sub
> > structure =E2=80=93 multiprocessor wake-up structure - is added to the
> > ACPI Multiple APIC Description Table (MADT) to describe the
> > information of the mailbox. If a platform firmware produces the
> > multiprocessor wake-up structure, then OS may use this new
> > mailbox-based mechanism to wake up the APs.
> >
> > Add ACPI MADT wake table parsing support for x86 platform and if
> > MADT wake table is present, update apic->wakeup_secondary_cpu with
> > new API which uses MADT wake mailbox to wake-up CPU.
>
> Gentle ping. Any comments on this patch? I think I have addressed
> the concerns raised by you in previous version.
>
> >
> > Co-developed-by: Sean Christopherson <sean.j.christopherson(a)intel.com>
> > Signed-off-by: Sean Christopherson <sean.j.christopherson(a)intel.com>
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy(a=
)linux.intel.com>
> > Reviewed-by: Andi Kleen <ak(a)linux.intel.com>
> > ---
> >   arch/x86/include/asm/apic.h |  3 ++
> >   arch/x86/kernel/acpi/boot.c | 79 +++++++++++++++++++++++++++++++++++++
> >   arch/x86/kernel/apic/apic.c |  8 ++++
> >   3 files changed, 90 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> > index 412b51e059c8..3e94e1f402ea 100644
> > --- a/arch/x86/include/asm/apic.h
> > +++ b/arch/x86/include/asm/apic.h
> > @@ -487,6 +487,9 @@ static inline unsigned int read_apic_id(void)
> >       return apic->get_apic_id(reg);
> >   }
> >
> > +typedef int (*wakeup_cpu_handler)(int apicid, unsigned long start_eip);
> > +extern void acpi_wake_cpu_handler_update(wakeup_cpu_handler handler);
> > +
> >   extern int default_apic_id_valid(u32 apicid);
> >   extern int default_acpi_madt_oem_check(char *, char *);
> >   extern void default_setup_apic_routing(void);
> > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > index 14cd3186dc77..fce2aa7d718f 100644
> > --- a/arch/x86/kernel/acpi/boot.c
> > +++ b/arch/x86/kernel/acpi/boot.c
> > @@ -65,6 +65,9 @@ int acpi_fix_pin2_polarity __initdata;
> >   static u64 acpi_lapic_addr __initdata =3D APIC_DEFAULT_PHYS_BASE;
> >   #endif
> >
> > +static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> > +static u64 acpi_mp_wake_mailbox_paddr;
> > +
> >   #ifdef CONFIG_X86_IO_APIC
> >   /*
> >    * Locks related to IOAPIC hotplug
> > @@ -329,6 +332,52 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers *=
 header, const unsigned long e
> >       return 0;
> >   }
> >
> > +static void acpi_mp_wake_mailbox_init(void)
> > +{
> > +     if (acpi_mp_wake_mailbox)
> > +             return;
> > +
> > +     acpi_mp_wake_mailbox =3D memremap(acpi_mp_wake_mailbox_paddr,
> > +                     sizeof(*acpi_mp_wake_mailbox), MEMREMAP_WB);
> > +}
> > +
> > +static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
> > +{
> > +     u8 timeout =3D 0xFF;
> > +
> > +     acpi_mp_wake_mailbox_init();
> > +
> > +     if (!acpi_mp_wake_mailbox)
> > +             return -EINVAL;
> > +
> > +     /*
> > +      * Mailbox memory is shared between firmware and OS. Firmware will
> > +      * listen on mailbox command address, and once it receives the wa=
keup
> > +      * command, CPU associated with the given apicid will be booted. =
So,
> > +      * the value of apic_id and wakeup_vector has to be set before up=
dating
> > +      * the wakeup command. So use WRITE_ONCE to let the compiler know=
 about
> > +      * it and preserve the order of writes.
> > +      */
> > +     WRITE_ONCE(acpi_mp_wake_mailbox->apic_id, apicid);
> > +     WRITE_ONCE(acpi_mp_wake_mailbox->wakeup_vector, start_ip);
> > +     WRITE_ONCE(acpi_mp_wake_mailbox->command, ACPI_MP_WAKE_COMMAND_WA=
KEUP);
> > +
> > +     /*
> > +      * After writing wakeup command, wait for maximum timeout of 0xFF
> > +      * for firmware to reset the command address back zero to indicate
> > +      * the successful reception of command.
> > +      * NOTE: 255 as timeout value is decided based on our experiments.
> > +      *
> > +      * XXX: Change the timeout once ACPI specification comes up with
> > +      *      standard maximum timeout value.
> > +      */
> > +     while (READ_ONCE(acpi_mp_wake_mailbox->command) && timeout--)
> > +             cpu_relax();
> > +
> > +     /* If timedout, return error */
> > +     return timeout ? 0 : -EIO;

I'm not sure how my comment regarding the fact that for a given CPU
this function is only usable once has been addressed.

While it may not be a practical concern in the use case that you are
after (TDX), this is a generic mechanism and it needs to cover other
possible usage scenarios.

> > +}
> > +
> >   #endif                              /*CONFIG_X86_LOCAL_APIC */
> >
> >   #ifdef CONFIG_X86_IO_APIC
> > @@ -1086,6 +1135,30 @@ static int __init acpi_parse_madt_lapic_entries(=
void)
> >       }
> >       return 0;
> >   }
> > +
> > +static int __init acpi_parse_mp_wake(union acpi_subtable_headers *head=
er,
> > +                                   const unsigned long end)
> > +{
> > +     struct acpi_madt_multiproc_wakeup *mp_wake;
> > +
> > +     if (acpi_mp_wake_mailbox)
> > +             return -EINVAL;
> > +
> > +     if (!IS_ENABLED(CONFIG_SMP))
> > +             return -ENODEV;
> > +
> > +     mp_wake =3D (struct acpi_madt_multiproc_wakeup *) header;
> > +     if (BAD_MADT_ENTRY(mp_wake, end))
> > +             return -EINVAL;
> > +
> > +     acpi_table_print_madt_entry(&header->common);
> > +
> > +     acpi_mp_wake_mailbox_paddr =3D mp_wake->base_address;
> > +
> > +     acpi_wake_cpu_handler_update(acpi_wakeup_cpu);
> > +
> > +     return 0;
> > +}
> >   #endif                              /* CONFIG_X86_LOCAL_APIC */
> >
> >   #ifdef      CONFIG_X86_IO_APIC
> > @@ -1284,6 +1357,12 @@ static void __init acpi_process_madt(void)
> >
> >                               smp_found_config =3D 1;
> >                       }
> > +
> > +                     /*
> > +                      * Parse MADT MP Wake entry.
> > +                      */
> > +                     acpi_table_parse_madt(ACPI_MADT_TYPE_MULTIPROC_WA=
KEUP,
> > +                                           acpi_parse_mp_wake, 1);
> >               }
> >               if (error =3D=3D -EINVAL) {
> >                       /*
> > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> > index 4f26700f314d..f1b90a4b89e8 100644
> > --- a/arch/x86/kernel/apic/apic.c
> > +++ b/arch/x86/kernel/apic/apic.c
> > @@ -2554,6 +2554,14 @@ u32 x86_msi_msg_get_destid(struct msi_msg *msg, =
bool extid)
> >   }
> >   EXPORT_SYMBOL_GPL(x86_msi_msg_get_destid);
> >
> > +void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
> > +{
> > +     struct apic **drv;
> > +
> > +     for (drv =3D __apicdrivers; drv < __apicdrivers_end; drv++)
> > +             (*drv)->wakeup_secondary_cpu =3D handler;
> > +}
> > +
> >   /*
> >    * Override the generic EOI implementation with an optimized version.
> >    * Only called during early boot when only one CPU is active and with
> >
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
--===============8223118532051526199==--

