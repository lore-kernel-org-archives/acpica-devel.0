Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396421;
	b=SYZx9T7G9h4ok6qgErrLSdKTBJO89xfMxNa69OOq7WM9+dayE0TEeyA6TM4AM/YgpyUc
	 6SRoxCBXHQz73MTyq31GLeDQ5S98Y5tbQxrfJcGVkFZ375bmvl1JOMIT3rgsqwBEBfs1d
	 a9tqZatpB8LMYJg7L9e6hnmMLZUy6/XjP30gNGb2lIMUJRoGd0ecbrA8Fn0zbUGhzcK4j
	 AzeCWoozhZh2r6jiOccmm6EqMuH1cafYLVvB57Qh7MrL21lYyuUVM/7xxnOS65JFqDkPG
	 qKF7hfV9CNUh8dhp8UpE+Gmv1QJQPfEzfCOK+qyJqCKjJUaKkId8Td6RlAukMjP3yhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396421;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=AzamBldx86MhDlsFg4AtMRiwjZaUeXBeihXriheeQTU=;
	b=wLHMDkbouYa1qValHYywB6d9RLt2QlwES7mvB30kbNtXcIwA4D5haH12dZOUgGQxZkX7
	 QiKa46B99wDGYoq/n7u46vYqtrmUZg40grw8CupAGo/FpE/T+UhgGiN1skxcYVNxZvyuo
	 2a53pb+9dJIY37bYmPonvVVbHUDV7ib0RHnj8pc104RnAJ1FKBEdCmgkgyLr7fTZJTE5L
	 LUKVzJ76J06lWOW5A2mqO4BQx2EJJh1lTCswOAJ5n/I2SlYaKY4i2Ro7a8Ps6W9k96FUl
	 asfr/HPJMdYQ98BR2ag29Gozb9nJeEM+UK0oAPjuyMfb41gTNQwl5AFy3wT79RyH81Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bfs3p0Dk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QrYLjltS;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17743606A329
	for <acpica-devel@lists.linux.dev>; Fri, 30 Oct 2026 21:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17743606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bfs3p0Dk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QrYLjltS
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ULAwgd4087134
	for <acpica-devel@lists.linux.dev>; Fri, 30 Oct 2026 21:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AzamBldx86MhDlsFg4AtMRiwjZaUeXBeihXriheeQTU=; b=bfs3p0DkFZKaSceC
	vlX1bd0BKhJEnIsymsRUWJ7yd1yDZXKKvugBcFpoUzvzcC4+apH39jdaK3OrWlUY
	hdHpSo2cEgYmjpelO34Sng57/Dx2Q3phKrK7rdewRDP2zwDbuOCj0KP718ThKMjF
	6OJotWNLHDy/WM3iux+vAzv+oR0xZhQ2THdceY5sHxL0x2VNP4R6WzWX8An6R54l
	xKOGKbL+3SLJbzHbvhUP+guCrL79i4TJMpi/3xH2YHFuQ3S+VWMW354qlLcgBLf3
	cVHgVmzIrLceeI+Vc4u3039QlBRWWa/8R6cPHxJvQZAWPUBlE2woOlK8tncXhBYo
	ivS45Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x10513-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Fri, 30 Oct 2026 21:40:18 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36637676140so1705050eec.0
        for <acpica-devel@lists.linux.dev>; Fri, 30 Oct 2026 14:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793396418; x=1794001218; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AzamBldx86MhDlsFg4AtMRiwjZaUeXBeihXriheeQTU=;
        b=QrYLjltSA9cQgwtdWP/1FKAmcL2hFMvUl9rqCZAhYZkADA2KkOOkcOGotQJ/CsiJuF
         rHC9H/NhqKPXExxxZht7YdHckwIUpMBhnAb1RHNhjAOPf1NQPbXMPYpddO1otgiyP4or
         /0yY9Iapho1TiVhIwpW14c39mXu+CIEqZm8zpalBALU0EHMd5tHQ14HJ9E+a7kxiCU9m
         M/36YSScxsWfqJ0Ipm1EPvkG9FXSYFsz4jOrBnyyCPOcZyCFsRxCbrjuUZFK1ulN023Y
         NVa/bVPZZCJ+MrQqUxFB0wsyx0bJSDd1ix3JJ4i9asevRGupVL9LLEIZagSgvXgXUlAi
         +R9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793396418; x=1794001218;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AzamBldx86MhDlsFg4AtMRiwjZaUeXBeihXriheeQTU=;
        b=zmRnl0yL71OrJ6ap1rpIAzV05TdFO76P5g4aQCLGEUEHd337m9B3lyQPG/P/BlVtOd
         eIuINi3AzLrkFumMHHe44wtJiM9Vm1VUVeJRQYIV5q3vf65+DqZTtEOiPuKr09/gR0zO
         iWLTSh7HI11CDlugsVVjI0p+H6dO9A9hgeayDjNWnJB7kGlbuO6CWvhsnUxNd46Z1fj+
         w2rcuhKD0U4b3hgWTWCwVN7pBJdKKnic3slgElaHpnNCRr0mxzz1QUQo80Y6x7x0Zpq4
         na393oL4TdysUx6MvimkTdL5F317q4iKdFVz4Fj1QPFFbrfzuK9cSinQxsZARS/IJtkA
         4/Pw==
