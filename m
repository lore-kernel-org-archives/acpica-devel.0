Content-Type: multipart/mixed; boundary="===============6371276915606350189=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: power-off delay/hang due to commit 6d25be57 (mainline)
Date: Tue, 14 Jul 2020 17:53:15 +0200
Message-ID: <CAJZ5v0iogereapmhcFi=iXHsjnzmC26mewUSTY3+5O3ei5kfDQ@mail.gmail.com>
In-Reply-To: 20200714141135.47adndrsdgpiqfy4@linutronix.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6371276915606350189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2020 at 4:11 PM Sebastian Andrzej Siewior
<bigeasy(a)linutronix.de> wrote:
>
> On 2020-07-14 15:54:57 [+0200], Rafael J. Wysocki wrote:
> > On Tue, Jul 14, 2020 at 3:44 PM Sebastian Andrzej Siewior
> > <bigeasy(a)linutronix.de> wrote:>
> > > On 2020-06-24 23:49:52 [+0200], Stephen Berman wrote:
> > >
> > > Let me summarize the thread here:
> > >
> > > On Stephen's system, ACPI informs the thermal zone driver to poll the
> > > temperature every second and the driver does so.
> > > The driver queries the temperature by invoking acpi_evaluate_integer()
> > > which invokes (at some point) acpi_ev_queue_notify_request().
> >
> > Well, I don't quite see how acpi_ev_queue_notify_request() can be
> > invoked from the acpi_evaluate_integer() code path.
> >
> > Do you have a call trace showing that?
>
> So the trace in
>      https://lore.kernel.org/linux-acpi/87o8pjh1i0.fsf(a)gmx.net/
>
> shows the pattern and we nailed it down that it comes from
> thermal_get_temp().

acpi_evaluate_integer() doesn't show up in the trace, though, AFAICS.

> I assumed acpi_ex_opcode_2A_0T_0R() since the other
> candidate was acpi_ev_asynch_execute_gpe_method().

Which probably is the case.  Specifically

acpi_ev_asynch_execute_gpe_method: Evaluate _L66

is likely to cause the Notify() to be dispatched.

> Stephen, the patch attached adds a WARN_ON() statement which will
> produce a stack trace (4 or so). Could please run 'dmesg' after a while
> and send it back. There should be a
>     "WARNING in drivers/acpi/acpica/evmisc.c"
>
> statement or something along the lines.
>
> Rafael, are you also interested in an ACPI dump?

That might help a bit.

So what probably happens is that poking at the TZ causes a GPE to
trigger and a Notify() to be dispatched which then goes into the
workqueue for execution.

Now, I'm not sure what happens to those Notify() items, though.  They
each should cause a handler (in the thermal driver) to be executed,
but does that happen?
--===============6371276915606350189==--

