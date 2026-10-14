Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE3B5335B2
	for <acpica-devel@lists.linux.dev>; Wed, 14 Oct 2026 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985183; cv=none; b=lqiVYO4x9AQHtRI1lZYCE3tDGstHTjk/Gns4aXE4D0TJ0AV4v/KPHMoAI+g/oOUzmW6Ac2P5nfni336932mN1QChjghNZDVTR4S1JdAQ2SoW3toYN5QmFDP7GJrfZGsbeYTGD8U5XO0VnS82rJvQyySeHo9VoTMCPiVltqon4PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985183; c=relaxed/simple;
	bh=yJRtTsx1Z/dlS18YF82FYZYEB/5T+QeuKE2x3uhnYLA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iM8rquyRhd6UKEClGxnmeYn8ORGSWM0yP4LJ4szwp4SrVFAbOhBjkHaEaOUgP2rHsl/adpVv5l8dth57fRDQpzHHV5LvrUVfD/kRyrdZpq4d37jUvISbo8ZRC1ymQigNeYVv2qfgkf08MfsdMK0TpjZc70stroQQ3akKvOfZyyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YtA1vLiV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TZzGmu60; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YtA1vLiV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TZzGmu60"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EARC3p466347
	for <acpica-devel@lists.linux.dev>; Wed, 14 Oct 2026 13:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LU5iwxOOYRR9huRXhO8Bq+2PBVQhVFp9657Vu6mwVmk=; b=YtA1vLiVcUl2KR1m
	No50nfDkZJL942+jlsU/WOkZtwrlW2gbPRPY1BCnktLUQvF5Cm8zcnXJfLCC5FC/
	faE0yendvZ2SgPCtTZAgwNr2Sy4p8rLENtynYy3geCT63vIuTRDhnvioRzYjFDXL
	VNXJp5htxGIwSdmtwH57RPHmnjjR8V2d6SuV8ewgB82LeuSNABEfgU5lbhzdYSzw
	6VL3brA6BH9nS6Ijk3X6ifXUe8fhl/4MndKm0vXT7iVEcsJPR3x/zX5dpb8hVjy4
	RahcgPvUYhLmx9lzBowBJT+0Wfw2mRmRLnS8BhIW9iU5cOHV8A735abU/haK8eqE
	Xyk9zg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha80crqfq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Wed, 14 Oct 2026 13:39:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb93c874bso181981185a.0
        for <acpica-devel@lists.linux.dev>; Wed, 14 Oct 2026 06:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791985174; x=1792589974; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LU5iwxOOYRR9huRXhO8Bq+2PBVQhVFp9657Vu6mwVmk=;
        b=TZzGmu60ppbB3q9bkvKZq+2qhMAQqewI6+Eb598Nj/cnC+0BSskBJDVS+vGTlKxxvM
         EmErS2gnSXkDzePobMdO2UAYHdy4MMEhHiJKRWwPeqAH7/DYK3vr7sIs7NmpCDWCtCIl
         AaSmrfdhejOK7VTbk/HI6o3aJm2Uf1k4fsj4iWjhdIUzOQVrklOqpVP4NW4ZmabsFZnU
         3i12nS5GT3Ef/4NWPQiMAWu+HyOIAYZiBYgyQkqbSE13nK9zanV3PA+/5/LiQup0WqvC
         fOLZTgK97TUYtjvanG8tz8AJ36qY5dqnwLJGMgjqXGZDTr97zbliWiEpJagCizQ//DST
         SWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791985174; x=1792589974;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LU5iwxOOYRR9huRXhO8Bq+2PBVQhVFp9657Vu6mwVmk=;
        b=p7KExZHIQn+CtIJkR9sDH5PiAE8GdyocbId6tO+3y9NII4qsYnyskT0bTjYCVK4eup
         voVdR8PVnn5w976+9imoGdZgrBHNrTYwxgmwk652FinjCF5yglHSZHrVBjc1rwPcSAUg
         twPb7/fKuHtRtG7h5Ki5oCk6d4JwY0y9FSINyrhl33vCmXAu6rDeLyjkOdL/+Hv1FBFW
         GYiPByOPstJHhcpnIhCcK5qUVxcD3hOg+y29fxnZcMM7WAtxF2a4bkouMQOieaH+VyB+
         m8cuJW6v0RDrAIWZa6TnQT4db/i5gbyPjhdkckTiGqz3sjAr7BRLNv1NdXpBGsmcDrkH
         FQZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwtqnnzCtrXLI0Z0Zu8ugxRZqq5j3LX9wzlFT64Utc/wX3IIyZlArDi07yqlbW7VNOLqf2eVtyOQFXVNpk=@lists.linux.dev
