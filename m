Content-Type: multipart/mixed; boundary="===============0221083633303545068=="
MIME-Version: 1.0
From: Ross Zwisler <ross.zwisler at linux.intel.com>
Subject: [Devel] [PATCH 2/2] acpi: Fix typo in SRAT table name
Date: Fri, 21 Jul 2017 16:51:24 -0600
Message-ID: <20170721225124.15297-2-ross.zwisler@linux.intel.com>
In-Reply-To: 20170721225124.15297-1-ross.zwisler@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0221083633303545068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To save someone the time of searching the ACPI spec for "Static Resource
Affinity Table".

Signed-off-by: Ross Zwisler <ross.zwisler(a)linux.intel.com>
---
 drivers/acpi/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index edb0c79..917f1cc 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -443,7 +443,7 @@ int __init acpi_numa_init(void)
 	 * So go over all cpu entries in SRAT to get apicid to node mapping.
 	 */
 =

-	/* SRAT: Static Resource Affinity Table */
+	/* SRAT: System Resource Affinity Table */
 	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
 		struct acpi_subtable_proc srat_proc[3];
 =

-- =

2.9.4


--===============0221083633303545068==--

