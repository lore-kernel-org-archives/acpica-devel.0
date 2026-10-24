Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792879545;
	b=n+kTqvd0uMDg3NeVZDHvZVeHove7xmFo6NxH/2K8QOyQ6vcrmk9wC8fN25aYAOaWbYVv
	 CcBy20FRfndREmxuBmW2VBZ2iMkhsYqJgiEosGytwQDWBKvV7NQI23oD6GjqOq5F+7ALX
	 GLITFvzfsNJp/gX+2WLnpueWpwmaD0PzuSPMN9iaqBmemnbdeGYrQt2zzkC/LqYrYczYd
	 xKKFHT+4MtFU+YXR/oThIQdYBoWRJsFjawiUP03yf+258pxW0ZGNCnVNLQ4n1JInSTIJc
	 RmLJvM0OjhDuFFEvn79YT6QBkJygwfSUcI8yMAHpN4qUWzn3QSZw3Ky/ytkLAvcM5zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792879545;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8kVrNNwECi/pBgLtq3kn4zJJZjFdKtfvJtknlnpxdJ8=;
	b=QYDVq+WM3mJduJT/Q2BGuG7ZxPQzrKdeR1ywGYXdeChFlOMM8bvSSnLGX3Ixu6Kc+5OP
	 GAgj0dVBM6oh3yxSWj6WQvt8/JSn9lBJKd0xtA1Xvrfb467ybabTfZWPfCWnuTiZIh6YL
	 NTSaifsyOcvWzao2AFLXrZRWgIgwUSfl6/RV75D/zydZyD/3RfRitXM8vp9/TEys4rq/K
	 XXf+USv+nPeJW7LqyHTl05JqyO91GRSFTYAecY99xjmhcOJOpKmTNYrntWi6Y94TSzDWI
	 4E0hIU0uXTubTK6ZtobDQHXmy/Sh55W8I/tVhGFMjYNmF56f3FED8VzirikkICP74KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EkULdcR1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RtC2BQE5;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34E606A31A
	for <acpica-devel@lists.linux.dev>; Sat, 24 Oct 2026 22:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD34E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EkULdcR1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RtC2BQE5
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69OLbNAq1795118
	for <acpica-devel@lists.linux.dev>; Sat, 24 Oct 2026 22:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8kVrNNwECi/pBgLtq3kn4zJJ
	ZjFdKtfvJtknlnpxdJ8=; b=EkULdcR1W7J1DWJ7fuajGh1OltMM/HIW7ISBoMnG
	1SZYxKXb0cBdx4bcHvLUUzPzuMg0RLERHpFi2duhPcczNf9MDmP4CRy4xnsg6z7e
	NfYWkQXvLU2YEXN6NcxVFy2Ib9AkhzzYFY1h5RrDYHRNz7R4xkN81FOwINetckcW
	sbarvaT7AhrCCiRM5C7isD56tlZAlokwAsavEI1exfCGU/ekMZT/hT1LtIrazsQD
	kfoUno1TRqN8HfViLUmKxWxEKNs2uz0pak0H68U3NNvJZy6S+GJQjJ2NByZqRDR0
	neUM82luDMwYuHra/XXMOkXd3k6BE4GSrWFczlz+z4kBhQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgny9sqyt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Sat, 24 Oct 2026 22:05:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3510d0baf63so5268653eec.1
        for <acpica-devel@lists.linux.dev>; Sat, 24 Oct 2026 15:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792879543; x=1793484343; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8kVrNNwECi/pBgLtq3kn4zJJZjFdKtfvJtknlnpxdJ8=;
        b=RtC2BQE51hL4GOxS8Fu7JD/xVa+IIfJ0HlnBEJ7Fs0hz5LC22489Ow8y6oeOEwoxtZ
         fHQiasHbTOBQLtHn3H4j2NpHqioqvZOv+0g7WC+1kFupF6k/Q7A8I5WQNZP+BOtLPg1d
         XsJahcHaG/RDADm2hKwuaRAQAm8GuJX2q2QrhQJ0nPCmIUDV/vgWh9UWL2iRf9S0pxU+
         KKWSo2WCboTSgTKfREuip9KsQKANQWR/hjldEIIYzMV3vwfLm62d/izdgIqDr8R/vATZ
         f6uU9buA+fSfZJtUx1iB+PaQo98IKZZ0+fGDah56vAvl+GJQ8YaPV2V6j1VK/QKozY8n
         jspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792879543; x=1793484343;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8kVrNNwECi/pBgLtq3kn4zJJZjFdKtfvJtknlnpxdJ8=;
        b=E3nROESztmmuW+tN9mkzxY7wACxFzTYfyrYi74WX+CTajCIrwlVpPBy3eEpHXAJVjk
         2pfnQZMqCnuTAFVNDfmrwIWnxUx/otIPf0jHud6/kU8TtsYkZ2kF1QyDGRxRL4nmPklO
         AF9UAPBSAhqfrSXsnPP5g3+25OwzYcLGOfAVgh6JfSQVFcKet+GwmwunxbpogRcQTW16
         eHTh1WWC7KSHOiYYxMJiAoPw8DUJSHUbfMdCKxeFq2Nlj+bjIqbYUKmCjBp9TT5xQ5ev
         UEciaaFZv1rzIHseoNzNdtQloxBHD+JE8dMmLLwWa1/Gct/fnhS+msOUOYDMxwrovFDb
         qLqA==
