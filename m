Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665473E0C50
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235467; cv=none; b=gmL0sQRLdpVyWcVza22qXxIJAKr1rfxaw3roj3UJWC5mi1KOkI0/VCsguIpBr+X4E8MCUrsdpG3YevpMP6sQkd2bGPVQeDmzLy4UcXSbA85pJCfdoHIKoxf8SjG+FvsA31hLnNCi3gWx0zLIuC8CantwMVIJAaNbBb7wDR0eXpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235467; c=relaxed/simple;
	bh=Oc/lCz7J8IDjeFbK//EJABhRCbxS4k/rXQvZVa9k5zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZY3YiNn5taotNqJI75veWLP6t2IaMttH0En2JnS6L4tCAl0oVVeMbLBfJeNQKMmLzZHpq3dIYzzfrW6J3L7SUgx2tagVYzaiWzBWG73YFmJcPXGkx6kEKIjh+X7Q2/0pril7sI25SweZ9rbQSd4mtUd32MolvCsRIVqc2RiM+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pe/wqpde; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PsHcBqvC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pe/wqpde";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PsHcBqvC"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5e9JA2420873
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pB6vrkBAByF
	zx3Q4zdQRRWEh7E4G3c0it3uuIjGmP0k=; b=Pe/wqpdeZ7PC+JWlQFS3sxeFLeb
	VUsxqEQqq4j43LQi5K6bmjtMVe7Can69P1VvO8utIXIxZxaGAqcbWbWuKtJ+0ERB
	VZXYDcKsb5/ELqplhyGtv3Mk/SyA7RmxMMJbC6ilvS4C1OCEKsNmNAjRCDAjZMQf
	KL+Y4zIW9MxZc6t6MrUuM+ZuP1ZPrfgA4p4fwYeTC6KE170rqUL99gsiG/IP34P+
	WJTMvjiYvhxtnkXasP2Ll1k79wUuhRlpnB5fJIWQ5jC4+FP+bTppMR/qeJUrvXLY
	vNQ1mDrluGHUlzuyeuqS80C8X7Dw8yyHcLUeomlQimYC7N4vdPid+uB48dw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvstuhaee-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 07:37:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so3294974eec.1
        for <acpica-devel@lists.linux.dev>; Thu, 24 Sep 2026 00:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790235465; x=1790840265; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pB6vrkBAByFzx3Q4zdQRRWEh7E4G3c0it3uuIjGmP0k=;
        b=PsHcBqvCTVgYiQddq6IZ5nlTCykV0JXK0kZE8RKfE26nRTDUTtf++oyokHk59/Q98R
         +NikvI/59bjNAFca+1YZgCn5FJhnWmOykpSYPPfLRLAqpZjCUPYlfxLoakXzLP/BZYF1
         R2EF9aKNC5+ewLjNeYDkzzJvxRKjbNcPBynYexFZZ7oNcTO5wB+fATUgx3hMFlqGGgsW
         9yuB7cfvyq7YL4NsBna0ZQtcNOC56iebXxklvromy217WL6DHUL/PzSEL8DjCoHkCpb7
         4IAritmdYzvoOSi8OgNecw4u47MCTDC1uTR4SsK0X6gn/hvhRFNKk3sp7bIOY+6eYNYi
         cXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235465; x=1790840265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pB6vrkBAByFzx3Q4zdQRRWEh7E4G3c0it3uuIjGmP0k=;
        b=J03pCW2yVjm24C2NyrstKrce/5D2dfI+6HA23gDhnf3Y5eFSMnrzay0IlJI+bsai4c
         IPR3aSQaZ3tC1p8LdSJrczaGu8D9EKEVhu2cXNMQHedMqnPqSP5p+znVshCp1ddUc851
         wL9vOIyHg6N4kVStX7SWh7S1094m4NbHd0nf6Do8aPDQ1c9jVR/gEFppeJxMZ34TH1C8
         fCmjEvxp/gxDKqP3T0das8dEJcm7+X5pP4+/tIUKdiVoWtU78I876NATIbUviJFYBs3R
         5y42QdRtWuvmIUaGm0XapHi+kchakNmebw64gguHTS5cEzf/KL6jKkKUpMMwpyxRhPJp
         rerA==
X-Gm-Message-State: AFuF++nny+5c41MLQyh1x1gFjeddb0SdyC7xsRW4EAROGL+9vVSMXEa7
	b7GqtdIq4j1YtpWiccu7tWVi6TZIEQs5D0pNXm36t8pjo38xwhbXT8WR4x5Z//AbolXKFtrvKmP
	iBDIKPxPa/OARpfJJR8iBP9Nu/pKEmJktutNEdSrbSRLK/yl8PpM4sMqavd60eJtnAWg=
