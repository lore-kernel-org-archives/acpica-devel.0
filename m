Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564231D63CA
	for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933245; cv=none; b=n4iWsldXyt9TMm1Feri8NHLJ9g/nApDWeJd8y/H7sXHPkuGN4myngMT52BAgR6Ee1Aa/1xwoxP01gYiieajPNojs/gc7+U+q1s4/Qw9fogscqbKp3AaS0dgwb4ogHoQUc8apuGWegNr/V27w2L34BWvJ8Xin9VHJMViwo7klXbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933245; c=relaxed/simple;
	bh=Al9wzob7Lhv6GfLgpukZha8snPi/gtMWzqmI5Nh5O0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fTYrTmLAJIcdqVHxfWmAt5yHiSNd9evVNj+QkvrTs1aVtlfoCJW91IiME02FWpgAb20xiuX332drZgic3jiBUKcADJRDe34rNzzQQeKJ/wCsGPPa93TF350pkbbqTozuKFvd4el5RbCuvrsL76afzYLX5iG9vj0UeWnXt5qDhPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M0SvPo4y; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M0SvPo4y"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d88282980bso63025926d6.3
        for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 08:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733933243; x=1734538043; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTwO2nGd6wIbXXez+6l1I38nMUW2rTd+Ao412JHVCs4=;
        b=M0SvPo4y1pBPhy8VwnOI1AvfeITwq1wZ/ShDo823ge5r3558i+K62ZFMjwoFF8gmDY
         AwknBaR578fm1yNPrdSAEHoxiMS4rEciYbC/U3UZFKiUmYFsyJnjlUFR/dcCpgoERVDS
         s+4PlfOwJtdY70XnO4RZV9qtZXzTR8BG5UlwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933243; x=1734538043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTwO2nGd6wIbXXez+6l1I38nMUW2rTd+Ao412JHVCs4=;
        b=G12DwZh/C17/lvS2zs6wBU5S2ADzBGVXyW6gDYRLsrdwo6FaaMJzfAPIOv5+z1wc8p
         Sc7onZr3lBeAbxMIrZvfXRz0kXkYql805Iv2CWbmpKwXEyQ/zcTvohCn9IyA43JbFVZO
         qUzbMDprs/MLS3wezgs1iYS51B/gkQ7iNAu3JZJkkBLY16fR++1gRLVjx6cKjH7bKH5V
         4KHc//GLXBWVUz2pX4IKrdjfoL6ryVHgNbBRN9GS6vSAm225f3t+Mt/SStUZzPe4WN36
         kb4chUeKio/rAu9+UsFdBIeSD9BM1NEqsZX53Oq+pXaiNlFPbcEyJ9NnXE0tmdD1dnen
         Ze4A==
X-Forwarded-Encrypted: i=1; AJvYcCW4LkAc/AvNbwFJQOXfsNYgzzUF9oKa5GY0Nfukox5vX1gfm0kN2hU3Hw6WU/6y9VYJCg0VBm9u03u3628=@lists.linux.dev
X-Gm-Message-State: AOJu0YwMU43S7mwwWXeS513GrFScDmIMW+wmjz3q2qa4vtXesZ2ttCs0
	k6R0sUXp9MAyz8UbgsHEiVLA5QW2RpZD4/88PI3xbs5xMebS74y9p9lMM29rhw==
X-Gm-Gg: ASbGncvx3ffUQpH0rtVn8JP/ZLavo1GSZKMMs85GvY8PS5hEXcQWoykQcNchwA2xpcY
	gbj9zNGvHaUxT9KWBEeyVFkCaX8IHPQFj1dxdq7LsB1yKn+Hm2EEr/QuBsNTIJHDiGzzhFxY82p
	CQLkZN1J3V/XhbJDrKRy28K+IKExZYDIpzum6hI8Cbx6FizNlnvmZQpb9aCBgi1klypNoPijD2Y
	4dN1czuM2w7eb6EZnGqVAYtJiGe627jeK6PgVVg8x3qS1Q9wkge6bbsXp5SuZQTI0wUoTdl4Jrc
	TQV6sbrlJVUyh1gk+4oPkUnQ3haV
X-Google-Smtp-Source: AGHT+IHNI8I7kNh1BQAzlY9E5JVcbcVT91dIbzXQpJE1CHokvbatsoZUS9G+d6jIEJjgxda5ooPoQg==
X-Received: by 2002:ad4:5c42:0:b0:6d8:8f14:2f5d with SMTP id 6a1803df08f44-6d934b2d7f1mr64995796d6.28.1733933243062;
        Wed, 11 Dec 2024 08:07:23 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm71484946d6.88.2024.12.11.08.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:07:22 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 16:07:19 +0000
Subject: [PATCH v4 3/6] ACPI: header: implement acpi_device_handle when
 !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-ipu-v4-3-4102e97aceb6@chromium.org>
References: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
In-Reply-To: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.13.0

Provide an implementation of acpi_device_handle that can be used when
CONFIG_ACPI is not set.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/acpi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 05f39fbfa485..fb88f21bffb2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -854,6 +854,11 @@ static inline struct fwnode_handle *acpi_fwnode_handle(struct acpi_device *adev)
 	return NULL;
 }
 
+static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
+{
+	return NULL;
+}
+
 static inline bool has_acpi_companion(struct device *dev)
 {
 	return false;

-- 
2.47.0.338.g60cca15819-goog

