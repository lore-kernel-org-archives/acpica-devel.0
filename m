Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373591;
	b=GDnd3phZBBodo17alrm5mRCOj9CQsU0SWO+S5q7EcCOkLgpmnLOhhyPPFK3qDSqtwDnK
	 RV9l0e+6YfE4udGpo7lLa26SlunNOx+xx0u18283h0wdd3MYH3VAAfUsEg/f8xBJ1vtot
	 mp/YpiBX2xHD06yHtLz6R+IPFed07ezZWs+k6Xvkv49kmDzDkR61DWCQXMYLgWSFgUarH
	 Ei8hMhFFCB0agu/kmFtoDXtUdO+wppQOygPkWL+D6ETalHqDnq1OBtYbxMu93vwp6y7O7
	 Cf5FwPyiKB1WNc0UagQzXysQyKjVznH+7bCIv5ifP41/1v+JxCxhMnsazsPDWK6fkow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373591;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FGkyxQN9i0NhBdCJIXq1uYlUjDXSlWOx7RjK7fuDemM=;
	b=xIS/Xvtv6Bi5reOwBFpdkE5iB1RvVfi5J2V9eV/qyeL+EnePLZ0ZhLuRFbQ5qH7qNnqa
	 XlV1Jr+C+7QSl8iCuwD6hVJZV5HutGCit8QeGZKcCKh6Wx9aOta5ObCJyKD7RGjMuZIoI
	 v1Xmjao/at2kvz4FNPUk1x3jMtn8nBn4324vyGp+gkRalAXcYgPbc/0X4pS7+2T06/kp9
	 sUgK2geN++ZxzDG4oqd4uM7Y0STNPuUOaRj99+7N1YVqwtRDHCtf2aigsSeD6QgV5lX64
	 WYzaRmtE2ktxMz7GOfrT4+nXXAchcGbR6kV+05w4ecMSdvB9sR3z6xvXfN/d/1sSSmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AwZhD1dB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jtci50ST;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88779606A321
	for <acpica-devel@lists.linux.dev>; Fri, 30 Oct 2026 15:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88779606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AwZhD1dB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jtci50ST
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UERFjv378155
	for <acpica-devel@lists.linux.dev>; Fri, 30 Oct 2026 15:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FGkyxQN9i0NhBdCJIXq1uYlUjDXSlWOx7RjK7fuDemM=; b=AwZhD1dBRmP8Tyfx
	1gG20HuFAU1a2cuph7IGHXKITBF/tFArNX9LK1LpPvrPPoZFKGjx2dyvKX23UtHS
	NYkC50mBMEpZOVwK0tfV0bMtZdQP0Zvygh4pyvHCeT9r4ri8F4LX2NEMOZVdwpUD
	6QvJUXKDohf7O2ixKt6YHDsvU5FIJxo9Bdq44lvTUUM7NEb01ZRu+mAsgTUlWQ38
	IegLbJqK9w6z7wZ1okemLhEV5SHGhUJTHCcHCvKq9Y7JIqtOmw1qK20MFBeke9C2
	qOvzZ1MeVWA8ESRROuge9EQrQq17hFm5TbUAgnxXp4Ijn+ugmae38k6DVkh4gzIh
	etqevA==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme753pmh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Fri, 30 Oct 2026 15:19:49 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-55bf11583d9so1174167b6e.1
        for <acpica-devel@lists.linux.dev>; Fri, 30 Oct 2026 08:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793373589; x=1793978389; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FGkyxQN9i0NhBdCJIXq1uYlUjDXSlWOx7RjK7fuDemM=;
        b=Jtci50STsn57lLcR6N9xgRqA+oHn1Y3eWHJtsUZpr0qzlfCkeOUf8jy/S3ge9sUIi0
         KlBg70yoVNCNdGwFIUTZywgGtz1imQmg1vR9QYY6G77PYROREl8BUgUjqnqXJFVSFplX
         3qj3h72o3vV1w33pN1wK2jebifdVlLCr6mS/fkvR6TMCuoFSvkRKyqHVzM9xDJFLayA4
         L7wfCsrVLCdNGRrYEXiCupoRMVzhVAbFrdZvmKjU4+V3CxWgPZz4kv7ILUuLPWAgsi2n
         DJWx8zmX/wlEhESrenY9jCOfZhpxN/GvMLyxv6ymRK/nTJunTbrwim59BImoNBES+/Pc
         IdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793373589; x=1793978389;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FGkyxQN9i0NhBdCJIXq1uYlUjDXSlWOx7RjK7fuDemM=;
        b=frHj/ZFrVqN51kV3NLmPtKNqb5famDv7/Gm8ZMdW1U9sx1T2WIE9zserC4x6ZWYvgk
         NHKfC11sbQ0FwI9gPYydCLaYyVvhCg5S4IaiYVybr+HqEzPS1Gw9dOao+kxPVtE236Vu
         OtSGeqfY8+LAznueXRvCg6fGkHCyPGEjfpUsVSrLKW9Zsmxlkbudq/bffDWHPW0tap2x
         HM6V0Ki92sQASMSM/ux5D5OcM2Tbu6rVyNGdvqPEs+BpDA3r9at6lv7w235WcZ+4uHxp
         HZGBk7iA9SaM1XczxnpnFbZ6QJxIXAjmn00H2oUHqRXJfiUlpsjHt2r/diHWHnUiRHec
         8cBA==
