Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625159;
	b=JZY6r18W1sn7YemVdQtx+qzsjMQKNXAxTl9w0PYEsyAU6ixpesHl1i7avyyPOG0vsHmy
	 YAn6vGbVnIos+2Kov1uLoULib5fuwkLnfcLZue4LoCGzK6jNAbXT0MOqtrq73RbhjZ9SF
	 SKT6kgfrXNtkAFIxzCOI72teuNbUS28IHLfxlIV5Lf/gWaLbF77PLNcEknUG22iNyydDf
	 i1xkdiS+1MPOxHONTR6LJbY0+D24+NXbCcNdwlwl9QH2Gv+6AN0EsXx+n+lw51MjwlT10
	 kXbv5jt0fe+cdb/IumtqaUe470andkf0Fwe8+gKqdjazD9XzH8W3OZI3UsLlEghga1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625159;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7Ofy+nGZGG5GjSQ/p9hjatkioBWd7QndibG1/NjdTig=;
	b=3YxvcJ3iuot4Uxuzgw8nNUKPt/yJLYDnOdZPKWVbfhNd9/8Nyy9kBxOdFxvdiC2fLZF2
	 kAVo1a1K9Glgg4ZmC8CGoAktRykxEaGxQGy9WPax0h9U/7fbplZWru+FeoWevMQRxZJqf
	 bpELKnF5AeQuq21P+C8jQkJczAI6WS4+Ix5WApaLHsLzx8S1y8lloyLvX5fsLom1Zwep3
	 HzRQnU5n6rib1L24nk8MkaMMYO8/ft4HGNCSADWtghOzuyEuAOo7KTS8P1wTN3o4KrW8R
	 tYyLGU9Kbt/o9WYZI362MKHntaCfUT+LY8KpiaI9S8JtCVSV2N+eyPUdDUrOwtfSVzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FnbISpxn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A97606A321
	for <acpica-devel@lists.linux.dev>; Wed, 25 Nov 2026 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FnbISpxn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4371F000E0
	for <acpica-devel@lists.linux.dev>; Wed, 25 Nov 2026 16:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625158;
	bh=7Ofy+nGZGG5GjSQ/p9hjatkioBWd7QndibG1/NjdTig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FnbISpxnsBf8m0U3xd/OLVl7vxIJAa+9YONUmKpGpEnWKMf08r9xzEpHz/jgp+Wy3
	 hYR8DcSI4C7QgnHZRVTeRA9aG7YpFTOQgXH1pXIwyOSyFwFK5C767S+VcEkIW08ND0
	 47idpSLK+NeC5zqL5mCSMA7g14tj2hVsBJfvpe1ltsneuxkdau490DpgLtvhx013XE
	 kDhjEtwauDJ/g0dIqATs0tWCLtpR9E1aj1ZNY7PA0IRgazQTx/XDU4o7GDyyC3KGuq
	 um/ULeytSQIBUQwk/zXNaYoYOZde63xfl2rgQuHFI6SBJTnyoUMa/R6dphUCShnUWs
	 nTnEf1w8hLE0A==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5c14470729eso5568029e87.2
        for <acpica-devel@lists.linux.dev>; Wed, 25 Nov 2026 08:45:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFHNdIR5yiIOBgYx8SvOJusWxO0fJ8MrjPxDIT8CPfL6v0hjOYUZG6Zpti2JBNwXvroq1Qk85SsNRtPpVs=@lists.linux.dev
X-Gm-Message-State: APuU4Z+offv2HSPOn4V18noUNpWqZ/E5to06MytrFaRmMd3uojCDb3Mq
	yWeXOP9Gq8nVESF+2O4ijGG8F4soGcU2cxXKf9YAfmjxJyuS/nDm/QD3SHa5YDw6i5RCeC/RDxB
	iwJJVxJamoEk65Fvkclx4ur5wwAlIRjQ=
