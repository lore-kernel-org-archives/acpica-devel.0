Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421678;
	b=XTBN/uXJSH/GEF1sqgJo+fk6hF2IKHrDuYuriZcAcOmcxR2zOCsWOniKZcewb93JTfTn
	 t98El76gvaoaHyxMibfx7FRphLxmrNh3w9n7wEw2CDUrGAfotLvj2REhy8+4UxdSvY0OI
	 8q0IncLBqIs1Uxfl2hk5NF1oVDM0cCp0+8TQ+bN3uHjbYGMfVr3pwzymF2jon4KT2+ZqN
	 Xiauv7NZlwPm+jusoyo95hPj/AOFJjP9QkVB7n85/Od/lUEc+DPlKsGPYrZfLBsl3ebyP
	 VibZsAOHwZ6dNVtgTEfD0rC6U+jHxcPG5m6kpWV+7kZfUiefPNAhwxOvEX/aek4IYRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421678;
	h=Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Bar:X-Rspamd-Report:X-Rspamd-Score:
	 DKIM-Signature;
	bh=xOumFf8QovRxhD1eGGAGpu54ZcAWxs2MC729deNVVtU=;
	b=TU/kQDi3RPI28wZ+6nvfZrG2oIVNJGwLroWv7KUtQRdhVO6bEcKlYkTltGEBQnRuj2E8
	 +WiEbngtTTBYkwma4PZifOKrbuUuq4MkWlEUigb6VoXHijDzseMcNSNGQR/9ZuqIdG8i8
	 1FvmUYC8WAajW9WloBG1YyTY+hqK9GTaDpwXXDVJw0T9f0VljtQqT/4F5hNzSkd0qe0dt
	 tn/F9D1lf6CFkFJBVB4LF4jdQUnong/RaWDsicUTGai38TjG2DVPxbOPGDAKO7ildIYk8
	 hqOk1SvwvJHIy35EEUon9vlwjDUhtYDcomTjBYo9tmF87ggwMEayqPThuQguaKaA4Ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=lausen.nl header.i=@lausen.nl header.a=rsa-sha256 header.s=uberspace header.b=G34Zwobk;
	dmarc=pass header.from=lausen.nl;
	spf=pass smtp.mailfrom=lausen.nl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802BC606DA75
	for <acpica-devel.lists.linux.dev@localhost.mlmmj>; Mon, 19 Oct 2026 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=lausen.nl header.i=@lausen.nl header.a=rsa-sha256 header.s=uberspace header.b=G34Zwobk
Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D152F4C4604
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421678; cv=none; b=lgikfT6EbBVKOUslH+dlp+gnpuNcZWUQlvMdqYCsDRV+0o/FW+wFpRZ7EfurpuTzR7Zg5DXtYSknGSP+HQY8l1zjsI7aUGCDmjkJCpJkjIPGLj7SW9nQnn89HIVhXjB45+QsPOT4gTEEBGY0By+DptNmE75YAipoQXj1bazH9FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421678; c=relaxed/simple;
	bh=Hipy/KE3TsEelU94kP3nCg+Z58+mCcvF4l6Qeuvkmms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EO09gdI20sJDNtCctVxH1mNhisFEfbMIiM+2Z2vOGNSsL957hM7Vhd+jaZ6JOegCt8dTEs/SYnikEzDaBHf5E6MnUPLAuqjwJqjVT/wTtUeNVfy0oAwiqRPORALAxQUTkC9YQ61dWO7p5VhJrxCyXvqV9hsdOfG4rcpe3diY4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl; spf=pass smtp.mailfrom=lausen.nl; dkim=pass (4096-bit key) header.d=lausen.nl header.i=@lausen.nl header.b=G34Zwobk; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lausen.nl
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 3B8856112A
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 16:54:35 +0200 (CEST)
Received: (qmail 28350 invoked by uid 990); 19 Oct 2026 14:54:35 -0000
Authentication-Results: devico.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by devico.uberspace.de (Haraka/3.1.1) with ESMTPSA; Mon, 19 Oct 2026 16:54:34 +0200
From: Leonard Lausen <leonard@lausen.nl>
To: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: leonard@lausen.nl,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	acpica-devel@lists.linux.dev,
	Len Brown <lenb@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Ivan Hu <ivan.hu@canonical.com>,
	Joshua Grisham <josh@joshuagrisham.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ACPICA: Initialize ParserState.AmlEnd in AcpiInstallMethod
