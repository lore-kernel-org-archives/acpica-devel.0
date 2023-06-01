Return-Path: <michal.wilczynski@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 742756132F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 88E9E60F5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685625709; x=1717161709;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LDh3/ulcjpVzc1kWMXWyk72lw2x2F5XCJG1Yb1dhhKw=;
 b=IIifFB/XN7cmxihAwzfPaOsSrnwyTQa4g/nwQeIkyX7s+6NMiOI4eNIW
 pw9v3j8cHzqARqPY5CIVqhW1z/SWMcWVNMXPsuQmv5svvEtSsP3nf/QRg
 ktc+Q5cXPm8l3nOXXWQTHTm6gwzyTKTbi9gsXg0H9lrC1eQMOJFhgeA4Y
 NsFbMX5X5IdobzoGGwp3aki2kUAZaPx0MkpTKpT8xHJwgtlstYFUQTG3H
 KiICLv90iFWOTY5Se8r9HR9Y8wmlXeq43DPXxKv6Lho/+Ym+D9XredWrq
 WvfAZ1xz+wQVQAC6C318CHV4WADG6qy3lyssLxL7DTjTT5Jux0Ndfg0uD g==;
From: Michal Wilczynski <michal.wilczynski@intel.com>
Date: Thu,  1 Jun 2023 15:21:37 +0200
Message-Id: <20230601132137.301802-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH v4 35/35] acpi/bus: Remove notify callback
	and flags
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com, ira.weiny@intel.com, rui.zhang@intel.com, jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org, lars@metafoo.de, bleung@chromium.org, yu.c.chen@intel.com, hdegoede@redhat.com, markgross@kernel.org, luzmaximilian@gmail.com, corentin.chary@gmail.com, jprvita@gmail.com, cascardo@holoscopio.com, don@syst.com.br, pali@kernel.org, jwoithe@just42.net, matan@svgalib.org, kenneth.t.chan@gmail.com, malattia@linux.it, jeremy@system76.com, productdev@system76.com, herton@canonical.com, coproscefalo@gmail.com, tytso@mit.edu, Jason@zx2c4.com, robert.moore@intel.com
Cc: linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev, Michal Wilczynski <michal.wilczynski@intel.com>, nvdimm@lists.linux.dev, linux-iio@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org

As callback has been replaced by drivers installing their handlers in
.add it's presence is not useful anymore.

Remove .notify callback and flags variable from struct acpi_driver,
as they're not needed anymore.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 include/acpi/acpi_bus.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 7fb411438b6f..3326794d5b70 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -151,12 +151,10 @@ struct acpi_hotplug_context {
 
 typedef int (*acpi_op_add) (struct acpi_device * device);
 typedef void (*acpi_op_remove) (struct acpi_device *device);
-typedef void (*acpi_op_notify) (struct acpi_device * device, u32 event);
 
 struct acpi_device_ops {
 	acpi_op_add add;
 	acpi_op_remove remove;
-	acpi_op_notify notify;
 };
 
 #define ACPI_DRIVER_ALL_NOTIFY_EVENTS	0x1	/* system AND device events */
@@ -165,7 +163,6 @@ struct acpi_driver {
 	char name[80];
 	char class[80];
 	const struct acpi_device_id *ids; /* Supported Hardware IDs */
-	unsigned int flags;
 	struct acpi_device_ops ops;
 	struct device_driver drv;
 	struct module *owner;
-- 
2.40.1

