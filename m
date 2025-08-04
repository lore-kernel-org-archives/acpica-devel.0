Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2604B2F2E
	for <acpica-devel@lists.linux.dev>; Mon,  4 Aug 2025 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754333948; cv=none; b=CTGU+IkM85jPIfwi5yn6zzwLFY/B/OSqr1couYXDYTMGrQGZhGO7j8Jrc1lCv6VIHOTtJBcykNd8pIDDe41pi4GKNGQmNDDXwr6iEUgmTMCr4hcgiHuVdFzDD+C7YCITbP6f4JFMPhh1bOJvTYwJqlng5yV0kKDcRYa5Yg8ZYk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754333948; c=relaxed/simple;
	bh=cEmRum5XYAzlQ9YsYVZG/YOXocwoC+rRSdZyIJuBJ3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BLa/Mmw/28dnKsepG7BMGhZLcNIq2xxkCgqBeedyL7k1fxHkO6a1oZHzI5Z1Cb7GD6sxkQg2tiT28dk99f5TJ+442R4wxHa4X6Q1RutHP6zkP9W+g4BWg5Z/F3WzN/noR2X9pa/nthwY0zg/5KuWl2PfmjreMqMSii3IJKnAyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aro0rh+F; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aro0rh+F"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23fc5aedaf0so33158535ad.2
        for <acpica-devel@lists.linux.dev>; Mon, 04 Aug 2025 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754333946; x=1754938746; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMHrDBTVCapZN4Ij1l4T90M7GkuqWi+q6Y/GUZJOE5A=;
        b=aro0rh+F82Phg+c+CNkCzaUokO6ckeBo1J5BkN0/VHceZRmJah/JcPFFLGw9hhpvzF
         rxoc6HS5ifdBYNghQy9szvNN3hpghP+tnF36KUelELOZnCvm4FmyTuF4x5vViAuItoEM
         8GGa/Rdiy2Kbi5fGzs5n1YaZZtEYKpaDtD3v6sRkO8Kn9WAyiEvHUJ2LE3AFVL2tYGIt
         icsnpylvv1WiocK8alcB/opFi2414b9A2WWTeGcxeIV2BjOlt36OdChUti1+Jx2giuXq
         Sfb8son/Evx7RiYdFQUNQz9VuWy4BsJz0e3h/bRLptrQtEStCJgJTrX48iPwqrIQVvCP
         56xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754333946; x=1754938746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMHrDBTVCapZN4Ij1l4T90M7GkuqWi+q6Y/GUZJOE5A=;
        b=crlDKp8yc7ot7+FRoNFeuzI6oXKiWuVBHbV2ER3qbaUO8G1/AxHLrNye0M+sjYutKZ
         GdKKfl+QxdMknMcn6nBvWK3LbSLgezdzRP34tdLKDAGCSEnxKUY+73BJibvbfZf0ezvo
         ep6Zg897h4Ol2Iv2T5C8911wiMMewxtI49oXYaXwDWqGC7FKeALmkY78arpXesvSovhS
         XqNSUN6qnrE2sD8j8oTS1Qt/MiiZYvhvOmnD/cKjtJ/g+0YotLWQx5MySKswAQhVXaMn
         x6Ca5a7fgoru7w+23pkRONYIW2hFZK80KaUlW2+UFUZACzrno0Pt50VqvGcR5ZUU7yNg
         ktpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVof8ykXeQZTnYkucnfkARQX9tetxDBXjM40lhrfhK1kn7EELcSNbd5bQcvEKaYZaO6AJ6ZcxFGWR4YKeo=@lists.linux.dev
X-Gm-Message-State: AOJu0YwsiukP1cvY6mb4gB+34b8SaLoQzjrwnEr6MkVYhaRC/hzncRsb
	lkMoCj2h94xEKD6o+taI7KUlb8cPdGPS0j8Sw9o2AqWmy3JrXPmtnlQA
X-Gm-Gg: ASbGnctjs182b2Shc35SqbKc2LX76kcPAMBJ2796QeK9pFiEMIZeUxOdjlKh84rhpZV
	ILABZeqFgJEx83e3yeCcQkqMH7JzUEFalz+cVeS6eFVlS4yY1uFvRQOS8vjVY9WX25jICnhKl5R
	ewc8Cgna8PYoeerDbeWCYi14hdRNNoJhnjpEaVkS19Iq6IEt05R0Js5nY7voEtHcKHByNk8cGnB
	JIUCSpCEtaIbMr+aP6gTrek8b2H5teKWd7eX8Ru2nUkKR6Qv5dmRPWEUyt3kryq71Z+scFgLOmR
	ET5Bvz0hdJxeyjWlTkg26W/JJHVBw8MQjntGC1D6RKl8zBAAjn97ynqpLADSt36LfgEVYTvD49h
	nqN/o9NJRrRfER6w=
X-Google-Smtp-Source: AGHT+IEOnucQk03b0U4cuDeXdIZDNb3Av5jSWL1ukaJL0ECYCD8PzJA4YIhmCdjbvBLf0PScyJPtrQ==
X-Received: by 2002:a17:903:2d1:b0:23f:d8e4:ded2 with SMTP id d9443c01a7336-24247066a0fmr142738105ad.53.1754333946401;
        Mon, 04 Aug 2025 11:59:06 -0700 (PDT)
Received: from diksha-pc.. ([2401:4900:1f27:8800:4f4d:8f79:7e46:47aa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976d13sm115046835ad.109.2025.08.04.11.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 11:59:06 -0700 (PDT)
From: Diksha Kumari <dikshakdevgan@gmail.com>
To: rafael@kernel.org,
	robert.moore@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de
Cc: Diksha Kumari <dikshakdevgan@gmail.com>
Subject: [PATCH V3] acpi: remove unnecessary return parentheses and conditional braces
Date: Tue,  5 Aug 2025 00:28:26 +0530
Message-Id: <20250804185826.29723-1-dikshakdevgan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes unnecessary parentheses around return values and curly braces from single-statement conditionals.
Curly braces are removed only from conditionals that are directly related to the return statements being cleaned up.
Other instances of one-line conditionals remain unchanged to limit the scope of this patch.

These changes address checkpatch.pl warnings and improve code readability.

v3:
- Updated commit message

v2:
- Addressed review comments
- Updated commit message

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

