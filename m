Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8619539F
	for <acpica-devel@lists.linux.dev>; Fri,  4 Apr 2025 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755120; cv=none; b=g45n5u9u8ig0Nc8NbRmUuKgwp8N9zjtbVGoR/Mqtg1ND0AmPzioEqlmd8v5MTxZLpXVnkEk4ow8LoEpGLpCM9Wvv6XXZdqmE7LudIB4qgDiC82QFXwFfcPvv4XJp+Jdf9BdaiyTiDs7qjq3xjMkzlXfvRqeGihFD8SbgmpexekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755120; c=relaxed/simple;
	bh=ki2U4QAPiVrOPCNE0sc9O7MbbgjVfkGGaNGHNTMHOsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnW0JUhRYNLZ1E2qjINazM//Zj7YdoeZWZ8HwzbSRkzko5p/m4/X6C5TjemiXDJM7KOTzPPC3N1EfsHKl3Akm7c37KhaqX5FDwc02NMp5vWO3EbTSHXZokHo7HZvlG4kRdgNSL4rX5PkLCwhavaqBKCoeOsVlO0BZa+Y6syMj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2XD1v/M; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2XD1v/M"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac34257295dso342530866b.2
        for <acpica-devel@lists.linux.dev>; Fri, 04 Apr 2025 01:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743755117; x=1744359917; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zryx7ad32NdBny1P05+MPUD/OPYaqir+9vR64JjAn9M=;
        b=K2XD1v/MGxDf22iP25DyH1zbGLvKdyy83RhU6pxBkA38Q2G/O/OOvwOOZ3Htj2g/ak
         sxe+d+PPrX3OWsJj9Ixubt6csgvqwS2sJ/+cczFIyTuVMx83zuRNt+RayXVU4avARa2R
         T4MB5QH/eiaycnWjatEpDVLIg+ZOsmyNbREnlobJV0C7WTLFk9MbwD2L9NxXyJC/jPbL
         JgUSFy7h4/V5bHj5hoJtpNnVrbxUYY7LVmr006joUK3V4asmQrGFYXT1cyPrfnsmGZF2
         dfh7sUcxSM2+KHcZGTZPTP8N+opYG4I3fd3XuPgTHEAlEeROlvJuTp4DkZmfVIqsGxEK
         /yEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743755117; x=1744359917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zryx7ad32NdBny1P05+MPUD/OPYaqir+9vR64JjAn9M=;
        b=NB6pAD+wSx+wIRY/gGqp4tXZ4RSVBhU4Zq58bcNEgJwQsnU8GUBAeziT+pas+1WFV8
         jtxcS4zP0A95tynLatPkuonJm2/bRp0H81tyWuVEJeAyRTwvqq91/+yqQaC/uONS7qmg
         MdiMwn4GNAOpDbDgNlJ5cTd9zdgdohNDAFNKayXjMmEMLLlpW6aF8pHz0lZ7nYvKC19t
         OSDO9TPybmQlhbtf3XnQtGBfVsmFr9i15i15RqR6DesAUT56TO8uktpM+wMm7ZvjiDTf
         FjdHvVwMV1eTiK6FWk2CbSzdTj1YWyk75irTpxQqKjo106tSNrvtLpW7Wbhby3jhM3VS
         iOMw==
X-Forwarded-Encrypted: i=1; AJvYcCWGMRipdXxkN1wj7bd3mhLfGn17Jon5goeCHRk/k72c6lR8MDmn7gK1fymzX8Sx2E8q4dL/gkaLkWxu3zk=@lists.linux.dev
X-Gm-Message-State: AOJu0YwAvWdlOstMdVGJEdlBvk66L3KX9yT6oEc/nRx4FQP1oeQhO0lm
	b61HKmXveqOw+R/rnLiHPv+p+buVomO2JBBypUNKrMZ+97cUdeVx
X-Gm-Gg: ASbGncvSG6Zsg9pJFzhMqtYX3tb6VA3LtuEmtVEXEP+vN8dVxBeFhUc6mGqn2L0RIkf
	ZFfVvgRXVXsH1kiC/yelZrekzVwN7rRBYp9CV5q7KMgV6kPdBDRJgyGlTCiSk8lMHxqZS0hqwbE
	8eduz0rVz7gX03YGxxMMyceC2a+rPsHAh7AhkmUroKfwVU6aYbBdDIftZe+F6JG3wB7zzCx/wUj
	Cqhpo4TTW/KaMtAmDvvqfuj5rnyDJlKcAhPZgqpRUiijIhX86nbjR4JOMVbc1kE9dKupWVVwXjl
	LY6xSc/Ue2cgCGDWXaMz/KHOrhiAFCpicw==
X-Google-Smtp-Source: AGHT+IEYtKEnGZ39GvMbcfj0wNEB/Y7HPIe4XJ9Z3n5OVfb4/JVz12XWbpPUjW0OK75Bv0H17r1gBQ==
X-Received: by 2002:a17:907:8688:b0:ac3:c59a:413e with SMTP id a640c23a62f3a-ac7d6ec546dmr163533466b.55.1743755117074;
        Fri, 04 Apr 2025 01:25:17 -0700 (PDT)
Received: from localhost ([95.85.21.12])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac7bfe67e17sm216029466b.34.2025.04.04.01.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 01:25:16 -0700 (PDT)
Date: Fri, 4 Apr 2025 10:25:14 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ACPI: PRM: apply ACPI_NONSTRING annotation
Message-ID: <00f4b71ec859adedb34bb33b05634cc1ae97cfda.1743754416.git.x0rw3ll@gmail.com>
References: <cover.1743754416.git.x0rw3ll@gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1743754416.git.x0rw3ll@gmail.com>

Mark ACPI_COPY_NAMESEG() destination char array with the ACPI_NONSTRING
annotation. prm_content_buffer->signature[ACPI_NAMESEG_SIZE] is 4 bytes
long and not expected to include a NUL terminating character.

Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index e549914a636c..7c2553696dd1 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -40,7 +40,7 @@ struct prm_buffer {
 };
 
 struct prm_context_buffer {
-	char signature[ACPI_NAMESEG_SIZE];
+	char signature[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
 	u16 revision;
 	u16 reserved;
 	guid_t identifier;
-- 
2.47.2

