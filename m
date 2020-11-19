Content-Type: multipart/mixed; boundary="===============6187358091912277118=="
MIME-Version: 1.0
From: Shameer Kolothum <shameerali.kolothum.thodi at huawei.com>
Subject: =?utf-8?q?=5BDevel=5D__=5BRFC_PATCH_v2_6/8=5D_iommu/arm-smmu-v3=3A_Add_by?=
 =?utf-8?q?pass_flag_to=C2=A0arm=5Fsmmu=5Fwrite=5Fstrtab=5Fent=28=29?=
Date: Thu, 19 Nov 2020 12:11:48 +0000
Message-ID: <20201119121150.3316-7-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: 20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6187358091912277118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

By default,=C2=A0disable_bypass is set and any dev without an iommu domain
installs STE with CFG_ABORT during=C2=A0arm_smmu_init_bypass_stes(). Introd=
uce
a "bypass" flag to=C2=A0arm_smmu_write_strtab_ent() so that we can force it=
 to
install=C2=A0CFG_BYPASS STE for specific SIDs. This will be=C2=A0useful=C2=
=A0for RMR
related SIDs.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/ar=
m/arm-smmu-v3/arm-smmu-v3.c
index 1953b317d814..5f366d5a9ebf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1174,7 +1174,7 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu=
_device *smmu, u32 sid)
 }
 =

 static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 =
sid,
-				      __le64 *dst)
+				      __le64 *dst, bool bypass)
 {
 	/*
 	 * This is hideously complicated, but we only really care about
@@ -1245,7 +1245,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu=
_master *master, u32 sid,
 =

 	/* Bypass/fault */
 	if (!smmu_domain || !(s1_cfg || s2_cfg)) {
-		if (!smmu_domain && disable_bypass)
+		if (!smmu_domain && disable_bypass && !bypass)
 			val |=3D FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
 		else
 			val |=3D FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
@@ -1317,7 +1317,7 @@ static void arm_smmu_init_bypass_stes(__le64 *strtab,=
 unsigned int nent)
 	unsigned int i;
 =

 	for (i =3D 0; i < nent; ++i) {
-		arm_smmu_write_strtab_ent(NULL, -1, strtab);
+		arm_smmu_write_strtab_ent(NULL, -1, strtab, false);
 		strtab +=3D STRTAB_STE_DWORDS;
 	}
 }
@@ -2038,7 +2038,7 @@ static void arm_smmu_install_ste_for_dev(struct arm_s=
mmu_master *master)
 		if (j < i)
 			continue;
 =

-		arm_smmu_write_strtab_ent(master, sid, step);
+		arm_smmu_write_strtab_ent(master, sid, step, false);
 	}
 }
 =

-- =

2.17.1

--===============6187358091912277118==--

