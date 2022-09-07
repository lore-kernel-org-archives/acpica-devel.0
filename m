Content-Type: multipart/mixed; boundary="===============7191040020975806666=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPI: Wait for ACPI IRQ to be processed before
 disable GPE
Date: Wed, 07 Sep 2022 22:26:39 +0200
Message-ID: <CAJZ5v0hY05BzG=fL78BzyvxeJDZT+5D_ZeyCALt2+0JUDvHnew@mail.gmail.com>
In-Reply-To: de1cf16c-54cb-316b-3fcb-2520e6bb152f@semihalf.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7191040020975806666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 7, 2022 at 7:31 AM Marek Ma=C5=9Blanka <mm(a)semihalf.com> wrot=
e:
>
> On the wake-up, the ACPI GPE that are marked as a wakeup source are
> turned off. Before turning off, the kernel waits for the currently
> processing IRQ to finish and assumes that this is an ACPI interrupt that
> triggered wake-up. In the case the first interrupt after wake-up is not
> an ACPI interrupt, this might cause the ACPI GPE not to be processed
> because it will be disabled.
>
> The patch makes sure that an ACPI interrupt is processed before
> disabling GPE that are wakeup sources.
>
> This patch fix the issue that is seen on low-end Chromebooks with two
> cores CPU when HPET IRQ is triggered while resuming the device and is
> processed before the ACPI GPE interrupt on the same CPU core.
>
> Signed-off-by: Marek Maslanka <mm(a)semihalf.com>
> ---
>  drivers/acpi/internal.h |  2 ++
>  drivers/acpi/osl.c      | 18 ++++++++++++++++++
>  drivers/acpi/sleep.c    |  6 ++++++
>  include/linux/acpi.h    |  2 ++
>  4 files changed, 28 insertions(+)
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 219c02df9a08..e4df1bf2963b 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -251,6 +251,8 @@ static inline bool force_storage_d3(void)
>  }
>  #endif
>
> +extern bool acpi_resume_gpe_irq_handled;
> +
>  /*----------------------------------------------------------------------=
----
>                                 Device properties
>    ----------------------------------------------------------------------=
---- */
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 3269a888fb7a..ea587ac4c68a 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -42,6 +42,8 @@
>  #define _COMPONENT             ACPI_OS_SERVICES
>  ACPI_MODULE_NAME("osl");
>
> +#define ACPI_WAIT_FOR_RESUME_GPE_IRQ_MS 500

This is a relatively large number.  Doesn't anything smaller work?

> +
>  struct acpi_os_dpc {
>         acpi_osd_exec_callback function;
>         void *context;
> @@ -69,6 +71,8 @@ static struct workqueue_struct *kacpi_hotplug_wq;
>  static bool acpi_os_initialized;
>  unsigned int acpi_sci_irq =3D INVALID_ACPI_IRQ;
>  bool acpi_permanent_mmap =3D false;
> +bool acpi_resume_gpe_irq_handled;
> +static DECLARE_WAIT_QUEUE_HEAD(acpi_irq_after_suspend_wait);
>
>  /*
>   * This list of permanent mappings is for memory that may be accessed fr=
om
> @@ -549,6 +553,10 @@ static irqreturn_t acpi_irq(int irq, void *dev_id)
>         handled =3D (*acpi_irq_handler) (acpi_irq_context);
>
>         if (handled) {
> +               if (acpi_s2idle_wakeup()) {
> +                       acpi_resume_gpe_irq_handled =3D true;
> +                       wake_up(&acpi_irq_after_suspend_wait);
> +               }
>                 acpi_irq_handled++;
>                 return IRQ_HANDLED;
>         } else {
> @@ -1768,3 +1776,13 @@ acpi_status acpi_os_enter_sleep(u8 sleep_state,
>                                                reg_a_value, reg_b_value);
>         return status;
>  }
> +
> +int acpi_wait_for_resume_gpe_irq(void)
> +{
> +       int wait_ms =3D msecs_to_jiffies(ACPI_WAIT_FOR_RESUME_GPE_IRQ_MS);
> +       int timeout =3D wait_event_timeout(acpi_irq_after_suspend_wait,
> +                                        acpi_resume_gpe_irq_handled,
> +                                        wait_ms);
> +       return timeout;

So this will wait for the full timeout if there are no ACPI events to
process, right?

Isn't it a bit excessive?

Moreover, what if there is an ACPI event right after the wait has completed?

> +}
> +EXPORT_SYMBOL(acpi_wait_for_resume_gpe_irq);
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index ad4b2987b3d6..6ddf28067687 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -721,6 +721,7 @@ int acpi_s2idle_prepare(void)
>         acpi_os_wait_events_complete();
>
>         s2idle_wakeup =3D true;
> +       acpi_resume_gpe_irq_handled =3D false;
>         return 0;
>  }
>
> @@ -789,6 +790,7 @@ bool acpi_s2idle_wake(void)
>
>  void acpi_s2idle_restore(void)
>  {
> +       int timeout;
>         /*
>          * Drain pending events before restoring the working-state config=
uration
>          * of GPEs.
> @@ -797,6 +799,10 @@ void acpi_s2idle_restore(void)
>         acpi_ec_flush_work(); /* flush the EC driver's workqueues */
>         acpi_os_wait_events_complete(); /* synchronize Notify handling */
>
> +       timeout =3D acpi_wait_for_resume_gpe_irq();
> +       if (timeout =3D=3D 0)
> +               pr_warn("Failed to wait for ACPI interrupt after resume");

This is perfectly fine, for example if the system is woken up by a
non-ACPI IRQ (eg. the keyboard one).

> +
>         s2idle_wakeup =3D false;
>
>         acpi_enable_all_runtime_gpes();
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index ed4aa395cc49..ef2ab7990f1c 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1475,4 +1475,6 @@ static inline void acpi_device_notify(struct device=
 *dev) { }
>  static inline void acpi_device_notify_remove(struct device *dev) { }
>  #endif
>
> +int acpi_wait_for_resume_gpe_irq(void);
> +
>  #endif /*_LINUX_ACPI_H*/
> --

Overall, I'm not convinced about the approach.

If the goal is to process all of the ACPI wakeup interrupts, this
doesn't meet it.

AFAICS the only way to do that which is not racy is to dispatch every
wakeup GPE in-line (from the ACPICA code) before disabling it in case
it is active at that point.
--===============7191040020975806666==--

