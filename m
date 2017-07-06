Content-Type: multipart/mixed; boundary="===============5204600075113260198=="
MIME-Version: 1.0
From: Ross Zwisler <ross.zwisler at linux.intel.com>
Subject: [Devel] [RFC v2 1/5] acpi: add missing include in acpi_numa.h
Date: Thu, 06 Jul 2017 15:52:29 -0600
Message-ID: <20170706215233.11329-2-ross.zwisler@linux.intel.com>
In-Reply-To: 20170706215233.11329-1-ross.zwisler@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5204600075113260198==
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


--===============5204600075113260198==--

