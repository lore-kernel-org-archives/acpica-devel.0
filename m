Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34E4340A6B
	for <acpica-devel@lists.linux.dev>; Wed, 17 Jun 2026 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781718010; cv=none; b=OzpNEZGHxdxwhK0nSP34xH7W4qSWEPpqck8OBCmYBsyhKGscuA+Tg8+puRTxX+kXR3APkeiGaFkq2bixQlRs7j6usxfRTJw7+dbLOUD+IkSaDxiu6kj9v8/eFe0OajBP5IFpN0Fwxtn0gvY+kpOtEemuMxXmMRf5Bxl31o5WULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781718010; c=relaxed/simple;
	bh=3H6Tx8GKVFXGcwT6woXKZw4U9eyeRFNU5j+1Z0MDS6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdxK/YMxH2TuB6OK9jP9EIZ26L/UV0kULQsOez7x3CluZYOd7MjLas97xSSYwjCmbLC1tDMHKgchKR5gumVSy8K5aa32tZpBng54jMkCK3Ah32wVpfo0o9+ICaRcYPIkhpZjyhNK4uoGLN6rOq2VvQff1lp+t+T11u80Oa4FQZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jogdPkLs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jogdPkLs"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so63570235e9.2
        for <acpica-devel@lists.linux.dev>; Wed, 17 Jun 2026 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781718007; x=1782322807; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=E4aTYQpCEBfoHlNp/ih1aDYhCnw5Uq36PYKp2Wj/2Xk=;
        b=jogdPkLs659GxtPLgAblXV91NYRqFN1z0yHFpgxD3CVXrGu0y44Q5n2BBRgADp1sWu
         LpCz/z5AzY38UqAIO14/Vi37nwQDfL90003+UV6JKjXKvWyNa4OKxtH79uTFN15zHJG+
         Cjly9KXApgFe2aAnHqUitYTRchtTX0QSthONoX5KV5bVQwmBpHhK1ITlf4xOltZd+6Of
         HXq068x8iuQYqP2rXItpv0sRlWUyJ+RhJLnOCj7IPegqx/kXXt2SI5rgp9yxNSPaNyAs
         Hj/a3NqsFOmVGfITlDl+3XDVO5DkgLOj4JsTrDOkxiCQE3y9/oNO1bo3aSOhB+KaoORi
         RcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781718007; x=1782322807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4aTYQpCEBfoHlNp/ih1aDYhCnw5Uq36PYKp2Wj/2Xk=;
        b=hH4MdtO51meckH1tDaQE5xJLlz9FlSQ8GZo3361IFRJQ+9EbQgcBPjYoE6CXKV4td+
         iHBmaVWHLzEO0JtP+BFfhNz8RNuu/g/z/v4noXbCnnxikaWSAfr1nYjCWSlmUATSKHZl
         MPEUsHui2nnhhtJqtA2vunO9xiD1uIwTOy+i86+Gle8Cj7yXEbvL0SB/jAR5kuWUI6mk
         eBawlgzJyA78WSpKkkzYj8Wo0AmXpl5P2ZMnIWO1uBr4gbccm/VCKSuUZEnpOs7T6K28
         LjTiKWFVpVMKeYH9TzkO1MXKXrLp0LbtqZrCH2CIGZG8xkAl31X+UcdEA8sbUPU+NzTl
         Da+g==
X-Forwarded-Encrypted: i=1; AFNElJ82lv8QeDi8L/AE0JDLRZAyY72GFNZHTht+MOczVNt4MXtFFy7+c95SnNGDu8meEh3fjMNcnrQIbnyZQJE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxt0UyX2xZtADK9mokZVj8CmxuKZf8FNzlL3+yIDzKWAVwH9vJa
	s2PPQLnKkeTWO383WCm5klo9qG75wwglVp9OvxX/QfpWIKI4ctzk2BN8
X-Gm-Gg: Acq92OHbcr/tgZ9GedDZx/kyLp70E+ccmQryEiQK81d88gWhtps96Opvpxe7qzA0XrH
	QagkrcNeTVQ+hEuVur8oI9kXXgfh8aJz3eHnT5lkOBGSduK7rXZ+mtA7or7hzamYdu9sM1GsK19
	KxdKZdvCuUK8FG0uCKuqrqJ9rJUB3fgUN8rrK/Hgg1Xn2IuUDJllq/InJcAOIgjOLu8SJlQplfz
	Q3aV/+NBNuzIFTT9dnvijmRfP8wBKwvJeh4OysQYFQ4JN4HuV61EkyUTOvJiVtoU8tWpFgIbcH6
	vNp3p2PWFKcRZKqfsDvhAgVCFa8Qxc6z9D2lY8y+Bw8uL8TxE/rJUZ2zR6FjMYWEExC5aJf4Dv0
	eJ7I/IG0qcbl1ONw8CbT7Zjmntr4IrFPIVfvOfILjuUl0Bf+uEpcluEUXXVETkVnAkOrCMjasv+
	ut3fylH2g/2VojEfyjyMTU1559Dky7Rp9YoecdhSoJ1aRvlQ6UALGmipCktPM+G78xqAR7278Ow
	pMpgFaBaVMhBETHbg==
X-Received: by 2002:a05:600c:3e1a:b0:490:e974:e01f with SMTP id 5b1f17b1804b1-492333ecb80mr88065235e9.28.1781718007311;
        Wed, 17 Jun 2026 10:40:07 -0700 (PDT)
Received: from [10.128.11.42] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49234daafc7sm59819515e9.10.2026.06.17.10.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 10:40:06 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <0f131ee4-d335-45d2-b6ae-49c18df1353b@gmail.com>
Date: Wed, 17 Jun 2026 18:40:05 +0100
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/10] RAS: add firmware-first CPER provider
To: Ahmed Tiba <ahmed.tiba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Len Brown <lenb@kernel.org>, Saket Dumbre <saket.dumbre@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org,
 devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
References: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
 <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-10-91f725174aa0@arm.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-10-91f725174aa0@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi again Ahmed,

On 6/17/26 14:54, Ahmed Tiba wrote:
> +config RAS_CPER_ESOURCE
> +	bool "Firmware-first CPER error source block provider"
> +	select GHES_CPER_HELPERS
> +	help
> +	  Enable support for firmware-first Common Platform Error Record
> +	  (CPER) error source block providers. The current in-tree user is
> +	  described by the arm,ras-cper DeviceTree binding. The driver
> +	  reuses the existing GHES CPER helpers so the error processing
> +	  matches the ACPI code paths, but it can be built even when ACPI is
> +	  disabled.

Yep, sure enough, this patch causes a build error when you enable
RAS_CPER_ESOURCE without enabling ACPI:

drivers/firmware/efi/cper-x86.c: In function ‘cper_print_proc_ia’:
drivers/firmware/efi/cper-x86.c:352:21: error: implicit declaration of
function ‘arch_apei_report_x86_error’ [-Wimplicit-function-declaration]
  352 |                     arch_apei_report_x86_error(ctx_info,
proc->lapic_id)) {
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~

- Julian Braha
