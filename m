Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495C428A1C2
	for <acpica-devel@lists.linux.dev>; Wed,  7 May 2025 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631252; cv=none; b=FAsqN035X9X1sp9rc1/5JX7otlwKO7h0wBW+D82nsB+CF31VJVxwNHD92+2LDjewF9N+TaVfEIeQmZ3S4ekUAXk5kQ2em4zTD7tvK+2PcYdGntywtGLgUrbbxcpxMYWVMXVBEBXJ6XTQux/LE32vhXM+QTQfbP9cXK6I/Xj+aQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631252; c=relaxed/simple;
	bh=Q/4cDy2daokCHRuAKMI+zYNWvXXLfIv9JvBRagRcqMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BJQV4XcVXP0rh92BhABwGh1GjJ+VeQiYWUMwotrP4BaZ6qMPDQXpGs4LDUrXJ7mOxS7B4YBtNpSo+7xK1FnObOe3WA2jdVpsR9y/nOwoG2GAUdC+SQEJoMM0iYU8WJkklbqAKHbjum/oqy3IiQwds6SCRHTm842lSmPTYk58Rwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnbOu9TN; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnbOu9TN"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-acb615228a4so218154066b.0
        for <acpica-devel@lists.linux.dev>; Wed, 07 May 2025 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746631249; x=1747236049; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=86P87XsBGCoqJSisq9XyUEwQyZoFsxfiJg6l7nSj/Yo=;
        b=ZnbOu9TNaEDGz10xvY1Oq9GsodoogBOnMEvasNq1MPVEEGNuX21ghK2I3H2X5fSGmU
         bEPOHpy1lwMcEgwssEvINZDaLvLA6tWnJjNiS4u8dma+tzqFlV4Tneyi0UPmn07iX9xR
         WcwfZzGcI1rw/ubAjeYEMyz+C01yBV+PVuBtYirnQ9rwgdZI9P+UlDiHJowKsC91DZkB
         OalBGYmlbsa/e29hQ3pFzxgHKirYkCGQ6ZBsloqPRm1slYeiyYYpRaSDGBzPbljzmPj/
         HBkxlpuXFZg8FDh8+M07OmHfV3DOnSFcbuJqMlY10d/UwqYubzCknLUZQkxRDs9m+CP6
         KLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746631249; x=1747236049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86P87XsBGCoqJSisq9XyUEwQyZoFsxfiJg6l7nSj/Yo=;
        b=I7IUtqMwcWzChHhd+2kMU03MuH0IWgdqXvl3DPthFr3WuNQvYUg+DQni1tnrYplxLJ
         xccbOfSl5iCqHsihE/3yepGvWMgvM1GtVYl8jGrkcfcOVzRlpH+Fd9xXrxfFppOxedYB
         ZFGQ+rMcZLgVsv8oiRbFGjo61ywNmDGa4Sd2fws+elFFOM7GI9SUzgDOTtviDilSuVT2
         PTdShkwi8uTzCbFVb7247ja/pVEwsDKg5xQQUXDkVJQpaLQdMSEFjlg8kyrH2cyVIqwB
         lJXS6NbQKjcPhKrGCDmoChuEGXZXXNNDyv3E+eq5OiPqUMjuuesswbcGVnfDyJksnYKw
         7pTg==
X-Gm-Message-State: AOJu0Yw1Qrw8mG9PKFgUGgRPH9nnDPkss1UckkAxUIU9B9K+5uDwCjDu
	CMcksjh0H47LdnaLl4Gq/nGwcMCN+ycGVH6SRVBYsEAqh/RQLPnH
X-Gm-Gg: ASbGncsBUF9vq/rgI5iRQTLJaHD/0Tf4pEzrc3Ng6XVY1ZctqHSQPM40kd//IwBfF5n
	6vD3gL4E3OrXR6YDKYWMf5uuxRW/F5Cs9ctcEtaTUdal1pqn+4+4zFJgDLHwHi6gGRC3F4b9zA8
	zo/kIPFzy4WJHLAqlX8KG7vUo27kHdeBzRigDvZhKYNZjR6hsaKLIKccqgqHM7ARigdYF6Uq2DF
	sJ51BofH/Pyx33Z9223fX+G8BZo2nXG2bB22u/HL/+cbmElYLYpD4JYhoJ2ZKgo7HrVuiqUnLxy
	WlVVaQDv5ZeovYjwfR0yWCxQtD3Fk5u1b5ZUABl5a0zld6jK3bRk
X-Google-Smtp-Source: AGHT+IFJOz+hM/atyuzW8Ro4vxwvTSN7B5TcW5gFCeQ7LS04K1WokNMsqUcdXI0V9aKqtcXIJaSPLQ==
X-Received: by 2002:a17:907:3daa:b0:acf:dca5:80f7 with SMTP id a640c23a62f3a-ad1e7974c37mr352094066b.26.1746631249142;
        Wed, 07 May 2025 08:20:49 -0700 (PDT)
Received: from localhost.localdomain ([78.172.0.119])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fbf7e57ce4sm837530a12.35.2025.05.07.08.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 08:20:48 -0700 (PDT)
From: goralbaris <goralbaris@gmail.com>
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: acpica-devel@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	skhan@linuxfoundation.org,
	goralbaris <goralbaris@gmail.com>
Subject: [PATCH] acpi: convert strncpy into strscpy
Date: Wed,  7 May 2025 18:20:45 +0300
Message-Id: <20250507152045.12266-1-goralbaris@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strncpy() function is actively dangerous to use since it may not
NULL-terminate the destination string, resulting in potential memory.
Link: https://github.com/KSPP/linux/issues/90

Signed-off-by: goralbaris <goralbaris@gmail.com>
---
 drivers/acpi/acpica/tbfind.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
2.34.1

