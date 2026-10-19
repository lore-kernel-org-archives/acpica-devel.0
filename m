Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433818;
	b=Gk/7W/qoq5acNtGBNMI74vX2mRKoFBgEYUngJ3vUPUdmwZiDYkU2r1/LW48A2BUr0QWS
	 FWvP1C5YAklZqhgiEzlOd7VnXoOYvu8VwLrNMK0/gA1ONRHCZ6WTmWex/mITpIjQ6Rm1B
	 601tnv68S/PK4RphdZLKhi5dJ3brCIY6AcMENGEbcez9Th94YPheE2l0iTSbdMS6nAkx/
	 Yci3qeVpjeg8pzOMP8XvHhEb7EK/fLD+SuPjqHPI5g12C+idguzAQDtk39DGpret/JqdU
	 JLpnDUkCca6ATafByWQWjmFG4jx/u9SEJfMgRHCqkBV/kv7BFn8t+J6B2ap+1ZdCcaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433818;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ME3cN6VotEvPOysbvIMmDJdPx2UppASZcvsxt09CPAs=;
	b=arsJ91+b9NmAJSEZS223zPk8YNW8sSvkrhyL+BHpVKBFwH+tDieYuSSkh4qxYgOh9goR
	 vvA8P+S4cMtpJDjsXhKIxQnwJXoeNMR/RP23aIzRb+lzmKgVGDymvLnz5XLohbAOxh48Q
	 4mkp9jvK8oPPUXOdE5Kw5OcveFgKBi8kKJf0sY9zvbptzQp5k/iZDtiRWF+VqxQYhxkcG
	 WvC30ffHDb+9k7tSH+Op4KXgKz2JsctbVHc8ylywKqPjrv06f83JP/6QBJpPTUR6PNz9h
	 RpmT6q+H0WqbWjipwA8sG9LnsrI+599zbAoEXDxlUikKOKb8s+t8wtmZiwko/ig35vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=axJNuqcB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=euRQmwg4;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDD3606A31D
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 18:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EDD3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=axJNuqcB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=euRQmwg4
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JFP1De036224
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 18:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ME3cN6VotEvPOysbvIMmDJdPx2UppASZcvsxt09CPAs=; b=axJNuqcBJaHuVjYQ
	E2h2efGauM/+beb5rqtHhYdH2yfr4LDBETXMtNNTpsMcVxu/zV05WGsZErrGlF2K
	NBqWn4pGclrsQMKQT01KPyg2s68U4YtSd1vuXPf+6DGhimC9elShCu9c9uVj9229
	EqdIyf7P0mrR/shsMGcnyBRoWwOigvjtNRtqzesSIyu8b5KIQQ3qkVI83ScRwGg4
	MPQQ3D5/PraMeXaZxgKr8btYTr59ASH+gNhYPOZIAKqiHsj0TUvs7DAoFTrl+aWh
	NfLf97PMAoG84chGn+yYASVlJ/nMX+WXb+8FbDTtE+cRVje7e8ByDlHd/ssalKut
	LKhjwg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47jpw9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 18:16:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3510d0baf63so6106332eec.1
        for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792433817; x=1793038617; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ME3cN6VotEvPOysbvIMmDJdPx2UppASZcvsxt09CPAs=;
        b=euRQmwg4Y/FK3R/II78FY31stfBDXv6m+RG3jMgatwjilWsFuJ5JVEd8YTT1EpMjyo
         GMyT7kanLUI+XYiudZcGujbJuP+C5Ww4uco35AvhfNOmDQ3jl38pY60UxznxQ2CIyehc
         KYFNT8LRYzTbhn0OqFyPOQ0CYBlrcvlnb0yKQqCn2E06vFIup0bjOBNAmKp8vQguWMJl
         qGWVPNTif64kFfJ6bXFli1fEwqjRdKzQwj0HtwPbFFisizFo40MbDRKu+ikFuMgtLDsy
         QR5ZH7bYLZmaaB+ORcM0C5XRZhryGORPv2VKiHDmLnCYYPCQZ7p0E5hcSCfHj63YSf4u
         Qieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792433817; x=1793038617;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ME3cN6VotEvPOysbvIMmDJdPx2UppASZcvsxt09CPAs=;
        b=ttVnJAhyZtG9DPhhpX197xxtNFAy4vC203VukHu0z/KdBkBfnRdTEcCxcCtBLOT07t
         Wk9Dc2cFJECHT8iCSbof7Sk2kJuCKKBglfFJBaVXZlbgYmj+TjOdfZcfzFr9fwKMKV3y
         dEXUfAZqTiCRhzXlHLvbS61GppA9O6kttKDvWeBYYlQAUPhP/r2YZA9CmztEoCAvrDU4
         OT8SpsPErL0VYiZWFqhRRohx5bUGCvjMIvcwciUcXiKt0C8VaB+m6rkBTTWn7UbgnD/d
         9wRxgqkN9S952TiVH+n7g73y+xEn6Y4ml8IMf0ghUVzNArDSjGRaQOVnh6Snx99EHOce
         auEw==
