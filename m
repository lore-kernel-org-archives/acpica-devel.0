Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72E94E0212
	for <acpica-devel@lists.linux.dev>; Thu, 15 Oct 2026 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069997; cv=none; b=d9H+DtlDbJ0a0LTPeS30lOxLW8sYbVZ3UjMtNQh62cov7mpLZcGYG/kpm7fJUNypdEaHt/pW0RnUhJ55jyqpeM+kZciC9S0RZjWJU4chpRR0JtfxVgh8XMn994lAl2esSvo28dvwQkfGeO7us9kw/9v0LaiONjiqVog5Db4Wjos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069997; c=relaxed/simple;
	bh=qhwosOUFEn40xQ8xFJW/TeqPHN2EC2c9BkQeLwTb0ac=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fVvyvqVqJalVFS4tVVwf6McomT61CQ2Nx9wsBgLKEXqb1KTmiourcJ30PloM+jOwZyh/SdI/9YsVbZEt0+fLTP9wPRLjEKa4D/KQk8micEZBesqHyxRtEwq3aBUtm4zwcIREdjrifCfQ6Nmg+dv0aWDXXOlDSkYmUbAqi1gybmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nrbgjqHy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BLX6g5qh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nrbgjqHy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BLX6g5qh"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jRPK2662625
	for <acpica-devel@lists.linux.dev>; Thu, 15 Oct 2026 13:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T4QVkck8E27F/8+DyCCyWCYYz70WAZti6OBC0YA7Lo0=; b=nrbgjqHy43VPixes
	GMy+iRjepgiRo8XgnGN5CqmL+kk3Xhq501X/tx1YTUhmuyWQtxOhxRnbKveBM8vk
	Qrypbr3eC7ILnQFKoexVYXVEFjyaQLOqFOD5QjVpqYLB3efdmnyrNOWOD1x5CG7n
	BkGV1G1kPvytGjmSFyD4q9UCA5duKoioRjUJY/qfljoOLkSL1ScCUAPLOngqKIzG
	IqzR32sQDvxrUbGKWzpN+u2wBD5gU6+FbXt0UUZSZLxdHcOWUCFZ6/i0bXuiOGFm
	IXuLo0ekpbxtsUDFbHjHfy/CwGpL5YAy0fFtR4S9XqVXpYrEPYGZ/QzPG31w4W4u
	zA9YuA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqda26kp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Thu, 15 Oct 2026 13:13:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93caa0ce0cdso185641685a.2
        for <acpica-devel@lists.linux.dev>; Thu, 15 Oct 2026 06:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792069994; x=1792674794; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T4QVkck8E27F/8+DyCCyWCYYz70WAZti6OBC0YA7Lo0=;
        b=BLX6g5qh5D9aqS3i1df9U6y1LB9322xlMhKimBmPAkhjEP+PE4/2w+vl6FGnvg2PyA
         1tUt/2/RpVFmm46jfbt3rb91260RsxEO/3V6QcD7BJBRXSj1ggt3LMVKwIQB7z2HAk9q
         WiVQyogxqmSLjmsIbtbmnozjKBwGZJ7gl3wfRb7naTU/9KOY3/nBOXD+bToXj6/alooh
         GuZPP7i4ovKBBQUWzJj0C1H67i5AfBe/cqi1UrgZxFOC9SdHm2mA++s2DvupZ+uZQ6Xj
         +pJBV39GEktpHtnm8rIePk4U8MnbGXfah7IEYnACJ1qXAY3HF1PEqh8tLZUj/RIr3p0D
         4fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069994; x=1792674794;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T4QVkck8E27F/8+DyCCyWCYYz70WAZti6OBC0YA7Lo0=;
        b=n7B2X65+SouHVObuShLuiKnatSaOYcYmklrEvYO9jk84GMvfPvG1Y9KCQORVtpAf3f
         CIOUYEUSZHQ247yXrB/B6YBN0Gzpe3dmqqTOGv1dzGtdijqFz2vpbLwM9AokWjLQzd/2
         mBxv+0Ho3DCCDntnX/lCF782KLs7ClTTy7iUzhjZlmOT2KXwfBajY6Tr81dUAYhGg1gn
         sulehuKzC/KkF+AEe1OlqRBzlaO39Tu0OpZ+YTudoogsxdnvmS9X5y1CGObOWY81q/Ui
         qdatxSQq9+OnWiniuONvVGQz4ta4xlar7TW17CHcqnDdhjnkSukBhGPWZqk/lmx39G4W
         WB3w==
