Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971A0225415
	for <acpica-devel@lists.linux.dev>; Sun,  1 Feb 2026 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769969971; cv=none; b=iNZUUywGZOxPXYolGSdHmhMCJmDKecPSEPJfuVA5J1Z1wcqHiEa4V16wbmKmdmg4Ncy7hcNtl3ylZHgnEEBCUtDEnKwfaenDCEXQYKdgikYS3ijDmmEBGZZr8N2/jldMGnqzRYqoiRaf+bk0eNLt94mlFOkFCvo0Ad/lzuEjGWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769969971; c=relaxed/simple;
	bh=9UEAYs8BOtkPMSZ+aZJXJjA/lA1oMnfd0ad1J+W/DCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QLC+E21nlkWbfkYfiimHQeRd6SSJzfoVcaE7f8Hv093aH9XiLtklp/50FRHy3jnq2UGADT9cXjE9y9gGhU0mWQ8PmDbEPRdcqvyrS43trL+NDVJzkzDnkZbwLIRs0i5+DItY9YpuexIPjfoww8fMTQic5Fd4r6Z1n9swwCnOttQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSSuCk3w; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSSuCk3w"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a7b47a5460so20963355ad.1
        for <acpica-devel@lists.linux.dev>; Sun, 01 Feb 2026 10:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769969970; x=1770574770; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w0qHBL38GMK6RiP1vSDBko5Oah8ksm+tgX8bU2a4jHo=;
        b=jSSuCk3wrH/vyXadqMsCkE3CJNWszxHAG13nMz7VLomw3t1Ul0PwWnDXBTzWfdjJvr
         wjYZcdgbndlHkAyCmFf/LVB491IPo64SwXfia3eHDTbMAqWbor2TTLm/mXacgt7w3jbO
         EUnZ/DGQOOVWqFcEwRmQ9W+91xECF0HNubFH5LTvkKOPiEX0XAzc6mtbpM/Gl6QctRl6
         F79jLKY929CEIGiJ3wHIpX67DzmmGrNj6yfVzwxY8yN8l50oZNDZQu7Blyf1X7t5Wp9h
         tfS0LEaj1I3q/5mUo3Hb7xQRmVENcqjfQ5hbHcZOeQ7pXX0kdgfttGMMw/JlLfLimxsZ
         n3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769969970; x=1770574770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0qHBL38GMK6RiP1vSDBko5Oah8ksm+tgX8bU2a4jHo=;
        b=IgzCQbiGd0goFhYpnhU1nhrJWHRkOYsDQO0W0jufRs/ZajcIYaRI2L9rJ8kWL9P92R
         0JoUAExzt4GAYvLSDGqlR6G0fMw0bNIaU6miCxXZAPkAyf/DrHSFYWzWYy55WPU6ftsT
         G9MQWhizKH/J6eOCfOu+f57Wcf36rObbBSy2CzZr+LMKQ5khvFwKOfaDGbZVHUUFg2zn
         XyHzFvi7Lvq/bW/vO7XgIcZrUrQ/RaDc9HSP48+iq/UGWGWHbdyJpYawMQTUurZfoDxB
         /h9ReTyc7YVNpk833ut64NGMOOcwcuL3r0rb4zZ67e7jkKLn7CYCZkySRGlTbwVoaC36
         crIA==
X-Forwarded-Encrypted: i=1; AJvYcCWkKxQikpkafCsWXwu861Fkat/YdHFLZHQlmbe4PeaJOC4Tv+G6HvRTtnI0GpwsoM2paSQJynNPfUAmbak=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzyp7/SIQ1rl/S6iyHjsxXW1pHnHWchq/Ip28Bhl3ib13LG0p+X
	BJn6qHyRJ77zDVVtwmjw/bd5TtjJUKj9o/qDGPdLsFi2th4bkv4bPmIr
X-Gm-Gg: AZuq6aJ1zI8t4oobDDhif/Lrl0C3/BONE142YZIwzBFrxOztCEba/G6Fl15KHD+AJD+
	NalAVaguJkGPWToH8QJBZ5dkTGoyUsmge77rgLCDkVqfqJ/p03cU6KUstl/Ty8R1pPF9uqLMLf9
	Gb6hZmn2RbBjgwOuOjd6D5fJn/MHrmnDWzwlff1nmYIcvOB+CAm07E5cJCl87E55Y3l5MjkEbFO
	tEMZC4NlIDVTmcALbKUYNedmB5IjsQmRMeOS/Gv+ZiLxAhVeTJIAnlxn8K/cWa+4zFar3iYk74E
	Fo5iK+7ERLA6giJNM9tzT2adK9Ua63kzIRj8Sxpe0kEhUBj0rinvhkyQmLY1TFNoHfEG0CApCa7
	fgT31WPz+NSAvkcUnLWBc1D2FfdV4OnqCvwtWWhHd8kshBqwLij2x4w5KrGdhU8nx1MFjSrc9AP
	Ko4QJdkoOFCcDi9oWi+LnP8rnHM+s=
X-Received: by 2002:a17:903:2f86:b0:2a7:a6fa:eddf with SMTP id d9443c01a7336-2a8d99514femr91910555ad.17.1769969969660;
        Sun, 01 Feb 2026 10:19:29 -0800 (PST)
Received: from gmail.com ([2409:4081:2d1d:b4be:89d5:e086:c91c:ec66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b7f9a9esm125644925ad.102.2026.02.01.10.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 10:19:29 -0800 (PST)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	robert.moore@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] tools/power/acpi: Replace unsafe strcat with strncat in apfiles.c
Date: Sun,  1 Feb 2026 23:48:24 +0530
Message-ID: <20260201181824.4999-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace unsafe strcat() calls with strncat() in apfiles.c to prevent
potential buffer overflow vulnerabilities when constructing filenames.
The strncat() function performs bounds checking to ensure the
destination buffer is not overflowed.

No functional change.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 tools/power/acpi/tools/acpidump/apfiles.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index d6b8a201480b..c7b71579aae6 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -131,10 +131,12 @@ int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
 
 	if (instance > 0) {
 		snprintf(instance_str, sizeof(instance_str), "%u", instance);
-		strcat(filename, instance_str);
+		strncat(filename, instance_str,
+			sizeof(filename) - strlen(filename) - 1);
 	}
 
-	strcat(filename, FILE_SUFFIX_BINARY_TABLE);
+	strncat(filename, FILE_SUFFIX_BINARY_TABLE,
+		sizeof(filename) - strlen(filename) - 1);
 
 	if (gbl_verbose_mode) {
 		fprintf(stderr,
-- 
2.43.0

