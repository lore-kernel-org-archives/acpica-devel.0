Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15DA81C
	for <acpica-devel@lists.linux.dev>; Mon, 27 Nov 2023 05:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp20Miso"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-285c3512f37so605672a91.3
        for <acpica-devel@lists.linux.dev>; Sun, 26 Nov 2023 21:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701064763; x=1701669563; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T+lkPxpcGV4ulENWtL8UIKN/+j2CNZhdMfJlWPRbNbU=;
        b=jp20MisoJE8VKK1JlQUZF21fYMtSKREhm3yQNruFEU6QFrlLAK4rxvN2Ff7ylpaQ8j
         XzOUjC7Lf9p7Fu4MQuNQKJ8QCnRJVW+q+rwqyOTw1nNea4UUk7ujcBzK9f1uFvpk/G9I
         UyW/1ym7dEEAU4FedQnpYkH4Fe34yZ9FZayxdWxpqfRgC5CwVpBbVIUFrXriHrG+uZn8
         3qEC708IwsgIO9nIeeLevk8ZFG1ULxLW4gVMvCXXsJzXc3CklPdiT/GkXXIlwDvcUKYv
         Q8RNgpk16nqhkXVT8RA1MCS7YLEx5+/U0HM7kaRvYK92h/yDo8dlhygG/HpU+LYH75wd
         sE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701064763; x=1701669563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+lkPxpcGV4ulENWtL8UIKN/+j2CNZhdMfJlWPRbNbU=;
        b=eAJzoxJdpS+H588CWwxWjU2bs9f3vCSvVEF5E7IfFBRM5S3t60npYAKubS2YpWarG8
         agwGiL94sbM/0ppuZGu1jav2T3R/tR2/5sbrwGWHCAqJSlF78V/LLqty5GzzREZR6hG+
         WuiamNyhbXEOEnFf4zEsUzLa1Z1UtBfrmFhualLqitiWwRsQGp4JNB7ByBeQPScKE/hu
         Y5nc76qdOyR8rehZdfo5Q3DS8KA+iOMhl5yfYfUMOxlQlSmK28ZhV8jplBrYdQJqazte
         9Ffl8gt3MWTb1b4Tpkd5kcrRE5r+cGhcVZSoMdzPXsCCcQZGdV1Xfsf0RdJ1NE/JrtYX
         LdOw==
X-Gm-Message-State: AOJu0YwgZuH0BbUuEiypn+bHtO2iP2DDcaynlduuC1IUo+Q5KXgmIevX
	6h5vksW0zqTqBBmO32NEg/M=
X-Google-Smtp-Source: AGHT+IGHtZK0Vns6BWzZHgVZD1B5+jmOlfvtT8e9meE4tDaoDr2RuIg/boyy2Iqn/QGqgmbdATfAiA==
X-Received: by 2002:a17:90a:1904:b0:27d:1f9f:a57f with SMTP id 4-20020a17090a190400b0027d1f9fa57fmr13232816pjg.32.1701064763065;
        Sun, 26 Nov 2023 21:59:23 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id gm3-20020a17090b100300b0026f39c90111sm6599692pjb.20.2023.11.26.21.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:59:22 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] ACPICA: Remove unused struct field and incorrect comments
Date: Mon, 27 Nov 2023 13:58:58 +0800
Message-ID: <20231127055858.41004-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return_object_type field in `struct acpi_evaluate_info` is unused,
so remove it.

There are also some issues in the comments of acpi_ps_execute_method().
First, the parameter_type field has already been removed from
`struct acpi_evaluate_info`, so the corresponding field description in
the comments should also be removed. Second, the return_object field
description in the comments is duplicated. Remove these incorrect comments.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 drivers/acpi/acpica/acstruct.h | 1 -
 drivers/acpi/acpica/psxface.c  | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index f8fee94ba708..fe57c3a16e59 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -169,7 +169,6 @@ struct acpi_evaluate_info {
 	u16 param_count;	/* Count of the input argument list */
 	u16 node_flags;		/* Same as Node->Flags */
 	u8 pass_number;		/* Parser pass number */
-	u8 return_object_type;	/* Object type of the returned object */
 	u8 flags;		/* General flags */
 };
 
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index 6f4eace0ba69..df5679bbc510 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -70,9 +70,6 @@ acpi_debug_trace(const char *name, u32 debug_level, u32 debug_layer, u32 flags)
  *                                    NULL if no parameters are being passed.
  *                  return_object   - Where to put method's return value (if
  *                                    any). If NULL, no value is returned.
- *                  parameter_type  - Type of Parameter list
- *                  return_object   - Where to put method's return value (if
- *                                    any). If NULL, no value is returned.
  *                  pass_number     - Parse or execute pass
  *
  * RETURN:      Status
-- 
2.43.0

