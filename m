Content-Type: multipart/mixed; boundary="===============0442202544182555277=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 13/14] include: media: v4l2-fwnode: Include
 v4l2_fwnode_bus_type
Date: Thu, 24 Dec 2020 14:32:21 +0200
Message-ID: <CAHp75VdSyNv3M9T0_nQKsZfO-nxd5A3Z6o0mrRKrpHm282wsjQ@mail.gmail.com>
In-Reply-To: 20201224010907.263125-14-djrscally@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0442202544182555277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 24, 2020 at 3:13 AM Daniel Scally <djrscally(a)gmail.com> wrote:
>
> V4L2 fwnode bus types are enumerated in v4l2-fwnode.c, meaning they aren't
> available to the rest of the kernel. Move the enum to the corresponding
> header so that I can use the label to refer to those values.

Reviewed-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>
One nitpick below, though.

> Suggested-by: Andy Shevchenko <andriy.shevchenko(a)linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally(a)gmail.com>
> ---
> Changes in v3
>         - Patch introduced
>
>  drivers/media/v4l2-core/v4l2-fwnode.c | 11 -----------
>  include/media/v4l2-fwnode.h           | 22 ++++++++++++++++++++++
>  2 files changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-c=
ore/v4l2-fwnode.c
> index 5353e37eb950..c1c2b3060532 100644
> --- a/drivers/media/v4l2-core/v4l2-fwnode.c
> +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
> @@ -28,17 +28,6 @@
>  #include <media/v4l2-fwnode.h>
>  #include <media/v4l2-subdev.h>
>
> -enum v4l2_fwnode_bus_type {
> -       V4L2_FWNODE_BUS_TYPE_GUESS =3D 0,
> -       V4L2_FWNODE_BUS_TYPE_CSI2_CPHY,
> -       V4L2_FWNODE_BUS_TYPE_CSI1,
> -       V4L2_FWNODE_BUS_TYPE_CCP2,
> -       V4L2_FWNODE_BUS_TYPE_CSI2_DPHY,
> -       V4L2_FWNODE_BUS_TYPE_PARALLEL,
> -       V4L2_FWNODE_BUS_TYPE_BT656,
> -       NR_OF_V4L2_FWNODE_BUS_TYPE,
> -};
> -
>  static const struct v4l2_fwnode_bus_conv {
>         enum v4l2_fwnode_bus_type fwnode_bus_type;
>         enum v4l2_mbus_type mbus_type;
> diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
> index 4365430eea6f..d306a28bda96 100644
> --- a/include/media/v4l2-fwnode.h
> +++ b/include/media/v4l2-fwnode.h
> @@ -213,6 +213,28 @@ struct v4l2_fwnode_connector {
>         } connector;
>  };
>
> +/**
> + * enum v4l2_fwnode_bus_type - Video bus types defined by firmware prope=
rties
> + * @V4L2_FWNODE_BUS_TYPE_GUESS: Default value if no bus-type fwnode prop=
erty
> + * @V4L2_FWNODE_BUS_TYPE_CSI2_CPHY: MIPI CSI-2 bus, C-PHY physical layer
> + * @V4L2_FWNODE_BUS_TYPE_CSI1: MIPI CSI-1 bus
> + * @V4L2_FWNODE_BUS_TYPE_CCP2: SMIA Compact Camera Port 2 bus
> + * @V4L2_FWNODE_BUS_TYPE_CSI2_DPHY: MIPI CSI-2 bus, D-PHY physical layer
> + * @V4L2_FWNODE_BUS_TYPE_PARALLEL: Camera Parallel Interface bus
> + * @V4L2_FWNODE_BUS_TYPE_BT656: BT656 video format bus-type
> + * @NR_OF_V4L2_FWNODE_BUS_TYPE: Number of bus-types
> + */
> +enum v4l2_fwnode_bus_type {
> +       V4L2_FWNODE_BUS_TYPE_GUESS =3D 0,
> +       V4L2_FWNODE_BUS_TYPE_CSI2_CPHY,
> +       V4L2_FWNODE_BUS_TYPE_CSI1,
> +       V4L2_FWNODE_BUS_TYPE_CCP2,
> +       V4L2_FWNODE_BUS_TYPE_CSI2_DPHY,
> +       V4L2_FWNODE_BUS_TYPE_PARALLEL,
> +       V4L2_FWNODE_BUS_TYPE_BT656,

> +       NR_OF_V4L2_FWNODE_BUS_TYPE,

I see that comma is in the original line, but I think it's a good time
to remove it from this line. Since it's a terminator line we might
prevent potential issues during review (by a different diff look) and
at compile time (if anything comes after it).

> +};
> +
>  /**
>   * v4l2_fwnode_endpoint_parse() - parse all fwnode node properties
>   * @fwnode: pointer to the endpoint's fwnode handle
> --
> 2.25.1
>


-- =

With Best Regards,
Andy Shevchenko
--===============0442202544182555277==--

