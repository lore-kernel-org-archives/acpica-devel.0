Return-Path: <rmk+acpica-devel=lists.linuxfoundation.org@armlinux.org.uk>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2DBB26FBFE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E22B6FC0B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
 In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7mUed4j6JYeBkSblH2nqcvZsQbChg0c7FCSaYvctrZY=; b=RXKzMk8nxqLsHr4DrG64vwCDNl
 L1dBvNRAboxbtvs9cSI1KCnV0hnPEd7IW2lznQwfui6jPeu3MJ5AAq2UCyu6FgD+8x2iGNf4iDs5W
 Hw2gX7LecqKIJFAwAF1BKt8bxa1WBrvQMwLcjVSAzi89+ncVyvzw0koZvYsmjNUkGg+jRIE5r3U5x
 orHxHls/n75Zzq/kBkYtZ0EOZfE8GldZzqesp2T03cpK4YGxXTcZiQmUuT5AYQwhg5tvCo9L0tXt9
 NbmL3Te3xKJ1+ljcRqR+ihf1KD34wlPyBSMmb4jpyIB5r1SctfT0r+pSXWkYCf0HEW9QvzvWn9Ogc
 wAFyW+YA==;
In-Reply-To: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJBA-00AqRq-QW@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 24 Oct 2023 16:18:48 +0100
Subject: [Acpica-devel] [PATCH 31/39] ACPICA: Add new MADT GICC flags fields
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: linux-pm@vger.kernel.org, loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Salil Mehta <salil.mehta@huawei.com>, justin.he@arm.com, jianyong.wu@arm.com, Robert Moore <robert.moore@intel.com>, James Morse <james.morse@arm.com>, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>

From: James Morse <james.morse@arm.com>

Add the new flag field to the MADT's GICC structure.

'Online Capable' indicates a disabled CPU can be enabled later. See
ACPI specification 6.5 Tabel 5.37: GICC CPU Interface Flags.

Signed-off-by: James Morse <james.morse@arm.com>
---
This patch probably needs to go via the upstream acpica project,
but is included here so the feature can be tested.

If the ACPICA header files are updated before merging this patch set,
this patch will need to be dropped.

Changes since RFC v2:
 * Add ACPI specification reference.
---
 include/acpi/actbl2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 3751ae69432f..c433a079d8e1 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1046,6 +1046,7 @@ struct acpi_madt_generic_interrupt {
 /* ACPI_MADT_ENABLED                    (1)      Processor is usable if set */
 #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1)	/* 01: Performance Interrupt Mode */
 #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2)	/* 02: VGIC Maintenance Interrupt mode */
+#define ACPI_MADT_GICC_CPU_CAPABLE      (1<<3)	/* 03: CPU is online capable */
 
 /* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
 
-- 
2.30.2

