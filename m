Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914291;
	b=BU1svbv+S/Ljp0Jh3bE9hZov/NuB22H3HOIUI1kgwHpVyWenxR9+AafwJfRu8fZZiAZm
	 jQKrNgk32ImTaxEN5DLxV1GsvHL4+VdcoWhENL5lrtW+PSDXezNkYXFFCOfYvA0gsJSN0
	 Rmx+CfZRtfcmpW1IO9aAJ/HlmO3qJRIoZGz5uEr58JjmYSwlNr17Y/eTrf/AZ5JBGtvPf
	 +35G1laW1WhjtXpSIQUYGj0473WNbhlyl07Ie3LNVpre42sDaRq8fe+mA5EnNPjpcoOU5
	 x3fq+gT8Zi0qEjKIykc2vAbt9WHe2w/+U9ODVoWlqMcAvC79Gq360yWv3ZDpwR9wYnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914291;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MXEFABk4Xv2GbPN1b8uTXS1gNaUbI7j11V7WDEniAMs=;
	b=aFlGu8xXzoqAa84qOWaiLuko/5xuObvhm0SbfECqSVge+UqQ2dFlsayWaSgCiKvHuARM
	 HGX0Whd4Eh6AzKdVPGMPVF9pobGd9il6A9S45PAh2OqSUlhP3Qi9aHFL5J45jfCyBxcK4
	 ImcVT6RoZA3pVcJeOcslpYZN/UJfaiUDPBd7iwjms/SNhIP7b1y81yeHDnUOlxrS51TS8
	 Lv0ZU7fZMTLaCet/K50vepTiFz/GDWxEN8ov4XpEJaoGJd1NzkKBzKoXMOXX2jeECKSON
	 1waMUBMOLUl4eW//uOtAt+C1rLafGy7SyMxDrisGVYaYsYcqKZgcjtF6sdcK0HQDszA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TObnbVaF;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F040606A31C
	for <acpica-devel@lists.linux.dev>; Tue, 17 Nov 2026 11:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F040606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TObnbVaF
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5E101688;
	Tue, 17 Nov 2026 03:18:06 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 265A73F763;
	Tue, 17 Nov 2026 03:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914289; bh=yZVJhKbCQ+zekgJDP6u8e334wVc5yCWM6Mm1+2PqYS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TObnbVaF6xpP+HLg6TEoqPA+Dl8IoTW5CpnMywtjGb5xKgtWWe1CrMgEKBtJG8yd9
	 /hkB4k4x/0IHRL4kMCB2ylfOkb4BHBs6q94+rDzUMCEWiF/ftRq9V9YsA9OEeiBqzK
	 zbXfzD8kcFZqpHVyZ8TzJwgZ+zepiLO16by4KoLY=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Radu Rendec <radu@rendec.net>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 08/19] ACPI: extlog: Align extlog_print_pcie() and ghes_handle_aer()
Date: Tue, 17 Nov 2026 12:10:18 +0100
Message-ID: <20261117111444.4185512-9-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117111444.4185512-1-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to unify extlog_print_pcie() with ghes_handle_aer() and
prepare to remove one of the functions, align the behaviour of the
2 functions. Thus:
- Submit the decoded snapshot through aer_recover_queue() instead of
  just printing the error.
- Override the mapped AER severity with AER_FATAL when CPER_SEC_RESET
  is set so the AER worker selects the frozen-channel recovery path
  when it finds an unmasked uncorrectable error.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/acpi_extlog.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 125f7931b98bc..e09ea571c32f5 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -8,9 +8,11 @@
 
 #include <linux/module.h>
 #include <linux/acpi.h>
+#include <linux/aer.h>
 #include <linux/cper.h>
 #include <linux/ratelimit.h>
 #include <linux/edac.h>
+#include <linux/pci.h>
 #include <linux/ras.h>
 #include <cxl/event.h>
 #include <acpi/ghes.h>
@@ -138,7 +140,6 @@ static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
 	struct aer_capability_regs aer_regs = {};
-	struct pci_dev *pdev;
 	unsigned int devfn;
 	unsigned int bus;
 	int aer_severity;
@@ -156,6 +157,9 @@ static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
 		return;
 
 	aer_severity = cper_severity_to_aer(gdata->error_severity);
+	/* A component reset by firmware needs reinitialization. */
+	if (gdata->flags & CPER_SEC_RESET)
+		aer_severity = AER_FATAL;
 
 	aer_cap_regs_unpack(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
 
@@ -163,12 +167,7 @@ static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
 	bus = pcie_err->device_id.bus;
 	devfn = PCI_DEVFN(pcie_err->device_id.device,
 			  pcie_err->device_id.function);
-	pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
-	if (!pdev)
-		return;
-
-	pci_print_aer(pdev, aer_severity, &aer_regs);
-	pci_dev_put(pdev);
+	aer_recover_queue(domain, bus, devfn, aer_severity, &aer_regs);
 #endif
 }
 
-- 
2.43.0

