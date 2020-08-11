Content-Type: multipart/mixed; boundary="===============3146101456763581936=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: power-off delay/hang due to commit 6d25be57 (mainline)
Date: Tue, 11 Aug 2020 16:02:17 +0200
Message-ID: <CAJZ5v0jy08XwTRUwHwjQ-UgHhi=j80q9SW2_ze1J0RiArTRKsw@mail.gmail.com>
In-Reply-To: 20200811102735.yifejbx62ewzpfcs@linutronix.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3146101456763581936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2020 at 12:27 PM Sebastian Andrzej Siewior
<bigeasy(a)linutronix.de> wrote:
>
> On 2020-07-14 17:53:15 [+0200], Rafael J. Wysocki wrote:
> > acpi_evaluate_integer() doesn't show up in the trace, though, AFAICS.
> >
> > > I assumed acpi_ex_opcode_2A_0T_0R() since the other
> > > candidate was acpi_ev_asynch_execute_gpe_method().
> >
> > Which probably is the case.  Specifically
> >
> > acpi_ev_asynch_execute_gpe_method: Evaluate _L66
> >
> > is likely to cause the Notify() to be dispatched.
> =E2=80=A6
> > > Rafael, are you also interested in an ACPI dump?
> >
> > That might help a bit.
> >
> > So what probably happens is that poking at the TZ causes a GPE to
> > trigger and a Notify() to be dispatched which then goes into the
> > workqueue for execution.
> >
> > Now, I'm not sure what happens to those Notify() items, though.  They
> > each should cause a handler (in the thermal driver) to be executed,
> > but does that happen?
>
> Stephen's trace contains a few backtraces, all of them look like this:
>
> | Call Trace:
> |  acpi_ex_opcode_2A_0T_0R+0x93/0xdf
> |  acpi_ds_exec_end_op+0x10d/0x701
> |  acpi_ps_parse_loop+0x7f2/0x8c3
> |  acpi_ps_parse_aml+0x1a5/0x540
> |  acpi_ps_execute_method+0x1fe/0x2ba
> |  acpi_ns_evaluate+0x345/0x4e2
> |  acpi_evaluate_object+0x177/0x39f
> |  acpi_evaluate_integer+0x4f/0x110
> |  acpi_thermal_get_temperature.part.0+0x45/0xc4
> |  thermal_get_temp.cold+0xc/0x2e
> |  thermal_zone_get_temp+0x4c/0x70
> |  thermal_zone_device_update.part.0+0x2a/0x110
> |  acpi_thermal_notify+0xcf/0x140
> |  acpi_ev_notify_dispatch+0x45/0x5a
> |  acpi_os_execute_deferred_notify+0x34/0x60

This is Notify () processing.

The handler is acpi_thermal_notify() which calls acpi_thermal_check()
which is just a wrapper around thermal_zone_device_update() doing
update_temperature() and that calls thermal_zone_get_temp() (among
other things) which invokes the ->get_temp() callback for the target
thermal zone.

In the ACPI thermal driver the ->get_temp callback is
thermal_get_temp() which basically calls
acpi_thermal_get_temperature() and that evaluates _TMP (for the target
thermal zone).

It looks like on the machine in question the _TMP method contains
another Notify () targeting the same thermal zone which gets queued up
via the acpi_ex_opcode_2A_0T_0R() at the top.  Obviously that Notify
() (when it gets executed) will cause acpi_thermal_notify() to be
executed again and so on, ad infinitum unless the Notify () in _TMP is
conditional on something.

> |  process_one_work+0x1d2/0x3a0
> |  worker_thread+0x45/0x3c0
> |  kthread+0xf6/0x130
> |  ret_from_fork+0x35/0x40
>
> so no GPE and it comes the notify callback while parsing the ACPI table.

Right.

> Any ideas? I guess acpi_ex_opcode_2A_0T_0R() uses the workqueue because
> it may sleep and it might be invoked from non-preemptible context.

No, it uses the workqueue because it queues up a Notify () which
always goes through a workqueue (kacpi_notify_wq to be precise) and
basically in order to avoid deadlocks (it runs under locks which may
need to be acquired again to handle the notification).
--===============3146101456763581936==--

