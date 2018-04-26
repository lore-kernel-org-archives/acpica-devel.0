Content-Type: multipart/mixed; boundary="===============5360933341382269657=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH 1/2] ACPICA: provide abstraction for raw_spinlock_t
Date: Thu, 26 Apr 2018 08:44:36 +0200
Message-ID: <CAJZ5v0hQsbXsH9+b+vuQ5QTqkT8RDPJMiRh_tji4k_AhN7sS6Q@mail.gmail.com>
In-Reply-To: 20180425142827.22202-1-bigeasy@linutronix.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5360933341382269657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 4:28 PM, Sebastian Andrzej Siewior
<bigeasy(a)linutronix.de> wrote:
> Provide a new lock type acpi_raw_spinlock which is implemented as
> raw_spinlock_t on Linux. This type should be used in code which covers
> small areas of code and disables interrupts only for short time even on
> a realtime OS.
> There is a fallback to spinlock_t if an OS does not provide an
> implementation for acpi_raw_spinlock.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy(a)linutronix.de>

Thanks for the update!

I think I can apply this series, but first I need to discuss sorting
it out upstream with Bob and Erik.

> ---
>  include/acpi/acpiosxf.h           | 21 +++++++++++++++++++++
>  include/acpi/actypes.h            |  4 ++++
>  include/acpi/platform/aclinux.h   |  5 +++++
>  include/acpi/platform/aclinuxex.h | 30 ++++++++++++++++++++++++++++++
>  4 files changed, 60 insertions(+)
>
> diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
> index 540d35f06ad6..eb1f21af7556 100644
> --- a/include/acpi/acpiosxf.h
> +++ b/include/acpi/acpiosxf.h
> @@ -97,6 +97,27 @@ acpi_cpu_flags acpi_os_acquire_lock(acpi_spinlock hand=
le);
>  void acpi_os_release_lock(acpi_spinlock handle, acpi_cpu_flags flags);
>  #endif
>
> +/*
> + * RAW spinlock primitives. If the OS does not provide them, fallback to
> + * spinlock primitives
> + */
> +#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_create_raw_lock
> +# define acpi_os_create_raw_lock(out_handle)   acpi_os_create_lock(out_h=
andle)
> +#endif
> +
> +#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_delete_raw_lock
> +# define acpi_os_delete_raw_lock(handle)       acpi_os_delete_lock(handl=
e)
> +#endif
> +
> +#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_acquire_raw_lock
> +# define acpi_os_acquire_raw_lock(handle)      acpi_os_acquire_lock(hand=
le)
> +#endif
> +
> +#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_release_raw_lock
> +# define acpi_os_release_raw_lock(handle, flags)       \
> +       acpi_os_release_lock(handle, flags)
> +#endif
> +
>  /*
>   * Semaphore primitives
>   */
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index 1c530f95dc34..2b1bafa197c0 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -245,6 +245,10 @@ typedef u64 acpi_physical_address;
>  #define acpi_spinlock                   void *
>  #endif
>
> +#ifndef acpi_raw_spinlock
> +#define acpi_raw_spinlock              acpi_spinlock
> +#endif
> +
>  #ifndef acpi_semaphore
>  #define acpi_semaphore                  void *
>  #endif
> diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/acli=
nux.h
> index a0b232703302..7451b3bca83a 100644
> --- a/include/acpi/platform/aclinux.h
> +++ b/include/acpi/platform/aclinux.h
> @@ -102,6 +102,7 @@
>
>  #define acpi_cache_t                        struct kmem_cache
>  #define acpi_spinlock                       spinlock_t *
> +#define acpi_raw_spinlock                   raw_spinlock_t *
>  #define acpi_cpu_flags                      unsigned long
>
>  /* Use native linux version of acpi_os_allocate_zeroed */
> @@ -119,6 +120,10 @@
>  #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_acquire_object
>  #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_thread_id
>  #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_create_lock
> +#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_create_raw_lock
> +#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_delete_raw_lock
> +#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_acquire_raw_lock
> +#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_release_raw_lock
>
>  /*
>   * OSL interfaces used by debugger/disassembler
> diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/ac=
linuxex.h
> index 7e81475fe034..d754a1b12721 100644
> --- a/include/acpi/platform/aclinuxex.h
> +++ b/include/acpi/platform/aclinuxex.h
> @@ -90,6 +90,36 @@ static inline acpi_thread_id acpi_os_get_thread_id(voi=
d)
>                 lock ? AE_OK : AE_NO_MEMORY; \
>         })
>
> +
> +#define acpi_os_create_raw_lock(__handle) \
> +       ({ \
> +               raw_spinlock_t *lock =3D ACPI_ALLOCATE(sizeof(*lock)); \
> +               if (lock) { \
> +                       *(__handle) =3D lock; \
> +                       raw_spin_lock_init(*(__handle)); \
> +               } \
> +               lock ? AE_OK : AE_NO_MEMORY; \
> +       })
> +
> +static inline acpi_cpu_flags acpi_os_acquire_raw_lock(acpi_raw_spinlock =
lockp)
> +{
> +       acpi_cpu_flags flags;
> +
> +       raw_spin_lock_irqsave(lockp, flags);
> +       return flags;
> +}
> +
> +static inline void acpi_os_release_raw_lock(acpi_raw_spinlock lockp,
> +                                           acpi_cpu_flags flags)
> +{
> +       raw_spin_unlock_irqrestore(lockp, flags);
> +}
> +
> +static inline void acpi_os_delete_raw_lock(acpi_raw_spinlock handle)
> +{
> +       ACPI_FREE(handle);
> +}
> +
>  static inline u8 acpi_os_readable(void *pointer, acpi_size length)
>  {
>         return TRUE;
> --
> 2.17.0
>

--===============5360933341382269657==--

