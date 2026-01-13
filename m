Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816923803EC
	for <acpica-devel@lists.linux.dev>; Tue, 13 Jan 2026 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293730; cv=none; b=YXD65p5ZTy7AsdZ9TYGiYlYOD/J6+fGa5V1mwCQJhdVRDqA8jUSaTlcfkEWwnRbXCBa+PCovz/U3o5ui337wwmhUTkvkgVH2Ly+xr02FMKHqPpwm9OLBKyt3SOXKBeXtTsrxEOsgzWWxZTGrLR3HmYOL89MuLj6mRp3HazYHHsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293730; c=relaxed/simple;
	bh=5RecTGm365RUoJMEkqeB/sqOi4xLmrfY6YTWJNvhWmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ihmm1tVYn4C/rHAo3iBgSFkiu9QJCKhfRPtrUVhI1LMTpmQpo+cX8M6EMJGqJNeTZCsDJyh57SG1cb00uOn+AbkjuOxfC/0w21rz7jGIC/ZAC//780O+01BR5Y+V4ux30m1j/N1S07aHV72BKyV+Ou8pi/a5BaOAp7rOX8mZi94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oCRv0Yc7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aXOuPUIB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oCRv0Yc7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aXOuPUIB"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D5aqb13636924
	for <acpica-devel@lists.linux.dev>; Tue, 13 Jan 2026 08:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=gMMQfkmso6EqTlKeQEIEJn6dTWYUS6uAjenTpc28WAg=; b=oC
	Rv0Yc7voplOJZGPIG+HGVNrv1yJUbGTtAr/0T90J5xBbbGRXbHTsT4PZQDK187Sd
	5dq9JJmBcFMqj3K9w8ns7D1vIt4EUn9Q5BeStCe3AMyVdBx40d+owdeDUjE2fQIS
	WW40/Ja0zGgBx4fJ0SEkTlPOP96lOPK18PN1K6X3yiJgzKGTqgiShP5DM/i6rFOV
	BV2v28SOxRuzDuFigKIM4g8VRfwYsR1QVOds9J3iz3J8pCv0ebYmNfbbQ/4lfCbd
	rp7jdJgfzwr1gMGL9LMgDeCsO0YPajQYgtx8WdlXch7AuxXggLFxLdM3VZ8GleRH
	QbsEJ6SWkMi0tkd0UcGQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bng2c0hv3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Tue, 13 Jan 2026 08:42:06 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88fcbe2e351so159465276d6.1
        for <acpica-devel@lists.linux.dev>; Tue, 13 Jan 2026 00:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768293726; x=1768898526; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gMMQfkmso6EqTlKeQEIEJn6dTWYUS6uAjenTpc28WAg=;
        b=aXOuPUIBBMD+fIDVZjM1fauMqkltVc9RNzuMSdN0r7Gg4aPIfm4W8OYetGZb6pRZKo
         lghP3ujXzAXOf/eQ/7rvvNyxqhibTTf0KcBQKTMX9PM6nNVS2clVIQaJ0NP0FH4DtFrf
         UEARSjX8niHAS8pEAAC7CNett7+Cldpf8jt4sZ/TdQGLM82P7pD5c+yftkW318l9DAGb
         7qunwe5EDsVx+SsJuLQSezqczuk8zCTrONpapMwNqnDb4z1oqMaAKGOqtu5a14vigkU5
         YbKZeigtKh5V8jykLgS7UA44T1/ljVCLdTKKDojFrOAgqKUIld6uSzbs9txT0YRH1xqV
         mGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768293726; x=1768898526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMMQfkmso6EqTlKeQEIEJn6dTWYUS6uAjenTpc28WAg=;
        b=ex1ExdmHQKUvTEcPF99sy6LEkr1I6M9QbwYtZMaqd8zlN67eIiLf4pdMaxOLJDRayl
         wC4Z3smnD5IWi1petUDFxmev2YTvu+L5/g0dyGMMR69npE00H8jGUcHTqqHSlQRqEB/t
         FAdq9wjHoc7NL503I7ql2JHZyOt1M6qD1bbWBgnJ6XFs5RK+yFZM9BDzLP+gbkD/lBMK
         V47GhRyh8kT3a+DhUZgHFJX84j5b2ZOsujRjVQ9IBeKx71Txd4CuFBeZoW6pBeR+6lso
         mELozPCfITsdJj2HnHuxZQEAug6b2lOuroHuTIjC0W3xhDZ0wWmiey1WCwB/DZ2R+u+J
         e1Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVfpAWIfr4d49pOSl16HMCg4XV51ffcnRdML+Zcrr4tYCnjP1aVMgqW0D91enThlKWMPWmrnpIKaqtw/wc=@lists.linux.dev
