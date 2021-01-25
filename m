Content-Type: multipart/mixed; boundary="===============3920091673158232439=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: power-off delay/hang due to commit 6d25be57 (mainline)
Date: Mon, 25 Jan 2021 17:25:11 +0100
Message-ID: <CAJZ5v0ihGfW=8PRXZgLVMfwOCVJQQh=Kc+htqbYhBFvxgfYuZQ@mail.gmail.com>
In-Reply-To: 87wnw278ds.fsf@gmx.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3920091673158232439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 24, 2021 at 2:49 PM Stephen Berman <stephen.berman(a)gmx.net> w=
rote:
>
> On Mon, 04 Jan 2021 16:38:43 +0100 Stephen Berman <stephen.berman(a)gmx.n=
et> wrote:
>
> > On Thu, 31 Dec 2020 21:46:11 +0100 "Rafael J. Wysocki" <rjw(a)rjwysocki=
.net> wrote:
> >
> >> ATM, I'm tempted to do something like the patch below (with the ration=
ale
> >> that it shouldn't be necessary to read the temperature right after upd=
ating
> >> the trip points if polling is in use, because the next update through =
polling
> >> will cause it to be read anyway and it will trigger trip point actions=
 as
> >> needed).
> >>
> >> Stephen, can you give it a go, please?
> >
> > On Sat, 02 Jan 2021 12:03:17 +0100 "Rafael J. Wysocki" <rjw(a)rjwysocki=
.net> wrote:
> >
> >> There is one more way to address this, probably better: instead of che=
cking the
> >> temperature right away in acpi_thermal_notify(), queue that on
> >> acpi_thermal_pm_queue
> >> and so only if another thermal check is not pending.
> >>
> >> This way there will be at most one temperature check coming from
> >> acpi_thermal_notify() queued up at any time which should prevent the
> >> build-up of work items from taking place.
> >>
> >> So something like this:
> >
> > Thanks for the patches.  I'll try them as soon as I can.
>
> FTR, since this is the thread I started for this bug, I've confirmed in
> https://lore.kernel.org/lkml/87y2gi78sg.fsf(a)gmx.net/T/#t that the latest
> patch fixes the bug.

OK, thanks!

The patch has been applied as 5.11-rc material.
--===============3920091673158232439==--

