Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AA343E480
	for <acpica-devel@lists.linux.dev>; Tue, 31 Mar 2026 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979313; cv=none; b=oiMjGcQvLg5s7jsNzr4zJVjisZT/ehcCsF9UANbCEJTmxDAQaRI0NQyIyDbz4RjHw07cXg+wVmjm8cuy5V6td3l/12n98kXwbEKkQRdqcsf3WbMvpkxPgmmRciUrBuN4PJh9T8FuGRxnwAi1pSsBng8wiLj7x3JaHQTm7nBBtzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979313; c=relaxed/simple;
	bh=yInp3jQ2nfEc1FkUQ7qUyW0p89IAt5AFdaupsLTGINE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=F+5sjTMNepKBb2TWzjLSk6w6fK2yCErh6EGUUtoFEEb45yLL6VD2x2wj7lYpBywK2AT8SLElZGV1+YxUxQSs07uSE3VSP0GUZkvtrfx/3FYhMJrKRJYqra2Y3ENErvNE9QgrP5Dk4cn41aRs9NHFK4HF9mnUVpF48ACTuJKN8v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IgBJukjV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MYnbKro3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IgBJukjV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MYnbKro3"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VGdbWO2814395
	for <acpica-devel@lists.linux.dev>; Tue, 31 Mar 2026 17:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9tkluilWSFi/zwAvCgNgh5sc8znVExg6yAujw+zfcHE=; b=IgBJukjVHVlVxAeC
	uka8zQLMz3Hpa6J1fgfMtCBZI89mTZ68ZtodlMEERZAKZUcKVnWH2l//Tha7AD1f
	WJiujnb3gxO/PKyKDmp9G/vPf5MR5sA9PDr1GksgOsatL2SsqGph9AArDf6S8z8/
	3LhvgwRX/pBIY9Gef6MJTWA8nwyImw6Wy+Cl8dhw5lLukZhh0KKPCWQgYtFC53bv
	MESSzTiyrq/ozH2s9JhocgnIsND7Lsq38ZOvTw4BgrCOb+iHWVpOic3FVqhhpmSF
	sUnufd0QpedVrTnqkCXm7EzO8vDAMTO7aJOwphbYyvy+uqWOaAZ9MrSAlyztHnLn
	oVnf1g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d86ntbn8r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Tue, 31 Mar 2026 17:48:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b274f94f8so3964271cf.1
        for <acpica-devel@lists.linux.dev>; Tue, 31 Mar 2026 10:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774979310; x=1775584110; darn=lists.linux.dev;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tkluilWSFi/zwAvCgNgh5sc8znVExg6yAujw+zfcHE=;
        b=MYnbKro3yjakoFa6NordAvfO8EI7ZwiKUOesbIhYRwJhWJfA86fSP4f3N5UUC8AGSp
         IPb2a0B/OR6X/UVeM+Ah8AqbZng3WSBCNQiY9obQ8H+SAEhpWleohZgNuTx1IvaMOlmf
         yrsd9kxMUs8XWiLJ3JBf0h0PqX38FzGaI66kf6i6adfhaOnkcVnaSWVwklLvofGnqcQb
         8rfayGSeBSm7a4Sn3YBvjr/15nH94IirH6rPDmOL0KrGzAADDA6YNdErWx2Bf18ukUNA
         9MXruOvZoYTmiheQ+mSx+RHBdEBiPW8iQdvyKG4Xby57MG4cPPwVGVmZ/+gpRF1gyCpB
         zp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774979310; x=1775584110;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9tkluilWSFi/zwAvCgNgh5sc8znVExg6yAujw+zfcHE=;
        b=r7ZRYuwcsCm2O5JVF9PXvVizJxfLOJ1kziqDJZXqCW2Tpdx9k5kLnZ0Uv05U4M+W5W
         Z/tnuK1qWStO5qP2bNQc32qsb19gHEx4nsAjfwJsK06Lhu0vGkODxH4Aq+go8/ltbQpy
         Oo5RYvqKq5wMjRL2tJ+8UHBoX1JEEaCHAGR6PobApHUqevfHTkGSpROc0kpdTuaMxDkO
         sPtTC6KMnfnSk6mL3j3edDgruq1BC6LAvC8tV29rrSq9UujpPzRokOME6YG2zfX2//Bw
         07aYVXhICKaypst4qgIX7qz8PjcPCUjYTaIN295+o4UbiGJrmXafS9DXxE42w8PuUPzO
         pM7A==
