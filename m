Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790791;
	b=1HsKTgJo7B3vP+UN/HX6fgilzPrHnGfJdZFRH4U00OLOLVX9uAEPCLqGNv1LhcdJnyBf
	 AELpOQHndxzTegQdGU3dgyC7WQK5YsGqyVMplj7kUzSUymn4378g+sxNlPB8MP2+slHfp
	 1/DUqd5LLZW0F/LjZESq8KC3xmNJNtlMEZ09CGK29H/nn7sR/gbTIUpMWbcevV2kKmiP2
	 4J87aPpGJTLTKlrZAXWdfV3bvr6QpgZiwpCkcCwgZYVUoBwEEujOgk6rTh9jzwLJw01EH
	 1uAFyDbaHNPxJZdumsj/Tp+6NydSi/09jvI2/U9mDQvn6Ep+z+wRIBET2aoumJHz8sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790791;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=onjC+0/JB/EMzeywRoMR9YdIXgcyM2qGbjpbSI4T3h0=;
	b=ZzNvMhwNFqiB5pXLPsJBhQNL8/0EouXnfJalbPSAOTE4FMhPNaks+s/Ltv+5disr1DI7
	 psw6rhduIdlss6BsXftvojU626rll81PtPs8Vy9lQdclAxu9AI2afLt0//Bjhg8buV6G9
	 u3RVcWgThc94MYvuKuM2wGvBbFqAQPDzp45sbwsCBuu8dua5idYctZN4xYlINBxBkCNI5
	 gAL7PY6n+u/GO1QUeTI+yFUCRD/UvF3id4osB6043A29+dYTIRinIwlA7kyM7HLzWc6it
	 Yb6SpgpLl5EusyBUypdgWvTIiGeLtb2vTCaa+Sn9nSC5lEKIqihFyN66A5ayqZDP0Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HRnNMC+Q;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jU+efiz2;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC91606A320
	for <acpica-devel@lists.linux.dev>; Fri, 23 Oct 2026 21:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CC91606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HRnNMC+Q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jU+efiz2
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NIZqBk2540620
	for <acpica-devel@lists.linux.dev>; Fri, 23 Oct 2026 21:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	onjC+0/JB/EMzeywRoMR9YdIXgcyM2qGbjpbSI4T3h0=; b=HRnNMC+Q6WSd7YsH
	RZcrFxdaoCMuhrteHUqGKX3AkmhklMoyZ/cnmcyrc35ASxrxIEE8JA9999/TAR0a
	28AEarTbNWLmVQxHLdal8A9BJPiuN//4x1dBC5o998g2pi+jbfzFmyD+Fz/hQBNS
	Do0nkv/8rq81UF5qKDK3gPhxUSkrsH6EUnwVD0JqfCOfzXPdAoihGPBRqaUSEOK/
	IvgSn/8FuzbbiYsRcUSi2gxL1OnN+XNzK0eJSYq/9IDb+aFXYiovcASXrnuuL+ZA
	JGVbXs4Cy9nQAtXMD1feWK69CqjLqBy4MSK99b9xb3smeWxCpbTE/rXMLr/XWEhB
	K/2oJQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgatc92ss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Fri, 23 Oct 2026 21:26:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3552883bd19so4188191eec.1
        for <acpica-devel@lists.linux.dev>; Fri, 23 Oct 2026 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792790788; x=1793395588; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=onjC+0/JB/EMzeywRoMR9YdIXgcyM2qGbjpbSI4T3h0=;
        b=jU+efiz2XU54kRRo46LZO8sj0SLt6gvwMgnmGSXMuhrdPK7hke/c575u3NpeT3fjCg
         h/LI2ZxKTxG2A+QWxvwtUOxAEZ9QcXsrX4fDNioWT8Ur7lBu0CovBAOYPErwgMeoWvJz
         um+OOeOmhwPpjsIgs63vNabfXvpdiJPWrJsez/m56KCDqb76jpQWQNsLcewp9tEUZ711
         nfWtDRtmq2stPQFs9Ose8Azb2eC0SH1guE/gJeyb//wgiEZZ1wyrP3Rlb5t2IljDyZ4Q
         MV142FgzL9s5IO7beqPoj5H8udnA6gm9ozCK8YYctx4MeeoAf+NtyKzk2O3XM7b2qJGW
         qCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790788; x=1793395588;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=onjC+0/JB/EMzeywRoMR9YdIXgcyM2qGbjpbSI4T3h0=;
        b=PvNhH2PFSq+5bljTWpASLDrNy+8jhx/ycM8en74gXaFpeXWopbC0wEUCUpMOyaaJO6
         COxgcssxT/Hfrab3nCveN4mSNfg/QA1TnArFA4J5JIBI2fYwMyTXpysRgRzk4+60ypRA
         zkjIokuVIV0GKa6oDmZvHOjyvKSyFLLzpQlupWybU9PvHqsRD1GfR1dzVvMjZhzXTZu6
         qWkHUflKcUukU4uIGvyRJzBjxOf/b7z6FZt+JFo6+8+/e9TJf6Ba7IszV7IfemdUQzcx
         gancgs2zWnZdA4XvaLc6psPY1NCswx6EGrdxYw9vUgmjGm8+ysZBDPcmXcv14MNBA/c7
         12jg==
