Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FD634CDD
	for <acpica-devel@lists.linux.dev>; Sun,  1 Feb 2026 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769969829; cv=none; b=OsI4ytczvj67KRVLaJFK7hLYT6SShLjP+8V6goE2MKgOOyFvNCMW9gBrvWqX8uBzC8HFkrOc/UbUI/T1nYrQGYrQLcwaKwg2+61LPbZH6FRFBrjU8yd67DCt2jMSnedsB95t9q4fEY0Ejw7Ma4o7sE6fW9vFZ2OK8e5utjlLLHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769969829; c=relaxed/simple;
	bh=GUrSB2n7oRGHcPWkgJseQFjjXQatFD2FzE1j1iw6aYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWqZPDkxeHvF2RQh4NKZUBkUrdizc2TtFoPwW5QyhYG0/TjAAjo1zfhTeT/22v8v1Sx2zSTndmcBsoHEC1esc1jfGNW55JQgo9g6Ap995w/QGzor7xAS+zyJOUpiApi44jWvDtmPIIXC+JWrtkHnaYuMgpxhOU6lsxyN+2NiPhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+o6lylU; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+o6lylU"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34f2a0c4574so3728744a91.1
        for <acpica-devel@lists.linux.dev>; Sun, 01 Feb 2026 10:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769969827; x=1770574627; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ujk5k65rRpax7qPZizdIUInwgoyZVajK00HSdGaFW4A=;
        b=X+o6lylUJt978KufIfND9fhDXD8IxG+grLwxH3UMhlqbvgLSOBZQ0UufipNW1iIw/o
         /VnPDoSLA+LZvKU0nuBXC3w2S9PlZgd8RsPl1hFK587sQgDD0YtdFNfQXVGTmIaGXsmR
         haBwHsbkokMzS6ale99E6+cC6nWzK7zfoBpoT8vwkg7v7eBMVZW1s6pch2PXD/uALRQZ
         WXvoEjGtyS700SyKI1sQKk1bQP64N/+kBwGja8uayyxrSqUDGIpJPu1GysYzQRDyjZ46
         /jMi38xaA7hv7e+q/rv3zT/Ce7AEB1kTBjipuWv2+stSH35Mv/OzI9wwWve1amLDhENq
         so3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769969827; x=1770574627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujk5k65rRpax7qPZizdIUInwgoyZVajK00HSdGaFW4A=;
        b=AmCNoNjDUSKB/+D4Ih5NIB+bfwLRRQKZ1ngqgXJ6waefp7FnlZVNCQ1QOQ1GC6KYUM
         DFIXfYiKGjcJIqujt1dM8c17JvsU//99tCL2b95S86E9j1MFCR97SNO+c6PXNs8u2Ooy
         C8QeNF8pklTe6MyeXCMc8X25yXE0SoVEpfeOVg0bxNxIaPvUfSi/NrIJVQ5AknV2lqn0
         MHm77HycOAM5vk+UAnT6cEVWkkFmVSeQJWqsaqGaX7/gE416VOvK71l76dqiP600Fsm6
         WoqqjZj6jKtzX9SGYbUZVWc959ALlzhV+5BXY5pgxDXXP/FPseRfsPE8biYhjQsgDtyi
         LEDw==
X-Forwarded-Encrypted: i=1; AJvYcCV4tUjtITvC6h9QZmfn7kCRIXSjDkTO8+kZcsJ1rsz0Cfpuypwe8NytaJ9HLlAvb1GmMOgUdtm4LMm8hj8=@lists.linux.dev
X-Gm-Message-State: AOJu0YwVZIydR7i2u0Nn6ikVAPoboR3uLv3GhH+JhN/DYHy4N33GQffi
	FHrTuv4uwAZDN7+VhBFx5FbARefpPXpKCHgmTSpnyTFHodr/kKBFywXe
X-Gm-Gg: AZuq6aKmF2vlN1iSh5IeddzNRvlwF6EIcT/xU+grluR1ZeO/+1mKcqhFe9vo+s4xUDF
	fkzLyZk5hQxko2hi86vhDfHba+g8aTW9ccE4Y+1uMKXP+KaxSsgjqqIO5bRWf/llLoUuOzegrN9
	ZJ8kk6VwV5FQTNXd+aiKFaPE12vVgG7v5qW+ZV3/Eqv+IbiI6h7vy42Sq2ad46gDgsQXM+PiZxL
	5nBceBoGzQEfEoP2mDHD3Jurp9l+WwMkVjmPaychmMAxLMKQWR8QwzktI1GEPr/FrIyiwn1CEzN
	xvHB3lvT3HcvNkbOq8xZ6tF2qYSUJrbsMShvkk/Di2qacPuyRQKXE/6wZS4ywEWLQRZdnsTrfwF
	Asfa0cGXzy8kAWhLjO41XxGZu+s4SF6VY7wGSGIQ+sNzlOFF/S9Ik2Lbifod3QuvqlY9WNvTEkM
	q12XYQGUGUQ7Jv1JE+
X-Received: by 2002:a17:90b:3ccd:b0:352:bd7c:ddbd with SMTP id 98e67ed59e1d1-3543b38af32mr9508501a91.23.1769969826957;
        Sun, 01 Feb 2026 10:17:06 -0800 (PST)
Received: from gmail.com ([2409:4081:2d1d:b4be:89d5:e086:c91c:ec66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3543bab8025sm3192608a91.0.2026.02.01.10.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 10:17:06 -0800 (PST)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	robert.moore@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] tools/power/acpi: Replace strcpy/strcat with snprintf in osunixdir.c
Date: Sun,  1 Feb 2026 23:46:20 +0530
Message-ID: <20260201181620.4964-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace unsafe strcpy() and strcat() calls with snprintf() in
osunixdir.c to prevent potential buffer overflow vulnerabilities
when constructing file paths.

The snprintf() function performs automatic bounds checking to ensure
the destination buffer is not overflowed.

No functional change.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 .../power/acpi/os_specific/service_layers/osunixdir.c  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/power/acpi/os_specific/service_layers/osunixdir.c b/tools/power/acpi/os_specific/service_layers/osunixdir.c
index b9bb83116549..5dc960c6b376 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixdir.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixdir.c
@@ -113,9 +113,8 @@ char *acpi_os_get_next_filename(void *dir_handle)
 				return (NULL);
 			}
 
-			strcpy(temp_str, external_info->dir_pathname);
-			strcat(temp_str, "/");
-			strcat(temp_str, dir_entry->d_name);
+			snprintf(temp_str, str_len, "%s/%s",
+				 external_info->dir_pathname, dir_entry->d_name);
 
 			err = stat(temp_str, &temp_stat);
 			if (err == -1) {
@@ -137,8 +136,9 @@ char *acpi_os_get_next_filename(void *dir_handle)
 
 				/* copy to a temp buffer because dir_entry struct is on the stack */
 
-				strcpy(external_info->temp_buffer,
-				       dir_entry->d_name);
+				snprintf(external_info->temp_buffer,
+					 sizeof(external_info->temp_buffer),
+					 "%s", dir_entry->d_name);
 				return (external_info->temp_buffer);
 			}
 		}
-- 
2.43.0

