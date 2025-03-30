Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A972182D2
	for <acpica-devel@lists.linux.dev>; Sun, 30 Mar 2025 05:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743314098; cv=none; b=Bf2DY0Ao4FIVsU9B89NtRPxHC0OAPT8PnHTwfuhx7RyE5mDdnaLapez46XW4TpWf0a/s0mmGRYrkZnp4psRLs+4unLGldh6jBtzYkzCT5iA5qxSVWCwzbh+IDQw7yYjuNUc7fxKe7HQUjZ+RnWVyn36AMeRiTIW1Ydix8mZ75WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743314098; c=relaxed/simple;
	bh=6p8gncaaZsHPc5k3Qs2ZLsncfJuQGvSixclKj5eyQLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enyuzigo5nRhvlnhsjdvs91SnZ8QMs4ZoOTzkm4waBrrtkCVQhF4Dp86GCdcWwqaK+f+zIIk9KHzaM8uV1qtpdT4TKMkczPgT1My3tMp/a1WDnGYv3N8WieGlHLwe4jPzJc0hhu90xuD0dofUpMMgiCCV8ZQOWF9hBXq+4zd4ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0xoYkvu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0xoYkvu"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso548257666b.3
        for <acpica-devel@lists.linux.dev>; Sat, 29 Mar 2025 22:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743314094; x=1743918894; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LZS5hChiziL0zECiXtf+2ICQEzuKraJOFVrf1WXGBpo=;
        b=b0xoYkvuZDRYPd7OosdJzLc1Q/R0BekJU7khy5FN904VyNLKWbLRmLdaTAVtYPVl4I
         7BpBtqqWjmA3yOHyLVPTUfFNcSJoryy5gtoUdGGhFcKfbLXkgw3pgb+976nwKjFvejQ3
         uIGUvF7DnaFMVCz5iJ/d7ir1z9nAatbL7oTXw3CXnFq8vZFZrSmPELC25GvkQImkhW7k
         qn79wXJl7bgT1m5m06lAvTztjQBc76LyRy8vc4NftIdgMOgWZB0Zra6Hzc7WP1WV2qSA
         YETG/TK8IBJTtyBXQnYYEyrSUNO5BMDCJsXdqTrwype4Dtidb75HZ50Uu7YcTtWsleRT
         e/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743314094; x=1743918894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZS5hChiziL0zECiXtf+2ICQEzuKraJOFVrf1WXGBpo=;
        b=IO+RiHXIv91HmmFp26oXnBJGU7EVulHFltgJRorD28hiEQJAisoEmYilVZTIStEx3a
         hc4nIIyg0ieeHGzk81mXcRkbdzQmb7N6tDqCeGr7zSEt8937dcN9QhfAWmCSLRUIUu7N
         J70HGwlclCjK9y8Gjp3vxE9KJIh7zRiHOEX5mdipZSJpAKT6csGoUjDTVEkJ5ovrgmuo
         sUMjTfOh+uzuJ0InWKgaW0J8JrDcoQe2sY7/TRrT0zS4KSyH/379mxCfccvTMOAXyOAd
         kC3enR/R9ed10cOltczPCEm6nDwR8g9oRlQtrmkQ7fmVQxFiOejHulMcDBjCpXULA7jf
         K50w==
X-Forwarded-Encrypted: i=1; AJvYcCX6rr+MR3Mu+/fSE9O8zm+xkczIEopU7gKh4IYmCA6KS1YDY0iEUwi+OINMkGTDdnmWnSOFdQ3BFdFKeZw=@lists.linux.dev
X-Gm-Message-State: AOJu0YzU+7bX6CgAgk4BJnoSB4jYCZQQZboQap2hk4ELm3MG9otNad3+
	nVn2KBMXdFqxCCTzP3lydNZfuGf6s7bsES2kSKStvUVYnYvVxsWW
X-Gm-Gg: ASbGncs9SI2WOS7QHueWvpFlqqVbQ+hPpMNG65+t7tyVoD4+U9GnFKyEpz/Nm9uijB2
	95nj1qe+zOO0BcnmmwmMu1caedboEr5qROSCMCV3C9hUWTDhxvVP7I5vt8QHv+uDOBDFHrt11Hq
	MFPjW1MV0Oo2hq2WmGxFROIEP7tBSmctfxKEf2X4b0N/3q4Utab0NJCPtxtKawuOvhGb7ofyfue
	ieq5r5TftBTQTYT6oaej6/6+RbiUeTbWZKb5Jii1HL9YpjVL9uQRv38jTshuFnqW+wYQh/5KqsM
	CYe61g8qYvW23KJS20YI6ESTSf/t+CUHOA6bsef3ODf5RjIbh8ofJXhdDb5uRe/9FWI=