Date: Mon, 19 Oct 2026 16:54:17 +0200
Message-ID: <20261019145421.47181-2-leonard@lausen.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019145421.47181-1-leonard@lausen.nl>
References: <20261019145421.47181-1-leonard@lausen.nl>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.97699) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.57699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lausen.nl; s=uberspace;
	h=from:to:cc:subject:date;
	bh=Hipy/KE3TsEelU94kP3nCg+Z58+mCcvF4l6Qeuvkmms=;
	b=G34Zwobk7+jTQBscFXiVl0wGO6Tg694XtvV7EdCgNByMswpXAAHkC/NWoS2OHCCmmc4Wx9aC08
	f9GuU5l6gfqtWFwQ/elECYEZhu1HPdedLFG/2IeOv0gmoTaz/n76FjaNvQbblViulMw+UOVgzcRz
	20ndPfGyGVhYSuYRc/QmLtVRwr3ZZZnSYHsjedOTyC6LnyUu5eEtkWtSEND+7ZOe+omi6z7KIooQ
	wroZrKtbzgISr/hCm7jRhUhIV1R9KfsO16VzW69N48yJlIkCWuM/61tte2qrzzEdkVtoxDwurYok
	w1alnWRJN1rAqFA3JJGyzK5G5CgpoTMugQnarBVGA+uIdYlKL1K6Uz2LqiFxAZtgw0IcruSiW669
	4An0xXHOJb8/W9hTbNYzlNCNLuLfdaKUstzBI03uSKQJ3Y+XSMw1Hd/2/vPnjLmbOQQNZpGfTrrh
	s+qkcFWI9mIqZmk9Smxjc578MaAHK2c5ikFCUhmEuQa1YXVZsX52pNCHvz8SMwGX47oWWhXmJl6F
	uf3WoBUzgjhXqt1pdehm0q0TyAZVuZaexC/4VZq/idZ7tcvgH1TLaIH/HsfyYoR0495PxzyyvTrE
	9oep4yW+QlozYICzBmA84E4GO20dkv9dJQSw2kE+56GZ3Ra8XLmUnHkcch3gSOxSi/Guu6+KbAAm
	8=

From: Ivan Hu <ivan.hu@canonical.com>

In AcpiInstallMethod(), the local ParserState is stack-allocated and
only ParserState.Aml was initialized. Parser helpers called by this path
read ParserState.AmlEnd for bounds checking: AcpiPsPeekOpcode() reads it
before validating the first AML opcode, and AcpiPsGetNextPackageEnd()
reads it indirectly via AcpiPsGetNextPackageLength(). The subsequent
package-limit check also compares against ParserState.AmlEnd. Because
AmlEnd was never set, these checks operated on an uninitialized value,
which Coverity flagged as an uninitialized read (CID 1684785) and which
could lead to incorrect parser bounds decisions.

Coverity report:

*** CID 1684785:         Memory - illegal accesses  (UNINIT)
/src/acpica/source/components/namespace/nsxfname.c: 712             in AcpiInstallMethod()
        ParserState.Aml += AcpiPsGetOpcodeSize (Opcode);
>>>     CID 1684785:         Memory - illegal accesses  (UNINIT)
>>>     Using uninitialized value "ParserState.AmlEnd" when calling
        "AcpiPsGetNextPackageEnd".
        ParserState.PkgEnd = AcpiPsGetNextPackageEnd (&ParserState);

Initialize ParserState.AmlEnd to the end of the table
(Buffer + Table->Length) so the parser bounds checks operate on a valid
limit.

Link: https://github.com/open-acpica/acpica/commit/19429ef91ebfb2144c918038dce13e297b4ef051
Fixes: bdc357540129 ("ACPICA: add boundary checks in two places")
Signed-off-by: Ivan Hu <ivan.hu@canonical.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Leonard Lausen <leonard@lausen.nl>
---
 drivers/acpi/acpica/nsxfname.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index b6534187cd43..fcd94947fedb 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -503,6 +503,7 @@ acpi_status acpi_install_method(u8 *buffer)
 	/* First AML opcode in the table must be a control method */
 
 	parser_state.aml = buffer + sizeof(struct acpi_table_header);
+	parser_state.aml_end = buffer + table->length;
 	opcode = acpi_ps_peek_opcode(&parser_state);
 	if (opcode != AML_METHOD_OP) {
 		return (AE_BAD_PARAMETER);
-- 
2.55.0

