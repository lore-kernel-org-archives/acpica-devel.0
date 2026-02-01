Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E1277CAB
	for <acpica-devel@lists.linux.dev>; Sun,  1 Feb 2026 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769970113; cv=none; b=iTtxC58Xh4VkdcveaPwdqv3fXUgt+40u4v9Y4mBkQA6N6NlLQpUVrRkPgLgOak/aPGVMLhLZr82Y7bshELqG3HXxIPLIia+gT7zOMOSjieewSusu/ywoZIcj3ENDdbqLp+6+OwTRQr5G30sOJVVBRM7CLRxSagoKVPUdImGWy1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769970113; c=relaxed/simple;
	bh=ifpEA+fzHgyIbirKJKn1wJrl4wHKSf5jVLm3dOmyb9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXTWUXF4NwmVDPFTxE/TYZpm/OO6mv8ltyDn5cOFTndHT/FlAFJEtdy2+UT0XVxFZNLhPnOKQxIURvjWqTaiIRobUm5q+hc3yL+v0xUTbSpuLT3sv1DUTrcbI/ZdCWqzt6ZSY2e1sRtE2rzIG0PijJNTlxaw8W/2hjV8RI+2iqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQAJaiJM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQAJaiJM"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a7bceb6cd0so26167385ad.1
        for <acpica-devel@lists.linux.dev>; Sun, 01 Feb 2026 10:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769970111; x=1770574911; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rXoPKzs5Nz6Ocvm/PYFIBQC+JTSF0Nmu5luN9ipSXfY=;
        b=eQAJaiJM6ksuUtfw0GfMHLJcW0kLQmvN+uCYJ1DTaiNp1fdSTXmIoiDOpkwWIdRzLh
         18qS0ksRUqoEOYLytdK8eK/DOLuaGaQD98mwxdB7wSCzjdhdVhtskoyHBQZQOGMn9AHj
         ASC0P/y3F3h7fgg/9gbwy1gW7kqKU2Tq0aWvvQ0BWvtv/Igs8O6gBO5piGD2auF6EBpC
         CNt1+4QEYk2484l6tU+137TLRZs/gom5DOGgIkKo0fzzTH9buSK8xyBlOEA5Owcrtpem
         35KF0iTo09KVr2yeIj40d4c4+4KZHO/gi7vC27+T4jrkYcYdU2Q1VsDH5kyQGRKWD+zP
         L7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769970111; x=1770574911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXoPKzs5Nz6Ocvm/PYFIBQC+JTSF0Nmu5luN9ipSXfY=;
        b=rJTmACkvM4DQhFKy+lIEdx2uzfEGYdeyb3BQ6Uxbsc9APw5L7AJYmB2F2H2PRzx//V
         hQ6CBAc0qJccrVbzg13mUXZ50zRC8ayvPtr+1aSXcINpeD0h033GF0F+iOp4OlyG2vba
         BesHab2/EmuGBK3hZMDnO7dqIa23t32YykmHMATK1M1JrQlsSQ2d4zlS0kCYJ9qIzJa8
         sMlSjX8a1TAEbcgyTwDWelP5ctPoDr5+5pmmQil31grcqiE1sUoUscNMD7Jfs+D4tDPd
         AVYRvLJJs7mgSqR861vu+NLqKOZBGb/oDozCr1BljURX+ywo0hs6J8ONseJzp0eW7xth
         COFg==
X-Forwarded-Encrypted: i=1; AJvYcCWaA9WB/w1uyUiSAkn8oUh9O6xOwfPhcTMTGHBpsKKF8yZP+RZH3qF8hSkbHJa/0ZuaRrjGiJNHhJfbeRc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2GWKY+mnDaBxzzMMj0S7Y8dnjSOVVdsXQxQIyxLmNAKmeMh4c
	mq0QdPyoGez3AJW246cMyT96TAWsiisMF9vsAqe2cneEMXYJkgU9xm8P
X-Gm-Gg: AZuq6aJR7umQKZXWAS3uEjyA6r/DllyldGpIeyyemEN9fTLVS99dC34C+gFxmXnCZxU
	WPEfSZDWr4W13/8DjskV9dRI3GkYpYVP9fn4y3dCm5tvRQwEUf6kpxsQrJCaGmPnD8yhW3uK734
	XyH4n+CF7q5GuzUyKjg3GRhoes7yd/0qzwWtN7R3gZLvXndCtvlz5z8gJ3IgA5/sim/WCXHJOhW
	VqsLvA2aWRF/3Ceq5v7LANNy0l+WPh1Ygp1wVeRVCXF8Pisqo1MOxpLawmQA8aH9DmuGwr4CsBo
	lfnUbqylEaC5DWrUKCiIF4t99N0pLdTQbrektTu5oc/CPxRd99/fZvdyjgMyplOG+RRva5dil/4
	Nxl7Ewq9ngWHRiPcpO7RmCccAtSaFyprE2sxWriX/oCG2+t8zrVX+ZCnVkKHg9tO9/n/FAnq2TR
	hzueRoaoN2d/LZLRcr
X-Received: by 2002:a17:90b:4d09:b0:353:e91:9b38 with SMTP id 98e67ed59e1d1-3543b3bac1fmr9070089a91.34.1769970111493;
        Sun, 01 Feb 2026 10:21:51 -0800 (PST)
Received: from gmail.com ([2409:4081:2d1d:b4be:89d5:e086:c91c:ec66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f3ed0dasm12599461a91.14.2026.02.01.10.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 10:21:51 -0800 (PST)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	robert.moore@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] tools/power/acpi: Replace unsafe strcpy with snprintf in apdump.c
Date: Sun,  1 Feb 2026 23:51:41 +0530
Message-ID: <20260201182141.5039-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace unsafe strcpy() calls with snprintf() in apdump.c to prevent
potential buffer overflow vulnerabilities when handling table signatures.
The snprintf() function performs automatic bounds checking to ensure
the destination buffer is not overflowed.

No functional change.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 tools/power/acpi/tools/acpidump/apdump.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index 7a6223aa703c..b566f9b832f1 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -308,15 +308,17 @@ int ap_dump_table_by_name(char *signature)
 
 	/* Table signatures are expected to be uppercase */
 
-	strcpy(local_signature, signature);
+	snprintf(local_signature, sizeof(local_signature), "%s", signature);
 	acpi_ut_strupr(local_signature);
 
 	/* To be friendly, handle tables whose signatures do not match the name */
 
 	if (ACPI_COMPARE_NAMESEG(local_signature, "FADT")) {
-		strcpy(local_signature, ACPI_SIG_FADT);
+		snprintf(local_signature, sizeof(local_signature), "%s",
+			 ACPI_SIG_FADT);
 	} else if (ACPI_COMPARE_NAMESEG(local_signature, "MADT")) {
-		strcpy(local_signature, ACPI_SIG_MADT);
+		snprintf(local_signature, sizeof(local_signature), "%s",
+			 ACPI_SIG_MADT);
 	}
 
 	/* Dump all instances of this signature (to handle multiple SSDTs) */
-- 
2.43.0