X-Forwarded-Encrypted: i=1; AKwUvBysadMKlIxb2uRkvEuy54pWsQvqsBC0ev2AOqygGLdn0QIM3iOn/P/NrRkycK7MfMbaDSqB3UzaUk43H8g=@lists.linux.dev
X-Gm-Message-State: AFq9FYILVpn7Bnl2NhBV4WqpuYdoHLdE5q8D4x1zkkPW9rC/eIIDhBn+
	04ruI0+7fwYoHNTAkjf/rwZerH9n+ZXwYH282OGu1nBKnZZBhMeTLchD63LVoWPB9nFA8+szCRR
	p5fBbRSor05KuIvT3ZGfaqyL60epdg7EoqrMP+FgmEAN0YbIp4toj6aeJQT82Z7FL31g=
X-Gm-Gg: AYBFou35y/Kip2V6a7yxmacTnxN/dLDt9/DWtZvyywpIcXC/+K9nKK12NaEYkbaGsLh
	Wdllq/ruShYHXECO1ZHlKQ5TFX2pJviOfdSdxGt/4q9fJrII/tU7ObqdQ5Z9G5dmiyeWlgX+uER
	+JT6sN8fRUO4Yh3E72g/Ve/T6QwHe8cKIi5LDTRpWMA1kco4hFR4K92KdtASyGLgPtGmBecpRjQ
	XzbNTqD/D56eghKm/nGvbAemrD3AQ9bmuYzor95WzNwbF7v0Kfgvxi5XmagPGSxHMpZgp/njmBI
	wvpQkV/Nt2ohEsrwE+iZ354h2AydCZFzB1zh+jP7NZY3FfOq3ONmVU0XhyAf1XK7pjEHf4pZLoc
	4jX+LzZv5NGXptd1tj6WZUvtAXh+ds1eJGCA6uAMaA8jyCbDQ
X-Received: by 2002:a05:7022:4585:b0:147:a685:912d with SMTP id a92af1059eb24-1993580ef4cmr5550171c88.29.1792879543054;
        Sat, 24 Oct 2026 15:05:43 -0700 (PDT)
X-Received: by 2002:a05:7022:4585:b0:147:a685:912d with SMTP id a92af1059eb24-1993580ef4cmr5550122c88.29.1792879542501;
        Sat, 24 Oct 2026 15:05:42 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a277b26csm11055500c88.18.2026.10.24.15.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 15:05:41 -0700 (PDT)
Date: Sat, 24 Oct 2026 15:05:39 -0700
From: Ashok Raj <ashok.raj@oss.qualcomm.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
        Breno Leitao <leitao@debian.org>, Dan Williams <djbw@kernel.org>,
        Terry Bowman <terry.bowman@amd.com>, Ard Biesheuvel <ardb@kernel.org>,
        Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev,
        Ashok Raj <ashok.raj@oss.qualcomm.com>,
        Ashok Raj <ashoraj@qti.qualcomm.com>
