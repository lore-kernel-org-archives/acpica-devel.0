Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9734510948
	for <acpica-devel@lists.linux.dev>; Fri, 15 Dec 2023 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-28b14d02ab9so257385a91.1
        for <acpica-devel@lists.linux.dev>; Thu, 14 Dec 2023 23:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702625053; x=1703229853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNpC7NFbJjbEn49G0H7MyhYXJbT+qig1neudpuf1zUA=;
        b=nHSr73euCbHeew28bHoyjKitm6hpa/Q3hB5POaeH7Phkq3TCrqnsJztFedV5uPQrIo
         nMqdd7nHHq7JdhAIq8MOEQ+l47I2r+qpAmPm9LAqX+8VFsA1N/QrjVOaqJRXo5NgMR7p
         kGN0I9n9kUzHa47vqRXSUJRP2+gBkC0oL4hgAXV06p1OtWhv+xlbUCb7Fr+WyzVikn2q
         vOuo+yZIzLfrG1UgSmhEIQwYepvUJx+QhYlEU33AkBXy+qIQb9ZzekFPa9Fdi/StHeUd
         V47qMl3yqYCXeIaw3K9xUMBp3ayaP2+ptpXso38QRBCFvoAMBfr9RgBWUuyrNvsGS85X
         SM4A==
X-Gm-Message-State: AOJu0YzmEndEdtns/41W3C1nEot6IkStus3LWWSC6BBwx8kMxNt8802J
	skx2R12WTtmK5IG7I0qPBsk=
X-Google-Smtp-Source: AGHT+IE2GSUOcnc8CjzGsfrsEfmISwc8i0DZ/GUQE9BbbHhbu2/MUPr4aOlBN2D6ECmKIqOXhn1NQA==
X-Received: by 2002:a17:90a:990f:b0:286:6cc1:3f1b with SMTP id b15-20020a17090a990f00b002866cc13f1bmr8637604pjp.82.1702625052825;
        Thu, 14 Dec 2023 23:24:12 -0800 (PST)
Received: from kylin-ThinkBook-15-G2-ITL.. ([111.48.58.12])
        by smtp.gmail.com with ESMTPSA id in18-20020a17090b439200b0028b041cbef3sm2888719pjb.22.2023.12.14.23.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 23:24:12 -0800 (PST)
From: xueqin Luo <luoxueqin@kylinos.cn>
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH -next] ACPICA: Replace strncpy() with strscpy_pad() for dest
Date: Fri, 15 Dec 2023 15:24:05 +0800
Message-Id: <20231215072405.65887-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While it is safe to use strncpy in this case, the advice is to move to
strscpy_pad[1].

Link: https://www.kernel.org/doc/html/latest/process/deprec:qated.html#strncpy-on-nul-terminated-strings [1]
Signed-off-by: xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/acpi/acpica/utnonansi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnonansi.c
index ff0802ace19b..3a7952be6545 100644
--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -168,8 +168,7 @@ void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size)
 {
 	/* Always terminate destination string */
 
-	strncpy(dest, source, dest_size);
-	dest[dest_size - 1] = 0;
+	strscpy_pad(dest, source, dest_size);
 }
 
 #endif
-- 
2.34.1

