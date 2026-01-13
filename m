Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0863530DD25
	for <acpica-devel@lists.linux.dev>; Tue, 13 Jan 2026 05:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768281209; cv=none; b=bXi30/Um9ztKIFyOFC9VD5dum1GcmRiXnSG8GQaCyRMfHyIw8Aq/Z6SigLSbWkQTw4EiH63NbdvJEUdU1GzDqxsOKGwC/EqZG273WPjFzhiHA5KiVhty2aAeOo+AwgYvanB5vIqGnBHAHigP6463bApjua5kZCDY7r6CNWhzNSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768281209; c=relaxed/simple;
	bh=5RD5WrNMzywR0/zMCxxyZS30F4/0MelxtGDY9ehw4VQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEA3omj80nt/7xwhhvwnTG3Yn0c0E2r7AdA9DfAEUxdbSNSS9ZZ8TJ2rbDgS3lsK/WXUKShhHx4Tivd5xftFObK/GOVva88kM+nxBeqbm1HVHRdkyUjWgBHVTx+1IEE0z5mgcySvqKuUwZVKzCNiPXIMPl8R6yrrN5ICjquLdVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BALsIr6G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FMmvP2nq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BALsIr6G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FMmvP2nq"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CN4vvA3299678
	for <acpica-devel@lists.linux.dev>; Tue, 13 Jan 2026 05:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=BZHPhzXJ0Mcz+3zRww6wyIQlO4Z+6GX7AaKUsI1bag8=; b=BA
	LsIr6GJT7JWvOyskC1k9p9VJbn3WWoTC+ig5mjlApKnZD6xZWBQ6suqFZ6hqdw+U
	WtSBy5PEM/KUvMP9mGDPoCtZMnIyKKaCWCTMXgFE2cy2WDxoIbcgqYHSbwAL6xP9
	5WeAy6J0N2HKNtJ/2dyiA9l5jXGmdSwn5ACFnLPs8soxhrm7vCxPY37l0AI9mHsL
	cYaF65LYlXzU1D/CiMNWY+vxWvIBEhdn2zn/tD1sECzHQ3SPz9Z01lvrFhZk+Ect
	2mKG3kWKOQQ7NeKPS/GO0tAj0y34ag0tYPfBrlHYq39cHJMmvediql6Rg+5nmdy3
	lxuSUSjC2zXSIOCtZfAw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6jm9f8g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Tue, 13 Jan 2026 05:13:26 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88a43d4cd2bso94422696d6.1
        for <acpica-devel@lists.linux.dev>; Mon, 12 Jan 2026 21:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768281206; x=1768886006; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BZHPhzXJ0Mcz+3zRww6wyIQlO4Z+6GX7AaKUsI1bag8=;
        b=FMmvP2nqI42k44cHV0xpS6vW4w/OXhS7LVH+qhc35kTw2qxGd8tOyU4ypEx03LMsAS
         gWeSkS5dyOyVf07KpUcJLi7wQ0QMI7k3IJHdKm2NGLvSVmoTsgVkq3FSlQ/EkQ1X7xus
         N9OXvUsFuIRQ7XpYcxkdq2JTybeZN2xvCgTjbkQGQg1x9ytS1mCB+0ctkXpapmyOYmyu
         sDv4wpstENrQaD9JcIiKhmOSuK/xiyaYCyd2IGhKcZPXWMO3Jg5qUq/0wNt2/oMMtUF7
         og/5LPMHVfUZxaku5NNgXvAg4zGkKPdLOHuPpZf7QZ77rlHGcFQ/YDB3zQ0ti4hO49+Q
         BNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768281206; x=1768886006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZHPhzXJ0Mcz+3zRww6wyIQlO4Z+6GX7AaKUsI1bag8=;
        b=TtDoltgnD7REDnfSbjLqapGwA4PHkjn4iUE9bx/y/Z6LOka8ShCuxx4xMQE2c66+fk
         R6rdhtmlkTemqG79X0405uWGdgfhcC9dc9IovhbypX2frPY+ta9XJwRZjnaPNdWvNi03
         GU5E84rBdJcNNsuhvvzkSDsUU888RB1Ev7BCHPoQnWi/b367vC2PBwl2M/fKwfYOGuGZ
         syXywfOpqtjraYD67q5VqjIT+iFXOpLwBzaHhHYmO6rjLGizRsPZ2BCsCFUuGTTcKQX6
         J/JBLLTyoa6o1lJOVn22uqdiBA88r/Zt8PQEupPahWf/AWBZ6tIdghWjOCiErHYczlxw
         zqcw==
