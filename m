Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5811291C02
	for <acpica-devel@lists.linux.dev>; Wed,  6 Aug 2025 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754508170; cv=none; b=R/BXiqzVHZUkqJI+585YeX46DoScbQIzeCX82lue0SXJNJR3VodNi8YS+cUMBfDu75HIGpyzDVNsC8a4iWl4Kt0IVKKe51gM8VT62qGOp2RIE9S2fP9V76yNGYDd4TUbO9DKQs5/TTT0uRx4HwsSFhWiXn9hgUs2OhOG2hXGQ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754508170; c=relaxed/simple;
	bh=0Smmvk7/7PBIfJOmFbelMA4iOxCor7rfdYx7f5lWz+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f2KIzGMgd0qqhCLAGsOswD4sjGCgBieS7o0nifOr/X4P7/OR1y4qWt7zNpo0iiM+m8pYQCb1GIKDB50UbUmFGcNLLSzC4fxDX7362IScC+yQ9sBhEiiLxwevFVIfF9ybwUobGF5OH6ITXde8i+ZC2J4E7LSD4EaEwAaLF3CLe+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBr39dME; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBr39dME"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76bdc73f363so299335b3a.3
        for <acpica-devel@lists.linux.dev>; Wed, 06 Aug 2025 12:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754508168; x=1755112968; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4AyOWdEDqjQgldlgukYNr30YcKFtHC6pdaPLRv6HM7w=;
        b=RBr39dMEysGr0SLnC12r9A8s1qRBC7Js7UUS+CqvFHji3EwGFwTpj3nOJZTYZ3ss2x
         JHq8Tm1C2y9dOJqtCOuRLugeM/ukEWQQRBqRGHRgeOPTvA5umAaoBLEYO2bvXKtKgSv6
         L9vRiyxO5/ANXwIavVQ2XqO8dXJmN1Be5f7X+HXEPKUW8qhj3lYyATkdFyhl+pQuaxXc
         4QvoJSMuiTyH3BFJoZOGGB7LF+QiK3ausUFd+MB5j/+A8sHLFkMJp3T0s2TEhgwovwS9
         UfyFNa4m3aRA3RRcXvAnMdfKGRI/9IoFVv5DS2cbGVIaaj8oJlZJy0gRbvorqKs564HC
         9KaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754508168; x=1755112968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AyOWdEDqjQgldlgukYNr30YcKFtHC6pdaPLRv6HM7w=;
        b=UPSCIwaNc2j0rf0WBwYHTraEMggEs9EWj0G3D30hbFoeEr6vH8qFeRkO3BfSe6m88y
         XwKrR4DaN9AXKpaUE03BabZj4YJJqPksenEJx6TzzH3/qPjaLdSx0Tocw41yXMvVotFK
         FvTUSQkF5kPrSar/1Pc3E38fIDa3IpQOe/aF2ICqBEP27+YfBNlT5STowwgvQKMoYaDI
         qehzlShzIXLyZQ0lAhmPfpb6Vc8q2qlxgRQb/mB8ipBOU7dNwHW7AqAg8D0/pw1668Z3
         7Ki4yKG3RCH0NrRl11xdBmilXTc6uaH2z2PxASNu9M+VFtVhVmdCKZNWfVkPvL4B3KE4
         RnqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNBXJuEbicYe68K9HoHxp4ihtFSzWFB1CHciVucXoLW/WR7LPrzQvWWlDbNCeOMX6ziJXCcnI60dq2KaI=@lists.linux.dev
X-Gm-Message-State: AOJu0YxS9lM/k6pfrCLnpee3u8IJdVe318PArQlEKe/ycn1qF8Rhlcag
	GcDv5GO9weXQdRh+amXKJcl93pZx//9sKij7ucBFSxEPuD1aUSuKBybC
X-Gm-Gg: ASbGnctqDKOREvCo7snA3cHVgBvHngNu9g8af/G/y+Nzatj0clv1vXVNU0fRYgXWBsR
	JnVlqlqwT3x/yGU/44M4q3Xf7S2aXMin0OIV/w3c7ud+zxdJPCZZ/ffnr7LR+eIiuMT/ETvtIxJ
	QNXqhzBU1xnApouaeoPieZ8IwdPonUauY310czecHm7/Yhxwlmh/opsREFZM2VXyolKRMCW7awt
	YWFmFy37dUbMQlIVdF+l9GIrsvBDxt5g+9U8D8LFuh4spVoMi5k+gmD4P2a4k/j49WV0NkSMiuD
	MdRLDjrN+/Z6Yb+6anXTycf+6eksQsV33jgtKbCMfS2NgaK0zFRLxq/P4FvGZT3IsReL0Ag2vFN
	YIITZbA3SB7wsnzWRat4fJiaHUHWxTn5O7OViCH+M
X-Google-Smtp-Source: AGHT+IF6JEuKE3Jn3aX/UVQAo0grixOintA1fW1G8ukMtbQ142BQH0FQqo5RG9vdd72dWReaWCJnvQ==
X-Received: by 2002:a05:6a21:6d85:b0:240:21e1:cbbd with SMTP id adf61e73a8af0-24031455135mr6502150637.26.1754508167931;
        Wed, 06 Aug 2025 12:22:47 -0700 (PDT)
Received: from diksha-pc.. ([2401:4900:1f27:8350:374b:b9dd:a07b:cf15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd1d4e312sm15528619b3a.17.2025.08.06.12.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 12:22:47 -0700 (PDT)
From: Diksha Kumari <dikshakdevgan@gmail.com>
To: rafael@kernel.org,
	robert.moore@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de
Cc: Diksha Kumari <dikshakdevgan@gmail.com>
Subject: [PATCH v4] acpi: remove unnecessary return parentheses and conditional braces
Date: Thu,  7 Aug 2025 00:52:40 +0530
Message-Id: <20250806192240.31849-1-dikshakdevgan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

remove unnecessary parentheses around return values and curly braces from
single-statement conditionals. Curly braces are removed only from
conditionals that are directly related to the return statements being
cleaned up. Other instances of one-line conditionals remain unchanged to
limit the scope of this patch. These changes address checkpatch.pl
warnings and improve code readability.

Signed-off-by: Diksha Kumari <dikshakdevgan@gmail.com>
---
V3 -> V4: Corrected commit message and patch format
V2 -> V3: Updated commit message and added changelogs
V1 -> V2: Addressed review comments and updated commit message

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

