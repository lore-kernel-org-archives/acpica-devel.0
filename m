Content-Type: multipart/mixed; boundary="===============6866607661969488164=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: Re: [Devel] [PATCH 2/2] ACPICA: Convert acpi_gbl_hardware lock back
 to an acpi_raw_spinlock
Date: Sun, 13 May 2018 10:28:56 +0200
Message-ID: <7377329.ZPTMpYNSux@aspire.rjw.lan>
In-Reply-To: 20180425142827.22202-2-bigeasy@linutronix.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6866607661969488164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, April 25, 2018 4:28:27 PM CEST Sebastian Andrzej Siewior wrot=
e:
> From: Steven Rostedt <rostedt(a)goodmis.org>
> =

> We hit the following bug with -RT:
> =

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
> =

> The lock was converted from a raw to a sleeping lock due to some
> previous issues, and tests that showed it didn't seem to matter.
> Unfortunately, it did matter for one of our boxes.
> =

> This patch converts the lock back to a raw lock. I've run this code on a
> few of my own machines, one being my laptop that uses the acpi quite
> extensively. I've been able to suspend and resume without issues.
> =

> [ tglx: Made the change exclusive for acpi_gbl_hardware_lock ]
> =

> Signed-off-by: Steven Rostedt <rostedt(a)goodmis.org>
> Cc: John Kacur <jkacur(a)gmail.com>
> Cc: Clark Williams <clark(a)redhat.com>
> Link: http://lkml.kernel.org/r/1360765565.23152.5.camel(a)gandalf.local.h=
ome
> Signed-off-by: Thomas Gleixner <tglx(a)linutronix.de>
> [bigeasy: shorten the backtrace, use the type acpi_raw_spinlock incl.
>  accessor]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy(a)linutronix.de>

Applied along with the [1/2], thanks!


--===============6866607661969488164==--

