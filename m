Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792438147;
	b=y9L8j/rqJZXu0xOcSdj/YcMJCjL2mIjrt4TFKwgmXY7qk0A2SBF6gX88VczdhgOWGBFu
	 L2sftspeUWqBZiPmm+/jC3Yli41LB6+48Z2OKc8TmlHPkLcYjeMOlVNXQUU1bttEStFDV
	 gYn76KpFP+++GgOK2jcme2l7A1z/Lik5qVEdpZUFoVugiUzUoF4YpqmSDdpokHwH7RAxD
	 faoM/fXr54578j5aHYLZWOU8EjlsSb7SnFoFEh1HdFw1zPWzOYNXTpytFYerIS+4LkF4B
	 SiPwQI0Rz0MMYjx9hTCJbEVBS63oXFa5/sX/erWW6A1hW/ditwTmZlxxcRZzDwI2tJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792438147;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HTr+bxbq66BXfG6Xfngcx7CALmbZE47aY8OHfPSSUbQ=;
	b=VFhhW3vHEDFge0YK09/q3LZhop8VlMQp/LNMA6HKRQZ4RIj4jrYNQsw47eb8FvbyEiVt
	 TsOKpxFZg0CRaaDuZjsL/skYQQkyJJqMCrDuNASzjE18NY2siSFejHqJwKcw72e9F4yPx
	 SI+/vLaq3oujg7x7JddzYVcIjl65rZMcESU45TAG9B8gja6FTP4ptk6fQmHKDK6zeYELF
	 2bvevK+ce0AxYTX7rXJsyN8DDza0gv0+9o95/an414jH5eJNsjjxPf5WB51tIXtTlXMtO
	 I1uDZT+lzYelshd2yjG2GPhZmyEr3rG94uoTwt9EYnYkmNjgPQlowwXWachZ5xsRL5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="SS/rmX7J";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NYxOfXaj;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D25606A31D
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 19:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72D25606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SS/rmX7J;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NYxOfXaj
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JJK99j2604981
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 19:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HTr+bxbq66BXfG6Xfngcx7CALmbZE47aY8OHfPSSUbQ=; b=SS/rmX7J69jv854K
	k6MYKuuktMkMKa56Fl1yxD1LV2ygTDQvqgdK8dPvPdZlOpL8zrxqpx9kHI28gBnq
	c9G9slGZ8HAfXo5PP8qKCplKLa9k9oLmOFprlF3rOM4v5uFC2qEiHdO421kY/Y6U
	ACeRgV8WsFawbBLYvcR3IB1kn2sB/Z+ZDd6ZbKmyb+TDsIVSPTBI8qbGn+pv0WhV
	2Bd7KQJBN4rdXRYuUXvCMKXL08zzg+DYIs+0ER9g8OToavQC4Mxwa4LI4DsX3QaX
	rYV39n4h+5KDRa3Xsa7vNr5j4zUO9UN6kWMt9xhxNDaDDZPKss3g89ej2nvlxN/r
	402beQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4a0aj9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 19:29:05 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso5113315eec.1
        for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792438144; x=1793042944; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HTr+bxbq66BXfG6Xfngcx7CALmbZE47aY8OHfPSSUbQ=;
        b=NYxOfXaj/4POj88jVt+f/flZLfp1mbSapxbbrebCSKULlP+ycAlsE+iwgIZU1g1aQs
         02If1x7fso2ZWx7KrMLWDWdJaSsz8GjRKnb66gi8Xy28L8CVl7z6AzECKzFOQUng2usf
         gDu7FYk6VluuG3LhMtcdT1UjEsF7Z9hnXqMmZlmu7C64pjTgFw0lh5oYqrYXBjYWn/yb
         rzXBE/wr/3aX3INnUG1kmZ18XpEmw/8+X8qQtRP6NQphkHMqRNARO8tyH9/hrREUgunt
         fpU79QAs2PT1VsvMp/2y88vzD4lDt8SpmBvcN3vluinTz8JdkYlt1A47TwIjiTWPpM+u
         a1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792438144; x=1793042944;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HTr+bxbq66BXfG6Xfngcx7CALmbZE47aY8OHfPSSUbQ=;
        b=LMiqnhEJXZuw2/KBSmNBqPo/nLLtpPaEIrYpiNk/6PTi9+S06lbOMfjfmNR0FgNrGu
         Vt651Fz/M0hFqsKBovCyCiUj/62Qam9We2yS7za2nqHAPnPxpO/9bJAMeyI8pMxNE6cz
         2r3xZ7xn1x7p+G6oJ8NP1HytuwORt6Z8tu2ttASyNyB4lGY6F76HSB/OdusUdy71C/GQ
         tCNA/4MjIRQsLomlrMLfaXuFoPjh3biXoET+/kaYp2AB+u3ncEuEL8wtPVyOZPAuhT8r
         W8sQ0HBm8dD5xWO9vWFq7E4J3Cd98pzcT2hyQbk7FAhSXEpPvrGtmIZb/Nxzz/Tk5U/l
         V8hg==
