Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421822;
	b=udaSbNDrRCLV9aSaac8ut8Q2xwWOsrlImQu+lhLpDpvwmT7BxjsyegKZMokU3PAD1txb
	 gaGXUL4l4DPkFAxy7F+O4IstVAdoVeB29QhWU6WdVpKF8iqVq34biTpJ19w9uqQweWa79
	 VmCpTTc6/3PGlDTFtpq5zU+RCtqdh+eOEChv7Y3M04HiUTkTrG/ntn+t+T/Psf3+vqkhl
	 7kaO6uMZ9MaacXbxUPJjUeR3go+IKz6eEBGtSsQCoQc0vARmhPzeQRnFR6PqQLkBq+vWh
	 uBnbcpyUgCeEJzMqSOeNL4iny3UeD+2vtB+DpdpCnp7/JsXmYQSkX+0nlMiGcCU0i0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421822;
	h=Received:Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=XFFhmkzN3gCpAVV9wNJFrGK2My1XuAXj1fxImpVBK8k=;
	b=iG7jbmBNWSMnn/leWJov0BGQ6O0XQqtv1qWDPXnWGqKloW61CAuIi8KPALccjTk9pQWy
	 EUzs7USKpRguUy/G2M0qYvYUJnAH3Hwn1u6VON48KhR86deRUNz+pbiMd6vaGZY4N6OGV
	 0NPlouOOHT45OQ65e7eiaVvY3Fim5G2L4HGnm2O+iv6vLTE2LPNTS6ioCUU77zE1aFbso
	 yvIj3dpq35Fhy7mjxa44b4fO8y0mDrWZQkqXZUmj0UN8UsDxuoDJa/qHMhZDGVYgMCK+v
	 gqBWX85B/SMy8gO1xipltiyp/2aUz9VarETis2KUEO5uuueyjTSsCmdEYI6jZ2iOAdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PV9btGXP;
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BD3607408F
	for <acpica-devel.lists.linux.dev@localhost.mlmmj>; Mon, 19 Oct 2026 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PV9btGXP
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A06353A72
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421822; cv=none; b=tLJI0XFjgrbHSfVKqAiiYrsl1UcoDkeIkhMCg8grs7QA33twm/P6Hn6S/6j3rISmwPauAuctmFqFxCb/iUFZXqLArvnVSiX7yG9olhHuGWaPA/7HVI4aMi5lnHTeeEvnigkl5isymNvtg364Np0mibO97O0zd53ZgY3J5+Sg5Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421822; c=relaxed/simple;
	bh=wstiMUuPit29XB21u72+Sm9cipTaJpB6vDxcGcOze1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P371awcMjGWSiA2es/VRMNTvVHWcJIX51AaZW+sOQ7+IfhavU1M6riri+M5YAS1hg22vqfApo7T9r0opy36IeLzwpwnmClnfvAuz6VGIssg+zrvVaFnvUqBZxflM6P3t61jiDZzaRkJWQVwynSzkA0m/o+pchkPjiJ5UX+rGHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PV9btGXP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CEB31682;
	Mon, 19 Oct 2026 07:56:56 -0700 (PDT)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.131])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7C98F3F673;
	Mon, 19 Oct 2026 07:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792421819; bh=wstiMUuPit29XB21u72+Sm9cipTaJpB6vDxcGcOze1Y=;
	h=From:To:Cc:Subject:Date:From;
	b=PV9btGXPW0TQosrp57rBn61aSnEngvPMA1lmEZ+6U2btLHX4uWQIxUZu+zPNw+d0L
	 BiMzgeElPDm7ulf/S1KMvYNrhX1bzSLNQ/4bJtdB7oKylU2tpBI2R1BmPbiEECRQAj
	 2Yj3fv/A9UJz4KDiQCT9PrO8wcl4O29jAZGa+yEM=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH 0/6] CPER: Add Memory Error Section 2 support
Date: Mon, 19 Oct 2026 16:56:07 +0200
Message-ID: <20261019145643.1877246-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
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

The support is mostly duplicated from Memory Error Section handling.
Other than differences coming from the content of  Memory Error
Section 1 and 2, differences in the support are:

- v2 do not rely on a compact "struct cper_mem_err_compact" struct.
This structure was used to support older versions of the Memory
Error Section (1). This is not needed for the new structure.

- The compact version is also used by the tracing framework.
To avoid relying and propagating a non-standard record format,
through trace event (cf. extlog_mem event) the new trace event
prints each field individually.

The last patch of the serie was only build-tested due to the
absence of relevant hardware. apei_mce_report_mem_error() and
arch_apei_report_mem_error() implementations were also removed since
last version.

It will also require a proper handling from the rasdaemon. Applying
this last patch without rasdaemon support will silent the reports of
Memory Error Section 2 error, cf. ras_userspace_consumers() check.

RFC: https://lore.kernel.org/all/20260929074659.2587216-1-pierre.gondois@arm.com/#t

Pierre Gondois (6):
  ACPI: extlog: fix extlog_mem_event build issue
  cper: add Memory Error Section 2 structures
  cper: use BIT_ULL() for processor and memory validation bits
  cper: add helpers to handle Memory Error Section 2
  ACPI: APEI: add separate Memory Error Section 2 handlers
  ACPI: extlog: add Memory Error Section 2 trace event

 drivers/acpi/acpi_extlog.c  |  30 +++++++-
 drivers/acpi/apei/ghes.c    |  49 +++++++++++-
 drivers/edac/ghes_edac.c    | 150 ++++++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper.c | 108 ++++++++++++++++++++++++++
 drivers/ras/ras.c           |   1 +
 include/acpi/ghes.h         |   2 +
 include/linux/cper.h        | 129 ++++++++++++++++++++++---------
 include/ras/ras_event.h     | 102 ++++++++++++++++++++++++
 8 files changed, 532 insertions(+), 39 deletions(-)

--
2.43.0
