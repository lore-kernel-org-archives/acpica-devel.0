Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800258;
	b=QMLnlBPUjULoG/c0Y90p3jOSkvD12/Sn1r3SZU2HL3peIj7C7Vw63qCTcSdqzOjNirye
	 41FohxAP3MEOyQVil+Ds99C3joN3SfJ+ZnBqpg+G2S5IQCSFuJo8gdV8tjSRolf/NySSD
	 X02A57ui89i3ngX3oPEkxKgVqi7++yjTHzU9eCnQoYooU3niHC4QgY4DYmFi203pDtt8a
	 DO0lQhopf73oR0Jp0GkfgW1ICPfRuugqU0bNKPiUINSrVXsHiujLnzB2DHKDeHMzfYpj6
	 S/5GP9ywadFBee+kJ98L7ixR6k+mg3Za52dmw3iHUPSDSUcdYZLklnrGKFbhBc42nBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800258;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=I3wuHmWmGvXCtEnDUsJhkbmfuPnqQvs8DG+95QVzPvo=;
	b=O+kU2njDkHYFdnDInSFfPN2cVrgulkGrR508l70S7+Dz6ViRN+7xTpzRo9bYBeF6xkqj
	 NWSCyU6uPe9Kbqeyy6iHhNP6nx3IgIs8pM0jYsfE+0WGXHpumPvdk18F6olsAkAivtToe
	 wGXw9n+ilDt7CNyIGRkkJevO0dKlB9Vl9bmpftzR50ZsA1xrjX3mLeY6N5FvMkNgNpA4j
	 njIc0ozqZ3ZPBbnN6mrIAubZFbK864cKIya4E6lTKQZ8ifalb6I3ZDIO0YX64TquZzAF8
	 Lon3RlP1NKbHacyaHgRmM5PwUdehkC7dZqJAS4cTyZqUllTrEFAnfb0qsr9EbrnZPxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jNkuuk4I;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iIvmbFLn;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C6606A324
	for <acpica-devel@lists.linux.dev>; Sat, 24 Oct 2026 00:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C97C6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jNkuuk4I;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iIvmbFLn
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLvNNT372296
	for <acpica-devel@lists.linux.dev>; Sat, 24 Oct 2026 00:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I3wuHmWmGvXCtEnDUsJhkbmfuPnqQvs8DG+95QVzPvo=; b=jNkuuk4IgwSv7LIN
	QjlEVqboix2Uhx3LX0GdsDVcM6gUaaZs9kfYdLK/tTA6awMBcp8eeSDtJ5/Fh7ft
	kUFgaIP7onQ7cW15aR+Nl/e9uLd/67A3y2pLZ7t43M+OfhmpVdcoEA8eyRaHULwr
	eQxDVRmG3yH/yXhN+QXkXwvgaWxhzbZ3Z/10JKKeG+3WRlKz3fH36pSSgsyOOasj
	t54pvJx3PEso5l0PZYq4Uh5mddeqLRlSFwMkbREj959unA+uLDqpuZ0J6LnLHV+x
	vY5Aq7hxo41J7IjIZOEeArheZjJPw1Qu6/KEdjFDbgbvnqPPtTZ6UE8ukXlBmLB8
	4BNO7A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas89eya-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Sat, 24 Oct 2026 00:04:11 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-147be78cd56so5373804c88.1
        for <acpica-devel@lists.linux.dev>; Fri, 23 Oct 2026 17:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792800251; x=1793405051; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=I3wuHmWmGvXCtEnDUsJhkbmfuPnqQvs8DG+95QVzPvo=;
        b=iIvmbFLnAa65hr8A1t9dnHZ6TUPlQps63Fmq+am67tQlSmM7LVhjrEsbiKnLNUY0Rl
         LJ74CuNvx7Ch0B1bw2ThZgnY8DN2ICKaFJm/uYcC9809w/wFSNIAiTKkWAwjzFwAnULM
         hc8/VAC+bGPVcHO8F2FAE/NI8XwShvP5Bffap4JQSJt78c+5px3XJjGEoaEVYBMFJSWR
         aMqsJhp8rj0mT1msk1qS4NfWM70ptZINJdlo52+PSxesGSnEcghzQUEp/1sMj6LnB/4w
         ZnklJSRmtoQ9yi5yHHYVHq7KgTgdXOO0+LsIoehtDsx8eLkeLkPUEZu4NLBdLW73Ic2k
         wI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792800251; x=1793405051;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I3wuHmWmGvXCtEnDUsJhkbmfuPnqQvs8DG+95QVzPvo=;
        b=0cMlnfveytpvQRE+q0ovGy9MD4VyTuGCM2O6WqunsH70g3OlrJmersnZlKXuTKCpj8
         XyAMr/VeuvqJejodQ81oRFnlOt+4ChTM1YpbaX6gbKjaG8uNX/rt57xETPPrDXIx2VNf
         xV1VWSkCd5F5+0dE5XNBihLyskslRg9LLi85rS+9OWDgI5Oh6NB2We/31ZlLAb8rFuAr
         mAyuC+Y2g/VOurXPWTDZYIMiWSH0e+ws7DYP0lH57d+JSh66mxS70udVEBph8nZaQQvw
         a7xEXfr0ykrwxnyoynxiQJa4/GDUulD//sC4Z+oSLlcimtkX2sXXmLbdO002f5xYcrLo
         P94g==