X-Received: by 2002:a05:6512:401c:b0:5c1:ad4b:4be7 with SMTP id
 2adb3069b0e04-5c1bc7d00aamr5425949e87.20.1795625156701; Wed, 25 Nov 2026
 08:45:56 -0800 (PST)
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
In-Reply-To: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 25 Nov 2026 17:45:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hUQBr0k3GNqf2t118nRZnBS_Chw4NJXA+j501Bf=AEGQ@mail.gmail.com>
X-Gm-Features: Aa3M54qST7obZ3zrfYaLQiJELeljnYeJDcQKh7-DXwYZlMnrrNHk2B9oFBxFD3s
Message-ID: <CAJZ5v0hUQBr0k3GNqf2t118nRZnBS_Chw4NJXA+j501Bf=AEGQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/42] ACPICA: ACPICA 20260930 with follow-up fixes
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: catalin.marinas@arm.com, pawel.chmielewski@intel.com, 
	kyle.d.pelton@intel.com, lenb@kernel.org, guohanjun@huawei.com, 
	maobibo@loongson.cn, lpieralisi@kernel.org, will@kernel.org, 
	sudeep.holla@kernel.org, erik.kaneda@intel.com, rafael@kernel.org, 
	robert.moore@intel.com, void0red@gmail.com, superm1@kernel.org, 
	chenhuacai@kernel.org, acpica-devel@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 6:18=E2=80=AFPM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> The following patches are ported from upstream ACPICA and contain the 202=
60930
> release and some follow up fixes (so generally everything after the 20260=
408
> release). Only source files relevant to the Linux kernel are being ported=
.
>
> Changes since v1:
> v1 [1] contained only commits between the 20260408 and 20260930 releases.
> However sashiko.dev [2] raised some issues that needed to be either appli=
ed or
> rejected. Most issues were valid and were resolved in patches that follow=
 the