X-Gm-Message-State: AFq9FYJ86plRH4wBEbaruiMDwj2oFr4RB9mdw5cPXoibsv1VsB0AeXoE
	jR6Djfwo00AFgnmtm9852iEtekXRzX3zDiu16I21coJgv6uD57l1f57R76HxEkeXwLzVu3GaoIR
	HVqxDyufLJTp4vGzx6N/pygZmlSLD26mOgh1g4iIRH9dNZq4efOYHQOAwVSt9i8xJ8y0=
X-Gm-Gg: AYBFou152CinmxhDCpn0udaJh27hnD842ggoBBIKC13eqlc3KDRawHziXs5IHCjo1ga
	czxZ9hYclu0u9ArIZbn/NCt2dwaCybvLYMos4uNWX3e9ppnLcvg9CrnD25NZk1Rgw9O7kvmjcG3
	0RRV1Ld9AnuWIIwvQRc3q2mlwUKL+EGz+X4FX5wXlwFJhtE4JzFUnMew0iuCMuRN1yn85jmAXzC
	mOCrsvuRu78TouMDp2gsPmr1w9K9g0WPFmRnYh3zXfDqCbC0IOUsvfx/BS6RRDt6ykywq3vzbcR
	7f/MZiDTyr3DzPPQVNc3TVpR/z2OCwZr1xsPLRpMZyMk8KmrJM+IH1nO7agY1v0RXmIhM0NxzPh
	Q9CjiTWjhXuHQtSm6MF+ppZnmSNPjLD7jluN43WwapOLMxr6HEPZuhFyaJpWEKnw4nX7H49zIIK
	g+drWaQ9ioACzKsqOJUwFenlF/rz+IPwmIBB7o9x9+b5FixmW1uMBNTFew1daN8T9AvA==
X-Received: by 2002:a05:620a:294a:b0:93e:60e8:c9ae with SMTP id af79cd13be357-93eb95e2c20mr2595643785a.10.1791985173674;
        Wed, 14 Oct 2026 06:39:33 -0700 (PDT)
X-Received: by 2002:a05:620a:294a:b0:93e:60e8:c9ae with SMTP id af79cd13be357-93eb95e2c20mr2595639485a.10.1791985173150;
        Wed, 14 Oct 2026 06:39:33 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9766209sm720315966b.3.2026.10.14.06.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 06:39:32 -0700 (PDT)
Message-ID: <21f3a18d-88a8-4c0b-9ccc-590b311f0aeb@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:39:31 +0200
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] ACPI: battery: Evaluate battery methods exclusively
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Rong Zhang <i@rong.moe>,
        Charis Stratakis <c.stratakis@proton.me>, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261014132703.93355-1-aliamemis@disroot.org>
 <20261014133013.94097-2-aliamemis@disroot.org>
Content-Language: en-US, nl
In-Reply-To: <20261014133013.94097-2-aliamemis@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NCBTYWx0ZWRfX1/x98rDZ41Md
 SFV1oec4mGPjn45NIQqOmHR911DSvgMe7Iy33y66YbHrr26hsPTsoYiSv2C29AVWkbJtx8z+yA3
 lOLJA6sBlw2pNCA7iHn4KjmIX01YH7Y=
