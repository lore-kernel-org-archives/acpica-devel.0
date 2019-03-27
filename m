Content-Type: multipart/mixed; boundary="===============1138257005707015770=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH] drivers/acpi: Clear status of an event before
 enabling it
Date: Wed, 27 Mar 2019 13:24:46 +0100
Message-ID: <CAJZ5v0hxNA_KHjcqSL4XPpQpB1M4UuWJcYOknex=NOGavoooHA@mail.gmail.com>
In-Reply-To: CAEGmHFEqhh_xYaTXsVHqSgNW-1Ao6-mtk0BPhgu3-8ua6cCZ-Q@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1138257005707015770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2019 at 3:16 AM Furquan Shaikh <furquan(a)google.com> wrote:
>
> On Wed, Mar 20, 2019 at 5:11 PM Rafael J. Wysocki <rafael(a)kernel.org> w=
rote:
> >
> > On Wed, Mar 20, 2019 at 11:34 PM Furquan Shaikh <furquan(a)google.com> =
wrote:
> > >
> > > Commit 18996f2db918 ("ACPICA: Events: Stop unconditionally
> > > clearing ACPI IRQs during suspend/resume") was added to stop clearing
> > > of event status bits unconditionally on suspend and resume paths. This
> > > was done because of an issue
> > > reported (https://bugzilla.kernel.org/show_bug.cgi?id=3D196249) where
> > > lid status stays closed even on resume (which happens because event
> > > status bits are cleared unconditionally on resume). Though this change
> > > fixed the issue on suspend path, it introduced regressions on several
> > > resume paths.
> > >
> > > First regression was reported and fixed on S5 path by the following
> > > change: commit fa85015c0d95 ("ACPICA: Clear status of all events when
> > > entering S5"). Next regression was reported and fixed on all legacy
> > > sleep paths by the commit f317c7dc12b7 ("ACPICA: Clear status of all
> > > events when entering sleep states"). However, regression still exists
> > > on S0ix sleep path since it does not follow the legacy sleep path.
> >
> > What exactly is failing?
>
> Here is the failure scenario:
>
> 1. Consider the case of trackpad which acts as a wake source.
> 2. Since the pad is configured for SCI, GPE_STS gets set for that pad
> during normal interrupts as well (i.e. during probe at boot or when
> using the trackpad)

I don't quite understand this.

Is the same GPE used for signaling trackpad events in the system
working state and for wakeup?

> 3. Now, when the platform decides to enter S0ix, it enables the wake
> on trackpad by enabling appropriate GPE_EN bit.
> 4. So, at this point, we are in a situation where GPE_EN as well as
> GPE_STS are set.
> 5. Now, if the platform enters S0ix, having GPE_STS set will result in
> unwanted wakes because of stale events.
>
> This is similar to what was fixed on the legacy sleep path:
> https://lkml.org/lkml/2018/8/12/42. However, as S0ix does not follow
> the legacy sleep path, clearing of GPE status does not happen. Thus,
> it is causing failures to go into S0ix on our platforms because of the
> stale wake events as described above.
>
> >
> > > In case of S0ix, events are enabled as part of device suspend path. If
> > > status bits for the events are set when they are enabled, it could
> > > result in premature wake from S0ix. This change ensures that status is
> > > cleared for any event that is being enabled so that any stale events
> > > are cleared out.
> > >
> > > Signed-off-by: Furquan Shaikh <furquan(a)google.com>
> > > ---
> > >  drivers/acpi/acpica/evgpe.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
> > > index 62d3aa74277b4..61455ab42fc87 100644
> > > --- a/drivers/acpi/acpica/evgpe.c
> > > +++ b/drivers/acpi/acpica/evgpe.c
> > > @@ -81,8 +81,12 @@ acpi_status acpi_ev_enable_gpe(struct acpi_gpe_eve=
nt_info *gpe_event_info)
> > >
> > >         ACPI_FUNCTION_TRACE(ev_enable_gpe);
> > >
> > > -       /* Enable the requested GPE */
> > > +       /* Clear the GPE (of stale events) */
> > > +       status =3D acpi_hw_clear_gpe(gpe_event_info);
> > > +       if (ACPI_FAILURE(status))
> > > +               return_ACPI_STATUS(status);
> >
> > Well, this may cause events to be missed.
>
> Won't those be stale events?

They need not be stale, the device may have already detected some
activity before the GPE is enabled.

> i.e. any event that has occurred before GPE is enabled should be ignored.

But this is a good point.

>
> >
> > >
> > > +       /* Enable the requested GPE */
> > >         status =3D acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABL=
E);
> > >         return_ACPI_STATUS(status);
> > >  }
> > > --

--===============1138257005707015770==--

