Content-Type: multipart/mixed; boundary="===============0309938490093114416=="
MIME-Version: 1.0
From: Shameer Kolothum <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] [RFC PATCH v2 7/8] iommu/arm-smmu-v3: Get associated RMR info
 and install bypass STE
Date: Thu, 19 Nov 2020 12:11:49 +0000
Message-ID: <20201119121150.3316-8-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: 20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0309938490093114416==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Check if there is any RMR info associated=C2=A0with the devices behind
the SMMUv3 and if any, install bypass STEs for them. This is to
keep any ongoing traffic associated with these devices alive
when we enable/reset SMMUv3 during probe().

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 40 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/ar=
m/arm-smmu-v3/arm-smmu-v3.c
index 5f366d5a9ebf..97df1df001c9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3486,6 +3486,42 @@ static void __iomem *arm_smmu_ioremap(struct device =
*dev, resource_size_t start,
 	return devm_ioremap_resource(dev, &res);
 }
 =

+static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
+{
+	struct iommu_rmr *e;
+	int i, ret;
+
+	/*
+	 * Since, we don't have a mechanism to differentiate the RMR
+	 * SIDs that has an ongoing live stream, install bypass STEs
+	 * for all the reported ones.=C2=A0
+	 * FixMe: Avoid duplicate SIDs in the list as one sid may
+	 *        associate with multiple RMRs.
+	 */
+	list_for_each_entry(e, &smmu->rmr_list, list) {
+		for (i =3D 0; i < e->num_ids; i++) {
+			__le64 *step;
+			u32 sid =3D e->ids[i];
+
+			ret =3D arm_smmu_init_sid_strtab(smmu, sid);
+			if (ret) {
+				dev_err(smmu->dev, "RMR bypass(0x%x) failed\n",
+					sid);
+				continue;
+			}
+
+			step =3D arm_smmu_get_step_for_sid(smmu, sid);
+			arm_smmu_write_strtab_ent(NULL, sid, step, true);
+		}
+	}
+}
+
+static int arm_smmu_get_rmr(struct arm_smmu_device *smmu)
+{
+	INIT_LIST_HEAD(&smmu->rmr_list);
+	return iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &smmu->rmr_list);
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -3569,6 +3605,10 @@ static int arm_smmu_device_probe(struct platform_dev=
ice *pdev)
 	/* Record our private device structure */
 	platform_set_drvdata(pdev, smmu);
 =

+	/* Check for RMRs and install bypass STEs if any */
+	if (!arm_smmu_get_rmr(smmu))
+		arm_smmu_rmr_install_bypass_ste(smmu);
+
 	/* Reset the device */
 	ret =3D arm_smmu_device_reset(smmu, bypass);
 	if (ret)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/ar=
m/arm-smmu-v3/arm-smmu-v3.h
index d4b7f40ccb02..17b517ddecee 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -636,6 +636,8 @@ struct arm_smmu_device {
 =

 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+
+	struct list_head		rmr_list;
 };
 =

 /* SMMU private data for each master */
-- =

2.17.1

--===============0309938490093114416==--

