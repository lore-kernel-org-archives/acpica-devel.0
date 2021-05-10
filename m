Content-Type: multipart/mixed; boundary="===============0809185804614166360=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v3 3/3] x86/acpi,
 x86/boot: Add multiprocessor wake-up support
Date: Mon, 10 May 2021 19:24:38 +0200
Message-ID: <CAJZ5v0iFsBWwXhqtLbTMicBSFme0HCvg+2xgtMgpkFMupk_Rkw@mail.gmail.com>
In-Reply-To: 20210510172237.GU4032392@tassilo.jf.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0809185804614166360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, May 10, 2021 at 7:22 PM Andi Kleen <ak(a)linux.intel.com> wrote:
>
> On Mon, May 10, 2021 at 10:10:24AM -0700, Kuppuswamy, Sathyanarayanan wro=
te:
> >
> >
> > On 5/10/21 9:55 AM, Rafael J. Wysocki wrote:
> > > I'm not sure how my comment regarding the fact that for a given CPU
> > > this function is only usable once has been addressed.
> > >
> > > While it may not be a practical concern in the use case that you are
> > > after (TDX), this is a generic mechanism and it needs to cover other
> > > possible usage scenarios.
> >
> > For the same CPU, if we try to use mailbox again, firmware will not
> > respond to it. So the command will timeout and return error.
>
> Right because the firmware code doesn't run anymore.
>
> The only possibility would be for Linux to put back some code that spins
> and waits again, but that would be quite pointless and wasteful.

The wakeup function can return an error when it is called for the
second time on the same CPU.
--===============0809185804614166360==--

