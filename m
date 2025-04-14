Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE47725A620
	for <acpica-devel@lists.linux.dev>; Mon, 14 Apr 2025 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616140; cv=none; b=bTr1egeKinCuew0aPCbCy5K+qEzvL2o22rdIZpZUVAYkE+06j81+vQhPkN0gjGZan2md+2bEFGQN1/s+yLRcg/XGeun+ESGh1dQM0LrVwTkNBGEYoiyFjJ+Sxh4a6CXZpaTGXRtHdOBdteUnfP3Y+GzbeblZ4PPMRiXzt5Rwcck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616140; c=relaxed/simple;
	bh=KTe3uWaWlgANscop60ILOfJGk6PaXW06xvdFjDJSwTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DDQ3t84/JrkxeR415gNKJgfpd8+SEY07UXFaJs6VwM6nn9heJjCEr7bv/JcoYT3/PWTiGo1h0R9b2+1DBZyuQTpqUx5ulTIIw+9b9x1Ch+eqnn0vy74w5S5hcC2Q9mFMbqtt6TXYhEAWUTuZJa3/CS+qg+tbyNWQ6ic6gIgScPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdN2G0EO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdN2G0EO"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73bb647eb23so3442558b3a.0
        for <acpica-devel@lists.linux.dev>; Mon, 14 Apr 2025 00:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744616138; x=1745220938; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWQtHqSbTf9NzEXG3WeHgoYFaTCv1grfOd+Mceut8xA=;
        b=kdN2G0EORETdJEVFxh17svR0DNp42DpgdUsx5etvFnjl/W04g6BtA3RLBjbXYluzUj
         TaJqm5oONB4lEAt+wbAbv4H+yNMMKc+xDfP6Gpa6jfHxUwlDVNHgL5mB0hmZ0VDE70bX
         d4T6WM9qrX2NTpJquxMjzJks//fo4fuY29PsYB48j8dqpOw0i/+Q6SaCnZXgrp00AqJn
         WGVhrHTIphsWgmIekShGOgEh4mIVYzNMSRiRm7bnCLJT+nAfoF44GmJDu//NOhnIuanC
         iGMjEwaeocAVNZwYTHgvnoS1m6U+GoGtUEgqzKJwt75ImNXBcm1Y3gzgbZR0QOay6xGK
         zRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744616138; x=1745220938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWQtHqSbTf9NzEXG3WeHgoYFaTCv1grfOd+Mceut8xA=;
        b=dwP708KaFCdjTbcHDvb1D1baY7CjvzLNF9vGi7lQvIWj3BlzXOmujbzfYluLPJIP/K
         rB3aZV4AHRPKIw7pnhoTCzkh81ST0Tze2na4cfvDCfq6d7grHHLIB1SkkLN4YRM3yws7
         +xjYGy1W14ZQIJ1YOdYnYN22BEZ5dZGkE/xXKD1d9YFhZ2fwThaAWgXlXroaTBOTYwKL
         /MXPyLnt5YaqUECyfkLm7XPZeWZfzaUx9hL5GnHed2pV/6lF0/F2SRG6YS7Z1veD8ZCO
         BVo/oH+4NJj742EgNStaR0b+c+9f1APA2aoCTYTfTDZYN+O/m2Mf+LDpxNjXLTwzhE6A
         l9Dg==
X-Forwarded-Encrypted: i=1; AJvYcCV61zruZEJ/ftV0Uap2AI8ldYo5QGDtyh7Fg9/AfwRYiyrl4sNBrYie1PaeaOPAzrNWDUSzeegTyvqa0dc=@lists.linux.dev
X-Gm-Message-State: AOJu0YwIXG4HAcxEu4M1wqr3pdczrsmVqlxvXI+YbQium+hsfrekgrMV
	7AAfIyqL+nMOmcf5/lqpVRnPllDPKgugSpTO62Rt3H2hV0WBsjg2
X-Gm-Gg: ASbGnct2a6yiowmpPBYh89lPnAoS6XhtxCF+DQKDr47cBUHtaEz2QOy8VpfjUinxuYU
	yg3a+Xz+vNJ+Lrs9YLlo6/5YfNTXO9e1RpgX4bKmK5PELeju8TYO3fDFJt5IEpEeJu1g8S3RvZe
	feTq3JQjBBljG9XFP5Vp13zw4NQ0EBXXdxYbuJ2MBRH/b9VUel0gxGal+N18vVKyJsJ1KuW4Yh7
	3hhErZGcjoKaCs7JsERRPS4Y2tvCL/LPScZsNrS0+bS+LmOxwxsKm/VyPs5ZFL6iSka+xA6c3mK
	fpMy7KZ+99YGbcBQtf/qU74eFbat5nmVF3S40Ybflq+PKwl8K3Yuqlbqw+h9
X-Google-Smtp-Source: AGHT+IE3VhdggcNXYAgq0b6PYooX5zuI2ynpcIPLIPK5E38pSNyG5MDqPQafDO4ubU5wA1GBOa1Txw==
X-Received: by 2002:a05:6a21:9012:b0:1f5:59e5:8ade with SMTP id adf61e73a8af0-2017996f6c8mr17350608637.29.1744616137864;
        Mon, 14 Apr 2025 00:35:37 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c408:a0b5:82a7:fae4:9cf0:3b75])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0830418644sm1615915a12.39.2025.04.14.00.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 00:35:37 -0700 (PDT)
From: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kevinpaul468@gmail.com
Subject: [PATCH] acpica: Removing deprecated strncpy()
Date: Mon, 14 Apr 2025 13:05:17 +0530
Message-Id: <20250414073517.57745-1-kevinpaul468@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch suggests the replacement of strncpy with strscpy
as per Documentation/process/deprecated.
The strncpy() fails to guarantee NULL termination,
The function adds zero pads which isn't really convenient for short strings
as it may cause performance issues.

strscpy() is a preferred replacement because
it overcomes the limitations of strncpy mentioned above.

Compile Tested

Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
---
 drivers/acpi/acpica/exconvrt.c | 2 +-
 drivers/acpi/acpica/tbfind.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index bb1be42daee1..648e68a31e1f 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -226,7 +226,7 @@ acpi_ex_convert_to_buffer(union acpi_operand_object *obj_desc,
 		/* Copy the string to the buffer */
 
 		new_buf = return_desc->buffer.pointer;
-		strncpy((char *)new_buf, (char *)obj_desc->string.pointer,
+		strscpy((char *)new_buf, (char *)obj_desc->string.pointer,
 			obj_desc->string.length);
 		break;
 
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 1c1b2e284bd9..5536d1755188 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -57,8 +57,8 @@ acpi_tb_find_table(char *signature,
 
 	memset(&header, 0, sizeof(struct acpi_table_header));
 	ACPI_COPY_NAMESEG(header.signature, signature);
-	strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
-	strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
+	strscpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
+	strscpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
 
 	/* Search for the table */
 
-- 
2.39.5

