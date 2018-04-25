Content-Type: multipart/mixed; boundary="===============2590987861519642477=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: Re: [Devel] [RFC PATCH] ACPICA: Convert acpi_gbl_hardware lock back
 to a raw_spinlock_t
Date: Wed, 25 Apr 2018 11:11:08 +0200
Message-ID: <6547480.he27n6xWXc@aspire.rjw.lan>
In-Reply-To: 20180425085758.qkud5krf2xg3bfpr@linutronix.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2590987861519642477==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, April 25, 2018 10:57:58 AM CEST Sebastian Andrzej Siewior wro=
te:
> On 2018-04-24 22:55:20 [+0200], Rafael J. Wysocki wrote:
> > > diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/=
aclinux.h
> > > index a0b232703302..38eaa3235210 100644
> > > --- a/include/acpi/platform/aclinux.h
> > > +++ b/include/acpi/platform/aclinux.h
> > > @@ -102,6 +102,7 @@
> > >
> > >  #define acpi_cache_t                        struct kmem_cache
> > >  #define acpi_spinlock                       spinlock_t *
> > > +#define acpi_raw_spinlock              raw_spinlock_t *
> > =

> > I would prefer to redefine acpi_spinlock as raw_spinlock_t and then
> > acpi_os_acquire/release_lock() as
> > raw_spin_lock_irqsave/unlock_irqrestore(), respectively.
> =

> I would rather not convert all current ACPI spinlock_t into
> raw_spinlock_t. Only those which are required to.

I'm actually not 100% sure right now (as a rule things like this come up
when you are not expecting them :-)), but IIRC there are assumptions
regarding at least some of the ACPICA locks as being real spinlocks.

They need to be reviewed from this angle and the code in question is
far from straightforward.

> I don't know if there is anything special about acpi_gbl_hardware_lock
> but we have other raw locks already (like erst_lock or c3_lock).
> I could come up with something like acpi_os_acquire_rawlock() if you
> prefer this instead.

That might work, but the other OSes using ACPICA don't actually have a "raw
spinlock" concept, so this should just fall back to acpi_os_acquire_lock()
if the OS doesn't implement the "raw" thing separately.


--===============2590987861519642477==--

