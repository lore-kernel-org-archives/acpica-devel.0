Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F7E32AAB0
	for <acpica-devel@lists.linux.dev>; Fri,  9 Jan 2026 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949401; cv=none; b=KVaoB1q7drznPPBx8QwJXe5yf8R8KOTExyEncKcN/I9wQTjxOfHMnJvUtJFrtj84aUuq4JwnQTZcyuy0N8fpEa0xFKOBYTaye24/17K15qBNHQTDG6vsH7eGit5OrXW075RIzPWZ8fGJmlZREBZwW+nTTUhQSFvBGqpC+mpN2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949401; c=relaxed/simple;
	bh=z25NS89FtakA2eko6Ure0qKn5EJXXO+h7R/VGAf7s14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbbYauAjaCSejjtvcM4TZOqhsP+9zdAfx9gWAJUHgS6bo265X28Wgy1tFYQtwXO2tEgyj8o+0MCmNkvAnMDtX4A7b48VP77Lgaq3nLSZeW0CcrIONyxknkCzqzVHcdDQIPABCVD7F3XLpxJnuyR2L13u//8+ni/ZwdqqUt34ktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QYhlGNSa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jOgmYGms; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QYhlGNSa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jOgmYGms"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6098XNjl822710
	for <acpica-devel@lists.linux.dev>; Fri, 9 Jan 2026 09:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CYIkrEqrqp8
	jD5QuPnx++ARhgF+TQWP9mqsMoFPAsjM=; b=QYhlGNSa1E8AeS+9k6scumC25RY
	Llo1ynUGgo1yhtVX3rnJ0TyHR8yxA7nGZAWdiDYJq9ySB/O3bjp6GXTDmbCxyp1P
	7HdODDWvrF4RN72k3dg2LD5a74XVPB0lEQ4OcBv0zKvS5lV8RFiv0+TcT7bltSb8
	Kr8OZnN+pUFYLvxCUrWaMI6GHBANnzcVZg8ucs1PPDIIkx7PSwDOnNSEw64yPWdM
	YTMmnGJQw5aScR4WZPRtL19BFXOp5nVETix52Jz+qI2yYubXe0lIykqx21wAQivU
	o3+S2vzQMkk12y836vf4OwBL1DqnxTi2ucQOHcel/cD583VC7OqVsV5NtAQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjx94g3cu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 09:03:19 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c52779e9e65so1053200a12.0
        for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 01:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949398; x=1768554198; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYIkrEqrqp8jD5QuPnx++ARhgF+TQWP9mqsMoFPAsjM=;
        b=jOgmYGms7d2Agvcv4ZvpyIZ/TuR30XY9E+rA8U+HMkOPGgNeXG5KEXkDy7ZMrYt+C0
         1g5eAoPOhdnIF1TdcsuRpwRtqUmOlTLEKzdSbtjDKuj1sVhsrgjsZG36ZjAH87Lk6it+
         aeeHMrE1mQCE3/junz0efV9Uxf6A/BYdvBY+OhQn6HDRZ7AQyNaok4XjzXiu6qtbKjPw
         Z3bpmtDnbpC3ReMJgo34NaNPaF8BinRryqEqygjvM1z0lJeBB3De+Ce2eMSClXksF43X
         /WSRNYdsTrRbQh9Ds07+T8eVsUnXs3Yi5OvyskJCFnJwAPJdAO/Gfxsu7beVfbC2wczR
         jYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949398; x=1768554198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CYIkrEqrqp8jD5QuPnx++ARhgF+TQWP9mqsMoFPAsjM=;
        b=MjLIpAiVlHNm6BeriojT5NTB2CLIocPQXKpcSr/YLi9V2byoT6loiskbF+PHIK7QwH
         hVVdQQ+x3slm8HkFgmUBFWui8emZZXYNuqXpvonNNBNhg+0w7IyxRFl7I4+A5XmbEfPC
         7ZKNitglkERMSoVucHPNSmX1/UtCebIAwFILeuhhBSCGtsAKU3ePT5OQj6b+7UoJ8PYo
         inPsR/Zx+6qx647VzKxn9p4YS8rZ6oTZhVZ4tiLQFyd6DKWTFNJv0AA47NEfpKr0j2N7
         dPiY1sm8MA+eR3CUlwL5dsPKJHMl/r9cErp0i24ocD6SeuGAbf4hc2WOhyIcDcN29Y4z
         WCtw==