> 20260930 release. Things that were rejected were the whole patch [3] due =
to not
> being a full solution to a very unlikely, debug only problem. Also the sa=
shiko
> comment related to ACPI_GPE_AUTO_ENABLED in patch [4] wasn't applied due =
to
> not being realistically possible to happen and consequences were only an =
odd
> looking log entry.
>
> There are non-ACPICA changes related to constants/variable name changes
> in these patches:
> - ACPICA: actbl2: MPAM: adapt to MPAM ACPI spec v3.1
> - ACPICA: acpica: Fix typo in the IOVT_IOMMU table definitions
>
> The base for this patches is upstream kernel v7.4-rc3 and it consists of
> the following material:
>
> Andre Przywara (1):
>       ACPICA: actbl2: MPAM: adapt to MPAM ACPI spec v3.1
>
> Colin Ian King (2):
>       ACPICA: components: Fix typo "Supress" -> "Suppress"
>       ACPICA: components: Fix typo: "numer" -> "number"
>
> Dave Jiang (2):
>       ACPICA: CEDT: RDPAS: Add missing reserved field in RDPAS structure
>       ACPICA: CEDT: RDPAS: Fix incorrect field positions for RDPAS
>
> Hanjun Guo (1):
>       ACPICA: add UBRT (UnifiedBus Root Table) definitions
>
> Himanshu Chauhan (1):
>       ACPICA: Introduce a new HEST notification type for RISC-V SSE event=
s
>
> Iurii Trukhin (1):
>       ACPICA: parser: Fix parse tree memory leak on AML execution error u=
nwind
>
> Leonard Lausen (1):
>       ACPICA: Executer: Resolve package index references used as integer =
operands
>
> Maciej Strozek (1):
>       ACPICA: Utilities: Fix for AcpiUtVerifyChecksum warning display
>
> Maciej Wieczor-Retman (17):
>       ACPICA: executer: Fix NULL pointer dereference in AcpiExStoreObject=
ToIndex()
>       ACPICA: compiler: Add _Ixx GPE object
>       ACPICA: namespace: Fix possible underflow and NULL pointer derefere=
nce
>       ACPICA: iASL: Fix the truncated count of external control methods
>       ACPICA: release: Update version to 20260930
>       ACPICA: events: Add missing event mutex to AcpiEvClearGpeDispatchBy=
Owner()
>       ACPICA: events: Remove redundant code
>       ACPICA: events: Fix AcpiEvClearGpeDispatchByOwner handler type proc=
essing
>       ACPICA: events: Fix GPE cleanup return after changing program state
>       ACPICA: events: Handle GPEs' Notify dispatch type
>       ACPICA: tables: Fix wrong table unload and notify call order
>       ACPICA: tables: Fix global table read missing mutex
>       ACPICA: executer: Fix copying PCC source buffer data
>       ACPICA: dispatcher: Fix zero size non-NULL PCC buffer pointer
>       ACPICA: utilities: Clear NextObject so the outer loop doesn't read =
it
>       ACPICA: namespace: Fix memory leak around compiler alias flag
>       ACPICA: acpica: Fix typo in the IOVT_IOMMU table definitions
>
> Mario Limonciello (AMD) (1):
>       ACPICA: Add ACPI_MSG_DEBUG to set KERN_DEBUG for debug output
>
> Pawel Chmielewski (3):
>       ACPICA: ACPI 6.5 Add support for the MISC table
>       ACPICA: iASL: Complete KEYP support
>       ACPICA: tables: Fix table buffer leak when Load fails verification
>
> Rong Zhang (1):
>       ACPICA: parser: Set AML length for bytelist
>
> Vidya Sagar (1):
>       ACPICA: IORT: Add Root Complex PASID Flags field
>
> ikaros (8):
>       ACPICA: Events: Clear GPE dispatch by owner during table unload
>       ACPICA: executer: Add bounds checking for PCC field read access
>       ACPICA: Validate 4-char field names before namespace lookup
>       ACPICA: Improve error handling in table loading process
>       ACPICA: executer: Add bounds checking for PCC field write access
>       ACPICA: tables: Fix heap-buffer-overflow in AcpiTbFindTable
>       ACPICA: Fix object reference update to skip non-local notify types
>       ACPICA: namespace: Recognize alias node types in detach
>
> purofle (1):
>       ACPICA: fix: build error with gcc 16: unused-but-set-variable
>
> [1] https://lore.kernel.org/all/20261020141051.2194123-1-pawel.chmielewsk=
i@intel.com/
> [2] https://sashiko.dev/#/patchset/20261020141051.2194123-1-pawel.chmiele=
wski%40intel.com
> [3] https://sashiko.dev/#/message/20261020141051.2194123-9-pawel.chmielew=
ski%40intel.com
> [4] https://sashiko.dev/#/patchset/20261020141051.2194123-1-pawel.chmiele=
wski%40intel.com?part=3D7
>
> Andre Przywara (1):
>   ACPICA: actbl2: MPAM: adapt to MPAM ACPI spec v3.1
>
> Colin Ian King (2):
>   ACPICA: components: Fix typo "Supress" -> "Suppress"
>   ACPICA: components: Fix typo: "numer" -> "number"
>
> Dave Jiang (2):
>   ACPICA: CEDT: RDPAS: Add missing reserved field in RDPAS structure
>   ACPICA: CEDT: RDPAS: Fix incorrect field positions for RDPAS
>
> Hanjun Guo (1):
>   ACPICA: add UBRT (UnifiedBus Root Table) definitions
>
> Himanshu Chauhan (1):
>   ACPICA: Introduce a new HEST notification type for RISC-V SSE events
>
> Iurii Trukhin (1):
>   ACPICA: parser: Fix parse tree memory leak on AML execution error
>     unwind
>
> Leonard Lausen (1):
>   ACPICA: Executer: Resolve package index references used as integer
>     operands
>
> Maciej Strozek (1):
>   ACPICA: Utilities: Fix for AcpiUtVerifyChecksum warning display
>
> Maciej Wieczor-Retman (17):
>   ACPICA: executer: Fix NULL pointer dereference in
>     AcpiExStoreObjectToIndex()
>   ACPICA: compiler: Add _Ixx GPE object
>   ACPICA: namespace: Fix possible underflow and NULL pointer dereference
>   ACPICA: iASL: Fix the truncated count of external control methods
>   ACPICA: release: Update version to 20260930
>   ACPICA: events: Add missing event mutex to
>     AcpiEvClearGpeDispatchByOwner()
>   ACPICA: events: Remove redundant code
>   ACPICA: events: Fix AcpiEvClearGpeDispatchByOwner handler type
>     processing
>   ACPICA: events: Fix GPE cleanup return after changing program state
>   ACPICA: events: Handle GPEs' Notify dispatch type
>   ACPICA: tables: Fix wrong table unload and notify call order
>   ACPICA: tables: Fix global table read missing mutex
>   ACPICA: executer: Fix copying PCC source buffer data
>   ACPICA: dispatcher: Fix zero size non-NULL PCC buffer pointer
>   ACPICA: utilities: Clear NextObject so the outer loop doesn't read it
>   ACPICA: namespace: Fix memory leak around compiler alias flag
>   ACPICA: acpica: Fix typo in the IOVT_IOMMU table definitions
>
> Mario Limonciello (AMD) (1):
>   ACPICA: Add ACPI_MSG_DEBUG to set KERN_DEBUG for debug output
>
> Pawel Chmielewski (3):
>   ACPICA: ACPI 6.5 Add support for the MISC table
>   ACPICA: iASL: Complete KEYP support
>   ACPICA: tables: Fix table buffer leak when Load fails verification
>
> Rong Zhang (1):
>   ACPICA: parser: Set AML length for bytelist
>
> Vidya Sagar (1):
>   ACPICA: IORT: Add Root Complex PASID Flags field
>
> ikaros (8):
>   ACPICA: Events: Clear GPE dispatch by owner during table unload
>   ACPICA: executer: Add bounds checking for PCC field read access
>   ACPICA: Validate 4-char field names before namespace lookup
>   ACPICA: Improve error handling in table loading process
>   ACPICA: executer: Add bounds checking for PCC field write access
>   ACPICA: tables: Fix heap-buffer-overflow in AcpiTbFindTable
>   ACPICA: Fix object reference update to skip non-local notify types
>   ACPICA: namespace: Recognize alias node types in detach
>
> purofle (1):
>   ACPICA: fix: build error with gcc 16: unused-but-set-variable
>
>  drivers/acpi/acpica/acevents.h  |   4 +
>  drivers/acpi/acpica/acglobal.h  |   2 +-
>  drivers/acpi/acpica/acpredef.h  |   1 +
>  drivers/acpi/acpica/acutils.h   |   3 +
>  drivers/acpi/acpica/dsfield.c   |  24 +++
>  drivers/acpi/acpica/evgpe.c     | 355 ++++++++++++++++++++++++++++++++
>  drivers/acpi/acpica/exconfig.c  |   3 +-
>  drivers/acpi/acpica/exconvrt.c  |   4 +-
>  drivers/acpi/acpica/exfield.c   | 105 +++++++---
>  drivers/acpi/acpica/exresop.c   |  26 +++
>  drivers/acpi/acpica/exstore.c   |  20 +-
>  drivers/acpi/acpica/extrace.c   |   2 +-
>  drivers/acpi/acpica/nsaccess.c  |   2 +-
>  drivers/acpi/acpica/nsobject.c  |   7 +-
>  drivers/acpi/acpica/nsxfname.c  |   8 +
>  drivers/acpi/acpica/psargs.c    |   8 +-
>  drivers/acpi/acpica/psloop.c    |   5 +-
>  drivers/acpi/acpica/psobject.c  |   1 -
>  drivers/acpi/acpica/psparse.c   |  16 +-
>  drivers/acpi/acpica/tbdata.c    |  32 ++-
>  drivers/acpi/acpica/tbfind.c    |  16 +-
>  drivers/acpi/acpica/utcksum.c   |   3 +-
>  drivers/acpi/acpica/utdebug.c   |   9 +-
>  drivers/acpi/acpica/utdelete.c  |   5 +
>  drivers/acpi/arm64/mpam.c       |   6 +-
>  drivers/acpi/loongarch/iovt.c   |   6 +-
>  include/acpi/acpixf.h           |   2 +-
>  include/acpi/actbl1.h           |   6 +-
>  include/acpi/actbl2.h           | 200 +++++++++++++++++-
>  include/acpi/platform/aclinux.h |   1 +
>  30 files changed, 811 insertions(+), 71 deletions(-)
>
> --

Whole series applied as 7.5 material, thanks!