X-Proofpoint-GUID: NUrihAq9O9fUTaXn-uVde-wAvIbZohM1
X-Proofpoint-ORIG-GUID: NUrihAq9O9fUTaXn-uVde-wAvIbZohM1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NCBTYWx0ZWRfX6ysNV+uMlOXw
 rnFWeLVCoBiAZyPokLsfmKBzLOSBf/jAQixtbfcmNbD5ga1CtJ9Q2YmekoUQeBIIUUEKs/vjZfb
 sRuwgXvz6NKkxALKB0u1nmRqV4bX9om3IJskhSNs2aoc1vc6GXfZ0h1KjcazoJ5MPGx/zUi6yWz
 yGBhMd5l6yhL5ntI/Pgomz2k8wa64lzOHYSk3aZegGYwhMtdVTdgHC/ccZXRQ/A7YlBvSGW43b7
 99tzDPJo0e+v+ip1vG7Dt3CbUh4XtoOC+GKc8pjEmZDX635rc/nELHYqA7sTnFNiV4JIU/Pl4qA
 HW/3O7j8l7or7t6WidTh7IqOJEW2ZsXRVuf6doHZ6UHuLh+g96idf5qe9ELM4KZtVEO/Xa68ZwB
 8C5X3zYO8vIJRLcN/rnnz5AD3F3XknpPsvwX2Ku3zqAZbZzf6kiAY+XR74n6Y9dPB+vUjwHSNVC
 Iu1s1tdOIp8jWhavfnA==
X-Authority-Analysis: v=2.4 cv=JegpPkKV c=1 sm=1 tr=0 ts=6acf8616 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=LpNgXrTXAAAA:8 a=EUspDBNiAAAA:8 a=RHI-k3j4eS9Gi5hBZt8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140054

Hi,

On 14-Oct-26 15:30, Ali Ahmet Memiş wrote:
> On ThinkPad P1 Gen2 and P53, INT3403 _TMP switches the EC page selector
> without taking the AML mutex the battery methods use, so _BIX and _BST
> running at the same time can read the wrong page. Since commit d33e89d12295
> ("thermal: core: Suspend thermal zones later and resume them earlier")
> this happens on most resumes.
> 
> Evaluate the battery methods with acpi_evaluate_object_exclusive().
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
>  drivers/acpi/battery.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 670853ec3a4d..61de3f5be51f 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -583,9 +583,9 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
>  		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  		acpi_status status = AE_ERROR;
>  
> -		status = acpi_evaluate_object(battery->device->handle,
> -					      use_bix ? "_BIX":"_BIF",
> -					      NULL, &buffer);
> +		status = acpi_evaluate_object_exclusive(battery->device->handle,
> +							use_bix ? "_BIX":"_BIF",
> +							NULL, &buffer);
>  
>  		if (ACPI_FAILURE(status)) {
>  			acpi_handle_info(battery->device->handle,
> @@ -624,8 +624,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
>  			msecs_to_jiffies(cache_time)))
>  		return 0;
>  
> -	status = acpi_evaluate_object(battery->device->handle, "_BST",
> -				      NULL, &buffer);
> +	status = acpi_evaluate_object_exclusive(battery->device->handle, "_BST",
> +						NULL, &buffer);
>  	if (ACPI_FAILURE(status)) {
>  		acpi_handle_info(battery->device->handle,
>  				 "_BST evaluation failed: %s",
> @@ -667,6 +667,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
>  
>  static int acpi_battery_set_alarm(struct acpi_battery *battery)
>  {
> +	union acpi_object arg = { .type = ACPI_TYPE_INTEGER };
> +	struct acpi_object_list args = { .count = 1, .pointer = &arg };
>  	acpi_status status = 0;
>  
>  	lockdep_assert_held(&battery->property_lock);
> @@ -675,8 +677,9 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
>  	    !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
>  		return -ENODEV;
>  
> -	status = acpi_execute_simple_method(battery->device->handle, "_BTP",
> -					    battery->alarm);
> +	arg.integer.value = battery->alarm;
> +	status = acpi_evaluate_object_exclusive(battery->device->handle, "_BTP",
> +						&args, NULL);
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  