X-Forwarded-Encrypted: i=1; AKwUvBwgNaHwLNC1tVQVCcd2J2U6mqwhaxVdyU816ocZ3HMfTP+hvN3gmk+9K29idZjHB1VtrCzyS/wLn7FBzzU=@lists.linux.dev
X-Gm-Message-State: AFq9FYLVqBwzmIDPhxwu2QjqSr8I3nGfxbsX1Gx2V+TvPGSoET/6mZc+
	EAeOeZo5PTvwPtfWAJRfzuIZpqYAFEaLsH5d+AhqfMWnCNFDz3iOYH0NA417pthzfcMGupRqJsT
	AppOtDc8PL+Ir4I7GR+m3T/zFSF4PHkTWEg0u3kMlsMzilVpM1Uv/QZ+Oow3P8ZTHi4w=
X-Gm-Gg: AYBFou1bzPNaAhqmdUS+qBS006Xoi5dXCE/T+k4PhVPXNzBomfWlGIRzs/ZOXWRP15k
	wBSFCtWPx2vF5AnTBX92lSZRWO6E25D0H3jpCK6AdB/8ughWQNbjADrg6R0//4ig5IDUFIFKTLo
	u7VPN7qBjznFtJU6hUwxO0VAmkS8Rnk4oWV1UlvwfgqJ9zjR6VrBZZjv2okZnS3cgbE2XtqPKjG
	J5zAQSIrRmDZPfN29VZP5kO9pJ9B0gjRnSxHI4u3pIOavqvE/qAAIrHy6FEZMXWus8d4Vp3IuE3
	GIa7H0VLtgacyWZKZKj5BE3lElhqxzxTw8rHfk0X5HtW2w7X9rGHZITISvhId9J4wvtSI5KIl6f
	5rHEbh/TO7LxrhXGEQdSJ0e94ZTCKXi6+rdgylSRghYds8HEpZW5NSQuEhpZZ1TAVv756MHphPl
	kI69Xx4H+PyFgmyNZ+aVKB6EN8K4Y=
X-Received: by 2002:a05:693c:4154:20b0:35e:f4ac:5f8e with SMTP id 5a478bee46e88-36a420574admr5315647eec.0.1793396417776;
        Fri, 30 Oct 2026 14:40:17 -0700 (PDT)
X-Received: by 2002:a05:693c:4154:20b0:35e:f4ac:5f8e with SMTP id 5a478bee46e88-36a420574admr5315576eec.0.1793396416900;
        Fri, 30 Oct 2026 14:40:16 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm13643226eec.16.2026.10.30.14.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:40:16 -0700 (PDT)
Date: Fri, 30 Oct 2026 14:40:13 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
        Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Borislav
 Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, James Morse
 <james.morse@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
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
        linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev,
        Ashok Raj
 <ashoraj@qti.qualcomm.com>
