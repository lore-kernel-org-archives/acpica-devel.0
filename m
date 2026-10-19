Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434123;
	b=yKSI2RByyGSdYDIjXUctV/jxlxdj4GhoIbdgIEJ61s1OAYzAFEIrUrllZzPUOkEC+zfq
	 eia0Hzbwly+QhM071tWA8kQ2LLNl1JRW0Hubsyl0UD72SSzUrdRMluBjl7D8A2U0i3j6v
	 /zfGcYBPjS1xc7/RoHs3TNhBfCxxr3E9pEWYkjl++XLV/Zg59YWqCtmEMBoSE4yef0eHO
	 URS8fAHVU1KtwiB0tNyEOD1MYLyptcvlq3whhAuTeiky/Xg6T0szm++hac/1o82AAP+62
	 jlYONQMQMM6fMiKRxsliKjJsmc7rMfoAvpv5ruFayp6gyvnbCikIjXPvEqrZ27DhhIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434123;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OzM/EG87vKHwQb3clxhLpAhZOOi6NHbejQuRTq00yik=;
	b=d4qJYk1uxgslvjZvchCRaUqL5xo5jno9tKorP3Xz8lqMA9uYVxgQVJBY6KxjmkUtTNle
	 +UPr2BM/Vm63gJkBgvkAgTumC9CI7BKbxOlItHwPKDSaDj0Z6d92BNQxy/sy+26jhnwER
	 B3hR82/bidsW5+jrj7RDQkOErll76x6rZ9ytbxpHpeU6xsdiBjp8YRk7AdasBDjgg8K9n
	 EUAKPfR3WZqg4o4mhBrGiWhpRVYzYeO3S9JIem5k1/irEAxRxQf8TDIXaxthmWtOzjVdg
	 Yg5Y3z+eb2M7sRvt3Js4VtfI63s2iPewzvRIAHHgiFdz6A1edO7kLYYwL/Yt4jptdYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FtpHEkUE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JzbsYJSj;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E1606A319
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 18:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF9E1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FtpHEkUE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JzbsYJSj
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JI27ha2937299
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 18:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OzM/EG87vKHwQb3clxhLpAhZOOi6NHbejQuRTq00yik=; b=FtpHEkUEYbIV7Ov6
	yArCnhlsnLn8n/AoCj/bcuc+gbW9OavkkIylfb5r95I9LYzxoq3gpRM6XEVWW5Xw
	nAX2V9OxZ9GzlHN3vsfFop0nJwOe/jEXxVSYr9pYMVUa4tSDIUBW2chu2F/kt594
	xxYMnfntZ+bEwLFktpp7WIz79wPVjPh87tRpwzgwc4HHwgCxHuit3s5n8GzmExqC
	gg//XU8uE+hTDxC9tk/BoMZ7LugfOPSC86+vr8gg2cMmLaBUMlrfSYrB6qAEZrU5
	vhdE0IIGdd5pQ2lLkB5Cx2wig0X2k5wFsP0yO8moXWkAzLWXD880fvxzBsmbcyFs
	ZME7iA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4q02n4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 18:22:02 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so1380399c88.0
        for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 11:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792434122; x=1793038922; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OzM/EG87vKHwQb3clxhLpAhZOOi6NHbejQuRTq00yik=;
        b=JzbsYJSjqgThkC8A3EjSJ4ty3H98hyTGO/huullqTLt2q1z7ZWz/HDGtWONWBIjlOO
         N7jJtA3woaIt2gkeWx4zqqacnu++tp/l+kXGSghE5nXXeE6+BVg13LLn085fZLZmOZU3
         9S045r21QMCVpOp8mNJ3OeUa8dambZEyYT+/90xnGHISLJc3prnqp2z5kMvQY9ZO8AGI
         aNbjPkZLWQ6DViSvTgCMUfSfRtkR1Uk3Qg4lwjZ9hPPMa1bbXmOwcDoAwYSQVM62/uRB
         H54HFQmlCl1WdxwLHcLY8sEpce+5Ow4hplx5bZ40ASSJl6RuS33VDgCScmUG2y0X2Xvw
         XUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792434122; x=1793038922;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OzM/EG87vKHwQb3clxhLpAhZOOi6NHbejQuRTq00yik=;
        b=jHOEZKMzj25XhymADge9L8RuRfVhLo43aQK1HVpnMxRJNIOtfX0R0tqhnskf2bkLG5
         pGcpqw+Hq8E2qlY1POkTgd2Q9wtTzSbUMmlV7XbYw5p6X7fWe/BU/s6vEN0mVftAlULy
         57M4QoVxn7FYAhpT4Cw5HDHcbA4NJQqr0M2E8e+ajDwsojhquu65koLwUHiCL1wG82pp
         2fN8Hw8hDyKM/gnqU7iNqy0NqvGKFr311H/7WAvMs7JQExjueyyTeOlpOBE+0XKyxgzC
         ZMNqHHuGsQDeXWr20pp/6HVZNwP+UeP4BESgneyaPX92r/bdeynMlaVibAJc6SvKg7KW
         VaXg==
