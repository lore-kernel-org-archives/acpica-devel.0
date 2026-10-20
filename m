Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516258;
	b=y93iSctR4T1+PxuFLiZEfLzpNo4P/xD6uTmBsRjQXNoxkF1VC37R6jTG9Tq5W/D/YC9u
	 k3jCS1ePIhEMc4DLM4x0DnrhmwQE6EI4iJejfhkK9OMDQnC5z+9zPuLWnQk4TA70RLC/9
	 k+IDOHBrpYuY9UNKsF9eDRe/Swh+84SAydhlCKWehWf43gQ477f7jxoonFnx80GiJK3Ga
	 A9r5o+WIEeelizxKo5qlpoH+hAI/87eP97mhQvsr/CToYS4F2KmtuMKqyjLf9F+kxQ6vh
	 jJ9kTGB/6XY4hJKc7sE0ZpegABqJYzoIJb/AFf3vlE97946qG/KAjrc1d5YwzcUrHHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516258;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=XuGp63Zu8Xhb/maxQXifefMXC5yHBwIeZ7UZd8sAo6g=;
	b=YzGt+wBCY50MoeVO0/8qBWc8NQ8FTgSntND+LK+8Ftw+5lkRaWTv0cN+WbWmNavV4frS
	 lNTHTEunMtSSm428Rf14Uk5mqqQVzFWxkqcR8ds0I2YKFdPCLdZAxqYNghOC75Ba093D6
	 VrnlUOUD5OUM0JCkElcxilZV0Hz4mrHIsdYoO9gLxpDaeXVKTwQkW39cp8tIOamoPW4Xm
	 HUPmHUQrE4aNIq1fKdyAOTIuKq1RE7Q3/DM6okfwmAZXk7JZmwZB/JXs8iYVp/n+qVrTH
	 RbrUoyzoT6NNtsoIlcS9vD3SYMJJzb3DuzK210w42s18/euBxEtMIWwwctNeI3xF7VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cr8UEhZt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cTSWS7Nf;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B04606A33A
	for <acpica-devel@lists.linux.dev>; Tue, 20 Oct 2026 17:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06B04606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cr8UEhZt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cTSWS7Nf
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KGu4X01926022
	for <acpica-devel@lists.linux.dev>; Tue, 20 Oct 2026 17:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XuGp63Zu8Xhb/maxQXifefMXC5yHBwIeZ7UZd8sAo6g=; b=cr8UEhZtHzcb3IqX
	cktx1/Tjz8ZOrSW7yg+EZjyDKalpeLFfVXvVcxfZ4GpdXdFGuKFaPVtumG8TBpri
	Xs+CjKAOSb+4yXKrNTEvUFfYF9t5qD5MbmfqqNGbF7psV0brw9s0rYH66Tr2Ii+I
	oAzpuwaR2C9LAdKXF4WIU8Xj45vbbt4KJOw0YjDlnlyKCU+hEHkOS05mR8edq5LH
	1T4Uqdy/B2K+cc3aeodyeQl+RvcjSR6jknYOZp+7eUQ0ijDlFgZ5CAj7yzfnZf4n
	I9vkWmzYQ2gVYynfg6gUE3FuU1mfMOkP9J62yHxw9T8pfBJTDHF5e+jrzE/VHrkV
	meRLog==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5qbjpm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Tue, 20 Oct 2026 17:10:56 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1665200f4c2so4706965c88.0
        for <acpica-devel@lists.linux.dev>; Tue, 20 Oct 2026 10:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792516256; x=1793121056; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XuGp63Zu8Xhb/maxQXifefMXC5yHBwIeZ7UZd8sAo6g=;
        b=cTSWS7NfrRjEAMdqftuAbsXinQAnEWTh4rtXSEmSvr6WI2aufVEwg68gZ/MzrwndOR
         ivehWX3mSYGHf4Vb28OGtMUbkyiiRXCJnBAkDaspsgaGGy/dCt3/jUXFcI9PXDC5qctk
         U+t1NT4v4iUUcMOG3I3mTFfDlRoCYhb44shND/1R9S79ju5wQB1zotRvUpTAk5Hvp2OV
         4jIGYAXFQgAXpGNZfSTpBO+oVjqOxdC5UgLzjuIT3JZzgSrYCEy8PemmuuI1/Wedi5oE
         jw7yQPzaW9NlPpYnIUoU9E2DUv3Fnza8dkqH2JvR2wgdTTq9GYXVpfMMv2OgYJMbubre
         Dy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792516256; x=1793121056;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XuGp63Zu8Xhb/maxQXifefMXC5yHBwIeZ7UZd8sAo6g=;
        b=hMNHXAWJi/CUqWfA6hOdl/IjiwiEkGSEAm5l3ZZ3uCg7HO93pf1BXzO7IviJGTzhnb
         AePl5UvWAp1dhLCeuJGMlt4BVdPM6HvUl52MlAfdImgGb9ATinYOEm1piPIhsDBAtl0D
         Er2tixYKFCO6Y0ymoDJRVz6tvqxaLH52WBJZQMYz4BZQps1CbMOmkp/BIpIcIp8g0I1y
         qthu20ATmRPXvcjnCaJJfa9cFKatgLjNdoJfTB7ZaIRwEkNMfE/SB1IUlYrr5V8GZz5W
         NPocmcGPdg2lWB82quvhwpvbgRbPYsQ8aruXM9Fo+mn10fL7YZ04czFyw4v+e3emM1ze
         0Wtw==
