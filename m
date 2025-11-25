Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAF52D662F
	for <acpica-devel@lists.linux.dev>; Tue, 25 Nov 2025 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.35.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061683; cv=none; b=u2vsAD+2Fk4r93cXBIJzmQS8kp4GqarpJ7iyPJW+0dLOcnJ1YWWk5X19aAKPcAgFT4EIQ7+UabvLk+V0Zbgi3lYBuplqi9NxmvX/4CqEEwwYpPF5tmlTg1T1syhhAxJufnuh4ukzp4NnMLjNYlAePWp2y3KIR+AA4ejfPXSvCsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061683; c=relaxed/simple;
	bh=9vOFtqIWzazMdCPHxFRVurGLYvckDHb3NZHZdeLZqqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obCgl28PDsSKewM0JEE2qXnzpLp3FcmlJCkmsADf/9/QE33Of09bdT6EaO81rSpeDvZ3G5e5DMBifGbrnxqOOlpbWjCsUUEKtQpYEP+OqYbOX43Rolgvfcj9ZVadCt8w87dr6kiehEHR8MR/2e/f7/ul5G/J+pPQfGGYdXmvzOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=A9CQTr4R; arc=none smtp.client-ip=51.81.35.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="A9CQTr4R"
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 63C762020D
	for <acpica-devel@lists.linux.dev>; Tue, 25 Nov 2025 09:01:19 +0000 (UTC)
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [149.56.97.132])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 88FE8260DB
	for <acpica-devel@lists.linux.dev>; Tue, 25 Nov 2025 09:01:10 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id 5F5413E859;
	Tue, 25 Nov 2025 09:01:03 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 0CD8E40135;
	Tue, 25 Nov 2025 09:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1764061257; bh=9vOFtqIWzazMdCPHxFRVurGLYvckDHb3NZHZdeLZqqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A9CQTr4RQKvaddo6OBu9PNAQdnFH7IEzl/BdXdBL4AsiYh5Cbuc5cEh9UWjOWWU75
	 XZT5iA6L/bEAuAJlts3sNjH1cjfm1ZcV23i/AuExWh5yjs+SfuSUdw6Jk6CxnLeC3u
	 Fq7DSvvYsChknsaeABuvkamilUbs5cKcw/R8SYFs=
Received: from avenger-XINGYAO-Series (unknown [39.144.78.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 0CBBA436FA;
	Tue, 25 Nov 2025 09:00:43 +0000 (UTC)
From: WangYuli <wangyuli@aosc.io>
To: cryolitia.pukngae@linux.dev
Cc: acpica-devel@lists.linux.dev,
	cryolitia@deepin.org,
	guanwentao@uniontech.com,
	jeffbai@aosc.io,
	kexybiscuit@aosc.io,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	niecheng1@uniontech.com,
	rafael@kernel.org,
	robert.moore@intel.com,
	zhanjun@uniontech.com,
	WangYuli <wangyl5933@chinaunicom.cn>
Subject: Re: [PATCH] ACPICA: Avoid walking the Namespace if StartNode is NULL
Date: Tue, 25 Nov 2025 17:00:26 +0800
Message-ID: <20251125090026.373878-1-wangyuli@aosc.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125-acpica-v1-1-99e63b1b25f8@linux.dev>
References: <20251125-acpica-v1-1-99e63b1b25f8@linux.dev>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0CD8E40135
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [1.40 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	RCVD_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[chinaunicom.cn:query timed out];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[wangyl5933.chinaunicom.cn:server fail];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[wangyl5933.chinaunicom.cn:query timed out];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action

Great!

Reviewed-by: WangYuli <wangyl5933@chinaunicom.cn>

Thanks,
---
WangYuli
