Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8B9167DB7
	for <acpica-devel@lists.linux.dev>; Fri,  4 Apr 2025 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755078; cv=none; b=i8AvAqO82iK3qCVBbAc+BF6AMeexPejsnGENmbLS4UIv2vxMV8+E19QYtL0aGA/T3Iugd5wejQ69Gx+crPDVGMxhYgzgyXrKYaYHLMIh81xexqTMn7rsVo5WGLA7VmoE7wjoQFDdp9e84M0eYM3Ep2YDXR3xXY9NK2SUHdv2vps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755078; c=relaxed/simple;
	bh=O+GAE5Vzbp65UqRHmQTuY00tUUYdLuUU21KF3CXm+jA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A/LNc6gavQ3t8d7rlBFUE8mX+/3cGoBD9LBWqOuzKOF6bF+JKKUO4bakwQy/I1TrswURs6tFvcMBg/cajTs5qw85whYmgQl3gp1z9ajzBLK1WtvX+51FFagDcf2mSb7Txd0KNwXZypuiNjawSx2OiDc+lFCJRRN/aKw0/7R+PDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pn1Zjcff; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pn1Zjcff"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso241596066b.1
        for <acpica-devel@lists.linux.dev>; Fri, 04 Apr 2025 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743755075; x=1744359875; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8Q4hgwLYaVKLcAdMEHefEZY3heGKBcISCd2gGVlBqQ=;
        b=Pn1ZjcffMSavmTdXESCMCakT1tyrve9AjJjFsOvjKh0UokiqmllOpOpCDbqXCWXp/g
         2BriGIer/wRcQTbygkihGuWPpq4Bc5qFe837DI95wp6y1EEU04zYF7TaKTcnWTbVikL3
         /2k0QKTyr2KS6c/k4XHtowpAHJgclnpFub5vc4fKFGdvb6tdis6pHO0f7WPvn3KIhq1g
         r8xfHTpPaNAN2chWRzqWNaGpw1ULVSMZsa6XxLr5RrVV2MopB7fNOMSo/wEL9RmKTW1+
         trxuGVJdXdmagYhmqYKlEQlvrZBty6z8EOAOMW5Cd10MGuFPT5n4k9UaUuud7+R4ZHup
         PbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743755075; x=1744359875;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c8Q4hgwLYaVKLcAdMEHefEZY3heGKBcISCd2gGVlBqQ=;
        b=ZQpeqrwRK8+TiKQzMfHFPtLDtl9Z2Zv8v7wQZjdU0sHsIuhDQmzDGVpdbyzHPYLXoC
         STWN1Zrg372AtnNyqdv/cCV8hPhG2RqasC7EMfmBAVJ2USoxFKCtNnBpnyZjWjErk9vF
         9Uqe1ktYTsmeZREtV1bCOyEihOxdozNsZLmrTQ6LpeK4TzEg363tdyeVNhJ2Ti6exGHz
         Ob34zSwZOeF4zKeL9Yz7AIlxHERCdb1/PXxBSON+FcGBqcezH1CNPjwiv+lyL5CqahIw
         fOpQQfai4JkqstwKsGL8lBxt//ogAAq8KECFZdpJCpy70hJyWGU1L3NZj4lRGE38vbTs
         Cj5w==
X-Forwarded-Encrypted: i=1; AJvYcCV5u8cY9BOl1Q7llmHHrF0UshbLgxfbuhfmyrUM/fHvqXwDXLMCVCXOH3PcNHcdqeigMFY7M0dOlDHzNRk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxw+KBizRQkROTUBpJIurOdjtSY7t4KXdI9ZhXDgEfXsjeg8ZoN
	h/h/KUne/+P83GUl19tLr4NTJDtXEAqcPN1y2t5hmD9Af8lILcPf
X-Gm-Gg: ASbGncvDYdzczUh0kVCkFczAVCVOiRqObT1w17bqI5XU2SHzO9ood2jQvGEkbQnBLvp
	GY0vC/QHjQts4g6X6eLQdfrPQf5YOULY14HlXy5L+zV6Yd7YdDnCDgzKuOHcDPJxD6tKGYoAluY
	kgNsU3AM6xiepaHJ3mkuCtpBQj698JhnzV35OsqDuBFSjICZFZ2M11buOTTnz5jLL/8XQ5vq6b+
	hxm/qcBMGVifTnInGv6YrZPtJ8TJOSI6YDx5lwIpk0r0vC8IqWubWdSSBfwxga2hXhVOT/7uY8U
	XTEfTkMysGWTE6GcO8kPthh+sbeKFgLNxh8fhvwQMytx
X-Google-Smtp-Source: AGHT+IEr8VZKlZ7IIYPgxyNWlJEzXndX2BwR3FYtz6od+rPLp6bFG9RsHZn/yoO5kSnu/NpReCNkfg==
X-Received: by 2002:a17:907:3e1b:b0:ac7:7d43:4535 with SMTP id a640c23a62f3a-ac7d6927509mr133733566b.0.1743755074851;
        Fri, 04 Apr 2025 01:24:34 -0700 (PDT)
Received: from localhost ([95.85.21.12])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac7c0186250sm209973366b.155.2025.04.04.01.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 01:24:33 -0700 (PDT)
Date: Fri, 4 Apr 2025 10:24:26 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ACPI: apply ACPI_NONSTRING annotations
Message-ID: <cover.1743754416.git.x0rw3ll@gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Mark ACPI_COPY_NAMESEG() destination char arrays with the
ACPI_NONSTRING attribute.

This series depends on an upstream ACPICA commit[1].

[1] https://github.com/acpica/acpica/commit/de1d500509d37

Ahmed Salem (2):
  ACPI: PRM: apply ACPI_NONSTRING annotation
  ACPI: sysfs: apply ACPI_NONSTRING annotation

 drivers/acpi/prmt.c  | 2 +-
 drivers/acpi/sysfs.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


base-commit: b3c623b9a94f7f798715c87e7a75ceeecf15292f
-- 
2.47.2

