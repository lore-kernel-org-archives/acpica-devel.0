Content-Type: multipart/mixed; boundary="===============8883590203202976085=="
MIME-Version: 1.0
From: Shameer Kolothum <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] [RFC PATCH v2 3/8] iommu/dma: Introduce generic helper to
 retrieve RMR info
Date: Thu, 19 Nov 2020 12:11:45 +0000
Message-ID: <20201119121150.3316-4-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: 20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8883590203202976085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Reserved Memory Regions(RMR) associated with an IOMMU may be
described either through ACPI tables or DT in systems with
devices that require a unity mapping or bypass for those
regions in IOMMU drivers.

Introduce a generic interface so that IOMMU drivers can retrieve
and set up necessary mappings.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>
---
 drivers/iommu/dma-iommu.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h |  7 +++++++
 include/linux/iommu.h     | 16 ++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0cbcd3fc3e7e..d73768ecdd1a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -166,6 +166,42 @@ void iommu_dma_get_resv_regions(struct device *dev, st=
ruct list_head *list)
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 =

+/**
+ * iommu_dma_get_rmrs - Retrieve Reserved Memory Regions(RMRs) associated
+ *                      with a given IOMMU
+ * @iommu_fwnode: fwnode associated with IOMMU
+ * @list: RMR list to be populated
+ *
+ */
+int iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode,
+		       struct list_head *list)
+{
+	return 0;
+}
+EXPORT_SYMBOL(iommu_dma_get_rmrs);
+
+struct iommu_rmr *iommu_dma_alloc_rmr(u64 base, u64 length,
+				      u32 *ids, int num_ids)
+{
+	struct iommu_rmr *rmr;
+	int i;
+
+	rmr =3D kzalloc(struct_size(rmr, ids, num_ids), GFP_KERNEL);
+	if (!rmr)
+		return NULL;
+
+	INIT_LIST_HEAD(&rmr->list);
+	rmr->base_address =3D base;
+	rmr->length =3D length;
+	rmr->num_ids =3D num_ids;
+
+	for (i =3D 0; i < num_ids; i++)
+		rmr->ids[i] =3D ids[i];
+
+	return rmr;
+}
+EXPORT_SYMBOL(iommu_dma_alloc_rmr);
+
 static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
 		phys_addr_t start, phys_addr_t end)
 {
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 2112f21f73d8..8900ccbc9e6a 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -37,6 +37,9 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 =

 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list=
);
 =

+int iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct list_head *list=
);
+struct iommu_rmr *iommu_dma_alloc_rmr(u64 base, u64 length,
+				      u32 *ids, int num_ids);
 #else /* CONFIG_IOMMU_DMA */
 =

 struct iommu_domain;
@@ -78,5 +81,9 @@ static inline void iommu_dma_get_resv_regions(struct devi=
ce *dev, struct list_he
 {
 }
 =

+int iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct list_head *list=
);
+{
+	return 0;
+}
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b95a6f8db6ff..e43c4e8084e7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -592,6 +592,22 @@ struct iommu_sva {
 	struct device			*dev;
 };
 =

+/**
+ * struct iommu_rmr - Reserved Memory Region details per IOMMU
+ * @list: Linked list pointers to hold RMR region info
+ * @base_address: base address of Reserved Memory Region
+ * @length: length of memory region
+ * @num_ids: number of associated device IDs
+ * @ids: associated device IDs
+ */
+struct iommu_rmr {
+	struct list_head	list;
+	phys_addr_t		base_address;
+	u64			length;
+	unsigned int		num_ids;
+	u32			ids[];
+};
+
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwno=
de,
 		      const struct iommu_ops *ops);
 void iommu_fwspec_free(struct device *dev);
-- =

2.17.1

--===============8883590203202976085==--