X-Google-Smtp-Source: AGHT+IE87WJv0/ZzDl3FXShm+jTRY2Te+7Zv9PYAX8DvccPdhOEnetOp/txCzMreLmUt78hsaQBNgA==
X-Received: by 2002:a17:907:7f07:b0:ac2:55f2:f939 with SMTP id a640c23a62f3a-ac738975e33mr385096066b.6.1743314093493;
        Sat, 29 Mar 2025 22:54:53 -0700 (PDT)
Received: from localhost (44.tor-exit.nothingtohide.nl. [192.42.116.218])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac71922ba63sm433884266b.2.2025.03.29.22.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 22:54:53 -0700 (PDT)
Date: Sun, 30 Mar 2025 07:54:50 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] ACPI: mark ACPI_COPY_NAMESEG destinations with
 __nonstring attribute
Message-ID: <a9bd2a1b490b4305c18f8473aab21c97e8902fb8.1743313252.git.x0rw3ll@gmail.com>
References: <cover.1743313252.git.x0rw3ll@gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1743313252.git.x0rw3ll@gmail.com>

strncpy(), which ACPI_COPY_NAMESEG currently uses, is deprecated[1].

This patch is the first of two, ultimately replacing strncpy() with
strtomem(), avoiding future compiler warnings about truncation.

[1] https://github.com/KSPP/linux/issues/90

Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
---
 drivers/acpi/acpica/acdebug.h                            | 2 +-
 drivers/acpi/prmt.c                                      | 2 +-
 drivers/acpi/sysfs.c                                     | 4 ++--
 include/acpi/actbl.h                                     | 6 +++---
 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c | 2 +-
 tools/power/acpi/tools/acpidump/apfiles.c                | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 911875c5a5f1..2b56a8178f43 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -37,7 +37,7 @@ struct acpi_db_argument_info {
 struct acpi_db_execute_walk {
 	u32 count;
 	u32 max_count;
-	char name_seg[ACPI_NAMESEG_SIZE + 1];
+	char name_seg[ACPI_NAMESEG_SIZE + 1] __nonstring;
 };
 
 #define PARAM_LIST(pl)                  pl
diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index e549914a636c..ca70f01c940c 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -40,7 +40,7 @@ struct prm_buffer {
 };
 
 struct prm_context_buffer {
-	char signature[ACPI_NAMESEG_SIZE];
+	char signature[ACPI_NAMESEG_SIZE] __nonstring;
 	u16 revision;
 	u16 reserved;
 	guid_t identifier;
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index a48ebbf768f9..a05d4032d4f1 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -307,9 +307,9 @@ static struct kobject *hotplug_kobj;
 
 struct acpi_table_attr {
 	struct bin_attribute attr;
-	char name[ACPI_NAMESEG_SIZE];
+	char name[ACPI_NAMESEG_SIZE] __nonstring;
 	int instance;
-	char filename[ACPI_NAMESEG_SIZE+ACPI_INST_SIZE];
+	char filename[ACPI_NAMESEG_SIZE+ACPI_INST_SIZE] __nonstring;
 	struct list_head node;
 };
 
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 451f6276da49..8aa60281e7db 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -66,12 +66,12 @@
  ******************************************************************************/
 
 struct acpi_table_header {
-	char signature[ACPI_NAMESEG_SIZE];	/* ASCII table signature */
+	char signature[ACPI_NAMESEG_SIZE] __nonstring;	/* ASCII table signature */
 	u32 length;		/* Length of table in bytes, including this header */
 	u8 revision;		/* ACPI Specification minor version number */
 	u8 checksum;		/* To make sum of entire table == 0 */
-	char oem_id[ACPI_OEM_ID_SIZE];	/* ASCII OEM identification */
-	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];	/* ASCII OEM table identification */
+	char oem_id[ACPI_OEM_ID_SIZE] __nonstring;	/* ASCII OEM identification */
+	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE] __nonstring;	/* ASCII OEM table identification */
 	u32 oem_revision;	/* OEM revision number */
 	char asl_compiler_id[ACPI_NAMESEG_SIZE];	/* ASCII ASL compiler vendor ID */
 	u32 asl_compiler_revision;	/* ASL compiler version */
diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index 9d70d8c945af..52026b9e389e 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -19,7 +19,7 @@ ACPI_MODULE_NAME("oslinuxtbl")
 typedef struct osl_table_info {
 	struct osl_table_info *next;
 	u32 instance;
-	char signature[ACPI_NAMESEG_SIZE];
+	char signature[ACPI_NAMESEG_SIZE] __nonstring;
 
 } osl_table_info;
 
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index 13817f9112c0..5a39b7d9351d 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -103,7 +103,7 @@ int ap_open_output_file(char *pathname)
 
 int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
 {
-	char filename[ACPI_NAMESEG_SIZE + 16];
+	char filename[ACPI_NAMESEG_SIZE + 16] __nonstring;
 	char instance_str[16];
 	ACPI_FILE file;
 	acpi_size actual;
-- 
2.47.2

