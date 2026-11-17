Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914445;
	b=R+y+wA3ZhdAZVhvOLHg4+8npzRm5JFbL4+wQlBViwQ3JG0z+YFiyDABVqTojUs4mM1Jd
	 Mbll8cRkrMat31xrkQBGZ3t7541ErX6iWT+uIPvlASr/a59Lv8RyC+q+wDxCi83OFe7fO
	 PjW1ig17PY3Q6GSXgHbjiUw593c4tMtfBWgWcsbGX0cm+ZGpQkC9rai/z2OuCW2qrY3S4
	 74S5sYzBZ/woNTN66jB23oBRGwKTSzWYRUJCHtlJrPM2FA7CyeWWgn+nEAmV3lNnNcqxq
	 Ztjtjl810D0lDddDl/a4M7SimUj9/C65HGytHs+PPn5TfLHQ1uX9inmS2xdnvJuDCYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914445;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=09rZsuWp6CtR9LOTXoLoaUtfkW84uWWxOZaFgvige7E=;
	b=qJTPIGtRs7y1cSVZHOVKavLxwHFddYCuup0uWosRWi1m+4g9TYzmLMBi9GJdphaIc1CA
	 BuyAur0JvNQvsBigyGIeJIUTKZUWVYPmn5MXuC4sahTXtQpK0hfhrhXdCTG8pmt5Imq7S
	 /oGyrC5YOZLzw58xyx5REWrVkfhsoJu72aMly/u2KllH1Cvphi+ErU/qJlb+ROy5OwGWT
	 Us56IV7Nz3SUQXbUUVHYbRyU7fZaNGGmxorpRvHRT30UXyocQ595fgFkcPQv3y5fSqboY
	 e43OJB19IKQgaUCGtwlt3avYVCCHW5R0QCrf/8kdifMSX4uZXMrk8vumbalyuWju3ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=o7QcNwPV;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6846C606A332
	for <acpica-devel@lists.linux.dev>; Tue, 17 Nov 2026 11:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6846C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=o7QcNwPV
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA9601C2B;
	Tue, 17 Nov 2026 03:20:40 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 72CBA3F763;
	Tue, 17 Nov 2026 03:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914443; bh=trVuWSDFiGkBDhc3DOcsF8Ag/Ixhu7mOBHZTT9DfJC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o7QcNwPVEYbkit4dugp52SPlNUGTA/LWgN93kS73LQ3MAYgcoOsJPBmgWysestjsx
	 motBi9i03VoGIBTSHOZVOnMv0zd5FJ99CyLLqBPz1VR+3F7UN8x3KK9WD+MkagPP/i
	 Mj1WcyzvPEcFXtVqi/yWxqB+Q+2bDvspMGZLQvi4=
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
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 16/19] ACPI: extlog: Report error severity using GHES bindings in MCE
Date: Tue, 17 Nov 2026 12:10:26 +0100
Message-ID: <20261117111444.4185512-17-pierre.gondois@arm.com>
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

MCE extended logs report raw CPER severity values to
log_non_standard_event(). GHES relies on the GHES bindings in
ghes_do_proc(). The rasdaemon interprets the severity
as a GHES_SEV_* value.

Translate the CPER severity with ghes_severity() before reporting
the event.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/apei/extlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/extlog.c b/drivers/acpi/apei/extlog.c
index 8cae5bdacf1c6..bd407436928b4 100644
--- a/drivers/acpi/apei/extlog.c
+++ b/drivers/acpi/apei/extlog.c
@@ -216,7 +216,7 @@ void acpi_extlog_report(const struct acpi_hest_generic_status *estatus)
 			void *err = acpi_hest_get_payload(gdata);
 
 			log_non_standard_event(sec_type, fru_id, fru_text,
-					       gdata->error_severity, err,
+					       ghes_severity(gdata->error_severity), err,
 					       gdata->error_data_length);
 		}
 	}
-- 
2.43.0

