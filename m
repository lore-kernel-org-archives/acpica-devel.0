Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800596;
	b=Kj6g22fBBww2DDvOjDKdNbtzBE9cxjGC9jX07gMCYEicTjn2I2I5EiIJmLnMWhrhIov4
	 30FBxP9vkthUcLMQvGLEq1gT3OBbWlWSK9Gq6cby7APQyXp5wcj75CKXpcUvAn6JLPyoo
	 MhvTLmOoDgyX698baVkSMtyylZlWHCoZIfgbLpjskJ6v1Zc9qLl0Ec1PKUHLd48CfHnww
	 mvdA34J1hge/QK4i8eXqb6iNtqnC9+Rj5nkrdK0iDoyVRam82cmbwJ92r3yZ2AdN09tWk
	 EPNlB1+jPzde3xhxr7MTSXfFAKKDHSlMIzqNCsbo1YMEiZt6HMhnIVAl8OYI2ArwpIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800596;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=oHnBaDBiTFLamKq5NGOdIg3Rc+UCACis/kFyJn6z/tk=;
	b=DlVfZUfBh5N+lUTSNwFX/r5a0UMYZkjAAkUDpuyEDuh4E+SB0g03/1VVOjZ2WUFOqztw
	 j8OQzglyGK4gCzwL49F2c6/KC/aV/EeykcmiuoZmjE190Xa6nWfzUUMRQfLBfqHW84DE6
	 K8nUDg6YfqG1evHSU4F7JlXn1kUzPsWWp6E0afFfws0JEYSeUHc2RGV6TW4870kEyXKQT
	 Ta5D/h/ZvLT95RHBXgn3TJNzU2JFeB4C7CGSqImm65fVvhlP4tce7sVsmoRsnE1LC3o1/
	 ySsgpnSLKyoL2SDXEwWCxqvXAa+zTakWe31OxEqPOFekwMVZUbSiX9kPhuWILYPag/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=an5WwwQJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RH83sAYL;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FB9606A32E
	for <acpica-devel@lists.linux.dev>; Sat, 24 Oct 2026 00:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75FB9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=an5WwwQJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RH83sAYL
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLvboq3471152
	for <acpica-devel@lists.linux.dev>; Sat, 24 Oct 2026 00:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oHnBaDBiTFLamKq5NGOdIg3Rc+UCACis/kFyJn6z/tk=; b=an5WwwQJwdtacYzX
	YJ8cLxGoL+zkrqCAPNMPb1Bo0l+rmin4NW2dGTwQaowfVy1NE/u8anbBNJQff6oD
	9iRQO7hAN9qqHc1egF3y/x3ZPjBYwVfQwVxRYVJ6YFoGl0MKYr3jK8b9nPkhXmLs
	KuItwHvGmLAK88dmjtMkQwQ9A+E+HZzhXWqQF8vryy3K6pARLXxxH+XzQLJ+x+r7
	ukOGjazpt0nJDkepfdt+abjQkWoOtJ6Ydgbib2b+YXAGbKLPXqV5iD8cEOdVsTyN
	vQCKf3YhQZ2fKRHPYFTx4ICxpE3XpO/wHt9uDfI0Vb+9+0uuWFb2I4K4lIDeS0Di
	MvN1wg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcrugy70-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Sat, 24 Oct 2026 00:09:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3662e7a9299so6004955eec.1
        for <acpica-devel@lists.linux.dev>; Fri, 23 Oct 2026 17:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792800595; x=1793405395; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oHnBaDBiTFLamKq5NGOdIg3Rc+UCACis/kFyJn6z/tk=;
        b=RH83sAYL9RU35Alq6eiR2HFHHui925IIREqiuHlJc38qlyzcij5/b8fJJaH1nYnbIv
         qThuQnjarncltgsnC4Pku0RSbZOzy0kzpQOcu6trIELvl4AhmckfSCfbMd2WtO31Oc8f
         J/moXudJNa2lxz0RvqcW4BYl8WuaMB6T0gGQJ/ourQsXlbsk5uBy9xNgrkz1rsW8nWwe
         6aJA0/lzybXQq1ZefLqb2e0R70OOBm4jW706wqzu7k6KQo0uO0mVh77+Co3zWfdVN8xF
         usCdebBHr/5BcoW3Zgd3W3thzZvrpcKNXhJYw3hzYCSaGyEofN0b3rMynSjZXZuQPkjp
         MdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792800595; x=1793405395;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oHnBaDBiTFLamKq5NGOdIg3Rc+UCACis/kFyJn6z/tk=;
        b=sZSCLAJY/OVJFbMKU/o41ETMrXkor/qqQgzX05EKFuqWLZQXRQqI7QaIbvEuXZ69m5
         EgxcFFcq1pySRcyoiWWBobuPoprQ0M88pC6fT8VijW/e9R///MJozb+Hu1bLkyzHr2wL
         0aa04bahQWYNC038lejVRWLOg4GOVg3QZdzh2weAWN4txByIhSPHUYw/KrgUs/Hett/Q
         24EKpR283rf/ScvF+bS4L/Iahg0LDq9Ba+pkub80oM+4j+x0MJzS52WOOM4Daib+hUr8
         ZrRo+z4rzP8FqrVIgUNTmyCmVGMJ2SpZ1OIWjK1g3jT9iT9Bt3hLUsrvMU13SZ2e1ETD
         sXqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzg6HE/luP2/lN31CReP3VVTeuE2hQV0qrUtcYcjuC2yo18OVNC3PiTjEV/Xf5m5C4XO1xdAU1zpyRabJc=@lists.linux.dev
