Content-Type: multipart/mixed; boundary="===============0003011507044929792=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 5/6] platform/x86: Add intel_skl_int3472 driver
Date: Wed, 24 Feb 2021 10:56:22 +0200
Message-ID: <CAHp75VcUcEhXn3W-JW0iJaSHGDtyYtNE42o9UsBp1K2oEJi41g@mail.gmail.com>
In-Reply-To: 1360fc85-3f39-1dce-eee9-c4e76c2087ae@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0003011507044929792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, February 24, 2021, Daniel Scally <djrscally(a)gmail.com> wrot=
e:

> Hi Laurent
>
> On 23/02/2021 20:04, Laurent Pinchart wrote:
> > +
> > +/*
> > + * Here follows platform specific mapping information that we can pass
> to
> > + * the functions mapping resources to the sensors. Where the sensors
> have
> > + * a power enable pin defined in DSDT we need to provide a supply name
> so
> > + * the sensor drivers can find the regulator. The device name will be
> derived
> > + * from the sensor's ACPI device within the code. Optionally, we can
> provide a
> > + * NULL terminated array of function name mappings to deal with any
> platform
> > + * specific deviations from the documented behaviour of GPIOs.
> > + *
> > + * Map a GPIO function name to NULL to prevent the driver from mapping
> that
> > + * GPIO at all.
> > + */
> > +
> > +static const struct int3472_gpio_function_remap
> ov2680_gpio_function_remaps[] =3D {
> > +     { "reset", NULL },
> > +     { "powerdown", "reset" },
> > +     { }
> > +};
> > +
> > +static struct int3472_sensor_config int3472_sensor_configs[] =3D {
> > This should be static const (and there will be some fallout due to that,
> > as skl_int3472_register_regulator() modifies the supply_map, so I think
> > you'll have a copy of supply_map in int3472_discrete_device).
>
>
> Ack to all of the constness; you mentioned that last time too - not sure
> how I missed doing those! I think I can just having a local struct
> regulator_consumer_supply in skl_int3472_register_regulator and fill it
> from int3472->sensor_config.supply_map
>
> >> +static unsigned int skl_int3472_get_clk_frequency(struct
> int3472_discrete_device *int3472)
> >> +{
> >> +    union acpi_object *obj;
> >> +    unsigned int ret =3D 0;
> >> +
> >> +    obj =3D skl_int3472_get_acpi_buffer(int3472->sensor, "SSDB");
> >> +    if (IS_ERR(obj))
> >> +            return 0; /* report rate as 0 on error */
> >> +
> >> +    if (obj->buffer.length < CIO2_SENSOR_SSDB_MCLKSPEED_OFFSET +
> sizeof(u32)) {
> > Should we define an ssdb structure instead of peeking into the buffer
> > with an offset ?
>
>
> I thought about that, but in the end decided it didn't seem worth
> defining the whole SSDB structure just to use one field. Particularly
> since we use it in cio2-bridge already, so if we're going to do that it
> really ought to just live in a header that's included in both - and that
> seemed even less worthwhile.
>
>
> I don't have a strong feeling though, so if you think it's better to
> define the struct I'm happy to.
>
>
> >> +static unsigned long skl_int3472_clk_recalc_rate(struct clk_hw *hw,
> >> +                                             unsigned long parent_rat=
e)
> >> +{
> >> +    struct int3472_gpio_clock *clk =3D to_int3472_clk(hw);
> >> +    struct int3472_discrete_device *int3472 =3D to_int3472_device(clk=
);
> >> +
> >> +    return int3472->clock.frequency;
> > Maybe just
> >
> >       struct int3472_gpio_clock *clk =3D to_int3472_clk(hw);
> >
> >       return clk->frequency;
>
>
> Oops, of course.
>
> >> +static int skl_int3472_register_regulator(struct
> int3472_discrete_device *int3472,
> >> +                                      struct acpi_resource *ares)
> >> +{
> >> +    char *path =3D ares->data.gpio.resource_source.string_ptr;
> >> +    struct int3472_sensor_config *sensor_config;
> >> +    struct regulator_init_data init_data =3D { };
> >> +    struct regulator_config cfg =3D { };
> >> +    int ret;
> >> +
> >> +    sensor_config =3D int3472->sensor_config;
> >> +    if (IS_ERR_OR_NULL(sensor_config)) {
> >> +            dev_err(int3472->dev, "No sensor module config\n");
> >> +            return PTR_ERR(sensor_config);
> >> +    }
> >> +
> >> +    if (!sensor_config->supply_map.supply) {
> >> +            dev_err(int3472->dev, "No supply name defined\n");
> >> +            return -ENODEV;
> >> +    }
> >> +
> >> +    init_data.constraints.valid_ops_mask =3D REGULATOR_CHANGE_STATUS;
> >> +    init_data.num_consumer_supplies =3D 1;
> >> +    sensor_config->supply_map.dev_name =3D int3472->sensor_name;
> >> +    init_data.consumer_supplies =3D &sensor_config->supply_map;
> >> +
> >> +    snprintf(int3472->regulator.regulator_name,
> >> +             sizeof(int3472->regulator.regulator_name),
> "%s-regulator",
> >> +             acpi_dev_name(int3472->adev));
> >> +    snprintf(int3472->regulator.supply_name,
> >> +             GPIO_REGULATOR_SUPPLY_NAME_LENGTH, "supply-0");
> >> +
> >> +    int3472->regulator.rdesc =3D INT3472_REGULATOR(
> >> +
> int3472->regulator.regulator_name,
> >> +                                            int3472->regulator.supply_
> name,
> >> +
> &int3472_gpio_regulator_ops);
> >> +
> >> +    int3472->regulator.gpio =3D acpi_get_gpiod(path,
> >> +
>  ares->data.gpio.pin_table[0],
> >> +                                             "int3472,regulator");
> >> +    if (IS_ERR(int3472->regulator.gpio)) {
> >> +            dev_err(int3472->dev, "Failed to get regulator GPIO
> lines\n");
> > s/lines/line/ (sorry, it was a typo in my review of v2)
>
>
> No problem!
>
> >> +static int skl_int3472_parse_crs(struct int3472_discrete_device
> *int3472)
> >> +{
> >> +    struct list_head resource_list;
> >> +    int ret;
> >> +
> >> +    INIT_LIST_HEAD(&resource_list);
> >> +
> >> +    int3472->sensor_config =3D skl_int3472_get_sensor_module_
> config(int3472);
> > I have forgotten some of the context I'm afraid :-/ Are there valid use
> > cases for not checking for an error here, or should we do so and drop
> > the error checks in other functions above ?
>
>
> Not all platforms need a sensor_config; only those which have either a
> regulator pin or need a GPIO function to be remapped; the rest will do
> without it.
>
> So, we need to not check for an error here because the absence of a
> sensor_config isn't necessarily an error, we won't know till later.
>
> > +int skl_int3472_discrete_probe(struct platform_device *pdev)
> > +{
> > +     struct acpi_device *adev =3D ACPI_COMPANION(&pdev->dev);
> > +     struct int3472_discrete_device *int3472;
> > +     struct int3472_cldb cldb;
> > +     int ret;
> > +
> > +     ret =3D skl_int3472_fill_cldb(adev, &cldb);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Couldn't fill CLDB structure\n");
> > +             return ret;
> > +     }
> > +
> > +     if (cldb.control_logic_type !=3D 1) {
> > +             dev_err(&pdev->dev, "Unsupported control logic type %u\n",
> > +                     cldb.control_logic_type);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Max num GPIOs we've seen plus a terminator */
> > +     int3472 =3D kzalloc(struct_size(int3472, gpios.table,
> > +                       INT3472_MAX_SENSOR_GPIOS + 1), GFP_KERNEL);
> > +     if (!int3472)
> > +             return -ENOMEM;
> > +
> > +     int3472->adev =3D adev;
> > +     int3472->dev =3D &pdev->dev;
> > +     platform_set_drvdata(pdev, int3472);
> > +
> > +     int3472->sensor =3D acpi_dev_get_dependent_dev(adev);
> > +     if (IS_ERR_OR_NULL(int3472->sensor)) {
> > +             dev_err(&pdev->dev,
> > +                     "INT3472 seems to have no dependents.\n");
> > +             ret =3D -ENODEV;
> > +             goto err_free_int3472;
> > +     }
> > +     get_device(&int3472->sensor->dev);
> > I see no corresponding put_device(), am I missing something ? I'm also
> > not sure why this is needed.
> >
>
> The put is acpi_dev_put() in skl_int3472_discrete_remove(); there seems
> to be no acpi_dev_get() for some reason. We use the sensor acpi_device
> to get the clock frequency, and to fetch the sensor module string, so I
> thought it ought to hold a reference on those grounds.
>
>
> >> diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_tps6=
8470.c
> b/drivers/platform/x86/intel-int3472/intel_skl_int3472_tps68470.c
> >> new file mode 100644
> >> index 000000000000..d0d2391e263f
> >> --- /dev/null
> >> +++ b/drivers/platform/x86/intel-int3472/intel_skl_int3472_tps68470.c
> >> @@ -0,0 +1,113 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/* Author: Dan Scally <djrscally(a)gmail.com> */
> >> +
> >> +#include <linux/i2c.h>
> >> +#include <linux/mfd/core.h>
> >> +#include <linux/mfd/tps68470.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/regmap.h>
> >> +
> >> +#include "intel_skl_int3472_common.h"
> >> +
> >> +static const struct mfd_cell tps68470_c[] =3D {
> >> +    { .name =3D "tps68470-gpio" },
> >> +    { .name =3D "tps68470_pmic_opregion" },
> >> +};
> >> +
> >> +static const struct mfd_cell tps68470_w[] =3D {
> > Maybe more explicit names than _c and _w could be nice ?
>
>
> _chrome and _windows was in my mind - sound ok?


In kernel =E2=80=9Ccros=E2=80=9D used for Chrome OS, you may take it, for t=
he Windows I
have no idea, b/c =E2=80=9Cwin=E2=80=9D maybe still ambiguous.




-- =

With Best Regards,
Andy Shevchenko

--===============0003011507044929792==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGJyPjxicj5PbiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDI0LCAyMDIxLCBEYW5pZWwgU2NhbGx5ICZs
dDs8YSBocmVmPSJtYWlsdG86ZGpyc2NhbGx5QGdtYWlsLmNvbSI+ZGpyc2NhbGx5QGdtYWlsLmNv
bTwvYT4mZ3Q7IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxl
PSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxl
ZnQ6MWV4Ij5IaSBMYXVyZW50PGJyPgo8YnI+Ck9uIDIzLzAyLzIwMjEgMjA6MDQsIExhdXJlbnQg
UGluY2hhcnQgd3JvdGU6PGJyPgomZ3Q7ICs8YnI+CiZndDsgKy8qPGJyPgomZ3Q7ICsgKiBIZXJl
IGZvbGxvd3MgcGxhdGZvcm0gc3BlY2lmaWMgbWFwcGluZyBpbmZvcm1hdGlvbiB0aGF0IHdlIGNh
biBwYXNzIHRvPGJyPgomZ3Q7ICsgKiB0aGUgZnVuY3Rpb25zIG1hcHBpbmcgcmVzb3VyY2VzIHRv
IHRoZSBzZW5zb3JzLiBXaGVyZSB0aGUgc2Vuc29ycyBoYXZlPGJyPgomZ3Q7ICsgKiBhIHBvd2Vy
IGVuYWJsZSBwaW4gZGVmaW5lZCBpbiBEU0RUIHdlIG5lZWQgdG8gcHJvdmlkZSBhIHN1cHBseSBu
YW1lIHNvPGJyPgomZ3Q7ICsgKiB0aGUgc2Vuc29yIGRyaXZlcnMgY2FuIGZpbmQgdGhlIHJlZ3Vs
YXRvci4gVGhlIGRldmljZSBuYW1lIHdpbGwgYmUgZGVyaXZlZDxicj4KJmd0OyArICogZnJvbSB0
aGUgc2Vuc29yJiMzOTtzIEFDUEkgZGV2aWNlIHdpdGhpbiB0aGUgY29kZS4gT3B0aW9uYWxseSwg
d2UgY2FuIHByb3ZpZGUgYTxicj4KJmd0OyArICogTlVMTCB0ZXJtaW5hdGVkIGFycmF5IG9mIGZ1
bmN0aW9uIG5hbWUgbWFwcGluZ3MgdG8gZGVhbCB3aXRoIGFueSBwbGF0Zm9ybTxicj4KJmd0OyAr
ICogc3BlY2lmaWMgZGV2aWF0aW9ucyBmcm9tIHRoZSBkb2N1bWVudGVkIGJlaGF2aW91ciBvZiBH
UElPcy48YnI+CiZndDsgKyAqPGJyPgomZ3Q7ICsgKiBNYXAgYSBHUElPIGZ1bmN0aW9uIG5hbWUg
dG8gTlVMTCB0byBwcmV2ZW50IHRoZSBkcml2ZXIgZnJvbSBtYXBwaW5nIHRoYXQ8YnI+CiZndDsg
KyAqIEdQSU8gYXQgYWxsLjxicj4KJmd0OyArICovPGJyPgomZ3Q7ICs8YnI+CiZndDsgK3N0YXRp
YyBjb25zdCBzdHJ1Y3QgaW50MzQ3Ml9ncGlvX2Z1bmN0aW9uX3JlbWFwIG92MjY4MF9ncGlvX2Z1
bmN0aW9uX3JlbWFwc1tdID0gezxicj4KJmd0OyArwqAgwqAgwqB7ICZxdW90O3Jlc2V0JnF1b3Q7
LCBOVUxMIH0sPGJyPgomZ3Q7ICvCoCDCoCDCoHsgJnF1b3Q7cG93ZXJkb3duJnF1b3Q7LCAmcXVv
dDtyZXNldCZxdW90OyB9LDxicj4KJmd0OyArwqAgwqAgwqB7IH08YnI+CiZndDsgK307PGJyPgom
Z3Q7ICs8YnI+CiZndDsgK3N0YXRpYyBzdHJ1Y3QgaW50MzQ3Ml9zZW5zb3JfY29uZmlnIGludDM0
NzJfc2Vuc29yX2NvbmZpZ3NbXSA9IHs8YnI+CiZndDsgVGhpcyBzaG91bGQgYmUgc3RhdGljIGNv
bnN0IChhbmQgdGhlcmUgd2lsbCBiZSBzb21lIGZhbGxvdXQgZHVlIHRvIHRoYXQsPGJyPgomZ3Q7
IGFzIHNrbF9pbnQzNDcyX3JlZ2lzdGVyXzx3YnI+cmVndWxhdG9yKCkgbW9kaWZpZXMgdGhlIHN1
cHBseV9tYXAsIHNvIEkgdGhpbms8YnI+CiZndDsgeW91JiMzOTtsbCBoYXZlIGEgY29weSBvZiBz
dXBwbHlfbWFwIGluIGludDM0NzJfZGlzY3JldGVfZGV2aWNlKS48YnI+Cjxicj4KPGJyPgpBY2sg
dG8gYWxsIG9mIHRoZSBjb25zdG5lc3M7IHlvdSBtZW50aW9uZWQgdGhhdCBsYXN0IHRpbWUgdG9v
IC0gbm90IHN1cmU8YnI+CmhvdyBJIG1pc3NlZCBkb2luZyB0aG9zZSEgSSB0aGluayBJIGNhbiBq
dXN0IGhhdmluZyBhIGxvY2FsIHN0cnVjdDxicj4KcmVndWxhdG9yX2NvbnN1bWVyX3N1cHBseSBp
biBza2xfaW50MzQ3Ml9yZWdpc3Rlcl9yZWd1bGF0b3IgYW5kIGZpbGwgaXQ8YnI+CmZyb20gaW50
MzQ3Mi0mZ3Q7c2Vuc29yX2NvbmZpZy5zdXBwbHlfPHdicj5tYXA8YnI+Cjxicj4KJmd0OyZndDsg
K3N0YXRpYyB1bnNpZ25lZCBpbnQgc2tsX2ludDM0NzJfZ2V0X2Nsa19mcmVxdWVuY3koPHdicj5z
dHJ1Y3QgaW50MzQ3Ml9kaXNjcmV0ZV9kZXZpY2UgKmludDM0NzIpPGJyPgomZ3Q7Jmd0OyArezxi
cj4KJmd0OyZndDsgK8KgIMKgIHVuaW9uIGFjcGlfb2JqZWN0ICpvYmo7PGJyPgomZ3Q7Jmd0OyAr
wqAgwqAgdW5zaWduZWQgaW50IHJldCA9IDA7PGJyPgomZ3Q7Jmd0OyArPGJyPgomZ3Q7Jmd0OyAr
wqAgwqAgb2JqID0gc2tsX2ludDM0NzJfZ2V0X2FjcGlfYnVmZmVyKDx3YnI+aW50MzQ3Mi0mZ3Q7
c2Vuc29yLCAmcXVvdDtTU0RCJnF1b3Q7KTs8YnI+CiZndDsmZ3Q7ICvCoCDCoCBpZiAoSVNfRVJS
KG9iaikpPGJyPgomZ3Q7Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIDA7IC8qIHJlcG9y
dCByYXRlIGFzIDAgb24gZXJyb3IgKi88YnI+CiZndDsmZ3Q7ICs8YnI+CiZndDsmZ3Q7ICvCoCDC
oCBpZiAob2JqLSZndDtidWZmZXIubGVuZ3RoICZsdDsgQ0lPMl9TRU5TT1JfU1NEQl9NQ0xLU1BF
RURfPHdicj5PRkZTRVQgKyBzaXplb2YodTMyKSkgezxicj4KJmd0OyBTaG91bGQgd2UgZGVmaW5l
IGFuIHNzZGIgc3RydWN0dXJlIGluc3RlYWQgb2YgcGVla2luZyBpbnRvIHRoZSBidWZmZXI8YnI+
CiZndDsgd2l0aCBhbiBvZmZzZXQgPzxicj4KPGJyPgo8YnI+CkkgdGhvdWdodCBhYm91dCB0aGF0
LCBidXQgaW4gdGhlIGVuZCBkZWNpZGVkIGl0IGRpZG4mIzM5O3Qgc2VlbSB3b3J0aDxicj4KZGVm
aW5pbmcgdGhlIHdob2xlIFNTREIgc3RydWN0dXJlIGp1c3QgdG8gdXNlIG9uZSBmaWVsZC4gUGFy
dGljdWxhcmx5PGJyPgpzaW5jZSB3ZSB1c2UgaXQgaW4gY2lvMi1icmlkZ2UgYWxyZWFkeSwgc28g
aWYgd2UmIzM5O3JlIGdvaW5nIHRvIGRvIHRoYXQgaXQ8YnI+CnJlYWxseSBvdWdodCB0byBqdXN0
IGxpdmUgaW4gYSBoZWFkZXIgdGhhdCYjMzk7cyBpbmNsdWRlZCBpbiBib3RoIC0gYW5kIHRoYXQ8
YnI+CnNlZW1lZCBldmVuIGxlc3Mgd29ydGh3aGlsZS48YnI+Cjxicj4KPGJyPgpJIGRvbiYjMzk7
dCBoYXZlIGEgc3Ryb25nIGZlZWxpbmcgdGhvdWdoLCBzbyBpZiB5b3UgdGhpbmsgaXQmIzM5O3Mg
YmV0dGVyIHRvPGJyPgpkZWZpbmUgdGhlIHN0cnVjdCBJJiMzOTttIGhhcHB5IHRvLjxicj4KPGJy
Pgo8YnI+CiZndDsmZ3Q7ICtzdGF0aWMgdW5zaWduZWQgbG9uZyBza2xfaW50MzQ3Ml9jbGtfcmVj
YWxjX3JhdGUoPHdicj5zdHJ1Y3QgY2xrX2h3ICpodyw8YnI+CiZndDsmZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHVuc2lnbmVkIGxvbmcgcGFyZW50X3JhdGUpPGJyPgomZ3Q7Jmd0OyArezxicj4KJmd0OyZndDsg
K8KgIMKgIHN0cnVjdCBpbnQzNDcyX2dwaW9fY2xvY2sgKmNsayA9IHRvX2ludDM0NzJfY2xrKGh3
KTs8YnI+CiZndDsmZ3Q7ICvCoCDCoCBzdHJ1Y3QgaW50MzQ3Ml9kaXNjcmV0ZV9kZXZpY2UgKmlu
dDM0NzIgPSB0b19pbnQzNDcyX2RldmljZShjbGspOzxicj4KJmd0OyZndDsgKzxicj4KJmd0OyZn
dDsgK8KgIMKgIHJldHVybiBpbnQzNDcyLSZndDtjbG9jay5mcmVxdWVuY3k7PGJyPgomZ3Q7IE1h
eWJlIGp1c3Q8YnI+CiZndDs8YnI+CiZndDvCoCDCoCDCoCDCoHN0cnVjdCBpbnQzNDcyX2dwaW9f
Y2xvY2sgKmNsayA9IHRvX2ludDM0NzJfY2xrKGh3KTs8YnI+CiZndDs8YnI+CiZndDvCoCDCoCDC
oCDCoHJldHVybiBjbGstJmd0O2ZyZXF1ZW5jeTs8YnI+Cjxicj4KPGJyPgpPb3BzLCBvZiBjb3Vy
c2UuPGJyPgo8YnI+CiZndDsmZ3Q7ICtzdGF0aWMgaW50IHNrbF9pbnQzNDcyX3JlZ2lzdGVyXzx3
YnI+cmVndWxhdG9yKHN0cnVjdCBpbnQzNDcyX2Rpc2NyZXRlX2RldmljZSAqaW50MzQ3Miw8YnI+
CiZndDsmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBzdHJ1Y3QgYWNwaV9yZXNvdXJjZSAqYXJlcyk8YnI+CiZndDsmZ3Q7ICt7PGJy
PgomZ3Q7Jmd0OyArwqAgwqAgY2hhciAqcGF0aCA9IGFyZXMtJmd0O2RhdGEuZ3Bpby5yZXNvdXJj
ZV88d2JyPnNvdXJjZS5zdHJpbmdfcHRyOzxicj4KJmd0OyZndDsgK8KgIMKgIHN0cnVjdCBpbnQz
NDcyX3NlbnNvcl9jb25maWcgKnNlbnNvcl9jb25maWc7PGJyPgomZ3Q7Jmd0OyArwqAgwqAgc3Ry
dWN0IHJlZ3VsYXRvcl9pbml0X2RhdGEgaW5pdF9kYXRhID0geyB9Ozxicj4KJmd0OyZndDsgK8Kg
IMKgIHN0cnVjdCByZWd1bGF0b3JfY29uZmlnIGNmZyA9IHsgfTs8YnI+CiZndDsmZ3Q7ICvCoCDC
oCBpbnQgcmV0Ozxicj4KJmd0OyZndDsgKzxicj4KJmd0OyZndDsgK8KgIMKgIHNlbnNvcl9jb25m
aWcgPSBpbnQzNDcyLSZndDtzZW5zb3JfY29uZmlnOzxicj4KJmd0OyZndDsgK8KgIMKgIGlmIChJ
U19FUlJfT1JfTlVMTChzZW5zb3JfY29uZmlnKTx3YnI+KSB7PGJyPgomZ3Q7Jmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgZGV2X2VycihpbnQzNDcyLSZndDtkZXYsICZxdW90O05vIHNlbnNvciBtb2R1
bGUgY29uZmlnXG4mcXVvdDspOzxicj4KJmd0OyZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIHJldHVy
biBQVFJfRVJSKHNlbnNvcl9jb25maWcpOzxicj4KJmd0OyZndDsgK8KgIMKgIH08YnI+CiZndDsm
Z3Q7ICs8YnI+CiZndDsmZ3Q7ICvCoCDCoCBpZiAoIXNlbnNvcl9jb25maWctJmd0O3N1cHBseV9t
YXAuPHdicj5zdXBwbHkpIHs8YnI+CiZndDsmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCBkZXZfZXJy
KGludDM0NzItJmd0O2RldiwgJnF1b3Q7Tm8gc3VwcGx5IG5hbWUgZGVmaW5lZFxuJnF1b3Q7KTs8
YnI+CiZndDsmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gLUVOT0RFVjs8YnI+CiZndDsm
Z3Q7ICvCoCDCoCB9PGJyPgomZ3Q7Jmd0OyArPGJyPgomZ3Q7Jmd0OyArwqAgwqAgaW5pdF9kYXRh
LmNvbnN0cmFpbnRzLnZhbGlkXzx3YnI+b3BzX21hc2sgPSBSRUdVTEFUT1JfQ0hBTkdFX1NUQVRV
Uzs8YnI+CiZndDsmZ3Q7ICvCoCDCoCBpbml0X2RhdGEubnVtX2NvbnN1bWVyXzx3YnI+c3VwcGxp
ZXMgPSAxOzxicj4KJmd0OyZndDsgK8KgIMKgIHNlbnNvcl9jb25maWctJmd0O3N1cHBseV9tYXAu
ZGV2Xzx3YnI+bmFtZSA9IGludDM0NzItJmd0O3NlbnNvcl9uYW1lOzxicj4KJmd0OyZndDsgK8Kg
IMKgIGluaXRfZGF0YS5jb25zdW1lcl9zdXBwbGllcyA9ICZhbXA7c2Vuc29yX2NvbmZpZy0mZ3Q7
c3VwcGx5X21hcDs8YnI+CiZndDsmZ3Q7ICs8YnI+CiZndDsmZ3Q7ICvCoCDCoCBzbnByaW50Zihp
bnQzNDcyLSZndDtyZWd1bGF0b3IuPHdicj5yZWd1bGF0b3JfbmFtZSw8YnI+CiZndDsmZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoHNpemVvZihpbnQzNDcyLSZndDtyZWd1bGF0b3IuPHdicj5yZWd1
bGF0b3JfbmFtZSksICZxdW90OyVzLXJlZ3VsYXRvciZxdW90Oyw8YnI+CiZndDsmZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoGFjcGlfZGV2X25hbWUoaW50MzQ3Mi0mZ3Q7YWRldikpOzxicj4KJmd0
OyZndDsgK8KgIMKgIHNucHJpbnRmKGludDM0NzItJmd0O3JlZ3VsYXRvci48d2JyPnN1cHBseV9u
YW1lLDxicj4KJmd0OyZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgR1BJT19SRUdVTEFUT1JfU1VQ
UExZX05BTUVfPHdicj5MRU5HVEgsICZxdW90O3N1cHBseS0wJnF1b3Q7KTs8YnI+CiZndDsmZ3Q7
ICs8YnI+CiZndDsmZ3Q7ICvCoCDCoCBpbnQzNDcyLSZndDtyZWd1bGF0b3IucmRlc2MgPSBJTlQz
NDcyX1JFR1VMQVRPUig8YnI+CiZndDsmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpbnQzNDcyLSZndDtyZWd1bGF0
b3IucmVndWxhdG9yXzx3YnI+bmFtZSw8YnI+CiZndDsmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpbnQzNDcyLSZn
dDtyZWd1bGF0b3Iuc3VwcGx5Xzx3YnI+bmFtZSw8YnI+CiZndDsmZ3Q7ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmYW1w
O2ludDM0NzJfZ3Bpb19yZWd1bGF0b3Jfb3BzKTs8YnI+CiZndDsmZ3Q7ICs8YnI+CiZndDsmZ3Q7
ICvCoCDCoCBpbnQzNDcyLSZndDtyZWd1bGF0b3IuZ3BpbyA9IGFjcGlfZ2V0X2dwaW9kKHBhdGgs
PGJyPgomZ3Q7Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhcmVzLSZndDtkYXRhLmdwaW8ucGluX3RhYmxlWzBd
LDxicj4KJmd0OyZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7aW50MzQ3MixyZWd1bGF0b3ImcXVvdDsp
Ozxicj4KJmd0OyZndDsgK8KgIMKgIGlmIChJU19FUlIoaW50MzQ3Mi0mZ3Q7cmVndWxhdG9yLjx3
YnI+Z3BpbykpIHs8YnI+CiZndDsmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCBkZXZfZXJyKGludDM0
NzItJmd0O2RldiwgJnF1b3Q7RmFpbGVkIHRvIGdldCByZWd1bGF0b3IgR1BJTyBsaW5lc1xuJnF1
b3Q7KTs8YnI+CiZndDsgcy9saW5lcy9saW5lLyAoc29ycnksIGl0IHdhcyBhIHR5cG8gaW4gbXkg
cmV2aWV3IG9mIHYyKTxicj4KPGJyPgo8YnI+Ck5vIHByb2JsZW0hPGJyPgo8YnI+CiZndDsmZ3Q7
ICtzdGF0aWMgaW50IHNrbF9pbnQzNDcyX3BhcnNlX2NycyhzdHJ1Y3QgaW50MzQ3Ml9kaXNjcmV0
ZV9kZXZpY2UgKmludDM0NzIpPGJyPgomZ3Q7Jmd0OyArezxicj4KJmd0OyZndDsgK8KgIMKgIHN0
cnVjdCBsaXN0X2hlYWQgcmVzb3VyY2VfbGlzdDs8YnI+CiZndDsmZ3Q7ICvCoCDCoCBpbnQgcmV0
Ozxicj4KJmd0OyZndDsgKzxicj4KJmd0OyZndDsgK8KgIMKgIElOSVRfTElTVF9IRUFEKCZhbXA7
cmVzb3VyY2VfbGlzdCk8d2JyPjs8YnI+CiZndDsmZ3Q7ICs8YnI+CiZndDsmZ3Q7ICvCoCDCoCBp
bnQzNDcyLSZndDtzZW5zb3JfY29uZmlnID0gc2tsX2ludDM0NzJfZ2V0X3NlbnNvcl9tb2R1bGVf
PHdicj5jb25maWcoaW50MzQ3Mik7PGJyPgomZ3Q7IEkgaGF2ZSBmb3Jnb3R0ZW4gc29tZSBvZiB0
aGUgY29udGV4dCBJJiMzOTttIGFmcmFpZCA6LS8gQXJlIHRoZXJlIHZhbGlkIHVzZTxicj4KJmd0
OyBjYXNlcyBmb3Igbm90IGNoZWNraW5nIGZvciBhbiBlcnJvciBoZXJlLCBvciBzaG91bGQgd2Ug
ZG8gc28gYW5kIGRyb3A8YnI+CiZndDsgdGhlIGVycm9yIGNoZWNrcyBpbiBvdGhlciBmdW5jdGlv
bnMgYWJvdmUgPzxicj4KPGJyPgo8YnI+Ck5vdCBhbGwgcGxhdGZvcm1zIG5lZWQgYSBzZW5zb3Jf
Y29uZmlnOyBvbmx5IHRob3NlIHdoaWNoIGhhdmUgZWl0aGVyIGE8YnI+CnJlZ3VsYXRvciBwaW4g
b3IgbmVlZCBhIEdQSU8gZnVuY3Rpb24gdG8gYmUgcmVtYXBwZWQ7IHRoZSByZXN0IHdpbGwgZG88
YnI+CndpdGhvdXQgaXQuPGJyPgo8YnI+ClNvLCB3ZSBuZWVkIHRvIG5vdCBjaGVjayBmb3IgYW4g
ZXJyb3IgaGVyZSBiZWNhdXNlIHRoZSBhYnNlbmNlIG9mIGE8YnI+CnNlbnNvcl9jb25maWcgaXNu
JiMzOTt0IG5lY2Vzc2FyaWx5IGFuIGVycm9yLCB3ZSB3b24mIzM5O3Qga25vdyB0aWxsIGxhdGVy
Ljxicj4KPGJyPgomZ3Q7ICtpbnQgc2tsX2ludDM0NzJfZGlzY3JldGVfcHJvYmUoPHdicj5zdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KTxicj4KJmd0OyArezxicj4KJmd0OyArwqAgwqAgwqBz
dHJ1Y3QgYWNwaV9kZXZpY2UgKmFkZXYgPSBBQ1BJX0NPTVBBTklPTigmYW1wO3BkZXYtJmd0O2Rl
dik7PGJyPgomZ3Q7ICvCoCDCoCDCoHN0cnVjdCBpbnQzNDcyX2Rpc2NyZXRlX2RldmljZSAqaW50
MzQ3Mjs8YnI+CiZndDsgK8KgIMKgIMKgc3RydWN0IGludDM0NzJfY2xkYiBjbGRiOzxicj4KJmd0
OyArwqAgwqAgwqBpbnQgcmV0Ozxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoHJldCA9IHNr
bF9pbnQzNDcyX2ZpbGxfY2xkYihhZGV2LCAmYW1wO2NsZGIpOzxicj4KJmd0OyArwqAgwqAgwqBp
ZiAocmV0KSB7PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGRldl9lcnIoJmFtcDtwZGV2
LSZndDtkZXYsICZxdW90O0NvdWxkbiYjMzk7dCBmaWxsIENMREIgc3RydWN0dXJlXG4mcXVvdDsp
Ozxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4KJmd0OyArwqAg
wqAgwqB9PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgaWYgKGNsZGIuY29udHJvbF9sb2dp
Y190eXBlICE9IDEpIHs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgZGV2X2VycigmYW1w
O3BkZXYtJmd0O2RldiwgJnF1b3Q7VW5zdXBwb3J0ZWQgY29udHJvbCBsb2dpYyB0eXBlICV1XG4m
cXVvdDssPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNsZGIuY29u
dHJvbF9sb2dpY190eXBlKTs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1F
SU5WQUw7PGJyPgomZ3Q7ICvCoCDCoCDCoH08YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqAv
KiBNYXggbnVtIEdQSU9zIHdlJiMzOTt2ZSBzZWVuIHBsdXMgYSB0ZXJtaW5hdG9yICovPGJyPgom
Z3Q7ICvCoCDCoCDCoGludDM0NzIgPSBremFsbG9jKHN0cnVjdF9zaXplKGludDM0NzIsIGdwaW9z
LnRhYmxlLDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBJTlQz
NDcyX01BWF9TRU5TT1JfR1BJT1MgKyAxKSwgR0ZQX0tFUk5FTCk7PGJyPgomZ3Q7ICvCoCDCoCDC
oGlmICghaW50MzQ3Mik8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FTk9N
RU07PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgaW50MzQ3Mi0mZ3Q7YWRldiA9IGFkZXY7
PGJyPgomZ3Q7ICvCoCDCoCDCoGludDM0NzItJmd0O2RldiA9ICZhbXA7cGRldi0mZ3Q7ZGV2Ozxi
cj4KJmd0OyArwqAgwqAgwqBwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBpbnQzNDcyKTs8YnI+
CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqBpbnQzNDcyLSZndDtzZW5zb3IgPSBhY3BpX2Rldl9n
ZXRfZGVwZW5kZW50X2Rldig8d2JyPmFkZXYpOzxicj4KJmd0OyArwqAgwqAgwqBpZiAoSVNfRVJS
X09SX05VTEwoaW50MzQ3Mi0mZ3Q7PHdicj5zZW5zb3IpKSB7PGJyPgomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoGRldl9lcnIoJmFtcDtwZGV2LSZndDtkZXYsPGJyPgomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O0lOVDM0NzIgc2VlbXMgdG8gaGF2ZSBubyBkZXBl
bmRlbnRzLlxuJnF1b3Q7KTs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gLUVO
T0RFVjs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBlcnJfZnJlZV9pbnQzNDcy
Ozxicj4KJmd0OyArwqAgwqAgwqB9PGJyPgomZ3Q7ICvCoCDCoCDCoGdldF9kZXZpY2UoJmFtcDtp
bnQzNDcyLSZndDtzZW5zb3ItJmd0Ozx3YnI+ZGV2KTs8YnI+CiZndDsgSSBzZWUgbm8gY29ycmVz
cG9uZGluZyBwdXRfZGV2aWNlKCksIGFtIEkgbWlzc2luZyBzb21ldGhpbmcgPyBJJiMzOTttIGFs
c288YnI+CiZndDsgbm90IHN1cmUgd2h5IHRoaXMgaXMgbmVlZGVkLjxicj4KJmd0Ozxicj4KPGJy
PgpUaGUgcHV0IGlzIGFjcGlfZGV2X3B1dCgpIGluIHNrbF9pbnQzNDcyX2Rpc2NyZXRlX3JlbW92
ZSgpOyB0aGVyZSBzZWVtczxicj4KdG8gYmUgbm8gYWNwaV9kZXZfZ2V0KCkgZm9yIHNvbWUgcmVh
c29uLiBXZSB1c2UgdGhlIHNlbnNvciBhY3BpX2RldmljZTxicj4KdG8gZ2V0IHRoZSBjbG9jayBm
cmVxdWVuY3ksIGFuZCB0byBmZXRjaCB0aGUgc2Vuc29yIG1vZHVsZSBzdHJpbmcsIHNvIEk8YnI+
CnRob3VnaHQgaXQgb3VnaHQgdG8gaG9sZCBhIHJlZmVyZW5jZSBvbiB0aG9zZSBncm91bmRzLjxi
cj4KPGJyPgo8YnI+CiZndDsmZ3Q7IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9p
bnRlbC08d2JyPmludDM0NzIvaW50ZWxfc2tsX2ludDM0NzJfPHdicj50cHM2ODQ3MC5jIGIvZHJp
dmVycy9wbGF0Zm9ybS94ODYvaW50ZWwtPHdicj5pbnQzNDcyL2ludGVsX3NrbF9pbnQzNDcyXzx3
YnI+dHBzNjg0NzAuYzxicj4KJmd0OyZndDsgbmV3IGZpbGUgbW9kZSAxMDA2NDQ8YnI+CiZndDsm
Z3Q7IGluZGV4IDAwMDAwMDAwMDAwMC4uZDBkMjM5MWUyNjNmPGJyPgomZ3Q7Jmd0OyAtLS0gL2Rl
di9udWxsPGJyPgomZ3Q7Jmd0OyArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC08d2Jy
PmludDM0NzIvaW50ZWxfc2tsX2ludDM0NzJfPHdicj50cHM2ODQ3MC5jPGJyPgomZ3Q7Jmd0OyBA
QCAtMCwwICsxLDExMyBAQDxicj4KJmd0OyZndDsgKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wPGJyPgomZ3Q7Jmd0OyArLyogQXV0aG9yOiBEYW4gU2NhbGx5ICZsdDs8YSBocmVm
PSJtYWlsdG86ZGpyc2NhbGx5QGdtYWlsLmNvbSI+ZGpyc2NhbGx5QGdtYWlsLmNvbTwvYT4mZ3Q7
ICovPGJyPgomZ3Q7Jmd0OyArPGJyPgomZ3Q7Jmd0OyArI2luY2x1ZGUgJmx0O2xpbnV4L2kyYy5o
Jmd0Ozxicj4KJmd0OyZndDsgKyNpbmNsdWRlICZsdDtsaW51eC9tZmQvY29yZS5oJmd0Ozxicj4K
Jmd0OyZndDsgKyNpbmNsdWRlICZsdDtsaW51eC9tZmQvdHBzNjg0NzAuaCZndDs8YnI+CiZndDsm
Z3Q7ICsjaW5jbHVkZSAmbHQ7bGludXgvcGxhdGZvcm1fZGV2aWNlLmgmZ3Q7PGJyPgomZ3Q7Jmd0
OyArI2luY2x1ZGUgJmx0O2xpbnV4L3JlZ21hcC5oJmd0Ozxicj4KJmd0OyZndDsgKzxicj4KJmd0
OyZndDsgKyNpbmNsdWRlICZxdW90O2ludGVsX3NrbF9pbnQzNDcyX2NvbW1vbi5oJnF1b3Q7PGJy
PgomZ3Q7Jmd0OyArPGJyPgomZ3Q7Jmd0OyArc3RhdGljIGNvbnN0IHN0cnVjdCBtZmRfY2VsbCB0
cHM2ODQ3MF9jW10gPSB7PGJyPgomZ3Q7Jmd0OyArwqAgwqAgeyAubmFtZSA9ICZxdW90O3RwczY4
NDcwLWdwaW8mcXVvdDsgfSw8YnI+CiZndDsmZ3Q7ICvCoCDCoCB7IC5uYW1lID0gJnF1b3Q7dHBz
Njg0NzBfcG1pY19vcHJlZ2lvbiZxdW90OyB9LDxicj4KJmd0OyZndDsgK307PGJyPgomZ3Q7Jmd0
OyArPGJyPgomZ3Q7Jmd0OyArc3RhdGljIGNvbnN0IHN0cnVjdCBtZmRfY2VsbCB0cHM2ODQ3MF93
W10gPSB7PGJyPgomZ3Q7IE1heWJlIG1vcmUgZXhwbGljaXQgbmFtZXMgdGhhbiBfYyBhbmQgX3cg
Y291bGQgYmUgbmljZSA/PGJyPgo8YnI+Cjxicj4KX2Nocm9tZSBhbmQgX3dpbmRvd3Mgd2FzIGlu
IG15IG1pbmQgLSBzb3VuZCBvaz88L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5JbiBr
ZXJuZWwg4oCcY3Jvc+KAnSB1c2VkIGZvciBDaHJvbWUgT1MsIHlvdSBtYXkgdGFrZSBpdCwgZm9y
IHRoZSBXaW5kb3dzIEkgaGF2ZSBubyBpZGVhLCBiL2Mg4oCcd2lu4oCdIG1heWJlIHN0aWxsIGFt
YmlndW91cy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PsKgPC9kaXY+PGJyPjxicj4tLSA8YnI+
V2l0aCBCZXN0IFJlZ2FyZHMsPGJyPkFuZHkgU2hldmNoZW5rbzxicj48YnI+PGJyPgo=

--===============0003011507044929792==--

