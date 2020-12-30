Content-Type: multipart/mixed; boundary="===============6186935708824645347=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 14/14] ipu3-cio2: Add cio2-bridge to ipu3-cio2
 driver
Date: Wed, 30 Dec 2020 20:48:08 +0000
Message-ID: <CAHp75Vf18sse_QQGSy+E2qK-N_B=ky83x36HiNfmUKmya_CS9Q@mail.gmail.com>
In-Reply-To: X+pzKDNWpiQWenHy@pendragon.ideasonboard.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6186935708824645347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 29, 2020 at 2:07 AM Laurent Pinchart
<laurent.pinchart(a)ideasonboard.com> wrote:
> On Tue, Dec 29, 2020 at 01:54:59AM +0200, Andy Shevchenko wrote:
> > On Tue, Dec 29, 2020 at 1:08 AM Laurent Pinchart wrote:

...

> > +#include <linux/videodev2.h>
>
> I think this can be dropped.

I dropped above (I noticed it's included by a half of the headers listed be=
low.

> > +#include <media/media-device.h>
> > +#include <media/media-entity.h>
> > +#include <media/v4l2-async.h>
> > +#include <media/v4l2-dev.h>
> > +#include <media/v4l2-device.h>
> > +#include <media/v4l2-subdev.h>
> > +#include <media/videobuf2-core.h>
> > +#include <media/videobuf2-v4l2.h>

...

> How about grouping all forward declarations at the top ?

Done.

> Otherwise this looks good,
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart(a)ideasonboard.com>

Thanks!
I just sent a formal patch with your tag included.

-- =

With Best Regards,
Andy Shevchenko
--===============6186935708824645347==--

