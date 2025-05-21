Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD02254869;
	Wed, 21 May 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747843135; cv=none; b=j4eVrY1H6fA/BlFnhLb6iaYq8ZjTYz0Eh2zk6CweN7otonu37b1RgdN1aZPV0kkjSWnpzSi1aE71M2agR2zBkC/B7ziiCa6yXdVt0W9jQT1liIy0qx2FBEj4UvFqumZT6fYXvuMpjhp4p3McM6gKc6nK/R0ClVi57lcJfnqzfr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747843135; c=relaxed/simple;
	bh=5+T8GTHcN2Kuz6CaX0w3iMNFuK4+py2zrcsMcPNUFJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jVgkR9j/J/WdgmbGuO0yJvV6hRiqydlAtFvua+o0YOr3odRzIeCAS1Yk8dtDI8gu7ITlvkUdrsf19On0BVvpM4ERXr0MaEavZexq0TCl65t3uLJsWu01B02ByhgISmYQ3S1CdHVdMn7qN3tTtCwQfHCOBHMM2djT47fm9bW5NzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnIDVgYk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnIDVgYk"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso53620525e9.2;
        Wed, 21 May 2025 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747843132; x=1748447932; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gszD8DxK/QJXTJSJJ0pI3vv/hb5ULbF271EMSl7cRgQ=;
        b=KnIDVgYkLOAbm9yoyj7QjsicEkmyPNWnAWCiGLii1vkRm2T5JztX+VCnP9x2flnVBu
         0m2O1XXjP7l4yJfrytgG5wFN/kK4fOQvovjFumdyHBsVvRmNCBxFpSDNneoEs1vP3FE8
         IBLmmT52HGN8RYYyyZiX+2NU4nj/FDFJbu+/N14e8Ia7fUCpmn9eHBgWCVUN8pD//pyZ
         M2HWz1yXEDfDYlcaM472FTmfFVoU7qS8Nsjm4KG8T/ZhorN1MnDORiWylKRk2sVO81f2
         iFJccc3KKgId28LlA7ff0yFbAYA+krJlIcOLyGkEetk0Ccpe1YrmTCr7xZzgQGpgSuFD
         +onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747843132; x=1748447932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gszD8DxK/QJXTJSJJ0pI3vv/hb5ULbF271EMSl7cRgQ=;
        b=cp069zNeoGdZDCS3SANBS75sr1HSKnI0r1365vFnu2+Q0wijdjyxCrIDpJ1aUgQaLs
         YuPFwEA6rZdHHTXhuPmRuUN5sqM9c9Dkp4ahcPFMeK47454c5kzj1P+Ggm+rsRiVL+/0
         VaJsmXVqaTYhoSZwP6rbpSN2eptIteUb4GP6bhL2t1EmwDSLL4QQjbVFHrsC0UmHO3Ek
         uzhR0UR98MVtc9BrUMrxphvbOdy7pSTu9PTipj02iY8UpwqOI02KIAQZj7VYb9WX63A6
         pQHEZZJASUrzJkRFLrytZ1RjgtdipOoR+l1bwSoZ5fGM1+lzvu4o6CS/JviZchfSo2Dg
         LPIA==
X-Forwarded-Encrypted: i=1; AJvYcCXORsci2AZODbp3PDj+jobEn726tpQylGQAOEAk+loBbj5gUqtzSoz2BhTJGtCLS/MBW0i+7xc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzB1siJkvBvkZ81EkfLGRzbHO1+LNZz6l98r6u9H4Hx2yXGTEB9
	Z2fVZWoZaGdrwfPl7KlkZ7szPWnOyBCm4ZHUD5+2ktaoqFyRxDZgQmur
X-Gm-Gg: ASbGncuV9HukzWykeRY5dVkb1Cr1+jeBxXa+eaF7M30tq7jBDcVfq8HfkIyy31Magym
	gvm2x1gGD+QlIQ1/CGaIMjOsR/gBO7e1dvkec2KE+bnHbtkj3+UViVVtSRob5kXehWkNcd/PPIg
	GPoknGNRKHDoNuHBTke7wi0hEACs8bEbpNldFntfVo+mEsH+joNpXcuPo4h6WwKuNnaUKYbGhKf
	nrFtQ5LGdD9WOCliPTGfcBmDWTN10QYzVgb440CK43yshXAakv5m1jY33jd+CiDWwKf9BUYPSN2
	2FV8a/PqsKuP1djF7gpScxPGHmKhTxcb2vwKu0HzJk+K+/5+QYtLQpiOwknbuw4=
X-Google-Smtp-Source: AGHT+IGjt+tgPME2C9K/SJUnMp5BEwfG8pQsZa5B2z1xYKBqj2V1u/YCvGhGgjGSJatBpF3CFRDr6A==
X-Received: by 2002:a05:600c:a113:b0:442:ff29:c2f6 with SMTP id 5b1f17b1804b1-442ff29c404mr178921795e9.13.1747843131872;
        Wed, 21 May 2025 08:58:51 -0700 (PDT)
Received: from localhost.localdomain ([78.172.0.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29633sm78652695e9.8.2025.05.21.08.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 08:58:51 -0700 (PDT)
From: Baris Can Goral <goralbaris@gmail.com>
To: mjguzik@gmail.com
Cc: acpica-devel@lists.linux.dev,
	goralbaris@gmail.com,
	kees@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	rafael.j.wysocki@intel.com,
	robert.moore@intel.com,
	skhan@linuxfoundation.org
Subject: [PATCH acpi] Replace strncpy with strscpy
Date: Wed, 21 May 2025 18:58:49 +0300
Message-Id: <20250521155849.13783-1-goralbaris@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <rkc452hxtxcaym55croa5uvtjjsulbl25bhdk2mw2ce5fwqx4p@guhdxk6eogqj>
References: <rkc452hxtxcaym55croa5uvtjjsulbl25bhdk2mw2ce5fwqx4p@guhdxk6eogqj>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mateusz,

Tyring to understand your point. Why the customer want a string or
an ID without nul termination?
In your case, you put forward an idea that "the thing is NOT related as a
string, instead it is handled with memcmp".

My idea is:

For examle, the variable "signature" is __nonstring so, it does not necessarily 
contain a terminating NUL.
[snip]
      ACPI_COPY_NAMESEG(header.signature, signature);
      strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
      strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);

[/snip]

But the others, oem_id,oem_table_id are not.
So they are strings and deserve to end with nul.
[snip]
struct acpi_table_header {
    char signature[ACPI_NAMESEG_SIZE] __nonstring;  /* ASCII table signature */
    u32 length;     /* Length of table in bytes, including this header */
    u8 revision;        /* ACPI Specification minor version number */
    u8 checksum;        /* To make sum of entire table == 0 */
    char oem_id[ACPI_OEM_ID_SIZE];  /* ASCII OEM identification */
    char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];  /* ASCII OEM table identification */
    u32 oem_revision;   /* OEM revision number */
    char asl_compiler_id[ACPI_NAMESEG_SIZE];    /* ASCII ASL compiler vendor ID */
    u32 asl_compiler_revision;  /* ASL compiler version */
  };
[/snip]
Otherwise, the writer would have added "__nonstring" keyword.

Best Regards,
Baris
