Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA1A24BD0C;
	Tue, 20 May 2025 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758946; cv=none; b=F60MHsy1XXprxYdnuhrCs/KI0T+P2mhiKteTaZHPU6hoZ+bZKLm12MeZcp7l8/Sv55ZCHkrUZhH0sZ2zHznZ+Ji6qN1DjIpUbprDsQsmAwSbEXZJxnDSrZK463FV2q7M6EYN2up+bvrLF1poLiUJI9P/RJhJUIBYcpP6DZyZtR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758946; c=relaxed/simple;
	bh=f0PfTfMmru6XtZg7/P7iWYe3RnaZ5NwcijI/RTSpFVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OxyJBb9PuzzLwbSr8UFKF0Frmc/kOb6/r872myx16d6A1AyCC5Qy84ZMlJBBgxO0kuqAT8HMrdxrwyzLNdYdNxo7H6+r5DoTZWsxBA0FvwDUoO2aOXZwetWDu1hyLvKydvPgTyYTQZh+5kwZswJnlepdZVchpHcxnUFW4vbANng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3n1UOzT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3n1UOzT"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43edb40f357so48684615e9.0;
        Tue, 20 May 2025 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747758943; x=1748363743; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0PfTfMmru6XtZg7/P7iWYe3RnaZ5NwcijI/RTSpFVU=;
        b=g3n1UOzTRsLhtPa90f0VvGj2vHMDMOGprL0qMWOgCHBQU7wUE0d4KIPSocSuXy+7R7
         Fo7lRLkqADJ/WNvBMtlPZZSLyTsJqkGDDHUSAv8x8QX0fmQk5Fmv6+oHmIQ7LWzsu+cA
         DUwHPgVJYoAQ4+jv9lKlsQW9TH4Bii8lFHva5uc2NALU30W+1VwS9pw6ysWboRHWdHhh
         QwWF7y5XbO+2illxWitKgR2nFAmLAG9a5/9q/IABqqg7Hnd5UbunWxGl9NFe+MFuNYc1
         eOrEUvg/N+dPpdtus9K5BCrOWuGwQIHoFE8LbV2PoxBjrNXPjpS6Z5gTGg2ROWH6/GBg
         L84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747758943; x=1748363743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0PfTfMmru6XtZg7/P7iWYe3RnaZ5NwcijI/RTSpFVU=;
        b=sWcrXtNevUllrdheHJIpr5VkZFTWoxxSeHEJSvts8HCSpiDkGIz12R2Q+kRn27/GTJ
         Xg0Qs4EC4KR/+A0MWZxuwVsBCcxzLFelNmYdDKPZSK0kCZFREApjxt88FvsCLNqhOty/
         GJt1Pmd8O1BWamhBGvl3NcDGkq9Zkw2/VlvDAoQXkKdi/ODYJc0lHXqXIR75Icxg4z9d
         cxwTvpcDAFVSyAr2g/JAH+RzkP53yhjPnsCuVLyYh9Ov77sPFhLVyBdsJl6XF8cOVWdK
         13Bd6iLFbUzPWkbSyVWa6mLer1ZmX/fse8/PsvOunUrKyXn8gh2QX08TtXpuc4euPVx5
         dHWg==
X-Forwarded-Encrypted: i=1; AJvYcCXTkXUnEi0FVVeCsukrEwl+tdPJCqPxpuYtH412ErbGcchZA0qQmpoc3/6nJqNaF0UUm0OJ+Nc=@lists.linux.dev
X-Gm-Message-State: AOJu0YwkOX0TdqEnAnTudb73Gfv2m8vAQt3nJMwFw5hYZgn54dcgXK4r
	oRN2dmdzG4b1lGtCrcvQqtPerpb94g1WWCDhnuAuSVsUdxbFidYgbEGu
X-Gm-Gg: ASbGncvHZNbkce8F4FY+KVOQrv+JUdzzzrmWnGm8BuTyS8Ac0TU013OjICxYmtG7xis
	WjoRiLYMiNmlqALxFubK+RAFPSZq/oVBqSmw5OszxiRepH85vLhYMmtSoAwE2exxhUgeHvM7Qv9
	0NJxZAaljKBbix3LPfvnjVsi0MUIKEI8mYAXyVYXkOYri6VE+001OzMthG/R7Opzk+21jyTsA8E
	0nQ2X5ORzxhSUHIW7UXd8iSTdp5SCqv2Yv+ckt9YSGlaqwuEZLmhTiSW+MgpcbKRutRTzWIS8Vr
	0lOifYFZU1N7l+PnGgSHsBSi5zgh4riZ6bJwYGJvb4Py7DxyB4AErDz0NAGuEnA=
X-Google-Smtp-Source: AGHT+IH0BSz4RjlodJowlGibph9G6OBJbinuQbQBcy85MNVysOtD3B+YBfEIqxAYnCdgCYfSiR0cyw==
X-Received: by 2002:a05:600c:1f82:b0:442:dc6e:b9a6 with SMTP id 5b1f17b1804b1-442fd64e349mr192530105e9.17.1747758943067;
        Tue, 20 May 2025 09:35:43 -0700 (PDT)
Received: from localhost.localdomain ([78.172.0.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7ca2de7sm36321295e9.35.2025.05.20.09.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:35:42 -0700 (PDT)
From: Baris Can Goral <goralbaris@gmail.com>
To: oliver.sang@intel.com
Cc: acpica-devel@lists.linux.dev,
	goralbaris@gmail.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	rafael.j.wysocki@intel.com,
	robert.moore@intel.com,
	skhan@linuxfoundation.org
Subject: [PATCH acpi] Replace strncpy with strscpy
Date: Tue, 20 May 2025 19:35:40 +0300
Message-Id: <20250520163540.6893-1-goralbaris@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202505191014.718ca1d6-lkp@intel.com>
References: <202505191014.718ca1d6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Rafael I dont understand your question. This patch replaces
strncpy which is vulnerable with strscpy. As it stated in Link I shared.
It seems it works to fix somethings. Thank you for your test effort Oliver :)

Best Regards,
Baris
