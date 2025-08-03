Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F1328F4
	for <acpica-devel@lists.linux.dev>; Sun,  3 Aug 2025 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754235552; cv=none; b=dHKBAHCtvSsvT0VK9FIS6T19mDoRr8TmTgYd00ag3Rh4RfOoou8l6QEtW4lnFuBz+KaS5nOYbG4R2iO1EGcvjQi+l+1R7V5DyQ1b7OKkLxhnu28UgGAG6lSlhLZvVfUgGngRh71QK9vZkGBQh7WAoEhAziRgQgWTcT97mI6w6VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754235552; c=relaxed/simple;
	bh=QnhcH6EmOVfVct7pYcTO7Tgv9reBGW+qWGGn3slLxgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SwzSzD5oHNyLKe3nNC5jvL9tEjxhUKBJZvzOQaMpyhS369xX1oBsc4wd2rSkQAyODI+duf2hx/igY44M9kKJvxw2DRv5GDZqJLsebabzgF2wKhG4lx+XgD8h5iLB96/LsFK9Z12QlbHLTLyPGbMNHgTivmN8Smy8bHOf+3Pdq2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDkenbEf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDkenbEf"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76a3818eb9bso2018001b3a.3
        for <acpica-devel@lists.linux.dev>; Sun, 03 Aug 2025 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754235550; x=1754840350; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ij3lZbSxaO2czp7QJ8u/Z0Siwp4mTMeKHEVXbv9xEV8=;
        b=lDkenbEfZO+FIZI0L+KD3b6fXn9hiBNTZMpFJDdJDSjIpO5k4/OoGNqJiFjMjPQapw
         BlRZWIli57DOlfmURDRNenY5GO4tUaghgxEksS9CtNF6yG7kkkWQoGnUOaOqT7MioPfY
         2dxJlta/+rFzhOyAw0YstvlX4BYVA7bW9tf8avlVIsVY4s7d59QAXA4ZZIrhogNMpWFd
         8I2n1hmYWYPlS3lkOhXalRLkD1Abh5iX61mBtK7hpNPBwS83ixoNTDGzCUUTricuee5v
         k0r71BZzU68bqtOXlhkH+HASv5q9Cri3jvf4d0/0/BvwFSc+QH2ba71bNq50w/l6UUvn
         RTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754235550; x=1754840350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ij3lZbSxaO2czp7QJ8u/Z0Siwp4mTMeKHEVXbv9xEV8=;
        b=sxvMaawG/e+LeeAa2AhsAMdjUULb7iL+OxC9FHmdnwEmQMsA9et8kqMnDmILed6zNq
         q4BnYp4uniNsYyyOhr68Uki9qvUkoX/ofjEKx0kwBlX/m3VtxUL++hw8F97m8L8X8Rig
         a0gn8bVRs6z/iRPYVM3o/2aJGx54W4rHvhKOCdmEVIFHJgPql0NtQDxlwFS8j5i2vjEO
         M41WQWlnjDlsJpLvEy5ONwJ3AjLhBu31TCpx/5WD077sUstnfTd0NAbFGlOCssYK8z//
         9F7p/wzhuNLoy9G+7vGRvv4DulPIwzx01KowljAaELxm9JxjRRXe/2K66fT1999rUxYr
         4yUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi3Y8LdC36hI2ZF+tg5mqsf0NvHl/gfEbF2MUFTc4vAT75uC90htLbIA6b/P7w3f0lxYq15bPbx7Q4Jx8=@lists.linux.dev
X-Gm-Message-State: AOJu0YzHngbhw60IA/SKmTxGltLmzbu387oo/IwNDwZO4u7llYLXhdpZ
	x60SEu3f/moSDl1Ln+z++/TTTv1e19wtbaQr3GujZbb0k0OfnTHRqSKh
X-Gm-Gg: ASbGncskhDXdM0dajopCNjHb1w2k7A3cO3xIiC79nLRk7+wav2x1LTTuhepbo8XWjG/
	a7TY+RD85rH2xhz3NEkgtSnxJzNWOFz9Tp3zA0EmpJuACEmn9GyelZd5UGZrqDiySvqqtwLLxSr
	LFrnB0m6+tg/DwR9sZ2gDWtKwz5BBQXam3PlVe0Mrey4ercVIqUXszB1/WVPBQka26SinSmO8vb
	4HrSu0GDQiDKVUuRFMmSbgO1obEmvSTkmMMI8P1Na6EVviA9rtRzWh/+Zrt1B9zYSmVxnM0Gg5j
	RblTmjuFpF/JvNTjBJbNpU70VV55bqfNXR9/LypuFPeY4/uzM4agqx6E/LAvFPbpPge0w2aAjuu
	1aP8toC9HCg==
X-Google-Smtp-Source: AGHT+IHlv4LdOei1NQjX17HaQo40l3r02Z+8Vmhd8q3LeHn7bo5+nyuKOLMqzXI5mVFrLexVqTtDng==
X-Received: by 2002:a05:6a20:244b:b0:23d:7c59:c7c1 with SMTP id adf61e73a8af0-23df91a0467mr9896065637.44.1754235549756;
        Sun, 03 Aug 2025 08:39:09 -0700 (PDT)
