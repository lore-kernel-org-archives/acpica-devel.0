Content-Type: multipart/mixed; boundary="===============0590618997345510755=="
MIME-Version: 1.0
From: Alexei Fedorov <Alexei.Fedorov at arm.com>
Subject: Re: [Devel] Devel Digest, Vol 77, Issue 2
Date: Tue, 16 May 2017 09:04:10 +0000
Message-ID: <HE1PR0802MB2299B15486AFBC0CFA68776D9AE60@HE1PR0802MB2299.eurprd08.prod.outlook.com>
In-Reply-To: mailman.3164.1494918833.2175.devel@acpica.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0590618997345510755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Re: [PATCH] ACPI: SPCR: Use access width to determine mmio
      usage (Zheng, Lv)


Hi Zheng,


> +             switch (table->serial_port.access_width) {
> +             default:
> +                     pr_err("Unexpected SPCR Access Width.  Defaulting t=
o byte size\n");
> +             case ACPI_ACCESS_SIZE_BYTE:
> +                     iotype =3D "mmio";
> +                     break;
> +             case ACPI_ACCESS_SIZE_WORD:
> +                     iotype =3D "mmio16";
> +                     break;
> +             case ACPI_ACCESS_SIZE_DWORD:
> +                     iotype =3D "mmio32";
> +                     break;
> +             }
> +     } else
> +             iotype =3D "io";


Why there's no code for ACPI_ACCESS_SIZE_QWORD?


Regards,

Alexei.


________________________________
From: Devel <devel-bounces(a)acpica.org> on behalf of devel-request(a)acpic=
a.org <devel-request(a)acpica.org>
Sent: 16 May 2017 08:13:53
To: devel(a)acpica.org
Subject: Devel Digest, Vol 77, Issue 2

Send Devel mailing list submissions to
        devel(a)acpica.org

To subscribe or unsubscribe via the World Wide Web, visit
        https://lists.acpica.org/mailman/listinfo/devel
or, via email, send a message with subject or body 'help' to
        devel-request(a)acpica.org

You can reach the person managing the list at
        devel-owner(a)acpica.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Devel digest..."


Today's Topics:

   1. Re: [PATCH] ACPI: SPCR: Use access width to determine mmio
      usage (Zheng, Lv)
   2. [RFC PATCH v2 0/5] ACPICA: Tables: Add deferred verification
      support (Lv Zheng)
   3. [RFC PATCH v2 1/5] ACPICA: Tables: Cleanup table handler
      invokers (Lv Zheng)
   4. [RFC PATCH v2 2/5] ACPICA: Tables: Do not validate signature
      for dynamic table load (Lv Zheng)
   5. [RFC PATCH v2 3/5] ACPICA: Tables: Change table duplication
      check to be related to acpi_gbl_verify_table_checksum (Lv Zheng)
   6. [RFC PATCH v2 4/5] ACPICA: Tables: Combine
      checksum/duplication verification together (Lv Zheng)


----------------------------------------------------------------------

Message: 1
Date: Fri, 5 May 2017 03:09:34 +0000
From: "Zheng, Lv" <lv.zheng(a)intel.com>
To: Jon Mason <jon.mason(a)broadcom.com>, Rafael Wysocki
        <rjw(a)rjwysocki.net>, Len Brown <lenb(a)kernel.org>, "Moore, Rober=
t"
        <robert.moore(a)intel.com>
Cc: "linux-acpi(a)vger.kernel.org" <linux-acpi(a)vger.kernel.org>,
        "linux-kernel(a)vger.kernel.org" <linux-kernel(a)vger.kernel.org>,
        "devel(a)acpica.org" <devel(a)acpica.org>,
        "bcm-kernel-feedback-list(a)broadcom.com"
        <bcm-kernel-feedback-list(a)broadcom.com>
Subject: Re: [Devel] [PATCH] ACPI: SPCR: Use access width to determine
        mmio usage
Message-ID:
        <1AE640813FDE7649BE1B193DEA596E886CE9DCBC(a)SHSMSX101.ccr.corp.inte=
l.com>

Content-Type: text/plain; charset=3D"gb2312"

Hi,

