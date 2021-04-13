Content-Type: multipart/mixed; boundary="===============8714076085921027602=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v2] ipu3-cio2: Parse sensor orientation and
 rotation
Date: Tue, 13 Apr 2021 18:15:23 +0300
Message-ID: <CAHp75VfkWAZ0rZQw_UGKdzdEZ9era-rizRJXfn+ZfQPkTDZRmQ@mail.gmail.com>
In-Reply-To: 20210413063435.18111-1-me@fabwu.ch
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8714076085921027602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 13, 2021 at 12:02 PM Fabian W=C3=BCthrich <me(a)fabwu.ch> wrote:
>
> The sensor orientation is read from the _PLC ACPI buffer and converted
> to a v4l2 format.
>
> See https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.p=
df
> page 351 for a definition of the Panel property.

Better to refer to the version, chapter number and title, like]

  ACPI specification v6.3 defines that in the chapter 6.1.8 "_PLD
(Physical Location of Device)"

> The sensor rotation is read from the SSDB ACPI buffer and converted into
> degrees.

After splitting to two patches, take my
Reviewed-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>

> Signed-off-by: Fabian W=C3=BCthrich <me(a)fabwu.ch>
> Reviewed-by: Daniel Scally <djrscally(a)gmail.com>
> ---
> Changes in v2:
>   - Move ACPI PLD constants to ACPI headers
>   - Fix dev_properties size
>
>  drivers/media/pci/intel/ipu3/cio2-bridge.c | 60 ++++++++++++++++++++--
>  drivers/media/pci/intel/ipu3/cio2-bridge.h |  9 +++-
>  include/acpi/acbuffer.h                    |  9 ++++
>  3 files changed, 73 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/p=
ci/intel/ipu3/cio2-bridge.c
> index c2199042d3db..926141e9a516 100644
> --- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
> +++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
> @@ -29,6 +29,7 @@ static const struct cio2_sensor_config cio2_supported_s=
ensors[] =3D {
>  static const struct cio2_property_names prop_names =3D {
>         .clock_frequency =3D "clock-frequency",
>         .rotation =3D "rotation",
> +       .orientation =3D "orientation",
>         .bus_type =3D "bus-type",
>         .data_lanes =3D "data-lanes",
>         .remote_endpoint =3D "remote-endpoint",
> @@ -72,11 +73,51 @@ static int cio2_bridge_read_acpi_buffer(struct acpi_d=
evice *adev, char *id,
>         return ret;
>  }
>
> +static u32 cio2_bridge_parse_rotation(struct cio2_sensor *sensor)
> +{
> +       switch (sensor->ssdb.degree) {
> +       case CIO2_SENSOR_ROTATION_NORMAL:
> +               return 0;
> +       case CIO2_SENSOR_ROTATION_INVERTED:
> +               return 180;
> +       default:
> +               dev_warn(&sensor->adev->dev,
> +                        "Unknown rotation %d. Assume 0 degree rotation\n=
",
> +                        sensor->ssdb.degree);
> +               return 0;
> +       }
> +}
> +
> +static enum v4l2_fwnode_orientation cio2_bridge_parse_orientation(struct=
 cio2_sensor *sensor)
> +{
> +       switch (sensor->pld->panel) {
> +       case ACPI_PLD_PANEL_FRONT:
> +               return V4L2_FWNODE_ORIENTATION_FRONT;
> +       case ACPI_PLD_PANEL_BACK:
> +               return V4L2_FWNODE_ORIENTATION_BACK;
> +       case ACPI_PLD_PANEL_TOP:
> +       case ACPI_PLD_PANEL_LEFT:
> +       case ACPI_PLD_PANEL_RIGHT:
> +       case ACPI_PLD_PANEL_UNKNOWN:
> +               return V4L2_FWNODE_ORIENTATION_EXTERNAL;
> +       default:
> +               dev_warn(&sensor->adev->dev, "Unknown _PLD panel value %d=
\n",
> +                        sensor->pld->panel);
> +               return V4L2_FWNODE_ORIENTATION_EXTERNAL;
> +       }
> +}
> +
>  static void cio2_bridge_create_fwnode_properties(
>         struct cio2_sensor *sensor,
>         struct cio2_bridge *bridge,
>         const struct cio2_sensor_config *cfg)
>  {
> +       u32 rotation;
> +       enum v4l2_fwnode_orientation orientation;
> +
> +       rotation =3D cio2_bridge_parse_rotation(sensor);
> +       orientation =3D cio2_bridge_parse_orientation(sensor);
> +
>         sensor->prop_names =3D prop_names;
>
>         sensor->local_ref[0].node =3D &sensor->swnodes[SWNODE_CIO2_ENDPOI=
NT];
> @@ -85,9 +126,12 @@ static void cio2_bridge_create_fwnode_properties(
>         sensor->dev_properties[0] =3D PROPERTY_ENTRY_U32(
>                                         sensor->prop_names.clock_frequenc=
y,
>                                         sensor->ssdb.mclkspeed);
> -       sensor->dev_properties[1] =3D PROPERTY_ENTRY_U8(
> +       sensor->dev_properties[1] =3D PROPERTY_ENTRY_U32(
>                                         sensor->prop_names.rotation,
> -                                       sensor->ssdb.degree);
> +                                       rotation);
> +       sensor->dev_properties[2] =3D PROPERTY_ENTRY_U32(
> +                                       sensor->prop_names.orientation,
> +                                       orientation);
>
>         sensor->ep_properties[0] =3D PROPERTY_ENTRY_U32(
>                                         sensor->prop_names.bus_type,
> @@ -159,6 +203,7 @@ static void cio2_bridge_unregister_sensors(struct cio=
2_bridge *bridge)
>         for (i =3D 0; i < bridge->n_sensors; i++) {
>                 sensor =3D &bridge->sensors[i];
>                 software_node_unregister_nodes(sensor->swnodes);
> +               ACPI_FREE(sensor->pld);
>                 acpi_dev_put(sensor->adev);
>         }
>  }
> @@ -170,6 +215,7 @@ static int cio2_bridge_connect_sensor(const struct ci=
o2_sensor_config *cfg,
>         struct fwnode_handle *fwnode;
>         struct cio2_sensor *sensor;
>         struct acpi_device *adev;
> +       acpi_status status;
>         int ret;
>
>         for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
> @@ -193,11 +239,15 @@ static int cio2_bridge_connect_sensor(const struct =
cio2_sensor_config *cfg,
>                 if (ret)
>                         goto err_put_adev;
>
> +               status =3D acpi_get_physical_device_location(adev->handle=
, &sensor->pld);
> +               if (ACPI_FAILURE(status))
> +                       goto err_put_adev;
> +
>                 if (sensor->ssdb.lanes > CIO2_MAX_LANES) {
>                         dev_err(&adev->dev,
>                                 "Number of lanes in SSDB is invalid\n");
>                         ret =3D -EINVAL;
> -                       goto err_put_adev;
> +                       goto err_free_pld;
>                 }
>
>                 cio2_bridge_create_fwnode_properties(sensor, bridge, cfg);
> @@ -205,7 +255,7 @@ static int cio2_bridge_connect_sensor(const struct ci=
o2_sensor_config *cfg,
>
>                 ret =3D software_node_register_nodes(sensor->swnodes);
>                 if (ret)
> -                       goto err_put_adev;
> +                       goto err_free_pld;
>
>                 fwnode =3D software_node_fwnode(&sensor->swnodes[
>                                                       SWNODE_SENSOR_HID]);
> @@ -226,6 +276,8 @@ static int cio2_bridge_connect_sensor(const struct ci=
o2_sensor_config *cfg,
>
>  err_free_swnodes:
>         software_node_unregister_nodes(sensor->swnodes);
> +err_free_pld:
> +       ACPI_FREE(sensor->pld);
>  err_put_adev:
>         acpi_dev_put(sensor->adev);
>  err_out:
> diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.h b/drivers/media/p=
ci/intel/ipu3/cio2-bridge.h
> index dd0ffcafa489..202c7d494f7a 100644
> --- a/drivers/media/pci/intel/ipu3/cio2-bridge.h
> +++ b/drivers/media/pci/intel/ipu3/cio2-bridge.h
> @@ -12,6 +12,10 @@
>  #define CIO2_MAX_LANES                         4
>  #define MAX_NUM_LINK_FREQS                     3
>
> +/* Values are educated guesses as we don't have a spec */
> +#define CIO2_SENSOR_ROTATION_NORMAL            0
> +#define CIO2_SENSOR_ROTATION_INVERTED          1
> +
>  #define CIO2_SENSOR_CONFIG(_HID, _NR, ...)     \
>         (const struct cio2_sensor_config) {     \
>                 .hid =3D _HID,                    \
> @@ -80,6 +84,7 @@ struct cio2_sensor_ssdb {
>  struct cio2_property_names {
>         char clock_frequency[16];
>         char rotation[9];
> +       char orientation[12];
>         char bus_type[9];
>         char data_lanes[11];
>         char remote_endpoint[16];
> @@ -106,9 +111,11 @@ struct cio2_sensor {
>         struct cio2_node_names node_names;
>
>         struct cio2_sensor_ssdb ssdb;
> +       struct acpi_pld_info *pld;
> +
>         struct cio2_property_names prop_names;
>         struct property_entry ep_properties[5];
> -       struct property_entry dev_properties[3];
> +       struct property_entry dev_properties[4];
>         struct property_entry cio2_properties[3];
>         struct software_node_ref_args local_ref[1];
>         struct software_node_ref_args remote_ref[1];

...

> --- a/include/acpi/acbuffer.h
> +++ b/include/acpi/acbuffer.h
> @@ -207,4 +207,13 @@ struct acpi_pld_info {
>  #define ACPI_PLD_GET_HORIZ_OFFSET(dword)        ACPI_GET_BITS (dword, 16=
, ACPI_16BIT_MASK)
>  #define ACPI_PLD_SET_HORIZ_OFFSET(dword,value)  ACPI_SET_BITS (dword, 16=
, ACPI_16BIT_MASK, value)      /* Offset 128+16=3D144, Len 16 */
>
> +/* Panel position defined in _PLD section of ACPI Specification 6.3 */
> +#define ACPI_PLD_PANEL_TOP                     0
> +#define ACPI_PLD_PANEL_BOTTOM                  1
> +#define ACPI_PLD_PANEL_LEFT                    2
> +#define ACPI_PLD_PANEL_RIGHT                   3
> +#define ACPI_PLD_PANEL_FRONT                   4
> +#define ACPI_PLD_PANEL_BACK                    5
> +#define ACPI_PLD_PANEL_UNKNOWN                 6
> +
>  #endif                         /* ACBUFFER_H */

I assume this is a separate patch against ACPICA.

-- =

With Best Regards,
Andy Shevchenko
--===============8714076085921027602==--

