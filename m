Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81605335AB
	for <acpica-devel@lists.linux.dev>; Wed, 14 Oct 2026 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985201; cv=none; b=lUb0Ps8lcFV0XR/z4knWhn8HQiytmms2i+ilfmhKCddr8dt3TiHB5iC7fOCXnk4hRRswX1ITsXu6TktMHyAJlThiExciyP7o2RVb75VxaA6SF2dKkI1RYQZFui1U18qg3hPJTa6Qn//F95J74Sfv5UwcwQBx1Vi6qLW/i2tEk/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985201; c=relaxed/simple;
	bh=0xfdTrDLB2gWOdwJBkzEjPw0cKgTkhuJdf6y1UsT6YM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ShUcjyWrKLB2yQdhd0m15YEkgKs8Nv3AMBc/r0PPJjM9JZlRjKyNRZlMnZOsknGddgS3goyTpvwJDpwNm9fjm23FyPP0vjHTJ89nCP7W46QuuL7ENtA+mvrdysUtkYo+flxduF7MlSWZcGaYzGpppZuEFH5EuDizcRMnxG3QupU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m5kxVZpb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TLheYqYP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m5kxVZpb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TLheYqYP"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ECLQuF2088499
	for <acpica-devel@lists.linux.dev>; Wed, 14 Oct 2026 13:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NKJXy1eO5vGiVrxvsBEG/GIMF2FHbHhV5DLbt20ey20=; b=m5kxVZpbI7GUQhYx
	Diuw2Cb7PXF2g6Kk1nf81YlMx8pkB+qU1KrTO49M1fg/2pg+9GIBh0oZ2qhU18m0
	OlTVhT2PClDiT5R4bvvnbThWGaBEEB1sQizX6fNJZMIAvmP0NmUcNCIkGJkCqlsl
	GdSbpDp2H8JmUuCTeHGRduB42x8lbbtT1GrxcqkwgOo78w+ZUS4Czv44bIEFLwf2
	kcaIz2ZfZHeRI2lY/2u8J0ektqC3HP3UmsupYKEkt/sBfqQdqpasMZXrGTQGugG5
	KGdqAYJ2z0AceXufVEwCSQfO9PePeCvoM4x/MCakC8A//Yzojrvm7JHg48eyIhVe
	TpkCaA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9x49k3rw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Wed, 14 Oct 2026 13:39:53 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91b7e7d5f56so70550376d6.3
        for <acpica-devel@lists.linux.dev>; Wed, 14 Oct 2026 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791985193; x=1792589993; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NKJXy1eO5vGiVrxvsBEG/GIMF2FHbHhV5DLbt20ey20=;
        b=TLheYqYP1tH3ABpts0bb2yffKUDdRnujUXTZspsgHqVfTuNqFh98L/Fvof1fyk+OtV
         Cqt28wUiW3rEafO8XZ3CD78bIaRizXVlx94lAytVhEUxWuWZCm6wzlMGkwl9Km8qLJKy
         9pqGNNDA1izZbWuDL4uiv9mDFVp3iOfVVOYg3hPfCSYmcd260JJUApWxHGZ/+8jjimBo
         7u9+iv5oXzHbGguLVMBpWy/g/faMt4Ca/K819wOBr42Sd/mfL9u+NrbzTJUV28T0lg3Q
         PQiOcUxM24T+dgdIWXLst+RaFkreWgGvtNpYReJdZZ1cBczjWBbSJaccdA8L1O6zwbsK
         +l7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791985193; x=1792589993;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NKJXy1eO5vGiVrxvsBEG/GIMF2FHbHhV5DLbt20ey20=;
        b=r8naKhrFd4Dse8lh9ZM/78vQy2zYrZBDDuty+259JedtG2fgM5AHzrExsxuE7w+ZOQ
         79N1EltuKrJfJkexk7TCK9htIykBeHljK9EkwMWr/0w8E7uv52K0kskIS7tA4QofBcSO
         yzl3v8h0hF378ecTWkOBK5ak/su6L9saha7D5ndMiH3T07r0uGbME5hdLwoXVSztQjRS
         AgUIyVJahyFb2FIPLRSG6H2oLNRMEWqk8nEgnJFsmJmmd5WYyehRtGqA1R5HSzu/nDnT
         kexnK68ms2+EW/a2Tsqf7/sE4q3l9bVpUDzCQnuBGlLk0clSRjIavxiOy/EnGb4Vjflf
         rYcQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSxBgMwWqqwEnB4ahJ8CzA1UwedHGIUV/ZVxM4+/5pb2GOduD6Yv8U4dH3k8feG290K293RLPn+idmiqo=@lists.linux.dev
X-Gm-Message-State: AFq9FYJWtDSYBWc47LTU/DduzwN8Y/J7PgB+xq4/DtjLKZQscG2BZonF
	WxxDI/NghOvMlhC4umjeysJhlDAoeo5H9Gg5g6fPFE+K6mnxAEKzibPBS8ciYEeICs/2BkPs9b/
	9JsnoK65oH4ptNhcswfXfjXPBOb9y+FaufFuEDAawey2SE8tQr95IyMV69JzPwAF2vxU=
