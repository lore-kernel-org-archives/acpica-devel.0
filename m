Content-Type: multipart/mixed; boundary="===============2643796050352613176=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH] drivers/acpi: Clear status of an event before
 enabling it
Date: Thu, 28 Mar 2019 09:57:18 +0100
Message-ID: <CAJZ5v0jPJYM6n0OWBM17d3MF5h5B+an+LSRiXTHqboXZuXkcvw@mail.gmail.com>
In-Reply-To: CAEGmHFHaFk6v=vcciU3QNaQfLriWSJtQ5QUjciY+O8dLh3DhJA@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2643796050352613176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2019 at 1:46 AM Furquan Shaikh <furquan(a)google.com> wrote:
>
> On Wed, Mar 27, 2019 at 5:24 AM Rafael J. Wysocki <rafael(a)kernel.org> w=
rote:
> >
> > On Thu, Mar 21, 2019 at 3:16 AM Furquan Shaikh <furquan(a)google.com> w=
rote:
> > >
> > > On Wed, Mar 20, 2019 at 5:11 PM Rafael J. Wysocki <rafael(a)kernel.or=
g> wrote:
> > > >
> > > > On Wed, Mar 20, 2019 at 11:34 PM Furquan Shaikh <furquan(a)google.c=
om> wrote:
> > > > >
> > > > > Commit 18996f2db918 ("ACPICA: Events: Stop unconditionally
> > > > > clearing ACPI IRQs during suspend/resume") was added to stop clea=
ring
> > > > > of event status bits unconditionally on suspend and resume paths.=
 This
> > > > > was done because of an issue
> > > > > reported (https://bugzilla.kernel.org/show_bug.cgi?id=3D196249) w=
here
> > > > > lid status stays closed even on resume (which happens because eve=
nt
> > > > > status bits are cleared unconditionally on resume). Though this c=
hange
> > > > > fixed the issue on suspend path, it introduced regressions on sev=
eral
> > > > > resume paths.
> > > > >
> > > > > First regression was reported and fixed on S5 path by the followi=
ng
> > > > > change: commit fa85015c0d95 ("ACPICA: Clear status of all events =
when
> > > > > entering S5"). Next regression was reported and fixed on all lega=
cy
> > > > > sleep paths by the commit f317c7dc12b7 ("ACPICA: Clear status of =
all
> > > > > events when entering sleep states"). However, regression still ex=
ists
> > > > > on S0ix sleep path since it does not follow the legacy sleep path.
> > > >
> > > > What exactly is failing?
> > >
> > > Here is the failure scenario:
> > >
> > > 1. Consider the case of trackpad which acts as a wake source.
> > > 2. Since the pad is configured for SCI, GPE_STS gets set for that pad
> > > during normal interrupts as well (i.e. during probe at boot or when
> > > using the trackpad)
> >
> > I don't quite understand this.
> >
> > Is the same GPE used for signaling trackpad events in the system
> > working state and for wakeup?
>
> Yes. The same pad is being configured for interrupts (i.e. routed to
> APIC) during S0 as well as configured for GPE (i.e. routed for SCI) to
> cause wakes when in S0ix/S3. This pad is externally connected to
> trackpad interrupt line.

And the way the system is wired up causes the GPE status to be set
when it is enabled, I suppose?

So effectively, you need to disable the active-state IRQ, then clear
the GPE status and enable it for wakeup.

OK, I'll queue up the patch (and talk to the upstream ACPICA people
about taking it in there).

Thanks!

--===============2643796050352613176==--

