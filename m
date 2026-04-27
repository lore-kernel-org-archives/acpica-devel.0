Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B713B6364
	for <acpica-devel@lists.linux.dev>; Mon, 27 Apr 2026 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288984; cv=none; b=ODNgFYeVqPGVvzMn8WmopVIXPFRPve2wHd9CZdiIX6bcCVt3xCVTPD4pnZWjnyFr3yTbMQm4AD8HjDU1sN7VnMhb+oRh8EaGVaNhxrdixTJmRCbyfuUnhwfwNU+3PGeN9Cp84QJc+3jzS9f25RJC4Yhndm2P1a/RQZ81dYZurnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288984; c=relaxed/simple;
	bh=XgzHn885FWid3cTTZxGylf++YQN4FERwJEs8Jjsu50o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b42vwrUW2NQPI0KpYphp+LNN3BXdNNRj27rGcNF0J2xveMGnOYMrQs7WlpO+t+J8GChGA6ZU8A1myJAyj4Sh0LQhdBzUeJuO3V0It5mQEP3/UeFBgqYw/xB5Ap9993FN/HU1s9a2ZpedKioVoQi4sB8NxsqIFP9dMszknZbJktQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D5DNrB+C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ImGCYUtB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D5DNrB+C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ImGCYUtB"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RB73fa1237224
	for <acpica-devel@lists.linux.dev>; Mon, 27 Apr 2026 11:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=I0hy7Pqqez7D6hC5jhpZMX9oVReaOUnQN5f
	qbMLiLSw=; b=D5DNrB+CWpt0dN7GLAmqXDh5Z/L09GJ2m8lIHkFTjHxlgqIHM5p
	o8vuOdR/3N49MEUEkYC3yvaXPlyCy3E/qD0Uobk3QgzTKx3ufjiuAQ8Um0vFr8KU
	ElHM6+5rvD2plb1934/IzcYzOyaIub1nOpA7tEYpq1DKmQTSZ9UZp8MN3P/SZWku
	RJbZjO+rxPCiF9bT17uUY4r+IuYc91ebf8cKpOS13CyHnZf8kABT8xNA3LVwCl4s
	z7YdCKaefejvc9Nq5mXtJbFfj0G5iKKKsNJ0F+lYSUvIHx4CF+aSVxcv/iek4GX4
	bDXWvWUhzYDl6m5DIU0wXEz4hiiHsAGM3KQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt6n4g1f1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Mon, 27 Apr 2026 11:23:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50edf0245b0so33704211cf.1
        for <acpica-devel@lists.linux.dev>; Mon, 27 Apr 2026 04:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777288982; x=1777893782; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I0hy7Pqqez7D6hC5jhpZMX9oVReaOUnQN5fqbMLiLSw=;
        b=ImGCYUtBsFGElHEj8v57J6siHItISNSNtqUuxOIgYRttLLw25pePwsJpWCeB9eEBfe
         10/JWpX/LjL/hcS23PEVYCrMecugvLuVhoEaCsOD8CbIRCDFjHhKeOuPnC9HFjrkGNQ8
         Lg+ApwWROTfdR0fkcXr7vQyKpS1m4RuGEc7CK1Q0yLoXQs8HHJ/7viF+cc87SEH4NkGy
         UuOw49J5i++njekuT4raB5GSfWH0s6Qujs5mLVwuMaO6FizB55FbZVQDFCYrHv+koZPY
         VMWWbwI3Hc2xsOpJWwu/iCetC786VE7KYYOeYo4AzwnCurOy4LLY8FpVLptkqbg1rnCk
         +vgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777288982; x=1777893782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0hy7Pqqez7D6hC5jhpZMX9oVReaOUnQN5fqbMLiLSw=;
        b=IpAX9mv84FjA7PG/AqPSFxPTmZ8VdYN/rCOL6JP/i8WUYUtIZCZ9Bvhy7FXFJbc0hz
         PP5Czk7pzVewIKqfXi+VYGEaJ69P/xiQ+SYOPE8U4+wHSb3IVakFj9qBF63ikHmzX0N+
         E1yWWy8fJX3qCkmtrzeRhecazssdGhmdc6tTG1ZhK1u6moWccyu2ZVDDJDblukXcBEyR
         VrIBt2G+SMuJvBOlmIKSbCuBa4RktG9oS+FDZxi2UIRptPJ9EEb9/EPftErGZU2LNIUi
         iMK7b+BJXVNL8IeHT4ZkvaS/cW3LXOntj3ksU/CU79CZKFbeWFKZbDvyEhCtDCTNvXSe
         lmvg==