X-Forwarded-Encrypted: i=1; AKwUvBxZtwSDrsenAIVm2eCl/lv4yg+ns6T2rVzE5rsUhU6JdY+nd+LOn3tGA4zyr51wqo+EORy3MqceNFAh1XU=@lists.linux.dev
X-Gm-Message-State: AFq9FYI76bQc3x6CsQpUzuTgAW0sGV1PcZp0lfreI+9V3vx37ly8URFy
	aDGbmeRpFrKdzZZ2CxVLHDDIE7eBnqdD4E3qE3bzwGpRTt5tbJOQSMGjwRKXr7idZi3IRXPr/CG
	gsLa150QJPQjaKoCtriUvwexbqeVqHiWVCO27S3kCRniMz6ZYZy3Uyv6+6KkQ1MwcVXU=
X-Gm-Gg: AYBFou2RUYS9dJVDP7I+rtpSco8wqv84Tlfehb+4ZoFZoVmxTdmQLJxnmOK60D8yb/S
	yaxSvM0BYH8XB6pqwhGkcFF0aiQPQThSSSeDISJWF1HWg1tZv6yK2mRbycENRRYYxh0StNiGJQ6
	c0GRmmDERShvGOMR9SEYu/YDfCHzhNLwNf7L1SqXT16xZghOVJyp4ZGRVPo0omekbWU/Ty6yxbw
	rZzkKirGUqdrND2ZOjWbgy+ywGKhB2OLTdNAs9/Nw+AbIzKO5QVxGGlwe6eUk8qCh1Wf1L9cY7A
	bdZRd+bQ7TmK8OwwVG2ZecKDlrXzBniiZJu+A738Awd5sBRfCv4+65qng7RUHGhaIEPKOPf+nFX
	ZRM4zbM0tzCjy7asffbr/cHdTmtMvv6QbcuLyM3o2ErOZuGsXzvJX9Q==
X-Received: by 2002:a05:701b:280b:b0:192:e5a8:6bae with SMTP id a92af1059eb24-1993fe812c8mr601075c88.40.1792800250469;
        Fri, 23 Oct 2026 17:04:10 -0700 (PDT)
X-Received: by 2002:a05:701b:280b:b0:192:e5a8:6bae with SMTP id a92af1059eb24-1993fe812c8mr601041c88.40.1792800249918;
        Fri, 23 Oct 2026 17:04:09 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0d98660sm1757914c88.9.2026.10.23.17.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:04:09 -0700 (PDT)
Date: Fri, 23 Oct 2026 17:04:05 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Pierre Gondois <pierre.gondois@arm.com>, Tony Luck
 <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>, Mark Brown
 <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shuai Xue
 <xueshuai@linux.alibaba.com>,
        Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>,
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
 <ashok.raj@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/6] CPER: Add Memory Error Section 2 support
Message-ID: <20261023170405.000060b8@oss.qualcomm.com>
In-Reply-To: <20261024003917.283b890d@foz.lan>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
	<20261020101048.00000186@oss.qualcomm.com>
	<0817615d-5e96-4a3a-b39e-3e5d1b88e716@arm.com>
	<20261023142621.00007051@oss.qualcomm.com>
	<20261024003917.283b890d@foz.lan>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5NCBTYWx0ZWRfXyvgEjVDinF8X
 SteqHe4uC2GZ5tKL/o60OQnnDLLSWAy6ZS4pw6Gyw/LNjAk/hZlQvB/xWlZloU0ipLfTXBenhfN
 w43D3RHo39P+YyxGDIDj+Hw2AE9mayM=
X-Authority-Analysis: v=2.4 cv=OPqyTiaB c=1 sm=1 tr=0 ts=6adbf5fb cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=x053eCT7BGEYFa6Myv8A:9
 a=CjuIK1q_8ugA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5NCBTYWx0ZWRfX07VdcHTbrsou
 /NT7mkOTtpDJNb9wQeDrgW4KqkZNNQ6RhG1Jwg3YMHuuDPGQMcTEmMVrUjlM+2QqSnfEvJM422/
 cfZmxbLfXJHkJcqyS0dwRqLQKpFZOJF1uR+jJ64S7Vl48uYT3a6xaAbrE1kHQ+g49mWnx8DxKg5
 oEupyEFuxnBVxWdKkO1OTHVicwrq2vFoRZLY8E54r6SuvtvhRChKxDnVhbT6GvRKPzv7k+6jQ3I
 fCHuUsZJ6XGfl2v7flpeKoay46CwFqyZTU+hp09VaRB7EXBlhQSeS0+UGHTU/rMbO65MaaatOlq
 JFMxQ/6GZfx3X3Kxhp+gJ+XyU7pKPeait1dpRXNv4Ce7l4/cF6qdIjl12DWRm4ahJA8WbokX+Cn
 nPYT5BmI8H7Mxz/LFlSplxupa+GfehulrY0bH6uZGUdgE+ZCu4vPPfhylO1FQIa+sQUKo60SEHp
 CfwG4nMkWySETW5Cwag==
