Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4137952E059
	for <acpica-devel@lists.linux.dev>; Tue, 29 Sep 2026 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699728; cv=none; b=EVYfDYHkoVhypJC418pz4d80LY6wktGfgGUDfWu+yP7mcPhCOrixACbGPLGSZ4qDtGnhcIHCYz8O+8X/FIqbwCCnMhMl4aYEQJazgvCnERH9+9C8z4KJ/2Vhw9oYHrGK9hCqp1UMBinMUh550UmET5/t4tuUJfMup9R1ta1t6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699728; c=relaxed/simple;
	bh=47rwlglKSQxfxEDXXmuEm44Dq/NXlBUlHanQleCqj5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YIKlxTu6Bdz8fqNQKjCRcRgp4eYw5SxJbpq6MIcy5tMT7sf47VPziCbjQzwR9glsae2HopASRAh8DubOuJAOCpLNWFGRJ/hOLq4LHYdgra40B7Ov6iY3b/zWBfusCTdJTyjFwbadGAEOKy/EBawTquSLAekPbIl41O6e8FO5X74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ThElj4IK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QTNff5jP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ThElj4IK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QTNff5jP"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqmKT613838
	for <acpica-devel@lists.linux.dev>; Tue, 29 Sep 2026 16:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QFiMMBdl/YpceHjKDolf2xod3hSnCtpF9Xk21w7Nw2A=; b=ThElj4IKoevghTAa
	4XiJQlDhMIyY1XUHykZQSTSS+vlsvajzHyW34tKwk4T9H9WSo+o2LtEABTw84mK9
	i3/s+pnm1hl7EYJzsVlfJHpyDFqlhsgxn8Iq81MzIoMOhD3BQvtzw7ofgQCzv8aj
	N6sVj1wB9vLTCew2UKGNpE7GAVjXCK30YIF4ywcxdOBLiqny2OwUEPx2jtBYS46K
	loqvi279e8mMjRHAZU6kLRlBRtxFEvekfAzbxfRCf/elUqmSUMMyBCmG0/bkW24b
	PB/w7WQJbrbQV4V7i+FWCl8GJ5xPHiQVikoRdv5mCEkV45TUc1wZSQnFjh8k7ws5
	1LVvQQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h03ew3kpg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Tue, 29 Sep 2026 16:35:23 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so3111902a12.1
        for <acpica-devel@lists.linux.dev>; Tue, 29 Sep 2026 09:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790699723; x=1791304523; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QFiMMBdl/YpceHjKDolf2xod3hSnCtpF9Xk21w7Nw2A=;
        b=QTNff5jPXFPE8UEQ9a7fQv+AaTHDAfvZQ59YxYUXO4IyGtlkF40bBtcEBkdIDZdCI7
         u/MaTAgAwfzJIHU/vRlZ0ltuCiR9f47TqR8uAgxQVGWEDS2AHJpM/b4DnmwO/Vscz+/U
         +AIHhAtlra9OmDRJt9z2KN5mpMkqp70gLwqsd2L6ltlr6gLILmHxVHTiqhsDayWP+4ST
         lR1w1AKm/sCqazVP9zcQqswVD5VmGMiAPXbFUiYfSIQzfOVCUKYbYob8E5WRkCxSFqKA
         jrIvRc0gLPbsclR64cA3wNtVNxjMd1qa8XiCraXy6yO7xezo/ExxERyb0ry+1G30G834
         G83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699723; x=1791304523;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QFiMMBdl/YpceHjKDolf2xod3hSnCtpF9Xk21w7Nw2A=;
        b=T6/nML4dvT+O8F6MiCursa+soR6ePl6ml1SyItzX0+M5du7kWHZtoF+bbL5CAB+X8/
         B7uYC2OpojixWawu3tMJHrKqhVpypB+ZhPLP5ZCUmb+rHvLrLsWelfB03cVLJhKbHcqt
         ZlEqI1JJrwyxIKiVYjJKAzl/cJe4TovLqEz545NvNrkAiHeHqMClLdeTjPVLUG5BsLlH
         Uf8TECd5+jXN8OUX0djAEUo/kEpDbVMBfsNRTWs3DiF3R1YNSvVsk3Vm9MSpXdJKBIyK
         3+Iabndmr/sppsixadLx4LUqrb9oRIZ7BfxdO4L/arZmU1ShqWB012XeX/IBDqXb/7+b
         +ucw==
