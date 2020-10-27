Content-Type: multipart/mixed; boundary="===============2623274206640579830=="
MIME-Version: 1.0
From: Shameer Kolothum <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] [RFC PATCH 3/4] ACPI/IORT: Add RMR memory regions reservation
 helper
Date: Tue, 27 Oct 2020 11:26:45 +0000
Message-ID: <20201027112646.44680-4-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: 20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2623274206640579830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a helper function that retrieves RMR memory descriptors
associated with a given endpoint dev. These memory regions
should have a unity=C2=A0mapping in the SMMU. So reserve them as
IOMMU_RESV_DIRECT.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>
---
 drivers/acpi/arm64/iort.c | 56 +++++++++++++++++++++++++++++++++++++++
 include/linux/acpi_iort.h |  4 +++
 2 files changed, 60 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index b32cd53cca08..c0700149e60b 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -842,6 +842,60 @@ static inline int iort_add_device_replay(struct device=
 *dev)
 	return err;
 }
 =

+static bool iort_dev_has_rmr(struct device *dev, struct iort_rmr_entry *e)
+{
+	struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
+	struct acpi_iort_node *iommu;
+	struct iort_rmr_id *rmr_ids =3D e->rmr_ids;
+	int i, j;
+
+	iommu =3D iort_get_iort_node(fwspec->iommu_fwnode);
+
+	for (i =3D 0; i < e->rmr_ids_num; i++, rmr_ids++) {
+		for (j =3D 0; j < fwspec->num_ids; j++) {
+			if (rmr_ids->sid =3D=3D fwspec->ids[j] &&
+			    rmr_ids->smmu =3D=3D iommu)
+				return true;
+		}
+	}
+
+	return false;
+}
+
+/**
+ * iort_dev_rmr_get_resv_regions - RMR Reserved region driver helper
+ * @dev: Device from iommu_get_resv_regions()
+ * @head: Reserved region list from iommu_get_resv_regions()
+ *
+ * Returns: 0 on success, <0 failure
+ */
+int iort_dev_rmr_get_resv_regions(struct device *dev, struct list_head *he=
ad)
+{
+	struct iort_rmr_entry *e;
+
+	list_for_each_entry(e, &iort_rmr_list, list) {
+		struct iommu_resv_region *region;
+		struct acpi_iort_rmr_desc *rmr;
+		int prot =3D IOMMU_READ | IOMMU_WRITE |
+			   IOMMU_NOEXEC | IOMMU_MMIO;
+
+		if (!iort_dev_has_rmr(dev, e))
+			continue;
+
+		rmr =3D e->rmr_desc;
+		region =3D iommu_alloc_resv_region(rmr->base_address,
+						 rmr->length, prot,
+						 IOMMU_RESV_DIRECT);
+		if (!region) {
+			dev_err(dev, "Out of memory allocating RMR regions\n");
+			return -ENOMEM;
+		}
+		list_add_tail(&region->list, head);
+	}
+
+	return 0;
+}
+
 /**
  * iort_iommu_msi_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
@@ -1112,6 +1166,8 @@ int iort_iommu_msi_get_resv_regions(struct device *de=
v, struct list_head *head)
 const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
 						const u32 *input_id)
 { return NULL; }
+int iort_dev_rmr_get_resv_regions(struct device *dev, struct list_head *he=
ad)
+{ return 0; }
 #endif
 =

 static int nc_dma_get_range(struct device *dev, u64 *size)
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 20a32120bb88..6dd89faf340c 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -38,6 +38,7 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u6=
4 *size);
 const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
 						const u32 *id_in);
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *=
head);
+int iort_dev_rmr_get_resv_regions(struct device *dev, struct list_head *he=
ad);
 #else
 static inline void acpi_iort_init(void) { }
 static inline u32 iort_msi_map_id(struct device *dev, u32 id)
@@ -55,6 +56,9 @@ static inline const struct iommu_ops *iort_iommu_configur=
e_id(
 static inline
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *=
head)
 { return 0; }
+static inline
+int iort_dev_rmr_get_resv_regions(struct device *dev, struct list_head *he=
ad)
+{ return 0; }
 #endif
 =

 #endif /* __ACPI_IORT_H__ */
-- =

2.17.1

--===============2623274206640579830==--