X-Forwarded-Encrypted: i=1; AKwUvBxbJM5VlOKFHppRNCEPZdNd+Po4TIxiY/jBRTUUbfG6lBBz0Wuql9NN9wbmZbOEx6czHSUhk/3oxROpf7k=@lists.linux.dev
X-Gm-Message-State: AFq9FYJwS59xo3Yr2dXN+Nxf2IUC5m55V+cc+caqaTlr+j0JOaqJZF4b
	WsnWrVQEWfySxic9nbtzyzwGQbGEAs4PF0D+CS2k9mKu9LU8kpB+0HWa9RE52wpSiAHx22m2uCC
	jOnAMq2CELJuVrcp7QHo1wt+67fyRwMVHednmIuivDWu9R74pYzbjPbRkIae+Qzxw9eA=
X-Gm-Gg: AYBFou0ibtDK4heheUsXDW8vdCKGJ3ci5U1eJNXyXea3oCJ/Qsx7KYadhtTO08haz+4
	cbnqGhVqAYN41IuzEpELgKxpdRz6byw+SfmSSP/uGAaWLNxTJVnphtaAZdP+pGZ9rBt9LOIVFCy
	mlVRPtRMJWEjRrdklKkGZcjhIMfexdFNTkVzGOGc1aKBHueAg+38Dzgcn2ZzPQDlrDKwY8AavDV
	Xc5kWhGH+T2T6Cfe9r9feDG3sxlG/2SoPnGh6hBEgpLoUgnPHBQ9bzCi8UGEZTFYg/XwiGeS5RL
	KVN7EGNK4pcMj4eEbwIExV/XImChqPsoYoU6z4RF2USmeZPyieM7b9LIS81g90LttuX0PLjWz/Y
	tgaJi9GygsQDojb9sfAobGeAQ776oe7X4RRWS5l9qteC99/eIee6/E7MvggN8PIEc2X0M0WvKIs
	VEpno6EGD/4PUifgaxRaWfexNQa/qXDISQ/3zp854PRUFKnenAIyTsuc+dsU+JC3Hs1A==
X-Received: by 2002:a05:620a:4515:b0:93c:aa75:71e with SMTP id af79cd13be357-93ebd27cc81mr3034316885a.55.1792069993806;
        Thu, 15 Oct 2026 06:13:13 -0700 (PDT)
X-Received: by 2002:a05:620a:4515:b0:93c:aa75:71e with SMTP id af79cd13be357-93ebd27cc81mr3034309285a.55.1792069993247;
        Thu, 15 Oct 2026 06:13:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b20388cfe6sm2456350a12.28.2026.10.15.06.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 06:13:12 -0700 (PDT)
Message-ID: <7ecfd94c-7083-4d76-a5f7-490ba1e650d7@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 15:13:10 +0200
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] ACPI: Serialize battery methods and INT3403 _TMP
To: Rong Zhang <i@rong.moe>,
        =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?=
 <aliamemis@disroot.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Charis Stratakis <c.stratakis@proton.me>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261014132703.93355-1-aliamemis@disroot.org>
 <58586fa666f09c209f9d7fe8c692a8bdda6d4410.camel@rong.moe>
Content-Language: en-US, nl
In-Reply-To: <58586fa666f09c209f9d7fe8c692a8bdda6d4410.camel@rong.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MiBTYWx0ZWRfX/7lCKvshjVTt
 Q2dd56A4XAuqw0mmrb72MJYv7ggboFOMU2s38oPede/pL8UeswVIomQh5lpvhKBt3rQEGCzVfWD
 kSvdqgoe+xniOR7W9euE4M5CbsnkyGg=
