Content-Type: multipart/mixed; boundary="===============2620524182649412608=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 14/14] ipu3-cio2: Add cio2-bridge to ipu3-cio2
 driver
Date: Mon, 28 Dec 2020 23:47:29 +0000
Message-ID: <CAHp75VeCbmUXagxwfn55tqicJoWqdHjN8_sirBtBbxueCV88Pw@mail.gmail.com>
In-Reply-To: 1b6ffc66-d16e-8ab4-64c8-b92bfac557f0@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2620524182649412608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 29, 2020 at 1:30 AM Daniel Scally <djrscally(a)gmail.com> wrote:
>
> Hi Andy
>
> On 28/12/2020 22:55, Andy Shevchenko wrote:
> > On Mon, Dec 28, 2020 at 10:37:38PM +0000, Daniel Scally wrote:
> >> On 28/12/2020 17:05, Sakari Ailus wrote:
> >>> On Thu, Dec 24, 2020 at 02:54:44PM +0200, Andy Shevchenko wrote:
> > ...
> >
> >>>>> +#include <linux/property.h>
> >>>>> +
> >>>>> +#define CIO2_HID                               "INT343E"
> >>>>> +#define CIO2_NUM_PORTS                         4
> >>> This is already defined in ipu3-cio2.h. Could you include that instea=
d?
> >> Yes; but I'd need to also include media/v4l2-device.h and
> >> media/videobuf2-dma-sg.h (they're included in ipu3-cio2-main.c at the
> >> moment). It didn't seem worth it; but I can move those two includes fr=
om
> >> the .c to the .h and then include ipu3-cio2.h in cio2-bridge.h
> >>
> >> Which do you prefer?

> > I think here should be a
> > compromise variant, split out something like ipu3-cio2-defs.h which can=
 be
> > included in both ipu3-cio2.h and cio2-bridge.h.
>
> And just including all the things that need to be in both files you mean?

Something which may be logically grouped together. It may include
something which cio2-bridge doesn't need, but at least it will be in
one place (for example, if you move one CIO2_PCI_* constant, that
means you better move all, or so, the rest CIO2_PCI_* constants as
well).


-- =

With Best Regards,
Andy Shevchenko
--===============2620524182649412608==--

