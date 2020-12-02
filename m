Content-Type: multipart/mixed; boundary="===============5881622683406389558=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: power-off delay/hang due to commit 6d25be57 (mainline)
Date: Wed, 02 Dec 2020 20:13:38 +0100
Message-ID: <CAJZ5v0j7i86twMS+csYMaetUkvqjof4FD2GRNoZ_AN=SBF7F1w@mail.gmail.com>
In-Reply-To: CAJZ5v0j86pX_a4bSLP=sobLoYhfQYV9dWL8HHf2941kXgND79g@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5881622683406389558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 2, 2020 at 7:31 PM Rafael J. Wysocki <rafael(a)kernel.org> wrot=
e:
>
> On Wed, Dec 2, 2020 at 7:03 PM Sebastian Andrzej Siewior
> <bigeasy(a)linutronix.de> wrote:
> >
> > On 2020-10-26 18:20:59 [+0100], To Rafael J. Wysocki wrote:
> > > > > > > Done as Bug 208877.
> > > > > Rafael, do you have any suggestions?
> > > >
> > > > I've lost track of this sorry.
> > > >
> > > > I have ideas, let me get back to this next week.
> > >
> > > :)
> >
> > Rafael, any update? If you outline an idea or so then I may be able to
> > form a patch out of it. Otherwise I have no idea how to fix this - other
> > than telling the driver to not poll in smaller intervals than
> > 30secs.
>
> The idea, roughly speaking, is to limit the number of outstanding work
> items in the queue (basically, if there's a notification occurring
> before the previous one can be handled, there is no need to queue up
> another work item for it).

That's easier said than done, though, because of the way the work item
queue-up is hooked up into the ACPICA code.
--===============5881622683406389558==--