X-Gm-Message-State: AOJu0YwgqNFdbL4yDrTaRnQ1iHmExxSemSHLhdSphq8HCBzskZSrux9/
	VyfCC4TCNxSE28uFT3sX02LCBfkHA92DKR9VY8yusPjVHX5EyeL/RbqB2TqfvPO3/EjQvMYgFyl
	Gsm03GExn0z5zB+Hv612Smx7kdFcjbdx0sHWarICAT+XzU8OQjsybyOxqQI6r/zFK67ECZGLkOR
	xgb5YoeTphHVEYQ7ndpWY28NMPM2RFvspEq5IvnZdCUQ==
X-Gm-Gg: AY/fxX7Klj8IfOgNcGSRIl7zX4YQoYl4z/96QokoD8oVp+RU8qIZOoLpA8in92O7cni
	LJAsqcnSTBDdeK2GAnuAo1aiLMgkjyjzQRY+REQTo0ZnLg02brYGBeLFn3cuCN/2QYchQUCX/K5
	Kz3xgHvSqJV2Kx1g1FoLGMLOhlPLjy/c5zZRiCA91Vuni7cdPaMYahjjMuJTWavqUjvA==
X-Received: by 2002:a0c:e017:0:b0:880:4272:9a4e with SMTP id 6a1803df08f44-892661a78a8mr25805626d6.10.1768293725693;
        Tue, 13 Jan 2026 00:42:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJYJUOMDvWx4l8hA/velk17KC5jXEUWmnRlBHDEYXsu1TKZmLa9YbgjQfnsevRZSrydtA0WA9PnjG8rM9/N9s=
X-Received: by 2002:a0c:e017:0:b0:880:4272:9a4e with SMTP id
 6a1803df08f44-892661a78a8mr25805426d6.10.1768293725320; Tue, 13 Jan 2026
 00:42:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com> <20260109090224.3105465-8-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260109090224.3105465-8-himanshu.chauhan@oss.qualcomm.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 14:11:54 +0530
X-Gm-Features: AZwV_Qh9cMywaFsFi6xL1Dz9DO_-xJHelf2IMNiJrFuansm4cMH8oxrnVD1xemI
Message-ID: <CAB19ukFj7BiyikY7Bmnu5uWidZcBhL7Vg+Yhc8exstKj_UnRhg@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] riscv: Add RISC-V entries in processor type and
 ISA strings
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com,
        anup.patel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA3MiBTYWx0ZWRfX/nFCLwm3wQRl
 3VdPjGPdMwKla0aOS/SyCQanQ7LaZC/8DsjJoJDN8WJV8MOR+wkz8jJR033mQBP5ZKe6P3izaIX
 wbG8GoaFzSsxnDt3MAd4tIv4sL/Xq/iaU5gG1qo3iNxY6rDMcpvM3ofYMDOj7oCzLQT1CrhWG8G
 WXdjcw7RlZiyIe+O0brJ2oRTxot4/TC1oJtXDjczmcAnlC3WBU0o2aPX6Il7lkR1Y3QeY2R+fKV
 2eGP8Tapzl5x2uCwe4oDZmWFdX0rQI+Epv4aRZgmUpRdIiejFg88xk75nmhY2JCziMampKKCQxT
 3iVL3AFqZ7oUP+vZsdLl5bwk+DH06KZ0GC67WlM4yCZouOhrl0XS6OHtRcyVCMGLDTGQvDbV0K3
 T/cwIeS6aFU7sO53ixpr3WUWEEMS2Q1MQ5YDTNXfcbygAeQXhtlDJ26owe5utVWn04mjut5fusL
 j5MLC0laqDCwp6bPPlg==
X-Authority-Analysis: v=2.4 cv=C5TkCAP+ c=1 sm=1 tr=0 ts=6966055e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=xWNtRwkhHlcOdG438WIA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 7wg7HwpWwiRTcVdm9KkI9ykJ7I3j4NJy
X-Proofpoint-ORIG-GUID: 7wg7HwpWwiRTcVdm9KkI9ykJ7I3j4NJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130072

Hi Himanshu,

On Fri, Jan 9, 2026 at 2:33=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> Add RISCV and RISCV32/64 strings in the in processor type and ISA strings
> respectively. These are defined for cper records.
>
I think it is better to add the reference to the ECR in the commit message.

> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  drivers/firmware/efi/cper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 0232bd040f61..9d591a294327 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -170,6 +170,7 @@ static const char * const proc_type_strs[] =3D {
>         "IA32/X64",
>         "IA64",
>         "ARM",
> +       "RISCV",

This should be "RISC-V" as per the ECR.

>  };
>
>  static const char * const proc_isa_strs[] =3D {
> @@ -178,6 +179,8 @@ static const char * const proc_isa_strs[] =3D {
>         "X64",
>         "ARM A32/T32",
>         "ARM A64",
> +       "RISCV32",
> +       "RISCV64",

This should be "RV32/RV32E" and "RV64" as per the ECR approved.

Thanks,
Sunil