X-Forwarded-Encrypted: i=1; AFNElJ9aUbDNXn3ZZnwYxGQtcxDVKiVnvezNqyvfGqVntLpcDcju7TyzMlfkKI5zhH/BQmfwK85iz5uWHo52UgE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxruzwpjok4J3cIL/UwGub1g3wU8ycCuvrN6EO3QD90KuJK0xId
	v/LEqujVsO+YNEEnVHTjkBOrOuFp6ueCjFAnvrLQ1fYL3CZ/+11mroA8r1fZbmIoHN+GhVbtPIc
	VXsjJc8yoWFrbJTh6H3pTVeO9sbvjDtBb6WBuMyAFah6d7jgraBLtYdQ/p66fdezaIbQ=
X-Gm-Gg: AeBDieuUorwNAnfHb0e+cbT9AsgcDSO0pm5RPKTZAQcTy/gVIF212uE4gyLmxMbMjE0
	WLAqyhDukhuLEur4gCG43JA0KM+hpSJD0/p9xhkcsgKwevMd01PGaVQ+YJMmbeSRkA/g4Q5yVbl
	d64fP9X31FXo2ZqGohfQH7lMSidTfp6rw8G5eyBiQ4uJCXRiKA9/cg45MFjnIMfJxCCZYnVsxUV
	S7nBMqloqOgvCimp0Us0yy3e8BSvLPJsF/FrMf5zm0R5IOTo8TvzekfFQnhhflys5i4ChBYS4QZ
	vx25firhnJN/2dV5hCzRkAftRLn9j6lQupJJkJxoU5qwusBaeMv5iKzaLa3wnTXu5RSg9XGNZ5J
	478xWNEdhHTnItFbDdWziJe8UL06QvVnub58Ykf4YdakTCg1Qbl4M8atVJzBQ
X-Received: by 2002:a05:622a:7103:b0:50e:5eba:caec with SMTP id d75a77b69052e-50e5ebad365mr322642231cf.54.1777288982017;
        Mon, 27 Apr 2026 04:23:02 -0700 (PDT)
X-Received: by 2002:a05:622a:7103:b0:50e:5eba:caec with SMTP id d75a77b69052e-50e5ebad365mr322641901cf.54.1777288981559;
        Mon, 27 Apr 2026 04:23:01 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:5062:ae86:23aa:702c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a525a0b1asm234825375e9.2.2026.04.27.04.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 04:23:00 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Saket Dumbre <saket.dumbre@intel.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH] ACPI: add missing forward declaration to acpi_bus.h
Date: Mon, 27 Apr 2026 13:22:38 +0200
Message-ID: <20260427112238.132419-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wbr5w_9GsECnphap-7KAnfon1iu6FBYR
X-Authority-Analysis: v=2.4 cv=Xba5Co55 c=1 sm=1 tr=0 ts=69ef4716 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=IbMZajSweJTZi3pcCa0A:9
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: wbr5w_9GsECnphap-7KAnfon1iu6FBYR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEyMCBTYWx0ZWRfX2kvmCsCEKkih
 BoRRTqn39tSU2Te05a3RJA5MiVrsrGoEowSsptl+lm5ukOAXEcW0l9pjiOQNnJ/5zT2hSLD89Zi
 R83f1grGGhlStyThY5NpqkxV1EcKdE9XB65NLdjFF3m/TUQAtfgVdZ2afvhPcFD5Yg6OvpEMNB2
 CwJtVKPq8rM57i8xLyfvsAgiiRzNoYVEIlSesL5Cuf6UtyGjR83IsnkJlsSJR+DpvewVyW8uCRG
 Bydhh7JZopo4tmbxpr04DKhHRv+FfSoSNNGwmj+CHYVfiJwNtI6LTnReqf4b0f4xDaVEsgtQF3L
 S8Y/0xyq1T+kukJEWPEuSeDWDISLIOtRexr/Erq5irNNSVxuELZFeIDJNwmDHUiLetIOC8Ptpxj
 l9aKOn12MeoC4CwW/Hm6kiq0U7Wk3hR/NGPdv7yPW9wejAtVKbrbn666KxHrVwxx+vii2gYcnha
 7osF7ee3GGisJhC09fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270120

The header references struct notifier_block but neither includes
linux/notifier.h nor contains the relevant forward declaration. Add the
latter for correctness.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/acpi/acpi_bus.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b701b5f972cb..c41d9a7565cf 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -17,6 +17,8 @@
 #include <linux/property.h>
 #include <linux/types.h>
 
+struct notifier_block;
+
 struct acpi_handle_list {
 	u32 count;
 	acpi_handle *handles;
-- 
2.47.3

