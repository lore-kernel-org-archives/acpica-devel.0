Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437886;
	b=MoBuR5UbCQeWqMOInG8/GTBcJ2qyNfA3SYKzy7t8A/Y8kdQ8qwR63OroYXj/+qKL9j1z
	 F0xOeUm+tp+cTkPLWhuw5yHlR7qT0TTpgrEgMlP6UwYdbbnTkUEF3nOmnCsAmSag/e1mn
	 MfJvPXujUM5qJNGarSt/qE8nL/tRCykHSa7yjVI9+6hMsioWF8H8D7wH/pOcqsxct3drp
	 VFxCkkUeLsc5yCSVFmgyXmwao1pQlhkvP2DcR92xPJE8gPJi7ykgnC/gznJ4LIxwlpcdx
	 B4EM21sxAP62I6hzRygAzvnZWYV/khnY10PoybeE2A84z5ZXu1P+QiRqj0/3wx2ub5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437886;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=BMUhm5+GJQEDK7W/pa/hsK7Ip8Ta9HhXsuNAgIn4IXI=;
	b=urQdz46UUDSDTnBN93pBfqWjdIoVkgG96daBaj320+D5V54YPP7DMQ9cG7RTdgPD+prp
	 KpQ6PidhrFnrdGfZwQo06IhEGbUfS/XvrmE/5NkoKor08ltnlS83y38hdoO7ytwlcOAiR
	 JCGD0w1OvkFg8t1bsxqSJuZmItPFdMfcnXUdNgNoZsA3DV7bUBPSO+G5W0EBrkekGPdHm
	 vEvETXeZSsjEdZci9uYbrfimkKEzcFx0ggPBZ25KZJCrbLVhA6ojP4Nompf+kkhjBWRhZ
	 eQmxKC3dYS4KvhjWSxb0A9xAUmtLDTkQ7QDexhfXVqomSrYSoJbVw6oXk0G29b0PURA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CRwJAm+R;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TN8lpxru;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9522606A31E
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 19:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9522606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CRwJAm+R;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TN8lpxru
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JJJuD02604726
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 19:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BMUhm5+GJQEDK7W/pa/hsK7Ip8Ta9HhXsuNAgIn4IXI=; b=CRwJAm+RXy3ZPfsk
	5y75LciccvrkroJApArGjvbL3WqdD5rIV/kvilAJo627eH2fu9ELzN90n+3tN3Ey
	OVo88iw9RoigRazM2oaGyz0oBqvnOYctvMHsYT5ECl3xWAX9z08SRLyWomJi3YkD
	MN0Z9pORPMppiZ7oqIQNUz+/YuQiyETnx5R+Kb68NqBNc6tABTfLKwkZ0Nh+eAlc
	tqDlldWEkZOln4AuvvnwKkAfoCi2Ijluszem9JSs+vPvqNoBInQ82Rx7Lp3kGCOV
	PcprY7NqODq584+bgpx5E8Oy4j1rgDS+P52Tqb78AdgH1UJozluk/nnG/QCaKe/R
	eVR16g==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4a0a5g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 19:24:44 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-18b5ee75447so3295991c88.1
        for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792437884; x=1793042684; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BMUhm5+GJQEDK7W/pa/hsK7Ip8Ta9HhXsuNAgIn4IXI=;
        b=TN8lpxruVHQojTx3hKuNfC/zY6p62AvBmvpaHKxGBrH/3t66A95t3yXiNTdeRIhN8P
         O3et8qotfn5vUMCx+Lc77SWs5RVZQ96ZKYyh00Jnqxog6nBE7P7VrbmQtW8j/+LuFjZM
         R6xITVZWsKo2by7z+c18QNrdriGyEuZ4/dkP92DEQmh5WeNB2fBr7+aahJ5HpDgXUidA
         U/6SD71L2FNlbGxR+8YGZQ9ysB5H6DaH0PrD6iynP7y8i1CxOrVnBlDi9QltlItBD5Y2
         2klSEeV6+lUv0+8sIY3NYa5vr/0HtTJZ2z0itFcaBFDX3BrU51sZryTfTFmKbiPf0QR/
         WnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437884; x=1793042684;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BMUhm5+GJQEDK7W/pa/hsK7Ip8Ta9HhXsuNAgIn4IXI=;
        b=WXykojynr4DP+jOPuSQAp5PjVvxAXa4HUQu1lCXBcAkIL70q/Y4jaaPW7eBrO3G0WQ
         P4azF54emYltv2S1rY/N6dA/YBzX3FbtnbNeFD3w18QnBQsz4pMD9/r6FQJQXJ+nZf0T
         S0sevJ7d0TVXu0oSQ1BssQrXGl5ZYL8qdeSKdOO/N/MNP/4mvMeBJH86kAGl5oUc3X4z
         vaylHCyBIK5mUEjWVYPcqwlpCFeQUArtRInVriDsBqQrFC0uIgb6Q+raQ+xBCVDB1d3e
         cqc3P7/T97rMUyF1/deD3Qs64sbnQjrhgyM0OwHOipvmQcnVCrUGDxzJkDGB6BAcTvee
         Qkgw==