X-Authority-Analysis: v=2.4 cv=K9u3jCWI c=1 sm=1 tr=0 ts=6ad0d16a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=Qb4wfcSRRCwKSm2dVBkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: dkD6kSuF-DcNXHbl7sFLgzk8dTBYsfSU
X-Proofpoint-ORIG-GUID: dkD6kSuF-DcNXHbl7sFLgzk8dTBYsfSU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MiBTYWx0ZWRfXzfPg/C/vt61G
 E1imaehAX/lstQUUjU+yxOGxUD2kisYDFbwfPNDlG/gxlBJyXWicD53BLgVNAHNJUY5LonquLna
 /imDmtg56P0Stg5uG2i+E3xBz36+SzWRtWrRNZZU+nArL+Ufr+aJaImDydUMBhCO5fz8qJHWyNr
 +8lFk060wLOVjvVIGgPRnn01+PoWLLby3UrPzAqpHO+vVfRZNEkTylAT1/Yq41H4a3vjaOGxPAj
 fNzoBcnM2TeflqhHUFqiN4si55NuibnQRmCf1j30B+IlftfMj+Z8qFqO64Zp8Vw8cOkdf70+Kge
 cMZWu9lhVKCvIt75rJZRm3hnkYWtRHOPdWAGpqUrMAiJ9kI/0Sb2ia8zgUDVJpCoErm/EvNduP6
 di/j5ho81nLmZj9upF2JdGy2MJtHHKDL/Kml8TpYe4ogA8duYKnKJ1e4ZV7ortlQUsFmEF4ipR7
 kjlbwTChgPgegl5LzBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150052

Hi,

On 15-Oct-26 13:45, Rong Zhang wrote:
> Hi Ali,
> 
> Thanks for working on this!
> 
> The series is generally in a good shape. I just have a few minor
> comments.
> 
> On Wed, 2026-10-14 at 16:26 +0300, Ali Ahmet Memiş wrote:
>> As discussed in [1], add exclusive variants of acpi_evaluate_object()
>> and acpi_evaluate_integer() and use them for the battery methods and
>> INT3403 _TMP, which interleave badly on ThinkPad P1 Gen2 and P53.
>>
>> UCSI (bko221065) is not converted.  
>>
> 
> Please leave a link to the bko bug, so that readers don't need to
> assemble the link themselves.
> 
>> There the contention is on a
> 
> After carefully auditing the ASL code again, I've just found the root
> cause of the mutex acquisition timeout.
> 
> It's hard to notice, but \_SB.PCI0.LPC0.EC0.RDER being declared as
> "Serialized" causes an ABBA deadlock:
> 
> Thread 1 (battery)                         Thread 2 (ideapad-laptop)
> -----------------------------------------  ---------------------------------------
> serialize \_SB.BAT0._BIX                   serialize \_SB.PCI0.LPC0.EC0.VPC0.GBMD
> evaluate \_SB.BAT0._BIX                    evaluate \_SB.PCI0.LPC0.EC0.VPC0.GBMD
>   acquire ECMT [A]
>   serialize \_SB.PCI0.LPC0.EC0.RDIF          serialize \_SB.PCI0.LPC0.EC0.RDER [B]
>   evaluate \_SB.PCI0.LPC0.EC0.RDIF           evaluate \_SB.PCI0.LPC0.EC0.RDER
>     serialize \_SB.PCI0.LPC0.EC0.RDER [B]      acquire ECMT [A]
> 
> That's why merging battery notifications significantly reduced the
> frequency of mutex acquisition timeout.
> 
>> firmware AML mutex that _Qxx EC queries also take, which a wrapper
>> around acpi_evaluate_object() cannot cover, and Rong's notification
>> merging in 7.3 already reduces it on the battery side.
> 
> Lock contention is not the root cause, and EC queries and UCSI _DSM are
> just innocent victims of the ABBA deadlock.

Hmm, ok so since \_SB.BAT0._BIX takes ECMT itself instead of relying
on \_SB.PCI0.LPC0.EC0.RDER taking it (1), this means that not just
the ideapad-laptop GBMD method call but anything calling
\_SB.PCI0.LPC0.EC0.RDER may cause this abba dead-lock, right?
Are we sure nothing else is calling  \_SB.PCI0.LPC0.EC0.RDER ?

Regards,

Hans


1) I guess ACPI mutexes may be taken nested from the same thread



