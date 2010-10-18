Content-Type: multipart/mixed; boundary="===============4133509946478231027=="
MIME-Version: 1.0
From: Stuart_Hayes at Dell.com
Subject: Re: [Devel] [PATCH] ACPICA: Do not hang at mutex forever if BIOS
 tries to release global lock
Date: Mon, 18 Oct 2010 10:37:15 -0500
Message-ID: <07E32F241046DA418A0381C1225BFC011A42BCE7BF@AUSX7MCPS301.AMER.DELL.COM>
In-Reply-To: alpine.LFD.2.00.1010152222150.2971@localhost.localdomain
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4133509946478231027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> =

> > There seem to be chipsets which can get this wrong (especially after
> a kexec
> > boot on Linux).
> =

> <recording>
> =

> As kexec is fundamentally unreliable by design,
> why should reliable software be modified for its beneift?
> =

> </recording>
> =


The problem isn't just with kexec.  The lock is acquired by acpi_ev_global_=
lock_handler() when a global lock release SCI occurs, even when the OS does=
n't want it, which sets the "owned" bit on the first SCI and then the "pend=
ing" bit on the second SCI.  This prevents the global lock from working cor=
rectly, even though we're only seeing the OS hang waiting for the semaphore=
 because of this when a kexec boot is attempted.


--===============4133509946478231027==--

