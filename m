Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA5F5581FD
	for <acpica-devel@lists.linux.dev>; Wed, 14 Oct 2026 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991814; cv=none; b=R0gUyRgTPtR/7e4kWA4RUy4mJIfmhiu81z/mOOY5K59uhQx4E+cKpj2wMFG21hKAZcTVAtvAaC967o/u7Ra0geWiBM7gXzQc6ssOi9jPVD0cYon3cbCoCeuCeiWcvMSY/oVE608Yo/g6VJoGK5OXEUexKfi3SBQ6+tkNt3XrJFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991814; c=relaxed/simple;
	bh=BDhIdaDKZ9lplDbcye0C+desv6HoQGR8gmQmNwSxBNk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FLiEVpXEFPjfw8rrxdqj3EtZhhMneDGRY5bvR6HQAfWG8cH6SdKo38fF30BJTIPV585i51GHgS3Ma1g3pRmORm8ggTRzBOeWduHf0T9A2MyRbfB2Rd+4hurYFlkAipPhCsmvH/2S0IbF2TJu+FYioq94yxTY/TscBYGyxMoZq10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jq2VNivX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TOeXtnbo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jq2VNivX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TOeXtnbo"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEbHNI467702
	for <acpica-devel@lists.linux.dev>; Wed, 14 Oct 2026 15:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZcsKSAXIsUoQvwuqGKNRF/KRcejBeBzxtNR/efR58HI=; b=Jq2VNivXr3uxGVSS
	MTyjKe0JLetyBXmtG3dKPr8Mv5ytFzQ8CaYshGhBD8RUObMdL+Qfo0KWl4YGeZb8
	qBkq1npT0hLsfr8d8exMyjeKAGHJDnWfkV4UjumTHja2ozm+rRopIYU2t1r0IqS9
	Ik28zgkBqH9vO++pbHEdD1y1VfCnL0LsfmoY03OLTOrGJ1PWE30fMZGQk0qa99Lm
	FKAJI605j9r0HiRE4ewKJtWByl6/+UP+OsEPiFbtVPtYigNpCclMlerV7li6KA6h
	ejjs6Nyam98T8r/sIqDI9vUiNKWk5qYMAvN/dgSWPPKeO67vHfol0zY78YbfM0oO
	fCdBgw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9yphk8eu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Wed, 14 Oct 2026 15:30:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93caf7856ffso870955885a.3
        for <acpica-devel@lists.linux.dev>; Wed, 14 Oct 2026 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791991806; x=1792596606; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZcsKSAXIsUoQvwuqGKNRF/KRcejBeBzxtNR/efR58HI=;
        b=TOeXtnboq5JqQsapLQHnGJ4quNOBg3lITCJPMukfEYF+Sg2WMfNTYHukOm4mFIgdi4
         wC8sZBfgfz8FQyIN01cxesvC4kq6BRvMO4OVKtTr4e8aY31Tniolvh1QbqY4xoEY4Eu5
         RMOmqGPDmusgsaAGGKF7ARBmqhsQMT84yiie5iGNStYh/N3Sp3Qk9EygIWkPuumHBS1M
         7B/TCkt6xbn+2pR/QYP60q5rebrdqr/HEnIiVRpU+SPE5e7790g/W7I8Rg7uT9b67zS6
         wX/EFtDqjk4fHnffwg5SKgruxztDYylbKcHueBsfQxGx8H9Ghz47B/dwvUYfkjR9salT
         nhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991806; x=1792596606;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZcsKSAXIsUoQvwuqGKNRF/KRcejBeBzxtNR/efR58HI=;
        b=W0N7LlpV8GmqvpVFJcwSN9gq5Q8qu4wE4lBpMJ2DDmI1oMtyi9P+VynE64TnXS0UPR
         O144Y7MBuXE3Snh7raiZv7ACUARcsHGuGxd+H36+hlzRIxJmxBhSTXrtGPFzk1HPIKY5
         JMW+xbp/BavxYFuWBsGng/NdtuO2c0wXT5MppcPeiP7OPdW50Kttdx9bwKFlMa6DKrEk
         jkjkbaqQpv78hg+a0lh7sTvREyVK2Wheqw0YRZBlP9NyisW1JIx5iUtpod/yUFaaojv9
         72Vs2bCM5ESArdOA2TBR6ut2gH8HOqvIiLTQUgygDL5uFFOze8MWmh9ZzNGDa3Gfg/Wf
         doag==
X-Forwarded-Encrypted: i=1; AKwUvBz2sfJZMM2IMLrPTrnWluI3no1FNPd6T3ej25g/GX9hRhQcOiW+B0CrmNDZS9Drw6fzMWEF8iLsTHFC1lo=@lists.linux.dev
X-Gm-Message-State: AFq9FYLNYJOvEEYbGOjjxreXVraU2Z40ev/1KUYlS0VI4RN7u03B0Yyz
	SwiuQDxzGoTYiqAK1WAZEvvufrB4VnHxxOmafYj4xAVuoJx/h7DhmaMfdhuWk89qIwpA0BIyhRg
	t1l9U4tVpL3LWydnBqnhHLWmrqrj1tl++Kb80HWirsI0zSI/5wiIppBzlDwP8VmAj0/o=