X-Forwarded-Encrypted: i=1; AJvYcCWtZDFQtgvmHlwmFWX4Nh4rBQlk6UUIwIzCMQNevKezIpMY/rr8wzV3g+GJaERlRj2u8u3UN019kiUhoTg=@lists.linux.dev
X-Gm-Message-State: AOJu0YwWhGeN5GCcvR0RGUXVzv4DCGyaTT3lgjE6QGKTuSjD0D75MajE
	mG1at70xtNkxjpsQupUeFdnF+LftkaTmu+YWUbbIBsyvzfEkA1t9oZSF6Pl7i9dLvRdtZVt/c9r
	jMKV1wsp6IWLQHuv3pJWMxQUE94W0KaxJwLKP+OsjfEl93oVH33LdZQILCX34zh7D1IE=
X-Gm-Gg: ATEYQzy7u8j2uibO/J5s+rs5Bi0y8forRmeleqlx0D2nplUoSsgQJWW+ZPJDrb7Vkwu
	9Hk4PeHXPWYYCvmjDNYz+WlCahcpDQtLC6DQ71H3di3/z+k3v2HHhQXwmyzYlW3tKs8Ye5WK99R
	Sj9KDK5Qzr8vKfl32zUvaOpL/iUyR4tGtsrpMKtVH87W2lbUc3sHsmGrWoez8s0rSSOCbIsm6fs
	8pePM6j3PVhm5l5kitYitX11lspBybSD9uWiMt1aSfGBzcpNrMrD1WxGLDor4NRMHmNTcQZdoHL
	65Z47KjKcCtlNbc3iIf+wZbOiDFUFamkEXgF39sCS7lJtJ5C9H/YrNClRTdQZfhpEELXFEQxxLB
	O26PgzRO3XOyxTAKkeM9U8BumDHe8rtDgEuDMrhLvWV70XJQgcBS8/WJyCNEU
X-Received: by 2002:a05:622a:a045:b0:509:144a:43bd with SMTP id d75a77b69052e-50d2c5b718bmr43350981cf.3.1774979310222;
        Tue, 31 Mar 2026 10:48:30 -0700 (PDT)
X-Received: by 2002:a05:622a:a045:b0:509:144a:43bd with SMTP id d75a77b69052e-50d2c5b718bmr43350401cf.3.1774979309635;
        Tue, 31 Mar 2026 10:48:29 -0700 (PDT)
