Return-Path: <raag.jadav@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0FB5D43271
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 140B840122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697791697; x=1729327697;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=rSipyHhM4gYIUQSn5eaLq9kVKKAAb0HFtJJ9r0gwffo=;
 b=Q6AMTih+8TuDtvh6PRZu2ITQ9IZlMSzAKnYyJebVTa8f+9nkCkLuDCT5
 vhLg+RAMcBZFSxHYKj/oYZDelq9PayCt4hdQJnh94jrgvwlqZkwvckVY2
 Im0TEi3G9dwRPbegLlPDqzF13AiFEPkK+EqSXrgtguIOtaI4GErj5DJq/
 LjjW4ryxn+UvPQWmg/oAzCGVRdb51V1hwmxGJmnHEmU859f00qU2gYDOa
 mKk5Iv0uj5h53CE6XdB3dwUqjib8TKnvVs0EhEB244Fue6GUw6X/uydnO
 YhlGJuJjHlM03Bpx3620LGjvVi4dR5XAH+8dbsVWt78i2PmgwZ1nc1PJu Q==;
From: Raag Jadav <raag.jadav@intel.com>
Date: Fri, 20 Oct 2023 14:17:30 +0530
Message-Id: <20231020084732.17130-7-raag.jadav@intel.com>
In-Reply-To: <20231020084732.17130-1-raag.jadav@intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
Subject: [Acpica-devel] [PATCH v1 6/8] perf: qcom: use acpi_device_uid() for
	fetching _UID
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org, linux-gpio@vger.kernel.org, Raag Jadav <raag.jadav@intel.com>, mallikarjunappa.sangannavar@intel.com, linux-kernel@vger.kernel.org, bala.senthil@intel.com, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, linux-arm-kernel@lists.infradead.org

Convert manual _UID references to use standard ACPI helpers.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/perf/qcom_l3_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index 2887edb4eb0b..f16783d03db7 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -742,8 +742,8 @@ static int qcom_l3_cache_pmu_probe(struct platform_device *pdev)
 
 	l3pmu = devm_kzalloc(&pdev->dev, sizeof(*l3pmu), GFP_KERNEL);
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "l3cache_%s_%s",
-		      acpi_dev_parent(acpi_dev)->pnp.unique_id,
-		      acpi_dev->pnp.unique_id);
+		      acpi_device_uid(acpi_dev_parent(acpi_dev)),
+		      acpi_device_uid(acpi_dev));
 	if (!l3pmu || !name)
 		return -ENOMEM;
 
-- 
2.17.1

