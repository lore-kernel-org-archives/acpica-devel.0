Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516185;
	b=docXWaTQHb1uYOld8r+yHHlETFSyDkMUlatF20lNfbKjsNab7e4Qn4gxJPhf3Qs/zscB
	 /oBptG1OedlsCBHiZ+MBPdSj1DzvRELUgSYqlDwAo7fR/vQNzK4p/b7p/j7Rn3NTuBUXf
	 oSii8u0uYkapQHwsnU5T1Yicckyuz/Sakxx973idXHLm17dzP+J4Hr0kmiI8S5OSbHEwO
	 eUDMTS/M5aASdOYJvlIw9QUEy5AwLOeXEsmreNR9Fmfh+BbV78RxNbD8Fn0CwWsNouGro
	 DI/PLEyD6vUezs4y9RnqpGgaatmQObAbuzpYBMoyiiD0FhroEEoDI9Tmcr0Qg3/72/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516185;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ohKpVZsSLKBqP3rLFRPbU8Ml4RClO3TAOr5rDUCda/w=;
	b=mBgbyQThMP7+/K91r0wKXLVr2FCCz2enh9yPZEs7Sw2bXPQZFr2DFVA+ZYOPGxfdZ4Bf
	 tr0jPBgvGg7gjAg58qJJzstEKvRdjzXsO86oc2f0fIO7xQzdJ95lhJeLcxL/3/cB7uSRB
	 L5DNVlIDGOz0fiFDG02yVtZ7v3UJh87Y7MxV/4uKAnare4Fir0uim+Bi1v9gxKKs5pimy
	 BRsqLmqDYBS4PX8a2XOLfuysX2LI56yi0xXzwOn7A8Is4iG3zRS4HSqa172WeEa/kQY+Q
	 nWk2b6CxaxCdt0kK0yumqpLt7WbbqIeiphrFYIjlnLKLkzCm1MeKQ1gqZgKHXF/TdUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Q/srjOz3";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="D14hJe/H";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA51606A337
	for <acpica-devel@lists.linux.dev>; Tue, 20 Oct 2026 17:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCA51606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q/srjOz3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D14hJe/H
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KGtvrb2712200
	for <acpica-devel@lists.linux.dev>; Tue, 20 Oct 2026 17:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ohKpVZsSLKBqP3rLFRPbU8Ml4RClO3TAOr5rDUCda/w=; b=Q/srjOz30TRKb0h+
	4i5NmNJzhXLuqckNdw/mg0I4BdzGglVTPPTqazzLFsx/Egq97m2DlLg9ue++z7ip
	6WVn7ZjlY/g7VfeucNdjyKyQZBNhpJucWzQD5lIZza3YJBHioVSU/aQsJG5snWE+
	Im9EeDhgIeH6Tr6y7/Qg5R1Kx+t3F746jDmWcVzfNxurlDL8JrmGFSL4mbP/TR6Z
	aQTdpZjm32+Rfs1bQ91lVPuoYRNQ+jDPXKIX7UfBMgGyReFum7adrZOaF813VB8E
	Zsna3eTyugakMRuQrPgQRVqqJkEknK00/GysSDNSK6Mzns/CW3C2UlGAMBjbAmPT
	68aWnQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nuh8v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Tue, 20 Oct 2026 17:09:43 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c0d568830so7539271eec.1
        for <acpica-devel@lists.linux.dev>; Tue, 20 Oct 2026 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792516182; x=1793120982; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ohKpVZsSLKBqP3rLFRPbU8Ml4RClO3TAOr5rDUCda/w=;
        b=D14hJe/HnzpH28JPRTMgxA1ZkolRh4SPPLDfcrpetiBQfEWmhglT47z9heRnLtP0qV
         lcrcnNDQoK0lxzjxDzxrGlLLsm0xJLqYQwm8z6MAq+AdlzNS0bdrPywhd1sVo+0HVuzx
         eOPlZk1ZTMBUUP5J04GojdESRAQG3LKbO2P3OzdDJdp3mqZrb6YP/XFE0MjlI3Jr08XM
         MqmCzEuxQLt2N9whzq+XKvm6flHE9YASb8PrX6PmZi8sBM7AdGJkbcRlghJN9uZKFJAs
         UUz+u9yoeO+XCFhr93FbsiHgXYDZC5wppQpLigzzeM5WWV3EcXC+rDgR7brzjUZMm712
         6IMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792516182; x=1793120982;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ohKpVZsSLKBqP3rLFRPbU8Ml4RClO3TAOr5rDUCda/w=;
        b=P3oyPQWwS8220Hclu27/6kaenZCilwHeUR+cNBvRWUgyD8rFfLBl+uhPtmhr7OJHBv
         r0BswfztaKIPME40qp9vC8861boIGleAsMGosEzkPRlBOCjwVyId9w4KYsUwo8RQFNN5
         f3+GR2JuxNcx6OgqNza5AL+B+hvDyPbIT2+aWf8wFQ/B9eaKV6ui5pkXhjcJByh+tqJi
         RBfcZWI85UqqVEYt2jPCWFpiA45Q0MaQbxpQphvAxCgG+1bjvHmWdTH9vwjYkjBUFwgW
         +VQno5jGk7ALpDVeIEirpRfpDK6t2NxV1pgx5zBzN1lkRhpKwPH5qkcY8EfFxL1F6a91
         UQtw==
