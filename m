Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F14439354
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235499; cv=none; b=elsiTgFwPv4Rc0JSsplbGVj5II/EUzQn76Ypw36c6mJ9OZtd/FT+32uZ20bQfnsDTfUPzP+fOJqHO7IU/oP+IdLaI45lBjDcpdMQNVWrhusvd/iHf6DE8ctbtpFgvsmlgmf2+7OOEE9EomzcLWqlQIHxzLBH8SdJ3zSz7ToszH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235499; c=relaxed/simple;
	bh=IPDczm67WB9cdss4DG7r4mgvBThj4nInB+DV/41f8tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPSUCSQbTfy25G9C3zzIum3wNXkSSoh0RL8lp0BcRK9TyEdvd73vkNVHKcTBWkAO0xGMopR7vmicSrO6Ar6woRnwGhc7eFU9SM1LRF3JdHJe6jh+DCmRAXC1ROBqUWQlAR0zWI+vx33NcIaYu0NJFT46qervHnAhbzIAwF38cZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZBLfErtj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N+opQB04; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZBLfErtj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N+opQB04"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5eRcw1278472
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=c4sUVCmmjjo
	/P0eMok8JUuO6sZJCdXw8PrIwaTMTfUA=; b=ZBLfErtjnHbpJBbL2C3TJnOe6dC
	rnrCo7Njc0NBxWlfBgH3egh5mSCMfCi72t6i+zCk+AEp711U7KE9VOV0nN9PzMY9
	HgMn4Drml+qLliqS3z5jQdWXo5MVVXhhS0Jg2sAgVWbnylsdfmUsGaL5n0jdEeWi
	wJYEJDAelI4PCLyCrbPjyk2b242HOqHdau7MfxrctdkRl5nNfAS49wyu+g9klAib
	88w7retfxiU0dHd6Zrywd6pZPGn2ZeQHbLj3qH/4Ip+S7vfekM6wcUfB0KgEjVxW
	TCChsOlO0SekmYqLNZjo4QS7M1DfHcTOUgT4hlivSPT/puQ7W7w46YDLmFA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvhsb37xj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:38:16 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30f1b904861so2472452eec.0
        for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 00:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790235495; x=1790840295; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c4sUVCmmjjo/P0eMok8JUuO6sZJCdXw8PrIwaTMTfUA=;
        b=N+opQB04B+8QhGqzmdxJkbLKrdjiZGftZgTPJ7o+gTCYTOpIv5tKAnYCxNYL9t1pX/
         QvbPFGgvB9qarkoxmreEwOv2dsiI2L9DQeZyKByc8yQiKyV3K/7pOfa5ZVS6q61doZpR
         CQey9zA3GaqO2Kct+xCoZumKXOIH3x2r3/4ogHgNLde0bos/Sus2vBIMFFazIukDGIHM
         TWQH6gLR2HJLzax9CSvwlbIrQcSe210sm42GNFqROp1hLBtriBlRFgWdgn2kf3fYqoX8
         xJ0w/4hLJOywqiSCxhJsKW6G+U/vwTROE7wmDkR+w9Pz7OMH9beeFQCwQ0frvb6RYgQX
         MZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235495; x=1790840295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c4sUVCmmjjo/P0eMok8JUuO6sZJCdXw8PrIwaTMTfUA=;
        b=MvkapqGhgglIjT9Zz3mJtaJNyZXA9au8Gr9cCaJcAHyGJm4HzNPlWD30M41/HugL3e
         0/NEgWn0+GnCUiueDmWUNcZ1GcwsRuJ/ASwDYWmzLwOuA1epL+08w6i9mVh3ZSjMq8Dt
         AU6ZFpTKElDmqTNtjOOanQo88wuXr0xL+LUEg/XSMdLhbmcIewhj09DmEe2bQvCeCJhP
         pzTV9gTZRXzbFb0DYioEmdPNUIRXB3GTadUQ/bwahnRcvbtk2XkknKl8KATYwXqGAQss
         7c8cM5AtACWZ9k+4Hj0beTxFV0WIaLLirKsTHITcepBl/b6OgC0ZXin1ScUZ/HyF93wM
         iAlg==
X-Gm-Message-State: AFuF++n/4MNB2JTXprdGDhUzrpXTbjKyKRDHRx2EyEc/YW1x7WcAqwMa
	nX0kaAJvqGMdKTZUmeK6HcosOP9XRbTovrCvxjj6JEdcDqPTdGsAQYII8Pv0qEzveW9VdWSYBiy
	3PY++EC56oKVmbntRGEWW5JGPvqxnwy2hd9bOT2wl7+rbWIqUSagXvSIkFMhQ8x0LJ+8=
