Content-Type: multipart/mixed; boundary="===============3664968786720660520=="
MIME-Version: 1.0
From: Ross Zwisler <ross.zwisler at linux.intel.com>
Subject: [Devel] [PATCH 1/2] acpi: add missing include in acpi_numa.h
Date: Fri, 21 Jul 2017 16:51:23 -0600
Message-ID: <20170721225124.15297-1-ross.zwisler@linux.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3664968786720660520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Right now if a file includes acpi_numa.h and they don't happen to include
linux/numa.h before it, they get the following warning:

./include/acpi/acpi_numa.h:9:5: warning: "MAX_NUMNODES" is not defined [-Wu=
ndef]
 #if MAX_NUMNODES > 256
     ^~~~~~~~~~~~

Signed-off-by: Ross Zwisler <ross.zwisler(a)linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>
---

These two small fixes were previously part of my HMAT enabling series, but
I thought I'd submit them seperately so they don't get held up while I'm
iterating that series.

---
 include/acpi/acpi_numa.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
index d4b7294..1e3a74f 100644
--- a/include/acpi/acpi_numa.h
+++ b/include/acpi/acpi_numa.h
@@ -3,6 +3,7 @@
 =

 #ifdef CONFIG_ACPI_NUMA
 #include <linux/kernel.h>
+#include <linux/numa.h>
 =

 /* Proximity bitmap length */
 #if MAX_NUMNODES > 256
-- =

2.9.4


--===============3664968786720660520==--

