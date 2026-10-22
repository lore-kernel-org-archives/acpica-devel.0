Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703596;
	b=sQYhE1/DrJkObrzF+G/1C6IgmeWkWI3Hh4gRrFehlXQaCpSbZZ3z3BeCJ2oxIp5N95un
	 YiFy1wMF6bU5JF9uBqnAjl5kxL7K/2ri0hzCvBYwBR9Sd9eYKuuN6T7G9lIucfYac1Q++
	 +rJJ4j425xb//Gd46/3LjYwx59eWcUIhuQDTuLa6eg5XOgOK+bVsfQQCxUCi6mhPhtwyg
	 KhNCfZZ/wSn7Hmk+0myMxqPZeEc5usi+PIOnyHuGdXZrFVnlTv6EBKRsBfppvJf3+gSGP
	 +5OB0XN3F/Uc5Cb3IBedWixA5K0xxTOoLDYbyY+bLyyOn7dfIaaCkz60zZowffD+ebQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703596;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HVfBLk4HTc3Q1JSz/tfe3BVw+fdZ6OMFICyRLMEHTb0=;
	b=VFc072vm8cy210bApm6mPvcF1kPgeGO7+TNb1mRW8N71W/81VP6xF6dgL5Lr0FxjHfkf
	 6ne9ndqNVOStFtQ6y2rCk2XSOK7Q291fOK1tBd5KVUX3FAK2owzz5MNMiTuGy0yFIhdDg
	 RZ7qGOCBYJCRddSVTG7Ad7cHDFV/l0/absi2+Gxulv8uV01cTrVweF7550z7EkXFKMQLz
	 zVX6o8Zhq6VDq5m7XBFdHhqGxyk0ShHaTjbQiajxxhvL8oRC+DMQMO5VCH1JOSJ4FVIKh
	 u4HXb0cAeaSE3lvmDOCSei98ISEfJSxYWqObUVC+4/OxLy+bcxMOcaBCyUXEAoM2Dmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="EpkiT5/P";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3023C606A31E
	for <acpica-devel@lists.linux.dev>; Thu, 22 Oct 2026 21:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3023C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=EpkiT5/P
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 9FC2820B7167; Thu, 22 Oct 2026 14:13:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9FC2820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792703586;
	bh=HVfBLk4HTc3Q1JSz/tfe3BVw+fdZ6OMFICyRLMEHTb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EpkiT5/PFjdo40SKtLABbtNcnlTX13uBQMIZSpTOpqmmD3/h6dlfmo7uI+jS3pNuo
	 dA3PMomECm134w2pkCHYbFTSBhvDDgnM2lgVTTBKI0sRtyx4U3Z+Pe9T1GxdFNSuO5
	 KrHbK2p+4tz1kKlZyP4DDuuYpb6w3wxxUZGUzlDY=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	acpica-devel@lists.linux.dev,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH 2/2] efi: don't register rtc-efi if the ACPI TAD can drive the RTC
Date: Thu, 22 Oct 2026 17:13:04 -0400
Message-ID: <20261022211304.2285792-2-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261022211304.2285792-1-hamzamahfooz@linux.microsoft.com>
References: <20261022211304.2285792-1-hamzamahfooz@linux.microsoft.com>
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

EFI runtime services are best avoided where possible, and ACPI defines a
standard interface to the real time clock in the form of the Time and
Alarm Device (TAD), which the acpi-tad driver has been exposing as an
RTC class device since commit 8a1e7f4b1764 ("ACPI: TAD: Add RTC class
device interface").

So, don't register the rtc-efi platform device if acpi-tad is going to
register an RTC class device for the TAD, according to
acpi_tad_rtc_available().

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/firmware/efi/efi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 9bc22de0d..706064479 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -34,6 +34,8 @@
 #include <linux/security.h>
 #include <linux/notifier.h>
 
+#include <acpi/acpi_tad.h>
+
 #include <asm/early_ioremap.h>
 
 struct efi __read_mostly efi = {
@@ -459,7 +461,8 @@ static int __init efisubsys_init(void)
 	if (!efi_enabled(EFI_BOOT))
 		return 0;
 
-	if (efi_rt_services_supported(EFI_RT_SUPPORTED_TIME_SERVICES))
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_TIME_SERVICES) &&
+	    !acpi_tad_rtc_available())
 		platform_device_register_simple("rtc-efi", 0, NULL, 0);
 
 	/* We register the efi directory at /sys/firmware/efi */
-- 
2.56.0