X-Forwarded-Encrypted: i=1; AKwUvBwgeodDkyb0RWymg33el6Rs03IkS9sLTfbiJPcH0+cqdWMfY3BDlegBlK47vOzwHLYbl8tTajdvZUkTc+U=@lists.linux.dev
X-Gm-Message-State: AFq9FYJx/3h7ZdOUW3fQtv6J4u0BSU0t2ywx8XE6Gp1WaI6UdSmRuUoX
	U/BiT/Ud89gZzuT3rlGBX20C3ktwjheY4+EOgYr69gzcICnJeMVtZxYBfQXtZ//GBoTFyQ8Vrby
	K+r5ZxPKOWUjTyUV2SE+fS9pLd0/mZIRIETrbaxeKfx/ibu/yf5AtxjaRn6Bsp8b4Z6U=
X-Gm-Gg: AYBFou1CbcbWGMPfvwZndzJfY+vFSMExtv2SYvscofTZcIqDT6tj/XyeIDYVFH4d8kL
	hHfymYlVK0Em9TnFuflGN2uDJ7UokQylSn+wCHb0asPe7NnNtt/fWKwgxN6qYT00gzUtW4WxEhd
	3vsxOKuTrejmeF6A94/aclk2IFx8+2RmkjcTjoWkjZHwaa3rpeY6Xx3oGXxgsQfX1z4f/MbwMvd
	O/YUlE/uZwbZg36AlFlo/Tb9QB257E1YacrcrKMuN5gv7yFLt7LG1qCPHuD0BVJLmuz5GTGSp15
	zKrfHIWwhBPcdIeIfDF1m2ckKyNaB0fLa79srrFrZuW7wo5YRUgLibosNkcLUCUBUIxcmWi5bbJ
	NuYinUzpJW6b3w1p6jA5TDHc4VUPe0Scl7uEmOIXrLw==
X-Received: by 2002:a05:701b:2902:b0:16a:c6f2:60c2 with SMTP id a92af1059eb24-18512c381bdmr9816933c88.12.1792438144214;
        Mon, 19 Oct 2026 12:29:04 -0700 (PDT)
X-Received: by 2002:a05:701b:2902:b0:16a:c6f2:60c2 with SMTP id a92af1059eb24-18512c381bdmr9816894c88.12.1792438143497;
        Mon, 19 Oct 2026 12:29:03 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm30689377c88.17.2026.10.19.12.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:29:03 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:28:58 -0700
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
Subject: Re: [RFC PATCH 6/6] ACPI: extlog: add Memory Error Section 2 trace
 event
Message-ID: <20261019122858.00006cce@oss.qualcomm.com>
In-Reply-To: <20261019145643.1877246-7-pierre.gondois@arm.com>
References: <20261019145643.1877246-1-pierre.gondois@arm.com>
	<20261019145643.1877246-7-pierre.gondois@arm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3NyBTYWx0ZWRfX85NZjp/xKOJy
 U2zQKAhV6Eew1EkB3YVR8PoOHEyM4A4EPUR8IYsQATq7U/lgqc7ceVgZjWa6pyMEJ2ZP4EZ85IO
 JVGnMYTTnmrhs4lOuVZWLBELKS3nNSs=