X-Forwarded-Encrypted: i=1; AKwUvByisQ3WxrbYXwb3lp6Z7JcVPTcd9Nz18TJptq4uj7NS17BMH+5bZie7IKbELcWEVzdQhvO+7CEmDo9HCx0=@lists.linux.dev
X-Gm-Message-State: AFq9FYIjdvpVxJVHAZpmywLltv+l3reokW0MTuT6L+fR7KAorLKy3p9z
	RF7uRJxZD3dhbVTcNgnIPDrs0CKUZTfi2/REOZGAUwM1XyL8NYUEPs3UmwlcvW8Q2WiTD3jKTY4
	omYVK4GKPfC+oYFImTG/Qa6bf59tjydv7tjRqeGq0Vxy/3Wd1t0QxzuyY7+pF8lKcah8=
X-Gm-Gg: AYBFou3GNy0uYPosZtPtzm1PhhEjI0TzTKqr1AEA7ua5YFDOrAJ5cWl+3KfrvcvLLo4
	QP7AiAdmRtp/1xbtjGil1SVDt6ScxTetAxMcqjiR3JftiDTmdCS+e5QQgcauLzYfhB4NjkWGYyB
	hdKj9/T1vY9kv1lEF8l2Wmk9KDJL04MEOX/IObzLDsC+1lawgJae+0b1b3zGNZV307NVkSuGgqJ
	rX6KreY0mH6MscVKNVrc3O9SpbholDKaLU9LQX0pTIHmT929afnqjr79Vn2BZ/vfhO20c38hA6A
	+um3XkueV3E4YLhdB+X0uXsFOyxq0DAZAwLMjWukc6U8+KoG+yoe0coCeRBoLPbkj/pG4GpjZhc
	B9psZ23R60lIvtQzGHR28ya1C8bhUqx5fB7sYH/LGdG8pL0ZGvpRgZg==
X-Received: by 2002:a05:701b:4308:b0:15a:2b63:a0cb with SMTP id a92af1059eb24-18511ad8bacmr13577097c88.13.1792437883578;
        Mon, 19 Oct 2026 12:24:43 -0700 (PDT)
X-Received: by 2002:a05:701b:4308:b0:15a:2b63:a0cb with SMTP id a92af1059eb24-18511ad8bacmr13577069c88.13.1792437882911;
        Mon, 19 Oct 2026 12:24:42 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b37ce3fsm27157689c88.14.2026.10.19.12.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:24:42 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:24:35 -0700
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
Subject: Re: [PATCH 5/6] ACPI: APEI: add separate Memory Error Section 2
 handlers
Message-ID: <20261019122435.000079c0@oss.qualcomm.com>
In-Reply-To: <20261019145643.1877246-6-pierre.gondois@arm.com>
References: <20261019145643.1877246-1-pierre.gondois@arm.com>
	<20261019145643.1877246-6-pierre.gondois@arm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3NyBTYWx0ZWRfXzojO5db5ZRG1
 YFBTt1L/Nk7BYE/KTYgQQQUQ7TZp3YKTOxY9n82izamozp2b8w8R0wHqr6QX1VJggDyGefFO8t9
 sgaG4Q8oeO8bhro+OgV1vOd2OrN50KU=
X-Authority-Analysis: v=2.4 cv=Zt54uN7G c=1 sm=1 tr=0 ts=6ad66e7c cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=7CQSdrXTAAAA:8 a=rtJ9AlOumMsWe6EQo_MA:9 a=CjuIK1q_8ugA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: fjB3UePxJGMmrMWAETFSnbT8M5Ovr5QD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3NyBTYWx0ZWRfXyKD248w7cT7S
 DBid4XuUXJu4/RoPUMNZ2LAO2pqihwkV+hrjUrd8ZPUA4jbRFvuKZ15P7joBossepWhVGSwLQqg
 pCUyXjVqmVuHyv9O6Vj1v+6wnjL8Y6DvKL4kGvEATtt/IczcsSjh/eHKNC7mYjJtVqVxShTxlzf
 6aQ1ZvFrVeJ8BOcblObT7q1tXxYb82aKbDtc11nJuVmL7cmCx1AsQDDpTJPxk8jLiBsCaYJEPPy
 YJepTxX8ypJwWx6VxM0s2NO2mb/xl3+L8C8IqUSNKJPicfOM9Mb8YV7xEv8TvLheKYmyRxqU3nN
 HiKVG3aDFBfzTKJbKhUNrzK+Ik0bFYpnNsr2MyJpjvIw88sTShAf3tlJWEdgo6uoyMUsN2I6uSI
 WRF8SwdgNIl5m3lKzKyfcDrsg99G2ulIkbuk36UVF5AtEmfbs0ARAEXA5N4/2HAc48g+W7H51To
 z6eWRXClgf+irPj675g==
X-Proofpoint-GUID: fjB3UePxJGMmrMWAETFSnbT8M5Ovr5QD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190077