> From: Jon Mason [mailto:jon.mason(a)broadcom.com]
> Sent: Thursday, May 4, 2017 11:06 PM
> Subject: [PATCH] ACPI: SPCR: Use access width to determine mmio usage
>
> The current SPCR code does not check the access width of the mmio, and
> uses a default of 8bit register accesses.  This prevents devices that
> only do 16 or 32bit register accesses from working.  By simply checking
> this field and setting the mmio string appropriately, this issue can be
> corrected.  To prevent any legacy issues, the code will default to 8bit
> accesses if the value is anything but 16 or 32.
>
> Signed-off-by: Jon Mason <jon.mason(a)broadcom.com>
> ---
>  drivers/acpi/spcr.c     | 18 ++++++++++++++++--
>  include/acpi/acrestyp.h |  7 +++++++
>  2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 01c9466..11233f6 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -74,8 +74,22 @@ int __init parse_spcr(bool earlycon)
>                goto done;
>        }
>
> -     iotype =3D table->serial_port.space_id =3D=3D ACPI_ADR_SPACE_SYSTEM=
_MEMORY ?
> -                     "mmio" : "io";
> +     if (table->serial_port.space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY=
) {
> +             switch (table->serial_port.access_width) {
> +             default:
> +                     pr_err("Unexpected SPCR Access Width.  Defaulting t=
o byte size\n");
> +             case ACPI_ACCESS_SIZE_BYTE:
> +                     iotype =3D "mmio";
> +                     break;
> +             case ACPI_ACCESS_SIZE_WORD:
> +                     iotype =3D "mmio16";
> +                     break;
> +             case ACPI_ACCESS_SIZE_DWORD:
> +                     iotype =3D "mmio32";
> +                     break;
> +             }
> +     } else
> +             iotype =3D "io";
>
>        switch (table->interface_type) {
>        case ACPI_DBG2_ARM_SBSA_32BIT:
> diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
> index f0f7403..781cb55 100644
> --- a/include/acpi/acrestyp.h
> +++ b/include/acpi/acrestyp.h
> @@ -372,6 +372,13 @@ struct acpi_resource_generic_register {
>        u64 address;
>  };
>
> +/* Generic Address Space Access Sizes */
> +#define ACPI_ACCESS_SIZE_UNDEFINED           0
> +#define ACPI_ACCESS_SIZE_BYTE                        1
> +#define ACPI_ACCESS_SIZE_WORD                        2
> +#define ACPI_ACCESS_SIZE_DWORD                       3
> +#define ACPI_ACCESS_SIZE_QWORD                       4
> +
>  struct acpi_resource_gpio {
>        u8 revision_id;
>        u8 connection_type;

Please don't define this.
It's possible to calculate 8/16/32/64 from the access width value.
Try:
1 << (access_width + 2?

Thanks
Lv


------------------------------

Message: 2
Date: Tue, 16 May 2017 15:13:08 +0800
From: Lv Zheng <lv.zheng(a)intel.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki(a)intel.com>, Len Brown
        <len.brown(a)intel.com>, Robert Moore <robert.moore(a)intel.com>, L=
v Zheng
        <lv.zheng(a)intel.com>, "David E . Box" <david.e.box(a)intel.com>
Cc: Lv Zheng <zetalog(a)gmail.com>, linux-acpi(a)vger.kernel.org,
        devel(a)acpica.org, Hans de Goede <hdegoede(a)redhat.com>
Subject: [Devel] [RFC PATCH v2 0/5] ACPICA: Tables: Add deferred
        verification support
Message-ID: <cover.1494916766.git.lv.zheng(a)intel.com>

On linux, we can not verify ACPI tables before installing them into the
global table list in early stage due to the number of slot limitations for
early ioremap. This leaves a problem that we cannot detect duplicated
tables in early stage, causing unwanted error messages seen when the
duplicated tables are failed to be loaded [link #1].

This patchset as ACPICA PR [link #2] adds support to verify tables in
acpi_reallocate_root_tables() which is invoked after installing tables in
early stage, being ready for late ioremap and beofre loading table in late
stage. If duplicated tables are detected, acpi_reallocate_root_tables()
stops installing them to the final reallocated global table list.

In v1 patchset [link #3], problems can be seen for dynamic loading tables
which are allocated as virtuall allocated tables. Such tables are
incremented in the global table list as the sanity check done in install
step only compares the table addresses while the virtual allocated
addresses are not stable.
In v2 patchset, we follow original design discussion made in ACPICA devel
mailing list, implements deferred table verification so that duplicate
tables are still can be detected in install step rather than in load step.
Also we removed table signature check according to verified windows
behavior [link #4] and reported issues [link #5].

Link: http://www.spinics.net/lists/linux-acpi/msg72215.html [#1]
Link: https://github.com//acpica/acpica/pull/265            [#2]
Link: http://www.spinics.net/lists/linux-acpi/msg72589.html [#3]
Link: https://github.com//acpica/acpica/pull/121            [#4]
      https://bugzilla.kernel.org/show_bug.cgi?id=3D118601    [#5]

Lv Zheng (5):
  ACPICA: Tables: Cleanup table handler invokers
  ACPICA: Tables: Do not validate signature for dynamic table load
  ACPICA: Tables: Change table duplication check to be related to
    acpi_gbl_verify_table_checksum
  ACPICA: Tables: Combine checksum/duplication verification together
  ACPICA: Tables: Add deferred table verification support

 drivers/acpi/acpica/actables.h |   5 +-
 drivers/acpi/acpica/tbdata.c   | 222 ++++++++++++++++++++++++++++++++++++-=
----
 drivers/acpi/acpica/tbinstal.c | 161 ++++--------------------------
 drivers/acpi/acpica/tbxface.c  |  36 ++++++-
 drivers/acpi/acpica/tbxfload.c |   2 +-
 drivers/acpi/bus.c             |   3 -
 drivers/acpi/tables.c          |   4 +-
 include/acpi/acpixf.h          |  15 +--
 include/acpi/actbl.h           |   1 +
 9 files changed, 266 insertions(+), 183 deletions(-)

--
2.7.4



------------------------------

Message: 3
Date: Tue, 16 May 2017 15:13:17 +0800
From: Lv Zheng <lv.zheng(a)intel.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki(a)intel.com>, Len Brown
        <len.brown(a)intel.com>, Robert Moore <robert.moore(a)intel.com>, L=
v Zheng
        <lv.zheng(a)intel.com>, "David E . Box" <david.e.box(a)intel.com>
Cc: Lv Zheng <zetalog(a)gmail.com>, linux-acpi(a)vger.kernel.org,
        devel(a)acpica.org, Hans de Goede <hdegoede(a)redhat.com>
Subject: [Devel] [RFC PATCH v2 1/5] ACPICA: Tables: Cleanup table
        handler invokers
Message-ID:
        <c8a48e0379ed9d06d50844b4d7ac59ac8fb6e7d7.1494916766.git.lv.zheng(a=
)intel.com>


Recently, we allows the table mutex to be held in both early and late stage
APIs. This patch further cleans up the related code to reduce redundant
code related to acpi_gbl_table_handler. Lv Zheng.

Tested-by: Hans de Goede <hdegoede(a)redhat.com>
Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
---
 drivers/acpi/acpica/actables.h |  2 ++
 drivers/acpi/acpica/tbdata.c   | 43 ++++++++++++++++++++++++++++----------=
----
 drivers/acpi/acpica/tbinstal.c |  8 ++------
 3 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index c8da453..89ed31b 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -132,6 +132,8 @@ acpi_tb_install_and_load_table(acpi_physical_address ad=
dress,

 acpi_status acpi_tb_unload_table(u32 table_index);

+void acpi_tb_notify_table(u32 event, void *table);
+
 void acpi_tb_terminate(void);

 acpi_status acpi_tb_delete_namespace_by_owner(u32 table_index);
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 27c5c27..42ea044 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -818,13 +818,9 @@ acpi_tb_load_table(u32 table_index, struct acpi_namesp=
ace_node *parent_node)
                 acpi_ev_update_gpes(owner_id);
         }

-       /* Invoke table handler if present */
-
-       if (acpi_gbl_table_handler) {
-               (void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_LOAD, table,
-                                            acpi_gbl_table_handler_context=
);
-       }
+       /* Invoke table handler */

+       acpi_tb_notify_table(ACPI_TABLE_EVENT_LOAD, table);
         return_ACPI_STATUS(status);
 }

@@ -892,15 +888,11 @@ acpi_status acpi_tb_unload_table(u32 table_index)
                 return_ACPI_STATUS(AE_NOT_EXIST);
         }

-       /* Invoke table handler if present */
+       /* Invoke table handler */

-       if (acpi_gbl_table_handler) {
-               status =3D acpi_get_table_by_index(table_index, &table);
-               if (ACPI_SUCCESS(status)) {
-                       (void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_UNLOA=
D,
-                                                    table,
-                                                    acpi_gbl_table_handler=
_context);
-               }
+       status =3D acpi_get_table_by_index(table_index, &table);
+       if (ACPI_SUCCESS(status)) {
+               acpi_tb_notify_table(ACPI_TABLE_EVENT_UNLOAD, table);
         }

         /* Delete the portion of the namespace owned by this table */
@@ -914,3 +906,26 @@ acpi_status acpi_tb_unload_table(u32 table_index)
         acpi_tb_set_table_loaded_flag(table_index, FALSE);
         return_ACPI_STATUS(status);
 }
+
+/*************************************************************************=
******
+ *
+ * FUNCTION:    acpi_tb_notify_table
+ *
+ * PARAMETERS:  event               - Table event
+ *              table               - Validated table pointer
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Notify a table event to the users.
+ *
+ *************************************************************************=
*****/
+
+void acpi_tb_notify_table(u32 event, void *table)
+{
+       /* Invoke table handler if present */
+
+       if (acpi_gbl_table_handler) {
+               (void)acpi_gbl_table_handler(event, table,
+                                            acpi_gbl_table_handler_context=
);
+       }
+}
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 4620f3c..ee74515 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -306,14 +306,10 @@ acpi_tb_install_standard_table(acpi_physical_address =
address,
         acpi_tb_install_table_with_override(&new_table_desc, override,
                                             table_index);

-       /* Invoke table handler if present */
+       /* Invoke table handler */

         (void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
-       if (acpi_gbl_table_handler) {
-               (void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_INSTALL,
-                                            new_table_desc.pointer,
-                                            acpi_gbl_table_handler_context=
);
-       }
+       acpi_tb_notify_table(ACPI_TABLE_EVENT_INSTALL, new_table_desc.point=
er);
         (void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);

 unlock_and_exit:
--
2.7.4



------------------------------

Message: 4
Date: Tue, 16 May 2017 15:13:26 +0800
From: Lv Zheng <lv.zheng(a)intel.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki(a)intel.com>, Len Brown
        <len.brown(a)intel.com>, Robert Moore <robert.moore(a)intel.com>, L=
v Zheng
        <lv.zheng(a)intel.com>, "David E . Box" <david.e.box(a)intel.com>
Cc: Lv Zheng <zetalog(a)gmail.com>, linux-acpi(a)vger.kernel.org,
        devel(a)acpica.org, Hans de Goede <hdegoede(a)redhat.com>
Subject: [Devel] [RFC PATCH v2 2/5] ACPICA: Tables: Do not validate
        signature for dynamic table load
Message-ID:
        <f07bb8cfeda364698adad9bc15d54c9b2ac8b366.1494916766.git.lv.zheng(a=
)intel.com>


Windows seems to allow arbitrary table signatures for Load/load_table
opcodes:
  ACPI BIOS Error (bug): Table has invalid signature [PRAD] (0x44415250)
So this patch removes dynamic load signature checks. However we need to
find a way to avoid table loading against tables like MADT. This is not
covered by this commit.

This Windows behavior has been validated on link #1. An end user bug
report can also be found on link #2.

This patch also includes simple cleanup for static load signature check
code. Reported by Ye Xiaolong, Fixed by Lv Zheng.

Link: https://github.com/acpica/acpica/pull/121 [#1]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D118601 [#2]
Reported-by: Ye Xiaolong <xiaolong.ye(a)intel.com>
Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
---
 drivers/acpi/acpica/tbinstal.c | 28 ----------------------------
 drivers/acpi/acpica/tbxfload.c |  2 +-
 2 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index ee74515..9d21296 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -222,34 +222,6 @@ acpi_tb_install_standard_table(acpi_physical_address a=
ddress,
         (void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);

         if (reload) {
-               /*
-                * Validate the incoming table signature.
-                *
-                * 1) Originally, we checked the table signature for "SSDT"=
 or "PSDT".
-                * 2) We added support for OEMx tables, signature "OEM".
-                * 3) Valid tables were encountered with a null signature, =
so we just
-                *    gave up on validating the signature, (05/2008).
-                * 4) We encountered non-AML tables such as the MADT, which=
 caused
-                *    interpreter errors and kernel faults. So now, we once=
 again allow
-                *    only "SSDT", "OEMx", and now, also a null signature. =
(05/2011).
-                */
-               if ((new_table_desc.signature.ascii[0] !=3D 0x00) &&
-                   (!ACPI_COMPARE_NAME
-                    (&new_table_desc.signature, ACPI_SIG_SSDT))
-                   && (strncmp(new_table_desc.signature.ascii, "OEM", 3)))=
 {
-                       ACPI_BIOS_ERROR((AE_INFO,
-                                        "Table has invalid signature [%4.4=
s] (0x%8.8X), "
-                                        "must be SSDT or OEMx",
-                                        acpi_ut_valid_nameseg(new_table_de=
sc.
-                                                              signature.
-                                                              ascii) ?
-                                        new_table_desc.signature.
-                                        ascii : "????",
-                                        new_table_desc.signature.integer));
-
-                       status =3D AE_BAD_SIGNATURE;
-                       goto unlock_and_exit;
-               }

                 /* Check if table is already registered */

diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index b71ce3b..d81f442 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -206,7 +206,7 @@ acpi_status acpi_tb_load_namespace(void)
         for (i =3D 0; i < acpi_gbl_root_table_list.current_table_count; ++=
i) {
                 table =3D &acpi_gbl_root_table_list.tables[i];

-               if (!acpi_gbl_root_table_list.tables[i].address ||
+               if (!table->address ||
                     (!ACPI_COMPARE_NAME(table->signature.ascii, ACPI_SIG_S=
SDT)
                      && !ACPI_COMPARE_NAME(table->signature.ascii,
                                            ACPI_SIG_PSDT)
--
2.7.4



------------------------------

Message: 5
Date: Tue, 16 May 2017 15:13:39 +0800
From: Lv Zheng <lv.zheng(a)intel.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki(a)intel.com>, Len Brown
        <len.brown(a)intel.com>, Robert Moore <robert.moore(a)intel.com>, L=
v Zheng
        <lv.zheng(a)intel.com>, "David E . Box" <david.e.box(a)intel.com>
Cc: Lv Zheng <zetalog(a)gmail.com>, linux-acpi(a)vger.kernel.org,
        devel(a)acpica.org, Hans de Goede <hdegoede(a)redhat.com>
Subject: [Devel] [RFC PATCH v2 3/5] ACPICA: Tables: Change table
        duplication check to be related to acpi_gbl_verify_table_checksum
Message-ID:
        <579de00f5d54e128b04bba5ae627afd0f132c528.1494916766.git.lv.zheng(a=
)intel.com>


acpi_gbl_verify_table_checksum is used to avoid validating (mapping) an ent=
ire
table in OS boot stage. 2nd "Reload" check in acpi_tb_install_standard_tabl=
e()
is prepared for the same purpose. So this patch combines them together
using a renamed acpi_gbl_enable_table_validation flag. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
---
 drivers/acpi/acpica/tbdata.c   |  4 ++--
 drivers/acpi/acpica/tbinstal.c |  2 +-
 drivers/acpi/acpica/tbxface.c  |  8 ++++++++
 drivers/acpi/bus.c             |  2 +-
 drivers/acpi/tables.c          |  4 ++--
 include/acpi/acpixf.h          | 15 ++++++++-------
 6 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 42ea044..e81355b 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -338,7 +338,7 @@ void acpi_tb_invalidate_table(struct acpi_table_desc *t=
able_desc)
 acpi_status acpi_tb_validate_temp_table(struct acpi_table_desc *table_desc)
 {

-       if (!table_desc->pointer && !acpi_gbl_verify_table_checksum) {
+       if (!table_desc->pointer && !acpi_gbl_enable_table_validation) {
                 /*
                  * Only validates the header of the table.
                  * Note that Length contains the size of the mapping after=
 invoking
@@ -394,7 +394,7 @@ acpi_tb_verify_temp_table(struct acpi_table_desc *table=
_desc, char *signature)

         /* Verify the checksum */

-       if (acpi_gbl_verify_table_checksum) {
+       if (acpi_gbl_enable_table_validation) {
                 status =3D
                     acpi_tb_verify_checksum(table_desc->pointer,
                                             table_desc->length);
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 9d21296..f7bc362 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -221,7 +221,7 @@ acpi_tb_install_standard_table(acpi_physical_address ad=
dress,

         (void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);

-       if (reload) {
+       if (acpi_gbl_enable_table_validation) {

                 /* Check if table is already registered */

diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 010b1c43..b0dc841 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -194,6 +194,14 @@ acpi_status ACPI_INIT_FUNCTION acpi_reallocate_root_ta=
ble(void)
                 }
         }

+       if (!acpi_gbl_enable_table_validation) {
+               /*
+                * Now it's safe to do full table validation. We can do def=
erred
+                * table initilization here once the flag is set.
+                */
+               acpi_gbl_enable_table_validation =3D TRUE;
+       }
+
         acpi_gbl_root_table_list.flags |=3D ACPI_ROOT_ALLOW_RESIZE;

         status =3D acpi_tb_resize_root_table_list();
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 34fbe02..c26342f 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1010,7 +1010,7 @@ void __init acpi_early_init(void)
         printk(KERN_INFO PREFIX "Core revision %08x\n", ACPI_CA_VERSION);

         /* It's safe to verify table checksums during late stage */
-       acpi_gbl_verify_table_checksum =3D TRUE;
+       acpi_gbl_enable_table_validation =3D TRUE;

         /* enable workarounds, unless strict ACPI spec. compliance */
         if (!acpi_strict)
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 0dae722..b5cc09c 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -740,10 +740,10 @@ int __init acpi_table_init(void)

         if (acpi_verify_table_checksum) {
                 pr_info("Early table checksum verification enabled\n");
-               acpi_gbl_verify_table_checksum =3D TRUE;
+               acpi_gbl_enable_table_validation =3D TRUE;
         } else {
                 pr_info("Early table checksum verification disabled\n");
-               acpi_gbl_verify_table_checksum =3D FALSE;
+               acpi_gbl_enable_table_validation =3D FALSE;
         }

         status =3D acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES,=
 0);
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 15c86ce..88a1de8 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -160,13 +160,14 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_create_osi_method, TRUE=
);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_use_default_register_widths, TRUE);

 /*
- * Whether or not to verify the table checksum before installation. Set
- * this to TRUE to verify the table checksum before install it to the table
- * manager. Note that enabling this option causes errors to happen in some
- * OSPMs during early initialization stages. Default behavior is to do such
- * verification.
- */
-ACPI_INIT_GLOBAL(u8, acpi_gbl_verify_table_checksum, TRUE);
+ * Whether or not to validate (map) an entire table to verify
+ * checksum/duplication in early stage before install. Set this to TRUE to
+ * allow early table validation before install it to the table manager.
+ * Note that enabling this option causes errors to happen in some OSPMs
+ * during early initialization stages. Default behavior is to allow such
+ * validation.
+ */
+ACPI_INIT_GLOBAL(u8, acpi_gbl_enable_table_validation, TRUE);

 /*
  * Optionally enable output from the AML Debug Object.
--
2.7.4



------------------------------

Message: 6
Date: Tue, 16 May 2017 15:13:48 +0800
From: Lv Zheng <lv.zheng(a)intel.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki(a)intel.com>, Len Brown
        <len.brown(a)intel.com>, Robert Moore <robert.moore(a)intel.com>, L=
v Zheng
        <lv.zheng(a)intel.com>, "David E . Box" <david.e.box(a)intel.com>
Cc: Lv Zheng <zetalog(a)gmail.com>, linux-acpi(a)vger.kernel.org,
        devel(a)acpica.org, Hans de Goede <hdegoede(a)redhat.com>
Subject: [Devel] [RFC PATCH v2 4/5] ACPICA: Tables: Combine
        checksum/duplication verification together
Message-ID:
        <eef9d0a56bb7bd7383dda740042b583fa58103c7.1494916766.git.lv.zheng(a=
)intel.com>


They are all mechanism used to verify if a table is qualified to be
installed and controlled by acpi_gbl_enable_table_validation, so combine
them together. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
---
 drivers/acpi/acpica/actables.h |   3 +-
 drivers/acpi/acpica/tbdata.c   | 148 +++++++++++++++++++++++++++++++++++++=
++--
 drivers/acpi/acpica/tbinstal.c | 124 ++++++----------------------------
 3 files changed, 165 insertions(+), 110 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 89ed31b..84a3ceb 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -76,7 +76,8 @@ void acpi_tb_release_temp_table(struct acpi_table_desc *t=
able_desc);
 acpi_status acpi_tb_validate_temp_table(struct acpi_table_desc *table_desc=
);

 acpi_status
-acpi_tb_verify_temp_table(struct acpi_table_desc *table_desc, char *signat=
ure);
+acpi_tb_verify_temp_table(struct acpi_table_desc *table_desc,
+                         char *signature, u32 *table_index);

 u8 acpi_tb_is_table_loaded(u32 table_index);

diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index e81355b..2dee2cd 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -50,6 +50,57 @@
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbdata")

+/* Local prototypes */
+static acpi_status
+acpi_tb_check_duplication(struct acpi_table_desc *table_desc, u32 *table_i=
ndex);
+
+static u8
+acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index=
);
+
+/*************************************************************************=
******
+ *
+ * FUNCTION:    acpi_tb_compare_tables
+ *
+ * PARAMETERS:  table_desc          - Table 1 descriptor to be compared
+ *              table_index         - Index of table 2 to be compared
+ *
+ * RETURN:      TRUE if both tables are identical.
+ *
+ * DESCRIPTION: This function compares a table with another table that has
+ *              already been installed in the root table list.
+ *
+ *************************************************************************=
*****/
+
+static u8
+acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index)
+{
+       acpi_status status =3D AE_OK;
+       u8 is_identical;
+       struct acpi_table_header *table;
+       u32 table_length;
+       u8 table_flags;
+
+       status =3D
+           acpi_tb_acquire_table(&acpi_gbl_root_table_list.tables[table_in=
dex],
+                                 &table, &table_length, &table_flags);
+       if (ACPI_FAILURE(status)) {
+               return (FALSE);
+       }
+
+       /*
+        * Check for a table match on the entire table length,
+        * not just the header.
+        */
+       is_identical =3D (u8)((table_desc->length !=3D table_length ||
+                            memcmp(table_desc->pointer, table, table_lengt=
h)) ?
+                           FALSE : TRUE);
+
+       /* Release the acquired table */
+
+       acpi_tb_release_table(table, table_length, table_flags);
+       return (is_identical);
+}
+
 /*************************************************************************=
******
  *
  * FUNCTION:    acpi_tb_init_table_descriptor
@@ -64,6 +115,7 @@ ACPI_MODULE_NAME("tbdata")
  * DESCRIPTION: Initialize a new table descriptor
  *
  *************************************************************************=
*****/
+
 void
 acpi_tb_init_table_descriptor(struct acpi_table_desc *table_desc,
                               acpi_physical_address address,
@@ -354,12 +406,78 @@ acpi_status acpi_tb_validate_temp_table(struct acpi_t=
able_desc *table_desc)
         return (acpi_tb_validate_table(table_desc));
 }

+/*************************************************************************=
******
+ *
+ * FUNCTION:    acpi_tb_check_duplication
+ *
+ * PARAMETERS:  table_desc          - Table descriptor
+ *              table_index         - Where the table index is returned
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Avoid installing duplicated tables. However table override=
 and
+ *              user aided dynamic table load is allowed, thus comparing t=
he
+ *              address of the table is not sufficient, and checking the e=
ntire
+ *              table content is required.
+ *
+ *************************************************************************=
*****/
+
+acpi_status
+acpi_tb_check_duplication(struct acpi_table_desc *table_desc, u32 *table_i=
ndex)
+{
+       u32 i;
+
+       ACPI_FUNCTION_TRACE(tb_check_duplication);
+
+       /* Check if table is already registered */
+
+       for (i =3D 0; i < acpi_gbl_root_table_list.current_table_count; ++i=
) {
+               /*
+                * Check for a table match on the entire table length,
+                * not just the header.
+                */
+               if (!acpi_tb_compare_tables(table_desc, i)) {
+                       continue;
+               }
+
+               /*
+                * Note: the current mechanism does not unregister a table =
if it is
+                * dynamically unloaded. The related namespace entries are =
deleted,
+                * but the table remains in the root table list.
+                *
+                * The assumption here is that the number of different tabl=
es that
+                * will be loaded is actually small, and there is minimal o=
verhead
+                * in just keeping the table in case it is needed again.
+                *
+                * If this assumption changes in the future (perhaps on lar=
ge
+                * machines with many table load/unload operations), tables=
 will
+                * need to be unregistered when they are unloaded, and slot=
s in the
+                * root table list should be reused when empty.
+                */
+               if (acpi_gbl_root_table_list.tables[i].flags &
+                   ACPI_TABLE_IS_LOADED) {
+
+                       /* Table is still loaded, this is an error */
+
+                       return_ACPI_STATUS(AE_ALREADY_EXISTS);
+               } else {
+                       *table_index =3D i;
+                       return_ACPI_STATUS(AE_CTRL_TERMINATE);
+               }
+       }
+
+       /* Indicate no duplication to the caller */
+
+       return_ACPI_STATUS(AE_OK);
+}
+
 /*************************************************************************=
*****
  *
  * FUNCTION:    acpi_tb_verify_temp_table
  *
  * PARAMETERS:  table_desc          - Table descriptor
  *              signature           - Table signature to verify
+ *              table_index         - Where the table index is returned
  *
  * RETURN:      Status
  *
@@ -369,7 +487,8 @@ acpi_status acpi_tb_validate_temp_table(struct acpi_tab=
le_desc *table_desc)
  *************************************************************************=
****/

 acpi_status
-acpi_tb_verify_temp_table(struct acpi_table_desc *table_desc, char *signat=
ure)
+acpi_tb_verify_temp_table(struct acpi_table_desc *table_desc,
+                         char *signature, u32 *table_index)
 {
         acpi_status status =3D AE_OK;

@@ -392,9 +511,10 @@ acpi_tb_verify_temp_table(struct acpi_table_desc *tabl=
e_desc, char *signature)
                 goto invalidate_and_exit;
         }

-       /* Verify the checksum */
-
         if (acpi_gbl_enable_table_validation) {
+
+               /* Verify the checksum */
+
                 status =3D
                     acpi_tb_verify_checksum(table_desc->pointer,
                                             table_desc->length);
@@ -411,9 +531,29 @@ acpi_tb_verify_temp_table(struct acpi_table_desc *tabl=
e_desc, char *signature)

                         goto invalidate_and_exit;
                 }
+
+               /* Avoid duplications */
+
+               if (table_index) {
+                       status =3D
+                           acpi_tb_check_duplication(table_desc, table_ind=
ex);
+                       if (ACPI_FAILURE(status) && status !=3D AE_CTRL_TER=
MINATE) {
+                               ACPI_EXCEPTION((AE_INFO, AE_NO_MEMORY,
+                                               "%4.4s 0x%8.8X%8.8X"
+                                               " Table is duplicated",
+                                               acpi_ut_valid_nameseg
+                                               (table_desc->signature.
+                                                ascii) ? table_desc->signa=
ture.
+                                               ascii : "????",
+                                               ACPI_FORMAT_UINT64(table_de=
sc->
+                                                                  address)=
));
+
+                               goto invalidate_and_exit;
+                       }
+               }
         }

-       return_ACPI_STATUS(AE_OK);
+       return_ACPI_STATUS(status);

 invalidate_and_exit:
         acpi_tb_invalidate_table(table_desc);
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index f7bc362..9404801 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -48,54 +48,6 @@
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbinstal")

-/* Local prototypes */
-static u8
-acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index=
);
-
-/*************************************************************************=
******
- *
- * FUNCTION:    acpi_tb_compare_tables
- *
- * PARAMETERS:  table_desc          - Table 1 descriptor to be compared
- *              table_index         - Index of table 2 to be compared
- *
- * RETURN:      TRUE if both tables are identical.
- *
- * DESCRIPTION: This function compares a table with another table that has
- *              already been installed in the root table list.
- *
- *************************************************************************=
*****/
-
-static u8
-acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index)
-{
-       acpi_status status =3D AE_OK;
-       u8 is_identical;
-       struct acpi_table_header *table;
-       u32 table_length;
-       u8 table_flags;
-
-       status =3D
-           acpi_tb_acquire_table(&acpi_gbl_root_table_list.tables[table_in=
dex],
-                                 &table, &table_length, &table_flags);
-       if (ACPI_FAILURE(status)) {
-               return (FALSE);
-       }
-
-       /*
-        * Check for a table match on the entire table length,
-        * not just the header.
-        */
-       is_identical =3D (u8)((table_desc->length !=3D table_length ||
-                            memcmp(table_desc->pointer, table, table_lengt=
h)) ?
-                           FALSE : TRUE);
-
-       /* Release the acquired table */
-
-       acpi_tb_release_table(table, table_length, table_flags);
-       return (is_identical);
-}
-
 /*************************************************************************=
******
  *
  * FUNCTION:    acpi_tb_install_table_with_override
@@ -112,7 +64,6 @@ acpi_tb_compare_tables(struct acpi_table_desc *table_des=
c, u32 table_index)
  *              table array.
  *
  *************************************************************************=
*****/
-
 void
 acpi_tb_install_table_with_override(struct acpi_table_desc *new_table_desc,
                                     u8 override, u32 *table_index)
@@ -210,67 +161,28 @@ acpi_tb_install_standard_table(acpi_physical_address =
address,
                 goto release_and_exit;
         }

-       /* Validate and verify a table before installation */
-
-       status =3D acpi_tb_verify_temp_table(&new_table_desc, NULL);
-       if (ACPI_FAILURE(status)) {
-               goto release_and_exit;
-       }
-
         /* Acquire the table lock */

         (void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);

-       if (acpi_gbl_enable_table_validation) {
-
-               /* Check if table is already registered */
-
-               for (i =3D 0; i < acpi_gbl_root_table_list.current_table_co=
unt;
-                    ++i) {
-                       /*
-                        * Check for a table match on the entire table leng=
th,
-                        * not just the header.
-                        */
-                       if (!acpi_tb_compare_tables(&new_table_desc, i)) {
-                               continue;
-                       }
+       /* Validate and verify a table before installation */

+       status =3D acpi_tb_verify_temp_table(&new_table_desc, NULL, &i);
+       if (ACPI_FAILURE(status)) {
+               if (status =3D=3D AE_CTRL_TERMINATE) {
                         /*
-                        * Note: the current mechanism does not unregister =
a table if it is
-                        * dynamically unloaded. The related namespace entr=
ies are deleted,
-                        * but the table remains in the root table list.
-                        *
-                        * The assumption here is that the number of differ=
ent tables that
-                        * will be loaded is actually small, and there is m=
inimal overhead
-                        * in just keeping the table in case it is needed a=
gain.
-                        *
-                        * If this assumption changes in the future (perhap=
s on large
-                        * machines with many table load/unload operations)=
, tables will
-                        * need to be unregistered when they are unloaded, =
and slots in the
-                        * root table list should be reused when empty.
+                        * Table was unloaded, allow it to be reloaded.
+                        * As we are going to return AE_OK to the caller, w=
e should
+                        * take the responsibility of freeing the input des=
criptor.
+                        * Refill the input descriptor to ensure
+                        * acpi_tb_install_table_with_override() can be cal=
led again to
+                        * indicate the re-installation.
                          */
-                       if (acpi_gbl_root_table_list.tables[i].flags &
-                           ACPI_TABLE_IS_LOADED) {
-
-                               /* Table is still loaded, this is an error =
*/
-
-                               status =3D AE_ALREADY_EXISTS;
-                               goto unlock_and_exit;
-                       } else {
-                               /*
-                                * Table was unloaded, allow it to be reloa=
ded.
-                                * As we are going to return AE_OK to the c=
aller, we should
-                                * take the responsibility of freeing the i=
nput descriptor.
-                                * Refill the input descriptor to ensure
-                                * acpi_tb_install_table_with_override() ca=
n be called again to
-                                * indicate the re-installation.
-                                */
-                               acpi_tb_uninstall_table(&new_table_desc);
-                               (void)acpi_ut_release_mutex(ACPI_MTX_TABLES=
);
-                               *table_index =3D i;
-                               return_ACPI_STATUS(AE_OK);
-                       }
+                       acpi_tb_uninstall_table(&new_table_desc);
+                       (void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
+                       return_ACPI_STATUS(AE_OK);
                 }
+               goto unlock_and_exit;
         }

         /* Add the table to the global root table list */
@@ -350,9 +262,11 @@ void acpi_tb_override_table(struct acpi_table_desc *ol=
d_table_desc)

 finish_override:

-       /* Validate and verify a table before overriding */
-
-       status =3D acpi_tb_verify_temp_table(&new_table_desc, NULL);
+       /*
+        * Validate and verify a table before overriding, no nested table
+        * duplication check as it's too complicated and unnecessary.
+        */
+       status =3D acpi_tb_verify_temp_table(&new_table_desc, NULL, NULL);
         if (ACPI_FAILURE(status)) {
                 return;
         }
--
2.7.4



------------------------------

Subject: Digest Footer

_______________________________________________
Devel mailing list
Devel(a)acpica.org
https://lists.acpica.org/mailman/listinfo/devel

------------------------------

End of Devel Digest, Vol 77, Issue 2
************************************
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

--===============0590618997345510755==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRl
eHQvaHRtbDsgY2hhcnNldD11cy1hc2NpaSI+CjxtZXRhIG5hbWU9IkdlbmVyYXRvciIgY29udGVu
dD0iTWljcm9zb2Z0IEV4Y2hhbmdlIFNlcnZlciI+CjwhLS0gY29udmVydGVkIGZyb20gdGV4dCAt
LT48c3R5bGU+PCEtLSAuRW1haWxRdW90ZSB7IG1hcmdpbi1sZWZ0OiAxcHQ7IHBhZGRpbmctbGVm
dDogNHB0OyBib3JkZXItbGVmdDogIzgwMDAwMCAycHggc29saWQ7IH0gLS0+PC9zdHlsZT4KPC9o
ZWFkPgo8Ym9keT4KPG1ldGEgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PVVURi04Ij4KPHN0
eWxlIHR5cGU9InRleHQvY3NzIiBzdHlsZT0iIj4KPCEtLQpwCgl7bWFyZ2luLXRvcDowOwoJbWFy
Z2luLWJvdHRvbTowfQotLT4KPC9zdHlsZT4KPGRpdiBkaXI9Imx0ciI+CjxkaXYgaWQ9InhfZGl2
dGFnZGVmYXVsdHdyYXBwZXIiIGRpcj0ibHRyIiBzdHlsZT0iZm9udC1zaXplOjEycHQ7IGNvbG9y
OiMwMDAwMDA7IGZvbnQtZmFtaWx5OkNhbGlicmksQXJpYWwsSGVsdmV0aWNhLHNhbnMtc2VyaWYi
Pgo8cD48Zm9udCBzaXplPSIyIj5SZTogW1BBVENIXSBBQ1BJOiBTUENSOiBVc2UgYWNjZXNzIHdp
ZHRoIHRvIGRldGVybWluZSBtbWlvPGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
dXNhZ2UgKFpoZW5nLCBMdik8L2ZvbnQ+PGJyPgo8L3A+CjxwPjxicj4KPC9wPgo8cD5IaSBaaGVu
Zyw8L3A+CjxwPjxicj4KPC9wPgo8cD48Zm9udCBzaXplPSIyIj4mZ3Q7ICYjNDM7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IHN3aXRjaCAodGFibGUtJmd0O3NlcmlhbF9wb3J0LmFjY2Vzc193aWR0aCkgezxicj4K
Jmd0OyAmIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBkZWZhdWx0Ojxicj4KJmd0OyAmIzQzOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBw
cl9lcnIoJnF1b3Q7VW5leHBlY3RlZCBTUENSIEFjY2VzcyBXaWR0aC4mbmJzcDsgRGVmYXVsdGlu
ZyB0byBieXRlIHNpemVcbiZxdW90Oyk7PGJyPgomZ3Q7ICYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGNh
c2UgQUNQSV9BQ0NFU1NfU0laRV9CWVRFOjxicj4KJmd0OyAmIzQzOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBpb3R5cGUgPSAm
cXVvdDttbWlvJnF1b3Q7Ozxicj4KJmd0OyAmIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBicmVhazs8YnI+CiZndDsgJiM0
MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgY2FzZSBBQ1BJX0FDQ0VTU19TSVpFX1dPUkQ6PGJyPgomZ3Q7ICYj
NDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IGlvdHlwZSA9ICZxdW90O21taW8xNiZxdW90Ozs8YnI+CiZndDsgJiM0MzsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgYnJlYWs7PGJyPgomZ3Q7ICYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGNhc2UgQUNQSV9BQ0NFU1Nf
U0laRV9EV09SRDo8YnI+CiZndDsgJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaW90eXBlID0gJnF1b3Q7bW1pbzMyJnF1
b3Q7Ozxicj4KJmd0OyAmIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBicmVhazs8YnI+CiZndDsgJiM0MzsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgfTxicj4KJmd0OyAmIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB9IGVsc2U8YnI+
CiZndDsgJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaW90eXBlID0gJnF1b3Q7aW8mcXVvdDs7PC9mb250
Pjxicj4KPC9wPgo8cD48YnI+CjwvcD4KPHA+V2h5IHRoZXJlJ3Mgbm8gY29kZSBmb3IgPGZvbnQg
c2l6ZT0iMiI+QUNQSV9BQ0NFU1NfU0laRV9RV09SRD88L2ZvbnQ+PC9wPgo8cD48Zm9udCBzaXpl
PSIyIj48YnI+CjwvZm9udD48L3A+CjxwPjxzcGFuPlJlZ2FyZHMsPC9zcGFuPjwvcD4KPHA+PHNw
YW4+QWxleGVpLjwvc3Bhbj48L3A+CjxwPjxicj4KPC9wPgo8L2Rpdj4KPGhyIHRhYmluZGV4PSIt
MSIgc3R5bGU9ImRpc3BsYXk6aW5saW5lLWJsb2NrOyB3aWR0aDo5OCUiPgo8ZGl2IGlkPSJ4X2Rp
dlJwbHlGd2RNc2ciIGRpcj0ibHRyIj48Zm9udCBmYWNlPSJDYWxpYnJpLCBzYW5zLXNlcmlmIiBj
b2xvcj0iIzAwMDAwMCIgc3R5bGU9ImZvbnQtc2l6ZToxMXB0Ij48Yj5Gcm9tOjwvYj4gRGV2ZWwg
Jmx0O2RldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyZndDsgb24gYmVoYWxmIG9mIGRldmVsLXJlcXVl
c3RAYWNwaWNhLm9yZyAmbHQ7ZGV2ZWwtcmVxdWVzdEBhY3BpY2Eub3JnJmd0Ozxicj4KPGI+U2Vu
dDo8L2I+IDE2IE1heSAyMDE3IDA4OjEzOjUzPGJyPgo8Yj5Ubzo8L2I+IGRldmVsQGFjcGljYS5v
cmc8YnI+CjxiPlN1YmplY3Q6PC9iPiBEZXZlbCBEaWdlc3QsIFZvbCA3NywgSXNzdWUgMjwvZm9u
dD4KPGRpdj4mbmJzcDs8L2Rpdj4KPC9kaXY+CjwvZGl2Pgo8Zm9udCBzaXplPSIyIj48c3BhbiBz
dHlsZT0iZm9udC1zaXplOjEwcHQ7Ij4KPGRpdiBjbGFzcz0iUGxhaW5UZXh0Ij5TZW5kIERldmVs
IG1haWxpbmcgbGlzdCBzdWJtaXNzaW9ucyB0bzxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IGRldmVsQGFjcGljYS5vcmc8YnI+Cjxicj4KVG8gc3Vic2NyaWJl
IG9yIHVuc3Vic2NyaWJlIHZpYSB0aGUgV29ybGQgV2lkZSBXZWIsIHZpc2l0PGJyPgombmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgPGEgaHJlZj0iaHR0cHM6Ly9saXN0
cy5hY3BpY2Eub3JnL21haWxtYW4vbGlzdGluZm8vZGV2ZWwiPmh0dHBzOi8vbGlzdHMuYWNwaWNh
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RldmVsPC9hPjxicj4Kb3IsIHZpYSBlbWFpbCwgc2VuZCBh
IG1lc3NhZ2Ugd2l0aCBzdWJqZWN0IG9yIGJvZHkgJ2hlbHAnIHRvPGJyPgombmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZGV2ZWwtcmVxdWVzdEBhY3BpY2Eub3JnPGJy
Pgo8YnI+CllvdSBjYW4gcmVhY2ggdGhlIHBlcnNvbiBtYW5hZ2luZyB0aGUgbGlzdCBhdDxicj4K
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGRldmVsLW93bmVyQGFj
cGljYS5vcmc8YnI+Cjxicj4KV2hlbiByZXBseWluZywgcGxlYXNlIGVkaXQgeW91ciBTdWJqZWN0
IGxpbmUgc28gaXQgaXMgbW9yZSBzcGVjaWZpYzxicj4KdGhhbiAmcXVvdDtSZTogQ29udGVudHMg
b2YgRGV2ZWwgZGlnZXN0Li4uJnF1b3Q7PGJyPgo8YnI+Cjxicj4KVG9kYXkncyBUb3BpY3M6PGJy
Pgo8YnI+CiZuYnNwOyZuYnNwOyAxLiBSZTogW1BBVENIXSBBQ1BJOiBTUENSOiBVc2UgYWNjZXNz
IHdpZHRoIHRvIGRldGVybWluZSBtbWlvPGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgdXNhZ2UgKFpoZW5nLCBMdik8YnI+CiZuYnNwOyZuYnNwOyAyLiBbUkZDIFBBVENIIHYyIDAv
NV0gQUNQSUNBOiBUYWJsZXM6IEFkZCBkZWZlcnJlZCB2ZXJpZmljYXRpb248YnI+CiZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBzdXBwb3J0IChMdiBaaGVuZyk8YnI+CiZuYnNwOyZuYnNw
OyAzLiBbUkZDIFBBVENIIHYyIDEvNV0gQUNQSUNBOiBUYWJsZXM6IENsZWFudXAgdGFibGUgaGFu
ZGxlcjxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGludm9rZXJzIChMdiBaaGVu
Zyk8YnI+CiZuYnNwOyZuYnNwOyA0LiBbUkZDIFBBVENIIHYyIDIvNV0gQUNQSUNBOiBUYWJsZXM6
IERvIG5vdCB2YWxpZGF0ZSBzaWduYXR1cmU8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyBmb3IgZHluYW1pYyB0YWJsZSBsb2FkIChMdiBaaGVuZyk8YnI+CiZuYnNwOyZuYnNwOyA1
LiBbUkZDIFBBVENIIHYyIDMvNV0gQUNQSUNBOiBUYWJsZXM6IENoYW5nZSB0YWJsZSBkdXBsaWNh
dGlvbjxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGNoZWNrIHRvIGJlIHJlbGF0
ZWQgdG8gYWNwaV9nYmxfdmVyaWZ5X3RhYmxlX2NoZWNrc3VtIChMdiBaaGVuZyk8YnI+CiZuYnNw
OyZuYnNwOyA2LiBbUkZDIFBBVENIIHYyIDQvNV0gQUNQSUNBOiBUYWJsZXM6IENvbWJpbmU8YnI+
CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBjaGVja3N1bS9kdXBsaWNhdGlvbiB2ZXJp
ZmljYXRpb24gdG9nZXRoZXIgKEx2IFpoZW5nKTxicj4KPGJyPgo8YnI+Ci0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08
YnI+Cjxicj4KTWVzc2FnZTogMTxicj4KRGF0ZTogRnJpLCA1IE1heSAyMDE3IDAzOjA5OjM0ICYj
NDM7MDAwMDxicj4KRnJvbTogJnF1b3Q7WmhlbmcsIEx2JnF1b3Q7ICZsdDtsdi56aGVuZ0BpbnRl
bC5jb20mZ3Q7PGJyPgpUbzogSm9uIE1hc29uICZsdDtqb24ubWFzb25AYnJvYWRjb20uY29tJmd0
OywgUmFmYWVsIFd5c29ja2k8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyAmbHQ7cmp3QHJqd3lzb2NraS5uZXQmZ3Q7LCBMZW4gQnJvd24gJmx0O2xlbmJAa2Vy
bmVsLm9yZyZndDssICZxdW90O01vb3JlLCBSb2JlcnQmcXVvdDs8YnI+CiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAmbHQ7cm9iZXJ0Lm1vb3JlQGludGVsLmNvbSZn
dDs8YnI+CkNjOiAmcXVvdDtsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZyZxdW90OyAmbHQ7bGlu
dXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmcmZ3Q7LDxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZxdW90O2xpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcmcXVv
dDsgJmx0O2xpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcmZ3Q7LDxicj4KJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZxdW90O2RldmVsQGFjcGljYS5vcmcmcXVv
dDsgJmx0O2RldmVsQGFjcGljYS5vcmcmZ3Q7LDxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZxdW90O2JjbS1rZXJuZWwtZmVlZGJhY2stbGlzdEBicm9hZGNv
bS5jb20mcXVvdDs8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyAmbHQ7YmNtLWtlcm5lbC1mZWVkYmFjay1saXN0QGJyb2FkY29tLmNvbSZndDs8YnI+ClN1Ympl
Y3Q6IFJlOiBbRGV2ZWxdIFtQQVRDSF0gQUNQSTogU1BDUjogVXNlIGFjY2VzcyB3aWR0aCB0byBk
ZXRlcm1pbmU8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBt
bWlvIHVzYWdlPGJyPgpNZXNzYWdlLUlEOjxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7ICZsdDsxQUU2NDA4MTNGREU3NjQ5QkUxQjE5M0RFQTU5NkU4ODZDRTlE
Q0JDQFNIU01TWDEwMS5jY3IuY29ycC5pbnRlbC5jb20mZ3Q7PGJyPgombmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgPGJyPgpDb250ZW50LVR5cGU6IHRleHQvcGxhaW47
IGNoYXJzZXQ9JnF1b3Q7Z2IyMzEyJnF1b3Q7PGJyPgo8YnI+CkhpLDxicj4KPGJyPgomZ3Q7IEZy
b206IEpvbiBNYXNvbiBbPGEgaHJlZj0ibWFpbHRvOmpvbi5tYXNvbkBicm9hZGNvbS5jb20iPm1h
aWx0bzpqb24ubWFzb25AYnJvYWRjb20uY29tPC9hPl08YnI+CiZndDsgU2VudDogVGh1cnNkYXks
IE1heSA0LCAyMDE3IDExOjA2IFBNPGJyPgomZ3Q7IFN1YmplY3Q6IFtQQVRDSF0gQUNQSTogU1BD
UjogVXNlIGFjY2VzcyB3aWR0aCB0byBkZXRlcm1pbmUgbW1pbyB1c2FnZTxicj4KJmd0OyA8YnI+
CiZndDsgVGhlIGN1cnJlbnQgU1BDUiBjb2RlIGRvZXMgbm90IGNoZWNrIHRoZSBhY2Nlc3Mgd2lk
dGggb2YgdGhlIG1taW8sIGFuZDxicj4KJmd0OyB1c2VzIGEgZGVmYXVsdCBvZiA4Yml0IHJlZ2lz
dGVyIGFjY2Vzc2VzLiZuYnNwOyBUaGlzIHByZXZlbnRzIGRldmljZXMgdGhhdDxicj4KJmd0OyBv
bmx5IGRvIDE2IG9yIDMyYml0IHJlZ2lzdGVyIGFjY2Vzc2VzIGZyb20gd29ya2luZy4mbmJzcDsg
Qnkgc2ltcGx5IGNoZWNraW5nPGJyPgomZ3Q7IHRoaXMgZmllbGQgYW5kIHNldHRpbmcgdGhlIG1t
aW8gc3RyaW5nIGFwcHJvcHJpYXRlbHksIHRoaXMgaXNzdWUgY2FuIGJlPGJyPgomZ3Q7IGNvcnJl
Y3RlZC4mbmJzcDsgVG8gcHJldmVudCBhbnkgbGVnYWN5IGlzc3VlcywgdGhlIGNvZGUgd2lsbCBk
ZWZhdWx0IHRvIDhiaXQ8YnI+CiZndDsgYWNjZXNzZXMgaWYgdGhlIHZhbHVlIGlzIGFueXRoaW5n
IGJ1dCAxNiBvciAzMi48YnI+CiZndDsgPGJyPgomZ3Q7IFNpZ25lZC1vZmYtYnk6IEpvbiBNYXNv
biAmbHQ7am9uLm1hc29uQGJyb2FkY29tLmNvbSZndDs8YnI+CiZndDsgLS0tPGJyPgomZ3Q7Jm5i
c3A7IGRyaXZlcnMvYWNwaS9zcGNyLmMmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfCAxOCAmIzQz
OyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0Mzsm
IzQzOyYjNDM7JiM0MzsmIzQzOy0tPGJyPgomZ3Q7Jm5ic3A7IGluY2x1ZGUvYWNwaS9hY3Jlc3R5
cC5oIHwmbmJzcDsgNyAmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOzxicj4KJmd0
OyZuYnNwOyAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoJiM0MzspLCAyIGRlbGV0aW9u
cygtKTxicj4KJmd0OyA8YnI+CiZndDsgZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9zcGNyLmMg
Yi9kcml2ZXJzL2FjcGkvc3Bjci5jPGJyPgomZ3Q7IGluZGV4IDAxYzk0NjYuLjExMjMzZjYgMTAw
NjQ0PGJyPgomZ3Q7IC0tLSBhL2RyaXZlcnMvYWNwaS9zcGNyLmM8YnI+CiZndDsgJiM0MzsmIzQz
OyYjNDM7IGIvZHJpdmVycy9hY3BpL3NwY3IuYzxicj4KJmd0OyBAQCAtNzQsOCAmIzQzOzc0LDIy
IEBAIGludCBfX2luaXQgcGFyc2Vfc3Bjcihib29sIGVhcmx5Y29uKTxicj4KJmd0OyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBnb3RvIGRvbmU7PGJyPgomZ3Q7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08YnI+CiZndDsgPGJyPgomZ3Q7IC0mbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgaW90eXBlID0gdGFibGUtJmd0O3NlcmlhbF9wb3J0LnNwYWNl
X2lkID09IEFDUElfQURSX1NQQUNFX1NZU1RFTV9NRU1PUlkgPzxicj4KJmd0OyAtJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZx
dW90O21taW8mcXVvdDsgOiAmcXVvdDtpbyZxdW90Ozs8YnI+CiZndDsgJiM0MzsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgaWYgKHRhYmxlLSZndDtzZXJpYWxfcG9ydC5zcGFjZV9pZCA9PSBBQ1BJ
X0FEUl9TUEFDRV9TWVNURU1fTUVNT1JZKSB7PGJyPgomZ3Q7ICYjNDM7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IHN3aXRjaCAodGFibGUtJmd0O3NlcmlhbF9wb3J0LmFjY2Vzc193aWR0aCkgezxicj4KJmd0OyAm
IzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyBkZWZhdWx0Ojxicj4KJmd0OyAmIzQzOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBwcl9lcnIo
JnF1b3Q7VW5leHBlY3RlZCBTUENSIEFjY2VzcyBXaWR0aC4mbmJzcDsgRGVmYXVsdGluZyB0byBi
eXRlIHNpemVcbiZxdW90Oyk7PGJyPgomZ3Q7ICYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGNhc2UgQUNQ
SV9BQ0NFU1NfU0laRV9CWVRFOjxicj4KJmd0OyAmIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBpb3R5cGUgPSAmcXVvdDtt
bWlvJnF1b3Q7Ozxicj4KJmd0OyAmIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBicmVhazs8YnI+CiZndDsgJiM0MzsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgY2FzZSBBQ1BJX0FDQ0VTU19TSVpFX1dPUkQ6PGJyPgomZ3Q7ICYjNDM7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IGlvdHlwZSA9ICZxdW90O21taW8xNiZxdW90Ozs8YnI+CiZndDsgJiM0MzsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgYnJl
YWs7PGJyPgomZ3Q7ICYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGNhc2UgQUNQSV9BQ0NFU1NfU0laRV9E
V09SRDo8YnI+CiZndDsgJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaW90eXBlID0gJnF1b3Q7bW1pbzMyJnF1b3Q7Ozxi
cj4KJmd0OyAmIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyBicmVhazs8YnI+CiZndDsgJiM0MzsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
fTxicj4KJmd0OyAmIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB9IGVsc2U8YnI+CiZndDsg
JiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgaW90eXBlID0gJnF1b3Q7aW8mcXVvdDs7PGJyPgomZ3Q7IDxi
cj4KJmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBzd2l0Y2gg
KHRhYmxlLSZndDtpbnRlcmZhY2VfdHlwZSkgezxicj4KJmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBjYXNlIEFDUElfREJHMl9BUk1fU0JTQV8zMkJJVDo8YnI+
CiZndDsgZGlmZiAtLWdpdCBhL2luY2x1ZGUvYWNwaS9hY3Jlc3R5cC5oIGIvaW5jbHVkZS9hY3Bp
L2FjcmVzdHlwLmg8YnI+CiZndDsgaW5kZXggZjBmNzQwMy4uNzgxY2I1NSAxMDA2NDQ8YnI+CiZn
dDsgLS0tIGEvaW5jbHVkZS9hY3BpL2FjcmVzdHlwLmg8YnI+CiZndDsgJiM0MzsmIzQzOyYjNDM7
IGIvaW5jbHVkZS9hY3BpL2FjcmVzdHlwLmg8YnI+CiZndDsgQEAgLTM3Miw2ICYjNDM7MzcyLDEz
IEBAIHN0cnVjdCBhY3BpX3Jlc291cmNlX2dlbmVyaWNfcmVnaXN0ZXIgezxicj4KJmd0OyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB1NjQgYWRkcmVzczs8YnI+CiZn
dDsmbmJzcDsgfTs8YnI+CiZndDsgPGJyPgomZ3Q7ICYjNDM7LyogR2VuZXJpYyBBZGRyZXNzIFNw
YWNlIEFjY2VzcyBTaXplcyAqLzxicj4KJmd0OyAmIzQzOyNkZWZpbmUgQUNQSV9BQ0NFU1NfU0la
RV9VTkRFRklORUQmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgMDxicj4KJmd0OyAmIzQzOyNkZWZpbmUgQUNQSV9BQ0NFU1NfU0laRV9C
WVRFJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDE8YnI+CiZndDsgJiM0MzsjZGVmaW5lIEFDUElf
QUNDRVNTX1NJWkVfV09SRCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAyPGJyPgomZ3Q7ICYjNDM7
I2RlZmluZSBBQ1BJX0FDQ0VTU19TSVpFX0RXT1JEJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDM8YnI+CiZn
dDsgJiM0MzsjZGVmaW5lIEFDUElfQUNDRVNTX1NJWkVfUVdPUkQmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
NDxicj4KJmd0OyAmIzQzOzxicj4KJmd0OyZuYnNwOyBzdHJ1Y3QgYWNwaV9yZXNvdXJjZV9ncGlv
IHs8YnI+CiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgdTgg
cmV2aXNpb25faWQ7PGJyPgomZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IHU4IGNvbm5lY3Rpb25fdHlwZTs8YnI+Cjxicj4KUGxlYXNlIGRvbid0IGRlZmluZSB0
aGlzLjxicj4KSXQncyBwb3NzaWJsZSB0byBjYWxjdWxhdGUgOC8xNi8zMi82NCBmcm9tIHRoZSBh
Y2Nlc3Mgd2lkdGggdmFsdWUuPGJyPgpUcnk6PGJyPgoxICZsdDsmbHQ7IChhY2Nlc3Nfd2lkdGgg
JiM0MzsgMj88YnI+Cjxicj4KVGhhbmtzPGJyPgpMdjxicj4KPGJyPgo8YnI+Ci0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLTxicj4KPGJyPgpNZXNzYWdlOiAyPGJyPgpEYXRlOiBUdWUsIDE2
IE1heSAyMDE3IDE1OjEzOjA4ICYjNDM7MDgwMDxicj4KRnJvbTogTHYgWmhlbmcgJmx0O2x2Lnpo
ZW5nQGludGVsLmNvbSZndDs8YnI+ClRvOiAmcXVvdDtSYWZhZWwgSiAuIFd5c29ja2kmcXVvdDsg
Jmx0O3JhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tJmd0OywgTGVuIEJyb3duPGJyPgombmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJmx0O2xlbi5icm93bkBpbnRlbC5j
b20mZ3Q7LCBSb2JlcnQgTW9vcmUgJmx0O3JvYmVydC5tb29yZUBpbnRlbC5jb20mZ3Q7LCBMdiBa
aGVuZzxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZsdDts
di56aGVuZ0BpbnRlbC5jb20mZ3Q7LCAmcXVvdDtEYXZpZCBFIC4gQm94JnF1b3Q7ICZsdDtkYXZp
ZC5lLmJveEBpbnRlbC5jb20mZ3Q7PGJyPgpDYzogTHYgWmhlbmcgJmx0O3pldGFsb2dAZ21haWwu
Y29tJmd0OywgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmcsPGJyPgombmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZGV2ZWxAYWNwaWNhLm9yZywgSGFucyBkZSBHb2Vk
ZSAmbHQ7aGRlZ29lZGVAcmVkaGF0LmNvbSZndDs8YnI+ClN1YmplY3Q6IFtEZXZlbF0gW1JGQyBQ
QVRDSCB2MiAwLzVdIEFDUElDQTogVGFibGVzOiBBZGQgZGVmZXJyZWQ8YnI+CiZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB2ZXJpZmljYXRpb24gc3VwcG9ydDxicj4K
TWVzc2FnZS1JRDogJmx0O2NvdmVyLjE0OTQ5MTY3NjYuZ2l0Lmx2LnpoZW5nQGludGVsLmNvbSZn
dDs8YnI+Cjxicj4KT24gbGludXgsIHdlIGNhbiBub3QgdmVyaWZ5IEFDUEkgdGFibGVzIGJlZm9y
ZSBpbnN0YWxsaW5nIHRoZW0gaW50byB0aGU8YnI+Cmdsb2JhbCB0YWJsZSBsaXN0IGluIGVhcmx5
IHN0YWdlIGR1ZSB0byB0aGUgbnVtYmVyIG9mIHNsb3QgbGltaXRhdGlvbnMgZm9yPGJyPgplYXJs
eSBpb3JlbWFwLiBUaGlzIGxlYXZlcyBhIHByb2JsZW0gdGhhdCB3ZSBjYW5ub3QgZGV0ZWN0IGR1
cGxpY2F0ZWQ8YnI+CnRhYmxlcyBpbiBlYXJseSBzdGFnZSwgY2F1c2luZyB1bndhbnRlZCBlcnJv
ciBtZXNzYWdlcyBzZWVuIHdoZW4gdGhlPGJyPgpkdXBsaWNhdGVkIHRhYmxlcyBhcmUgZmFpbGVk
IHRvIGJlIGxvYWRlZCBbbGluayAjMV0uPGJyPgo8YnI+ClRoaXMgcGF0Y2hzZXQgYXMgQUNQSUNB
IFBSIFtsaW5rICMyXSBhZGRzIHN1cHBvcnQgdG8gdmVyaWZ5IHRhYmxlcyBpbjxicj4KYWNwaV9y
ZWFsbG9jYXRlX3Jvb3RfdGFibGVzKCkgd2hpY2ggaXMgaW52b2tlZCBhZnRlciBpbnN0YWxsaW5n
IHRhYmxlcyBpbjxicj4KZWFybHkgc3RhZ2UsIGJlaW5nIHJlYWR5IGZvciBsYXRlIGlvcmVtYXAg
YW5kIGJlb2ZyZSBsb2FkaW5nIHRhYmxlIGluIGxhdGU8YnI+CnN0YWdlLiBJZiBkdXBsaWNhdGVk
IHRhYmxlcyBhcmUgZGV0ZWN0ZWQsIGFjcGlfcmVhbGxvY2F0ZV9yb290X3RhYmxlcygpPGJyPgpz
dG9wcyBpbnN0YWxsaW5nIHRoZW0gdG8gdGhlIGZpbmFsIHJlYWxsb2NhdGVkIGdsb2JhbCB0YWJs
ZSBsaXN0Ljxicj4KPGJyPgpJbiB2MSBwYXRjaHNldCBbbGluayAjM10sIHByb2JsZW1zIGNhbiBi
ZSBzZWVuIGZvciBkeW5hbWljIGxvYWRpbmcgdGFibGVzPGJyPgp3aGljaCBhcmUgYWxsb2NhdGVk
IGFzIHZpcnR1YWxsIGFsbG9jYXRlZCB0YWJsZXMuIFN1Y2ggdGFibGVzIGFyZTxicj4KaW5jcmVt
ZW50ZWQgaW4gdGhlIGdsb2JhbCB0YWJsZSBsaXN0IGFzIHRoZSBzYW5pdHkgY2hlY2sgZG9uZSBp
biBpbnN0YWxsPGJyPgpzdGVwIG9ubHkgY29tcGFyZXMgdGhlIHRhYmxlIGFkZHJlc3NlcyB3aGls
ZSB0aGUgdmlydHVhbCBhbGxvY2F0ZWQ8YnI+CmFkZHJlc3NlcyBhcmUgbm90IHN0YWJsZS48YnI+
CkluIHYyIHBhdGNoc2V0LCB3ZSBmb2xsb3cgb3JpZ2luYWwgZGVzaWduIGRpc2N1c3Npb24gbWFk
ZSBpbiBBQ1BJQ0EgZGV2ZWw8YnI+Cm1haWxpbmcgbGlzdCwgaW1wbGVtZW50cyBkZWZlcnJlZCB0
YWJsZSB2ZXJpZmljYXRpb24gc28gdGhhdCBkdXBsaWNhdGU8YnI+CnRhYmxlcyBhcmUgc3RpbGwg
Y2FuIGJlIGRldGVjdGVkIGluIGluc3RhbGwgc3RlcCByYXRoZXIgdGhhbiBpbiBsb2FkIHN0ZXAu
PGJyPgpBbHNvIHdlIHJlbW92ZWQgdGFibGUgc2lnbmF0dXJlIGNoZWNrIGFjY29yZGluZyB0byB2
ZXJpZmllZCB3aW5kb3dzPGJyPgpiZWhhdmlvciBbbGluayAjNF0gYW5kIHJlcG9ydGVkIGlzc3Vl
cyBbbGluayAjNV0uPGJyPgo8YnI+Ckxpbms6IDxhIGhyZWY9Imh0dHA6Ly93d3cuc3Bpbmljcy5u
ZXQvbGlzdHMvbGludXgtYWNwaS9tc2c3MjIxNS5odG1sIj5odHRwOi8vd3d3LnNwaW5pY3MubmV0
L2xpc3RzL2xpbnV4LWFjcGkvbXNnNzIyMTUuaHRtbDwvYT4gWyMxXTxicj4KTGluazogPGEgaHJl
Zj0iaHR0cHM6Ly9naXRodWIuY29tLy9hY3BpY2EvYWNwaWNhL3B1bGwvMjY1Ij5odHRwczovL2dp
dGh1Yi5jb20vL2FjcGljYS9hY3BpY2EvcHVsbC8yNjU8L2E+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IFsjMl08YnI+Ckxp
bms6IDxhIGhyZWY9Imh0dHA6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtYWNwaS9tc2c3
MjU4OS5odG1sIj5odHRwOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LWFjcGkvbXNnNzI1
ODkuaHRtbDwvYT4gWyMzXTxicj4KTGluazogPGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tLy9h
Y3BpY2EvYWNwaWNhL3B1bGwvMTIxIj5odHRwczovL2dpdGh1Yi5jb20vL2FjcGljYS9hY3BpY2Ev
cHVsbC8xMjE8L2E+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IFsjNF08YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyA8YSBocmVmPSJodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lk
PTExODYwMSI+aHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0xMTg2
MDE8L2E+Jm5ic3A7Jm5ic3A7Jm5ic3A7IFsjNV08YnI+Cjxicj4KTHYgWmhlbmcgKDUpOjxicj4K
Jm5ic3A7IEFDUElDQTogVGFibGVzOiBDbGVhbnVwIHRhYmxlIGhhbmRsZXIgaW52b2tlcnM8YnI+
CiZuYnNwOyBBQ1BJQ0E6IFRhYmxlczogRG8gbm90IHZhbGlkYXRlIHNpZ25hdHVyZSBmb3IgZHlu
YW1pYyB0YWJsZSBsb2FkPGJyPgombmJzcDsgQUNQSUNBOiBUYWJsZXM6IENoYW5nZSB0YWJsZSBk
dXBsaWNhdGlvbiBjaGVjayB0byBiZSByZWxhdGVkIHRvPGJyPgombmJzcDsmbmJzcDsmbmJzcDsg
YWNwaV9nYmxfdmVyaWZ5X3RhYmxlX2NoZWNrc3VtPGJyPgombmJzcDsgQUNQSUNBOiBUYWJsZXM6
IENvbWJpbmUgY2hlY2tzdW0vZHVwbGljYXRpb24gdmVyaWZpY2F0aW9uIHRvZ2V0aGVyPGJyPgom
bmJzcDsgQUNQSUNBOiBUYWJsZXM6IEFkZCBkZWZlcnJlZCB0YWJsZSB2ZXJpZmljYXRpb24gc3Vw
cG9ydDxicj4KPGJyPgombmJzcDtkcml2ZXJzL2FjcGkvYWNwaWNhL2FjdGFibGVzLmggfCZuYnNw
OyZuYnNwOyA1ICYjNDM7LTxicj4KJm5ic3A7ZHJpdmVycy9hY3BpL2FjcGljYS90YmRhdGEuYyZu
YnNwOyZuYnNwOyB8IDIyMiAmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7
JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYj
NDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQz
OyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzstLS0tLTxicj4KJm5ic3A7ZHJpdmVycy9hY3BpL2Fj
cGljYS90Ymluc3RhbC5jIHwgMTYxICYjNDM7JiM0MzsmIzQzOyYjNDM7LS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS08YnI+CiZuYnNwO2RyaXZlcnMvYWNwaS9hY3BpY2EvdGJ4ZmFjZS5jJm5ic3A7
IHwmbmJzcDsgMzYgJiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7LTxicj4KJm5ic3A7ZHJp
dmVycy9hY3BpL2FjcGljYS90YnhmbG9hZC5jIHwmbmJzcDsmbmJzcDsgMiAmIzQzOy08YnI+CiZu
YnNwO2RyaXZlcnMvYWNwaS9idXMuYyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB8Jm5ic3A7Jm5ic3A7IDMgLTxi
cj4KJm5ic3A7ZHJpdmVycy9hY3BpL3RhYmxlcy5jJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHwmbmJzcDsmbmJzcDsgNCAmIzQzOy08YnI+CiZu
YnNwO2luY2x1ZGUvYWNwaS9hY3BpeGYuaCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB8Jm5ic3A7IDE1ICYjNDM7LS08YnI+CiZuYnNwO2luY2x1
ZGUvYWNwaS9hY3RibC5oJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IHwmbmJzcDsmbmJzcDsgMSAmIzQzOzxicj4KJm5ic3A7OSBmaWxl
cyBjaGFuZ2VkLCAyNjYgaW5zZXJ0aW9ucygmIzQzOyksIDE4MyBkZWxldGlvbnMoLSk8YnI+Cjxi
cj4KLS0gPGJyPgoyLjcuNDxicj4KPGJyPgo8YnI+Cjxicj4KLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tPGJyPgo8YnI+Ck1lc3NhZ2U6IDM8YnI+CkRhdGU6IFR1ZSwgMTYgTWF5IDIwMTcg
MTU6MTM6MTcgJiM0MzswODAwPGJyPgpGcm9tOiBMdiBaaGVuZyAmbHQ7bHYuemhlbmdAaW50ZWwu
Y29tJmd0Ozxicj4KVG86ICZxdW90O1JhZmFlbCBKIC4gV3lzb2NraSZxdW90OyAmbHQ7cmFmYWVs
Lmoud3lzb2NraUBpbnRlbC5jb20mZ3Q7LCBMZW4gQnJvd248YnI+CiZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAmbHQ7bGVuLmJyb3duQGludGVsLmNvbSZndDssIFJv
YmVydCBNb29yZSAmbHQ7cm9iZXJ0Lm1vb3JlQGludGVsLmNvbSZndDssIEx2IFpoZW5nPGJyPgom
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJmx0O2x2LnpoZW5nQGlu
dGVsLmNvbSZndDssICZxdW90O0RhdmlkIEUgLiBCb3gmcXVvdDsgJmx0O2RhdmlkLmUuYm94QGlu
dGVsLmNvbSZndDs8YnI+CkNjOiBMdiBaaGVuZyAmbHQ7emV0YWxvZ0BnbWFpbC5jb20mZ3Q7LCBs
aW51eC1hY3BpQHZnZXIua2VybmVsLm9yZyw8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBkZXZlbEBhY3BpY2Eub3JnLCBIYW5zIGRlIEdvZWRlICZsdDtoZGVn
b2VkZUByZWRoYXQuY29tJmd0Ozxicj4KU3ViamVjdDogW0RldmVsXSBbUkZDIFBBVENIIHYyIDEv
NV0gQUNQSUNBOiBUYWJsZXM6IENsZWFudXAgdGFibGU8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBoYW5kbGVyIGludm9rZXJzPGJyPgpNZXNzYWdlLUlEOjxi
cj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZsdDtjOGE0OGUw
Mzc5ZWQ5ZDA2ZDUwODQ0YjRkN2FjNTlhYzhmYjZlN2Q3LjE0OTQ5MTY3NjYuZ2l0Lmx2LnpoZW5n
QGludGVsLmNvbSZndDs8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyA8YnI+Cjxicj4KUmVjZW50bHksIHdlIGFsbG93cyB0aGUgdGFibGUgbXV0ZXggdG8gYmUg
aGVsZCBpbiBib3RoIGVhcmx5IGFuZCBsYXRlIHN0YWdlPGJyPgpBUElzLiBUaGlzIHBhdGNoIGZ1
cnRoZXIgY2xlYW5zIHVwIHRoZSByZWxhdGVkIGNvZGUgdG8gcmVkdWNlIHJlZHVuZGFudDxicj4K
Y29kZSByZWxhdGVkIHRvIGFjcGlfZ2JsX3RhYmxlX2hhbmRsZXIuIEx2IFpoZW5nLjxicj4KPGJy
PgpUZXN0ZWQtYnk6IEhhbnMgZGUgR29lZGUgJmx0O2hkZWdvZWRlQHJlZGhhdC5jb20mZ3Q7PGJy
PgpTaWduZWQtb2ZmLWJ5OiBMdiBaaGVuZyAmbHQ7bHYuemhlbmdAaW50ZWwuY29tJmd0Ozxicj4K
LS0tPGJyPgombmJzcDtkcml2ZXJzL2FjcGkvYWNwaWNhL2FjdGFibGVzLmggfCZuYnNwOyAyICYj
NDM7JiM0Mzs8YnI+CiZuYnNwO2RyaXZlcnMvYWNwaS9hY3BpY2EvdGJkYXRhLmMmbmJzcDsmbmJz
cDsgfCA0MyAmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQz
OyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0Mzsm
IzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOy0tLS0tLS0tLS0tLS0tPGJyPgombmJz
cDtkcml2ZXJzL2FjcGkvYWNwaWNhL3RiaW5zdGFsLmMgfCZuYnNwOyA4ICYjNDM7JiM0MzstLS0t
LS08YnI+CiZuYnNwOzMgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygmIzQzOyksIDIwIGRl
bGV0aW9ucygtKTxicj4KPGJyPgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGljYS9hY3Rh
Ymxlcy5oIGIvZHJpdmVycy9hY3BpL2FjcGljYS9hY3RhYmxlcy5oPGJyPgppbmRleCBjOGRhNDUz
Li44OWVkMzFiIDEwMDY0NDxicj4KLS0tIGEvZHJpdmVycy9hY3BpL2FjcGljYS9hY3RhYmxlcy5o
PGJyPgomIzQzOyYjNDM7JiM0MzsgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL2FjdGFibGVzLmg8YnI+
CkBAIC0xMzIsNiAmIzQzOzEzMiw4IEBAIGFjcGlfdGJfaW5zdGFsbF9hbmRfbG9hZF90YWJsZShh
Y3BpX3BoeXNpY2FsX2FkZHJlc3MgYWRkcmVzcyw8YnI+CiZuYnNwOzxicj4KJm5ic3A7YWNwaV9z
dGF0dXMgYWNwaV90Yl91bmxvYWRfdGFibGUodTMyIHRhYmxlX2luZGV4KTs8YnI+CiZuYnNwOzxi
cj4KJiM0Mzt2b2lkIGFjcGlfdGJfbm90aWZ5X3RhYmxlKHUzMiBldmVudCwgdm9pZCAqdGFibGUp
Ozxicj4KJiM0Mzs8YnI+CiZuYnNwO3ZvaWQgYWNwaV90Yl90ZXJtaW5hdGUodm9pZCk7PGJyPgom
bmJzcDs8YnI+CiZuYnNwO2FjcGlfc3RhdHVzIGFjcGlfdGJfZGVsZXRlX25hbWVzcGFjZV9ieV9v
d25lcih1MzIgdGFibGVfaW5kZXgpOzxicj4KZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9hY3Bp
Y2EvdGJkYXRhLmMgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL3RiZGF0YS5jPGJyPgppbmRleCAyN2M1
YzI3Li40MmVhMDQ0IDEwMDY0NDxicj4KLS0tIGEvZHJpdmVycy9hY3BpL2FjcGljYS90YmRhdGEu
Yzxicj4KJiM0MzsmIzQzOyYjNDM7IGIvZHJpdmVycy9hY3BpL2FjcGljYS90YmRhdGEuYzxicj4K
QEAgLTgxOCwxMyAmIzQzOzgxOCw5IEBAIGFjcGlfdGJfbG9hZF90YWJsZSh1MzIgdGFibGVfaW5k
ZXgsIHN0cnVjdCBhY3BpX25hbWVzcGFjZV9ub2RlICpwYXJlbnRfbm9kZSk8YnI+CiZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBhY3BpX2V2X3VwZGF0ZV9ncGVzKG93bmVy
X2lkKTs8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyB9PGJyPgombmJzcDs8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
LyogSW52b2tlIHRhYmxlIGhhbmRsZXIgaWYgcHJlc2VudCAqLzxicj4KLTxicj4KLSZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBpZiAoYWNwaV9nYmxfdGFibGVfaGFuZGxlcikg
ezxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAodm9pZClhY3BpX2dibF90YWJsZV9o
YW5kbGVyKEFDUElfVEFCTEVfRVZFTlRfTE9BRCwgdGFibGUsPGJyPgotJm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IGFjcGlfZ2JsX3RhYmxlX2hhbmRsZXJfY29udGV4dCk7PGJyPgotJm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC8qIEludm9rZSB0YWJsZSBoYW5kbGVyICovPGJyPgom
bmJzcDs8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFjcGlf
dGJfbm90aWZ5X3RhYmxlKEFDUElfVEFCTEVfRVZFTlRfTE9BRCwgdGFibGUpOzxicj4KJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHJldHVybl9BQ1BJX1NU
QVRVUyhzdGF0dXMpOzxicj4KJm5ic3A7fTxicj4KJm5ic3A7PGJyPgpAQCAtODkyLDE1ICYjNDM7
ODg4LDExIEBAIGFjcGlfc3RhdHVzIGFjcGlfdGJfdW5sb2FkX3RhYmxlKHUzMiB0YWJsZV9pbmRl
eCk8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyByZXR1cm5fQUNQ
SV9TVEFUVVMoQUVfTk9UX0VYSVNUKTs8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyB9PGJyPgombmJzcDs8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgLyogSW52b2tlIHRhYmxlIGhhbmRsZXIgaWYgcHJlc2VudCAqLzxi
cj4KJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgLyogSW52b2tlIHRh
YmxlIGhhbmRsZXIgKi88YnI+CiZuYnNwOzxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyBpZiAoYWNwaV9nYmxfdGFibGVfaGFuZGxlcikgezxicj4KLSZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBzdGF0dXMgPSBhY3BpX2dldF90YWJsZV9ieV9pbmRleCh0YWJsZV9p
bmRleCwgJmFtcDt0YWJsZSk7PGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmIChB
Q1BJX1NVQ0NFU1Moc3RhdHVzKSkgezxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAodm9pZClhY3Bp
X2dibF90YWJsZV9oYW5kbGVyKEFDUElfVEFCTEVfRVZFTlRfVU5MT0FELDxicj4KLSZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyB0YWJsZSw8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgYWNwaV9nYmxf
dGFibGVfaGFuZGxlcl9jb250ZXh0KTs8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
fTxicj4KJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc3RhdHVzID0g
YWNwaV9nZXRfdGFibGVfYnlfaW5kZXgodGFibGVfaW5kZXgsICZhbXA7dGFibGUpOzxicj4KJiM0
MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKEFDUElfU1VDQ0VTUyhz
dGF0dXMpKSB7PGJyPgomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBhY3BpX3RiX25v
dGlmeV90YWJsZShBQ1BJX1RBQkxFX0VWRU5UX1VOTE9BRCwgdGFibGUpOzxicj4KJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08YnI+CiZuYnNwOzxicj4K
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC8qIERlbGV0
ZSB0aGUgcG9ydGlvbiBvZiB0aGUgbmFtZXNwYWNlIG93bmVkIGJ5IHRoaXMgdGFibGUgKi88YnI+
CkBAIC05MTQsMyAmIzQzOzkwNiwyNiBAQCBhY3BpX3N0YXR1cyBhY3BpX3RiX3VubG9hZF90YWJs
ZSh1MzIgdGFibGVfaW5kZXgpPGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgYWNwaV90Yl9zZXRfdGFibGVfbG9hZGVkX2ZsYWcodGFibGVfaW5kZXgs
IEZBTFNFKTs8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyByZXR1cm5fQUNQSV9TVEFUVVMoc3RhdHVzKTs8YnI+CiZuYnNwO308YnI+CiYjNDM7PGJy
PgomIzQzOy8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqPGJyPgomIzQzOyAqPGJyPgomIzQzOyAqIEZV
TkNUSU9OOiZuYnNwOyZuYnNwOyZuYnNwOyBhY3BpX3RiX25vdGlmeV90YWJsZTxicj4KJiM0Mzsg
Kjxicj4KJiM0MzsgKiBQQVJBTUVURVJTOiZuYnNwOyBldmVudCZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyAtIFRhYmxlIGV2ZW50PGJyPgomIzQzOyAqJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHRh
YmxlJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC0gVmFsaWRhdGVkIHRhYmxlIHBvaW50ZXI8
YnI+CiYjNDM7ICo8YnI+CiYjNDM7ICogUkVUVVJOOiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyBOb25lPGJyPgomIzQzOyAqPGJyPgomIzQzOyAqIERFU0NSSVBUSU9OOiBOb3RpZnkgYSB0
YWJsZSBldmVudCB0byB0aGUgdXNlcnMuPGJyPgomIzQzOyAqPGJyPgomIzQzOyAqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKiovPGJyPgomIzQzOzxicj4KJiM0Mzt2b2lkIGFjcGlfdGJfbm90aWZ5X3RhYmxl
KHUzMiBldmVudCwgdm9pZCAqdGFibGUpPGJyPgomIzQzO3s8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC8qIEludm9rZSB0YWJsZSBoYW5kbGVyIGlmIHByZXNl
bnQgKi88YnI+CiYjNDM7PGJyPgomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyBpZiAoYWNwaV9nYmxfdGFibGVfaGFuZGxlcikgezxicj4KJiM0MzsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgKHZvaWQpYWNwaV9nYmxfdGFibGVfaGFuZGxlcihldmVudCwgdGFibGUs
PGJyPgomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBhY3BpX2dibF90YWJsZV9o
YW5kbGVyX2NvbnRleHQpOzxicj4KJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgfTxicj4KJiM0Mzt9PGJyPgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGljYS90
Ymluc3RhbC5jIGIvZHJpdmVycy9hY3BpL2FjcGljYS90Ymluc3RhbC5jPGJyPgppbmRleCA0NjIw
ZjNjLi5lZTc0NTE1IDEwMDY0NDxicj4KLS0tIGEvZHJpdmVycy9hY3BpL2FjcGljYS90Ymluc3Rh
bC5jPGJyPgomIzQzOyYjNDM7JiM0MzsgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL3RiaW5zdGFsLmM8
YnI+CkBAIC0zMDYsMTQgJiM0MzszMDYsMTAgQEAgYWNwaV90Yl9pbnN0YWxsX3N0YW5kYXJkX3Rh
YmxlKGFjcGlfcGh5c2ljYWxfYWRkcmVzcyBhZGRyZXNzLDxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFjcGlfdGJfaW5zdGFsbF90YWJsZV93aXRo
X292ZXJyaWRlKCZhbXA7bmV3X3RhYmxlX2Rlc2MsIG92ZXJyaWRlLDxicj4KJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHRhYmxlX2luZGV4KTs8YnI+CiZuYnNwOzxicj4KLSZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAvKiBJbnZva2UgdGFibGUgaGFuZGxl
ciBpZiBwcmVzZW50ICovPGJyPgomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyAvKiBJbnZva2UgdGFibGUgaGFuZGxlciAqLzxicj4KJm5ic3A7PGJyPgombmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKHZvaWQpYWNwaV91dF9yZWxl
YXNlX211dGV4KEFDUElfTVRYX1RBQkxFUyk7PGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IGlmIChhY3BpX2dibF90YWJsZV9oYW5kbGVyKSB7PGJyPgotJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7ICh2b2lkKWFjcGlfZ2JsX3RhYmxlX2hhbmRsZXIoQUNQSV9UQUJM
RV9FVkVOVF9JTlNUQUxMLDxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBuZXdf
dGFibGVfZGVzYy5wb2ludGVyLDxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBh
Y3BpX2dibF90YWJsZV9oYW5kbGVyX2NvbnRleHQpOzxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyB9PGJyPgomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyBhY3BpX3RiX25vdGlmeV90YWJsZShBQ1BJX1RBQkxFX0VWRU5UX0lOU1RBTEwsIG5l
d190YWJsZV9kZXNjLnBvaW50ZXIpOzxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7ICh2b2lkKWFjcGlfdXRfYWNxdWlyZV9tdXRleChBQ1BJX01UWF9U
QUJMRVMpOzxicj4KJm5ic3A7PGJyPgombmJzcDt1bmxvY2tfYW5kX2V4aXQ6PGJyPgotLSA8YnI+
CjIuNy40PGJyPgo8YnI+Cjxicj4KPGJyPgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08
YnI+Cjxicj4KTWVzc2FnZTogNDxicj4KRGF0ZTogVHVlLCAxNiBNYXkgMjAxNyAxNToxMzoyNiAm
IzQzOzA4MDA8YnI+CkZyb206IEx2IFpoZW5nICZsdDtsdi56aGVuZ0BpbnRlbC5jb20mZ3Q7PGJy
PgpUbzogJnF1b3Q7UmFmYWVsIEogLiBXeXNvY2tpJnF1b3Q7ICZsdDtyYWZhZWwuai53eXNvY2tp
QGludGVsLmNvbSZndDssIExlbiBCcm93bjxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7ICZsdDtsZW4uYnJvd25AaW50ZWwuY29tJmd0OywgUm9iZXJ0IE1vb3Jl
ICZsdDtyb2JlcnQubW9vcmVAaW50ZWwuY29tJmd0OywgTHYgWmhlbmc8YnI+CiZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAmbHQ7bHYuemhlbmdAaW50ZWwuY29tJmd0
OywgJnF1b3Q7RGF2aWQgRSAuIEJveCZxdW90OyAmbHQ7ZGF2aWQuZS5ib3hAaW50ZWwuY29tJmd0
Ozxicj4KQ2M6IEx2IFpoZW5nICZsdDt6ZXRhbG9nQGdtYWlsLmNvbSZndDssIGxpbnV4LWFjcGlA
dmdlci5rZXJuZWwub3JnLDxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IGRldmVsQGFjcGljYS5vcmcsIEhhbnMgZGUgR29lZGUgJmx0O2hkZWdvZWRlQHJlZGhh
dC5jb20mZ3Q7PGJyPgpTdWJqZWN0OiBbRGV2ZWxdIFtSRkMgUEFUQ0ggdjIgMi81XSBBQ1BJQ0E6
IFRhYmxlczogRG8gbm90IHZhbGlkYXRlPGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgc2lnbmF0dXJlIGZvciBkeW5hbWljIHRhYmxlIGxvYWQ8YnI+Ck1lc3Nh
Z2UtSUQ6PGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJmx0
O2YwN2JiOGNmZWRhMzY0Njk4YWRhZDliYzE1ZDU0YzliMmFjOGIzNjYuMTQ5NDkxNjc2Ni5naXQu
bHYuemhlbmdAaW50ZWwuY29tJmd0Ozxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IDxicj4KPGJyPgpXaW5kb3dzIHNlZW1zIHRvIGFsbG93IGFyYml0cmFyeSB0
YWJsZSBzaWduYXR1cmVzIGZvciBMb2FkL2xvYWRfdGFibGU8YnI+Cm9wY29kZXM6PGJyPgombmJz
cDsgQUNQSSBCSU9TIEVycm9yIChidWcpOiBUYWJsZSBoYXMgaW52YWxpZCBzaWduYXR1cmUgW1BS
QURdICgweDQ0NDE1MjUwKTxicj4KU28gdGhpcyBwYXRjaCByZW1vdmVzIGR5bmFtaWMgbG9hZCBz
aWduYXR1cmUgY2hlY2tzLiBIb3dldmVyIHdlIG5lZWQgdG88YnI+CmZpbmQgYSB3YXkgdG8gYXZv
aWQgdGFibGUgbG9hZGluZyBhZ2FpbnN0IHRhYmxlcyBsaWtlIE1BRFQuIFRoaXMgaXMgbm90PGJy
Pgpjb3ZlcmVkIGJ5IHRoaXMgY29tbWl0Ljxicj4KPGJyPgpUaGlzIFdpbmRvd3MgYmVoYXZpb3Ig
aGFzIGJlZW4gdmFsaWRhdGVkIG9uIGxpbmsgIzEuIEFuIGVuZCB1c2VyIGJ1Zzxicj4KcmVwb3J0
IGNhbiBhbHNvIGJlIGZvdW5kIG9uIGxpbmsgIzIuPGJyPgo8YnI+ClRoaXMgcGF0Y2ggYWxzbyBp
bmNsdWRlcyBzaW1wbGUgY2xlYW51cCBmb3Igc3RhdGljIGxvYWQgc2lnbmF0dXJlIGNoZWNrPGJy
Pgpjb2RlLiBSZXBvcnRlZCBieSBZZSBYaWFvbG9uZywgRml4ZWQgYnkgTHYgWmhlbmcuPGJyPgo8
YnI+Ckxpbms6IDxhIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9hY3BpY2EvYWNwaWNhL3B1bGwv
MTIxIj5odHRwczovL2dpdGh1Yi5jb20vYWNwaWNhL2FjcGljYS9wdWxsLzEyMTwvYT4gWyMxXTxi
cj4KTGluazogPGEgaHJlZj0iaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNn
aT9pZD0xMTg2MDEiPmh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9
MTE4NjAxPC9hPiBbIzJdPGJyPgpSZXBvcnRlZC1ieTogWWUgWGlhb2xvbmcgJmx0O3hpYW9sb25n
LnllQGludGVsLmNvbSZndDs8YnI+ClNpZ25lZC1vZmYtYnk6IEx2IFpoZW5nICZsdDtsdi56aGVu
Z0BpbnRlbC5jb20mZ3Q7PGJyPgotLS08YnI+CiZuYnNwO2RyaXZlcnMvYWNwaS9hY3BpY2EvdGJp
bnN0YWwuYyB8IDI4IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+CiZuYnNwO2RyaXZl
cnMvYWNwaS9hY3BpY2EvdGJ4ZmxvYWQuYyB8Jm5ic3A7IDIgJiM0MzstPGJyPgombmJzcDsyIGZp
bGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCYjNDM7KSwgMjkgZGVsZXRpb25zKC0pPGJyPgo8YnI+
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaWNhL3RiaW5zdGFsLmMgYi9kcml2ZXJzL2Fj
cGkvYWNwaWNhL3RiaW5zdGFsLmM8YnI+CmluZGV4IGVlNzQ1MTUuLjlkMjEyOTYgMTAwNjQ0PGJy
PgotLS0gYS9kcml2ZXJzL2FjcGkvYWNwaWNhL3RiaW5zdGFsLmM8YnI+CiYjNDM7JiM0MzsmIzQz
OyBiL2RyaXZlcnMvYWNwaS9hY3BpY2EvdGJpbnN0YWwuYzxicj4KQEAgLTIyMiwzNCAmIzQzOzIy
Miw2IEBAIGFjcGlfdGJfaW5zdGFsbF9zdGFuZGFyZF90YWJsZShhY3BpX3BoeXNpY2FsX2FkZHJl
c3MgYWRkcmVzcyw8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyAodm9pZClhY3BpX3V0X2FjcXVpcmVfbXV0ZXgoQUNQSV9NVFhfVEFCTEVTKTs8YnI+
CiZuYnNwOzxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IGlmIChyZWxvYWQpIHs8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgLyo8YnI+
Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKiBWYWxpZGF0ZSB0aGUgaW5jb21p
bmcgdGFibGUgc2lnbmF0dXJlLjxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyAqPGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogMSkgT3JpZ2luYWxs
eSwgd2UgY2hlY2tlZCB0aGUgdGFibGUgc2lnbmF0dXJlIGZvciAmcXVvdDtTU0RUJnF1b3Q7IG9y
ICZxdW90O1BTRFQmcXVvdDsuPGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
ICogMikgV2UgYWRkZWQgc3VwcG9ydCBmb3IgT0VNeCB0YWJsZXMsIHNpZ25hdHVyZSAmcXVvdDtP
RU0mcXVvdDsuPGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogMykgVmFs
aWQgdGFibGVzIHdlcmUgZW5jb3VudGVyZWQgd2l0aCBhIG51bGwgc2lnbmF0dXJlLCBzbyB3ZSBq
dXN0PGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICombmJzcDsmbmJzcDsm
bmJzcDsgZ2F2ZSB1cCBvbiB2YWxpZGF0aW5nIHRoZSBzaWduYXR1cmUsICgwNS8yMDA4KS48YnI+
Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKiA0KSBXZSBlbmNvdW50ZXJlZCBu
b24tQU1MIHRhYmxlcyBzdWNoIGFzIHRoZSBNQURULCB3aGljaCBjYXVzZWQ8YnI+Ci0mbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKiZuYnNwOyZuYnNwOyZuYnNwOyBpbnRlcnByZXRl
ciBlcnJvcnMgYW5kIGtlcm5lbCBmYXVsdHMuIFNvIG5vdywgd2Ugb25jZSBhZ2FpbiBhbGxvdzxi
cj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAqJm5ic3A7Jm5ic3A7Jm5ic3A7
IG9ubHkgJnF1b3Q7U1NEVCZxdW90OywgJnF1b3Q7T0VNeCZxdW90OywgYW5kIG5vdywgYWxzbyBh
IG51bGwgc2lnbmF0dXJlLiAoMDUvMjAxMSkuPGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7ICovPGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmICgobmV3X3Rh
YmxlX2Rlc2Muc2lnbmF0dXJlLmFzY2lpWzBdICE9IDB4MDApICZhbXA7JmFtcDs8YnI+Ci0mbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKCFBQ1BJX0NP
TVBBUkVfTkFNRTxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyAoJmFtcDtuZXdfdGFibGVfZGVzYy5zaWduYXR1cmUsIEFDUElfU0lH
X1NTRFQpKTxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyAmYW1wOyZhbXA7IChzdHJuY21wKG5ld190YWJsZV9kZXNjLnNpZ25hdHVyZS5hc2Np
aSwgJnF1b3Q7T0VNJnF1b3Q7LCAzKSkpIHs8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgQUNQSV9C
SU9TX0VSUk9SKChBRV9JTkZPLDxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAmcXVvdDtUYWJsZSBoYXMgaW52YWxpZCBz
aWduYXR1cmUgWyU0LjRzXSAoMHglOC44WCksICZxdW90Ozxicj4KLSZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAmcXVvdDttdXN0
IGJlIFNTRFQgb3IgT0VNeCZxdW90Oyw8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgYWNwaV91dF92YWxpZF9uYW1lc2Vn
KG5ld190YWJsZV9kZXNjLjxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBzaWduYXR1cmUu
PGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFzY2lpKSA/PGJyPgotJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IG5ld190
YWJsZV9kZXNjLnNpZ25hdHVyZS48YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgYXNjaWkgOiAmcXVvdDs/Pz8/JnF1b3Q7
LDxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyBuZXdfdGFibGVfZGVzYy5zaWduYXR1cmUuaW50ZWdlcikpOzxicj4KLTxi
cj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBzdGF0dXMgPSBBRV9CQURfU0lHTkFUVVJFOzxicj4KLSZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBnb3RvIHVubG9ja19hbmRfZXhpdDs8YnI+Ci0mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgfTxicj4KJm5ic3A7PGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgLyogQ2hlY2sgaWYgdGFibGUgaXMgYWxyZWFkeSByZWdpc3RlcmVkICov
PGJyPgombmJzcDs8YnI+CmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaWNhL3RieGZsb2Fk
LmMgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL3RieGZsb2FkLmM8YnI+CmluZGV4IGI3MWNlM2IuLmQ4
MWY0NDIgMTAwNjQ0PGJyPgotLS0gYS9kcml2ZXJzL2FjcGkvYWNwaWNhL3RieGZsb2FkLmM8YnI+
CiYjNDM7JiM0MzsmIzQzOyBiL2RyaXZlcnMvYWNwaS9hY3BpY2EvdGJ4ZmxvYWQuYzxicj4KQEAg
LTIwNiw3ICYjNDM7MjA2LDcgQEAgYWNwaV9zdGF0dXMgYWNwaV90Yl9sb2FkX25hbWVzcGFjZSh2
b2lkKTxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IGZvciAoaSA9IDA7IGkgJmx0OyBhY3BpX2dibF9yb290X3RhYmxlX2xpc3QuY3VycmVudF90YWJs
ZV9jb3VudDsgJiM0MzsmIzQzO2kpIHs8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyB0YWJsZSA9ICZhbXA7YWNwaV9nYmxfcm9vdF90YWJsZV9saXN0LnRhYmxlc1tp
XTs8YnI+CiZuYnNwOzxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBpZiAoIWFjcGlf
Z2JsX3Jvb3RfdGFibGVfbGlzdC50YWJsZXNbaV0uYWRkcmVzcyB8fDxicj4KJiM0MzsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKCF0YWJsZS0mZ3Q7YWRkcmVzcyB8fDxicj4KJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
ICghQUNQSV9DT01QQVJFX05BTUUodGFibGUtJmd0O3NpZ25hdHVyZS5hc2NpaSwgQUNQSV9TSUdf
U1NEVCk8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAmYW1wOyZhbXA7ICFBQ1BJX0NPTVBBUkVfTkFNRSh0YWJs
ZS0mZ3Q7c2lnbmF0dXJlLmFzY2lpLDxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IEFDUElfU0lHX1BTRFQpPGJyPgotLSA8YnI+CjIuNy40PGJyPgo8YnI+Cjxicj4KPGJyPgotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+Cjxicj4KTWVzc2FnZTogNTxicj4KRGF0ZTog
VHVlLCAxNiBNYXkgMjAxNyAxNToxMzozOSAmIzQzOzA4MDA8YnI+CkZyb206IEx2IFpoZW5nICZs
dDtsdi56aGVuZ0BpbnRlbC5jb20mZ3Q7PGJyPgpUbzogJnF1b3Q7UmFmYWVsIEogLiBXeXNvY2tp
JnF1b3Q7ICZsdDtyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbSZndDssIExlbiBCcm93bjxicj4K
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZsdDtsZW4uYnJvd25A
aW50ZWwuY29tJmd0OywgUm9iZXJ0IE1vb3JlICZsdDtyb2JlcnQubW9vcmVAaW50ZWwuY29tJmd0
OywgTHYgWmhlbmc8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyAmbHQ7bHYuemhlbmdAaW50ZWwuY29tJmd0OywgJnF1b3Q7RGF2aWQgRSAuIEJveCZxdW90OyAm
bHQ7ZGF2aWQuZS5ib3hAaW50ZWwuY29tJmd0Ozxicj4KQ2M6IEx2IFpoZW5nICZsdDt6ZXRhbG9n
QGdtYWlsLmNvbSZndDssIGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnLDxicj4KJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGRldmVsQGFjcGljYS5vcmcsIEhhbnMg
ZGUgR29lZGUgJmx0O2hkZWdvZWRlQHJlZGhhdC5jb20mZ3Q7PGJyPgpTdWJqZWN0OiBbRGV2ZWxd
IFtSRkMgUEFUQ0ggdjIgMy81XSBBQ1BJQ0E6IFRhYmxlczogQ2hhbmdlIHRhYmxlPGJyPgombmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZHVwbGljYXRpb24gY2hlY2sg
dG8gYmUgcmVsYXRlZCB0byBhY3BpX2dibF92ZXJpZnlfdGFibGVfY2hlY2tzdW08YnI+Ck1lc3Nh
Z2UtSUQ6PGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJmx0
OzU3OWRlMDBmNWQ1NGUxMjhiMDRiYmE1YWU2MjdhZmQwZjEzMmM1MjguMTQ5NDkxNjc2Ni5naXQu
bHYuemhlbmdAaW50ZWwuY29tJmd0Ozxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IDxicj4KPGJyPgphY3BpX2dibF92ZXJpZnlfdGFibGVfY2hlY2tzdW0gaXMg
dXNlZCB0byBhdm9pZCB2YWxpZGF0aW5nIChtYXBwaW5nKSBhbiBlbnRpcmU8YnI+CnRhYmxlIGlu
IE9TIGJvb3Qgc3RhZ2UuIDJuZCAmcXVvdDtSZWxvYWQmcXVvdDsgY2hlY2sgaW4gYWNwaV90Yl9p
bnN0YWxsX3N0YW5kYXJkX3RhYmxlKCk8YnI+CmlzIHByZXBhcmVkIGZvciB0aGUgc2FtZSBwdXJw
b3NlLiBTbyB0aGlzIHBhdGNoIGNvbWJpbmVzIHRoZW0gdG9nZXRoZXI8YnI+CnVzaW5nIGEgcmVu
YW1lZCBhY3BpX2dibF9lbmFibGVfdGFibGVfdmFsaWRhdGlvbiBmbGFnLiBMdiBaaGVuZy48YnI+
Cjxicj4KU2lnbmVkLW9mZi1ieTogTHYgWmhlbmcgJmx0O2x2LnpoZW5nQGludGVsLmNvbSZndDs8
YnI+Ci0tLTxicj4KJm5ic3A7ZHJpdmVycy9hY3BpL2FjcGljYS90YmRhdGEuYyZuYnNwOyZuYnNw
OyB8Jm5ic3A7IDQgJiM0MzsmIzQzOy0tPGJyPgombmJzcDtkcml2ZXJzL2FjcGkvYWNwaWNhL3Ri
aW5zdGFsLmMgfCZuYnNwOyAyICYjNDM7LTxicj4KJm5ic3A7ZHJpdmVycy9hY3BpL2FjcGljYS90
YnhmYWNlLmMmbmJzcDsgfCZuYnNwOyA4ICYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYj
NDM7JiM0Mzs8YnI+CiZuYnNwO2RyaXZlcnMvYWNwaS9idXMuYyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB8Jm5i
c3A7IDIgJiM0MzstPGJyPgombmJzcDtkcml2ZXJzL2FjcGkvdGFibGVzLmMmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfCZuYnNwOyA0ICYjNDM7
JiM0MzstLTxicj4KJm5ic3A7aW5jbHVkZS9hY3BpL2FjcGl4Zi5oJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHwgMTUgJiM0MzsmIzQzOyYjNDM7
JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOy0tLS0tLS08YnI+CiZuYnNwOzYgZmlsZXMgY2hhbmdl
ZCwgMjIgaW5zZXJ0aW9ucygmIzQzOyksIDEzIGRlbGV0aW9ucygtKTxicj4KPGJyPgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9hY3BpL2FjcGljYS90YmRhdGEuYyBiL2RyaXZlcnMvYWNwaS9hY3BpY2Ev
dGJkYXRhLmM8YnI+CmluZGV4IDQyZWEwNDQuLmU4MTM1NWIgMTAwNjQ0PGJyPgotLS0gYS9kcml2
ZXJzL2FjcGkvYWNwaWNhL3RiZGF0YS5jPGJyPgomIzQzOyYjNDM7JiM0MzsgYi9kcml2ZXJzL2Fj
cGkvYWNwaWNhL3RiZGF0YS5jPGJyPgpAQCAtMzM4LDcgJiM0MzszMzgsNyBAQCB2b2lkIGFjcGlf
dGJfaW52YWxpZGF0ZV90YWJsZShzdHJ1Y3QgYWNwaV90YWJsZV9kZXNjICp0YWJsZV9kZXNjKTxi
cj4KJm5ic3A7YWNwaV9zdGF0dXMgYWNwaV90Yl92YWxpZGF0ZV90ZW1wX3RhYmxlKHN0cnVjdCBh
Y3BpX3RhYmxlX2Rlc2MgKnRhYmxlX2Rlc2MpPGJyPgombmJzcDt7PGJyPgombmJzcDs8YnI+Ci0m
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKCF0YWJsZV9kZXNjLSZndDtw
b2ludGVyICZhbXA7JmFtcDsgIWFjcGlfZ2JsX3ZlcmlmeV90YWJsZV9jaGVja3N1bSkgezxicj4K
JiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKCF0YWJsZV9kZXNj
LSZndDtwb2ludGVyICZhbXA7JmFtcDsgIWFjcGlfZ2JsX2VuYWJsZV90YWJsZV92YWxpZGF0aW9u
KSB7PGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgLyo8YnI+CiZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAqIE9ubHkgdmFsaWRh
dGVzIHRoZSBoZWFkZXIgb2YgdGhlIHRhYmxlLjxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogTm90ZSB0aGF0IExlbmd0aCBjb250YWlucyB0aGUgc2l6
ZSBvZiB0aGUgbWFwcGluZyBhZnRlciBpbnZva2luZzxicj4KQEAgLTM5NCw3ICYjNDM7Mzk0LDcg
QEAgYWNwaV90Yl92ZXJpZnlfdGVtcF90YWJsZShzdHJ1Y3QgYWNwaV90YWJsZV9kZXNjICp0YWJs
ZV9kZXNjLCBjaGFyICpzaWduYXR1cmUpPGJyPgombmJzcDs8YnI+CiZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAvKiBWZXJpZnkgdGhlIGNoZWNrc3VtICov
PGJyPgombmJzcDs8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYg
KGFjcGlfZ2JsX3ZlcmlmeV90YWJsZV9jaGVja3N1bSkgezxicj4KJiM0MzsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKGFjcGlfZ2JsX2VuYWJsZV90YWJsZV92YWxpZGF0
aW9uKSB7PGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc3RhdHVz
ID08YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyBhY3BpX3RiX3ZlcmlmeV9jaGVja3N1bSh0YWJsZV9kZXNjLSZndDtwb2lu
dGVyLDxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHRhYmxlX2Rlc2Mt
Jmd0O2xlbmd0aCk7PGJyPgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGljYS90Ymluc3Rh
bC5jIGIvZHJpdmVycy9hY3BpL2FjcGljYS90Ymluc3RhbC5jPGJyPgppbmRleCA5ZDIxMjk2Li5m
N2JjMzYyIDEwMDY0NDxicj4KLS0tIGEvZHJpdmVycy9hY3BpL2FjcGljYS90Ymluc3RhbC5jPGJy
PgomIzQzOyYjNDM7JiM0MzsgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL3RiaW5zdGFsLmM8YnI+CkBA
IC0yMjEsNyAmIzQzOzIyMSw3IEBAIGFjcGlfdGJfaW5zdGFsbF9zdGFuZGFyZF90YWJsZShhY3Bp
X3BoeXNpY2FsX2FkZHJlc3MgYWRkcmVzcyw8YnI+CiZuYnNwOzxicj4KJm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICh2b2lkKWFjcGlfdXRfYWNxdWlyZV9t
dXRleChBQ1BJX01UWF9UQUJMRVMpOzxicj4KJm5ic3A7PGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmIChyZWxvYWQpIHs8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmIChhY3BpX2dibF9lbmFibGVfdGFibGVfdmFsaWRhdGlv
bikgezxicj4KJm5ic3A7PGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgLyogQ2hlY2sgaWYgdGFibGUgaXMgYWxyZWFkeSByZWdpc3RlcmVkICovPGJyPgombmJzcDs8
YnI+CmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaWNhL3RieGZhY2UuYyBiL2RyaXZlcnMv
YWNwaS9hY3BpY2EvdGJ4ZmFjZS5jPGJyPgppbmRleCAwMTBiMWM0My4uYjBkYzg0MSAxMDA2NDQ8
YnI+Ci0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvdGJ4ZmFjZS5jPGJyPgomIzQzOyYjNDM7JiM0
MzsgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL3RieGZhY2UuYzxicj4KQEAgLTE5NCw2ICYjNDM7MTk0
LDE0IEBAIGFjcGlfc3RhdHVzIEFDUElfSU5JVF9GVU5DVElPTiBhY3BpX3JlYWxsb2NhdGVfcm9v
dF90YWJsZSh2b2lkKTxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IH08YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB9
PGJyPgombmJzcDs8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IGlmICghYWNwaV9nYmxfZW5hYmxlX3RhYmxlX3ZhbGlkYXRpb24pIHs8YnI+CiYjNDM7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC8qPGJyPgomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyAqIE5vdyBpdCdzIHNhZmUgdG8gZG8gZnVsbCB0YWJsZSB2YWxpZGF0aW9uLiBX
ZSBjYW4gZG8gZGVmZXJyZWQ8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7ICogdGFibGUgaW5pdGlsaXphdGlvbiBoZXJlIG9uY2UgdGhlIGZsYWcgaXMgc2V0Ljxicj4K
JiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKi88YnI+CiYjNDM7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFjcGlfZ2JsX2VuYWJsZV90YWJsZV92YWxpZGF0aW9uID0g
VFJVRTs8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08YnI+
CiYjNDM7PGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgYWNwaV9nYmxfcm9vdF90YWJsZV9saXN0LmZsYWdzIHw9IEFDUElfUk9PVF9BTExPV19SRVNJ
WkU7PGJyPgombmJzcDs8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyBzdGF0dXMgPSBhY3BpX3RiX3Jlc2l6ZV9yb290X3RhYmxlX2xpc3QoKTs8YnI+
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYnVzLmMgYi9kcml2ZXJzL2FjcGkvYnVzLmM8YnI+
CmluZGV4IDM0ZmJlMDIuLmMyNjM0MmYgMTAwNjQ0PGJyPgotLS0gYS9kcml2ZXJzL2FjcGkvYnVz
LmM8YnI+CiYjNDM7JiM0MzsmIzQzOyBiL2RyaXZlcnMvYWNwaS9idXMuYzxicj4KQEAgLTEwMTAs
NyAmIzQzOzEwMTAsNyBAQCB2b2lkIF9faW5pdCBhY3BpX2Vhcmx5X2luaXQodm9pZCk8YnI+CiZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBwcmludGsoS0VS
Tl9JTkZPIFBSRUZJWCAmcXVvdDtDb3JlIHJldmlzaW9uICUwOHhcbiZxdW90OywgQUNQSV9DQV9W
RVJTSU9OKTs8YnI+CiZuYnNwOzxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IC8qIEl0J3Mgc2FmZSB0byB2ZXJpZnkgdGFibGUgY2hlY2tzdW1zIGR1
cmluZyBsYXRlIHN0YWdlICovPGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IGFjcGlfZ2JsX3ZlcmlmeV90YWJsZV9jaGVja3N1bSA9IFRSVUU7PGJyPgomIzQzOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBhY3BpX2dibF9lbmFibGVfdGFibGVfdmFs
aWRhdGlvbiA9IFRSVUU7PGJyPgombmJzcDs8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAvKiBlbmFibGUgd29ya2Fyb3VuZHMsIHVubGVzcyBzdHJp
Y3QgQUNQSSBzcGVjLiBjb21wbGlhbmNlICovPGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKCFhY3BpX3N0cmljdCk8YnI+CmRpZmYgLS1naXQg
YS9kcml2ZXJzL2FjcGkvdGFibGVzLmMgYi9kcml2ZXJzL2FjcGkvdGFibGVzLmM8YnI+CmluZGV4
IDBkYWU3MjIuLmI1Y2MwOWMgMTAwNjQ0PGJyPgotLS0gYS9kcml2ZXJzL2FjcGkvdGFibGVzLmM8
YnI+CiYjNDM7JiM0MzsmIzQzOyBiL2RyaXZlcnMvYWNwaS90YWJsZXMuYzxicj4KQEAgLTc0MCwx
MCAmIzQzOzc0MCwxMCBAQCBpbnQgX19pbml0IGFjcGlfdGFibGVfaW5pdCh2b2lkKTxicj4KJm5i
c3A7PGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
aWYgKGFjcGlfdmVyaWZ5X3RhYmxlX2NoZWNrc3VtKSB7PGJyPgombmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgcHJfaW5mbygmcXVvdDtFYXJseSB0YWJsZSBjaGVja3N1bSB2
ZXJpZmljYXRpb24gZW5hYmxlZFxuJnF1b3Q7KTs8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgYWNwaV9nYmxfdmVyaWZ5X3RhYmxlX2NoZWNrc3VtID0gVFJVRTs8YnI+CiYjNDM7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFjcGlfZ2JsX2VuYWJsZV90YWJsZV92YWxpZGF0aW9u
ID0gVFJVRTs8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyB9IGVsc2Ugezxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IHByX2luZm8oJnF1b3Q7RWFybHkgdGFibGUgY2hlY2tzdW0gdmVyaWZpY2F0aW9uIGRpc2FibGVk
XG4mcXVvdDspOzxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBhY3BpX2dibF92ZXJp
ZnlfdGFibGVfY2hlY2tzdW0gPSBGQUxTRTs8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IGFjcGlfZ2JsX2VuYWJsZV90YWJsZV92YWxpZGF0aW9uID0gRkFMU0U7PGJyPgombmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfTxicj4KJm5ic3A7
PGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc3Rh
dHVzID0gYWNwaV9pbml0aWFsaXplX3RhYmxlcyhpbml0aWFsX3RhYmxlcywgQUNQSV9NQVhfVEFC
TEVTLCAwKTs8YnI+CmRpZmYgLS1naXQgYS9pbmNsdWRlL2FjcGkvYWNwaXhmLmggYi9pbmNsdWRl
L2FjcGkvYWNwaXhmLmg8YnI+CmluZGV4IDE1Yzg2Y2UuLjg4YTFkZTggMTAwNjQ0PGJyPgotLS0g
YS9pbmNsdWRlL2FjcGkvYWNwaXhmLmg8YnI+CiYjNDM7JiM0MzsmIzQzOyBiL2luY2x1ZGUvYWNw
aS9hY3BpeGYuaDxicj4KQEAgLTE2MCwxMyAmIzQzOzE2MCwxNCBAQCBBQ1BJX0lOSVRfR0xPQkFM
KHU4LCBhY3BpX2dibF9jcmVhdGVfb3NpX21ldGhvZCwgVFJVRSk7PGJyPgombmJzcDtBQ1BJX0lO
SVRfR0xPQkFMKHU4LCBhY3BpX2dibF91c2VfZGVmYXVsdF9yZWdpc3Rlcl93aWR0aHMsIFRSVUUp
Ozxicj4KJm5ic3A7PGJyPgombmJzcDsvKjxicj4KLSAqIFdoZXRoZXIgb3Igbm90IHRvIHZlcmlm
eSB0aGUgdGFibGUgY2hlY2tzdW0gYmVmb3JlIGluc3RhbGxhdGlvbi4gU2V0PGJyPgotICogdGhp
cyB0byBUUlVFIHRvIHZlcmlmeSB0aGUgdGFibGUgY2hlY2tzdW0gYmVmb3JlIGluc3RhbGwgaXQg
dG8gdGhlIHRhYmxlPGJyPgotICogbWFuYWdlci4gTm90ZSB0aGF0IGVuYWJsaW5nIHRoaXMgb3B0
aW9uIGNhdXNlcyBlcnJvcnMgdG8gaGFwcGVuIGluIHNvbWU8YnI+Ci0gKiBPU1BNcyBkdXJpbmcg
ZWFybHkgaW5pdGlhbGl6YXRpb24gc3RhZ2VzLiBEZWZhdWx0IGJlaGF2aW9yIGlzIHRvIGRvIHN1
Y2g8YnI+Ci0gKiB2ZXJpZmljYXRpb24uPGJyPgotICovPGJyPgotQUNQSV9JTklUX0dMT0JBTCh1
OCwgYWNwaV9nYmxfdmVyaWZ5X3RhYmxlX2NoZWNrc3VtLCBUUlVFKTs8YnI+CiYjNDM7ICogV2hl
dGhlciBvciBub3QgdG8gdmFsaWRhdGUgKG1hcCkgYW4gZW50aXJlIHRhYmxlIHRvIHZlcmlmeTxi
cj4KJiM0MzsgKiBjaGVja3N1bS9kdXBsaWNhdGlvbiBpbiBlYXJseSBzdGFnZSBiZWZvcmUgaW5z
dGFsbC4gU2V0IHRoaXMgdG8gVFJVRSB0bzxicj4KJiM0MzsgKiBhbGxvdyBlYXJseSB0YWJsZSB2
YWxpZGF0aW9uIGJlZm9yZSBpbnN0YWxsIGl0IHRvIHRoZSB0YWJsZSBtYW5hZ2VyLjxicj4KJiM0
MzsgKiBOb3RlIHRoYXQgZW5hYmxpbmcgdGhpcyBvcHRpb24gY2F1c2VzIGVycm9ycyB0byBoYXBw
ZW4gaW4gc29tZSBPU1BNczxicj4KJiM0MzsgKiBkdXJpbmcgZWFybHkgaW5pdGlhbGl6YXRpb24g
c3RhZ2VzLiBEZWZhdWx0IGJlaGF2aW9yIGlzIHRvIGFsbG93IHN1Y2g8YnI+CiYjNDM7ICogdmFs
aWRhdGlvbi48YnI+CiYjNDM7ICovPGJyPgomIzQzO0FDUElfSU5JVF9HTE9CQUwodTgsIGFjcGlf
Z2JsX2VuYWJsZV90YWJsZV92YWxpZGF0aW9uLCBUUlVFKTs8YnI+CiZuYnNwOzxicj4KJm5ic3A7
Lyo8YnI+CiZuYnNwOyAqIE9wdGlvbmFsbHkgZW5hYmxlIG91dHB1dCBmcm9tIHRoZSBBTUwgRGVi
dWcgT2JqZWN0Ljxicj4KLS0gPGJyPgoyLjcuNDxicj4KPGJyPgo8YnI+Cjxicj4KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPgo8YnI+Ck1lc3NhZ2U6IDY8YnI+CkRhdGU6IFR1ZSwg
MTYgTWF5IDIwMTcgMTU6MTM6NDggJiM0MzswODAwPGJyPgpGcm9tOiBMdiBaaGVuZyAmbHQ7bHYu
emhlbmdAaW50ZWwuY29tJmd0Ozxicj4KVG86ICZxdW90O1JhZmFlbCBKIC4gV3lzb2NraSZxdW90
OyAmbHQ7cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20mZ3Q7LCBMZW4gQnJvd248YnI+CiZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAmbHQ7bGVuLmJyb3duQGludGVs
LmNvbSZndDssIFJvYmVydCBNb29yZSAmbHQ7cm9iZXJ0Lm1vb3JlQGludGVsLmNvbSZndDssIEx2
IFpoZW5nPGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJmx0
O2x2LnpoZW5nQGludGVsLmNvbSZndDssICZxdW90O0RhdmlkIEUgLiBCb3gmcXVvdDsgJmx0O2Rh
dmlkLmUuYm94QGludGVsLmNvbSZndDs8YnI+CkNjOiBMdiBaaGVuZyAmbHQ7emV0YWxvZ0BnbWFp
bC5jb20mZ3Q7LCBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZyw8YnI+CiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBkZXZlbEBhY3BpY2Eub3JnLCBIYW5zIGRlIEdv
ZWRlICZsdDtoZGVnb2VkZUByZWRoYXQuY29tJmd0Ozxicj4KU3ViamVjdDogW0RldmVsXSBbUkZD
IFBBVENIIHYyIDQvNV0gQUNQSUNBOiBUYWJsZXM6IENvbWJpbmU8YnI+CiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBjaGVja3N1bS9kdXBsaWNhdGlvbiB2ZXJpZmlj
YXRpb24gdG9nZXRoZXI8YnI+Ck1lc3NhZ2UtSUQ6PGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgJmx0O2VlZjlkMGE1NmJiN2JkNzM4M2RkYTc0MDA0MmI1ODNm
YTU4MTAzYzcuMTQ5NDkxNjc2Ni5naXQubHYuemhlbmdAaW50ZWwuY29tJmd0Ozxicj4KJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDxicj4KPGJyPgpUaGV5IGFyZSBh
bGwgbWVjaGFuaXNtIHVzZWQgdG8gdmVyaWZ5IGlmIGEgdGFibGUgaXMgcXVhbGlmaWVkIHRvIGJl
PGJyPgppbnN0YWxsZWQgYW5kIGNvbnRyb2xsZWQgYnkgYWNwaV9nYmxfZW5hYmxlX3RhYmxlX3Zh
bGlkYXRpb24sIHNvIGNvbWJpbmU8YnI+CnRoZW0gdG9nZXRoZXIuIEx2IFpoZW5nLjxicj4KPGJy
PgpTaWduZWQtb2ZmLWJ5OiBMdiBaaGVuZyAmbHQ7bHYuemhlbmdAaW50ZWwuY29tJmd0Ozxicj4K
LS0tPGJyPgombmJzcDtkcml2ZXJzL2FjcGkvYWNwaWNhL2FjdGFibGVzLmggfCZuYnNwOyZuYnNw
OyAzICYjNDM7LTxicj4KJm5ic3A7ZHJpdmVycy9hY3BpL2FjcGljYS90YmRhdGEuYyZuYnNwOyZu
YnNwOyB8IDE0OCAmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0Mzsm
IzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0
MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7
JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzstLTxicj4KJm5ic3A7ZHJpdmVycy9h
Y3BpL2FjcGljYS90Ymluc3RhbC5jIHwgMTI0ICYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQz
Oy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+CiZuYnNwOzMgZmlsZXMgY2hhbmdlZCwg
MTY1IGluc2VydGlvbnMoJiM0MzspLCAxMTAgZGVsZXRpb25zKC0pPGJyPgo8YnI+CmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2FjcGkvYWNwaWNhL2FjdGFibGVzLmggYi9kcml2ZXJzL2FjcGkvYWNwaWNh
L2FjdGFibGVzLmg8YnI+CmluZGV4IDg5ZWQzMWIuLjg0YTNjZWIgMTAwNjQ0PGJyPgotLS0gYS9k
cml2ZXJzL2FjcGkvYWNwaWNhL2FjdGFibGVzLmg8YnI+CiYjNDM7JiM0MzsmIzQzOyBiL2RyaXZl
cnMvYWNwaS9hY3BpY2EvYWN0YWJsZXMuaDxicj4KQEAgLTc2LDcgJiM0Mzs3Niw4IEBAIHZvaWQg
YWNwaV90Yl9yZWxlYXNlX3RlbXBfdGFibGUoc3RydWN0IGFjcGlfdGFibGVfZGVzYyAqdGFibGVf
ZGVzYyk7PGJyPgombmJzcDthY3BpX3N0YXR1cyBhY3BpX3RiX3ZhbGlkYXRlX3RlbXBfdGFibGUo
c3RydWN0IGFjcGlfdGFibGVfZGVzYyAqdGFibGVfZGVzYyk7PGJyPgombmJzcDs8YnI+CiZuYnNw
O2FjcGlfc3RhdHVzPGJyPgotYWNwaV90Yl92ZXJpZnlfdGVtcF90YWJsZShzdHJ1Y3QgYWNwaV90
YWJsZV9kZXNjICp0YWJsZV9kZXNjLCBjaGFyICpzaWduYXR1cmUpOzxicj4KJiM0MzthY3BpX3Ri
X3ZlcmlmeV90ZW1wX3RhYmxlKHN0cnVjdCBhY3BpX3RhYmxlX2Rlc2MgKnRhYmxlX2Rlc2MsPGJy
PgomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBjaGFyICpzaWduYXR1cmUsIHUz
MiAqdGFibGVfaW5kZXgpOzxicj4KJm5ic3A7PGJyPgombmJzcDt1OCBhY3BpX3RiX2lzX3RhYmxl
X2xvYWRlZCh1MzIgdGFibGVfaW5kZXgpOzxicj4KJm5ic3A7PGJyPgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9hY3BpL2FjcGljYS90YmRhdGEuYyBiL2RyaXZlcnMvYWNwaS9hY3BpY2EvdGJkYXRhLmM8
YnI+CmluZGV4IGU4MTM1NWIuLjJkZWUyY2QgMTAwNjQ0PGJyPgotLS0gYS9kcml2ZXJzL2FjcGkv
YWNwaWNhL3RiZGF0YS5jPGJyPgomIzQzOyYjNDM7JiM0MzsgYi9kcml2ZXJzL2FjcGkvYWNwaWNh
L3RiZGF0YS5jPGJyPgpAQCAtNTAsNiAmIzQzOzUwLDU3IEBAPGJyPgombmJzcDsjZGVmaW5lIF9D
T01QT05FTlQmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgQUNQSV9UQUJMRVM8YnI+CiZuYnNwO0FDUElfTU9EVUxFX05BTUUoJnF1b3Q7dGJkYXRh
JnF1b3Q7KTxicj4KJm5ic3A7PGJyPgomIzQzOy8qIExvY2FsIHByb3RvdHlwZXMgKi88YnI+CiYj
NDM7c3RhdGljIGFjcGlfc3RhdHVzPGJyPgomIzQzO2FjcGlfdGJfY2hlY2tfZHVwbGljYXRpb24o
c3RydWN0IGFjcGlfdGFibGVfZGVzYyAqdGFibGVfZGVzYywgdTMyICp0YWJsZV9pbmRleCk7PGJy
PgomIzQzOzxicj4KJiM0MztzdGF0aWMgdTg8YnI+CiYjNDM7YWNwaV90Yl9jb21wYXJlX3RhYmxl
cyhzdHJ1Y3QgYWNwaV90YWJsZV9kZXNjICp0YWJsZV9kZXNjLCB1MzIgdGFibGVfaW5kZXgpOzxi
cj4KJiM0Mzs8YnI+CiYjNDM7LyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKio8YnI+CiYjNDM7ICo8YnI+
CiYjNDM7ICogRlVOQ1RJT046Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFjcGlfdGJfY29tcGFyZV90YWJs
ZXM8YnI+CiYjNDM7ICo8YnI+CiYjNDM7ICogUEFSQU1FVEVSUzombmJzcDsgdGFibGVfZGVzYyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAtIFRh
YmxlIDEgZGVzY3JpcHRvciB0byBiZSBjb21wYXJlZDxicj4KJiM0MzsgKiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyB0YWJsZV9pbmRleCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyAtIEluZGV4IG9mIHRhYmxlIDIgdG8gYmUgY29tcGFyZWQ8YnI+CiYjNDM7ICo8
YnI+CiYjNDM7ICogUkVUVVJOOiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBUUlVFIGlm
IGJvdGggdGFibGVzIGFyZSBpZGVudGljYWwuPGJyPgomIzQzOyAqPGJyPgomIzQzOyAqIERFU0NS
SVBUSU9OOiBUaGlzIGZ1bmN0aW9uIGNvbXBhcmVzIGEgdGFibGUgd2l0aCBhbm90aGVyIHRhYmxl
IHRoYXQgaGFzPGJyPgomIzQzOyAqJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFscmVhZHkgYmVlbiBp
bnN0YWxsZWQgaW4gdGhlIHJvb3QgdGFibGUgbGlzdC48YnI+CiYjNDM7ICo8YnI+CiYjNDM7ICoq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKi88YnI+CiYjNDM7PGJyPgomIzQzO3N0YXRpYyB1ODxicj4KJiM0
MzthY3BpX3RiX2NvbXBhcmVfdGFibGVzKHN0cnVjdCBhY3BpX3RhYmxlX2Rlc2MgKnRhYmxlX2Rl
c2MsIHUzMiB0YWJsZV9pbmRleCk8YnI+CiYjNDM7ezxicj4KJiM0MzsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgYWNwaV9zdGF0dXMgc3RhdHVzID0gQUVfT0s7PGJyPgomIzQz
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB1OCBpc19pZGVudGljYWw7PGJy
PgomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBzdHJ1Y3QgYWNwaV90
YWJsZV9oZWFkZXIgKnRhYmxlOzxicj4KJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgdTMyIHRhYmxlX2xlbmd0aDs8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IHU4IHRhYmxlX2ZsYWdzOzxicj4KJiM0Mzs8YnI+CiYjNDM7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHN0YXR1cyA9PGJyPgomIzQzOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBhY3Bp
X3RiX2FjcXVpcmVfdGFibGUoJmFtcDthY3BpX2dibF9yb290X3RhYmxlX2xpc3QudGFibGVzW3Rh
YmxlX2luZGV4XSw8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZhbXA7dGFibGUsICZh
bXA7dGFibGVfbGVuZ3RoLCAmYW1wO3RhYmxlX2ZsYWdzKTs8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkgezxicj4K
JiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcmV0dXJuIChGQUxTRSk7PGJyPgomIzQz
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB9PGJyPgomIzQzOzxicj4KJiM0
MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgLyo8YnI+CiYjNDM7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogQ2hlY2sgZm9yIGEgdGFibGUg
bWF0Y2ggb24gdGhlIGVudGlyZSB0YWJsZSBsZW5ndGgsPGJyPgomIzQzOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAqIG5vdCBqdXN0IHRoZSBoZWFkZXIuPGJyPgom
IzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAqLzxicj4KJiM0
MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaXNfaWRlbnRpY2FsID0gKHU4
KSgodGFibGVfZGVzYy0mZ3Q7bGVuZ3RoICE9IHRhYmxlX2xlbmd0aCB8fDxicj4KJiM0MzsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgbWVtY21wKHRhYmxl
X2Rlc2MtJmd0O3BvaW50ZXIsIHRhYmxlLCB0YWJsZV9sZW5ndGgpKSA/PGJyPgomIzQzOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBGQUxTRSA6IFRSVUUpOzxicj4K
JiM0Mzs8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC8qIFJl
bGVhc2UgdGhlIGFjcXVpcmVkIHRhYmxlICovPGJyPgomIzQzOzxicj4KJiM0MzsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgYWNwaV90Yl9yZWxlYXNlX3RhYmxlKHRhYmxlLCB0
YWJsZV9sZW5ndGgsIHRhYmxlX2ZsYWdzKTs8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IHJldHVybiAoaXNfaWRlbnRpY2FsKTs8YnI+CiYjNDM7fTxicj4KJiM0
Mzs8YnI+CiZuYnNwOy8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqPGJyPgombmJzcDsgKjxicj4KJm5i
c3A7ICogRlVOQ1RJT046Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFjcGlfdGJfaW5pdF90YWJsZV9kZXNj
cmlwdG9yPGJyPgpAQCAtNjQsNiAmIzQzOzExNSw3IEBAIEFDUElfTU9EVUxFX05BTUUoJnF1b3Q7
dGJkYXRhJnF1b3Q7KTxicj4KJm5ic3A7ICogREVTQ1JJUFRJT046IEluaXRpYWxpemUgYSBuZXcg
dGFibGUgZGVzY3JpcHRvcjxicj4KJm5ic3A7ICo8YnI+CiZuYnNwOyAqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKiovPGJyPgomIzQzOzxicj4KJm5ic3A7dm9pZDxicj4KJm5ic3A7YWNwaV90Yl9pbml0X3Rh
YmxlX2Rlc2NyaXB0b3Ioc3RydWN0IGFjcGlfdGFibGVfZGVzYyAqdGFibGVfZGVzYyw8YnI+CiZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyBhY3BpX3BoeXNpY2FsX2FkZHJlc3MgYWRkcmVzcyw8YnI+CkBAIC0zNTQsMTIgJiM0
Mzs0MDYsNzggQEAgYWNwaV9zdGF0dXMgYWNwaV90Yl92YWxpZGF0ZV90ZW1wX3RhYmxlKHN0cnVj
dCBhY3BpX3RhYmxlX2Rlc2MgKnRhYmxlX2Rlc2MpPGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcmV0dXJuIChhY3BpX3RiX3ZhbGlkYXRlX3RhYmxl
KHRhYmxlX2Rlc2MpKTs8YnI+CiZuYnNwO308YnI+CiZuYnNwOzxicj4KJiM0MzsvKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKjxicj4KJiM0MzsgKjxicj4KJiM0MzsgKiBGVU5DVElPTjombmJzcDsmbmJz
cDsmbmJzcDsgYWNwaV90Yl9jaGVja19kdXBsaWNhdGlvbjxicj4KJiM0MzsgKjxicj4KJiM0Mzsg
KiBQQVJBTUVURVJTOiZuYnNwOyB0YWJsZV9kZXNjJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC0gVGFibGUgZGVzY3JpcHRvcjxicj4KJiM0Mzsg
KiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB0YWJsZV9pbmRleCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAtIFdoZXJlIHRoZSB0YWJsZSBpbmRleCBpcyByZXR1
cm5lZDxicj4KJiM0MzsgKjxicj4KJiM0MzsgKiBSRVRVUk46Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IFN0YXR1czxicj4KJiM0MzsgKjxicj4KJiM0MzsgKiBERVNDUklQVElPTjogQXZv
aWQgaW5zdGFsbGluZyBkdXBsaWNhdGVkIHRhYmxlcy4gSG93ZXZlciB0YWJsZSBvdmVycmlkZSBh
bmQ8YnI+CiYjNDM7ICombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgdXNlciBhaWRlZCBkeW5hbWljIHRh
YmxlIGxvYWQgaXMgYWxsb3dlZCwgdGh1cyBjb21wYXJpbmcgdGhlPGJyPgomIzQzOyAqJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IGFkZHJlc3Mgb2YgdGhlIHRhYmxlIGlzIG5vdCBzdWZmaWNpZW50LCBh
bmQgY2hlY2tpbmcgdGhlIGVudGlyZTxicj4KJiM0MzsgKiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB0
YWJsZSBjb250ZW50IGlzIHJlcXVpcmVkLjxicj4KJiM0MzsgKjxicj4KJiM0MzsgKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqLzxicj4KJiM0Mzs8YnI+CiYjNDM7YWNwaV9zdGF0dXM8YnI+CiYjNDM7YWNw
aV90Yl9jaGVja19kdXBsaWNhdGlvbihzdHJ1Y3QgYWNwaV90YWJsZV9kZXNjICp0YWJsZV9kZXNj
LCB1MzIgKnRhYmxlX2luZGV4KTxicj4KJiM0Mzt7PGJyPgomIzQzOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyB1MzIgaTs8YnI+CiYjNDM7PGJyPgomIzQzOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBBQ1BJX0ZVTkNUSU9OX1RSQUNFKHRiX2NoZWNrX2R1
cGxpY2F0aW9uKTs8YnI+CiYjNDM7PGJyPgomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyAvKiBDaGVjayBpZiB0YWJsZSBpcyBhbHJlYWR5IHJlZ2lzdGVyZWQgKi88YnI+
CiYjNDM7PGJyPgomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBmb3Ig
KGkgPSAwOyBpICZsdDsgYWNwaV9nYmxfcm9vdF90YWJsZV9saXN0LmN1cnJlbnRfdGFibGVfY291
bnQ7ICYjNDM7JiM0MztpKSB7PGJyPgomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAv
Kjxicj4KJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKiBDaGVjayBmb3Ig
YSB0YWJsZSBtYXRjaCBvbiB0aGUgZW50aXJlIHRhYmxlIGxlbmd0aCw8YnI+CiYjNDM7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogbm90IGp1c3QgdGhlIGhlYWRlci48YnI+CiYj
NDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICovPGJyPgomIzQzOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyBpZiAoIWFjcGlfdGJfY29tcGFyZV90YWJsZXModGFibGVfZGVz
YywgaSkpIHs8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGNvbnRpbnVlOzxicj4KJiM0Mzsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfTxicj4KJiM0Mzs8YnI+CiYjNDM7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IC8qPGJyPgomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyAqIE5vdGU6IHRoZSBjdXJyZW50IG1lY2hhbmlzbSBkb2VzIG5vdCB1bnJlZ2lzdGVy
IGEgdGFibGUgaWYgaXQgaXM8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7ICogZHluYW1pY2FsbHkgdW5sb2FkZWQuIFRoZSByZWxhdGVkIG5hbWVzcGFjZSBlbnRyaWVz
IGFyZSBkZWxldGVkLDxicj4KJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
KiBidXQgdGhlIHRhYmxlIHJlbWFpbnMgaW4gdGhlIHJvb3QgdGFibGUgbGlzdC48YnI+CiYjNDM7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICo8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogVGhlIGFzc3VtcHRpb24gaGVyZSBpcyB0aGF0IHRoZSBu
dW1iZXIgb2YgZGlmZmVyZW50IHRhYmxlcyB0aGF0PGJyPgomIzQzOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyAqIHdpbGwgYmUgbG9hZGVkIGlzIGFjdHVhbGx5IHNtYWxsLCBhbmQg
dGhlcmUgaXMgbWluaW1hbCBvdmVyaGVhZDxicj4KJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgKiBpbiBqdXN0IGtlZXBpbmcgdGhlIHRhYmxlIGluIGNhc2UgaXQgaXMgbmVl
ZGVkIGFnYWluLjxicj4KJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKjxi
cj4KJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKiBJZiB0aGlzIGFzc3Vt
cHRpb24gY2hhbmdlcyBpbiB0aGUgZnV0dXJlIChwZXJoYXBzIG9uIGxhcmdlPGJyPgomIzQzOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAqIG1hY2hpbmVzIHdpdGggbWFueSB0YWJs
ZSBsb2FkL3VubG9hZCBvcGVyYXRpb25zKSwgdGFibGVzIHdpbGw8YnI+CiYjNDM7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogbmVlZCB0byBiZSB1bnJlZ2lzdGVyZWQgd2hlbiB0
aGV5IGFyZSB1bmxvYWRlZCwgYW5kIHNsb3RzIGluIHRoZTxicj4KJiM0MzsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgKiByb290IHRhYmxlIGxpc3Qgc2hvdWxkIGJlIHJldXNlZCB3
aGVuIGVtcHR5Ljxicj4KJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKi88
YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmIChhY3BpX2dibF9yb290X3Rh
YmxlX2xpc3QudGFibGVzW2ldLmZsYWdzICZhbXA7PGJyPgomIzQzOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBBQ1BJX1RBQkxFX0lTX0xPQURFRCkg
ezxicj4KJiM0Mzs8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC8qIFRhYmxlIGlzIHN0aWxs
IGxvYWRlZCwgdGhpcyBpcyBhbiBlcnJvciAqLzxicj4KJiM0Mzs8YnI+CiYjNDM7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IHJldHVybl9BQ1BJX1NUQVRVUyhBRV9BTFJFQURZX0VYSVNUUyk7PGJyPgomIzQz
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB9IGVsc2Ugezxicj4KJiM0MzsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgKnRhYmxlX2luZGV4ID0gaTs8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHJl
dHVybl9BQ1BJX1NUQVRVUyhBRV9DVFJMX1RFUk1JTkFURSk7PGJyPgomIzQzOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyB9PGJyPgomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyB9PGJyPgomIzQzOzxicj4KJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgLyogSW5kaWNhdGUgbm8gZHVwbGljYXRpb24gdG8gdGhlIGNhbGxlciAqLzxicj4K
JiM0Mzs8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHJldHVy
bl9BQ1BJX1NUQVRVUyhBRV9PSyk7PGJyPgomIzQzO308YnI+CiYjNDM7PGJyPgombmJzcDsvKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqPGJyPgombmJzcDsgKjxicj4KJm5ic3A7ICogRlVOQ1RJT046Jm5i
c3A7Jm5ic3A7Jm5ic3A7IGFjcGlfdGJfdmVyaWZ5X3RlbXBfdGFibGU8YnI+CiZuYnNwOyAqPGJy
PgombmJzcDsgKiBQQVJBTUVURVJTOiZuYnNwOyB0YWJsZV9kZXNjJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC0gVGFibGUgZGVzY3JpcHRvcjxi
cj4KJm5ic3A7ICombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc2lnbmF0dXJlJm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC0gVGFibGUgc2ln
bmF0dXJlIHRvIHZlcmlmeTxicj4KJiM0MzsgKiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB0YWJsZV9p
bmRleCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAtIFdo
ZXJlIHRoZSB0YWJsZSBpbmRleCBpcyByZXR1cm5lZDxicj4KJm5ic3A7ICo8YnI+CiZuYnNwOyAq
IFJFVFVSTjombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgU3RhdHVzPGJyPgombmJzcDsg
Kjxicj4KQEAgLTM2OSw3ICYjNDM7NDg3LDggQEAgYWNwaV9zdGF0dXMgYWNwaV90Yl92YWxpZGF0
ZV90ZW1wX3RhYmxlKHN0cnVjdCBhY3BpX3RhYmxlX2Rlc2MgKnRhYmxlX2Rlc2MpPGJyPgombmJz
cDsgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKiovPGJyPgombmJzcDs8YnI+CiZuYnNwO2FjcGlfc3RhdHVz
PGJyPgotYWNwaV90Yl92ZXJpZnlfdGVtcF90YWJsZShzdHJ1Y3QgYWNwaV90YWJsZV9kZXNjICp0
YWJsZV9kZXNjLCBjaGFyICpzaWduYXR1cmUpPGJyPgomIzQzO2FjcGlfdGJfdmVyaWZ5X3RlbXBf
dGFibGUoc3RydWN0IGFjcGlfdGFibGVfZGVzYyAqdGFibGVfZGVzYyw8YnI+CiYjNDM7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGNoYXIgKnNpZ25hdHVyZSwgdTMyICp0YWJsZV9pbmRl
eCk8YnI+CiZuYnNwO3s8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyBhY3BpX3N0YXR1cyBzdGF0dXMgPSBBRV9PSzs8YnI+CiZuYnNwOzxicj4KQEAg
LTM5Miw5ICYjNDM7NTExLDEwIEBAIGFjcGlfdGJfdmVyaWZ5X3RlbXBfdGFibGUoc3RydWN0IGFj
cGlfdGFibGVfZGVzYyAqdGFibGVfZGVzYywgY2hhciAqc2lnbmF0dXJlKTxicj4KJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGdvdG8gaW52YWxpZGF0ZV9hbmRfZXhpdDs8
YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB9PGJy
PgombmJzcDs8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgLyogVmVy
aWZ5IHRoZSBjaGVja3N1bSAqLzxicj4KLTxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmIChhY3BpX2dibF9lbmFibGVfdGFibGVfdmFsaWRhdGlv
bikgezxicj4KJiM0Mzs8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC8qIFZl
cmlmeSB0aGUgY2hlY2tzdW0gKi88YnI+CiYjNDM7PGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgc3RhdHVzID08YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBhY3BpX3RiX3ZlcmlmeV9jaGVj
a3N1bSh0YWJsZV9kZXNjLSZndDtwb2ludGVyLDxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IHRhYmxlX2Rlc2MtJmd0O2xlbmd0aCk7PGJyPgpAQCAtNDExLDkgJiM0Mzs1
MzEsMjkgQEAgYWNwaV90Yl92ZXJpZnlfdGVtcF90YWJsZShzdHJ1Y3QgYWNwaV90YWJsZV9kZXNj
ICp0YWJsZV9kZXNjLCBjaGFyICpzaWduYXR1cmUpPGJyPgombmJzcDs8YnI+CiZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyBnb3RvIGludmFsaWRhdGVfYW5kX2V4aXQ7PGJyPgombmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfTxicj4KJiM0Mzs8YnI+CiYjNDM7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC8qIEF2b2lkIGR1cGxpY2F0aW9ucyAqLzxicj4KJiM0
Mzs8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmICh0YWJsZV9pbmRleCkg
ezxicj4KJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc3RhdHVzID08YnI+CiYjNDM7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFjcGlfdGJfY2hlY2tfZHVwbGljYXRp
b24odGFibGVfZGVzYywgdGFibGVfaW5kZXgpOzxicj4KJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
aWYgKEFDUElfRkFJTFVSRShzdGF0dXMpICZhbXA7JmFtcDsgc3RhdHVzICE9IEFFX0NUUkxfVEVS
TUlOQVRFKSB7PGJyPgomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBBQ1BJX0VYQ0VQVElPTigoQUVfSU5GTywgQUVf
Tk9fTUVNT1JZLDxicj4KJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgJnF1b3Q7JTQuNHMgMHglOC44WCU4LjhYJnF1b3Q7PGJyPgomIzQzOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAmcXVvdDsgVGFibGUg
aXMgZHVwbGljYXRlZCZxdW90Oyw8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFjcGlfdXRfdmFsaWRfbmFtZXNlZzxicj4KJiM0MzsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKHRhYmxlX2Rlc2Mt
Jmd0O3NpZ25hdHVyZS48YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFzY2lpKSA/IHRhYmxlX2Rlc2MtJmd0O3NpZ25hdHVyZS48
YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IGFzY2lpIDogJnF1b3Q7Pz8/PyZxdW90Oyw8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEFDUElfRk9STUFUX1VJTlQ2NCh0YWJsZV9kZXNj
LSZndDs8YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IGFkZHJlc3MpKSk7PGJyPgomIzQzOzxicj4KJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZ290byBpbnZh
bGlkYXRlX2FuZF9leGl0Ozxicj4KJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfTxicj4KJiM0Mzsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfTxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08YnI+CiZuYnNwOzxicj4KLSZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyByZXR1cm5fQUNQSV9TVEFUVVMoQUVfT0spOzxicj4KJiM0
MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcmV0dXJuX0FDUElfU1RBVFVT
KHN0YXR1cyk7PGJyPgombmJzcDs8YnI+CiZuYnNwO2ludmFsaWRhdGVfYW5kX2V4aXQ6PGJyPgom
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgYWNwaV90Yl9p
bnZhbGlkYXRlX3RhYmxlKHRhYmxlX2Rlc2MpOzxicj4KZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNw
aS9hY3BpY2EvdGJpbnN0YWwuYyBiL2RyaXZlcnMvYWNwaS9hY3BpY2EvdGJpbnN0YWwuYzxicj4K
aW5kZXggZjdiYzM2Mi4uOTQwNDgwMSAxMDA2NDQ8YnI+Ci0tLSBhL2RyaXZlcnMvYWNwaS9hY3Bp
Y2EvdGJpbnN0YWwuYzxicj4KJiM0MzsmIzQzOyYjNDM7IGIvZHJpdmVycy9hY3BpL2FjcGljYS90
Ymluc3RhbC5jPGJyPgpAQCAtNDgsNTQgJiM0Mzs0OCw2IEBAPGJyPgombmJzcDsjZGVmaW5lIF9D
T01QT05FTlQmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgQUNQSV9UQUJMRVM8YnI+CiZuYnNwO0FDUElfTU9EVUxFX05BTUUoJnF1b3Q7dGJpbnN0
YWwmcXVvdDspPGJyPgombmJzcDs8YnI+Ci0vKiBMb2NhbCBwcm90b3R5cGVzICovPGJyPgotc3Rh
dGljIHU4PGJyPgotYWNwaV90Yl9jb21wYXJlX3RhYmxlcyhzdHJ1Y3QgYWNwaV90YWJsZV9kZXNj
ICp0YWJsZV9kZXNjLCB1MzIgdGFibGVfaW5kZXgpOzxicj4KLTxicj4KLS8qKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqPGJyPgotICo8YnI+Ci0gKiBGVU5DVElPTjombmJzcDsmbmJzcDsmbmJzcDsgYWNw
aV90Yl9jb21wYXJlX3RhYmxlczxicj4KLSAqPGJyPgotICogUEFSQU1FVEVSUzombmJzcDsgdGFi
bGVfZGVzYyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyAtIFRhYmxlIDEgZGVzY3JpcHRvciB0byBiZSBjb21wYXJlZDxicj4KLSAqJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IHRhYmxlX2luZGV4Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IC0gSW5kZXggb2YgdGFibGUgMiB0byBiZSBjb21wYXJlZDxicj4KLSAq
PGJyPgotICogUkVUVVJOOiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBUUlVFIGlmIGJv
dGggdGFibGVzIGFyZSBpZGVudGljYWwuPGJyPgotICo8YnI+Ci0gKiBERVNDUklQVElPTjogVGhp
cyBmdW5jdGlvbiBjb21wYXJlcyBhIHRhYmxlIHdpdGggYW5vdGhlciB0YWJsZSB0aGF0IGhhczxi
cj4KLSAqJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFscmVhZHkgYmVlbiBpbnN0YWxsZWQgaW4gdGhl
IHJvb3QgdGFibGUgbGlzdC48YnI+Ci0gKjxicj4KLSAqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovPGJy
PgotPGJyPgotc3RhdGljIHU4PGJyPgotYWNwaV90Yl9jb21wYXJlX3RhYmxlcyhzdHJ1Y3QgYWNw
aV90YWJsZV9kZXNjICp0YWJsZV9kZXNjLCB1MzIgdGFibGVfaW5kZXgpPGJyPgotezxicj4KLSZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBhY3BpX3N0YXR1cyBzdGF0dXMgPSBB
RV9PSzs8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgdTggaXNfaWRl
bnRpY2FsOzxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBzdHJ1Y3Qg
YWNwaV90YWJsZV9oZWFkZXIgKnRhYmxlOzxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyB1MzIgdGFibGVfbGVuZ3RoOzxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyB1OCB0YWJsZV9mbGFnczs8YnI+Ci08YnI+Ci0mbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgc3RhdHVzID08YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgYWNwaV90Yl9hY3F1aXJlX3Rh
YmxlKCZhbXA7YWNwaV9nYmxfcm9vdF90YWJsZV9saXN0LnRhYmxlc1t0YWJsZV9pbmRleF0sPGJy
PgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZhbXA7dGFibGUsICZhbXA7dGFibGVfbGVuZ3RoLCAm
YW1wO3RhYmxlX2ZsYWdzKTs8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgaWYgKEFDUElfRkFJTFVSRShzdGF0dXMpKSB7PGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IHJldHVybiAoRkFMU0UpOzxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyB9PGJyPgotPGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IC8qPGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogQ2hl
Y2sgZm9yIGEgdGFibGUgbWF0Y2ggb24gdGhlIGVudGlyZSB0YWJsZSBsZW5ndGgsPGJyPgotJm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogbm90IGp1c3QgdGhlIGhl
YWRlci48YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKi88
YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaXNfaWRlbnRpY2FsID0g
KHU4KSgodGFibGVfZGVzYy0mZ3Q7bGVuZ3RoICE9IHRhYmxlX2xlbmd0aCB8fDxicj4KLSZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBtZW1jbXAodGFibGVf
ZGVzYy0mZ3Q7cG9pbnRlciwgdGFibGUsIHRhYmxlX2xlbmd0aCkpID88YnI+Ci0mbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgRkFMU0UgOiBUUlVFKTs8YnI+Ci08YnI+
Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgLyogUmVsZWFzZSB0aGUgYWNx
dWlyZWQgdGFibGUgKi88YnI+Ci08YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgYWNwaV90Yl9yZWxlYXNlX3RhYmxlKHRhYmxlLCB0YWJsZV9sZW5ndGgsIHRhYmxlX2Zs
YWdzKTs8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcmV0dXJuIChp
c19pZGVudGljYWwpOzxicj4KLX08YnI+Ci08YnI+CiZuYnNwOy8qKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqPGJyPgombmJzcDsgKjxicj4KJm5ic3A7ICogRlVOQ1RJT046Jm5ic3A7Jm5ic3A7Jm5ic3A7
IGFjcGlfdGJfaW5zdGFsbF90YWJsZV93aXRoX292ZXJyaWRlPGJyPgpAQCAtMTEyLDcgJiM0Mzs2
NCw2IEBAIGFjcGlfdGJfY29tcGFyZV90YWJsZXMoc3RydWN0IGFjcGlfdGFibGVfZGVzYyAqdGFi
bGVfZGVzYywgdTMyIHRhYmxlX2luZGV4KTxicj4KJm5ic3A7ICombmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgdGFibGUgYXJyYXkuPGJyPgombmJzcDsgKjxicj4KJm5ic3A7ICoqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKi88YnI+Ci08YnI+CiZuYnNwO3ZvaWQ8YnI+CiZuYnNwO2FjcGlfdGJfaW5zdGFsbF90YWJs
ZV93aXRoX292ZXJyaWRlKHN0cnVjdCBhY3BpX3RhYmxlX2Rlc2MgKm5ld190YWJsZV9kZXNjLDxi
cj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHU4IG92ZXJy
aWRlLCB1MzIgKnRhYmxlX2luZGV4KTxicj4KQEAgLTIxMCw2NyAmIzQzOzE2MSwyOCBAQCBhY3Bp
X3RiX2luc3RhbGxfc3RhbmRhcmRfdGFibGUoYWNwaV9waHlzaWNhbF9hZGRyZXNzIGFkZHJlc3Ms
PGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZ290byByZWxlYXNl
X2FuZF9leGl0Ozxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IH08YnI+CiZuYnNwOzxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyAvKiBWYWxpZGF0ZSBhbmQgdmVyaWZ5IGEgdGFibGUgYmVmb3JlIGluc3RhbGxhdGlvbiAq
Lzxicj4KLTxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBzdGF0dXMg
PSBhY3BpX3RiX3ZlcmlmeV90ZW1wX3RhYmxlKCZhbXA7bmV3X3RhYmxlX2Rlc2MsIE5VTEwpOzxi
cj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBpZiAoQUNQSV9GQUlMVVJF
KHN0YXR1cykpIHs8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZ290byByZWxlYXNl
X2FuZF9leGl0Ozxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB9PGJy
PgotPGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
LyogQWNxdWlyZSB0aGUgdGFibGUgbG9jayAqLzxicj4KJm5ic3A7PGJyPgombmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKHZvaWQpYWNwaV91dF9hY3F1aXJl
X211dGV4KEFDUElfTVRYX1RBQkxFUyk7PGJyPgombmJzcDs8YnI+Ci0mbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKGFjcGlfZ2JsX2VuYWJsZV90YWJsZV92YWxpZGF0aW9u
KSB7PGJyPgotPGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC8qIENoZWNrIGlmIHRh
YmxlIGlzIGFscmVhZHkgcmVnaXN0ZXJlZCAqLzxicj4KLTxicj4KLSZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyBmb3IgKGkgPSAwOyBpICZsdDsgYWNwaV9nYmxfcm9vdF90YWJsZV9saXN0LmN1
cnJlbnRfdGFibGVfY291bnQ7PGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICYjNDM7JiM0MztpKSB7PGJyPgotJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IC8qPGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogQ2hlY2sgZm9yIGEgdGFi
bGUgbWF0Y2ggb24gdGhlIGVudGlyZSB0YWJsZSBsZW5ndGgsPGJyPgotJm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7ICogbm90IGp1c3QgdGhlIGhlYWRlci48YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgKi88YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKCFhY3BpX3RiX2NvbXBhcmVfdGFi
bGVzKCZhbXA7bmV3X3RhYmxlX2Rlc2MsIGkpKSB7PGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGNvbnRpbnVlOzxi
cj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB9PGJyPgomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyAvKiBWYWxpZGF0ZSBhbmQgdmVyaWZ5IGEgdGFibGUgYmVmb3JlIGluc3Rh
bGxhdGlvbiAqLzxicj4KJm5ic3A7PGJyPgomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyBzdGF0dXMgPSBhY3BpX3RiX3ZlcmlmeV90ZW1wX3RhYmxlKCZhbXA7bmV3X3Rh
YmxlX2Rlc2MsIE5VTEwsICZhbXA7aSk7PGJyPgomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyBpZiAoQUNQSV9GQUlMVVJFKHN0YXR1cykpIHs8YnI+CiYjNDM7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmIChzdGF0dXMgPT0gQUVfQ1RSTF9URVJNSU5BVEUpIHs8
YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAvKjxicj4KLSZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyAqIE5vdGU6IHRoZSBjdXJyZW50IG1lY2hhbmlzbSBkb2VzIG5vdCB1bnJlZ2lz
dGVyIGEgdGFibGUgaWYgaXQgaXM8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKiBkeW5h
bWljYWxseSB1bmxvYWRlZC4gVGhlIHJlbGF0ZWQgbmFtZXNwYWNlIGVudHJpZXMgYXJlIGRlbGV0
ZWQsPGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogYnV0IHRoZSB0YWJsZSByZW1haW5z
IGluIHRoZSByb290IHRhYmxlIGxpc3QuPGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICo8
YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKiBUaGUgYXNzdW1wdGlvbiBoZXJlIGlzIHRo
YXQgdGhlIG51bWJlciBvZiBkaWZmZXJlbnQgdGFibGVzIHRoYXQ8YnI+Ci0mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgKiB3aWxsIGJlIGxvYWRlZCBpcyBhY3R1YWxseSBzbWFsbCwgYW5kIHRoZXJl
IGlzIG1pbmltYWwgb3ZlcmhlYWQ8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKiBpbiBq
dXN0IGtlZXBpbmcgdGhlIHRhYmxlIGluIGNhc2UgaXQgaXMgbmVlZGVkIGFnYWluLjxicj4KLSZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAqPGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICog
SWYgdGhpcyBhc3N1bXB0aW9uIGNoYW5nZXMgaW4gdGhlIGZ1dHVyZSAocGVyaGFwcyBvbiBsYXJn
ZTxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAqIG1hY2hpbmVzIHdpdGggbWFueSB0YWJs
ZSBsb2FkL3VubG9hZCBvcGVyYXRpb25zKSwgdGFibGVzIHdpbGw8YnI+Ci0mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgKiBuZWVkIHRvIGJlIHVucmVnaXN0ZXJlZCB3aGVuIHRoZXkgYXJlIHVubG9h
ZGVkLCBhbmQgc2xvdHMgaW4gdGhlPGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogcm9v
dCB0YWJsZSBsaXN0IHNob3VsZCBiZSByZXVzZWQgd2hlbiBlbXB0eS48YnI+CiYjNDM7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogVGFibGUgd2FzIHVubG9hZGVkLCBhbGxvdyBpdCB0byBiZSBy
ZWxvYWRlZC48YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogQXMgd2UgYXJlIGdv
aW5nIHRvIHJldHVybiBBRV9PSyB0byB0aGUgY2FsbGVyLCB3ZSBzaG91bGQ8YnI+CiYjNDM7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogdGFrZSB0aGUgcmVzcG9uc2liaWxpdHkgb2YgZnJlZWlu
ZyB0aGUgaW5wdXQgZGVzY3JpcHRvci48YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
ICogUmVmaWxsIHRoZSBpbnB1dCBkZXNjcmlwdG9yIHRvIGVuc3VyZTxicj4KJiM0MzsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgKiBhY3BpX3RiX2luc3RhbGxfdGFibGVfd2l0aF9vdmVycmlkZSgp
IGNhbiBiZSBjYWxsZWQgYWdhaW4gdG88YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
ICogaW5kaWNhdGUgdGhlIHJlLWluc3RhbGxhdGlvbi48YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyAqLzxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBpZiAoYWNwaV9nYmxf
cm9vdF90YWJsZV9saXN0LnRhYmxlc1tpXS5mbGFncyAmYW1wOzxicj4KLSZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBBQ1BJX1RBQkxFX0lTX0xPQURFRCkgezxicj4K
LTxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyAvKiBUYWJsZSBpcyBzdGlsbCBsb2FkZWQsIHRoaXMgaXMgYW4gZXJy
b3IgKi88YnI+Ci08YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc3RhdHVzID0gQUVfQUxSRUFEWV9FWElTVFM7PGJy
PgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IGdvdG8gdW5sb2NrX2FuZF9leGl0Ozxicj4KLSZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyB9IGVsc2Ugezxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAvKjxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAqIFRhYmxl
IHdhcyB1bmxvYWRlZCwgYWxsb3cgaXQgdG8gYmUgcmVsb2FkZWQuPGJyPgotJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7ICogQXMgd2UgYXJlIGdvaW5nIHRvIHJldHVybiBBRV9PSyB0byB0aGUgY2FsbGVyLCB3ZSBz
aG91bGQ8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKiB0YWtlIHRoZSByZXNwb25zaWJpbGl0eSBvZiBm
cmVlaW5nIHRoZSBpbnB1dCBkZXNjcmlwdG9yLjxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAqIFJlZmls
bCB0aGUgaW5wdXQgZGVzY3JpcHRvciB0byBlbnN1cmU8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKiBh
Y3BpX3RiX2luc3RhbGxfdGFibGVfd2l0aF9vdmVycmlkZSgpIGNhbiBiZSBjYWxsZWQgYWdhaW4g
dG88YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKiBpbmRpY2F0ZSB0aGUgcmUtaW5zdGFsbGF0aW9uLjxi
cj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyAqLzxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBhY3BpX3RiX3VuaW5zdGFsbF90
YWJsZSgmYW1wO25ld190YWJsZV9kZXNjKTs8YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKHZvaWQpYWNwaV91dF9y
ZWxlYXNlX211dGV4KEFDUElfTVRYX1RBQkxFUyk7PGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICp0YWJsZV9pbmRl
eCA9IGk7PGJyPgotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHJldHVybl9BQ1BJX1NUQVRVUyhBRV9PSyk7PGJyPgotJm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IH08YnI+CiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFjcGlfdGJfdW5p
bnN0YWxsX3RhYmxlKCZhbXA7bmV3X3RhYmxlX2Rlc2MpOzxicj4KJiM0MzsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgKHZvaWQpYWNwaV91dF9yZWxlYXNlX211dGV4KEFDUElfTVRYX1RBQkxFUyk7PGJyPgom
IzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyByZXR1cm5fQUNQSV9TVEFUVVMoQUVfT0spOzxicj4KJm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08YnI+CiYjNDM7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IGdvdG8gdW5sb2NrX2FuZF9leGl0Ozxicj4KJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08YnI+CiZuYnNwOzxicj4KJm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC8qIEFkZCB0aGUg
dGFibGUgdG8gdGhlIGdsb2JhbCByb290IHRhYmxlIGxpc3QgKi88YnI+CkBAIC0zNTAsOSAmIzQz
OzI2MiwxMSBAQCB2b2lkIGFjcGlfdGJfb3ZlcnJpZGVfdGFibGUoc3RydWN0IGFjcGlfdGFibGVf
ZGVzYyAqb2xkX3RhYmxlX2Rlc2MpPGJyPgombmJzcDs8YnI+CiZuYnNwO2ZpbmlzaF9vdmVycmlk
ZTo8YnI+CiZuYnNwOzxicj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAv
KiBWYWxpZGF0ZSBhbmQgdmVyaWZ5IGEgdGFibGUgYmVmb3JlIG92ZXJyaWRpbmcgKi88YnI+Ci08
YnI+Ci0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc3RhdHVzID0gYWNwaV90
Yl92ZXJpZnlfdGVtcF90YWJsZSgmYW1wO25ld190YWJsZV9kZXNjLCBOVUxMKTs8YnI+CiYjNDM7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC8qPGJyPgomIzQzOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAqIFZhbGlkYXRlIGFuZCB2ZXJpZnkg
YSB0YWJsZSBiZWZvcmUgb3ZlcnJpZGluZywgbm8gbmVzdGVkIHRhYmxlPGJyPgomIzQzOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAqIGR1cGxpY2F0aW9uIGNoZWNr
IGFzIGl0J3MgdG9vIGNvbXBsaWNhdGVkIGFuZCB1bm5lY2Vzc2FyeS48YnI+CiYjNDM7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICovPGJyPgomIzQzOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBzdGF0dXMgPSBhY3BpX3RiX3ZlcmlmeV90ZW1w
X3RhYmxlKCZhbXA7bmV3X3RhYmxlX2Rlc2MsIE5VTEwsIE5VTEwpOzxicj4KJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmIChBQ1BJX0ZBSUxVUkUoc3Rh
dHVzKSkgezxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHJldHVy
bjs8YnI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB9
PGJyPgotLSA8YnI+CjIuNy40PGJyPgo8YnI+Cjxicj4KPGJyPgotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS08YnI+Cjxicj4KU3ViamVjdDogRGlnZXN0IEZvb3Rlcjxicj4KPGJyPgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj4KRGV2ZWwgbWFp
bGluZyBsaXN0PGJyPgpEZXZlbEBhY3BpY2Eub3JnPGJyPgo8YSBocmVmPSJodHRwczovL2xpc3Rz
LmFjcGljYS5vcmcvbWFpbG1hbi9saXN0aW5mby9kZXZlbCI+aHR0cHM6Ly9saXN0cy5hY3BpY2Eu
b3JnL21haWxtYW4vbGlzdGluZm8vZGV2ZWw8L2E+PGJyPgo8YnI+Ci0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLTxicj4KPGJyPgpFbmQgb2YgRGV2ZWwgRGlnZXN0LCBWb2wgNzcsIElzc3Vl
IDI8YnI+CioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKjxicj4KPC9kaXY+Cjwv
c3Bhbj48L2ZvbnQ+SU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwg
YW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2
aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90
aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVu
dHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlCiBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3Jl
IG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4KPC9ib2R5
Pgo8L2h0bWw+Cg==

--===============0590618997345510755==--

