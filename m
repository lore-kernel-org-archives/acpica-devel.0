Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516661;
	b=iuBBpgouK+Q7+vykVx2ISRFBeJWfyxgJVVQKin5Fmnd+eV8es6tc58he2ZAwyiiGYBz3
	 kT4Wo1ZACbPrX/jEiT28FZkWbTnNNvOwRa9zATOM8HFJ9cad9W3r26nzveQwstflICm4I
	 6c5cqlf1DTeFVDg7Uzb+hcBz1ZBuYO+T8ZmnRsizSaUXHAfizptCFzEVUWbIVKG0lKq6o
	 pnOeN+pvwFXsK9LkyqgPamhNSh4fgiP6cB1ENW69mRMIigARmBkfF8qVJChrzTlNh5J6A
	 tQE6PXIlXOFdpi3+eUuf5Z4wq1DElKlgezh41x86S5x9cQ1Ny2l8YN24FmylsUqSizg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516661;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8QpGW0NKviFKo87+h3Yw2MqyJCFWY8ItSyPAh+yd9CU=;
	b=2NMHgOv+/CkmKzGSzqX5WAG131jbV/AWNqcvL/6z3hyAdd3DzordREBSpNac+LcNoXLq
	 e6HlBKFVr77nL2jEwJ5PJugkQ7zo2LrrciUAXq8J/icTPsWDgkK2JF2SNnAvJVXvSZL64
	 UUE1a+4osnoFpE8rWZrpW8/iQEe96x4EugSvur6sveATQ6kQGuJ7ZmLYP4gHMCjjrrnG6
	 f1o5Cit9qUJkm21eOZEW4dZToWfZIwlVEsdrFAfAiRj4nXhTB8XlaFdUTHR3zkCSSvQbj
	 v4GH2TAYDHPaFC6JQOeku5n51x07rjqqrvYSRaJdMO8q+9uYcaLWDH8JpLfWvXLdgPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o38bSjL8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kH58JmaK;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C34B606A31D
	for <acpica-devel@lists.linux.dev>; Tue, 20 Oct 2026 17:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C34B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o38bSjL8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kH58JmaK
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KGtvtU2712200
	for <acpica-devel@lists.linux.dev>; Tue, 20 Oct 2026 17:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8QpGW0NKviFKo87+h3Yw2MqyJCFWY8ItSyPAh+yd9CU=; b=o38bSjL8gGuVcSTR
	84CM4Pq1EbcbZXg06gl55UxMOt3BBBFXAaXlhz0Nc/GShV6IEjkXFGHydvYGngD2
	VWDoa1cxKjLCUINW6x8og6Dtz14ENY1wHuXJZjFmXtCs7UHDtkyuYfUOZctxHUMG
	RU7zRXlVTOEjoJXk1XJZTpa7bD+Dxx/ObdjSI1IHfj6nZO/ALnZPQKUz/AB84XqC
	6+lm/dnxdyJClEsJ0v6Kj75y8szAaCKkgPjuu3eS1oHzKvAuYzHxbkueXhY9l8DV
	LWibtU0pGo0GN0B+p5+rf0WBZMCTpZeHcXMQCFoftLI47o+VrrEDr64el1XjtOu+
	1D4cOQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nujx3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Tue, 20 Oct 2026 17:17:39 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3580c07911eso9602132eec.0
        for <acpica-devel@lists.linux.dev>; Tue, 20 Oct 2026 10:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792516658; x=1793121458; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8QpGW0NKviFKo87+h3Yw2MqyJCFWY8ItSyPAh+yd9CU=;
        b=kH58JmaKcCPDBZcIhiM864whT54n8GVY9LdR5VMz3sstz/rAJOrKxfQlT9yhxjg0Qx
         Detb7oHoVZeKJumNQkU3ZwjhjGcxfyvReqJMgnhjfAafPuvvZInPqh1+9doy5eFM6Yvg
         2PhijpNC30o9YlKnbo9/Flr6GuPvc68nBLMck7PXVBG0ry4gPle1FNVPpwToSmIZybuf
         HTLsd84iMk4lsTFb3XFookaeqGO9ZCc7zKDXD+SgW16XTN89HNoBK06EHqevBJ49cTQI
         qbSrYb7rdvNQBtP6XKqHNu+pvNWfZ4MrBmqogzMrqVrsnuygkR97pBZA+2wJDvRdS7f6
         fDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792516658; x=1793121458;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8QpGW0NKviFKo87+h3Yw2MqyJCFWY8ItSyPAh+yd9CU=;
        b=TV53mWEuiNhdGHqPftdnjPX1yC700q6bGSFMGi0YcypHbZpef3Au3WTdVsSLaXWs+f
         AoybBjRA1aK+OIXIPiJWnSWL0N6s0myX4nBlCxsMFu8isC5hXS9abb7Xs7LuZkbtxQNy
         7qgoGcmW9piILx9PI8Nt0N5Jh9uNrRMK5vZZagnqAwc38X9352nay33ctM5v8fnc7sGv
         /6mbriA7eEB50lGfzUAPhP/jsQXBlSbivdpV6WGVI+SFjv244dGXMr42ke0wZ5nJCa52
         5msoCiis9R/6nJBwKMC6noEUXhMwAhzfNx8rg0CsIoHlW9ARgq1tmPrRFnBmkYVTCgm+
         AiIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwo9OqziMp7l1vUp8v4cluLP72rbrskQL8gsrGt6jtis8iVJnm84k/vskVMVNR8uJaHmci2+PUwWKydYck=@lists.linux.dev