X-Forwarded-Encrypted: i=1; AKwUvBxR76V9t3zQbfiWSx8DgXgzvl2qPWrTKdrF0UWh+sgEApAWxQh/dEr0g/bbG6o0YptivJ653J4o5C0RACM=@lists.linux.dev
X-Gm-Message-State: AFq9FYIt4/0Sb5JmatZvl7JPa7RrhI8a+mYEGXxSSQd9SZQZZuLZRynK
	COgvDFlMzR6C9n0hRE49ZpeqgHVlJZ7+BebU4/kyDj+qRzCRj5Tbv5EkB9x2rszWTKvtLyxUbC5
	InJ4I1AsIF0cEwfrew+2BEiGxqZpjECrQgBbiMAuPLl79QdfvdadqjxF6Nv8sKUwKFv4=
X-Gm-Gg: AYBFou01LheqPfvrMF+ePXz7MsEP0suZo1fHrcaC0gkJsvFx5KCasN0uWPC63Xiz/us
	ibhK04LLcdplG8s0wzZ79BNzovmlvH6KPtku/wWOFED5aRzB02+evvG1WHQR9tcYMVq/3tE4K+L
	XFVY6H2JJF2Vc1i42HHj/zJMDUS+KtuFmfTrmithKcvbUmHOIH51e80xKXIcAGeaXovVR34jJew
	yMsqVHlQyLgBYK6MB7kTtcAVpcpcVjfyrQNl6hJBwqkcp7pd5ZPqQVECsvIL5WA3SQB/Dkc6M7z
	OM9SYWY01c2N2Gt3j3Oc6/K6BJC6pw2C9osI5C1hbn4rpGWAqko1k5jr70sd68gvldOw/fpv8QY
	Ovdr21QCVP56VnR1S2hkORZzAa5LFGi+OQbpPIavRWqnNK+nWqzEkeEo=
X-Received: by 2002:a17:903:26c5:b0:2dd:c0ff:e727 with SMTP id d9443c01a7336-2df7dfd63f0mr145703425ad.57.1790699722886;
        Tue, 29 Sep 2026 09:35:22 -0700 (PDT)
X-Received: by 2002:a17:903:26c5:b0:2dd:c0ff:e727 with SMTP id d9443c01a7336-2df7dfd63f0mr145703055ad.57.1790699722348;
        Tue, 29 Sep 2026 09:35:22 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df90fbb201sm60790195ad.9.2026.09.29.09.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 09:35:21 -0700 (PDT)
Date: Tue, 29 Sep 2026 09:35:16 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mark
 Brown <broonie@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin"
 <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Hanjun Guo
 <guohanjun@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shuai
 Xue <xueshuai@linux.alibaba.com>,
        Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>,
        Pawel Chmielewski
 <pawel.chmielewski@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>, Radu
 Rendec <radu@rendec.net>,
        Avadhut Naik <avadhut.naik@amd.com>, Kees Cook
 <kees@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>,
        Breno Leitao
 <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
        Dan Williams
 <djbw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Morduan Zang
 <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [RFC PATCH 0/6] CPER: Add Memory Error Section 2 support
Message-ID: <20260929093516.00003781@oss.qualcomm.com>
In-Reply-To: <20260929074659.2587216-1-pierre.gondois@arm.com>
References: <20260929074659.2587216-1-pierre.gondois@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2NiBTYWx0ZWRfXwK80q+KVazns
 a1cFWkpFWoS/ULepanrR8c/mNk5EksvpvhmZCIyMp16FkvcxEHyO73S3rTjJnnzghzXtufoI/ly
 hoO2CBf6e5+k+A6Ymb3DFab2S2bzbsE=