X-Forwarded-Encrypted: i=1; AKwUvBy1CtkwGJkLZbDMNDXX2chDqB7czf+vZGRCLy1IF8dQGZvskbB7IWl+eFkAqZ+efrSafSzIqwLxwdeWCuk=@lists.linux.dev
X-Gm-Message-State: AFq9FYIkXRYS1lIfM7olq7D3Iu9Gq0ulaL0xwnGl4gK0lFr0Stogtpgo
	zG4dI2o6z0xZpVqaRABUq4x2hHc9EidzH7LXiOjB9kvXaxvU2h/9MmaS3G0RkxfCtPLX5bqnAw6
	rJqIxGNrJ7NEwqlMbIUXDtP7MelzvuuDL4arNL9pU+Sm5qMnM2DvRSiP9UIyti8jBv4U=
X-Gm-Gg: AYBFou0zIiSOcOMUTfrVXg/FjB2DdFUUltoehgIDgRK+OHeLPiKEyxGIj0SCs4Ycg7G
	hqdVFDbPXtkC2ZkcJ52UYmyEKml/zAEUACs10FVy0IjyTpkABbkwhBI1orCWPHR1c/rzGsbpikU
	F7L7ZsBJ+VIfhG9SFupzxU5Kx8V40hJeT4Jeuhfr5Q+i/LqAb4bKm5+IJVgceOtFOm25HTQMVQK
	qaDeXdMzW8ZdukbpVSXHc2ccGsB9ksBo0iM4zak/rvI17K0qtFx2GaBbIIA9OJHgDUXpN3LqYbl
	1YAhipOPZzkNSUCwJR6DKJZj/ogkYfOTQ6mwgXj64m5cCvMQDjvI6iSuphzT4CThXJPXNb17Bgf
	vx7SegoBUauvs7U5fsoIRpuJcXK6Lsn3xj2LmX8LcHAI=
X-Received: by 2002:a05:7300:10d:b0:351:1e89:66ab with SMTP id 5a478bee46e88-361a0e85fc5mr16354998eec.7.1792516182382;
        Tue, 20 Oct 2026 10:09:42 -0700 (PDT)
X-Received: by 2002:a05:7300:10d:b0:351:1e89:66ab with SMTP id 5a478bee46e88-361a0e85fc5mr16354944eec.7.1792516181614;
        Tue, 20 Oct 2026 10:09:41 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673b1d0ab7sm123492eec.0.2026.10.20.10.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:09:41 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:09:37 -0700
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
 <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
        Dan Williams
 <djbw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Morduan Zang
 <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 4/6] EDAC/ghes: Extract error report initialization
Message-ID: <20261020100937.00000d06@oss.qualcomm.com>
In-Reply-To: <20261019203915.2019037-5-pierre.gondois@arm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
	<20261019203915.2019037-5-pierre.gondois@arm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2OCBTYWx0ZWRfX57yhVezmnSZW
 lddH55i3/dM6OmVdRQ0fkko2pHBgVN+/9mGFdrrk0r8sR1iuqVcLIrnFEiq6Peb+EBSgAb7HXft
 E/EbZRfGCDWR/x68CXKS18wN9EVIRKw=
X-Proofpoint-GUID: uO2yxX1MzrRJlGY1D3mrvrN-qbdMWZse
X-Proofpoint-ORIG-GUID: uO2yxX1MzrRJlGY1D3mrvrN-qbdMWZse
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2OCBTYWx0ZWRfX7o4F29bRFT9e
 KoRh19DIlPB31KgvQlTM0rw5YW6AxSOVNkSgEDTk3/icjS/rWYNY11imbnIgtKMmMuAvKe2O/8k
 5bqdTSYdseUc4DXpEpY8KJrI8BtLeI7KM38Jvm2Dssiemg60xGL7VD1MM6SILQYTqeHFk0BqtEV
 H7O6jB27d1Ut5Z2vEwAyhifR4Z9gwKVsgFLNuQbqCFTpWMF9qnKcMHRQXVapOMe9FYPGz4zfmr1
 X6gLbc5EcNcMtnrRYNr0N5wLGI29YvAXwbXL28LSUIhOJSP68khRH9hRk02dOH6o1jNj55m1XAj
 MkWBrVPvfksXWum+k7hdyShAw+8PWN19Om3D8nCi+zlO3q1lncs6Keh06o0ERefF3MLx9PrhxmA
 j6ey05+1VZFuT2NzHudS9xzD1oAvIW7+bzVWqSR+GntKwHElgRQ7WAlOMdCEsEni1krd2q1Wk9b
 5rdd6OIoHn8q8t7u+KQ==
