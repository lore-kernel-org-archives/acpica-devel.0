Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF29194C86
	for <acpica-devel@lists.linux.dev>; Fri,  4 Apr 2025 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755132; cv=none; b=YOz0jKIJ6FUwqm7/Y9iBISBDtT2qb177ScWmaor1Bry5/2ifAzOpc03V6fA9fUl6hTa4JqrCq5JfwFjacOp598WzOSXQxJVeNdZElOoyFUsyO6uvmEtoqZVhwpivJcR73Ne0RvewcYhjJRrVcKLZs39fXCg41e01XJOwa2oxk5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755132; c=relaxed/simple;
	bh=Pd54fnZYvN0IF3kAJsE/tgFL69YD0dJcke+lyp9URmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRsWE9tI3uRuy7kZOxdD+VDPhFStFtaxCd9U2XfLHPGmJG6o2RsWZR6G5PWNwr3DGk/fqFd7RwmKdBGQ6I/XdF96D5WziXUPl9ldO1NUFlUJoRlNNF3Jgww0XUNkBC4Ui9tIfIS1AtBVNEQcguHujZZKUtrM1HjXrpR8YKL3190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mI5LpwtU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI5LpwtU"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso3191122a12.2
        for <acpica-devel@lists.linux.dev>; Fri, 04 Apr 2025 01:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743755129; x=1744359929; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1uH1IX2xHGor+jIVcJKBUYPSchHEkklHprBp/7Y2BGQ=;
        b=mI5LpwtUU1jp6rGK//YHAQzC4o4e9Cq2ryGkgadIh+HWM070/fzL4fO3Uv4U6/GIoG
         /LeMOdYDG4meEk0rF+0vpA1l1Jzk6U6P6Fm7yB1yfkJreEHtjJu+TPje23cnYZ4avsMy
         i+LwovKOZtWp/XWPKYU13zqgJd5T0Rmv+B7R3pSnHd2U978/uJiaSpg0DXqklIQpyJK1
         0nQEB31/2cNQ0RzTBOga0ULZ5GNfyy1oEZFljk5yUkQ0gprEtgmRYXf1aezAEJU9A5hc
         t9NdCWdhPOVlf6bXS0UWzTqztzORpg0PBRsecpyWQn/6675tmavoiyuTCneWJ27PczOW
         ycSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743755129; x=1744359929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uH1IX2xHGor+jIVcJKBUYPSchHEkklHprBp/7Y2BGQ=;
        b=NU1RuoiCbEW48NgaXndjfH4L1AYHNs4ODS/JSIRKVc82wpKpJHCwvH/uP0e2vST4Kb
         BqtMsuSouHTst6tdV4glwOJOV/tZhvE5Aur7ofOlCI1k/nKRImiVef8AA02v8zeYyTBq
         IMHIuiL7Pg1iCtTkN3MeyTG+j/oTsvDYjrSTyrTiMIEGeOsvk7blQgtyOqmdOW/L2kQ4
         jeyWPzlSHfOxsNKPOW3YpLwA8Xbbfp2cw2Q2gHYvJoGBO4p55805FvHYcFYX2UshvcBt
         gGXei4hWphSpKbbaflVrPfmad1uPsauynNCeU2uK9dbvOY3gc+jkgLKjAsrYNJaisVCc
         bf6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVN4fVHZXo1qZ8lBAnnwVuBF0JTZM4KPOqCBQNsUfTybe/wMfAsBX0A08Z1ga+UW+HODVqW6mjkZ/kbMQI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzb0/1Pt2d6i0s58aO1Sa1XshAMwawOS4Z4BzD/uNwDJR4wEI2I
	2wvRrSD8/+e2wf9MAvYpNF0JbEcwf7Cmk5JbgRNS9o9YikCTeRhO
X-Gm-Gg: ASbGncuigfj+iT4fJ9Nb8nQYXMb/qGvkvYF41s/eoqWch37sZKG0Ww0Hf139oV27MiX
	Sff7l8xj2KQrgrkmUk5O1R93gl6maRIjJAsz5SN0u1/6xwB+TlzF7Me7NFfLyJvhA8NcUE0/+vq
	k/xJD5ca3Spo0BbnDgSkUAnybBwJEFZEhZ3yUr0ToTQ3AG5pkkdieEHx2sn+rrqv1F5/F+xgHBt
	jb7gKMaNEwlriXHAzvrKh1uFTnpsppXd6cL+CSe7v+NaOzh5iqy1KEXrHgmsn3pAi/xsN7sfTUJ
	hJCaHiromIHx0W67vkSTaST/trE22ZaSiA==
X-Google-Smtp-Source: AGHT+IFVdlyUKzMf5Pb5awlp9iNJ1Cr8z/mFGTAH8E9fTJUEvs97KMGKq+hbLu5ymPdFCE1kusouSQ==
X-Received: by 2002:a05:6402:51ca:b0:5e6:23c:a242 with SMTP id 4fb4d7f45d1cf-5f0b3bd0a10mr1826431a12.18.1743755128931;
        Fri, 04 Apr 2025 01:25:28 -0700 (PDT)
Received: from localhost ([95.85.21.12])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5f087714df0sm1954318a12.14.2025.04.04.01.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 01:25:28 -0700 (PDT)
Date: Fri, 4 Apr 2025 10:25:26 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ACPI: sysfs: apply ACPI_NONSTRING annotation
Message-ID: <dcc3a018fb28899b277df2e154740d59d4e404af.1743754416.git.x0rw3ll@gmail.com>
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

Mark ACPI_COPY_NAMESEG() destination char arrays with the ACPI_NONSTRING
annotation.

Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index a48ebbf768f9..8a5af261129a 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -307,9 +307,9 @@ static struct kobject *hotplug_kobj;
 
 struct acpi_table_attr {
 	struct bin_attribute attr;
-	char name[ACPI_NAMESEG_SIZE];
+	char name[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
 	int instance;
-	char filename[ACPI_NAMESEG_SIZE+ACPI_INST_SIZE];
+	char filename[ACPI_NAMESEG_SIZE+ACPI_INST_SIZE] ACPI_NONSTRING;
 	struct list_head node;
 };
 
-- 
2.47.2

