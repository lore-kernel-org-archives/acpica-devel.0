Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C3E54774
	for <acpica-devel@lists.linux.dev>; Sun,  3 Aug 2025 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754221148; cv=none; b=HDrzMzzMlaAHX9KPYXhHXr+UypNyDGvaFsN5jff2DY1VdziBT53y/jwzFphdmr4q/+8C+g9l5AlsUD6oclOxhJUb7XNdqgPe7CYDCrZEKPnbLzjocYAzmdDvnAA/aFpOl3y9LSNms280/8yRC4qiipO5LK4SBpm83nNzP/yPaJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754221148; c=relaxed/simple;
	bh=s1FR7zxDZSSXuXE1d969kx1AYfH0bBKhLwrR+UZ+uDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NOiLdz7KAFUWcZmxMKukF0h5wHObTf6YyrHb+g1FmQI0AAt5HSnnjfJnU+w9PwmUCdWS1Jkxte9GrBqej7AfG8HogZjqIIIjrZvazFzZL/ndsE2z6csYAgvdq40oK9uMHdVen+OR4ewJ9T0hDWbB2HZfa54Gb9hzeFnnbL9vcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ygb5iVLw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ygb5iVLw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2401b855980so26383635ad.1
        for <acpica-devel@lists.linux.dev>; Sun, 03 Aug 2025 04:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754221145; x=1754825945; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y5aQYQG7h1SH5iX9vRpAQpmq1mqK08hgnvrQbM2elCA=;
        b=Ygb5iVLwpOHLzBW4fi/jUNAeMwkWcD2DeN1LfzOYrhglQCvlUuPydk/IzV7Gcmnlpc
         xKN/wQz2YRjX7yiTQAqMsNXUIVBbSylxe90ZBrHVroWgP2WcrXsYFdflmWtWdpl3XxXF
         PQiE0E1P/x3QLKTi/fLh4tkkG7tS1OQTxfTUjq1168vgxSFmw663KqRU+lggDO/rbFmI
         /XRWetFoOWrutF6rrsunEkfXn1zZuWzQ1HjUzkL+Hk/vWWkUOmFuKDZ1J01CGUC+q43K
         GX+M1N8pWGZqFYxgXg3XQwSlbRjd4KRJz+tr0jcnrpF4P26ZLXudL51Ku2jgBOVZkRdb
         ZYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754221145; x=1754825945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5aQYQG7h1SH5iX9vRpAQpmq1mqK08hgnvrQbM2elCA=;
        b=C5ojHAr+9kdA3YZKjmGFV7Pv64m5T4A3dnLtkAvo6Yuc8IAp+C81FoWT+bSMAZOeoT
         0UUNCt4eoN1P4AnsGv51ec1j693W9V1qRFljwkPliTnB1+qxvdpqJTYZsDGr/Rb7N6/J
         s2tvm3y5TD7KAua2J4xF3AGId78rQtSk1wes15MRoH44njQzNGqXWv89TtC16+sncCV+
         wVNPIlc7ScjRre1Kgp0xYrftvKM/XabgoG8wsq+KKcuuEXctiFOCxCbemgXDtHNvb0sq
         5BVbCJEWtoCWbvullpRQ7yv8NGof540wrH63TieRMCJySWrTkf+sKpXvSzBLgF7nVQyQ
         DBew==
X-Forwarded-Encrypted: i=1; AJvYcCXsgixMiZbof2uPfrAiZQMzXa0/lUhFMtiJWKA3rZ95KCCy3UEbj+XjuexWJIDEqyjaeuD4EAgKiaeAcHQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YzbDzbbHf1QSXTUlegtDRBcZD0qo/4qD3flJIZxfWYTZM4/r/gG
	u+qPp5Ubto9ScA5QcpJhWgy2lRNi/dbmth5y4CjYdZR4CwcY9SzLvg+E
X-Gm-Gg: ASbGnctd0J+Bmv4Q3w1cBAq/bxEbMn7E/sycTBS2AdNbt2X5CkIDv6xaLzRZ3LCZOBS
	QNO83PzMyXjXMVbInHWdbj+JIFExkgBwMn+VdwmGTxze9sFH/zviPxe/J/xKdT2+zSarAVzlyFF
	t4SYb5HetV6g+MJBdTZwoIivUq5Ro0uYvib93NJ/kO04OPqTTUn+eqQz21ppuB74Ln9ffpxCOJX
	DB3d41LiEuLvaXxntysliLM6/BpPGyqWXHtGo3ZdJPe+Vzi7vC31Orm9sD1nftr5Haop+VjNKHC
	mvkZABxrFB2Pa1G4WqzYac0UxYGifWQ6wSjIpg/c6f53vxvRH3JLgmNOV+BiaDKyIevbASXcRJC
	rqU1HgdftICcvbauYvfSP
