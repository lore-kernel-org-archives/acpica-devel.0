Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E5526ABA
	for <acpica-devel@lists.linux.dev>; Wed, 14 Oct 2026 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985518; cv=none; b=NNuuiLFviHrzrtDN2+ZEP4zfIRHBu8J93GvVgQulGbmnXOif7Jb0M46I9pWdeId3BCLmqlaIm97CnztSW27otJeCmrnXcYhFXelHsRwZi0povRuZzO3QywLepI+JxxfgZMablFtUtzn2ZH5Zl538MwWizf4ygNrGNgrx/sq5f44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985518; c=relaxed/simple;
	bh=2eik+EK4C3BWVrmrUDhcQ5ZFi8ccW6MMSJf+dkVWE3Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=plPG4IPk6RWZYWycfA2et8uJWfxY+O7AK7GepZRbNO74MzXrxIcpOAkELTDJ5nn6xERD3tzRmcpgymjapK4dr/zFHAZcftlMdj+c7Kq5lcP15B9diEZdwCJ6yE1xTsxThjvzjmdLcE2WtByspA0zh/zf3qdvBi1jS/YOMXTi+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I3ll0JsS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VVd5E2D8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I3ll0JsS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VVd5E2D8"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E8jhMH3000893
	for <acpica-devel@lists.linux.dev>; Wed, 14 Oct 2026 13:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QilNlIsY/JXTPlSp11Ew6P38xt9C05//jzUyoswKc8M=; b=I3ll0JsSee5/pLf+
	2iYXqQIqlF7Y7lwhqeVFo1CcwbvlO5l3Da68kuTYdockb9wNlgD/Gzl4AwJ7w7g8
	LH6W9LXMK/zhMGVLowNUNDeZH40ab6HSn301YcVDGWXJTtPlqByhl8GfpUf3J7PB
	UvFdhLF7Sr4oVHA7TnbjqEXHavDlVMfOSjyM24XdNTcmh7k03is4mWa/oiBlRYNO
	6ZpvJ+TI7QuPB2Z+C8vuTNTLXpAZhkXyFBZzrXgSKRp7iQd5z0vf5+NlkcW4XRGr
	0JtPSKLNFdI+w/99NpZz1IyIZwNQKFXYJLTDN45OdJYcCRKMlPsXrYfLs9ztYlku
	tEZYCQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9sbev7k0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Wed, 14 Oct 2026 13:45:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ce7a85f04so920340585a.0
        for <acpica-devel@lists.linux.dev>; Wed, 14 Oct 2026 06:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791985514; x=1792590314; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QilNlIsY/JXTPlSp11Ew6P38xt9C05//jzUyoswKc8M=;
        b=VVd5E2D8y7sLXMTMriWMIIQMzFOpkylSMOAxb8U8kUQ6xSzMBsWnqJO1sroeSqhPAk
         05ZOV8OeAujHBwetp4tnJuo/YZ6vQa+Lj+FQqc4KnzcX9dNNONR/yeb5YMIJqdBwO9Ia
         3dI/XRnMaUDAbUjOCESPI6nGIuMAPPNP0YkFnKrJRhnstX6fEMLL6CrdjkSUMTgqI/W+
         6L6P2JowTQTFpTTKLOh/9CKJcK/FVNlXWHNKqUYWtdnnPwgSw5ZsoS6tDuxKwE8fpWvs
         eCbQ3O84ZnXQThDei4KE/YkuvfpITHul0x/WYBl9rddSv33INJGTnLlFa+k+16U8PyJu
         3jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791985514; x=1792590314;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QilNlIsY/JXTPlSp11Ew6P38xt9C05//jzUyoswKc8M=;
        b=pnNZ/k4mPZLr1r0V6GYSLxs/nEeRE0kek7GrTflEhdHIjdJZZoa9OfCJ9aix4bdx4T
         ybTIyJezEJ5h5cK429XxEj+eqdYB++k+aPSjL1Q+/L19AXV7j0aYgISMGkZ694XNwJxj
         +Y/AJTTmu1ppbO24CCskuB5eJ0+V33ofk4qSiwxLBl8qUyn0mcN+4mm2jgfrODMmhCJW
         SXW7Yr8fjOsR/sBM9sdPdPDfyoZfDNFqJl/Q17YWyKGdGhEsqauH64Ig14RXYLOobk2f
         5pHMUSQKbMD7d2Jt7sB82mBQ56aoYxt/ur8+/vWPpVu0uAWoCT2GmCSpXYSxkqdudoSO
         5PHw==
X-Forwarded-Encrypted: i=1; AKwUvBzyi2VquRY07YRp/K0D7TESwCLVCu4bZIxmOB/ujNgeaEmWZt0Oc3oKcSOIFLV7Ot/KVH+29UG2sai/DIg=@lists.linux.dev
X-Gm-Message-State: AFq9FYJnnJM2eG84rLj5nRHnf1Pa7Eop71JKhRrE0P8qKjVRyhVqrMhT
	MeJewTwgU99ra/zKcuvW8EaEhCU35/FesdZndE7c2ebH5Mojkns/NLdW9XPuEoeEMu3bKoNl+dQ
	2wcUSOGCpv+nlRiZHSwGqR0d2YeFfZImfaWVsVqWe/X2oCGTwdHuysTJshpzhoB9bCVI=