X-Forwarded-Encrypted: i=1; AKwUvBxU4J2DMw93b5ZtSlzLsHyCrUWlSq4W6WORmRUZyjmQVNcjh4YgO5qSRUISsPZOuIWw+v0o0kBLSH1i6ZU=@lists.linux.dev
X-Gm-Message-State: AFq9FYIG6Y1xoS83q/nhXPd33R6/LxhstN0jLeYbQXXNkV+S682tumN8
	xWMNxdkCP9rrTwpE3Ox2TjuhvymkQyYp3MxaDBdq+9iXibMER3ToB5mj+yisMEnCEprZivbjmlf
	fSf4p8sF55tE1PECbkxn0/q1gL+rHkRgPNC3TKXDI1hUBgHSDB95IJ4veZ6ioGU4c3wc=
X-Gm-Gg: AYBFou3EXsZmBFWUzhljbfT/iPQnC7uzkFXOoUF2mYpMf+c5f5lEsHJ+0bZ+/niWU9z
	FC9ssOt+LMjPoRJ1WJRQK2uUTuHWPDsGx/P3H6obIm5qH9IdouqqhWwsRErevSufvVjXWeDSwYc
	CfUEkvQO6iHuL9v9otQ09THecVAHSGss1A0Lbjjvh4cSIGYTZbB7TGtU491LS9j+KzG6c+h4c6J
	vj+iEbqMG/0y+7ykaiPj6yHMTD74pcjNiNdoSj7pC3Cwv30znLSkEyaOmIkjuWMaMAVZrHwvSPZ
	6yNTZCj5HnCpQ08oNinEaJOtXGaWIt/Oowdqdn5ZYXG2j9Op7Oj8/J7vIsEB6cyOIDY18QWDxRT
	IsNl1pLyhl9YKmfCfhtk4XHPTwF86AMJg89o5nWQFww0mhGiNXjEHdmgyfrY3VAZfc9bRC5KjLk
	S0s6PYMbSAg5E8d20t5aMsjD5s73A=
X-Received: by 2002:a05:6808:ec2:b0:495:f8a5:8797 with SMTP id 5614622812f47-563ef28e71bmr3103304b6e.0.1793373588657;
        Fri, 30 Oct 2026 08:19:48 -0700 (PDT)
X-Received: by 2002:a05:6808:ec2:b0:495:f8a5:8797 with SMTP id 5614622812f47-563ef28e71bmr3103286b6e.0.1793373588134;
        Fri, 30 Oct 2026 08:19:48 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fe42454sm1821202b6e.17.2026.10.30.08.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:19:47 -0700 (PDT)