X-Gm-Message-State: AFq9FYLonzz8/yGTWocAjDlPUfZnIrpgfg5NmtXHoGrtcb/PbBfS9d3g
	wTOaW3A1OG5wmwz7CLpnmgZOJyGDCKWYgKqJl3Iwl0GufianHecZapXrqmDSOAVVmXHY4aFL0aa
	uX88aJlEhQL6CnOHZeiGgynN9ym8xpbmCU5swGCdIdifzcKYdLNSeSUGhjFgG62W7UJw=
X-Gm-Gg: AYBFou0JQB0yldfioKksZl2ltcpGPpo7Jcs1y2JHrp0AE2CL4yhXljDdo6FcnAmZi03
	3wEkKijUz3Wg9/7ZbBD4KPMIi9C+5NPOwP3n4LuWM6ysWgiLGtcbEb2OlydgIb4aCbVmcLfz6XC
	SNCYrZGKI0IcQay5Jzo8CwxYb0c/9WdwggGM4bL5wgFLiPf+IXm+8I8QoNtFNTFkJRtcKdu07+A
	AGnr+GWAIt8z0BPO8WNqvPgNoiL5POpEoBHyX4jZn1rftFjOeSnczVs0jtO+APQI9g65wKF9A3s
	2ZGAjxbi2OHsAHnOKua6Zbvyw0OX04mx9AC+7viiESJcebQk3fgoyk5OLhiQm/R1RdssA3d+6og
	zniowElqh31fzSWB44jksZXEzviF59Uq7LVd0NgpaYg==
X-Received: by 2002:a05:7023:a47:10b0:15a:9834:73c9 with SMTP id a92af1059eb24-1851453f752mr15327649c88.40.1792516658259;
        Tue, 20 Oct 2026 10:17:38 -0700 (PDT)
X-Received: by 2002:a05:7023:a47:10b0:15a:9834:73c9 with SMTP id a92af1059eb24-1851453f752mr15327601c88.40.1792516657378;
        Tue, 20 Oct 2026 10:17:37 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bb7f098sm5472c88.12.2026.10.20.10.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:17:36 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:17:20 -0700
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
Subject: Re: [PATCH v2 5/6] ACPI: APEI: add separate Memory Error Section 2
 handlers
Message-ID: <20261020101720.00002545@oss.qualcomm.com>
In-Reply-To: <20261019203915.2019037-6-pierre.gondois@arm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
	<20261019203915.2019037-6-pierre.gondois@arm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2OCBTYWx0ZWRfX33zu8jJjjY4r
 LSN8dg/eWjuQSCgBPJeq+bpbqWSY7x40Zoxm+axqD/wythLD3+Kh/IGHF9EH5k2HQgw+g9hWg5E
 nuhL9uRzbpmOur0P3/7jJOjfiDGQshc=
X-Proofpoint-GUID: PHw1fIe9N6kqi3T2gtalwmvOJrv0C02D
X-Proofpoint-ORIG-GUID: PHw1fIe9N6kqi3T2gtalwmvOJrv0C02D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2OCBTYWx0ZWRfXy+DtDp7c6pLz
 p/JDsi/IWseh6wTVHmL4C8q+TP8ty1piAXel/gr4QFSdYn8qD/iZydgL1MrRbSsHqavhAbabRy1
 5HuoCLumEybLSU8LIS0R7CbdY11ph3pcXKpS40hqvoZrP0G46H2aKZTxTG6JXUpKrFozxUbaWBm
 l7GBSxXM5vqzCWKBp1w40equolKeMU8WnG6q/x8FUlawPd1qWicl0Iqw7xlsrvDvZfN/WRChhAY
 Knelkw10TQDAuOh5CS+uHUh7kjN3o3YR4ISDqzNsKVc4CayyJrwIMPCvm5ZNKhiul3QrioyGk4x
 4TTWZljOjuhSeZPVKQjJQpyotI5ZggWwaW6jjEjYf6qvLu9uVdiWScBK7I5nUgbyZrF/AdcVX1O
 5EPvSKnDGHpWx9c09fu9bxfz3VJpNRYELfPnJFq1eE1/PJeiohCfRiG0s0op7MlBpr0ek5dMfLy
 LCleemK6mXr626liukg==
X-Authority-Analysis: v=2.4 cv=TcsDJhQh c=1 sm=1 tr=0 ts=6ad7a233 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=Rvnai5sDmRKbKYGs1KsA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200068

On Mon, 19 Oct 2026 22:38:44 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Add dedicated GHES and EDAC callbacks for Memory Error Section 2
> records. Use a separate GHES notifier chain so existing consumers
> continue to receive legacy memory error sections.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
I think this is is ok. I don't love the dual notifier chains but
right now I also don't have a better idea.