Subject: Re: [PATCH v2 0/6] CPER: Add Memory Error Section 2 support
Message-ID: <at0rs4parlHFGI7k@hu-ashoraj-lv.qualcomm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
 <20261020101048.00000186@oss.qualcomm.com>
 <0817615d-5e96-4a3a-b39e-3e5d1b88e716@arm.com>
 <20261023142621.00007051@oss.qualcomm.com>
 <20261024003917.283b890d@foz.lan>
 <20261023170405.000060b8@oss.qualcomm.com>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261023170405.000060b8@oss.qualcomm.com>
X-Proofpoint-GUID: 8zpyJgSsBj59V-60w9FQUfnUFxnvHYsa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA4OCBTYWx0ZWRfX27NO3Wb/rkpw
 C7SPU3TyQgkCe08LD1h2+7nPdqMXRa1ednjV0lmCVW34KYfIpww1m/PnUWKlAxtE937XIuTcgiY
 yV7eW5nMd/RRJLPRhFcgpeusNPlW1ntRv/IU+M17dStVArwwWBDcJJ69pX42qfzkuZkJfPaViKJ
 4Va6GtNVmBYlyJhhcZqT9x29gHUkluueEsq8q+YqvYZuleQds2Ry8MK10vL/Et4b/OK/3J3A5XM
 1SxtuhrPlCCkn6ZoeEmr10+Eh8G0nhJuLNbBidvSSon6LX/FkqQ3lT343CjreGpRexDTUg/TyBx
 k/hG3FMey9PSTw1wIpd26TeZYIF0Is9Vzt/43hzyz3CVuo5nY62PAkft0WlncR7gfOL9bOLVQBg
 33p6htUSX5EF5U+fj8aug16AEqKZt0z4lD+iuwk5hk961OpoPNDQfRpIw2Lw5nRXpKsxNd7IAmY
 bE21DVgF6WUE0buv0cQ==
X-Authority-Analysis: v=2.4 cv=PqcG/AM3 c=1 sm=1 tr=0 ts=6add2bb7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=6KC3CYklt-igK55gTzAA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 8zpyJgSsBj59V-60w9FQUfnUFxnvHYsa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA4OCBTYWx0ZWRfX0VNXu/AQ1MwJ
 YNM1W1ZfoM/bV4kvRnKT89PUUINJWmdQlXx2avUFBPNv26VYjqLyrqEY4+crN5lPzfDkgVyoZvG
 hXyUo4cbPC2vVa6YDzkHZXM5xS+S+v0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240088

On Fri, Oct 23, 2026 at 05:04:05PM -0700, Jonathan Cameron wrote:
> On Sat, 24 Oct 2026 00:40:33 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > On Fri, 23 Oct 2026 14:26:21 -0700
> > Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:
> > 
> > > On Thu, 22 Oct 2026 09:07:25 +0200
> > > Pierre Gondois <pierre.gondois@arm.com> wrote:
> > >   
> > > > On 10/20/26 19:10, Jonathan Cameron wrote:    
> > > > > On Mon, 19 Oct 2026 22:38:39 +0200
> > > > > Pierre Gondois <pierre.gondois@arm.com> wrote:
> > > > >      
> > > > >> The support is mostly duplicated from Memory Error Section handling.
> > > > >> Other than differences coming from the content of  Memory Error
> > > > >> Section 1 and 2, differences in the support are:
> > > > >>
> > > > >> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
> > > > >> This structure was used to support older versions of the Memory
> > > > >> Error Section (1). This is not needed for the new structure.
> > > > >>
> > > > >> - The compact version is also used by the tracing framework.
> > > > >> To avoid relying and propagating a non-standard record format,
> > > > >> through trace event (cf. extlog_mem event) the new trace event
> > > > >> prints each field individually.
> > > > >>
> > > > >> The last patch of the serie was only build-tested due to the
> > > > >> absence of relevant hardware. apei_mce_report_mem_error() and
> > > > >> arch_apei_report_mem_error() implementations were also removed since
> > > > >> last version.
> > > > >>
> > > > >> It will also require a proper handling from the rasdaemon. Applying
> > > > >> this last patch without rasdaemon support will silent the reports of
> > > > >> Memory Error Section 2 error, cf. ras_userspace_consumers() check.      
> > > > > Hi Pierre,
> > > > >
> > > > > I'd slow down a bit.  We are mid merge window and convention is normally
> > > > > one version a week or so anyway.  Better to gather up feedback from
> > > > > a number of folk and spin only one revision to cover it all.
> > > > >      
> > > > Hello Jonathan,
> > > > 
> > > > Ok sure, as the v1 was reviewed quickly I thought there was a chance
> > > > of having the serie accepted quickly aswell. I ll wait a bit more.
> > > > 
> > > > Thanks for the review,
> > > > 
> > > > Pierre
> > > >     
> > > 
> > > A general question that came up in a related thread with one of
> > > our RAS architects. How does firmware decide what to send?  As far as
> > > I can tell firwmare has no way to know whether the OS understands the CPER
> > > Memory Section 2. 
> > > 
> > > So options that come to mind.
> > > 1. Firmware must send a CPER with both Memory Section and Memory Section 2.  
> > 
> > Please don't do this: this would require either Kernespace or userspace to
> > discard one of the reports, only if the other one is there, which can be
> > tricky. Could be done more easily at userspace, but only if some database 
> > support is enabled, but, at least on rasdaemon, this is an optional module.
> 
> Good. That confirms my view that is horrible.