On Mon, 19 Oct 2026 16:56:12 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Add dedicated GHES and EDAC callbacks for Memory Error Section 2
> records. Use a separate GHES notifier chain so existing consumers
> continue to receive legacy memory error sections.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
A few trivial things inline. 

Otherwise I'm fine with this though as you noted before the duplicating
is a bit annoying.

> ---
>  drivers/acpi/apei/ghes.c |  49 ++++++++++++-
>  drivers/edac/ghes_edac.c | 150 +++++++++++++++++++++++++++++++++++++++
>  include/acpi/ghes.h      |   2 +
>  3 files changed, 200 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index fe10ab0e02f6..c7fb15543b56 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c


> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index d80c88818691..b18460ba8f40 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c

> +
> +static int ghes_edac_report_mem_error2(struct notifier_block *nb,
> +				       unsigned long val, void *data)
> +{
> +	struct cper_sec_mem_err2 *mem_err = data;
> +	struct edac_raw_error_desc *e;
> +	struct mem_ctl_info *mci;
> +	unsigned long sev = val;
> +	struct ghes_pvt *pvt;
> +	unsigned long flags;
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
> +	spin_lock_irqsave(&ghes_lock, flags);

Perhaps use a guard so you can simplify error paths a little.

> +
> +	pvt = ghes_pvt;
> +	if (!pvt)
> +		goto unlock;
> +
> +	mci = pvt->mci;
> +	e = &mci->error_desc;
> +
> +	/* Cleans the error report buffer */
> +	memset(e, 0, sizeof(*e));
> +	e->error_count = 1;
> +	e->grain = 1;
> +	e->msg = pvt->msg;
> +	e->other_detail = pvt->other_detail;
> +	e->top_layer = -1;
> +	e->mid_layer = -1;
> +	e->low_layer = -1;
> +	*pvt->other_detail = '\0';
> +	*pvt->msg = '\0';
> +
> +	switch (sev) {
> +	case GHES_SEV_CORRECTED:
> +		e->type = HW_EVENT_ERR_CORRECTED;
> +		break;
> +	case GHES_SEV_RECOVERABLE:
> +		e->type = HW_EVENT_ERR_UNCORRECTED;
> +		break;
> +	case GHES_SEV_PANIC:
> +		e->type = HW_EVENT_ERR_FATAL;
> +		break;
> +	default:
> +	case GHES_SEV_NO:
> +		e->type = HW_EVENT_ERR_INFO;
> +	}
> +

Almost everything down to here is not memerr2 specific maybe factor
out an initialization helper for the edac structure?

> +	edac_dbg(1, "error validation_bits: 0x%08llx\n",
> +		 (long long)mem_err->validation_bits);
> +
> +	/* Error type, mapped on e->msg */
> +	if (mem_err->validation_bits & CPER_MEM2_VALID_ERROR_TYPE) {
> +		u8 etype = mem_err->error_type;
> +
> +		p = pvt->msg;
> +		p += snprintf(p, sizeof(pvt->msg), "%s", cper_mem_err_type_str(etype));
> +	} else {
> +		strscpy(pvt->msg, "unknown error");
> +	}
> +
> +	/* Error address */
> +	if (mem_err->validation_bits & CPER_MEM2_VALID_PA) {
> +		e->page_frame_number = PHYS_PFN(mem_err->physical_addr);
> +		e->offset_in_page = offset_in_page(mem_err->physical_addr);
> +	}
> +
> +	/* Error grain */
> +	if (mem_err->validation_bits & CPER_MEM2_VALID_PA_MASK)
> +		e->grain = ~mem_err->physical_addr_mask + 1;
> +
> +	/* Memory error location, mapped on e->location */
> +	p = e->location;
> +	p += cper_mem_err2_location(mem_err, p);
> +
> +	if (mem_err->validation_bits & CPER_MEM2_VALID_MODULE_HANDLE) {
> +		struct dimm_info *dimm = NULL;
> +
> +		p += cper_dimm_err2_location(mem_err, p);
> +		if (mem_err->mem_dev_handle <= U16_MAX)
> +			dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
> +		else
> +			pr_warn(FW_WARN "Memory Error Section 2 module handle 0x%x exceeds SMBIOS range\n",
> +				mem_err->mem_dev_handle);
> +		if (dimm) {
> +			e->top_layer = dimm->idx;
> +			strscpy(e->label, dimm->label);
> +		}
> +	}
> +	if (p > e->location)
> +		*(p - 1) = '\0';
> +
> +	if (!*e->label)
> +		strscpy(e->label, "unknown memory");
> +
> +	/* All other fields are mapped on e->other_detail */
> +	p = pvt->other_detail;
> +	p += print_mem_error2_other_detail(mem_err, p, e->location, OTHER_DETAIL_LEN);
> +	if (p > pvt->other_detail)
> +		*(p - 1) = '\0';
> +
> +	edac_raw_mc_handle_error(e);
> +
> +unlock:
> +	spin_unlock_irqrestore(&ghes_lock, flags);
> +
> +	return NOTIFY_OK;
> +}