Date: Fri, 30 Oct 2026 08:19:41 -0700
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
Message-ID: <20261030081941.000040e7@oss.qualcomm.com>
In-Reply-To: <43301529-f169-493c-bc59-fa08b77e1ef3@arm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
	<20261020101048.00000186@oss.qualcomm.com>
	<0817615d-5e96-4a3a-b39e-3e5d1b88e716@arm.com>
	<20261023142621.00007051@oss.qualcomm.com>
	<20261024003917.283b890d@foz.lan>
	<20261023170405.000060b8@oss.qualcomm.com>
	<at0rs4parlHFGI7k@hu-ashoraj-lv.qualcomm.com>
	<43301529-f169-493c-bc59-fa08b77e1ef3@arm.com>
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
X-Proofpoint-GUID: w6VRvcU5Bn7pgArwTBSauTePiZ1taccI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MSBTYWx0ZWRfXx15BCcpIf8PJ
 HwF+7VdDZtzkZJVNGtt2NWveIMpLF3Hyi4W9f2sj/9DalHBJv9G8nQoAq1HnOplJ91mSTGVmIkD
 4/DCictiVS0q65S6+vVg1HpHOmkhx8zTtUpTGK6lNCKJk4HqVieYEw1470ULLp0ar22t6kkB2gk
 sRE0nnMRONBmoc0EaTV7ctfjGKVcUL4RIEhzGc3+/t46NeNz+ZsPBFYkwKtFndlbWfrkkLv1q8I
 KFR7j0mci3n+vdEwsDWIl+wqTynePhhp1CcO24iM8Hg22PlcfWrdwzt8RjIutgMECvqDQge7vB3
 5BCVo4N57sScMZHUdIu0Cg9W74/PhEHA1WctpfU1zYHwWgasAaO/5pCy98d6CP8LGwRcuW9jY71
 GmZUT/ANxFbjzay8yuKPJHVvZiUmlpF2koUWpn93fGXdQR1u5g9iy0UGwc9yvJ1sFm7tvsDozEF
 W6IWhpaZP2IWKxuOlaw==
X-Proofpoint-ORIG-GUID: w6VRvcU5Bn7pgArwTBSauTePiZ1taccI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MSBTYWx0ZWRfX3REY87p0x+fb
 cO69v9s9cAOXJB3+q7WoSWfgDnJ5jhI8jqXriHKd00dCG2pO+QPf5OB1Xt/oFE9cQj2o+jw+5yC
 xOUHfFMxp/g9fpGBdBCypZvNIPiNFys=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae4b595 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RAp2bQ1MI6N82g0F2AwA:9
 a=CjuIK1q_8ugA:10 a=TPnrazJqx2CeVZ-ItzZ-:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300061

