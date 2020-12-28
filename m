Content-Type: multipart/mixed; boundary="===============8414934072970835306=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 14/14] ipu3-cio2: Add cio2-bridge to ipu3-cio2
 driver
Date: Mon, 28 Dec 2020 22:54:51 +0000
Message-ID: <20201228225544.GH4077@smile.fi.intel.com>
In-Reply-To: 2d37df3d-f04c-6679-6e27-6c7f82e9b158@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8414934072970835306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 28, 2020 at 10:37:38PM +0000, Daniel Scally wrote:
> On 28/12/2020 17:05, Sakari Ailus wrote:
> > On Thu, Dec 24, 2020 at 02:54:44PM +0200, Andy Shevchenko wrote:

...

> >>> +#include <linux/property.h>
> >>> +
> >>> +#define CIO2_HID                               "INT343E"
> >>> +#define CIO2_NUM_PORTS                         4
> > =

> > This is already defined in ipu3-cio2.h. Could you include that instead?
> =

> Yes; but I'd need to also include media/v4l2-device.h and
> media/videobuf2-dma-sg.h (they're included in ipu3-cio2-main.c at the
> moment). It didn't seem worth it; but I can move those two includes from
> the .c to the .h and then include ipu3-cio2.h in cio2-bridge.h
> =

> Which do you prefer?

Actually ipu3-cio2.h misses a lot of inclusions (like mutex.h which I
immediately noticed when scrolled over data types). I think here should be a
compromise variant, split out something like ipu3-cio2-defs.h which can be
included in both ipu3-cio2.h and cio2-bridge.h.

And cio2-bridge.h needs more inclusions like types.h.

-- =

With Best Regards,
Andy Shevchenko


--===============8414934072970835306==--

