Content-Type: multipart/mixed; boundary="===============9113646612469162909=="
MIME-Version: 1.0
From: Shameer Kolothum <shameerali.kolothum.thodi at huawei.com>
Subject: =?utf-8?q?=5BDevel=5D__=5BRFC_PATCH_v2_8/8=5D_iommu/arm-smmu-v3=3A_Reserv?=
 =?utf-8?q?e_any_RMR_regions_associated_with_a=C2=A0dev?=
Date: Thu, 19 Nov 2020 12:11:50 +0000
Message-ID: <20201119121150.3316-9-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: 20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9113646612469162909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Get RMR regions associated with a dev=C2=A0reserved so that there is
a unity mapping for them in=C2=A0SMMU.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 38 +++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/ar=
m/arm-smmu-v3/arm-smmu-v3.c
index 97df1df001c9..174a9bcfd627 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2492,6 +2492,43 @@ static int arm_smmu_of_xlate(struct device *dev, str=
uct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 =

+static bool arm_smmu_dev_has_rmr(struct arm_smmu_master *master,
+				 struct iommu_rmr *e)
+{
+	int i, j;
+
+	for (i =3D 0; i < master->num_sids; i++) {
+		for (j =3D 0; j < e->num_ids; j++) {
+			if (e->ids[j] =3D=3D master->sids[i])
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static void arm_smmu_rmr_get_resv_regions(struct device *dev,
+					  struct list_head *head)
+{
+	struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu =3D master->smmu;
+	struct iommu_rmr *rmr;
+
+	list_for_each_entry(rmr, &smmu->rmr_list, list) {
+		struct iommu_resv_region *region;
+		int prot =3D IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+
+		if (!arm_smmu_dev_has_rmr(master, rmr))
+			continue;
+		region =3D iommu_alloc_resv_region(rmr->base_address,
+						 rmr->length, prot,
+						 IOMMU_RESV_DIRECT);
+		if (!region)
+			return;
+
+		list_add_tail(&region->list, head);
+	}
+}
 static void arm_smmu_get_resv_regions(struct device *dev,
 				      struct list_head *head)
 {
@@ -2506,6 +2543,7 @@ static void arm_smmu_get_resv_regions(struct device *=
dev,
 	list_add_tail(&region->list, head);
 =

 	iommu_dma_get_resv_regions(dev, head);
+	arm_smmu_rmr_get_resv_regions(dev, head);
 }
 =

 static bool arm_smmu_dev_has_feature(struct device *dev,
-- =

2.17.1

--===============9113646612469162909==--

