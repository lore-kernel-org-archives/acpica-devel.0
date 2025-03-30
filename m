Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6E2182D2
	for <acpica-devel@lists.linux.dev>; Sun, 30 Mar 2025 05:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743314125; cv=none; b=L8HyTBgX1CK40KMvQhvNPzTpR7goF6MHFg+P+YmjeYSFWEdFrHjjNYACwCZ2wU0vDjDsqdWiuhxfIMWU8XRIRDXLSSs85Nia3WzCOMPjUr713b+qSozXX4RMFzZbMMGGmbZzJjDi37yb3n+ZzuE5uwSr/fyJbUdl6/dRnSANJko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743314125; c=relaxed/simple;
	bh=jq+T0KY3Uy+rx4nE/vr2dkayKbNzmAXvHQY/LI1TJw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqFIN7rtLx/O3SIVpGbA1htSgi8sbg0CIP8PF8dx7tDKi61Z0dI4q1QU793WawQCEe91qX9KA7366iGEMr9dQ/rsPgaan6sb6IkZKwDmlvueyevkc8muOmXyx329EHmOIb5tYw3gU1MU022RwIJtyf5V6iqH9mg5emewN4p7pJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzc2kjcG; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzc2kjcG"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so5612449a12.0
        for <acpica-devel@lists.linux.dev>; Sat, 29 Mar 2025 22:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743314122; x=1743918922; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6PpTlh5KVVgsGhCGF4y/CrrtuRXsy3r6ZCRQJL7GKJ8=;
        b=bzc2kjcGlshr4/X0FJd6dVCISxQeYTyB5aJhMcAkiXRqVgyks3Zdv1A67Fzz7FADYi
         PTDtP1b3tSGvTO1yyBnrvaMy4r31ihBQmtGcUhMnKxNgXFcao2GCz+Ijm0ii4q2svtWC
         KcEpnEpfSxhUfXALsQnbKaqWlwmQQVrnE4SK3U5TxpxaCrGm/y5jFfEanOT0aTWfwcAd
         eoygkn0yFMqp9lJRvhhax01ig9Ew9lyL8iF8K8VvhGjtMg+r1MH4xcENNEtNxBDvJXhr
         GKxei5JTjYRqM8vSZS5XR5PHDTxWhxYIJziSDdJ5dpXPc522bZeYcX7/zUYZPkZV2YOv
         T1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743314122; x=1743918922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PpTlh5KVVgsGhCGF4y/CrrtuRXsy3r6ZCRQJL7GKJ8=;
        b=SFT6ke5YKt/LvDHsWYsz9PjjOErjWRjmySp2jdyzWyrx4hf3pWBqTWdMM6FuP3geED
         h7588Nn2Bv6Rgc322KvAgBG4rvtm988mQvoBGUcm+9TOzLlkDm4TNUZVN6wLF1yQuG9s
         hPD0yThFNkjaQkOSaubbckAFbwWdKr3AIFxYUnMGskJHCUVo7BQ9G11xJYF6QeqRqeTy
         YLa3CORcmxRVMxzL9KGZR/sECm655K9Chry36m04wVJGgk1FE4gUBHiIupUkvBE551US
         1ECM3TxXrdS9QpNGzGvTSxUSNLCJc3N/OGMhNVDkSpABHLyhREyPr8c9sn3AsBV/qtef
         DS7A==
X-Forwarded-Encrypted: i=1; AJvYcCW+jU2OCEpV0yVHhlt8uY04jMYJ64J6lvpnH/BpWP1a4CTwoHa9IFa5wCi0zA7S9vvCF/+Zsfz70Wjy9LQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzrv/gGX7k351jSApNGKQ3yBko/n5PqG4RP5VpCimXW6EV0HHKE
	6BsZaOvSZT1HCBjzYRf17RMLJyTCiq3+azN6QG4qFcqDSC6q4BQU
X-Gm-Gg: ASbGncsNX67W18QLfcaaz9qGuAhZWKZYB4Hv7al6RFopw0AoVPhpqjs+U4hL58DWhmN
	AbGcmnFndNtLd5OLgWUA1MAn2plUYERd+kg4jzByoGvCX67GlRDdlHhpdQ+L3TQZ7dDlTd4+V7Y
	GhlWy04KrRKSQ7rmdO1w02yRXCSR19b8b384ovhWGQR37U57fXq8QciQU/OdfbMjpihluBkiNtw
	CJIFq3PdeZ5eHR/CcsqG1DOp2yM8zdUBIcT4izx9v8bReYJeTuQoPcGDPLP22fESldH3NIH+R3v
	ghGMRKHGCc2U6/2Uj5tEE2eVLqPBpHgvAHueB38vYomyUmpdbJJdGxQa
X-Google-Smtp-Source: AGHT+IGos8Q7srbIrNbIAkO4sMWeffy1fVcgAryd53kfETkDp506bEMrCTcyjRgqYm0R6nLDH4kAow==
X-Received: by 2002:a17:907:6092:b0:ac3:8aa5:53f6 with SMTP id a640c23a62f3a-ac738a0c683mr434267666b.24.1743314121909;
        Sat, 29 Mar 2025 22:55:21 -0700 (PDT)
Received: from localhost (44.tor-exit.nothingtohide.nl. [192.42.116.218])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5edc16aae7asm3872618a12.2.2025.03.29.22.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 22:55:21 -0700 (PDT)
Date: Sun, 30 Mar 2025 07:55:18 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] ACPI: replace deprecated strncpy() with strtomem()
Message-ID: <6c1a263a89712b5cdc2a6752a91bb9f71f379a2a.1743313252.git.x0rw3ll@gmail.com>
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

strncpy() is deprecated for NUL-terminated destination buffers[1].

Use strtomem() for ACPI_COPY_NAMESEG() as destinations are length-bounded,
and not all of them require NUL termination.

Also replace strncpy() with memcpy() for copying header.oem_id
and header.oem_table_id

[1] https://github.com/KSPP/linux/issues/90

Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
---
 drivers/acpi/acpica/tbfind.c | 4 ++--
 include/acpi/actypes.h       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 1c1b2e284bd9..35f72dffc250 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -57,8 +57,8 @@ acpi_tb_find_table(char *signature,
 
 	memset(&header, 0, sizeof(struct acpi_table_header));
 	ACPI_COPY_NAMESEG(header.signature, signature);
-	strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
-	strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
+	memcpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
+	memcpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
 
 	/* Search for the table */
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 80767e8bf3ad..b85dec57f00d 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -522,7 +522,7 @@ typedef u64 acpi_integer;
 #define ACPI_COPY_NAMESEG(dest,src)     (*ACPI_CAST_PTR (u32, (dest)) = *ACPI_CAST_PTR (u32, (src)))
 #else
 #define ACPI_COMPARE_NAMESEG(a,b)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_CAST_PTR (char, (b)), ACPI_NAMESEG_SIZE))
-#define ACPI_COPY_NAMESEG(dest,src)     (strncpy (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)), ACPI_NAMESEG_SIZE))
+#define ACPI_COPY_NAMESEG(dest, src)     (strtomem (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src))))
 #endif
 
 /* Support for the special RSDP signature (8 characters) */
-- 
2.47.2