X-Forwarded-Encrypted: i=1; AKwUvByBQ4xtZudD64+Fwf30HTFSv4h+oytcGPrpmczeYlmnhO3HCEWV94p9VwUlpNH/8Iq1gEsNKRBjzRKVfzo=@lists.linux.dev
X-Gm-Message-State: AFq9FYKiXoCCkjWBj5WCkkDIJKgWWRC/pVj3glsIKKY78DbrnwA2Jgqm
	gVekPqQhLlaYHasAXSSJ0CMjExtNLCvl1ITNkrbiJrpHFfkeA+UireZFSlT1O7o34DHtVnat/t6
	CMwHd9bng3W2o6ishjSi5+rLJbqblf1wSl4fRGsxt+aNnvY2ubEWLJU1sasjsRHVOoJQ=
X-Gm-Gg: AYBFou2xJq3cUMg20zaLiHWGYAm/ymdg9YQMFVGDYG0LqqqCvbUFLSF/4Z3if87txep
	WVjFXcMfJqSYMOcNkGCyc5nMG+mzzUW1tZEgHzAVIciQ3p3XMJSAvDSUw7+fO5vurT0Nsse6PsO
	OwhFruPw0mgpyNfUFPmcKMMroax+sOIuW2XYB3AjXCkpDHVrVfMFIz+sLaxY4T2UI+CWgAdBxPf
	QFU4rL48YsmCfc5z5zAQzRRQ9NBYyKWSGvzII305+yf/oZRqKuzLhTqCiVsHhnAFNu5U9EkSfTJ
	ID/x0iRuQ2osZylE3KD6LYG0NDlyrblBPEc9tziu6ve9ojW/EEOYJELG4aoP7XABWYsfridk4Xe
	i5jNFHpUygvW+kcL6LcqyaeHqi/Xtgo3IZPxTu4WOwQ==
X-Received: by 2002:a05:693c:87ca:b0:35b:c1d2:eab9 with SMTP id 5a478bee46e88-361a2e3d3abmr11081716eec.39.1792433816857;
        Mon, 19 Oct 2026 11:16:56 -0700 (PDT)
X-Received: by 2002:a05:693c:87ca:b0:35b:c1d2:eab9 with SMTP id 5a478bee46e88-361a2e3d3abmr11081665eec.39.1792433816173;
        Mon, 19 Oct 2026 11:16:56 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36083283478sm32477142eec.29.2026.10.19.11.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:16:55 -0700 (PDT)
Date: Mon, 19 Oct 2026 11:16:48 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mark
 Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov
 <bp@alien8.de>,
        Hanjun Guo <guohanjun@huawei.com>,
        Mauro Carvalho Chehab
 <mchehab@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Maciej
 Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Pawel Chmielewski
 <pawel.chmielewski@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>,
        Breno Leitao
 <leitao@debian.org>, Dan Williams <djbw@kernel.org>,
        Terry Bowman
 <terry.bowman@amd.com>, Ard Biesheuvel <ardb@kernel.org>,
        Morduan Zang
 <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH 2/6] cper: add Memory Error Section 2 structures
Message-ID: <20261019111648.00006fe3@oss.qualcomm.com>
In-Reply-To: <20261019145643.1877246-3-pierre.gondois@arm.com>
References: <20261019145643.1877246-1-pierre.gondois@arm.com>
	<20261019145643.1877246-3-pierre.gondois@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Ri21gRXzB5KJB6ZGRXzw7V4rzxYrmXKF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3MiBTYWx0ZWRfX1D7HfWbCQzxw
 vxTw6B0MMbrqR9NoSrtgRvPbtVgOOpEQoGK1F37/oIKH/ezk7jO0Oef1/QQNHMYEypK1PzCpR9M
 ho/GJXWUEZ6pebSJqmP0mDDVaOOHzXyLUQ5lUdziKVQCENsVT2xFQWWaBLzpf6s/vzpiUHwEFJG
 5sKG8ers5gmMrfngmjlINXK1PrhtH50vZ20IonCQ9nC7DoVxHZJq4/PLw0QPWpSSN7REGHkqMWI
 IPflriXJrK6tC9qN7J2SD8LOLmJ9g9uR1S8SrZztSC+CcykF84VUUGNO9olA2qpEf13wMgPcsLF
 cB3BsF4YYRO8Ubj8jvyf7XKS88KrnV7GIleM7p5xKfQTO0bR3+JCQQFI6KFh+yfmmk2PVCGgJub
 MpsyAGkqgJKm64zFLn3WSwkmwEZWdELTICQr1w6YKiXv8vGkjCy2bI+uYMj67hRUos+1i9KAnSQ
 OyKlkkkYWArgdwR8TZQ==
X-Proofpoint-GUID: Ri21gRXzB5KJB6ZGRXzw7V4rzxYrmXKF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3MiBTYWx0ZWRfX7gKxsYscRZmT
 fEMaIABLAQrVpHPnNl9MDUYPLhz2BHqtlW44JioeCk4Qpo6wpYO+t0x4Fm0Vjc2IofC2PKkL4dW
 kf2TFVasPFCEgvR6aIWhTYivhnE0ipY=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad65e99 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=D-Xi6Kjd_1bfK2TynAAA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190072

On Mon, 19 Oct 2026 16:56:09 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Add CPER Memory Error Section 2 definitions to the CPER headers.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Checked against spec and the couple of commented names
that differ make sense to me.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
