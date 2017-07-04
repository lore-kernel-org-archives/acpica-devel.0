Content-Type: multipart/mixed; boundary="===============3285075434585025270=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v3] acpi: configfs: Unload SSDT on configfs entry
 removal
Date: Tue, 04 Jul 2017 14:05:20 +0200
Message-ID: <CAJZ5v0j_UMDqkr82v6OEcmUW5Lqn-fae2wsSmFLC8zsCyprx0w@mail.gmail.com>
In-Reply-To: ba9505c1-1412-42be-9af7-57972fc50d3f@siemens.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3285075434585025270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 4, 2017 at 8:14 AM, Jan Kiszka <jan.kiszka(a)siemens.com> wrote:
> On 2017-06-09 20:36, Jan Kiszka wrote:
>> Call directly into acpica to load a table to obtain its index on return.
>> We choose the direct call of acpica internal functions to avoid having
>> to modify its API which is used outside of Linux as well.
>>
>> Use that index to unload the table again when the corresponding
>> directory in configfs gets removed. This allows to change SSDTs without
>> rebooting the system. It also allows to destroy devices again that a
>> dynamically loaded SSDT created.
>>
>> This is widely similar to the DT overlay behavior.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka(a)siemens.com>
>> ---
>>
>> Change in v3:
>>  - fix breakage if acpi_configfs is modular
>>
>>  drivers/acpi/acpi_configfs.c | 20 +++++++++++++++++++-
>>  drivers/acpi/acpica/tbdata.c |  4 ++++
>>  2 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
>> index 146a77fb762d..853bc7fc673f 100644
>> --- a/drivers/acpi/acpi_configfs.c
>> +++ b/drivers/acpi/acpi_configfs.c
>> @@ -15,11 +15,15 @@
>>  #include <linux/configfs.h>
>>  #include <linux/acpi.h>
>>
>> +#include "acpica/accommon.h"
>> +#include "acpica/actables.h"
>> +
>>  static struct config_group *acpi_table_group;
>>
>>  struct acpi_table {
>>       struct config_item cfg;
>>       struct acpi_table_header *header;
>> +     u32 index;
>>  };
>>
>>  static ssize_t acpi_table_aml_write(struct config_item *cfg,
>> @@ -52,7 +56,11 @@ static ssize_t acpi_table_aml_write(struct config_ite=
m *cfg,
>>       if (!table->header)
>>               return -ENOMEM;
>>
>> -     ret =3D acpi_load_table(table->header);
>> +     ACPI_INFO(("Host-directed Dynamic ACPI Table Load:"));
>> +     ret =3D acpi_tb_install_and_load_table(
>> +                     ACPI_PTR_TO_PHYSADDR(table->header),
>> +                     ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL, FALSE,
>> +                     &table->index);
>>       if (ret) {
>>               kfree(table->header);
>>               table->header =3D NULL;
>> @@ -215,8 +223,18 @@ static struct config_item *acpi_table_make_item(str=
uct config_group *group,
>>       return &table->cfg;
>>  }
>>
>> +static void acpi_table_drop_item(struct config_group *group,
>> +                              struct config_item *cfg)
>> +{
>> +     struct acpi_table *table =3D container_of(cfg, struct acpi_table, =
cfg);
>> +
>> +     ACPI_INFO(("Host-directed Dynamic ACPI Table Unload"));
>> +     acpi_tb_unload_table(table->index);
>> +}
>> +
>>  struct configfs_group_operations acpi_table_group_ops =3D {
>>       .make_item =3D acpi_table_make_item,
>> +     .drop_item =3D acpi_table_drop_item,
>>  };
>>
>>  static struct config_item_type acpi_tables_type =3D {
>> diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
>> index 27c5c27d4818..c9d6fa6d7cc6 100644
>> --- a/drivers/acpi/acpica/tbdata.c
>> +++ b/drivers/acpi/acpica/tbdata.c
>> @@ -867,6 +867,8 @@ acpi_tb_install_and_load_table(acpi_physical_address=
 address,
>>       return_ACPI_STATUS(status);
>>  }
>>
>> +ACPI_EXPORT_SYMBOL(acpi_tb_install_and_load_table)
>> +
>>  /**********************************************************************=
*********
>>   *
>>   * FUNCTION:    acpi_tb_unload_table
>> @@ -914,3 +916,5 @@ acpi_status acpi_tb_unload_table(u32 table_index)
>>       acpi_tb_set_table_loaded_flag(table_index, FALSE);
>>       return_ACPI_STATUS(status);
>>  }
>> +
>> +ACPI_EXPORT_SYMBOL(acpi_tb_unload_table)
>>
>
> Ping for this patch.

Pushed to Linus and is waiting for merging (along with the other ACPI
changes for 4.13).

Thanks,
Rafael

--===============3285075434585025270==--

