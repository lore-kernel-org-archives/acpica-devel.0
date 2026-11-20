Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155685;
	b=WYLvuuBvWHArZym2A8XinJRfHxISzsbiOcRmWttPpK1zsqkFw6BGd0MNMWCj6PH8fZAI
	 OJj0BCawgBb2oj+1kxclYvyKLcaod43fihjObr5pTGGFMJE0WYsareR9VLLF/JmvP8DMq
	 fZDtMF88bVUbmxPYu5f5rqY9wLBGez1Tpibqvg7wcfMGRdOZL0XwfuHurkXqak9BkKETU
	 rctFn45aoa2FOFyLtHQpyWfOgvb11yE/F64I8qBdBk/8vjOwe8ctc4sSHyEB34rxSK2TC
	 GOouwJXWdKbTy/n1nO1X6BUPxRuEF19KHHIhbsxdABPZjJswfPMIEXn9XoP4GEKUlkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155685;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r3cd5ig/R4tMhDYHHFyjzzWcQOV/dhUUB6Eem+2QV8I=;
	b=DdO3ZgBXIFdgp9bhWlOJP9/UY5xNBIcyeAPfX2DayASAKasaQRY72PjDcfVoDuz7kOmO
	 OA4qzgv3G8K/ji4+e7m8jGC+U6q2Xvi84JdYqoEjr9jJ4smAgzijUbM2UJyG2w9SH8bTI
	 nU67X/0H1ilvSqDnlCNgUhQT/HWxCSUZ2qPuGX/MMi6XLPOW6nAQVoMJ6vC3U8HSGDG0I
	 bYcaGiNs4NKZs0m86NEvHmfsYJEYkEeeNKFh0t7gGIKmokP4Crhse2LgHCuREwCvX7wGq
	 eY0Iwe4SlSbrsh1Pv5P7RHn3n8fnXLuu/HXMhe/MThM0Iw3lKZVnyR7wnY94nE2H/4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="Xty/JveW";
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C9D60A2605
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 06:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7C9D60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Xty/JveW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Xty/JveW0erUX/l5CvxaqvVedXUNRtSTv0T3dlnSNS0ywCDTdl6osIKoFsfN0L7NWsKWHA06LtpXG
	 4kK/9OnKqsImQXREeKc1CrSyj+8UwjHsXmgvfwNtEkjIgjL6KKX1RMTyev97UROmq3K4lV5bjOPpry
	 bMJz5Tter64csuLM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96affe6e0b99-2a5d7;
	Fri, 20 Nov 2026 14:21:22 +0800 (CST)
X-RM-TRANSID:2ee96affe6e0b99-2a5d7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36affe6e1c95-31157;
	Fri, 20 Nov 2026 14:21:22 +0800 (CST)
X-RM-TRANSID:2ee36affe6e1c95-31157
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	maciej.wieczor-retman@intel.com,
	pawel.chmielewski@intel.com,
	trenn@suse.de,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] ACPI: tools: ec: Validate write values before narrowing
Date: Fri, 20 Nov 2026 14:21:20 +0800
Message-ID: <20261120062121.98448-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
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

ec_access stores the result of strtoul() in a uint8_t before validating
it. Values such as 0x100 are truncated to zero and accepted, while the
upper-bound check rejects the valid value 0xff.

Keep the parsed value as an unsigned long until it has been checked
against the EC byte range. Use an out-of-range initial value so omitting
-v remains an error, and report the offending value in the diagnostic.

Fixes: d7cddbb07b18 ("ACPI / tools: Introduce ec_access.c - tool to access the EC")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/power/acpi/tools/ec/ec_access.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/power/acpi/tools/ec/ec_access.c b/tools/power/acpi/tools/ec/ec_access.c
index 8bb271b210d8..0b06292bf1d0 100644
--- a/tools/power/acpi/tools/ec/ec_access.c
+++ b/tools/power/acpi/tools/ec/ec_access.c
@@ -30,7 +30,7 @@ static int read_mode = -1;
 static int sleep_time;
 static int write_byte_offset = -1;
 static int read_byte_offset = -1;
-static uint8_t write_value = -1;
+static unsigned long write_value = EC_SPACE_SIZE;
 
 void usage(char progname[], int exit_status)
 {
@@ -103,10 +103,9 @@ void parse_opts(int argc, char *argv[])
 				write_byte_offset, EC_SPACE_SIZE - 1);
 			usage(argv[0], EXIT_FAILURE);
 		}
-		if (write_value < 0 ||
-		    write_value >= 255) {
-			fprintf(stderr, "Wrong byte offset 0x%.2x, valid:"
-				"[0-0xff]\n", write_byte_offset);
+		if (write_value >= EC_SPACE_SIZE) {
+			fprintf(stderr, "Wrong byte value 0x%lx, valid: [0-0xff]\n",
+				write_value);
 			usage(argv[0], EXIT_FAILURE);
 		}
 	}