X-Forwarded-Encrypted: i=1; AJvYcCWlntPTdnMsVYD47dkllpRfcBrdLw09SNxdBrWhVsTZp8baCYb6rOT4pXYUn281y4R6vSLIW27G7n5QgL8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/+/8E0Ku4bpS6mCoEsPjQETIOhru8b84vpeMLvN8hTgCNSj6u
	QNCFSqi6vYbqR2KgoO+izBBY4DnN6egji7OeyPrPxpaGFEctxbFMgZboivIQZjRpR0bbM6vpJky
	IOOx6XqOLsSkom58EWZj1HRC3rozZ2zhG0v6XDcXXjdxnJYD80icwmiU8a4DVZ3LM380=
X-Gm-Gg: AY/fxX4X/GN1vhZXWK5uTI4rMqccaaFXdTqRvCRnqVzZ3aMLpnocVxB2g1p8TTTHEXB
	FfC4OY887NaZ7NBmMHwZ+BUexG2u2MuRlha3Waf/68XNkMV1MXIupECyMXG9lH7GOSILBSiLjXM
	PugRbjYrjAAegiN50CZN9gzqNgHN3+pWmsrYHD3KFy4avAaOrxwr3Z2EbB+tR5XN/Ml+5siDoPa
	2a/lJuBGcJPv6sGCzYauqb99fqU+MA/hytY1mDq9wPH0W4iye9WXq/7PTB/0Y309NQo1UWlNGVY
	jbQE1n3XTBUB1hBoyfFXP6Ix4QsRd1yFKN8vGKnnETLUPk2ZwR8xSdlNOkKqao67w+hJDJGEXFx
	iHidyzXvVJeeBDABPDJ9whW521C2bZd60mLGA+6HFWhozGUc6kkxF8wgcu1byaM1gh+IPnMqWGB
	kWoqd3c2tP4Ua0IE7GTJRwYWbzBrZy+p3AyQ==
X-Received: by 2002:a05:6a00:369b:b0:7ab:4106:8508 with SMTP id d2e1a72fcca58-81b7de5ded2mr8194212b3a.28.1767949398518;
        Fri, 09 Jan 2026 01:03:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZwwdauYHJ7mo9yWi9RFBYJfFv9+fHWbIuLHl8/MaWDzNNkxmOHuFcgwapDAslrzzgxq5nlQ==
X-Received: by 2002:a05:6a00:369b:b0:7ab:4106:8508 with SMTP id d2e1a72fcca58-81b7de5ded2mr8194191b3a.28.1767949398002;
        Fri, 09 Jan 2026 01:03:18 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:03:17 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 10/10] riscv: Enable APEI GHES driver in defconfig
Date: Fri,  9 Jan 2026 14:32:24 +0530
Message-ID: <20260109090224.3105465-11-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RN2+3oi+ c=1 sm=1 tr=0 ts=6960c457 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xUlk1AThICIXWUt23vsA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: RLo3YqLMxizHjw7RkI5ud6z8M8xp69cL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfX6e2XZu+kw7jc
 ZjQbGmq5MZWAm9wLE97mEE95If2AL2tqRYhG7TdKj4rj76YrK+8kwMSTPcENMNzzZaLHeSQJOZH
 ooenQtpOzZ2XLyj/Z9BoPNqZfAQFfpJM2mYZtC7CxmRtef7XuIlf4I92aWtQ7Nt7F6f2t/Bd5EF
 t20nmjoRwlInLoqhoj+oxjj02DC+xUMdP5UqdfSp+JXQXNU/mhrEwlWGUHPsQwJDSX3SAgSXfI4
 zYYFtR5BEHhhLkHkid/uwwf+XTaUa0BPeIbdfj9+URc8audwXfH59di533aemT5T/oX1HZODQXw
 gZ0+2+5+u7eLCH5hwJvT/q/eYlsB59SlSONZu2MwKOkgSsqApKAYC8z3z1cE5GUS2lOh0JgLqi3
 tWOea7KzRy+ufJxpgiAp5zL0DtlLvd+Ejozxp+K4tztu1y6xKfm7mDDnaBkR4t/Jm+kvWszWl8y
 SbixGyBK/FfuUvaJngw==
X-Proofpoint-ORIG-GUID: RLo3YqLMxizHjw7RkI5ud6z8M8xp69cL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090064

The APEI GHES driver is very important for error handling on ACPI
based platforms so enable it in defconfig.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index cd736a1d657e..38b4a802c2d5 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -46,6 +46,9 @@ CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
 CONFIG_ACPI=y
+CONFIG_ACPI_APEI=y
+CONFIG_ACPI_APEI_GHES=y
+CONFIG_ACPI_APEI_ERST_DEBUG=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-- 
2.43.0

