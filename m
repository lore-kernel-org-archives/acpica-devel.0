Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95401C6A6
	for <acpica-devel@lists.linux.dev>; Wed,  3 Apr 2024 01:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108617; cv=none; b=LyGW1PDz8fb5T9XUrJFGL/gjjPCJhjPHGKvVPRDCkHMd42M2xlp9LzUs4YE/rJrgL+KPcmFEwZSiClCxD/QLdiPt1phCW0oLQhkF2JyoBy2XZIoq9Sv+JFUEmi967vyE3kFjBXCglNXDs2aNU+2RLOTtb0a2l5AQTRbmdkAhwyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108617; c=relaxed/simple;
	bh=GmjAj532GROcGfekdwYtm9RSioEjiUXNOBiz7tB0ing=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mYliCyAOiU9rmLJsUoJXCIF79QfpuJDPXuhqbN8Il0tK/itLymBma2HzAYiGOpRZBZctyxXNtCUPsESYz9qUcmCDSTwpmuRphGFni6PzUvrpuUWpxARsJAOJKJfX42+8cvtnOqAveO9MFw+M9KWso3e09PFU9lu9s4qHBJV9a/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxjWCmny; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxjWCmny"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-6e6d089f603so4051974a34.1
        for <acpica-devel@lists.linux.dev>; Tue, 02 Apr 2024 18:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712108615; x=1712713415; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fsJ4FQL0ZHmTisEqkBaubldM19KDKDegM1Fl5PQoDrw=;
        b=CxjWCmnylthg55mGRrCrU9q63UowFGx+MTlTFAPOns1ZwTSQb8VAWSL0qHdR4lWzdi
         cG6Fu8GLcenCZS9VTevamFTm2xYJG8D9QuLwZ/mJmg/aOyeKWYmFY0k4te5nsovuzXtp
         ply2gf0sdizZ2TYkpVrPKgVkjUdskZm4jnIcj9ae5p01cJfrxp9QX5zWY9+VspHQIus0
         Eu8l34bqNORGW3yX86r9gNuLJ5QBn6+ZN/e3xhaSAU/YOd3wREiaZ9X2iOz/fCBZpkoy
         q3E/pUDygzJDtrhQG5lXGNeq/6iWRg78YrNR3fIYpehTWPFOA+qfsRIjURxlG/bnl6+Z
         5ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712108615; x=1712713415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsJ4FQL0ZHmTisEqkBaubldM19KDKDegM1Fl5PQoDrw=;
        b=X3ZUB/SOc/lcFbUaiS4nbYx4tEC0V/DgAaMmSxVpQEXl9jL9POILnIDRR/O+1BnNLU
         IGu00kp2R7Ef6xsYI/LAgHJeqkLcs52XCTcq04UArQmBESPV6nmR/LeS6C5ON3ucWwk+
         YAhwVVqwo/lIeFOaOgRv5hmm7R9ZJPttN2m7Yd8pI2t+tIBmVNGOMMAbMbBxyjUUZhE3
         8HjJLa5AXNuvOJaSJ/Tykkhx7vD1DgRPJ+AuqZ99MJxo85uSyMEEeYwWG9K1iKSP5nbu
         u11+AkGzXekkPsOnAZ2KkX0R8HxDS/h+Uc5Uqv8lpjwZu7n4lkKGtQSq6QvN5FmJ7mHl
         Eqbw==
X-Forwarded-Encrypted: i=1; AJvYcCXwhUSkP3e00Fjo5IeKsojEx/URcU4h01SuRmv6kNyUxwKHLraH2n6RwoAk4hP/91XluahBCG3vntoZaWdaVOCvnQyqB2GvfQjAv4Sr
X-Gm-Message-State: AOJu0YyMQwNxvvdtHzt6dUOpTc9TirFIWWbhocoRhNn85OeTp4QTXngI
	3pRW/PzoQ8TQv8hwTSEuNE0x/Jo/qtuBkWlDbswRJX2Jh8NnDNta
X-Google-Smtp-Source: AGHT+IFWdg4Jft0MJsEyLjf4TOUUiI1Wxoc2/tcBKNMSE+rgJhzeGdOLrEF3UdhUe1Jq5sMqFuCbww==
X-Received: by 2002:a9d:6f13:0:b0:6e6:8516:4866 with SMTP id n19-20020a9d6f13000000b006e685164866mr16951430otq.16.1712108614783;
        Tue, 02 Apr 2024 18:43:34 -0700 (PDT)
Received: from lhy-a01-ubuntu22.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id u4-20020a632344000000b005dc3fc53f19sm10403737pgm.7.2024.04.02.18.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 18:43:34 -0700 (PDT)
From: Huai-Yuan Liu <qq810974084@gmail.com>
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Huai-Yuan Liu <qq810974084@gmail.com>
Subject: [PATCH] ACPICA: debugger: dbconvert: add a null pointer check
Date: Wed,  3 Apr 2024 09:43:26 +0800
Message-Id: <20240403014326.970237-1-qq810974084@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocation function ACPI_ALLOCATE_ZEROED does not guarantee a
successful allocation, but the subsequent code directly dereferences the
pointer that receives it, which may lead to null pointer dereference.

To fix this issue, a null pointer check should be added. If it is null, 
return exception code AE_NO_MEMORY.

Fixes: 995751025572 ("ACPICA: Linuxize: Export debugger files to Linux")
Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
---
 drivers/acpi/acpica/dbconvert.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 2b84ac093698..8dbab6932049 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -174,6 +174,8 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	elements =
 	    ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
 				 sizeof(union acpi_object));
+	if (!elements)
+		return (AE_NO_MEMORY);
 
 	this = string;
 	for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
-- 
2.34.1