X-Gm-Message-State: AFq9FYK1gN0m9/4XZnPINNhKx1RxFeRWbISD58O9l+PmEuFASmA4A8BS
	Q2gxqcY9BCLa2wfXYZ1kQVuP/TvSIqRl5t9DYonsY2cqsNpCL6EnGtdQuX0UZfRG6X2emxH1Xm4
	ssMCYYGONKD1Awq1M1GR42kHHOmXTqCkv3RqfCRNfA3ppf2LGkD4xdvcmLkGFD5eThLk=
X-Gm-Gg: AYBFou3H/ByUd7o/Uc2sTnA60LkfIhP3ln1TQ2DeXaROXLEF/9+Wld1yS7kKC+lHoiK
	59LkLIw/zt1oALncNPXuaQJsnBPxQi/GqUAiYMNrlQLqN3IR9kdJlp5PGODQN79iGk8np0eRJgD
	5cJ2jNS6qPz4u//5i5GUZkPkJBE6eAwV1wa5ky/2zwWqnwwB/eV2ZzleQGkDlzVWwO+y+c1fKPW
	84+GGTxVTuLcnAiBE+T9HJZL2kvvvEUHyU56330B1UT0GdI6O4rXBJk+WQgzXfaq6kOmeHSgPBs
	jZ2TsZabHVRSFWpJTdmm9g38DhIein1FER+CBqSPnEJ88Rw6Wbo4mvIU/aFifOfpCbTLbwlX9Vr
	qHFtpN4Zwi04UVSTh18lFzF/otVv5j4NPOIUIZgwnW8bAmBbd5gTqTrU=
X-Received: by 2002:a05:7301:1694:b0:366:eda6:8dae with SMTP id 5a478bee46e88-369e84b9a3amr1452604eec.18.1792800594730;
        Fri, 23 Oct 2026 17:09:54 -0700 (PDT)
X-Received: by 2002:a05:7301:1694:b0:366:eda6:8dae with SMTP id 5a478bee46e88-369e84b9a3amr1452555eec.18.1792800594047;
        Fri, 23 Oct 2026 17:09:54 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d93663sm1724701eec.13.2026.10.23.17.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:09:53 -0700 (PDT)
Date: Fri, 23 Oct 2026 17:09:47 -0700
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
Subject: Re: [PATCH v2 6/6] ACPI: extlog: add Memory Error Section 2 trace
 event
Message-ID: <20261023170947.00003e37@oss.qualcomm.com>
In-Reply-To: <20261019203915.2019037-7-pierre.gondois@arm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
	<20261019203915.2019037-7-pierre.gondois@arm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAwMCBTYWx0ZWRfX+cEojnfJ5bY3
 4iAgmH5j5pIWtB3YTfqN72h7+fZ2IZcHLWIuU/V57r9A3ZaZY3TPmghvVfUiQ/jUzOevT02Shwv
 yBrbvlXgC9yDYYAEx5Sk0yyF6SJs4Ws=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAwMCBTYWx0ZWRfX6w5tXnIBPD+C
 SBTC3kqWf4lgOO89NTFV0lSQss4h/9D+ZdC5pyAuTU+jj+gb3LtQZ6GeEouDu9Ch1naFSlAn6n5
 PQNvefmJOgm6W48uWobMX/g62u5hpS7gimqAxgzwvnRdoaePsbFgUpSrldWdfcqNOUntIHRhnPM
 Ss/h0PF46FY4ePlX6drfGLYzh6JBYJZ9yNnkR+sVQaExFtLz7dP43v9y5APbDT3PZ6MQNUGRCcQ
 xvX3R7sKjOgfsGtu5hVcBrzhyL3TGLEiQ5aAVBxOLKFZJrKkHdQ+iMS7cJc1I/fddfbaf315UoC
 Ujx7jrjOgQiDHg4YQHtDouTjYqGPY319fjmjpemFzwiA7JEzGBcuacqar4KNy6DAivxXrhtbHBz
 V9nvwDxIBjQWWPpbP44/50UfwJ2SM9uH0eHuGi03T3H/69e9yZaLur+QMRYx6bOTOzuZqgEjEfh
 5bNi9k843huiH3SwrgA==
X-Authority-Analysis: v=2.4 cv=Ju5kP84C c=1 sm=1 tr=0 ts=6adbf753 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=dQPge2qhURPgFtmzFlYA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: HAynCPgB8TiAbCCtnHO2KRPmEpZf_vBR
X-Proofpoint-ORIG-GUID: HAynCPgB8TiAbCCtnHO2KRPmEpZf_vBR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240000

On Mon, 19 Oct 2026 22:38:45 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Add a separate handling for Memory Error Section 2 trace events.
> The fields of the record are individually printed so userspace
> can discover the layout more dynamically if a new field is added.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/acpi/acpi_extlog.c |   6 +++
>  drivers/ras/ras.c          |   1 +
>  include/ras/ras_event.h    | 102 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 109 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 7ad3b36013cc..9e4d16e06244 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -231,6 +231,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			if (gdata->error_data_length >= sizeof(*mem))
>  				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
>  						       (u8)gdata->error_severity);
> +		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
> +			struct cper_sec_mem_err2 *mem = acpi_hest_get_payload(gdata);
> +
> +			if (gdata->error_data_length >= sizeof(*mem))
> +				trace_extlog_mem2_event(mem, err_seq, fru_id, fru_text,
> +						      	(u8)gdata->error_severity);
Was just giving this a spin and looks like mix of tabs and spaces (with the spaces
in the middle).  Git moaned when I was applying it.

J