X-Authority-Analysis: v=2.4 cv=TcsDJhQh c=1 sm=1 tr=0 ts=6ad7a057 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=7CQSdrXTAAAA:8 a=rxnY8KSqnLZGKI4wGMoA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200068

On Mon, 19 Oct 2026 22:38:43 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Extract a ghes_edac_init_error() function to prepare for
> Memory Error Section 2 support (and re-usage).
> 
> Also use a guard in the caller ghes_edac_report_mem_error()
> function for code simplification.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/edac/ghes_edac.c | 66 +++++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index d80c88818691..b90150c67f4b 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -267,37 +267,14 @@ static int print_mem_error_other_detail(const struct cper_sec_mem_err *mem, char
>  	return n;
>  }
>  
> -static int ghes_edac_report_mem_error(struct notifier_block *nb,
> -				      unsigned long val, void *data)
> +/* Caller must hold ghes_lock. */
> +static struct edac_raw_error_desc *
> +ghes_edac_init_error(struct ghes_pvt *pvt, unsigned long sev)

Slightly unusual to have an init function that doesn't directly take the thing
being initialized. I'd pass it in. The clearly of pvt->msg and pvt->other_detail
is also a bit of a surprise for a function that claims to be initializing something
else so I'd do those outside of the helper.

Or maybe rename helper to something like
ghes_edac_fill_error_from_pvt() 
Not sure that really conveys the modification of pvt data hidden in here though.

Perhaps this refactor was a bad suggestion from me and better to just duplicate
the code.  What do ACPI maintainers think?



>  {
> -	struct cper_sec_mem_err *mem_err = (struct cper_sec_mem_err *)data;
> -	struct cper_mem_err_compact cmem;
> -	struct edac_raw_error_desc *e;
> -	struct mem_ctl_info *mci;
> -	unsigned long sev = val;
> -	struct ghes_pvt *pvt;
> -	unsigned long flags;
> -	char *p;
> -
> -	/*
> -	 * We can do the locking below because GHES defers error processing
> -	 * from NMI to IRQ context. Whenever that changes, we'd at least
> -	 * know.
> -	 */
> -	if (WARN_ON_ONCE(in_nmi()))
> -		return NOTIFY_OK;
> -
> -	spin_lock_irqsave(&ghes_lock, flags);
> -
> -	pvt = ghes_pvt;
> -	if (!pvt)
> -		goto unlock;
> -
> -	mci = pvt->mci;
> -	e = &mci->error_desc;
> +	struct edac_raw_error_desc *e = &pvt->mci->error_desc;
>  
>  	/* Cleans the error report buffer */
> -	memset(e, 0, sizeof (*e));
> +	memset(e, 0, sizeof(*e));
>  	e->error_count = 1;
>  	e->grain = 1;
>  	e->msg = pvt->msg;
> @@ -323,6 +300,36 @@ static int ghes_edac_report_mem_error(struct notifier_block *nb,
>  		e->type = HW_EVENT_ERR_INFO;
>  	}
>  
> +	return e;
> +}
> +
> +static int ghes_edac_report_mem_error(struct notifier_block *nb,
> +				      unsigned long val, void *data)
> +{
> +	struct cper_sec_mem_err *mem_err = (struct cper_sec_mem_err *)data;
> +	struct cper_mem_err_compact cmem;
> +	struct edac_raw_error_desc *e;
> +	struct mem_ctl_info *mci;
> +	struct ghes_pvt *pvt;
> +	char *p;
> +
> +	/*
> +	 * We can do the locking below because GHES defers error processing
> +	 * from NMI to IRQ context. Whenever that changes, we'd at least
> +	 * know.
> +	 */
> +	if (WARN_ON_ONCE(in_nmi()))
> +		return NOTIFY_OK;
> +
> +	guard(spinlock_irqsave)(&ghes_lock);
> +
> +	pvt = ghes_pvt;
> +	if (!pvt)
> +		return NOTIFY_OK;
> +
> +	mci = pvt->mci;
> +	e = ghes_edac_init_error(pvt, val);
> +
>  	edac_dbg(1, "error validation_bits: 0x%08llx\n",
>  		 (long long)mem_err->validation_bits);
>  
> @@ -375,9 +382,6 @@ static int ghes_edac_report_mem_error(struct notifier_block *nb,
>  
>  	edac_raw_mc_handle_error(e);
>  
> -unlock:
> -	spin_unlock_irqrestore(&ghes_lock, flags);
> -
>  	return NOTIFY_OK;
>  }
>  

