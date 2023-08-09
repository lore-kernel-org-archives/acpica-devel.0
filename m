Return-Path: <ivan.hu@canonical.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ECCCB41864
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CCEF041866
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1691574294;
 bh=hOaugecDmx8s0gF6A+lggXyk/CKpYFWeAHRtbZ38wmQ=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=krEUXcKKWwLdM/4fRl825m892/v34MgmuwWro79QtqU8vpVBCmCF0NywZfAFHmF9N
 QkWBtzJjoQgbsnsA62vPlYe3buqGZVVjWJOowOzDHUu6Ca4oiaM3PKfELpUlTgco4p
 ax6sFCJNerT2298+r2rpbA05jEDvE8wTvyn0JYZFVJM1uHldg4vDG9JVk3NKyHoQOG
 QWQXYz9ahOiQatA0zoR8+IROgC3b8lGiyPCHVpbFfc3jBqJVC8px+KFSPOdnmN0xLG
 y+RqJYd341kMgcxEADfL/U922Ol4O0a5z0u4WrXSzJZpRnAHBHRV3KaZbpYvcktYj9
 X1/CGGxf2us4Q==
From: Ivan Hu <ivan.hu@canonical.com>
Date: Wed,  9 Aug 2023 17:44:51 +0800
Message-Id: <20230809094451.15473-1-ivan.hu@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH] ACPI: thermal: extend the acpi maximum
	handles for _PSL method
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

Several platforms encountered the following kernel message:
ACPI: \_TZ_.BATZ: Invalid passive threshold

This issue arises due to the failure of the acpi_evaluate_reference function
in drivers/acpi/thermal.c while evaluating the ACPI _PSL method.

status = acpi_evaluate_reference(tz->device->handle, "_PSL",
			 NULL, &devices);
if (ACPI_FAILURE(status)) {
	acpi_handle_info(tz->device->handle,
			 "Invalid passive threshold\n");
	tz->trips.passive.valid = false;
} else {
	tz->trips.passive.valid = true;
}

However, the root cause lies in the _PSL method returning packages with a count
exceeding ACPI_MAX_HANDLES in acpi_evaluate_reference.

As per the ACPI specification, the _PSL (Passive List) method is defined under
a thermal zone and evaluates to a list of processor objects to be used for
passive cooling. And it will return a variable-length Package containing a list
of References to processor objects.

Signed-off-by: Ivan Hu <ivan.hu@canonical.com>
---
 include/acpi/acpi_bus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 23fbe4a16972..dc7b38826113 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -13,7 +13,7 @@
 #include <linux/property.h>
 
 /* TBD: Make dynamic */
-#define ACPI_MAX_HANDLES	10
+#define ACPI_MAX_HANDLES	32
 struct acpi_handle_list {
 	u32 count;
 	acpi_handle handles[ACPI_MAX_HANDLES];
-- 
2.34.1

