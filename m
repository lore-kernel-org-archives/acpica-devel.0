Content-Type: multipart/mixed; boundary="===============6009283978499157038=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: Re: [Devel] [PATCH v2] ACPI: surface3_power: MSHW0011 rev-eng
 implementation
Date: Thu, 29 Jun 2017 17:22:21 +0300
Message-ID: <CAHp75Vdn1-m0gDSHtZXX2A=Q07xG9j1eBiV8iM4e11Qk=oJfZg@mail.gmail.com>
In-Reply-To: 20170629121009.30234-1-benjamin.tissoires@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6009283978499157038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

+Cc: Hans (he might give some advice regarding to the below)

On Thu, Jun 29, 2017 at 3:10 PM, Benjamin Tissoires
<benjamin.tissoires(a)redhat.com> wrote:
> MSHW0011 replaces the battery firmware by using ACPI operation regions.
> The values have been obtained by reverse engineering, and are subject to
> errors. Looks like it works on overall pretty well.

What devices (laptops, tablets) have it?
Surface 3. What else?

> I couldn't manage to get the IRQ correctly triggered, so I am using a
> good old polling thread to check for changes.

It might be

>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D106231

> +config ACPI_SURFACE3_POWER_OPREGION
> +       tristate "Surface 3 battery platform operation region support"

depends on ACPI ?

> +       help
> +         Select this option to enable support for ACPI operation
> +         region of the Surface 3 battery platform driver.

> +/*
> + * Supports for the power IC on the Surface 3 tablet.

Shouldn't it go to drivers/acpi/pmic folder ?

And did you check if it have actual chip IP vendor name and model?
Most likely it's a TI (based?) solution.

> + */

> +/*
> + * Further findings regarding the 2 chips declared in the MSHW0011 are:
> + * - there are 2 chips declared:
> + *   . 0x22 seems to control the ADP1 line status (and probably the char=
ger)
> + *   . 0x55 controls the battery directly
> + * - the battery chip uses a SMBus protocol (using plain SMBus allows non
> + *   destructive commands):
> + *   . the commands/registers used are in the range 0x00..0x7F
> + *   . if bit 8 (0x80) is set in the SMBus command, the returned value i=
s the
> + *     same as when it is not set. There is a high chance this bit is the
> + *     read/write
> + *   . the various registers semantic as been deduced by observing the r=
egister
> + *     dumps.

All of this sounds familiar if look at what Hans discovered while was
doing INT33FE support.
Hans, does above ring any bell to you?

> + */

> +static bool dump_registers;
> +module_param_named(dump_registers, dump_registers, bool, 0644);
> +MODULE_PARM_DESC(dump_registers,
> +                "Dump the SMBus register at probe (debugging only).");

I'm not a fan of module parameter. Why not to use debugfs?

> +#define ACPI_BATTERY_STATE_DISCHARGING 0x1
> +#define ACPI_BATTERY_STATE_CHARGING    0x2
> +#define ACPI_BATTERY_STATE_CRITICAL    0x4

BIT() ?

> +#define MSHW0011_EV_2_5                        0x1ff

Is it mask? GENMASK() then.

> +
> +static int mshw0011_i2c_read_block(struct i2c_client *client, u8 reg, u8=
 *buf,
> +                                  int len)
> +{
> +       int status, i;
> +
> +       for (i =3D 0; i < len; i++) {
> +               status =3D i2c_smbus_read_byte_data(client, reg + i);
> +               if (status < 0) {
> +                       buf[i] =3D 0xff;
> +                       continue;
> +               }

Hmm... This looks weird. Why can you read entire block at once?

> +
> +               buf[i] =3D (u8)status;
> +       }
> +
> +       return 0;
> +}

> +static int
> +mshw0011_notify(struct mshw0011_data *cdata, u8 arg1, u8 arg2,
> +               unsigned int *ret_value)
> +{

> +       static const uuid_le mshw0011_guid =3D

guid_t, please :-)

> +               GUID_INIT(0x3F99E367, 0x6220, 0x4955,
> +                         0x8B, 0x0F, 0x06, 0xEF, 0x2A, 0xE7, 0x94, 0x12);

