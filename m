Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B0513A868
	for <acpica-devel@lists.linux.dev>; Thu, 31 Oct 2024 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395937; cv=none; b=fVLWEA2rx3ePX7MDT0TVnzSzQkuM52temZZTfhTgxL7kp1e4QuKUi+WEUw1++dCqRGCTa9xhED7A7yMapRqixUvdN+MxpGv1/GTUvPNh39p2/tvo3jZyVCngzpjb4UhrJ/tvy1+NA3yPAD/gaC+AYTXPMBusXhAzT8gaLxeIexY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395937; c=relaxed/simple;
	bh=M0pIn94Azowchec7I7p7M49ATq272Lmt8o7hlwxwDKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rHNaN0B8BniGPsi4bfkIr81KtqYk5UGvjU3cWWvwzOdhfR0hd17Q8mRh02l3j0Y/RdHXNxObqJUbZ4qGyLdHm8Ydui6MjGXQz3nWF+wsKJST7Vl+30jzHQKZPKXPpXbO16J0fnJxyFH+ZBOrL2/hC8SH8FHBBycTF/SyLaFTQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMGBljcU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMGBljcU"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e4824917so127585e87.3
        for <acpica-devel@lists.linux.dev>; Thu, 31 Oct 2024 10:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730395934; x=1731000734; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4sLwJ1Za+GKDAjN1FVw7zfT75tbwo/FRlb/5kWrOi0=;
        b=hMGBljcUA4bVZPPvALJrzy1hMkELvMYMxWlQlBFv3CDPPU9NzqB7UGJBzTDux3LLXw
         Z7nD2VTvJUq/tp2wJDPVbzaX1X109NOhbYfqGZ3eURxv3h0aswBblqZeM+/Oz0ka/9hJ
         GJI61qtmofClm+tU1MBtUKhVJtQ2HA9IgUhZw3NRPR1ICDc/sBel+woXyBNplDQsD6Br
         IIkB12ic0BZIwNQQmrsj40LxihFfCb6Ovtepn9w85L0OnoaJyUjWf3BaSTLeSEb8j6xr
         Znwfk5GYCFyX+5I2Qo94nkD8g7Gv6LkhSBF/HJp8tUmPP1c08PNK8gIbnUy/Poc126D7
         0FAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730395934; x=1731000734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4sLwJ1Za+GKDAjN1FVw7zfT75tbwo/FRlb/5kWrOi0=;
        b=MOYQLmj6VNhTuEHQHD2fESPlqiWMOCjPsq7z9mw5T8D2tBxhRZWD1e1XCJ6jieo5zB
         dvMSCwjQx2zi7eKisVpG+bMjNBd/QkEUz0D9NtI7nv2tVJYeJ94ZczH9b/5BhoqGAgnX
         in+4YZkDrn/5+stZC7IfllPWdle+DV4wL07/vHcD5fLCOt+rEQiNtX49adWhruisLBK5
         Ut5cTIa4nfitbtaovxlrY4dDZmeHjb0NRR+k7qHAiRNxt+nBR85pO6fdRLOe8Tsc2D2E
         F7DVLU/tEJ0jCTWVh/CPtAxS0bKIPZWVRH1TLn2ZXu3UvPhZ/TZD5NCfLsz9Ui0jayHc
         Ij9w==
X-Forwarded-Encrypted: i=1; AJvYcCUMe2g6BLoeKbR92f1M8lUjWkPihXuUw6HusbNxQMXxaSX8MlIPTd69TfbZyCypLeoWTM+W+2mdyRRFri0=@lists.linux.dev
X-Gm-Message-State: AOJu0YwpoL2LMCzBBE91NwNy6o92fv5Y/qFpCle3LPhPmjT8GOt2BTav
	K1KFKyp9QnrKH0VE+o8OK3k8vvWk3kpBVoZwweNfkSp/bvnymGgE
X-Google-Smtp-Source: AGHT+IFe87xKBVd4yftUeVT3qx9Oy2VAjU24uHaxTTbj4T2Gm9PoVBGwUR8pD/gNPDXKGc4fcsTaTA==
X-Received: by 2002:a05:6512:2354:b0:52f:c142:6530 with SMTP id 2adb3069b0e04-53b3491cb47mr3046431e87.6.1730395933433;
        Thu, 31 Oct 2024 10:32:13 -0700 (PDT)
Received: from localhost.localdomain (109-252-121-216.nat.spd-mgts.ru. [109.252.121.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bde3287sm270315e87.273.2024.10.31.10.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:32:13 -0700 (PDT)
From: George Rurikov <grurikov@gmail.com>
To: Robert Moore <robert.moore@intel.com>
Cc: George Rurikov <grurikov@gmail.com>,
	"Rafael J. Wysocki" <lenb@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] ACPICA: Fix dereference in acpi_ev_address_space_dispatch()
Date: Thu, 31 Oct 2024 20:31:46 +0300
Message-Id: <20241031173146.1459-1-grurikov@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When support for  PCC Opregion was added, validation of field_obj
was missed.
Based on the acpi_ev_address_space_dispatch function description,
field_obj can be NULL, and also when acpi_ev_address_space_dispatch
is called in the acpi_ex_region_read() NULL is passed as field_obj.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0acf24ad7e10 ("ACPICA: Add support for PCC Opregion special context data")
Cc: stable@vger.kernel.org
Signed-off-by: George Rurikov <grurikov@gmail.com>
---
 drivers/acpi/acpica/evregion.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index cf53b9535f18..03e8b6f186af 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -164,13 +164,17 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 		}
 
 		if (region_obj->region.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
-			struct acpi_pcc_info *ctx =
-			    handler_desc->address_space.context;
-
-			ctx->internal_buffer =
-			    field_obj->field.internal_pcc_buffer;
-			ctx->length = (u16)region_obj->region.length;
-			ctx->subspace_id = (u8)region_obj->region.address;
+			if (field_obj != NULL) {
+				struct acpi_pcc_info *ctx =
+					handler_desc->address_space.context;
+
+				ctx->internal_buffer =
+					field_obj->field.internal_pcc_buffer;
+				ctx->length = (u16)region_obj->region.length;
+				ctx->subspace_id = (u8)region_obj->region.address;
+			} else {
+				return_ACPI_STATUS(AE_ERROR);
+			}
 		}
 
 		if (region_obj->region.space_id ==
-- 
2.34.1