X-Forwarded-Encrypted: i=1; AKwUvBy90+2TqYTi89OBu6c8cdUIxS8oPWwjQDNcMGf2u8/GNpQf/v/OZopQRtqk7ASv6BMdrG5Jmt2fUDxvTss=@lists.linux.dev
X-Gm-Message-State: AFq9FYLgCxj6g0Lni1ssEaldzzUPK0HBWumS83EnOV+MrEiWQeeEqGt6
	HZcktUvGZZMhhKcr0ZczOmkhoaMZOBNcC/ULyifCi/oopBKLnGz9KhpPo6EHvwkAt/mHtq8MEHF
	SAF9lvd1vc5yJ6dOIK94NWlqe4vxWVI9DiUGdDHWE0dpxN/xnt4VwFeYMTzSR9Tm9des=
X-Gm-Gg: AYBFou2UmAcbPaZiVFymXHzvFF8uHeqy9VwqFE/5LQIkR2tspVc1KNPa4Z9JypU+qd4
	nPKWWxT07vonQZTiDiqEvaYauLJ3XJFdQ+0A+UgjobsO/QiO7K8q+zDjiS6ZusmVKnzu+G4ef4v
	8uEtAZw+dJ2sCVkSN1VH1UOxonSCVSKWfg/QmK4jzm3H6MbkvE9WneYOOtSNgYEbOoOxTdXTZwf
	aPFwjY7au9OtQblGvzf9uArGLVnmhiGgrhIrtzj38j3kPyXl63VBbRaTSjHkzEbH1VmD+icjvuJ
	8RSD1uYvBXeDV5c8afI/W2CfKEe7NtMmxL0ypjg8dHwKrir6Y+gVQa9jnUG8jCu7PZMb9JVEZNm
	a4LnSMhfj1wZw0EoEL/2Zaqhdn73Hf/fO35SbeEMc8c/Ssd/+Mbvgog==
X-Received: by 2002:a05:7301:2f31:b0:369:d8e1:7bad with SMTP id 5a478bee46e88-369e84d7714mr627750eec.34.1792790787899;
        Fri, 23 Oct 2026 14:26:27 -0700 (PDT)
X-Received: by 2002:a05:7301:2f31:b0:369:d8e1:7bad with SMTP id 5a478bee46e88-369e84d7714mr627705eec.34.1792790786964;
        Fri, 23 Oct 2026 14:26:26 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8afd64fsm1007158eec.0.2026.10.23.14.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:26:26 -0700 (PDT)
Date: Fri, 23 Oct 2026 14:26:21 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Pierre Gondois <pierre.gondois@arm.com>, Tony Luck
 <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mark
 Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shuai
 Xue <xueshuai@linux.alibaba.com>,
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
Message-ID: <20261023142621.00007051@oss.qualcomm.com>
In-Reply-To: <0817615d-5e96-4a3a-b39e-3e5d1b88e716@arm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
	<20261020101048.00000186@oss.qualcomm.com>
	<0817615d-5e96-4a3a-b39e-3e5d1b88e716@arm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4NCBTYWx0ZWRfX3qmpvOvHZ1na
 mrdFwHgmK+vRKrhF8mf1POJPKeSvJF7lFW2YzJKuSXkYrCjRbfE3BVehl4+PyCM3QKWTDRaGILJ
 SkfA2e9YIdfbFqWSU2YdZg9FaJC+jnc/eyt9xvpb/D8y0/lh0gqURJ1QJUfPfocUjMvDgptTuAd
 GR8BSwqdOJ9a+3kmyllWsmOL3pyBfXvCrX4hnvioHIkFafjvsiWhvpGVixL7eRi51wruuqFEI84
 SXuY2kyZqRlMaTCGDbndesZM0RAh4ZLz5mtMowGw4brLjAQykuK5h/r9OY7C3H3mj7IPupGmTKG
 qN4o3KqpfOcSBTh+Z9HiDcEiJtY9Ic/WDr7XQCaQsy+iaurcDVraCEEEGtwiAogmFRK2nfQHPOe
 CM2zhe8j+vjymdFJSyo0GHiXw+OWp+9+NBPBAzoRTlQPgOaU7WbS/K5EZ9BxziHI7DZTKz8XjbO
 ikFJYvzVfq26pJ9A4Og==
