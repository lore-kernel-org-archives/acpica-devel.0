Return-Path: <jgg@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 67D604011A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2773540124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywgd3HRS4oK39R26TqVY+MWvg9q8mZK2BdG9RN/u22A=;
 b=SyL2cOUyv00dS5YEl5lQ+AlGwI79I69+//iQR3SQKxsCTstWRo34Iha1tXDLYwNmWK5uQygtbgwzZa4n336qItTqK7jgvmGDoVAjpq3vPnnhn2WJSRmmWjrkiln0z/qGACjcJtDcb76TKG2orePjsRqjZPe5NcuV1stvC91HKjlvMLdwpJ5LAdMWU5XyGYuYJertb4bpR4pBIGMHi7cJ+BJe9W6peMVHviqNNQt8jNcvFv+PCABcWAajUXHu4soYbBXFNp08BphGSLauS14jlrPpTqAQv6LPwoEPZjdDqnl9jK1zr8XllFxOOKLClK3wqwKIEl/PzZ7T5QVsFaDJdQ==
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri,  3 Nov 2023 13:44:45 -0300
Message-ID: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Acpica-devel] [PATCH RFC 00/17] Solve iommu probe races around
	iommu_fwspec
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: acpica-devel@lists.linuxfoundation.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, Jean-Philippe Brucker <jean-philippe@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Peter <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>, virtualization@lists.linux-foundation.org, Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>

This is a more complete solution that the first attempt here:
https://lore.kernel.org/r/1698825902-10685-1-git-send-email-quic_zhenhuah@quicinc.com

I haven't been able to test this on any HW that touches these paths, so if
some people with HW can help get it in shape it can become non-RFC.


The iommu subsystem uses dev->iommu to store bits of information about the
attached iommu driver. This has been co-opted by the ACPI/OF code to also
be a place to pass around the iommu_fwspec before a driver is probed.

Since both are using the same pointers without any locking it triggers
races if there is concurrent driver loading:

     CPU0                                     CPU1
of_iommu_configure()                iommu_device_register()
 ..                                   bus_iommu_probe()
  iommu_fwspec_of_xlate()              __iommu_probe_device()
                                        iommu_init_device()
   dev_iommu_get()
                                          .. ops->probe fails, no fwspec ..
                                          dev_iommu_free()
   dev->iommu->fwspec    *crash*

My first attempt get correct locking here was to use the device_lock to
protect the entire *_iommu_configure() and iommu_probe() paths. This
allowed safe use of dev->iommu within those paths. Unfortuately enough
drivers abuse the of_iommu_configure() flow without proper locking and
this approach failed.

This approach removes touches of dev->iommu from the *_iommu_configure()
code. The few remaining required touches are moved into iommu.c and
protected with the existing iommu_probe_device_lock.

To do this we change *_iommu_configure() to hold the iommu_fwspec on the
stack while it is being built. Once it is fully formed the core code will
install it into the dev->iommu when it calls probe.

This also removes all the touches of iommu_ops from
the *_iommu_configure() paths and makes that mechanism private to the
iommu core.

A few more lockdep assertions are added to discourage future mis-use.

This is on github: https://github.com/jgunthorpe/linux/commits/iommu_fwspec

Jason Gunthorpe (17):
  iommu: Remove struct iommu_ops *iommu from arch_setup_dma_ops()
  of: Do not return struct iommu_ops from of_iommu_configure()
  of: Use -ENODEV consistently in of_iommu_configure()
  acpi: Do not return struct iommu_ops from acpi_iommu_configure_id()
  iommu: Make iommu_fwspec->ids a distinct allocation
  iommu: Add iommu_fwspec_alloc/dealloc()
  iommu: Add iommu_probe_device_fwspec()
  of: Do not use dev->iommu within of_iommu_configure()
  iommu: Add iommu_fwspec_append_ids()
  acpi: Do not use dev->iommu within acpi_iommu_configure()
  iommu: Hold iommu_probe_device_lock while calling ops->of_xlate
  iommu: Make iommu_ops_from_fwnode() static
  iommu: Remove dev_iommu_fwspec_set()
  iommu: Remove pointless iommu_fwspec_free()
  iommu: Add ops->of_xlate_fwspec()
  iommu: Mark dev_iommu_get() with lockdep
  iommu: Mark dev_iommu_priv_set() with a lockdep

 arch/arc/mm/dma.c                           |   2 +-
 arch/arm/mm/dma-mapping-nommu.c             |   2 +-
 arch/arm/mm/dma-mapping.c                   |  10 +-
 arch/arm64/mm/dma-mapping.c                 |   4 +-
 arch/mips/mm/dma-noncoherent.c              |   2 +-
 arch/riscv/mm/dma-noncoherent.c             |   2 +-
 drivers/acpi/arm64/iort.c                   |  39 ++--
 drivers/acpi/scan.c                         | 104 +++++----
 drivers/acpi/viot.c                         |  44 ++--
 drivers/hv/hv_common.c                      |   2 +-
 drivers/iommu/amd/iommu.c                   |   2 -
 drivers/iommu/apple-dart.c                  |   1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   9 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  23 +-
 drivers/iommu/intel/iommu.c                 |   2 -
 drivers/iommu/iommu.c                       | 227 +++++++++++++++-----
 drivers/iommu/of_iommu.c                    | 129 +++++------
 drivers/iommu/omap-iommu.c                  |   1 -
 drivers/iommu/tegra-smmu.c                  |   1 -
 drivers/iommu/virtio-iommu.c                |   8 +-
 drivers/of/device.c                         |  24 ++-
 include/acpi/acpi_bus.h                     |   8 +-
 include/linux/acpi_iort.h                   |   3 +-
 include/linux/acpi_viot.h                   |   5 +-
 include/linux/dma-map-ops.h                 |   4 +-
 include/linux/iommu.h                       |  46 ++--
 include/linux/of_iommu.h                    |  13 +-
 27 files changed, 417 insertions(+), 300 deletions(-)


base-commit: ab41f1aafb43c2555b358147b14b4d7b8105b452
-- 
2.42.0