X-Forwarded-Encrypted: i=1; AKwUvByKnVzMi2A+SmNsI8IUX3HShpFZSfGGMTw6jXVjCajCVI3IFPZJkvRmacajoM/LbhO0mShwPWwdcthbruI=@lists.linux.dev
X-Gm-Message-State: AFq9FYIdP0S4UGcDxnb12gGdjgfpqUYK/5JDN2DV8SwZCcOubWYKNMa1
	2KiZztKIY5zJnc7ZTeB+dKpvdylintaNU6VLBWxYrPvaQLXG0+Xl7edB76CV8T8fFUrqIPjEsPr
	jAiLia1EhLoLr/7in7vd3Ht8lXAa06OsMZPLCa6vFZAHD0gTGltpK0F9mtYXKMOtXzY4=
X-Gm-Gg: AYBFou3UsGUwsjrqnAp8DYCxp9mO6hlJRW1li9y4I5k4XbcVfaoXDZpqOLaoI67flWB
	9j/W5VoGx2bATlVPAOS+8y/+DCIrTzW8uod6ePbtIqyGqgbjQOzHjFgnF/EwxvMRr9Zb4qq3OIP
	sNubNkjO3Pn6t2o9dkNGjKXBHaXk/pI7J+LLuKusp762AphzygzkeFL36lKk7bEjv0vFNzfD/yW
	BMk3c/YZfMfU93Ua5m1PBmkdkXuBGgCjh+CSEzctNuiEWWL124bFLOktuYNbR7iy3ceQnf7YE4U
	LJekL5vQ6F/Ekb8UVH/3a8890vp+aDa9Zd6UWq2Q6b1yP3gkwwS6Jix3PuvwT6zHRd3QhP0zyXa
	JhcttJ3oWU+a8FlihKw0gOpMUYol7ye/0+RI32P6ikQY=
X-Received: by 2002:a05:701b:4587:b0:17d:961d:7db0 with SMTP id a92af1059eb24-18512e254fbmr15146319c88.28.1792516255330;
        Tue, 20 Oct 2026 10:10:55 -0700 (PDT)
X-Received: by 2002:a05:701b:4587:b0:17d:961d:7db0 with SMTP id a92af1059eb24-18512e254fbmr15146268c88.28.1792516254593;
        Tue, 20 Oct 2026 10:10:54 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm44388c88.3.2026.10.20.10.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:10:53 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:10:48 -0700
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
Subject: Re: [PATCH v2 0/6] CPER: Add Memory Error Section 2 support
Message-ID: <20261020101048.00000186@oss.qualcomm.com>
In-Reply-To: <20261019203915.2019037-1-pierre.gondois@arm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
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
X-Proofpoint-ORIG-GUID: 9-byG--vTwq4svqGgXF489R4LkmzACdm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2OCBTYWx0ZWRfX0J/k7BKAGvPe
 a1r46MCwQnvNZTX3VDRkr9IGvX8AkLLBrh4qL/V3eRCwPRzXykYNyhWI2GQTt72TVT7IvnmaBgo
 g3fY1YQdtYzJCA7rWNd5F3gaRA5Eu0Nj3UNfAMRoTLSL1XiZwr5wk17n1tdi+tKZ5U+kN9/tqpr
 4Yi68ZvLN/qYf6HBboXkfgCS+HQvw7vie+cN9uvz5lyBfveubhMFHSQUPE3pbS+OHeoomY0XQKD
 G5OoPEC0HsI9ofqsjHWUypBT/mcLZhAGrGsPbFUYcmhvAd/dYUWIw8u0F8W4CxFDxTzR1bZ0vZ4
 1FpUQahujKokrSlEt96xrUMjYXk8xJuJaoF0n8Y4dXOnqP2CQM5JohEm7qRurYjd56mCDnr+KZF
 oMiuyleeKo3ACCh7seNCE3MGUIpJCeT1LwkyvqE2Za3o0Fyg3LDDIxjIdoEMtyB1vT84oVkZMJ+
 QD7UVZFJjVI/O0BvFxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2OCBTYWx0ZWRfX5S7lgpggEmQZ
 NJg+VBJHB33HGLH3T91sDo9gfloD0gkGe6TROAFMXoFs1EiCRts+w47H9tbrAIZ84UY3+kpki8O
 fcwSxXVz0TpYIWwhoY8so5hDy+l/CMw=
X-Authority-Analysis: v=2.4 cv=LpcHWXdc c=1 sm=1 tr=0 ts=6ad7a0a0 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=7CQSdrXTAAAA:8 a=5VxSIjaA6f0WmzOPONwA:9 a=CjuIK1q_8ugA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 9-byG--vTwq4svqGgXF489R4LkmzACdm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200068

On Mon, 19 Oct 2026 22:38:39 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> The support is mostly duplicated from Memory Error Section handling.
> Other than differences coming from the content of  Memory Error
> Section 1 and 2, differences in the support are:
> 
> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
> This structure was used to support older versions of the Memory
> Error Section (1). This is not needed for the new structure.
> 
> - The compact version is also used by the tracing framework.
> To avoid relying and propagating a non-standard record format,
> through trace event (cf. extlog_mem event) the new trace event
> prints each field individually.
> 
> The last patch of the serie was only build-tested due to the
> absence of relevant hardware. apei_mce_report_mem_error() and
> arch_apei_report_mem_error() implementations were also removed since
> last version.
> 
> It will also require a proper handling from the rasdaemon. Applying
> this last patch without rasdaemon support will silent the reports of
> Memory Error Section 2 error, cf. ras_userspace_consumers() check.

Hi Pierre,

I'd slow down a bit.  We are mid merge window and convention is normally
one version a week or so anyway.  Better to gather up feedback from
a number of folk and spin only one revision to cover it all.

Jonathan