X-Proofpoint-GUID: hE31Poj2_uaBapWO9M5cpzCGyyxXJ4uy
X-Authority-Analysis: v=2.4 cv=Scxi5fRu c=1 sm=1 tr=0 ts=6adbd105 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=7CQSdrXTAAAA:8 a=viUReOrFISyjNDj8nWYA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: hE31Poj2_uaBapWO9M5cpzCGyyxXJ4uy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4NCBTYWx0ZWRfXz1uJVZ9aNpNR
 9AvMnQ6GD/uBD6hahkcUZhOb+hVtRiM/LbSgqZVPIxhsdTYoPc1t12F4M5B57ZtHw8qipaPfOmA
 oI0EA5V7JVBnQCo6kEIz5m1Yi8qosBg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230084

On Thu, 22 Oct 2026 09:07:25 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> On 10/20/26 19:10, Jonathan Cameron wrote:
> > On Mon, 19 Oct 2026 22:38:39 +0200
> > Pierre Gondois <pierre.gondois@arm.com> wrote:
> >  
> >> The support is mostly duplicated from Memory Error Section handling.
> >> Other than differences coming from the content of  Memory Error
> >> Section 1 and 2, differences in the support are:
> >>
> >> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
> >> This structure was used to support older versions of the Memory
> >> Error Section (1). This is not needed for the new structure.
> >>
> >> - The compact version is also used by the tracing framework.
> >> To avoid relying and propagating a non-standard record format,
> >> through trace event (cf. extlog_mem event) the new trace event
> >> prints each field individually.
> >>
> >> The last patch of the serie was only build-tested due to the
> >> absence of relevant hardware. apei_mce_report_mem_error() and
> >> arch_apei_report_mem_error() implementations were also removed since
> >> last version.
> >>
> >> It will also require a proper handling from the rasdaemon. Applying
> >> this last patch without rasdaemon support will silent the reports of
> >> Memory Error Section 2 error, cf. ras_userspace_consumers() check.  
> > Hi Pierre,
> >
> > I'd slow down a bit.  We are mid merge window and convention is normally
> > one version a week or so anyway.  Better to gather up feedback from
> > a number of folk and spin only one revision to cover it all.
> >  
> Hello Jonathan,
> 
> Ok sure, as the v1 was reviewed quickly I thought there was a chance
> of having the serie accepted quickly aswell. I ll wait a bit more.
> 
> Thanks for the review,
> 
> Pierre
> 

A general question that came up in a related thread with one of
our RAS architects. How does firmware decide what to send?  As far as
I can tell firwmare has no way to know whether the OS understands the CPER
Memory Section 2. 

So options that come to mind.
1. Firmware must send a CPER with both Memory Section and Memory Section 2.

2. For whatever other reason a platform knows it doesn't work with old kernel
   so can assume support in kernel and hopefully userspace got updated too.

3. We propose some additional discoverability (quickly - code first) to ACPI
   so that it can be a negotiated contract between OS and firmware.
   Until the OS confirms it understands Memory Section 2, firmware has to send
   the older one (or risk the record not being understood).  After that
   negotiation it can do what it likes - probably send the Memory Section 2 form.

Option 1 and 2 are ugly at best.

Obvious path to me for option 3 is an _OSC like the one for generic initiators
that we discovered a need for whilst implementing that years ago.

Anyhow have a better idea?  The above doesn't solve the end to end problem as
maybe userspace still has no idea what this new tracepoint is, but at least gets
us past hop 1 (so through the kernel). 

If we conclude _OSC plan works I'll draft a code first proposal.

Jonathan
