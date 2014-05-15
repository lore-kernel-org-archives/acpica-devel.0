Content-Type: multipart/mixed; boundary="===============7736760937483296483=="
MIME-Version: 1.0
From: David E. Box <david.e.box at linux.intel.com>
Subject: Re: [Devel] Clarification request about AcpiDbgLevel and
 AcpiGbl_EnableAmlDebugObject
Date: Thu, 15 May 2014 14:54:20 -0700
Message-ID: <20140515215420.GA1506@linux.intel.com>
In-Reply-To: CABC13nE9gguL8ZWUskE8Wn1s-F=+tV7nxOxFtNP1xPVuA23=Ew@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7736760937483296483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2014 at 09:21:33PM +0200, Sascha Wildner wrote:
> On Thu, May 15, 2014 at 3:08 AM, David E. Box
> <david.e.box(a)linux.intel.com> wrote:
> > On Wed, May 14, 2014 at 10:53:30PM +0200, Sascha Wildner wrote:
> >> So my question is: How should the host OS properly handle this? I saw =
that
> >> FreeBSD for example initializes AcpiDbgLevel to 0 (when their ACPI_DEB=
UG
> >> switch isn't set) but the reference manual doesn't mention that anythi=
ng
> >> other than AcpiGbl_EnableAmlDebugObject being FALSE is necessary.
> >
> > How should the host OS handle what exactly? I think you misunderstand w=
hat Debug
> > Object is. In ASL you can use the Store operator to print debug message=
s like
> > this:
> =

> David,
> =

> sorry for not being clear enough the first time.
> =

> After a recent ACPICA upgrade in DragonFly BSD we've had some reports
> of (mostly temperature related) Debug Object output like for example
> http://lists.dragonflybsd.org/pipermail/users/2014-February/109309.html,
> which I was investigating.

I'm not aware of a change we made recently that would have turned on Debug
Output, but maybe Lv knows. A BIOS change would be the culprit here. Howeve=
r if
you can clearly bisect the issue down to a difference in the version of ACP=
ICA
and nothing else, we'd like to know about.

> I checked the reference and I
> (mis)understood it as saying that with AcpiGbl_EnableAmlDebugObject
> being FALSE alone, Debug Object output would not be printed, which
> confused me, so I asked etc.

I think we should explicitly state that it can still be enabled by
AcpiDbgLevel in the spec to clear up any confusion.

> But I understand now that if I wanted to disable them, I would need to
> modify AcpiDbgLevel, too. I'll study the ASL first, though.

Good luck with that.

-- Dave Box

--===============7736760937483296483==--

