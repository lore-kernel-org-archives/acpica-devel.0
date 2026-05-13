Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29DC3E4C85
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661848; cv=none; b=itQ/02qiXwFyfVQl0aF3bbg9BuI8Y83JY665Oc57xEYmXAJ5b9w0AzPavDYfhyvOvrYapjKf+wfxTfa32TY/MQBevZSae8x0XeYHpEmcNBMz3R5MF7MWgGseJZMXliYIOCoYI8CPFsBixI94YPSmIvQRH9a2y8x3s7EoNVvNXTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661848; c=relaxed/simple;
	bh=OM3puXfkqZmLNZrfom/EqiK3YzhGX1pHmbG85tQySaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZYGWsTDYxgmPRL6dLsS5u4RHHLT2kryYPv7qRIIXy+J0L2hFMJXpPNcVVEZCZuJ6WD5B5zBiKsi6UfhyFf2rIl0vcSHh+SmUfBzpNSzULZNOHwoyJQi2wRp09CStbFGgoQbqJmiDDtcHcYiF/DYcAcyL7KuibX/1xFu4OfoO2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FiV9PcTO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KKwAmime; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FiV9PcTO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KKwAmime"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4pIjU2933187
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	10e/P1TFZBwN9btyQIYXv7eFhzP3u0CEgDuiofULBYw=; b=FiV9PcTOqUDEUrUB
	wi0As6qHPrmE1gK7uhvqXC2uVxa9J1dv7ySRSEbDJLDcDSaRwakuHud2jdMnNIwK
	Q0hNZ6dBU9a3s/Z0SfKkRwsydypn6S9OxbyfClQ0AH2illUtBPY0lOL+EBmocGs/
	pi6ioYi75L7WwnsGMhylhE3v+dWyYG3LPDDSoMF3YV/CKXBOiSCOyqzbDO4uPYqO
	gGs/hNOmOPNo8l9XQpt3K7iUwXJ5Je/tFiOSNvW4UlEjZBHYJkLO+pEUD1lNo/kj
	J+7Cfdr/7xYTwi72vawVCnv3U4srs/SJjVvCDmIO5j+nPL1VGlMVJrrIwy/Q9qmI
	hjYInw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4319vjeq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 08:44:02 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b4678c6171so68670045ad.1
        for <acpica-devel@lists.linux.dev>; Wed, 13 May 2026 01:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778661841; x=1779266641; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10e/P1TFZBwN9btyQIYXv7eFhzP3u0CEgDuiofULBYw=;
        b=KKwAmimeIdQ2VNWJ953T+sLP3e7ogONW0QMEQwxgHBR9BhoAcWxRdF9+A6gzUKqo/B
         LGlVt8a8wKtmSNenRsQokocrZmGDZxE/GZasgVpwCpcF+tJvgnwUirxYcMQvaKQPQt/n
         1aZvvCJ/f83YRAiv80hSE6Qcr4wkCBp7XAsDNrYNb/ei9C4h8KFOCUXftiFB41eeFKAB
         bgRQzxqAHfp4XxYB69SBdu0RKRo/dDqVFA3R6YjQ6zbOKciBdRaMW/zAHU+xZgEwIBLO
         MKlO53z0lA/7lZnuq3drrgJmcVGuRLc4r0yXSqCoI9FBfG1kGqaPK+eicevfW3f9M6A8
         nr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661841; x=1779266641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=10e/P1TFZBwN9btyQIYXv7eFhzP3u0CEgDuiofULBYw=;
        b=Y2r4gMsfvVF/xhyFhIZLk4KPI3Gxb6RGLlqAia1TPqnFsTzkVgd9rOoj2cURiWR67T
         aR4ZoBPduPO1zlyxi03cXqTGThUCqSlqHRcZtYG+umgj5WZeChxh8HIxZyIBhlwjeywh
         eZj/djF0dwvBeC8adcNduZg0J3xax8ZCMI7UyTy7ntFWqsgydhmvm7WCjL3l8UoaJjP6
         VwqLL2ZCgq7SjzKFs8MJVcBV/Tu2+Vw25KS1iYngvc3hWJGZQW12VB9XMyejE5Mshxgs
         sFiK+pyq0FR2fBPQI/OXR666Oi3BB9Qd02FFHFCsdbMj3kkPXhO4cF3GFSbjPAXIGP1+
         CK7Q==