X-Forwarded-Encrypted: i=1; AKwUvBwr9MYCgxugXO5DaBE7UXoZXDxk7qmDL5FZe0rnmiDVnuDD32gUMV7t14OTS9am+11gw6l5GFYfvXb56Iw=@lists.linux.dev
X-Gm-Message-State: AFq9FYK/UIvyihc3kVYDS+q7h2ntL9I8PX80fAetO2Ls/lNlBWepcKMp
	1V2/6l/0EzTPAvbm1eLvhKG4Sgvz8ZZSBP4dq1j05zQ5Yj80qq6it7HaE3KOBwP2V5GfW4Sg9vd
	se+xivsqxGodu+G5AZh74lt5ER8J3mIU1KHmdRyZsztaaVLndVWgm7/QcRJ8kEl6hiI74ve8/bR
	A=
X-Gm-Gg: AYBFou1VtUfXY5qyzvGYlp43h46wvg3NQPhzwn2BNFniGdgeOFTPgcukTVLgF1iQwVM
	1hppi0YA1Tzt/5KNWbHwHsd2XMUlTDKEgvgKJxawcjvl3fCTKKD+u/qjw43XwMP9k7lbZ9RWclN
	T9DK2dshYGp7QnwHT/k4OvMZ4kWL8ZQi+B4Y/FEMZLriEnbEHDSfIQstLH0SKB1jcdRQAuYo78c
	5RyfGfk+/C2tkdr3u0aT4jUcOPbhejnJi5KaZ8CtaMcmASW6Kz1+7IWz0y3YcNaq9a5XXME5p87
	tKkVxWLn/yJblRkFReEi4bHWDgRE0jdamcnHvqOHq3LFH0afFhyEWgNReBE5wfiRSna0PCLZw9J
	kl/MMNWRVGH2twkolvsp7v9/d5Y+RftP15KNmq6yrDQ==
X-Received: by 2002:a05:701a:c907:b0:169:3706:d61b with SMTP id a92af1059eb24-18511eb6a06mr12491469c88.16.1792434121230;
        Mon, 19 Oct 2026 11:22:01 -0700 (PDT)
X-Received: by 2002:a05:701a:c907:b0:169:3706:d61b with SMTP id a92af1059eb24-18511eb6a06mr12491430c88.16.1792434120643;
        Mon, 19 Oct 2026 11:22:00 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18314b1722asm31987710c88.1.2026.10.19.11.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:22:00 -0700 (PDT)
Date: Mon, 19 Oct 2026 11:21:55 -0700
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
Subject: Re: [PATCH 3/6] cper: use BIT_ULL() for processor and memory
 validation bits
Message-ID: <20261019112155.00006fb6@oss.qualcomm.com>
In-Reply-To: <20261019145643.1877246-4-pierre.gondois@arm.com>
References: <20261019145643.1877246-1-pierre.gondois@arm.com>
	<20261019145643.1877246-4-pierre.gondois@arm.com>
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
X-Proofpoint-ORIG-GUID: iYO_1Pw68753SPeEiKREHaskESZhbgBV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3MyBTYWx0ZWRfXxjqCNX25UAns
 BU2KehmG6T9G8S/wKHRuR1dOLssL5nAsmA5nb0p8fesjNMh9i1F70kijx+IgnV0VRK/iD4gxuhf
 KliikFY1EQrET2U1FFcemm0Z7UPO0os=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3MyBTYWx0ZWRfXxa4a0brPhz1u
 xwKSbNuzofNE+mnW+fYl0LFt+2aATKKNArKH+J8x7Cij88IoZEFlvTwVOwPTkkrVip6qyyRI+Z/
 WoamKTuXkw9pqDvmH2L9MMyAeFBujzrRxoMcmKmUo8KngEF8FF/MkzT/iRxsmtASZgNO+KiDAwi
 krAf35hZIZy4EyyFkys3pyG8e/xs90o+fMjDUr4Zo7dxhX97JRHwHgYMNpz1F+UgrYoOuD4Imqa
 Cb11DS6/itbovSJKv4BQDkcsDh1yFZ480/RITl//IMKxITd03W2v5v8M+VOebGo+No/3TGnLXzc
 GzvH06kBdmyBwuC2asTFgQYUes6blA9WtnYaCOezBC1RVulHqRr97QgaWx7xMFIcWnjkct7t3Mt
 2htZPnPnYRgrUaQd0TPW592Ou/WvasRyXUcni4xQnZZWwqL/UROGZmam43CebCRHLylXifCI80h
 Kv2KigoZYmIqldpYA7w==
X-Authority-Analysis: v=2.4 cv=aqsnmiZV c=1 sm=1 tr=0 ts=6ad65fca cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=wDomEPKxsuTd5H5FNvYA:9 a=CjuIK1q_8ugA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: iYO_1Pw68753SPeEiKREHaskESZhbgBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190073

On Mon, 19 Oct 2026 16:56:10 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Use the BIT_ULL() macro to describe flag bits instead of
> hexadecimal values which are harder to read.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Nice.
I'd do this before the previous patch, but not particularly important.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