On Fri, 30 Oct 2026 12:51:47 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> On 10/25/26 00:05, Ashok Raj wrote:
> > On Fri, Oct 23, 2026 at 05:04:05PM -0700, Jonathan Cameron wrote:  
> >> On Sat, 24 Oct 2026 00:40:33 +0200
> >> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >>  
> >>> On Fri, 23 Oct 2026 14:26:21 -0700
> >>> Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:
> >>>  
> >>>> On Thu, 22 Oct 2026 09:07:25 +0200
> >>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
> >>>>      
> >>>>> On 10/20/26 19:10, Jonathan Cameron wrote:  
> >>>>>> On Mon, 19 Oct 2026 22:38:39 +0200
> >>>>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
> >>>>>>         
> >>>>>>> The support is mostly duplicated from Memory Error Section handling.
> >>>>>>> Other than differences coming from the content of  Memory Error
> >>>>>>> Section 1 and 2, differences in the support are:
> >>>>>>>
> >>>>>>> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
> >>>>>>> This structure was used to support older versions of the Memory
> >>>>>>> Error Section (1). This is not needed for the new structure.
> >>>>>>>
> >>>>>>> - The compact version is also used by the tracing framework.
> >>>>>>> To avoid relying and propagating a non-standard record format,
> >>>>>>> through trace event (cf. extlog_mem event) the new trace event
> >>>>>>> prints each field individually.
> >>>>>>>
> >>>>>>> The last patch of the serie was only build-tested due to the
> >>>>>>> absence of relevant hardware. apei_mce_report_mem_error() and
> >>>>>>> arch_apei_report_mem_error() implementations were also removed since
> >>>>>>> last version.
> >>>>>>>
> >>>>>>> It will also require a proper handling from the rasdaemon. Applying
> >>>>>>> this last patch without rasdaemon support will silent the reports of
> >>>>>>> Memory Error Section 2 error, cf. ras_userspace_consumers() check.  
> >>>>>> Hi Pierre,
> >>>>>>
> >>>>>> I'd slow down a bit.  We are mid merge window and convention is normally
> >>>>>> one version a week or so anyway.  Better to gather up feedback from
> >>>>>> a number of folk and spin only one revision to cover it all.
> >>>>>>         
> >>>>> Hello Jonathan,
> >>>>>
> >>>>> Ok sure, as the v1 was reviewed quickly I thought there was a chance
> >>>>> of having the serie accepted quickly aswell. I ll wait a bit more.
> >>>>>
> >>>>> Thanks for the review,
> >>>>>
> >>>>> Pierre
> >>>>>        
> >>>> A general question that came up in a related thread with one of
> >>>> our RAS architects. How does firmware decide what to send?  As far as
> >>>> I can tell firwmare has no way to know whether the OS understands the CPER
> >>>> Memory Section 2.
> >>>>
> >>>> So options that come to mind.
> >>>> 1. Firmware must send a CPER with both Memory Section and Memory Section 2.  
> >>> Please don't do this: this would require either Kernespace or userspace to
> >>> discard one of the reports, only if the other one is there, which can be
> >>> tricky. Could be done more easily at userspace, but only if some database
> >>> support is enabled, but, at least on rasdaemon, this is an optional module.  
> >> Good. That confirms my view that is horrible.  
> > Hi Jonathan,
> >
> > I agree that an _OSC capability is the right long-term solution.
> >
> > Firmware should select one native CPER format based on OS support, rather
> > than emit both Section 1 and Section 2 and leave deduplication to the OS
> > or userspace.
> >
> > For a Section 2-capable kernel, we may still avoid a second GHES notifier
> > chain: preserve the existing struct cper_sec_mem_err * contract and give
> > it a lossy Section 1 projection of a Section 2 record. The conversion must
> > translate validation bits and clear validity for values that cannot be
> > represented, rather than truncate them.  
> 
> I understand we might want to emit a new extlog_mem2_event and a lossy
> extlog_mem_event for legacy userspace, but I'm not sure to follow how
> you want to do it.
> 
> Do you suggest that we only need one notifier (ghes_report_mem_chain)
> and that we should not add ghes_report_mem2_chain ? This would mean
> that the .notifier_call (= ghes_edac_report_mem_error) should handle
> both cper_sec_mem_err/cper_sec_mem_err2 struct.
> 
> Another solution would be to keep the ghes_report_mem2_chain,
> which would be responsible of creating the lossy v1 struct and
> triggering the original ghes_report_mem_chain.
> 
> > That preserves legacy EDAC consumers, but cannot carry all Section 2 data.
> > Updated userspace needs the native Section 2 payload through a
> > full-fidelity path, such as the existing GUID-tagged raw CPER event.
> >
> > This does mean an updated userspace listener may receive both the legacy
> > EDAC summary and the raw Section 2 record for the same firmware error.
> > They are two kernel views, not two firmware reports. We should therefore
> > add a shared GHES record/section ID to both events, so userspace can
> > correlate them reliably; address and timestamp are not sufficient.
> >
> > So _OSC solves firmware selection for old versus new kernels, while a
> > Section 1 projection plus the raw payload handles legacy versus updated
> > consumers on a new kernel.
> >
> > Thoughts?  
> 
> This will put more burden on the firmware, but this seems the right
> thing to do. I ll share the thread with the group working more closely
> on the architecture aswell,

We have will have a code first proposal for the _OSC part shortly. Just going
through internal review.  I'll make sure you + others here are on the +CC.

J

> 
> Regards,
> 
> Pierre
> 
> 
> > Thanks,
> > Ashok  
> >>>> 2. For whatever other reason a platform knows it doesn't work with old kernel
> >>>>     so can assume support in kernel and hopefully userspace got updated too.
> >>>>
> >>>> 3. We propose some additional discoverability (quickly - code first) to ACPI
> >>>>     so that it can be a negotiated contract between OS and firmware.
> >>>>     Until the OS confirms it understands Memory Section 2, firmware has to send
> >>>>     the older one (or risk the record not being understood).  After that
> >>>>     negotiation it can do what it likes - probably send the Memory Section 2 form.
> >>>>
> >>>> Option 1 and 2 are ugly at best.
> >>>>
> >>>> Obvious path to me for option 3 is an _OSC like the one for generic initiators
> >>>> that we discovered a need for whilst implementing that years ago.
> >>>>
> >>>> Anyhow have a better idea?  The above doesn't solve the end to end problem as
> >>>> maybe userspace still has no idea what this new tracepoint is, but at least gets
> >>>> us past hop 1 (so through the kernel).
> >>>>
> >>>> If we conclude _OSC plan works I'll draft a code first proposal.
> >>>>
> >>>> Jonathan  
> >> On another note, Pierre, any plans to actually enable a path to the tracepoints
> >> on arm64?  Today they only emerge from acpi_extlog which is x86 only.
> >>
> >> We definitely want the richer data for PFA and obviously for userspace nice
> >> to share tracepoints with extlog.
> >>
> >> Jonathan
> >>
> >>  
> >>> Regards,
> >>> Mauro  