Subject: Re: [PATCH v2 0/6] CPER: Add Memory Error Section 2 support
Message-ID: <20261030144013.0000320e@oss.qualcomm.com>
In-Reply-To: <fdbce441-921f-4ef9-9c57-0685706cdf89@arm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
	<20261020101048.00000186@oss.qualcomm.com>
	<0817615d-5e96-4a3a-b39e-3e5d1b88e716@arm.com>
	<20261023142621.00007051@oss.qualcomm.com>
	<20261024003917.283b890d@foz.lan>
	<20261023170405.000060b8@oss.qualcomm.com>
	<at0rs4parlHFGI7k@hu-ashoraj-lv.qualcomm.com>
	<43301529-f169-493c-bc59-fa08b77e1ef3@arm.com>
	<20261030081941.000040e7@oss.qualcomm.com>
	<fdbce441-921f-4ef9-9c57-0685706cdf89@arm.com>
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
X-Proofpoint-GUID: Sv2DVQDkY4KFpZcGf16tTdV1vt4-xF5I
X-Proofpoint-ORIG-GUID: Sv2DVQDkY4KFpZcGf16tTdV1vt4-xF5I
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NiBTYWx0ZWRfX/R31AflyM9Zg
 MA2QJGVLzRHMFcujP0QRMh9BkGxJCi3eYYJaC070d73xgKy09d7mDwlgdFp+bItfy+2xOThaTaj
 xjArBkGXIcyNKcY23+AjOnqYCv+nhmc=
X-Authority-Analysis: v=2.4 cv=abD0Dhot c=1 sm=1 tr=0 ts=6ae50ec2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=OkvmfuOBzfRrInaeso0A:9
 a=CjuIK1q_8ugA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NiBTYWx0ZWRfX1wYDLjsVBYEj
 Xdrj9Z2Ucb1KoX5L/PEnY4x8cq6RNIDU7EQKUzXGBZhaNNUycd7nx0fgW0SMAzg0JfHbUpOwMhG
 90QBJWl4IzhRV3a5KxYa6Jc27RkAjNQsqEoKvOaCJ1oUhm+nCHIaiOAAw71+nJb9x8fLaLLeSu4
 fNgenWhT79D1/Mv8+ljzzpXyyDhVPZHrnAh55OP0e/j3W1Yo0l9tdGsgXtNRt/M/ujB68+gc+Eo
 kvxgeoq+NgcVLaS/VEFEafkxyHs/eekg5lhgiUq/ghf2g5QPI5EPnf4xudpZdLV+LOF2POQN8L1
 8gL8Jq+7VcKB+v7l6x3JfThAOLIHmeubMlpVkkkVDTFg4eDXFLpsZuhk4ZwDJ/luOhvTPCuw4/0
 puqOpJntvTI8FgafWj5WBU+8ns0trE4wsJlxSgLJzNlcIyyI0EXxinLiw3tOX6VLOqg9MFoc0St
 Pk/f2ME+JIj3dp8sydg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610300086