X-Forwarded-Encrypted: i=1; AFNElJ/28a4Mi0iKJ3DX/vMd837m7XpJhZOuC7AdAvSHvRJpylXax3do0KW22L0h+ivRHQ0Y01JxBCtjJW9NHUM=@lists.linux.dev
X-Gm-Message-State: AOJu0YzmQnUFD3Jpzd78c2J1vHfi5oem3Lmnog26ONB2voMDt07cLpNi
	Zw3pTmpMellQOCUd14qXGBnbFjstL67FuF21TovrZUJfD8a+TrIzBXnGHdOIEyXTqYaTEVY9j56
	HUm+poGWemyjEjZKC3AGiyyEaZCzBqwxttDNKDCqV9rBR4pV8Jo6j41oe5gIEs1dPIak=
X-Gm-Gg: Acq92OGbpcPnSsILMYtm/qec3FzqqQitvWHO7+KgxHDj/BGAmCyTMHIHWdGRGnhK299
	8x8PuPPDpd1oqe+i7VSTwqQLInt/lcnQP2rPiBUizjIWhpvN2lEd5Cwmfo2kdOfHrNytXwEwyAE
	JxpXqcI0L1rqg4VZBHKPO7sVStK7fqLFs9OchE2X4i5iSrgfVFDtSof08VVu8SNN8WRW6n78Svw
	IvymJx2nhWzVD4ZY1KZ5UujyMJftwJqdnGwqlA2RAp3QGYBqDDFp3BvXXLf2A2F1vRXxjPn2tvD
	OzUyXgLDGDso1KImzA35h3s1/fwFgu1Ry5zRec7BaE04euyBYkDtZsgLNO5oNynEywVPbUP6nvK
	UYXhvFl1JlqZ7cW05X9vr242URNgonhswg4ik1vOLZVP0WNMDNDU6UyZLAbINLZ+K4+k+/rTDEi
	mQ+ryCcWQrR9RYp4KQ3Ku9GpOvDE+W9gUOaAxgALskBhLkJQ==
X-Received: by 2002:a17:902:db01:b0:2b9:cd2d:6f13 with SMTP id d9443c01a7336-2bd2716dbd0mr27138365ad.10.1778661840782;
        Wed, 13 May 2026 01:44:00 -0700 (PDT)
X-Received: by 2002:a17:902:db01:b0:2b9:cd2d:6f13 with SMTP id d9443c01a7336-2bd2716dbd0mr27137965ad.10.1778661840293;
        Wed, 13 May 2026 01:44:00 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2709bsm169158725ad.5.2026.05.13.01.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:43:59 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v4 03/10] acpi: Introduce SSE in HEST notification types
Date: Wed, 13 May 2026 14:13:18 +0530
Message-ID: <20260513084325.2176952-4-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OSBTYWx0ZWRfX2CzSoHJIgQqu
 DtPveIGE0t0bK142sZshnFSXCCqZtb/ylBEBU16ul+Cb7T1dGuFzK8+05zOycmvIrg7hZAcL5dk
 lm93JjdnJj/paBeYXYkZA34pWj6aWd4KsfouruWfarEW1j3l93w/2eziO9FDKm28OJeTp9WUWZS
 bF7e5F7ZVmBF5xlnKZGwybMwxceH4IYKkezTHzyjQ1jhaUMbHXD76+cqc41DutnJ2S1i9y+qosF
 FQ23OMLbxnUVFg7Un5prz5SrL1y/Bp7kQrhLSl20c/3lIxmIEJ6pz3N9ZbV7/qbAnVW9ExUPBp7
 Od+Oq2vLaFQXQwACpZg5jct4iM/WbVMOYo72jxNLBwsbP/PPaDvKFBvgtd41A7ySv435qqmAy1u
 6sbu8vXh1P3Dohsta77B+0JkzVOOXNI82RU9aEuK/NRWmYeOdu/6WCsC+wHIkAHzFkjJrFrnMKw
 +tqgQY1l2fgHsJArRew==
X-Proofpoint-GUID: pDIQBvShzhwv9yOYMJBmD4XpAYm4e-fC
X-Authority-Analysis: v=2.4 cv=bp98wkai c=1 sm=1 tr=0 ts=6a0439d2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=h0uksLzaAAAA:8 a=6zSMeUNXk5_XeOI1LAoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-ORIG-GUID: pDIQBvShzhwv9yOYMJBmD4XpAYm4e-fC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130089

Introduce a new HEST notification type for RISC-V SSE events.
The GHES entry's notification structure contains the notification
to be used for a given error source. For error sources delivering
events over SSE, it should contain the new SSE notification type.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index f72e00517eb3..2a8167979458 100644
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