X-Gm-Gg: AYBFou3z5JCOk82wWoemv0AV5v3sZyDjpnv9Rxx6CGgNYsGVjovyptuYc5jM/d32hYu
	yrSxVG06l2cPoR6u6d2kbs6gefPR0jAiz0FDQXv2Ka45QqXMpG1SL4uAhvoSGTkhodUqmbm87KO
	gk7dKwns/g0EE5IK876Gn1wyYr5sDUtk/je0tMC135LIa1TWOn0eAjNdNHo9fsoH0Jx/UzfPlhH
	D3u8e9QvxiY1R3eCRA/yhSxI4qyJ/bZKOwDBZ86sdaaMOKkewW21sJ5hQb1lq66pXclDh639KS3
	krO+vaGKTAE1UFfBf5bdoD1KmImx8eF7UGYKti9CHH5+oVbHu10kLS7g35rRRLBXzIn1cPE9Ti9
	V6OEuW58JnCm+4BIWTS0rQHstX+hfwxzvDhr7msuIAJBe4B3QCVmLAQP4M/i5SiiF4B1qxCzfr4
	fqZajMLjijgzkxWdMcyhplGJHY
X-Received: by 2002:a05:7301:77ca:b0:33c:e93:764d with SMTP id 5a478bee46e88-3400151e050mr1333094eec.39.1790235464768;
        Thu, 24 Sep 2026 00:37:44 -0700 (PDT)
X-Received: by 2002:a05:7301:77ca:b0:33c:e93:764d with SMTP id 5a478bee46e88-3400151e050mr1333069eec.39.1790235464103;
        Thu, 24 Sep 2026 00:37:44 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm12120680eec.5.2026.09.24.00.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:37:43 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev, anup.patel@oss.qualcomm.com, ardb@kernel.org,
        conor@kernel.org, james.morse@arm.com, lenb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robert.moore@intel.com,
        sunilvl@oss.qualcomm.com, tony.luck@intel.com,
        zhangzhanpeng.jasper@bytedance.com,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v5 3/9] Introduce a new HEST notification type for RISC-V SSE events.
Date: Thu, 24 Sep 2026 13:07:08 +0530
Message-ID: <20260924073714.1650588-4-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX8NHwbsa/0Nd8
 jrteKIAuu6AOcKSJy2loClmedMrDnXNwfpHxJWYK4j1qzN6p+Y1ntKFwn0iAAiGqNRhdtKgkBat
 H35KxzHETofuObMTaKQPwyb4ffiOZns=
X-Proofpoint-ORIG-GUID: GKv4dwaPuQxeO4SdxoXdRDkFzvCPc25P
X-Proofpoint-GUID: GKv4dwaPuQxeO4SdxoXdRDkFzvCPc25P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX1Bzts0g9+79O
 ruhn8VUKRz91dohAFRYQKK5aJPKYp9jvh8xsSFiov0xzirGCmQKCDmwRRz78GM8XAtLSrxHN6ay
 Y/gnuA7J+ZXPQTrlQcdcjxs6VDE+RAI7FzICxWJ0ZOrFngUua2DMcnyX5d8wfLTEcmUX2ZZvkFS
 /HXomKfVmbYkLatH6FM1YQ+Om0c/QJJNX2XMjKXhsQQUdXtGb0SKPgAOtt9UVahXHzrwHGJu3Fs
 gfF+MFQU2KA1gCYdTBiOw/5AWstb9DoleCI40UtAex9CX4ldXnjIOhIbMDdvjdf2JnE7TQCp0Qz
 ATkBby0E3wdbIeyvAj/TodcIYk9r8TeHcr9/pXIIX7v8w3k0SLtUcndfl4hslZcsyXTJom1AjPi
 jkgAJ6vXzV4VqDD9mGal7KVNulzDQV639h+u4r8EMQKS3rW7dFZOw/j25zLTCGEFd2usLlxPEbu
 scr4sfg/DxTRjKAQ4aA==
X-Authority-Analysis: v=2.4 cv=cKp1IVeN c=1 sm=1 tr=0 ts=6ab4d349 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=6zSMeUNXk5_XeOI1LAoA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240032

The GHES entry's notification structure contains the notification
to be used for a given error source. For error sources delivering
events over SSE, it should contain the new SSE notification type.
acpi: Introduce SSE in HEST notification types

ACPICA commit f73f39352c1170464afe812cc96b20cc9db1d822

Link: https://github.com/open-acpica/acpica/commit/f73f3935
Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index d824838cb7af..105fd51f83ec 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1798,7 +1798,8 @@ enum acpi_hest_notify_types {
 	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
-	ACPI_HEST_NOTIFY_RESERVED = 12	/* 12 and greater are reserved */
+	ACPI_HEST_NOTIFY_SSE = 12, /* RISCV SSE */
+	ACPI_HEST_NOTIFY_RESERVED = 13	/* 13 and greater are reserved */
 };
 
 /* Values for config_write_enable bitfield above */
-- 
2.43.0