X-Proofpoint-GUID: tM4iomaoAtOdjZPUEGlc0m_JVxV4V9hX
X-Proofpoint-ORIG-GUID: tM4iomaoAtOdjZPUEGlc0m_JVxV4V9hX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230094

On Sat, 24 Oct 2026 00:40:33 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> On Fri, 23 Oct 2026 14:26:21 -0700
> Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:
> 
> > On Thu, 22 Oct 2026 09:07:25 +0200
> > Pierre Gondois <pierre.gondois@arm.com> wrote:
> >   
> > > On 10/20/26 19:10, Jonathan Cameron wrote:    
> > > > On Mon, 19 Oct 2026 22:38:39 +0200
> > > > Pierre Gondois <pierre.gondois@arm.com> wrote:
> > > >      
> > > >> The support is mostly duplicated from Memory Error Section handling.
> > > >> Other than differences coming from the content of  Memory Error
> > > >> Section 1 and 2, differences in the support are:
> > > >>
> > > >> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
> > > >> This structure was used to support older versions of the Memory
> > > >> Error Section (1). This is not needed for the new structure.
> > > >>
> > > >> - The compact version is also used by the tracing framework.
> > > >> To avoid relying and propagating a non-standard record format,
> > > >> through trace event (cf. extlog_mem event) the new trace event
> > > >> prints each field individually.
> > > >>
> > > >> The last patch of the serie was only build-tested due to the
> > > >> absence of relevant hardware. apei_mce_report_mem_error() and
> > > >> arch_apei_report_mem_error() implementations were also removed since
> > > >> last version.
> > > >>
> > > >> It will also require a proper handling from the rasdaemon. Applying
> > > >> this last patch without rasdaemon support will silent the reports of
> > > >> Memory Error Section 2 error, cf. ras_userspace_consumers() check.      
> > > > Hi Pierre,
> > > >
> > > > I'd slow down a bit.  We are mid merge window and convention is normally
> > > > one version a week or so anyway.  Better to gather up feedback from
> > > > a number of folk and spin only one revision to cover it all.
> > > >      
> > > Hello Jonathan,
> > > 
> > > Ok sure, as the v1 was reviewed quickly I thought there was a chance
> > > of having the serie accepted quickly aswell. I ll wait a bit more.
> > > 
> > > Thanks for the review,
> > > 
> > > Pierre
> > >     
> > 
> > A general question that came up in a related thread with one of
> > our RAS architects. How does firmware decide what to send?  As far as
> > I can tell firwmare has no way to know whether the OS understands the CPER
> > Memory Section 2. 
> > 
> > So options that come to mind.
> > 1. Firmware must send a CPER with both Memory Section and Memory Section 2.  
> 
> Please don't do this: this would require either Kernespace or userspace to
> discard one of the reports, only if the other one is there, which can be
> tricky. Could be done more easily at userspace, but only if some database 
> support is enabled, but, at least on rasdaemon, this is an optional module.

Good. That confirms my view that is horrible.

> 
> > 2. For whatever other reason a platform knows it doesn't work with old kernel
> >    so can assume support in kernel and hopefully userspace got updated too.
> > 
> > 3. We propose some additional discoverability (quickly - code first) to ACPI
> >    so that it can be a negotiated contract between OS and firmware.
> >    Until the OS confirms it understands Memory Section 2, firmware has to send
> >    the older one (or risk the record not being understood).  After that
> >    negotiation it can do what it likes - probably send the Memory Section 2 form.
> > 
> > Option 1 and 2 are ugly at best.
> > 
> > Obvious path to me for option 3 is an _OSC like the one for generic initiators
> > that we discovered a need for whilst implementing that years ago.
> > 
> > Anyhow have a better idea?  The above doesn't solve the end to end problem as
> > maybe userspace still has no idea what this new tracepoint is, but at least gets
> > us past hop 1 (so through the kernel). 
> > 
> > If we conclude _OSC plan works I'll draft a code first proposal.
> > 
> > Jonathan  

On another note, Pierre, any plans to actually enable a path to the tracepoints
on arm64?  Today they only emerge from acpi_extlog which is x86 only.

We definitely want the richer data for PFA and obviously for userspace nice
to share tracepoints with extlog.  

Jonathan


> 
> Regards,
> Mauro