On Fri, 30 Oct 2026 18:16:06 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> On 10/30/26 16:19, Jonathan Cameron wrote:
> > On Fri, 30 Oct 2026 12:51:47 +0100
> > Pierre Gondois <pierre.gondois@arm.com> wrote:
> >  
> >> On 10/25/26 00:05, Ashok Raj wrote:  
> >>> On Fri, Oct 23, 2026 at 05:04:05PM -0700, Jonathan Cameron wrote:  
> >>>> On Sat, 24 Oct 2026 00:40:33 +0200
> >>>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >>>>     
> >>>>> On Fri, 23 Oct 2026 14:26:21 -0700
> >>>>> Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:
> >>>>>     
> >>>>>> On Thu, 22 Oct 2026 09:07:25 +0200
> >>>>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
> >>>>>>         
> >>>>>>> On 10/20/26 19:10, Jonathan Cameron wrote:  
> >>>>>>>> On Mon, 19 Oct 2026 22:38:39 +0200
> >>>>>>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
> >>>>>>>>            
> >>>>>>>>> The support is mostly duplicated from Memory Error Section handling.
> >>>>>>>>> Other than differences coming from the content of  Memory Error
> >>>>>>>>> Section 1 and 2, differences in the support are:
> >>>>>>>>>
> >>>>>>>>> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
> >>>>>>>>> This structure was used to support older versions of the Memory
> >>>>>>>>> Error Section (1). This is not needed for the new structure.
> >>>>>>>>>
> >>>>>>>>> - The compact version is also used by the tracing framework.
> >>>>>>>>> To avoid relying and propagating a non-standard record format,
> >>>>>>>>> through trace event (cf. extlog_mem event) the new trace event
> >>>>>>>>> prints each field individually.
> >>>>>>>>>
> >>>>>>>>> The last patch of the serie was only build-tested due to the
> >>>>>>>>> absence of relevant hardware. apei_mce_report_mem_error() and
> >>>>>>>>> arch_apei_report_mem_error() implementations were also removed since
> >>>>>>>>> last version.
> >>>>>>>>>
> >>>>>>>>> It will also require a proper handling from the rasdaemon. Applying
> >>>>>>>>> this last patch without rasdaemon support will silent the reports of
> >>>>>>>>> Memory Error Section 2 error, cf. ras_userspace_consumers() check.  
> >>>>>>>> Hi Pierre,
> >>>>>>>>
> >>>>>>>> I'd slow down a bit.  We are mid merge window and convention is normally
> >>>>>>>> one version a week or so anyway.  Better to gather up feedback from
> >>>>>>>> a number of folk and spin only one revision to cover it all.
> >>>>>>>>            
> >>>>>>> Hello Jonathan,
> >>>>>>>
> >>>>>>> Ok sure, as the v1 was reviewed quickly I thought there was a chance
> >>>>>>> of having the serie accepted quickly aswell. I ll wait a bit more.
> >>>>>>>
> >>>>>>> Thanks for the review,
> >>>>>>>
> >>>>>>> Pierre
> >>>>>>>           
> >>>>>> A general question that came up in a related thread with one of
> >>>>>> our RAS architects. How does firmware decide what to send?  As far as
> >>>>>> I can tell firwmare has no way to know whether the OS understands the CPER
> >>>>>> Memory Section 2.
> >>>>>>
> >>>>>> So options that come to mind.
> >>>>>> 1. Firmware must send a CPER with both Memory Section and Memory Section 2.  
> >>>>> Please don't do this: this would require either Kernespace or userspace to
> >>>>> discard one of the reports, only if the other one is there, which can be
> >>>>> tricky. Could be done more easily at userspace, but only if some database
> >>>>> support is enabled, but, at least on rasdaemon, this is an optional module.  
> >>>> Good. That confirms my view that is horrible.  
> >>> Hi Jonathan,
> >>>
> >>> I agree that an _OSC capability is the right long-term solution.
> >>>
> >>> Firmware should select one native CPER format based on OS support, rather
> >>> than emit both Section 1 and Section 2 and leave deduplication to the OS
> >>> or userspace.
> >>>
> >>> For a Section 2-capable kernel, we may still avoid a second GHES notifier
> >>> chain: preserve the existing struct cper_sec_mem_err * contract and give
> >>> it a lossy Section 1 projection of a Section 2 record. The conversion must
> >>> translate validation bits and clear validity for values that cannot be
> >>> represented, rather than truncate them.  
> >> I understand we might want to emit a new extlog_mem2_event and a lossy
> >> extlog_mem_event for legacy userspace, but I'm not sure to follow how
> >> you want to do it.
> >>
> >> Do you suggest that we only need one notifier (ghes_report_mem_chain)
> >> and that we should not add ghes_report_mem2_chain ? This would mean
> >> that the .notifier_call (= ghes_edac_report_mem_error) should handle
> >> both cper_sec_mem_err/cper_sec_mem_err2 struct.
> >>
> >> Another solution would be to keep the ghes_report_mem2_chain,
> >> which would be responsible of creating the lossy v1 struct and
> >> triggering the original ghes_report_mem_chain.
> >>  
> >>> That preserves legacy EDAC consumers, but cannot carry all Section 2 data.
> >>> Updated userspace needs the native Section 2 payload through a
> >>> full-fidelity path, such as the existing GUID-tagged raw CPER event.
> >>>
> >>> This does mean an updated userspace listener may receive both the legacy
> >>> EDAC summary and the raw Section 2 record for the same firmware error.
> >>> They are two kernel views, not two firmware reports. We should therefore
> >>> add a shared GHES record/section ID to both events, so userspace can
> >>> correlate them reliably; address and timestamp are not sufficient.
> >>>
> >>> So _OSC solves firmware selection for old versus new kernels, while a
> >>> Section 1 projection plus the raw payload handles legacy versus updated
> >>> consumers on a new kernel.
> >>>
> >>> Thoughts?  
> >> This will put more burden on the firmware, but this seems the right
> >> thing to do. I ll share the thread with the group working more closely
> >> on the architecture aswell,  
> > We have will have a code first proposal for the _OSC part shortly. Just going
> > through internal review.  I'll make sure you + others here are on the +CC.  
> 
> Ok thanks,
> If you can also also add Mark Brown <broonie@kernel.org>
> 
https://lore.kernel.org/linux-acpi/20261030143802.0000231d@oss.qualcomm.com/

I started a new thread so it wasn't too buried.

Thanks

Jonathan