X-Google-Smtp-Source: AGHT+IFcjXs40AxnwGTjfvVWOaYc9m2DmTG8evzSHsQvp65r/QMyy8sA4I35X3KKVoTM/Dqbar8UnA==
X-Received: by 2002:a17:902:f252:b0:23f:ed09:f7b with SMTP id d9443c01a7336-24247063df9mr51125695ad.48.1754221144647;
        Sun, 03 Aug 2025 04:39:04 -0700 (PDT)
Received: from diksha-pc.. ([49.207.53.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8ab0c40sm85423775ad.180.2025.08.03.04.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 04:39:04 -0700 (PDT)
From: dikshakdevgan@gmail.com
To: rafael@kernel.org,
	robert.moore@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Diksha Kumari <dkdevgan@outlook.com>
Subject: [PATCH] acpi: remove unnecessary paranthesis from return
Date: Sun,  3 Aug 2025 17:08:20 +0530
Message-Id: <20250803113820.16578-1-dikshakdevgan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Diksha Kumari <dkdevgan@outlook.com>

checkpatch.pl is generating a warning when return value is
enclosed in paranthesis. Remove the paranthesis to improve
code readability.

Signed-off-by: Diksha Kumari <dkdevgan@outlook.com>
---
 drivers/acpi/acpica/dbconvert.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 8dbab6932049..7995c1578522 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -32,7 +32,7 @@ acpi_status acpi_db_hex_char_to_value(int hex_char, u8 *return_value)
 	/* Digit must be ascii [0-9a-fA-F] */
 
 	if (!isxdigit(hex_char)) {
-		return (AE_BAD_HEX_CONSTANT);
+		return AE_BAD_HEX_CONSTANT;
 	}
 
 	if (hex_char <= 0x39) {
@@ -42,7 +42,7 @@ acpi_status acpi_db_hex_char_to_value(int hex_char, u8 *return_value)
 	}
 
 	*return_value = value;
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -69,18 +69,18 @@ static acpi_status acpi_db_hex_byte_to_binary(char *hex_byte, u8 *return_value)
 
 	status = acpi_db_hex_char_to_value(hex_byte[0], &local0);
 	if (ACPI_FAILURE(status)) {
-		return (status);
+		return status;
 	}
 
 	/* Low byte */
 
 	status = acpi_db_hex_char_to_value(hex_byte[1], &local1);
 	if (ACPI_FAILURE(status)) {
-		return (status);
+		return status;
 	}
 
 	*return_value = (u8)((local0 << 4) | local1);
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -123,7 +123,7 @@ acpi_db_convert_to_buffer(char *string, union acpi_object *object)
 
 	buffer = ACPI_ALLOCATE(length);
 	if (!buffer) {
-		return (AE_NO_MEMORY);
+		return AE_NO_MEMORY;
 	}
 
 	/* Convert the command line bytes to the buffer */
@@ -132,7 +132,7 @@ acpi_db_convert_to_buffer(char *string, union acpi_object *object)
 		status = acpi_db_hex_byte_to_binary(&string[i], &buffer[j]);
 		if (ACPI_FAILURE(status)) {
 			ACPI_FREE(buffer);
-			return (status);
+			return status;
 		}
 
 		j++;
@@ -145,7 +145,7 @@ acpi_db_convert_to_buffer(char *string, union acpi_object *object)
 	object->type = ACPI_TYPE_BUFFER;
 	object->buffer.pointer = buffer;
 	object->buffer.length = length;
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -175,7 +175,7 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	    ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
 				 sizeof(union acpi_object));
 	if (!elements)
-		return (AE_NO_MEMORY);
+		return AE_NO_MEMORY;
 
 	this = string;
 	for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
@@ -190,7 +190,7 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 		if (ACPI_FAILURE(status)) {
 			acpi_db_delete_objects(i + 1, elements);
 			ACPI_FREE(elements);
-			return (status);
+			return status;
 		}
 
 		this = next;
@@ -199,7 +199,7 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	object->type = ACPI_TYPE_PACKAGE;
 	object->package.count = i;
 	object->package.elements = elements;
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -251,7 +251,7 @@ acpi_db_convert_to_object(acpi_object_type type,
 		break;
 	}
 
-	return (status);
+	return status;
 }
 
 /*******************************************************************************
@@ -273,7 +273,7 @@ u8 *acpi_db_encode_pld_buffer(struct acpi_pld_info *pld_info)
 
 	buffer = ACPI_ALLOCATE_ZEROED(ACPI_PLD_BUFFER_SIZE);
 	if (!buffer) {
-		return (NULL);
+		return NULL;
 	}
 
 	/* First 32 bits */
@@ -331,7 +331,7 @@ u8 *acpi_db_encode_pld_buffer(struct acpi_pld_info *pld_info)
 		ACPI_MOVE_32_TO_32(&buffer[4], &dword);
 	}
 
-	return (ACPI_CAST_PTR(u8, buffer));
+	return ACPI_CAST_PTR(u8, buffer);
 }
 
 /*******************************************************************************
-- 
2.34.1

