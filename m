Content-Type: multipart/mixed; boundary="===============2209874050260685265=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 5/6] platform/x86: Add intel_skl_int3472 driver
Date: Tue, 18 May 2021 00:47:50 +0300
Message-ID: <CAHp75VdQ-BYs2MhKA0g+e5No6qP1-BpPBv5L9091yX9c51ZxKw@mail.gmail.com>
In-Reply-To: 0241df24-11cb-fd3b-12a5-f98dea55fac5@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2209874050260685265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, May 18, 2021 at 12:43 AM Daniel Scally <djrscally(a)gmail.com> wrot=
e:
>
> Hi Andy
>
> On 22/02/2021 14:58, Andy Shevchenko wrote
> >> +#include <linux/clk-provider.h>
> >
> > This is definitely not for *.h. (Not all C files needed this)
> >
> >> +#include <linux/gpio/machine.h>
> >
> > Ditto.
> >
> >> +#include <linux/regulator/driver.h>
> >> +#include <linux/regulator/machine.h>
> >
> > Ditto.
>
> Bit more delayed than I wanted to be, but I'm just finishing off the v4
> of this. For these includes, I'm using the actual structs from them
> rather than pointers, so removing these would mean moving the definition
> of struct int3472_discrete_device into one of the source files; you're
> happy with that?

Either way, please send a v4 and we start over from a fresh view.

Thanks!

-- =

With Best Regards,
Andy Shevchenko
--===============2209874050260685265==--

