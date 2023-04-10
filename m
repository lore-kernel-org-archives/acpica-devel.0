Return-Path: <void0red@hust.edu.cn>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D400812CF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8314D812BB
From: Kang Chen <void0red@hust.edu.cn>
Message-Id: <20230410093601.3945712-1-void0red@hust.edu.cn>
In-Reply-To: <CAJZ5v0gPUBFzuFiRWW8KHAwB1Agy+Le=CWuRD0RTr4MkNeEmQw@mail.gmail.com>
References: <CAJZ5v0gPUBFzuFiRWW8KHAwB1Agy+Le=CWuRD0RTr4MkNeEmQw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH v2] ACPICA: check null return of
	ACPI_ALLOCATE_ZEROED in acpi_db_display_objects
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Mon, 10 Apr 2023 09:47:25 -0000
To: rafael@kernel.org
Cc: void0red@gmail.com, rafael.j.wysocki@intel.com, robert.moore@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, lenb@kernel.org

From: Kang Chen <void0red@gmail.com>

ACPI_ALLOCATE_ZEROED may fails, object_info might be null and will
cause null pointer dereference later.

Link: https://github.com/acpica/acpica/commit/84b3752cfa0ce4b0ebecae5e193c937b8ed6e278
Signed-off-by: Kang Chen <void0red@gmail.com>
---
v2 -> v1: add a github link

 drivers/acpi/acpica/dbnames.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index 3615e1a6e..b91155ea9 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -652,6 +652,9 @@ acpi_status acpi_db_display_objects(char *obj_type_arg, char *display_count_arg)
 		object_info =
 		    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_object_info));
 
+		if (!object_info)
+			return (AE_NO_MEMORY);
+
 		/* Walk the namespace from the root */
 
 		(void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
-- 
2.34.1