X-Authority-Analysis: v=2.4 cv=IIOXmQvG c=1 sm=1 tr=0 ts=6abbe8cb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=7CQSdrXTAAAA:8 a=XM342pYOwZ3m7ahhEzQA:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2NiBTYWx0ZWRfX7Ulp035nJDtP
 UtQt+zx5V0s7/2PcS7/Y7c4plq1TcUoTe1bk7itIVci+/XkBFjt7m8hwiL3XFsHqDnUkH9fO2LG
 sYlvLAh8QGkdr8/DrnQRj9th2bvE0qowhPBM6saaICUMeoBt0/cNL/LDXvToG0VashgOgCcDHAa
 U6wQvz+bNNzr3PNmdsOsEworCBohZUYSPnaTxNpx7h0UEE/vUKUEhr81SE4VYVMqkK8UorxcD0+
 IIk/XWyf+3pOthXnDazhyGKLNyUwFXIhEF2mKmCYj3rBHSiCaB+3xreczTojegwYu3ig7RfJlnZ
 ZddpVN+wthsXmu804ye8DV5chZY9hBxSQnNY3KCZ84V2oqDosk3Con34YgES5tiYaPLCXDbO02T
 r3aiIN0Y60tjZ9D3cqCPN3SJtdTB7EOTcisx4o3WjDjFqzrC/a31/OCymUfcWeIWE8qE+aIpWbi
 DCUJjDSOnGFAYxMvVEg==
X-Proofpoint-GUID: w6FfWQyWOSgzTB9LhGATEUGKLcQnVleG
X-Proofpoint-ORIG-GUID: w6FfWQyWOSgzTB9LhGATEUGKLcQnVleG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290066

On Tue, 29 Sep 2026 09:45:59 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Add support for Memory Error Section 2 records.
> 
> Extend cper_mem_err_compact to hold both legacy and section-2 records.
> Add a common parser and convert the CPER, GHES, EDAC, extlog and x86 APEI
> paths to use it.
> 
> The extlog_mem_event payload layout changes with this series.
> Compatibility with existing userspace decoders still needs to be
> addressed. More specifically, the rasdaemon relies on the current
> struct cper_mem_err_compact definition.
> Either:
> A-
> this patchset should not modify struct cper_mem_err_compact and
> create a new structure to handle Memory Error Section 2 events,
> but this would ignore the similarities of Memory Error Section (1)/2
> B-
> userspace should not rely on the struct cper_mem_err_compact
> layout. extlog_mem_event trace events should instead emit data
> that relies on the actual layout of the CPER records, as defined
> in the ACPI spec.
> 
> I am looking for guidance on how to handle the above question.
> Current implementation lean toward B, but emits data in the trace
> event that maps the new/updated struct cper_mem_err_compact.

My initial thought is a no to modifying the usespace ABI.

It isn't particularly painful to just have separate handling code
for the new record.  Unfortunately the ext_log tracepoints don't
split out the fields in a fashion that would let you change
the structure.  Other RAS tracepoints do it field by field which
would have been possible to augment - even then it would have
required care to deal with field size changes.

It may be worth considering a much more 'expanded' tracepoint for
memory error section 2 to reduce similar future extension problems.
That is express ever field and don't use a compact structure at all.

Mauro, perhaps you can give input on what works better over the
long term?


Jonathan

> 
> Pierre Gondois (6):
>   ACPI: extlog: fix extlog_mem_event build issue
>   cper: add Memory Error Section 2 structures
>   cper: extend cper_mem_err_compact struct
>   cper: add helpers to handle Memory Error Section 2
>   x86/mce/apei: switch cper_sec_mem_err struct users to compact CPER
>     records
>   cper: make cper_mem_err_pack() static
> 
>  arch/x86/include/asm/mce.h     |   4 +-
>  arch/x86/kernel/acpi/apei.c    |   2 +-
>  arch/x86/kernel/cpu/mce/apei.c |   2 +-
>  drivers/acpi/acpi_extlog.c     |  23 +++-
>  drivers/acpi/apei/apei-base.c  |   2 +-
>  drivers/acpi/apei/ghes.c       |  20 +--
>  drivers/edac/ghes_edac.c       |  26 ++--
>  drivers/firmware/efi/cper.c    | 219 +++++++++++++++++++++++++++------
>  include/acpi/apei.h            |   2 +-
>  include/linux/cper.h           |  58 +++++++--
>  include/ras/ras_event.h        |   4 +-
>  11 files changed, 283 insertions(+), 79 deletions(-)
> 
> --
> 2.43.0

