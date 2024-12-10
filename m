Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7E1229B3E
	for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860585; cv=none; b=JK/RxVeNezudkxw0qWrQ4bAmItCmMBV8ksJc2giMZeM6sbqLMYlGUt5GiEbFLapgazTx6Fr8VUU1OrN7qVze3cSeS5t12DXhWULOE6sf2/e9Blc5072fgZsA5mi8N6YDlnJVudZ3IRVaEog6+AjE/CJp6AAxtHSimH6jqnotryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860585; c=relaxed/simple;
	bh=Whh0DQItzHYKCLXHq+kfFC3x+7+Dk004xdEIyRizvX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OvQrXowBx64K8ej3SEJa8C/1KlYIjkVJWsY5NOlyYWNV37jJTTiPY9pJtgF9U733/1RPlb3fQ6prr7nGPJeUWiR8eu0cXlQ7A7eyIbtcRqBx15vl432nhXVyKpLFRDCISrcLdWSSVWh5uDtKkrvz7A8nvrZSG30KS9DxQ0cf6ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HDDiBEJs; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HDDiBEJs"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-85c4d855fafso1006660241.2
        for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 11:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860581; x=1734465381; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8Rm27YENFKXAm/b99nWNPn/wMV7ojkGu352W65SJ+Y=;
        b=HDDiBEJsBsnuc3ilraz9hgzbTeYBwEDHBxC9d5d8oW3d5CpaaFW8oqgXH/eFCyhmrk
         ESmshqNFidrtQ0zdeXXij7XpH/64DVtfy55c8XOzHIFUO309pOgsqmNSMqHNEOFgFHAG
         MNDYo+gypExN1aOJGAVQdD6UcUzZ5KqUYvGLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860581; x=1734465381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8Rm27YENFKXAm/b99nWNPn/wMV7ojkGu352W65SJ+Y=;
        b=RT45g5y3coDj2N2x87OwMXVWZ39hTZ1xLa7OIK/+hXBIx1QbDHEEO0wO+PSsSttg3v
         Nc8zipPw4/0cV0Mr47fY33sAbpIKJeOztDqKLR8RzT502s9rQ56BxS+cbednEegykJty
         4ybzMasVX1s6I3ZXh7vG+ZD0e+oI0Cug0kw7m5S6a2jq6dDb3s2mL18t43R5RFkrRV6l
         0x1936gwGxU7Ca6kmffKL/k9cQTHyef6eDaoKvvqFlSIJJPk2G5pneHXnRbCf6d5snCE
         04opK6lW9Y7s9227aE3LxfAsY/tuxVGtgyVD4OYxskdHnZbSuwK4/GCK1EWLvapQKHGx
         Zfzw==
X-Forwarded-Encrypted: i=1; AJvYcCXqKNWqPY497m7Q7dxxthzg9pV+agMQjR/3sd8pGNKG4Xnvw+uqqbnvVuOpvoGo9g3iYW3I+dak2aCwzgg=@lists.linux.dev
X-Gm-Message-State: AOJu0YxKMsLSlM/e/CzGawQwj0J3wLiTV7jEaeSgSceOx6uqlAg5Gbx+
	Hw4J1aENA+P1ndwTlWa990+gTLYMVSXynKAd3B7OSBxrZBT9ChIM+FQ0X2jvmg==
X-Gm-Gg: ASbGnctcAB9VuzV/sTPmvHGszcPP0i14tKRPEIGCLZZ7bi2cRmxiqDvkH6hj5NmY9qQ
	NqW8+rAqD0Gj9sbeXJ63m0tVJvrTGHxNqYoXx07wz5P2kW3UzkAnSzH+SqZh9jiIh/bl6Zpj//U
	Uqn5sQtuGJLOzqY+6WuXE1NjT48c0jTmYue93urtIEy6Qlr76R48cCPVz6hp8ElXH2T0sMJuHeD
	a/XIjIqumY9FnQzVkmE+NvWuz4V8PGCUIi2TL8i01xOwX/5bFGyDXBC+R8uOozJ4tAbyt+SIMps
	sp/1tB/9XR/SNDLKyaa8YHUDwTVi
X-Google-Smtp-Source: AGHT+IEooHxihkgq0sisqhW/5irMfcedK/Z/FIef/F30lACx1FcjAKe1abfF7f/u+XsC/FOi7CtYPg==
X-Received: by 2002:a05:6102:ccb:b0:4af:a925:6b40 with SMTP id ada2fe7eead31-4b12913b260mr760661137.20.1733860581729;
        Tue, 10 Dec 2024 11:56:21 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:20 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:56:02 +0000
Subject: [PATCH v3 5/7] ACPI: bus: implement for_each_acpi_consumer_dev
 when !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-5-00e409c84a6c@chromium.org>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
In-Reply-To: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Provide an implementation of for_each_acpi_consumer_dev that can be use
used when CONFIG_ACPI is not set.

The expression `false && supplier` is used to avoid "variable not used"
warnings.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 520f12155e7f..4f1b3a6f107b 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1009,6 +1009,9 @@ acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld
 	return AE_ERROR;
 }
 
+#define for_each_acpi_consumer_dev(supplier, consumer)			\
+	for (consumer = NULL; false && (supplier);)
+
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = NULL; false && (hid) && (uid) && (hrv);)
 

-- 
2.47.0.338.g60cca15819-goog