Hi Jonathan,

I agree that an _OSC capability is the right long-term solution.

Firmware should select one native CPER format based on OS support, rather
than emit both Section 1 and Section 2 and leave deduplication to the OS
or userspace.

For a Section 2-capable kernel, we may still avoid a second GHES notifier
chain: preserve the existing struct cper_sec_mem_err * contract and give
it a lossy Section 1 projection of a Section 2 record. The conversion must
translate validation bits and clear validity for values that cannot be
represented, rather than truncate them.

That preserves legacy EDAC consumers, but cannot carry all Section 2 data.
Updated userspace needs the native Section 2 payload through a
full-fidelity path, such as the existing GUID-tagged raw CPER event.

This does mean an updated userspace listener may receive both the legacy
EDAC summary and the raw Section 2 record for the same firmware error.
They are two kernel views, not two firmware reports. We should therefore
add a shared GHES record/section ID to both events, so userspace can
correlate them reliably; address and timestamp are not sufficient.

So _OSC solves firmware selection for old versus new kernels, while a
Section 1 projection plus the raw payload handles legacy versus updated
consumers on a new kernel.

Thoughts? 

Thanks,
Ashok
> 
> > 
> > > 2. For whatever other reason a platform knows it doesn't work with old kernel
> > >    so can assume support in kernel and hopefully userspace got updated too.
> > > 
> > > 3. We propose some additional discoverability (quickly - code first) to ACPI
> > >    so that it can be a negotiated contract between OS and firmware.
> > >    Until the OS confirms it understands Memory Section 2, firmware has to send
> > >    the older one (or risk the record not being understood).  After that
> > >    negotiation it can do what it likes - probably send the Memory Section 2 form.
> > > 
> > > Option 1 and 2 are ugly at best.
> > > 
> > > Obvious path to me for option 3 is an _OSC like the one for generic initiators
> > > that we discovered a need for whilst implementing that years ago.
> > > 
> > > Anyhow have a better idea?  The above doesn't solve the end to end problem as
> > > maybe userspace still has no idea what this new tracepoint is, but at least gets
> > > us past hop 1 (so through the kernel). 
> > > 
> > > If we conclude _OSC plan works I'll draft a code first proposal.
> > > 
> > > Jonathan  
> 
> On another note, Pierre, any plans to actually enable a path to the tracepoints
> on arm64?  Today they only emerge from acpi_extlog which is x86 only.
> 
> We definitely want the richer data for PFA and obviously for userspace nice
> to share tracepoints with extlog.  
> 
> Jonathan
> 
> 
> > 
> > Regards,
> > Mauro
> 

-- 
/ashok.raj
ashok.raj@oss.qualcomm.com
Qualcomm Inc