Received: from diksha-pc.. ([49.207.53.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f483sm8382190b3a.31.2025.08.03.08.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 08:39:09 -0700 (PDT)
From: Diksha Kumari <dikshakdevgan@gmail.com>
To: rafael@kernel.org,
	robert.moore@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de
Cc: Diksha Kumari <dikshakdevgan@gmail.com>
Subject: [PATCH V2] acpi: remove unnecessary parenthesis from return statement
Date: Sun,  3 Aug 2025 21:08:30 +0530
Message-Id: <20250803153829.6545-1-dikshakdevgan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch.pl is generating a warning when return value is enclosed
in parenthesis. Remove the parenthesis to improve code readability.

Signed-off-by: Diksha Kumari <dikshakdevgan@gmail.com>
---
 drivers/acpi/acpica/dbconvert.c | 43 +++++++++++++++------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 8dbab6932049..5f53388b6f1e 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -31,9 +31,8 @@ acpi_status acpi_db_hex_char_to_value(int hex_char, u8 *return_value)
 
 	/* Digit must be ascii [0-9a-fA-F] */
 
-	if (!isxdigit(hex_char)) {
-		return (AE_BAD_HEX_CONSTANT);
-	}
+	if (!isxdigit(hex_char))
+		return AE_BAD_HEX_CONSTANT;
 
 	if (hex_char <= 0x39) {
 		value = (u8)(hex_char - 0x30);
@@ -42,7 +41,7 @@ acpi_status acpi_db_hex_char_to_value(int hex_char, u8 *return_value)
 	}
 
 	*return_value = value;
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -68,19 +67,17 @@ static acpi_status acpi_db_hex_byte_to_binary(char *hex_byte, u8 *return_value)
 	/* High byte */
 
 	status = acpi_db_hex_char_to_value(hex_byte[0], &local0);
-	if (ACPI_FAILURE(status)) {
-		return (status);
-	}
+	if (ACPI_FAILURE(status))
+		return status;
 
 	/* Low byte */
 
 	status = acpi_db_hex_char_to_value(hex_byte[1], &local1);
-	if (ACPI_FAILURE(status)) {
-		return (status);
-	}
+	if (ACPI_FAILURE(status))
+		return status;
 
 	*return_value = (u8)((local0 << 4) | local1);
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -122,9 +119,8 @@ acpi_db_convert_to_buffer(char *string, union acpi_object *object)
 	}
 
 	buffer = ACPI_ALLOCATE(length);
-	if (!buffer) {
-		return (AE_NO_MEMORY);
-	}
+	if (!buffer)
+		return AE_NO_MEMORY;
 
 	/* Convert the command line bytes to the buffer */
 
@@ -132,7 +128,7 @@ acpi_db_convert_to_buffer(char *string, union acpi_object *object)
 		status = acpi_db_hex_byte_to_binary(&string[i], &buffer[j]);
 		if (ACPI_FAILURE(status)) {
 			ACPI_FREE(buffer);
-			return (status);
+			return status;
 		}
 
 		j++;
@@ -145,7 +141,7 @@ acpi_db_convert_to_buffer(char *string, union acpi_object *object)
 	object->type = ACPI_TYPE_BUFFER;
 	object->buffer.pointer = buffer;
 	object->buffer.length = length;
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -175,7 +171,7 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	    ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
 				 sizeof(union acpi_object));
 	if (!elements)
-		return (AE_NO_MEMORY);
+		return AE_NO_MEMORY;
 
 	this = string;
 	for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
@@ -190,7 +186,7 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 		if (ACPI_FAILURE(status)) {
 			acpi_db_delete_objects(i + 1, elements);
 			ACPI_FREE(elements);
-			return (status);
+			return status;
 		}
 
 		this = next;
@@ -199,7 +195,7 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	object->type = ACPI_TYPE_PACKAGE;
 	object->package.count = i;
 	object->package.elements = elements;
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -251,7 +247,7 @@ acpi_db_convert_to_object(acpi_object_type type,
 		break;
 	}
 
-	return (status);
+	return status;
 }
 
 /*******************************************************************************
@@ -272,9 +268,8 @@ u8 *acpi_db_encode_pld_buffer(struct acpi_pld_info *pld_info)
 	u32 dword;
 
 	buffer = ACPI_ALLOCATE_ZEROED(ACPI_PLD_BUFFER_SIZE);
-	if (!buffer) {
-		return (NULL);
-	}
+	if (!buffer)
+		return NULL;
 
 	/* First 32 bits */
 
@@ -331,7 +326,7 @@ u8 *acpi_db_encode_pld_buffer(struct acpi_pld_info *pld_info)
 		ACPI_MOVE_32_TO_32(&buffer[4], &dword);
 	}
 
-	return (ACPI_CAST_PTR(u8, buffer));
+	return ACPI_CAST_PTR(u8, buffer);
 }
 
 /*******************************************************************************
-- 
2.34.1

