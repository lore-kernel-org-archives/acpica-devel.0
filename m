Content-Type: multipart/mixed; boundary="===============5594531024892429027=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: power-off delay/hang due to commit 6d25be57 (mainline)
Date: Tue, 11 Aug 2020 16:34:09 +0200
Message-ID: <CAJZ5v0h+n9VCz5=VixVbe_b=ZbTU3D=46stGhE9z7Y7yaUMJzw@mail.gmail.com>
In-Reply-To: 20200811132955.wbt55ns7bu5mxouq@linutronix.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5594531024892429027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2020 at 3:29 PM Sebastian Andrzej Siewior
<bigeasy(a)linutronix.de> wrote:
>
> On 2020-08-11 13:58:39 [+0200], Stephen Berman wrote:
> > him about your workaround of adding 'thermal.tzp=3D300' to the kernel
> > commandline, and he replied that this works for him too.  And it turns
> > out we have similar motherboards: I have a Gigabyte Z390 M Gaming
> > Rev. 1001 board and he has Gigabyte Z390 Designare rev 1.0.
>
> Yes. Based on latest dmesg, the ACPI tables contain code which schedules
> the worker and takes so long. It is possible / likely that his board
> contains the same tables which leads to the same effect. After all those
> two boards are very similar from the naming part :)
> Would you mind to dump the ACPI tables and send them? There might be
> some hints.

Do we have a BZ for this?  It would be useful to open one if not.

> It might be possible that a BIOS update fixes the problem but I would
> prefer very much to fix this in kernel to ensure that such a BIOS does
> not lead to this problem again.

I agree.

It looks like one way to address this issue might be to add a rate
limit for thermal notifications on a given zone.
--===============5594531024892429027==--