Received: from localhost (ip-86-49-249-15.bb.vodafone.cz. [86.49.249.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c091331e0sm50383566b.8.2026.03.31.10.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 10:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 31 Mar 2026 19:48:27 +0200
Message-Id: <DHH5NGQGQYBE.31X8OI8AKTYRU@oss.qualcomm.com>
Subject: Re: [PATCH RFC v2 08/17] RISC-V: QoS: add resctrl interface for
 CBQRI controllers
Cc: "Paul Walmsley" <paul.walmsley@sifive.com>, <linux-acpi@vger.kernel.org>,
        <acpica-devel@lists.linux.dev>, <devicetree@vger.kernel.org>,
        "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Drew Fustini" <fustini@kernel.org>, "Paul Walmsley" <pjw@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
        "Samuel Holland"
 <samuel.holland@sifive.com>,
        "Adrien Ricciardi" <aricciardi@baylibre.com>,
        "Nicolas Pitre" <npitre@baylibre.com>,
        =?utf-8?q?Kornel_Dul=C4=99ba?=
 <mindal@semihalf.com>,
        "Atish Patra" <atish.patra@linux.dev>,
        "Atish Kumar
 Patra" <atishp@rivosinc.com>,
        "Vasudevan Srinivasan" <vasu@rivosinc.com>,
        "Ved Shanbhogue" <ved@rivosinc.com>,
        "yunhui cui"
 <cuiyunhui@bytedance.com>,
        "Chen Pei" <cp0613@linux.alibaba.com>,
        "Liu
 Zhiwei" <zhiwei_liu@linux.alibaba.com>,
        "Weiwei Li" <liwei1518@gmail.com>, <guo.wenjia23@zte.com.cn>,
        <liu.qingtao2@zte.com.cn>,
        "Reinette Chatre"
 <reinette.chatre@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, "Babu
 Moger" <babu.moger@amd.com>,
        "Peter Newman" <peternewman@google.com>,
        "Fenghua Yu" <fenghua.yu@intel.com>,
        "James Morse" <james.morse@arm.com>, "Ben Horgan" <ben.horgan@arm.com>,
        "Dave Martin" <Dave.Martin@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <x86@kernel.org>,
        "Rob Herring" <robh@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>,
        "Robert Moore"
 <robert.moore@intel.com>,
        "Sunil V L" <sunilvl@ventanamicro.com>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        "Conor Dooley"
 <conor+dt@kernel.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?=
 <radim.krcmar@oss.qualcomm.com>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
In-Reply-To: <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
X-Proofpoint-GUID: ZbunS9hAqfa2Wv6KL8XQFKBJvTI5Hq9Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE2OSBTYWx0ZWRfX0U1yf56o0xZj
 OotNT/Ld5R19n1eDU2Xb2MjNqYgLGDGeKG3CwcFzX9kM64Mpw2RYtcPzINEnedfaSwhHHUmQaoi
 tD1HTK+0f8xXTlkbnQ03tok8rrC5YRZsJh9548EJBLJzQeI2P65hdoD1Z5sXfm8w2tMPdimmeY6
 Y81QyX8bfqHCFmt4HuZDDa8EP7YNcGoB/6/y9syt3cqRoi7VruDStvKrl8NbEMyg86t0969IXXH
 BmPcMk43KDcHSdkDJbovTUi3ypGyrxk/o1LASu7MUMAAgwJp/PIjZh7FN16QSQ5zIdRBMlb8Ua4
 XEd7IyezQIvdAGf3M73IIqhsCPo2alksuYWm7GVgOnidZUfpp6g1NMQMp01A6CgSMF2Xy5WMTkc
 ERWuK3LGS6qXKs+3Iq1ckJahz9o0ejxMTiTnV/uadipmO8wxMkuyLzF272RkJQC6Z1TRn7eioNS
 kO8ODufIfHD9vElkFyQ==
X-Authority-Analysis: v=2.4 cv=IswTsb/g c=1 sm=1 tr=0 ts=69cc08ef cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=fuErIE+P63Icv3tqjtEZBw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=1RoDV13bKi5nvpdD3ZQA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: ZbunS9hAqfa2Wv6KL8XQFKBJvTI5Hq9Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310169

2026-01-28T12:27:29-08:00, Drew Fustini <fustini@kernel.org>:
> Add interface for CBQRI controller drivers to make use of the resctrl
> filesystem.
>
> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---

Hi Drew, I have just a few minor comments as I noticed that you plan to
send a new version soon, so I'll try for a review then...

> diff --git a/arch/riscv/kernel/qos/qos_resctrl.c b/arch/riscv/kernel/qos/=
qos_resctrl.c
> +static int cbqri_probe_controller(struct cbqri_controller_info *ctrl_inf=
o,
> +				  struct cbqri_controller *ctrl)
> +{
> +	int err =3D 0, status;
> +	u64 reg;
[...]
> +	ctrl->base =3D ioremap(ctrl_info->addr, ctrl_info->size);
> +	if (!ctrl->base) {
> +		pr_warn("%s(): goto err_release_mem_region", __func__);

Missing "err =3D -E...".

> +		goto err_release_mem_region;
> +	}
[...]
> +		ctrl->ver_minor =3D reg & CBQRI_CC_CAPABILITIES_VER_MINOR_MASK;
> +		ctrl->ver_major =3D reg & CBQRI_CC_CAPABILITIES_VER_MAJOR_MASK;

Major version is shifted.

> +
> +		ctrl->cc.supports_alloc_op_flush_rcid =3D (reg >> CBQRI_CC_CAPABILITIE=
S_FRCID_SHIFT)
> +			& CBQRI_CC_CAPABILITIES_FRCID_MASK;

FIELD_GET() could be used to make the mask+shift pattern nicer when
defined by GENMASK().

Thanks.
