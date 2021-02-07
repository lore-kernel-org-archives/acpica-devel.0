Content-Type: multipart/mixed; boundary="===============0030835519964701190=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v2 6/7] platform: x86: Add intel_skl_int3472 driver
Date: Sun, 07 Feb 2021 13:56:27 +0200
Message-ID: <CAHp75VeF_tZdi8+fMYGtuzMH_jWit4cHy6kHM2OVuBkDA4+=uA@mail.gmail.com>
In-Reply-To: 2f85ec6d-b47e-6d86-02bc-5563cff7576d@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0030835519964701190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 7, 2021 at 1:00 PM Daniel Scally <djrscally(a)gmail.com> wrote:
> On 21/01/2021 00:18, Daniel Scally wrote:
> > On 20/01/2021 12:57, Andy Shevchenko wrote:

...

> > I'm not sure that one's better than the other, to be honest. Either the
> > multi-function device functionality lives in the conventional place, or
> > else _all_ of the int3472 handling code lives together in one module.
> Can we come to a consensus on this? I would rather be in agreement than
> leave it hanging...I do see the argument that it's better not to rebirth
> the MFD driver away from that subsystem, but at the moment I lean
> towards the view that having all the code handling this particular _HID
> in one place is probably preferable, if only to make it easier for
> anyone coming in the future to understand what's happening. That said;
> I'm not particularly precious about it, I'd just like to agree an
> approach so I can move forward with the next version

So, my priorities of rejection (first is higher)
- open-coding MFD subsystem (that said, if you shuffle the code, at
least leave it as an MFD driver)
- moving out from MFD (although I understand intentions)

Summarize, go ahead with your view (leaving it as an MFD driver) and
look forward to what maintainer(s) will say.

-- =

With Best Regards,
Andy Shevchenko
--===============0030835519964701190==--

