Content-Type: multipart/mixed; boundary="===============3646751174082213479=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v3 3/3] x86/acpi,
 x86/boot: Add multiprocessor wake-up support
Date: Tue, 11 May 2021 12:45:17 +0200
Message-ID: <CAJZ5v0hFfVCm25wUCetOm4YdZKwt5h2jknN9ad1nnpxuR16KkQ@mail.gmail.com>
In-Reply-To: bc14b461-6431-c5ce-7117-854af8454900@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3646751174082213479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, May 10, 2021 at 11:15 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy(a)linux.intel.com> wrote:
>
>
>
> On 5/10/21 10:24 AM, Rafael J. Wysocki wrote:
> > The wakeup function can return an error when it is called for the
> > second time on the same CPU.
>
> To do this, we can only maintain the wakeup status of the CPUs. Can
> you check whether following physid_mask based status maintenance is
> acceptable?

It would work for me except for a couple of nits below.

> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -67,6 +67,7 @@ static u64 acpi_lapic_addr __initdata =3D APIC_DEFAULT_=
PHYS_BASE;
>
>   static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
>   static u64 acpi_mp_wake_mailbox_paddr;
> +static physid_mask_t apic_id_wakemap =3D PHYSID_MASK_NONE;
>
>   #ifdef CONFIG_X86_IO_APIC
>   /*
> @@ -347,6 +348,13 @@ static int acpi_wakeup_cpu(int apicid, unsigned long=
 start_ip)
>
>          acpi_mp_wake_mailbox_init();
>
> +       /* Check if the given CPU (apicid) is already awake */

The reason why is that the wakeup mechanism used here is only usable
once per CPU by the spec, so I would add this information to the
comment.  Maybe something like "According to the ACPI specification
(ACPI 6.4, Section ...), the mailbox-based wakeup mechanism cannot be
used more than once for the same CPU, so avoid doing that."

> +       if (physid_isset(apicid, apic_id_wakemap)) {
> +               pr_err("APIC ID %x is already awake, so failed to wakeup\=
n",
> +                               apicid);

And I would reword the message like this "CPU already awake (APIC ID
%x), skipping wakeup\n".

> +               return -EINVAL;
> +       }
> +
>          if (!acpi_mp_wake_mailbox)

Note, though, that instead of having this additional flag, you may as
well create a mask that is fully populated initially and clear the IDs
of the woken-up CPUs in it.  Then, you'd only need one check here
instead of two.

>                  return -EINVAL;
>
> @@ -374,8 +382,18 @@ static int acpi_wakeup_cpu(int apicid, unsigned long=
 start_ip)
>          while (READ_ONCE(acpi_mp_wake_mailbox->command) && timeout--)
>                  cpu_relax();
>
> -       /* If timedout, return error */
> -       return timeout ? 0 : -EIO;
> +       if (timeout) {
> +               /*
> +                * If the CPU wakeup process is successful, store the
> +                * status in apic_id_wakemap to prevent re-wakeup
> +                * requests.
> +                */
> +               physid_set(apicid, apic_id_wakemap);
> +               return 0;
> +       }
> +
> +       /* If timed out (timeout =3D=3D 0), return error */
> +       return -EIO;
>   }
>
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
--===============3646751174082213479==--

