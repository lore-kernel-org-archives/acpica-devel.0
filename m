Content-Type: multipart/mixed; boundary="===============1999969784376935424=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [RFC PATCH] ACPICA: Convert acpi_gbl_hardware lock back
 to a raw_spinlock_t
Date: Tue, 24 Apr 2018 22:55:20 +0200
Message-ID: <CAJZ5v0gdZcVQv8dDge9a9TffcDkU8isRa0=hjNPRcKrsB6=UMQ@mail.gmail.com>
In-Reply-To: 20180424160257.1925-1-bigeasy@linutronix.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1999969784376935424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 6:02 PM, Sebastian Andrzej Siewior
<bigeasy(a)linutronix.de> wrote:
> From: Steven Rostedt <rostedt(a)goodmis.org>
>
> We hit the following bug with -RT:
>
> |BUG: scheduling while atomic: swapper/7/0/0x00000002
> |Pid: 0, comm: swapper/7 Not tainted 3.6.11-rt28.19.el6rt.x86_64.debug #1
> |Call Trace:
> |  rt_spin_lock+0x16/0x40
> |  __schedule_bug+0x67/0x90
> |  __schedule+0x793/0x7a0
> |  acpi_os_acquire_lock+0x1f/0x23
> |  acpi_write_bit_register+0x33/0xb0
> |  rt_spin_lock_slowlock+0xe5/0x2f0
> |  acpi_idle_enter_bm+0x8a/0x28e
> =E2=80=A6
> As the acpi code disables interrupts in acpi_idle_enter_bm, and calls
> code that grabs the acpi lock, it causes issues as the lock is currently
> in RT a sleeping lock.
>
> The lock was converted from a raw to a sleeping lock due to some
> previous issues, and tests that showed it didn't seem to matter.
> Unfortunately, it did matter for one of our boxes.
>
> This patch converts the lock back to a raw lock. I've run this code on a
> few of my own machines, one being my laptop that uses the acpi quite
> extensively. I've been able to suspend and resume without issues.
>
> [ tglx: Made the change exclusive for acpi_gbl_hardware_lock ]
>
> Signed-off-by: Steven Rostedt <rostedt(a)goodmis.org>
> Cc: John Kacur <jkacur(a)gmail.com>
> Cc: Clark Williams <clark(a)redhat.com>
> Link: http://lkml.kernel.org/r/1360765565.23152.5.camel(a)gandalf.local.h=
ome
>
> Signed-off-by: Thomas Gleixner <tglx(a)linutronix.de>
> [bigeasy: shorten the backtrace]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy(a)linutronix.de>
> ---
>  drivers/acpi/acpica/acglobal.h  |  2 +-
>  drivers/acpi/acpica/hwregs.c    |  4 ++--
>  drivers/acpi/acpica/hwxface.c   |  4 ++--
>  drivers/acpi/acpica/utmutex.c   |  4 ++--
>  include/acpi/platform/aclinux.h | 14 ++++++++++++++
>  5 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acgloba=
l.h
> index 0bc550072a21..1e6204518496 100644
> --- a/drivers/acpi/acpica/acglobal.h
> +++ b/drivers/acpi/acpica/acglobal.h
> @@ -82,7 +82,7 @@ ACPI_GLOBAL(u8, acpi_gbl_global_lock_pending);
>   * interrupt level
>   */
>  ACPI_GLOBAL(acpi_spinlock, acpi_gbl_gpe_lock); /* For GPE data structs a=
nd registers */
> -ACPI_GLOBAL(acpi_spinlock, acpi_gbl_hardware_lock);    /* For ACPI H/W e=
xcept GPE registers */
> +ACPI_GLOBAL(acpi_raw_spinlock, acpi_gbl_hardware_lock);        /* For AC=
PI H/W except GPE registers */
>  ACPI_GLOBAL(acpi_spinlock, acpi_gbl_reference_count_lock);
>
>  /* Mutex for _OSI support */
> diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
> index 27a86ad55b58..4c792f3e6135 100644
> --- a/drivers/acpi/acpica/hwregs.c
> +++ b/drivers/acpi/acpica/hwregs.c
> @@ -390,14 +390,14 @@ acpi_status acpi_hw_clear_acpi_status(void)
>                           ACPI_BITMASK_ALL_FIXED_STATUS,
>                           ACPI_FORMAT_UINT64(acpi_gbl_xpm1a_status.addres=
s)));
>
> -       lock_flags =3D acpi_os_acquire_lock(acpi_gbl_hardware_lock);
> +       raw_spin_lock_irqsave(acpi_gbl_hardware_lock, lock_flags);
>
>         /* Clear the fixed events in PM1 A/B */
>
>         status =3D acpi_hw_register_write(ACPI_REGISTER_PM1_STATUS,
>                                         ACPI_BITMASK_ALL_FIXED_STATUS);
>
> -       acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags);
> +       raw_spin_unlock_irqrestore(acpi_gbl_hardware_lock, lock_flags);
>
>         if (ACPI_FAILURE(status)) {
>                 goto exit;
> diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
> index 5d1396870bd0..8efeae8f3a8d 100644
> --- a/drivers/acpi/acpica/hwxface.c
> +++ b/drivers/acpi/acpica/hwxface.c
> @@ -227,7 +227,7 @@ acpi_status acpi_write_bit_register(u32 register_id, =
u32 value)
>                 return_ACPI_STATUS(AE_BAD_PARAMETER);
>         }
>
> -       lock_flags =3D acpi_os_acquire_lock(acpi_gbl_hardware_lock);
> +       raw_spin_lock_irqsave(acpi_gbl_hardware_lock, lock_flags);
>
>         /*
>          * At this point, we know that the parent register is one of the
> @@ -288,7 +288,7 @@ acpi_status acpi_write_bit_register(u32 register_id, =
u32 value)
>
>  unlock_and_exit:
>
> -       acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags);
> +       raw_spin_unlock_irqrestore(acpi_gbl_hardware_lock, lock_flags);
>         return_ACPI_STATUS(status);
>  }
>
> diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
> index d2d93e388f40..2e465e6a0ab6 100644
> --- a/drivers/acpi/acpica/utmutex.c
> +++ b/drivers/acpi/acpica/utmutex.c
> @@ -52,7 +52,7 @@ acpi_status acpi_ut_mutex_initialize(void)
>                 return_ACPI_STATUS (status);
>         }
>
> -       status =3D acpi_os_create_lock (&acpi_gbl_hardware_lock);
> +       status =3D acpi_os_create_raw_lock(&acpi_gbl_hardware_lock);
>         if (ACPI_FAILURE (status)) {
>                 return_ACPI_STATUS (status);
>         }
> @@ -109,7 +109,7 @@ void acpi_ut_mutex_terminate(void)
>         /* Delete the spinlocks */
>
>         acpi_os_delete_lock(acpi_gbl_gpe_lock);
> -       acpi_os_delete_lock(acpi_gbl_hardware_lock);
> +       acpi_os_delete_raw_lock(acpi_gbl_hardware_lock);
>         acpi_os_delete_lock(acpi_gbl_reference_count_lock);
>
>         /* Delete the reader/writer lock */
> diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/acli=
nux.h
> index a0b232703302..38eaa3235210 100644
> --- a/include/acpi/platform/aclinux.h
> +++ b/include/acpi/platform/aclinux.h
> @@ -102,6 +102,7 @@
>
>  #define acpi_cache_t                        struct kmem_cache
>  #define acpi_spinlock                       spinlock_t *
> +#define acpi_raw_spinlock              raw_spinlock_t *

I would prefer to redefine acpi_spinlock as raw_spinlock_t and then
acpi_os_acquire/release_lock() as
raw_spin_lock_irqsave/unlock_irqrestore(), respectively.

>  #define acpi_cpu_flags                      unsigned long
>
>  /* Use native linux version of acpi_os_allocate_zeroed */
> @@ -120,6 +121,19 @@
>  #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_thread_id
>  #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_create_lock
>
> +#define acpi_os_create_raw_lock(__handle)                      \
> +({                                                             \
> +       raw_spinlock_t *lock =3D ACPI_ALLOCATE(sizeof(*lock));    \
> +                                                               \
> +       if (lock) {                                             \
> +               *(__handle) =3D lock;                             \
> +               raw_spin_lock_init(*(__handle));                \
> +       }                                                       \
> +       lock ? AE_OK : AE_NO_MEMORY;                            \
> +})
> +
> +#define acpi_os_delete_raw_lock(__handle)      kfree(__handle)
> +
>  /*
>   * OSL interfaces used by debugger/disassembler
>   */
> --

--===============1999969784376935424==--