X-Gm-Gg: AYBFou0lrE1d1cgmYnrBqHwU0BClZ23+J8JVxZ/Ol7VTTAs1Uj8rvSPiE2MkR/eiYfX
	2fLCI8JLUCFDe9WOpCyfuOTqBuUp2Pu/xaWAa5eoghoPWVwtJ6Ihm0ppn0803a205ReSAN3ZxSO
	Y8+Ykr04dh0kvTAMYkxyNp/KGlcaLDCA1cY12lw5UJ45JotfNUGCLAA4HwkPbcWfK1NoUO5wSuO
	VLM8/IuQurwxhPLixa5jW5X2YRzXDCGbJCHgADyi2dlFvJlFalVQjutttSWFDQhJKD9TRRwfsAr
	FS15DC+tj3lAw7DUuQuybVm8xTtmtbWtX4e/ubja9uZDIddRVFGLT01HH74hb5Jo8VsjTr5mTEt
	uLl/FWpocP9f63a1QYF5PFzS6JRvzdoc+o3SSa6TporkT2fxduk3Fqe43I/nym+oHUFe/nVR5NI
	H6kfAihZqNM16giVj477iunr0AQVZvfHWOAsVEhNbvm6yHmIbLFFXQKpguZ3iqXrO2cP4=
X-Received: by 2002:a05:620a:2a09:b0:93e:b685:ae70 with SMTP id af79cd13be357-93ebd228f11mr2646645685a.26.1791985192702;
        Wed, 14 Oct 2026 06:39:52 -0700 (PDT)
X-Received: by 2002:a05:620a:2a09:b0:93e:b685:ae70 with SMTP id af79cd13be357-93ebd228f11mr2646638785a.26.1791985191965;
        Wed, 14 Oct 2026 06:39:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b203839a13sm1110061a12.9.2026.10.14.06.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 06:39:50 -0700 (PDT)
Message-ID: <26a3cd51-37ba-4b2d-8f56-cff4ad4de086@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:39:49 +0200
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] thermal: intel: int340x: Evaluate _TMP exclusively
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Rong Zhang <i@rong.moe>,
        Charis Stratakis <c.stratakis@proton.me>, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261014132703.93355-1-aliamemis@disroot.org>
 <20261014133013.94097-3-aliamemis@disroot.org>
Content-Language: en-US, nl
In-Reply-To: <20261014133013.94097-3-aliamemis@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YJcKWhGx c=1 sm=1 tr=0 ts=6acf8629 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=LpNgXrTXAAAA:8 a=EUspDBNiAAAA:8 a=yqPNUEQ4FSmsfWAeDTUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NCBTYWx0ZWRfX/KsDanh5AjVY
 EpzH7Pvq5cweDMTl2ef2+4PgoobPnNM3rgCfRK78lwMS57sFFmWq+sIrolu6BwVJEIDJZZNthkj
 LGEXGmoAya5hy3THbUwxRDE+jI4Z2w+toDpuOxJAp+sG6PkFZg2vQ6n85X45i/TqQcYQ52SfiHb
 /me3IITd9dPV2lqtZRayNew0RvQb7QZ5sgLbd03gGbe5Pp+nUpYYrHkd64nS6PSwSb/mUaJxCLZ
 ngCfL4OCzCQBAudx8wkHfzsP7/xS4kmVh5Sckwd555guHRzgxPRlJJzA+ofiD3/41zYjHDOME2m
 319fFkuLPVvDoPJ1ZIRgn9IGKbQ/uqUUCdXp83lAlx4ih3CeHQ8/uuz7o7V7zUv2KYM2UmyDX/4
 5qeUwW8Za7YZdb2NMm6tvYr1rYbwKVtitZezy8n+pbpsrbPBsx4gNfXRgR4iSZnJH6W/AzkzRc9
 2F6nQkLIKMIAFldkt8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NCBTYWx0ZWRfXxL0XCkzBtsO0
 64qzx76l1HpK2MWefBURFqWx7qv8UZfUZcZuZgY8apfVqBnBx6s8Wmg7dmlgBXv5JAJA2eEzJVd
 a3NRigSF3Hh5TLaDiUKThnqlTSXVINw=
X-Proofpoint-GUID: enpOoF5O_d_d_jznjiynOm2sKKoRYP-H
X-Proofpoint-ORIG-GUID: enpOoF5O_d_d_jznjiynOm2sKKoRYP-H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140054

Hi,

On 14-Oct-26 15:30, Ali Ahmet Memiş wrote:
> On ThinkPad P1 Gen2 and P53, INT3403 _TMP switches the EC page selector
> without taking the mutex the battery methods use, so it must not run
> interleaved with them.
> 
> Evaluate _TMP with acpi_evaluate_integer_exclusive().
> 
> Fixes: d33e89d12295 ("thermal: core: Suspend thermal zones later and resume them earlier")
> Reported-by: Charis Stratakis <c.stratakis@proton.me>
> Closes: https://lore.kernel.org/all/37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me/
> Cc: stable@vger.kernel.org
> Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans




> ---
>  .../thermal/intel/int340x_thermal/int340x_thermal_zone.c   | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> index 965700ee6962..de0a1fc7b817 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -18,7 +18,12 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
>  	unsigned long long tmp;
>  	acpi_status status;
>  
> -	status = acpi_evaluate_integer(d->adev->handle, "_TMP", NULL, &tmp);
> +	/*
> +	 * On some ThinkPads _TMP switches the EC page selector without
> +	 * taking the mutex the battery methods use.
> +	 */
> +	status = acpi_evaluate_integer_exclusive(d->adev->handle, "_TMP", NULL,
> +						 &tmp);
>  	if (ACPI_FAILURE(status))
>  		return -EIO;
>  