> +       *ret_value =3D 0;
> +       for (i =3D 0; i < obj->buffer.length; i++)
> +               *ret_value |=3D obj->buffer.pointer[i] << (i * 8);



> +
> +       ACPI_FREE(obj);
> +       return 0;
> +}

> +static int mshw0011_bix(struct mshw0011_data *cdata, struct bix *bix)
> +{

> +       memcpy(bix->serial, buf + 7, 3);
> +       memcpy(bix->serial + 3, buf, 6);
> +       bix->serial[9] =3D '\0';

snprintf()?

> +       bix->cycle_count =3D le16_to_cpu(ret);

non-x86 ?

> +       memcpy(bix->OEM, buf, 3);
> +       bix->OEM[4] =3D '\0';

snprintf() ?

> +
> +       return 0;
> +}

> +static int mshw0011_bst(struct mshw0011_data *cdata, struct bst *bst)
> +{
> +       struct i2c_client *client =3D cdata->bat0;
> +       int rate, capacity, voltage, state;
> +       s16 tmp;
> +
> +       rate =3D i2c_smbus_read_word_data(client, MSHW0011_BAT0_REG_RATE);
> +       if (rate < 0)
> +               return rate;
> +
> +       capacity =3D i2c_smbus_read_word_data(client, MSHW0011_BAT0_REG_C=
APACITY);
> +       if (capacity < 0)
> +               return capacity;
> +
> +       voltage =3D i2c_smbus_read_word_data(client, MSHW0011_BAT0_REG_VO=
LTAGE);
> +       if (voltage < 0)
> +               return voltage;
> +

> +       tmp =3D le16_to_cpu(rate);

Do we need that on x86?

> +       bst->battery_present_rate =3D abs((s32)tmp);
> +
> +       state =3D 0;

> +       if ((s32) tmp > 0)

See above, perhaps using rate directly.

> +               state |=3D ACPI_BATTERY_STATE_CHARGING;
> +       else if ((s32) tmp < 0)

Ditto.

> +       bst->battery_remaining_capacity =3D le16_to_cpu(capacity);
> +       bst->battery_present_voltage =3D le16_to_cpu(voltage);

non-x86 ?

> +}
> +