X-Gm-Gg: AYBFou2BZxmX9dUjoVeSzF35HplufFH071VqdhAwlrnGSJwqRtVn4te5wEeRH2zsuze
	jhVMbYZU7A6H2EF6ldhNdLA0z72xjXHhADA7G14NmTZPK6dJ5CAm6294cHKWSMOy4dyog+857nE
	QhcFvK2QwyTIh6Hqm63HL4YqFRSkHUPfLoU3eoBKAUAm1QOfjQpBmXO1p/bsh1OBP3k06cpIyBD
	RpNkTCAArZaggIFKZclJMeh5fuFgBvd4n/0mPlnuMm2OZTetBEP8ccxoy7BcuRJrIL0L0zq4nfQ
	BUMNpgNrYGUKPwvkvGWAaVoFoNXBhPJQGo13IHaQ5HAbdIKzxaq/jS/Lb2fu8/aiV65jTtwjzqY
	MOez/3vLwf0XDylAxJBQll+Mq+9mk6DRj+jqkhaW2+r8/XhjpqXbvHZK5lCJuA1lSiq3syoTEEo
	Nr4sdpl9McVpBdwoTwpSUJbG54rCC+o7Vxcs+rzCczcEbOncmGxoJ/bgTXWhMDxL/Pyw==
X-Received: by 2002:a05:620a:2a0f:b0:93b:d7a0:d9e1 with SMTP id af79cd13be357-93ebd2445b1mr2514966485a.59.1791985514054;
        Wed, 14 Oct 2026 06:45:14 -0700 (PDT)
X-Received: by 2002:a05:620a:2a0f:b0:93b:d7a0:d9e1 with SMTP id af79cd13be357-93ebd2445b1mr2514960385a.59.1791985513405;
        Wed, 14 Oct 2026 06:45:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9ac924dsm721471166b.70.2026.10.14.06.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 06:45:12 -0700 (PDT)
Message-ID: <24b2e368-f0bb-484c-bf88-b9ce3125180f@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:45:10 +0200
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] ACPI: Serialize battery methods and INT3403 _TMP
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Rong Zhang <i@rong.moe>,
        Charis Stratakis <c.stratakis@proton.me>, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20261014132703.93355-1-aliamemis@disroot.org>
Content-Language: en-US, nl
In-Reply-To: <20261014132703.93355-1-aliamemis@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2DFTX55mHGqkVcW_5FmmoJ5J0RhONooV
X-Proofpoint-GUID: 2DFTX55mHGqkVcW_5FmmoJ5J0RhONooV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NCBTYWx0ZWRfXy1hZzstUaVXB
 Vp6Ols4gZ4+8f876W+dZGMJx3UEu0JTWxyRX539MaCjkM6I1ZYTTFjQUqLlC4Z07rk7p1LWddOU
 3CqBh0BMkhPfWXdEKz/NaLN3q7Qg4A5t8ys7kMmpQa7I1SvmP/WryBZxXTLYL5A8V7iBFP5+p55
 yqNmf+bVLhoi3H38LM9/h1ghM8LczFVSponY5RnkHjjja58FtvOXUmQ2u4JFHFrCiQJSO5VNo/p
 +XpiiH3FDsgF8JUou3+A/zWAjfPdK9sDOaNhzijHW0VZtkorK8OzySlVbw+KeZ9GRuKQkqdGs8z
 qcLW/ts05Br82kF7xhCrqMMq5r8dw7zn5EUFZpLrpMR1D3vbVltXZ+mKOJPGCy033Y2ZmJYCQBU
 JyxNHVtNNAeR4NYjhjLA7Wfilo8QpVaohLgcD7V7APb9XNpas/o99tqHLyWXcJSSPtlycJ8CSnI
 Cz3biTl3egjlg8gS7yA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NCBTYWx0ZWRfX2+xIpHyBAkBr
 K2CrYRvWkZOmewNG8cwvHYxJFfDHQqRjLRepqOt1yzvZ+RVKe0ZDKTjG/yw2zrqX0FziC2LjkvX
 XgrTV1t+Kohr/Ssfog91VFD/oCpCdFc=
X-Authority-Analysis: v=2.4 cv=U7AHnuru c=1 sm=1 tr=0 ts=6acf876b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=jSlZZTkqHIX6knNQi3kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140054

Hi,

On 14-Oct-26 15:26, Ali Ahmet Memiş wrote:
> As discussed in [1], add exclusive variants of acpi_evaluate_object()
> and acpi_evaluate_integer() and use them for the battery methods and
> INT3403 _TMP, which interleave badly on ThinkPad P1 Gen2 and P53.

Thank you for your work on this!

> UCSI (bko221065) is not converted.  There the contention is on a
> firmware AML mutex that _Qxx EC queries also take, which a wrapper
> around acpi_evaluate_object() cannot cover, and Rong's notification
> merging in 7.3 already reduces it on the battery side.

Hmm, I wonder if we should export the lock added in patch 1/3 and
then also take that in the ACPI EC interrupt handler ?

The ACPI code already uses a threaded IRQ handler for both EC GPIO
IRQs and GPEs so sleeping in the handler should be ok.

Note this is something which can be done on top of this set. I'm just
thinking that if we're going to do this it would be nice to cover
the bko221065 UCSI case too. Rong's notification changes do not fix
the race, they just make it a bit harder to hit, but users are still
hitting it just less frequent.

Regards,

Hans





> 
> [1] https://lore.kernel.org/all/CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com/
> 
> Ali Ahmet Memiş (3):
>   ACPI: utils: Add exclusive AML evaluation helpers
>   ACPI: battery: Evaluate battery methods exclusively
>   thermal: intel: int340x: Evaluate _TMP exclusively
> 
>  drivers/acpi/battery.c                        | 17 +++---
>  drivers/acpi/utils.c                          | 56 +++++++++++++++++--
>  .../int340x_thermal/int340x_thermal_zone.c    |  3 +-
>  include/acpi/acpi_bus.h                       |  8 +++
>  4 files changed, 71 insertions(+), 13 deletions(-)
> 
> 
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907

