Content-Type: multipart/mixed; boundary="===============3887363265148407356=="
MIME-Version: 1.0
From: Shameer Kolothum <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] [RFC PATCH v2 5/8] iommu/arm-smmu-v3: Introduce strtab init
 helper
Date: Thu, 19 Nov 2020 12:11:47 +0000
Message-ID: <20201119121150.3316-6-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: 20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3887363265148407356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Introduce a helper to check the sid range and to init the l2 strtab
entries(bypass). This will be useful when we have to initialize the
l2 strtab for RMR SIDs.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 26 ++++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/ar=
m/arm-smmu-v3/arm-smmu-v3.c
index e634bbe60573..1953b317d814 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2308,6 +2308,19 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_de=
vice *smmu, u32 sid)
 =

 static struct iommu_ops arm_smmu_ops;
 =

+static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
+{
+	/* Check the SIDs are in range of the SMMU and our stream table */
+	if (!arm_smmu_sid_in_range(smmu, sid))
+		return -ERANGE;
+
+	/* Ensure l2 strtab is initialised */
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
+		return arm_smmu_init_l2_strtab(smmu, sid);
+
+	return 0;
+}
+
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 {
 	int i, ret;
@@ -2336,21 +2349,12 @@ static struct iommu_device *arm_smmu_probe_device(s=
truct device *dev)
 	INIT_LIST_HEAD(&master->bonds);
 	dev_iommu_priv_set(dev, master);
 =

-	/* Check the SIDs are in range of the SMMU and our stream table */
 	for (i =3D 0; i < master->num_sids; i++) {
 		u32 sid =3D master->sids[i];
 =

-		if (!arm_smmu_sid_in_range(smmu, sid)) {
-			ret =3D -ERANGE;
+		ret =3D arm_smmu_init_sid_strtab(smmu, sid);
+		if (ret)
 			goto err_free_master;
-		}
-
-		/* Ensure l2 strtab is initialised */
-		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
-			ret =3D arm_smmu_init_l2_strtab(smmu, sid);
-			if (ret)
-				goto err_free_master;
-		}
 	}
 =

 	master->ssid_bits =3D min(smmu->ssid_bits, fwspec->num_pasid_bits);
-- =

2.17.1

--===============3887363265148407356==--