ret =3D 0; ?
...
> +       switch (gsb->cmd.arg1) {
> +       case MSHW0011_CMD_BAT0_STA:

> +               ret =3D 0;

See above.

> +               break;
> +       case MSHW0011_CMD_BAT0_BIX:
> +               ret =3D mshw0011_bix(cdata, &gsb->bix);
> +               break;
> +       case MSHW0011_CMD_BAT0_BTP:

> +               ret =3D 0;

Ditto.

> +               cdata->trip_point =3D gsb->cmd.arg2;
> +               break;
> +       case MSHW0011_CMD_BAT0_BST:
> +               ret =3D mshw0011_bst(cdata, &gsb->bst);
> +               break;
> +       default:
> +               pr_info("command(0x%02x) is not supported.\n", gsb->cmd.a=
rg1);
> +               ret =3D AE_BAD_PARAMETER;
> +               goto err;
> +       }
> +
> + out:
> +       gsb->ret =3D status;
> +       gsb->status =3D 0;
> +
> + err:
> +       ACPI_FREE(ares);
> +       return ret;
> +}
> +
> +static int mshw0011_install_space_handler(struct i2c_client *client)
> +{
> +       acpi_handle handle;
> +       struct mshw0011_handler_data *data;
> +       acpi_status status;
> +
> +       handle =3D ACPI_HANDLE(&client->dev);
> +
> +       if (!handle)
> +               return -ENODEV;
> +
> +       data =3D kzalloc(sizeof(struct mshw0011_handler_data),
> +                           GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->client =3D client;
> +       status =3D acpi_bus_attach_private_data(handle, (void *)data);
> +       if (ACPI_FAILURE(status)) {
> +               kfree(data);
> +               return -ENOMEM;
> +       }
> +
> +       status =3D acpi_install_address_space_handler(handle,
> +                               ACPI_ADR_SPACE_GSBUS,
> +                               &mshw0011_space_handler,
> +                               NULL,
> +                               data);
> +       if (ACPI_FAILURE(status)) {
> +               dev_err(&client->dev, "Error installing i2c space handler=
\n");
> +               acpi_bus_detach_private_data(handle);
> +               kfree(data);
> +               return -ENOMEM;
> +       }
> +
> +       acpi_walk_dep_device_list(handle);
> +       return 0;
> +}
> +
> +static void mshw0011_remove_space_handler(struct i2c_client *client)
> +{
> +       acpi_handle handle =3D ACPI_HANDLE(&client->dev);
> +       struct mshw0011_handler_data *data;
> +       acpi_status status;
> +
> +       if (!handle)
> +               return;
> +
> +       acpi_remove_address_space_handler(handle,
> +                               ACPI_ADR_SPACE_GSBUS,
> +                               &mshw0011_space_handler);
> +
> +       status =3D acpi_bus_get_private_data(handle, (void **)&data);
> +       if (ACPI_SUCCESS(status))
> +               kfree(data);
> +
> +       acpi_bus_detach_private_data(handle);
> +}
> +

> +static int acpi_find_i2c(struct acpi_resource *ares, void *data)
> +{
> +       struct mshw0011_lookup *lookup =3D data;
> +
> +       if (ares->type !=3D ACPI_RESOURCE_TYPE_SERIAL_BUS)
> +               return 1;
> +
> +       if (lookup->n++ =3D=3D lookup->index && !lookup->addr)
> +               lookup->addr =3D ares->data.i2c_serial_bus.slave_address;
> +
> +       return 1;
> +}
> +
> +static int mshw0011_i2c_resource_lookup(struct mshw0011_data *cdata,
> +                                       unsigned int index)
> +{
> +       struct i2c_client *client =3D cdata->adp1;
> +       struct acpi_device *adev =3D ACPI_COMPANION(&client->dev);
> +       struct mshw0011_lookup lookup =3D {
> +               .cdata =3D cdata,
> +               .index =3D index,
> +       };
> +       struct list_head res_list;
> +       int ret;
> +
> +       INIT_LIST_HEAD(&res_list);
> +
> +       ret =3D acpi_dev_get_resources(adev, &res_list, acpi_find_i2c, &l=
ookup);
> +       if (ret < 0)
> +               return ret;
> +
> +       acpi_dev_free_resource_list(&res_list);
> +
> +       if (!lookup.addr)
> +               return -ENOENT;
> +
> +       return lookup.addr;
> +}

Strange you have above functions here. It's a copy paste from I2C
core. Please, think about way of deduplicating it.

> +static void mshw0011_dump_registers(struct i2c_client *client,
> +                                   struct i2c_client *bat0, u8 end_regis=
ter)
> +{
> +       char *rd_buf;

> +       char prefix[128];

128 is too way big for a prefix.

> +       unsigned int length =3D end_register + 1;
> +       int error;
> +
> +       snprintf(prefix, ARRAY_SIZE(prefix), "%s: ", bat0->name);

> +       prefix[127] =3D '\0';

Why?

> +       rd_buf =3D kzalloc(length, GFP_KERNEL);

> +       error =3D mshw0011_i2c_read_block(bat0, 0, rd_buf, length);
> +       print_hex_dump(KERN_INFO, prefix, DUMP_PREFIX_OFFSET, 16, 1,
> +                      rd_buf, length, true);

If you switch to debugfs it makes things a bit more easier to handle I thin=
k.

> +
> +       kfree(rd_buf);
> +}

> +static int mshw0011_probe(struct i2c_client *client,
> +                         const struct i2c_device_id *id)
> +{

> +       data->notify_version =3D version =3D=3D MSHW0011_EV_2_5;

0x1ff as version sounds hmm suspicious.

> +static const struct i2c_device_id mshw0011_id[] =3D {
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, mshw0011_id);

->probe_new(), please.

If I2C framework is _still_ broken we need to fix that part.

> +#ifdef CONFIG_ACPI

Is it going to be non-ACPI at all? See my proposal to Kconfig as well.

> +               .acpi_match_table =3D ACPI_PTR(mshw0011_acpi_match),

ACPI_PTR() might be gone

-- =

With Best Regards,
Andy Shevchenko

--===============6009283978499157038==--

