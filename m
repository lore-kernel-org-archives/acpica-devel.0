Content-Type: multipart/mixed; boundary="===============0617782562773290272=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: power-off delay/hang due to commit 6d25be57 (mainline)
Date: Tue, 14 Jul 2020 15:54:57 +0200
Message-ID: <CAJZ5v0hZSUkEMCszDADGWk-v0xNEiDE45B3CHLi05BX6rPfm6g@mail.gmail.com>
In-Reply-To: 20200714134410.3odqfvjq6rndjjf6@linutronix.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0617782562773290272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2020 at 3:44 PM Sebastian Andrzej Siewior
<bigeasy(a)linutronix.de> wrote:>
> On 2020-06-24 23:49:52 [+0200], Stephen Berman wrote:
>
> Let me summarize the thread here:
>
> On Stephen's system, ACPI informs the thermal zone driver to poll the
> temperature every second and the driver does so.
> The driver queries the temperature by invoking acpi_evaluate_integer()
> which invokes (at some point) acpi_ev_queue_notify_request().

Well, I don't quite see how acpi_ev_queue_notify_request() can be
invoked from the acpi_evaluate_integer() code path.

Do you have a call trace showing that?

> This then invokes acpi_os_execute_deferred() via
>     queue_work_on(, kacpi_notify_wq, )
>
> acpi_os_execute_deferred() invokes acpi_ev_notify_dispatch() and this is
> no longer synchronised with the initial acpi_evaluate_integer() request.

That indeed would be the case, but I first need to understand what's
going on with the acpi_evaluate_integer() causing a Notify () to be
queued up.

Cheers!
--===============0617782562773290272==--