X-Gm-Gg: AYBFou3p25g4z62g1SDfj1fZClUVm0WtjVHZ9ttBneDsqFpAJ6Re8eMFKrEUVhydz6I
	8m19b9KiaJLQgrOkGa1AwdBvdSXl5owEqMr6ZKjx23rqO97D5Nnprec6YfNlDot3t26BUyUnYnd
	WCErS0LPd+sqoCXs6qfIYlFodz0yWnm0VDseiAG/Bvt22wTLSiykldRrLgtGJfYeiEvPIlpVv8B
	xosMynJmt05rRvtmz+qOILlMhDEmi3mQSKRiKNQtDts811ZzBYTE5KiPHo9VA9EL6V4ItacWoUu
	NrUWVwCzHtdoir2A5tKL/V/mOPp3cS1BwJtkGXcVm5kZGf1VpOpCUaqYsWFPb6Gu9W6yvSrk5Ij
	UBTzF5LyrsrzdQ+SpM6nuzHPYUk2lNJ8uciGiAe/dOX+8S8NE8OHfaRmr+iYqjjrwjVu3cNplP/
	r9b069KPAcsV1DmTxzsElArjDZVi4WSWj9dHGw5LBmKjaUCzPFftN2J4/5kLBhyaTH9xs=
X-Received: by 2002:a05:620a:2b90:b0:93e:561c:5bce with SMTP id af79cd13be357-93ebd295d73mr2493797785a.55.1791991806171;
        Wed, 14 Oct 2026 08:30:06 -0700 (PDT)
X-Received: by 2002:a05:620a:2b90:b0:93e:561c:5bce with SMTP id af79cd13be357-93ebd295d73mr2493791485a.55.1791991805667;
        Wed, 14 Oct 2026 08:30:05 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b203762b86sm1331732a12.3.2026.10.14.08.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 08:30:02 -0700 (PDT)
Message-ID: <8be1a245-6061-4f86-9223-0da18d5e423a@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 17:30:01 +0200
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] ACPI: Serialize battery methods and INT3403 _TMP
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Rong Zhang <i@rong.moe>,
        Charis Stratakis <c.stratakis@proton.me>, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20261014132703.93355-1-aliamemis@disroot.org>
 <24b2e368-f0bb-484c-bf88-b9ce3125180f@oss.qualcomm.com>
 <20261014150537.121547-1-aliamemis@disroot.org>
Content-Language: en-US, nl
In-Reply-To: <20261014150537.121547-1-aliamemis@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hKh5JNHsJJ5F5IWkOonm-YyfwxvCaQHI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2MSBTYWx0ZWRfX9UnmLPtnv2sH
 lf01zFSozQEz71c9aqnqUya7+DQaOKcyVst9j2YOj4Z+rQwHlAAKg1bMjmoel+AteylTVwlXbtu
 KWiTWBMjEVHgAwnjS0NFJS7Ui1AvAX4=
X-Proofpoint-ORIG-GUID: hKh5JNHsJJ5F5IWkOonm-YyfwxvCaQHI
X-Authority-Analysis: v=2.4 cv=Uv72pOwB c=1 sm=1 tr=0 ts=6acfa003 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=iUgqFhfxAQh3BSJQTYcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2MSBTYWx0ZWRfX7vTrNCx92+ZS
 k70TXM72d32SCUjIL7nwB5QYyG79B8M5Gpj+gW7AFiER3b6KuoJy02zLeE9DpMZDaoMIVHHi8eC
 vTfxRYNHvUeuE2RPjVGOO7/IRuuaIozWN8ZCwi5mSzc1GIQTgdFS2YKdEMgF/Hkiwc1aVOtlKDc
 X4TjG37QiQal+IeJCWir2PKFtIhSKYDH1j/H8dqDbiIOS212Fz4PU1cafnAaK5NSNm3tw8u1ft8
 4o7RbScnf4hRn0sILWFEdNdt4sSj9PvL4P1xv+/8OnmaQ0kdEqIi2gVt1BxOfekr3oZfy8Cuuoy
 3K4QWB91vyUAny+yoR6HofmiXTeTS8DryNDdmNp1GJ4Sp7O82eO3yQ/XbZHyyb1lDgqhdXrxAlr
 35JStX+3LbehSW7EAYXODGVoogXXPh1IxZgRn2uK+AkOzIgdYVaWhO6s0w0GrZhZqGJr+1wnodN
 jeAUGmYOx4g44UGOftQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140061

Hi,

On 14-Oct-26 17:05, Ali Ahmet Memiş wrote:
> On Wed, Oct 14, 2026 at 03:45:10PM +0200, Hans de Goede wrote:
>> Hmm, I wonder if we should export the lock added in patch 1/3 and
>> then also take that in the ACPI EC interrupt handler ?
>>
>> The ACPI code already uses a threaded IRQ handler for both EC GPIO
>> IRQs and GPEs so sleeping in the handler should be ok.
> 
> Sleeping is fine, but the interrupt handler completes the EC
> transactions, so taking the lock there would deadlock an exclusive
> _BST.  Doing it in acpi_ec_event_processor() where the _Qxx methods
> are evaluated, works though.

Ack, doing it there sounds good to me.

> With the brightness key queries also
> running the \GTST copy, 283 of 891 _BST reads were broken without it
> and 0 of 804 with it.

Nice :)
>> I'm just thinking that if we're going to do this it would be nice to
>> cover the bko221065 UCSI case too.
> 
> UCSI and _Qxx alone aren't enough there.  I emulated the ECMT users
> from the 83DR tables and the EC helpers kept waiting up to ~680 ms of
> their 1 s timeout behind GBMD/SBMC until the ideapad methods were
> exclusive too.
> 
>> Note this is something which can be done on top of this set.
> 
> I can send a series on top of this one for the EC queries, UCSI and
> ideapad if that sounds good.

That sounds great, thank you so much for looking into this.

We should probably ask the reporters of bko221065 to test
the 2 series combined and see if this finally closes that issue
for real.

Regards,

Hans


