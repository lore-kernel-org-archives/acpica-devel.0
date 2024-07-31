Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5D32F37
	for <acpica-devel@lists.linux.dev>; Wed, 31 Jul 2024 01:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722388477; cv=none; b=B8XfuApCO3PL8iQJJoSVrbjx7ReSOoDmGDnhG8DoiDSKn6NjFpDyB7Cl5/qvhCxBxR7LVjQMLIzwTJLvhrfWj3UTtzQsg8iM3mXXPU1J++x+WZ6CUCW5y4D9BF0Ru5YcRXERNkPS/05APZGvz0jNpWiJx94SIvyjfkPr+U3KxuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722388477; c=relaxed/simple;
	bh=Ol6fsE837BWnDsz8i/J0CfxAa59HnAGNzCu3Ne8NyJA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=UkzmMIDw1Vswq5LJrLpZiNQBuMJ6lsaiz8Mbj7BRCx1VkZM1jr2QptXt2EcVgbCbIlVbUGrxv5zFwvi8fYzjJt4Hrh0Okk1MVJ6b/ZXdYSq70V/MhCwqMxXdEemUHuFYH4ZZ+D6q3btNjNStdFYMCOmeAGJNvpXUhlaw2IaFOzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=x9VrWy/l; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="x9VrWy/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1722388468;
	bh=xmziSWrE762AJPUBIoJqWj3lQPscDyDVM+Fh5GgSVGQ=;
	h=From:To:Cc:Subject:Date;
	b=x9VrWy/lIw99tosAbX6RQWWt7sDU9LqdXIaRemsSXlYkUxywNBoWaGZj+R3zk3BAH
	 UCVDz9HaT6W/pdDu+GSOgmjReAX3ObAOXg9pYIJEtGXUZwS1yVlTA7WiieD3Gb6FB4
	 GTuMgaGsd8VpBPgdDQcPGD4dGo6bEIfGs6z9wyU0=
Received: from xp-virtual-machine.. ([39.156.73.11])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 399B164C; Wed, 31 Jul 2024 09:14:25 +0800
X-QQ-mid: xmsmtpt1722388465tnp8i6sky
Message-ID: <tencent_ADB80DA880207BBCFA4F5CE7F05CDD221409@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8rCF2OiIEIyVkqJu9N/P/cpDW5VGsn6jBXZaKkXLdvPQY0e3kb0
	 EZoSs58fF/H586O8GGLJ5IO15XPQUahdwXSVjUNTfTOrKwKXqyIWnsfFGRLS3GPbTcfIxB0tEPZR
	 AmclmZuCqPAafMYgJl1vc0If4I7ZijRTKxlZEesIEiDZ8oLa9n1PkC5v3S9E/t2HiUeUpnbrPtTF
	 Jeoq0wbPywGx3wsfOhxOD7mqy32nYnUhTywpEVABq/k4WvuiyLOCmOGDc1Bz615OsSEVB7ZbG5FL
	 ps7MrL8KykTl2NnjbHxo29xIe8Bf2XIvpKPk8lbmoEKnLlcZJXSJ/A3L9VrKXGIFgypqgzAPvGWe
	 scYpsZYObZB3grH1LuKM86Kamfsb3YQGUagnbnCWjyFF0Iht4GX2H0m82zr2NYbKI/EituEnkDnK
	 8XvcGikA76NhfaSVhkfhqlrxiPTlpinW4EUUFFzzz785h+EgQh3hXkocV/EzwvGKzBYHu8IsFn4t
	 Ni6h2WQGmWN+Rc1Wgl/guvIVt+E7nIPf1BvYE6VdSp+5Lua3+dwkFpScCMC2EuuhvypA2JPUEL4q
	 ryk/wOQS7rF0g/vh/kIKKt/0SyTgv7hDfnIOHfY0AY/xJhacPZfumaoVaWEd+jkBtUqDrhymr3Da
	 ccN8puIyboqDL+OxKFqD2lqdbcvi+7kjyqesqLDwZ9khQQYURqxJjGA87WAN2xhC86HnMICoVBuj
	 Eess7XZ3oX/stBg9s00VF2Z+jOyZiUUgIxlGZ0oWYbqYzLbsj5zJ0zl8BQr5+Bw9V0gLUrwv9PJn
	 UmpzQJcHEybx0jrvAdr2ytWBV9Lry3x70gV0KmZnzkADDrB0HYYJATk6uxED8brfNfUgj668d9nH
	 nVyH/qu0qpNOv4TOaBL4YWkyQAc9CgVw5puBaDdIqonoppWSFzLJFRZcynJlaBCCg4m1icna9hBH
	 ibR6emSWOl4hW+2Nw6SWLc+qNGAAQmT05uuiMW/P4=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: xiaopeitux@foxmail.com
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com
Cc: acpica-devel@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	xiaopei01@kylinos.cn
Subject: [PATCH] ACPI:dbconvert:check null return of ACPI_ALLOCATE_ZEROED in acpi_db_convert_to_package
Date: Wed, 31 Jul 2024 09:14:23 +0800
X-OQ-MSGID: <e4f084d1fdc3fbcab24cefcbc5f484be43dc37a8.1722388346.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

ACPI_ALLOCATE_ZEROED may fails, elements might be null and will cause
null pointer dereference later.

Link: https://github.com/acpica/acpica/commit/4d4547cf
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/acpi/acpica/dbconvert.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 2b84ac093698..a60d1098a105 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -175,6 +175,8 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	    ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
 				 sizeof(union acpi_object));
 
+	if (!elements)
+		return (AE_NO_MEMORY);
 	this = string;
 	for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
 		this = acpi_db_get_next_token(this, &next, &type);
-- 
2.34.1


No virus found
		Checked by Hillstone Network AntiVirus