So a somewhat tentative
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Jonathan

> ---
>  drivers/acpi/apei/ghes.c |  49 +++++++++++++++-
>  drivers/edac/ghes_edac.c | 118 +++++++++++++++++++++++++++++++++++++++
>  include/acpi/ghes.h      |   2 +
>  3 files changed, 168 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index fe10ab0e02f6..c7fb15543b56 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -101,6 +101,7 @@
>  #endif
>  
>  static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
> +static ATOMIC_NOTIFIER_HEAD(ghes_report_mem2_chain);
>  
>  static inline bool is_hest_type_generic_v2(struct ghes *ghes)
>  {
> @@ -551,6 +552,29 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>  	return false;
>  }
>  
> +static bool ghes_handle_memory_failure2(struct acpi_hest_generic_data *gdata,
> +					int sev, bool sync)
> +{
> +	int flags = -1;
> +	int sec_sev = ghes_severity(gdata->error_severity);
> +	struct cper_sec_mem_err2 *mem_err = acpi_hest_get_payload(gdata);
> +
> +	if (!(mem_err->validation_bits & CPER_MEM2_VALID_PA))
> +		return false;
> +
> +	/* iff following two events can be handled properly by now */
> +	if (sec_sev == GHES_SEV_CORRECTED &&
> +	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
> +		flags = MF_SOFT_OFFLINE;
> +	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
> +		flags = sync ? MF_ACTION_REQUIRED : 0;
> +
> +	if (flags != -1)
> +		return ghes_do_memory_failure(mem_err->physical_addr, flags);
> +
> +	return false;
> +}
> +
>  static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
>  				     int sev, bool sync)
>  {
> @@ -915,7 +939,8 @@ static void ghes_log_hwerr(int sev, guid_t *sec_type)
>  		return;
>  	}
>  
> -	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
> +	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM) ||
> +	    guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
>  		hwerr_log_error_type(HWERR_RECOV_MEMORY);
>  		return;
>  	}
> @@ -952,6 +977,16 @@ static void ghes_do_proc(struct ghes *ghes,
>  
>  			arch_apei_report_mem_error(sev, mem_err);
>  			queued = ghes_handle_memory_failure(gdata, sev, sync);
> +		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
> +			struct cper_sec_mem_err2 *mem_err = acpi_hest_get_payload(gdata);
> +
> +			if (gdata->error_data_length < sizeof(*mem_err)) {
> +				pr_warn(FW_WARN "Memory Error Section 2 length is too small\n");
> +				continue;
> +			}
> +
> +			atomic_notifier_call_chain(&ghes_report_mem2_chain, sev, mem_err);
> +			queued = ghes_handle_memory_failure2(gdata, sev, sync);
>  		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>  			ghes_handle_aer(gdata);
>  		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
> @@ -1973,3 +2008,15 @@ void ghes_unregister_report_chain(struct notifier_block *nb)
>  	atomic_notifier_chain_unregister(&ghes_report_chain, nb);
>  }
>  EXPORT_SYMBOL_GPL(ghes_unregister_report_chain);
> +
> +void ghes_register_report_mem2_chain(struct notifier_block *nb)
> +{
> +	atomic_notifier_chain_register(&ghes_report_mem2_chain, nb);
> +}
> +EXPORT_SYMBOL_GPL(ghes_register_report_mem2_chain);
> +
> +void ghes_unregister_report_mem2_chain(struct notifier_block *nb)
> +{
> +	atomic_notifier_chain_unregister(&ghes_report_mem2_chain, nb);
> +}
> +EXPORT_SYMBOL_GPL(ghes_unregister_report_mem2_chain);
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index b90150c67f4b..01defc4e3bf1 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -390,6 +390,122 @@ static struct notifier_block ghes_edac_mem_err_nb = {
>  	.priority	= 0,
>  };
>  
> +static int print_mem_error2_other_detail(const struct cper_sec_mem_err2 *mem, char *msg,
> +					 const char *location, unsigned int len)
> +{
> +	u32 n;
> +
> +	if (!msg)
> +		return 0;
> +
> +	n = 0;
> +	len -= 1;
> +
> +	n += scnprintf(msg + n, len - n, "APEI location: %s ", location);
> +
> +	if (mem->validation_bits & CPER_MEM2_VALID_ERROR_STATUS) {
> +		n += scnprintf(msg + n, len - n, "status(0x%016llx): ", mem->error_status);
> +		n += scnprintf(msg + n, len - n, "%s ",
> +			       cper_mem_err_status_str(mem->error_status));
> +	}
> +	if (mem->validation_bits & CPER_MEM2_VALID_STATUS)
> +		n += scnprintf(msg + n, len - n, "section_status:0x%02x ",
> +			       mem->status);
> +
> +	msg[n] = '\0';
> +
> +	return n;
> +}
> +
> +static int ghes_edac_report_mem_error2(struct notifier_block *nb,
> +				       unsigned long val, void *data)
> +{
> +	struct cper_sec_mem_err2 *mem_err = data;
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
> +	return NOTIFY_OK;
> +}