X-Gm-Gg: AYBFou1fOvZaZtc6LEocDFs0tk5+41djuBVyzAktk3YRp5ymZf9Xy2Wagi4CY3gPNgd
	kEksLzEKvZZCp1H5OSIdwsZUttCxxW0gTw1mQlRT72Sa+iRvZTeF/pnSqj9DCoqcX4Cmxm8VKZK
	jqQhwDSw67QAiW87l50Sp8CCzps+dxgSeLwQoZvSDCOady20q0ak4bw+5E9TyBn4KDMwpUoaIZV
	GWcTBS0WyTQ6t+QqODQdV3oX9p44GzxF3lDruE29mZzK5qWWvqqh15OGKBZZRaFnHuPGwcwPy5q
	U68X2Rp2EMvashb3DM0bu6wzkFuhvdCsNpeyDor8y8axLjbRJnj+gI+T/KyU3njOxzjjbW3Gmww
	j9FII+E12F5iZAzQaE8WACcCeKHCebCsCAQGeA97CTfJgtjaw2N8OVlNu8q+XJnqhcj0YASWm51
	0m6c5hkCfIsCsK/adyidQTfiN2
X-Received: by 2002:a05:693c:821a:b0:33e:699d:575d with SMTP id 5a478bee46e88-34003ca6caamr1230455eec.1.1790235494682;
        Thu, 24 Sep 2026 00:38:14 -0700 (PDT)
X-Received: by 2002:a05:693c:821a:b0:33e:699d:575d with SMTP id 5a478bee46e88-34003ca6caamr1230426eec.1.1790235493990;
        Thu, 24 Sep 2026 00:38:13 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm12120680eec.5.2026.09.24.00.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:38:13 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev, anup.patel@oss.qualcomm.com, ardb@kernel.org,
        conor@kernel.org, james.morse@arm.com, lenb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robert.moore@intel.com,
        sunilvl@oss.qualcomm.com, tony.luck@intel.com,
        zhangzhanpeng.jasper@bytedance.com,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v5 8/9] riscv: Select HAVE_ACPI_APEI required for RAS
Date: Thu, 24 Sep 2026 13:07:13 +0530
Message-ID: <20260924073714.1650588-9-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924073714.1650588-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260924073714.1650588-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: B4_6cK0d8rgN6OUBbmVRNAgUDc6vsjan
X-Proofpoint-ORIG-GUID: B4_6cK0d8rgN6OUBbmVRNAgUDc6vsjan
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX/Tx4q7xIeYPT
 yElyhKTjc/mP6bQKWPdtST86Fs/gSVIeu3F0e4La5hBDZhJboyrMHJMDQUBhvFne1hJkM/Ij1H5
 b520PQY3W9W63SUHJhqExOgpfWQsFQJEqakGZ4a6DFWUXeo0coQm1XjS/cfiXN9ySPEXQb0/UcJ
 3i6gQUW6NF+k9KWsIYZ/DC0R+XJFQ34xXH4Eh8lIKi8b6YmpauVti6Wdihl7EGpAM1UqJgdOgO1
 5f4FM/lsS4k8RSoqdwq3ebzVNYPkgV6cXDUIw38Ckq0TgpQSThpD3+ZBqmnRw9WVtao/oQnrtrd
 BGyZNwl1NM+ko2BLPe9RN+nrWQLCHrtlVO3xv0OwCafxc/mHoy0ntKSK4HjIl9I1Ah5GC73AN2W
 ZroN1DZh3pcDF98ZK3sE09RCUZi6ud312bHJrLAOPHXR7lD25hz4s8PBbZSuBQ9BEeuT7EzOlWE
 1omqu5qgaX1slHdBvjw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX3vRY5S66Pdmv
 y73qoGoHkE+9XqL3crNPT2DZ80azhNsk18sVaI5wmAI9MRFwm1MET2WPUO4ZL1lfz5Lsdhzra2F
 01yaboYBBJW86E5K4UaQyUi63aOXsHI=
X-Authority-Analysis: v=2.4 cv=f7vdl+yM c=1 sm=1 tr=0 ts=6ab4d368 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=ctgbmQax9_dbRqqonagA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240032

Select the HAVE_ACPI_APEI option so that APEI GHES config options
are visible.

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d6c2dbf8455c..9608abe126a0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -191,6 +191,7 @@ config RISCV
 	select HAVE_MOVE_PUD
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
+	select HAVE_ACPI_APEI if ACPI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-- 
2.43.0