X-Authority-Analysis: v=2.4 cv=Zt54uN7G c=1 sm=1 tr=0 ts=6ad66f81 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=U8d67ivYhA4UYEs2wG4A:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: TEKkxHvnUzRI0DpM5ZXdu3KAGdUevf81
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3NyBTYWx0ZWRfX+djeq9AXIqdl
 fuTiup1/rRw3mv1ohL3pXuVrx2wDnS24+2bSUDmmLTtnM1IcNyMrS7KA/CWRFmPPu7ub/g6kLbl
 rhQZis+/kTvGIBBidZpPeLsXzqVorRoTvQ/6ZlGiD9Zg+uBT0MWfHlDW1Ht/WVMgWbSiDb5Vprm
 Qvf1y3nh4/EidtipSgU8wRmjPNFVPTwPSHff52XqcsDXmU6KwnBhyfOI8x5lFHVO7rqEegQxkZW
 aB/dBVVIXgDj9Jp92x9KQlJCEhwy7/Ezw0iqs8V1s4z1tIomMCH5dUZji73ZKoPcG/a2c8XhwiD
 f5JmjE/xnNybRDiWaMR7pdQoxdrdhUeJWPEJY02U9EV7OkRR+7nOlciuAPDVGnPDffc4He1DAs2
 +KzB4eOuY7ElHur9qSZsKTgJsu6cRRBOapQZwzLeCdX4kxhpGmXHNbTdSA+01LHF3i/otdK72CJ
 ARMSZsW2uGGJ4QBkGlg==
X-Proofpoint-GUID: TEKkxHvnUzRI0DpM5ZXdu3KAGdUevf81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190077

On Mon, 19 Oct 2026 16:56:13 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Add a separte handling for Memory Error Section 2 trace events with:
> - extlog_mem2_event()
> - extlog_mem2 trace event
> The fields of the record are individually printed so userspace
> can discover the layout more dynamically if a new field is added.

How useful are the pair of handles?