X-Forwarded-Encrypted: i=1; AJvYcCVv4yM4GAFuWbAMBRAEBqLd6W2zhuVNp2s29BzB69IICa6LFPWcxJpwR3kpsZqDZkUMOXkiHucNGes/PHM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3zoxNWqJo31ztMZe4K31EUXqQ6N4/yJMpD0aZKJu1DdpY730T
	PXRbsfzr3Jc77WG1qk89V6GvAmMGPlYHbazH6lzbrnBynzH3w6rQS5ubUSSpzuw2G2d/IdWGjA9
	GhKgjk7yTwlJv9VAmqPDKoYdUsLW35rp+MJ/hmeGPchetIQs/f3qKDVlCJmcLLIGe+mEm3wcP2f
	ovIML0yBxpF+T+SZHl1Mpcb1iUSWpJlNRDGVnuKDOznQ==
X-Gm-Gg: AY/fxX685/x3VoBqQohi1xtwBzXk/QjSSdkv6o5i03Dk3PW/LTmBw2iv9joQXL8w+bG
	hGjZAZAE9SeaTI1zIvQ5vHdfN6frKRBGm+LrzjoITsFmlvV/GiwiURYe2gMXP8jqEYHN4pZdQv1
	pMMVInGa08dGOm3r/v2jYS1SmvgvRAFCec0MaW5bUn5KsYV0SwM6+A512UdhzJahHg0g==
X-Received: by 2002:a05:6214:3bc7:b0:890:26d5:c1a0 with SMTP id 6a1803df08f44-890841839e8mr329033146d6.13.1768281206038;
        Mon, 12 Jan 2026 21:13:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExMAuvIVLlhHW04j7bO5r9MvIUOw7zMKjo1ttv/1gvnxGsx7YpOc4AlsHQuO9SAX7LPChaIbqWy0tH/97CcmI=
X-Received: by 2002:a05:6214:3bc7:b0:890:26d5:c1a0 with SMTP id
 6a1803df08f44-890841839e8mr329033026d6.13.1768281205621; Mon, 12 Jan 2026
 21:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com> <20260109090224.3105465-6-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260109090224.3105465-6-himanshu.chauhan@oss.qualcomm.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 10:43:14 +0530
X-Gm-Features: AZwV_Qj6V3rEVBDFKYHXH8y0L1nrX3Jw3QzqIWcDU_wtoiZfXPhPZIbxRemFGYQ
Message-ID: <CAB19ukF+3tBG=nXe8is5_3xWkt7avjAQ2o5cS=44SAf0mkVPwA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] riscv: conditionally compile GHES NMI spool function
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
X-Proofpoint-GUID: wVdQWPqhJS-CH_5hjSqgtQyS7RfyavqO
X-Authority-Analysis: v=2.4 cv=SK1PlevH c=1 sm=1 tr=0 ts=6965d476 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=9L7PnyXcnU1f3mQPG5kA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: wVdQWPqhJS-CH_5hjSqgtQyS7RfyavqO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA0MCBTYWx0ZWRfX5WLhT8HNdf0D
 D9uSxp21NQJ+yc8YjAAtIpalAR66jSYB25WeDq2EyGY3q+tbTBM9F1ewMbzR9KrdM8w/DjLI8mU
 5orthnaN7SADJ0YCwCPLbG+UufmW6eYyfj0OSoCVOfuJ1LwoLxIfSqOsMDcZjscy/n3Vzy4MiwS
 wq4qc+9tpyRz9J2vvrbhsmT1rOSJkky+d1fwi8Dn62VweGvRs73EJ+K2yx1QGHVDM/FIiLtQwNg
 b2RVpQCcTWg1t3ORTmdX0kMGbsuPmnAMO9zk//AkZS91JejjY7gwkK27GGDcVYs9KRfMEA351Wo
 oWls07AWDNrzuw+FXdQCet5dX9nbJYH5qkE5knz+Hoged+pmUCiQF91DrqazLG6VNHjh/0GQrNG
 67rFwYnkuCn/MNd2DFStSeMCnA+Ol3QCzjGqKKp1tqdNfjMY731mBPTypFAxlUHn9wP9t4WiziC
 KkWMgFxmQwDlkr26fIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130040

On Fri, Jan 9, 2026 at 2:32=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> Compile ghes_in_nmi_spool_from_list only when NMI and SEA
> is enabled. Otherwise compilation fails with "defined but
> not used" error.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  drivers/acpi/apei/ghes.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0dc767392a6c..6fd84a1772c6 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1387,6 +1387,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes =
*ghes,
>         return rc;
>  }
>
> +#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
>  static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
>                                        enum fixed_addresses fixmap_idx)
>  {
> @@ -1405,6 +1406,7 @@ static int ghes_in_nmi_spool_from_list(struct list_=
head *rcu_list,
>
>         return ret;
>  }
> +#endif
>
LGTM.

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
