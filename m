Content-Type: multipart/mixed; boundary="===============5493700617526910473=="
MIME-Version: 1.0
From: kbuild test robot <lkp at intel.com>
Subject: [Devel] [RFC PATCH] battery: hook_mutex can be static
Date: Sat, 23 Dec 2017 19:04:30 +0800
Message-ID: <20171223110430.GA50455@xian>
In-Reply-To: 20171220151536.GA12278@thinkpad
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5493700617526910473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Fixes: 19380b8e214c ("battery: Add the battery hooking API")
Signed-off-by: Fengguang Wu <fengguang.wu(a)intel.com>
---
 battery.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 1794408..9324591 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -640,9 +640,9 @@ static const struct device_attribute alarm_attr =3D {
 =

 LIST_HEAD(acpi_battery_list);
 LIST_HEAD(battery_hook_list);
-DEFINE_MUTEX(hook_mutex);
+static DEFINE_MUTEX(hook_mutex);
 =

-void __battery_hook_unregister(struct acpi_battery_hook *hook, int force)
+static void __battery_hook_unregister(struct acpi_battery_hook *hook, int =
force)
 {
 	struct list_head *position;
 	struct acpi_battery *battery;

--===============5493700617526910473==--