Otherwise I'm fine with this - subject to same comment as on patch 1.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/acpi/acpi_extlog.c |  16 ++++++
>  drivers/ras/ras.c          |   1 +
>  include/ras/ras_event.h    | 102 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 119 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index e764d61f71ca..9c0b932e22bc 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -189,6 +189,15 @@ extlog_mem_err_event(struct cper_sec_mem_err *mem, u32 err_seq,
>  #endif
>  }
> 
> +static void
> +extlog_mem_err2_event(struct cper_sec_mem_err2 *mem, u32 err_seq,
> +		      const guid_t *fru_id, const char *fru_text, u8 sev)
> +{
> +#if defined(CONFIG_ACPI_EXTLOG) || defined(CONFIG_ACPI_EXTLOG_MODULE)

Same comment as earlier patch about oddity of protecting stuff in a file
that is normally only built if they are set.


> +	trace_extlog_mem2_event(mem, err_seq, fru_id, fru_text, sev);
> +#endif
> +}
> +
>  static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			void *data)
>  {
> @@ -241,6 +250,13 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  				extlog_mem_err_event(mem, err_seq, fru_id,
>  						     fru_text,
>  						     (u8)gdata->error_severity);
> +		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
> +			struct cper_sec_mem_err2 *mem = acpi_hest_get_payload(gdata);
> +
> +			if (gdata->error_data_length >= sizeof(*mem))
> +				extlog_mem_err2_event(mem, err_seq, fru_id,
> +						      fru_text,
> +						      (u8)gdata->error_severity);
>  		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
>  			struct cxl_cper_sec_prot_err *prot_err =
>  				acpi_hest_get_payload(gdata);
> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> index 03df3db62334..c6b14202a5e9 100644
> --- a/drivers/ras/ras.c
> +++ b/drivers/ras/ras.c
> @@ -111,6 +111,7 @@ subsys_initcall(ras_init);
> 
>  #if defined(CONFIG_ACPI_EXTLOG) || defined(CONFIG_ACPI_EXTLOG_MODULE)
>  EXPORT_TRACEPOINT_SYMBOL_GPL(extlog_mem_event);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(extlog_mem2_event);
>  #endif
>  EXPORT_TRACEPOINT_SYMBOL_GPL(mc_event);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(non_standard_event);
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index fdb785fa4613..0c0dbe068dc8 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -74,6 +74,108 @@ TRACE_EVENT(extlog_mem_event,
>  		  &__entry->fru_id,
>  		  __get_str(fru_text))
>  );
> +
> +/*
> + * Memory Error Section 2 exposes each field separately so userspace can
> + * discover its layout. Validation bits use the UEFI Section 2 assignments.
> + */
> +TRACE_EVENT(extlog_mem2_event,
> +	TP_PROTO(const struct cper_sec_mem_err2 *mem,
> +		 u32 err_seq,
> +		 const guid_t *fru_id,
> +		 const char *fru_text,
> +		 u8 sev),
> +
> +	TP_ARGS(mem, err_seq, fru_id, fru_text, sev),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, err_seq)
> +		__field(u8, sev)
> +		__field_struct(guid_t, fru_id)
> +		__string(fru_text, fru_text)
> +		__field(u64, validation_bits)
> +		__field(u64, error_status)
> +		__field(u64, physical_addr)
> +		__field(u64, physical_addr_mask)
> +		__field(u16, node)
> +		__field(u16, card)
> +		__field(u16, module)
> +		__field(u16, bank)
> +		__field(u32, device)
> +		__field(u32, row)
> +		__field(u32, column)
> +		__field(u32, rank)
> +		__field(u32, bit_pos)
> +		__field(u8, chip_id)
> +		__field(u8, error_type)
> +		__field(u8, status)
> +		__field(u64, requestor_id)
> +		__field(u64, responder_id)
> +		__field(u64, target_id)
> +		__field(u32, mem_array_handle)
> +		__field(u32, mem_dev_handle)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->err_seq = err_seq;
> +		__entry->sev = sev;
> +		__entry->fru_id = *fru_id;
> +		__assign_str(fru_text);
> +		__entry->validation_bits = mem->validation_bits;
> +		__entry->error_status = mem->error_status;
> +		__entry->physical_addr = mem->physical_addr;
> +		__entry->physical_addr_mask = mem->physical_addr_mask;
> +		__entry->node = mem->node;
> +		__entry->card = mem->card;
> +		__entry->module = mem->module;
> +		__entry->bank = mem->bank;
> +		__entry->device = mem->device;
> +		__entry->row = mem->row;
> +		__entry->column = mem->column;
> +		__entry->rank = mem->rank;
> +		__entry->bit_pos = mem->bit_pos;
> +		__entry->chip_id = mem->chip_id;
> +		__entry->error_type = mem->error_type;
> +		__entry->status = mem->status;
> +		__entry->requestor_id = mem->requestor_id;
> +		__entry->responder_id = mem->responder_id;
> +		__entry->target_id = mem->target_id;
> +		__entry->mem_array_handle = mem->mem_array_handle;
> +		__entry->mem_dev_handle = mem->mem_dev_handle;
> +	),
> +
> +	TP_printk("{%u} %s error: validation_bits: 0x%llx "
> +		  "error_status: 0x%llx physical_addr: 0x%llx "
> +		  "physical_addr_mask: 0x%llx node: %u card: %u "
> +		  "module: %u bank: %u device: %u row: %u column: %u "
> +		  "rank: %u bit_pos: %u chip_id: %u error_type: %u "
> +		  "status: 0x%x requestor_id: 0x%llx responder_id: 0x%llx "
> +		  "target_id: 0x%llx mem_array_handle: 0x%x "
> +		  "mem_dev_handle: 0x%x FRU: %pUl %.20s",
> +		  __entry->err_seq, cper_severity_str(__entry->sev),
> +		  __entry->validation_bits,
> +		  __entry->error_status,
> +		  __entry->physical_addr,
> +		  __entry->physical_addr_mask,
> +		  __entry->node,
> +		  __entry->card,
> +		  __entry->module,
> +		  __entry->bank,
> +		  __entry->device,
> +		  __entry->row,
> +		  __entry->column,
> +		  __entry->rank,
> +		  __entry->bit_pos,
> +		  __entry->chip_id,
> +		  __entry->error_type,
> +		  __entry->status,
> +		  __entry->requestor_id,
> +		  __entry->responder_id,
> +		  __entry->target_id,
> +		  __entry->mem_array_handle,
> +		  __entry->mem_dev_handle,
> +		  &__entry->fru_id, __get_str(fru_text))
> +);
>  #endif
> 
>  /*
> --
> 2.43.0

