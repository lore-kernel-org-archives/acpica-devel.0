Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427818;
	b=b4zgdCBu/O3i9LSTjNBnHVbVNmXfHjw4SGU6p4V+Eynk35lH4aM+/uKffBssIE0KhL5K
	 B7LghIQx2NQwT05BodbSh0X95dxYhGbdF0v84BZCf9bjsNATrSfXWsCDAZhafrwrBl/yx
	 nUBFaxmkx0LIrGVNWesxYBeQMMHplgGqymONyY8Sfrhes1xyQYLvTUK+qKdFs0memA+f8
	 OBKgpHCpVYmSWxUyOOHctIwtkeuPCuJzhd9mK/Juk1vHqpECRGBKy3WkIdpOUR+L8peR2
	 KmK2n+UDMU8Cv3U/rCYrysYiXYDvY0u7ls8dS5CjZmnuNAwyTBiT/8HLoGt7U3Kx07A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427818;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=uTVSO8ab0jQ/KjHFQURA4S+jRgewRPU6KcTy4l+JKt4=;
	b=cMm6FpRAPJI2b+z/fPSaBnPW0IhoFJySW5mMIXlSaXLZRv07jWtQzse/a8HqwF8S4YPn
	 Y6a2ZGwCGRT7Mhc1L+YI6RPanpP3qRJxfHE/4/PhDIca95w1UmGcO/Gs96YM6VHGh244e
	 BiXGroelmPThOU3sQmZQ27ofEmsFD3k9jUCg9hef46G+c1g+7xtJ5pt67wCzGyge0MWG0
	 0qfv4t8+9wOl1y27BZUOgznle8/Ttrik/XbpfqAD9+TmvKM5ukbwWkU2KS+Bhq6pLnsO5
	 HxJHGxehrAJDcz4LsZycEDFY9R3T2gJ/DbaMSUNtj2LfP5j7GrdQUO/ORILvWdyDtZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=azHp1q7f;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e7ulenxb;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B83606A31A
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 16:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72B83606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=azHp1q7f;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e7ulenxb
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JFPR8a1646035
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 16:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uTVSO8ab0jQ/KjHFQURA4S+jRgewRPU6KcTy4l+JKt4=; b=azHp1q7fFlayj682
	T/VARjrDTiPkCoAzbrEhkv5N4zr9RyByqFCSUaojW32+2aUJK1SkDMuw39ScaRKc
	OnvAmeMXBTQdg/azB3dFJt2fog+F/NLMl9/aubFu74LcqLgotTAuJ+rKPqBvWIqN
	6NvzGdqW8yQ/ru2SjpIwNuGOPnJT+qOPA6NJCVLDqN/NHp3tyEZQlayHYaDfWx4S
	uy0S/gBW7qBIXOj3IBUTkQ5jFZhu8Zz1ngzQ/PnSDPjzx9eDTmFTQgkKkYBS6hzc
	me0gddDb9T/COwyB/Mn8kWfh156r5vLsUaygLKEOgNSYwhBqu65yYt3uvUWtSx4K
	aLcSXw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65j78k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 16:36:56 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3592749a017so2381282eec.1
        for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792427816; x=1793032616; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uTVSO8ab0jQ/KjHFQURA4S+jRgewRPU6KcTy4l+JKt4=;
        b=e7ulenxbS8xGmatkO9ARBP6HwBPSAy7wVkPpE9Jqnyg4w9io02MvhGxwaXH0dJQJ0Q
         w40O1jVgRjWIn0+60rx5T3ceuRGYvLxPnu+W21pHek8Tu2z2VYes1aXHghmXzrA+MQhx
         S/qgkjZgYP4w+I5Ge/1Kl6g7i1FY5niOMNUtHWTVqrp/0nHLUryQUD04JBHetQpbX2p9
         9hLjs7ceie2tfjBremYF+51jgTiEms1hbQ8mxHHRIBxZpRilJksTJYPWpRtmpz8VjEJd
         qJdMJ1+3e9y0eIrhAJ27SqHdRsBnw4gpz2LAjXLZe0DYvtL7uJJv1ZgxsoZpTZd5bX8K
         VAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792427816; x=1793032616;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uTVSO8ab0jQ/KjHFQURA4S+jRgewRPU6KcTy4l+JKt4=;
        b=TkrdiRcJWif3woOzJg/lMuiMjZpEUWOTWlWjPTl30xwqMVdP27M5Nj+t3VKHDpO5pz
         odKh93vobtpjDOorelalWy1pJ25NCHz3oYIUcCGi8LzZEfyJ2rTkjckt7nuNwO3RjMXj
         PLlZ/GbH8HbkeS6jAQxOnDZ13azwtaP/UNW8RzUePi44AurOnk2bcphCIq07/Eh4R/jA
         +/wIRwHEJ1+lMXIEM7TTpzvw/g2vjQLPTjHnlDqfiUFUUtItOQ/K9fCrAN5q1hR/u1lj
         hUfafRpxMeUTmztjg+z+FSWYWoPmqfjv+kA6Tz2h1bgVySWxzb5k4GRJOK52WB2I2qng
         grHg==
X-Forwarded-Encrypted: i=1; AKwUvBzRnghHbFqOoK0XgOttbiS8AMq2ABbovfU0EQVyE0FHievH2Ns6UykKH43Y1xpVvxFJCQ+vuQB4fW6PvdA=@lists.linux.dev
X-Gm-Message-State: AFq9FYKzbDTkjxee1ZVcJkQlH53qGZI64qj8WMjmySE8tsXWyaKENZcK
	khPENWK7+agnFENYnURUz4t8cLBGuNDQEHqlGf4iWFD1mD6uPzFaO8iS5/SBgqtPxQE0sPb2xLu
	DpkSZwCijiDaE3T+phvX5rfBYCR6JpVwWhLqrNDyj8lQyCHEjeokTdP4M9VxGo7jiJUo=
X-Gm-Gg: AYBFou0SKwBktolLT+4r+QDdv/SH36Y+/F2zbEfT0vgTniiUZv6MgnUIGymnTWApdae
	bNb/0aprzxAFKNsLs+tK+89OyKWTLUzffaTEPNDq9pjFudSn1DBMX5Xc54I/ZxDHwFp6bDN32DX
	JLRdj92wUekn+dTSoYNafRERkwO+/93/fsCNBMb8wP51MCg3bMiZFmru+vxvxR1foJGX/htFAZD
	iafa9SAIrf5O6reQLITCWQoE4faBtpwiiV3HbwriiHCN85loMMNNlkwkx8Lrz/DI2U/ZRGHwRNP
	xE9xkdjOY4OT16akcoNsq+KtXE1EeAYoDQc7YsuEbrZyFUpfOLCbllU5j0gYiBwydHUySq457eT
	pbf9XVAwl5HKWyvyoTyPVfnuyvKiQmgLLIt23lQGSPyE=
X-Received: by 2002:a05:7300:f0c3:b0:35f:ab1:4792 with SMTP id 5a478bee46e88-3602d6e460dmr15502762eec.6.1792427815626;
        Mon, 19 Oct 2026 09:36:55 -0700 (PDT)
X-Received: by 2002:a05:7300:f0c3:b0:35f:ab1:4792 with SMTP id 5a478bee46e88-3602d6e460dmr15502724eec.6.1792427814904;
        Mon, 19 Oct 2026 09:36:54 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608219f838sm33529919eec.19.2026.10.19.09.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 09:36:54 -0700 (PDT)
Date: Mon, 19 Oct 2026 09:36:48 -0700
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
Subject: Re: [PATCH 1/6] ACPI: extlog: fix extlog_mem_event build issue
Message-ID: <20261019093648.00002db2@oss.qualcomm.com>
In-Reply-To: <20261019145643.1877246-2-pierre.gondois@arm.com>
References: <20261019145643.1877246-1-pierre.gondois@arm.com>
	<20261019145643.1877246-2-pierre.gondois@arm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2NiBTYWx0ZWRfX6ow6bXDd3Of2
 cLHCXiF1Sxfy9+LaRSpR+RlS21DcSpIaSFR4EIjf8dukNILGbdgTvaAO4Bat2gMa/G8XYcVxlzF
 0ivtj19wXUgj/NoXySOJfFVEvCg3YOs=
X-Proofpoint-ORIG-GUID: Bw-k96-z7zVWdrnetlByW4mYwHYJfEyr
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad64728 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7CQSdrXTAAAA:8 a=crxqeblGBJ-rV0e4J-MA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2NiBTYWx0ZWRfX0Od+jI4cd5g9
 ecaJ2W0jvIkMl3SMeOSoEnkq8h5WtBhbuxHpx1a/z6YFJPAUcCcGovgAxHy9Ft1qsgaFhdUyj0C
 T3fnZ4LETxHOq19N8YD7FbvgBHb8Ii+LdGeoLrHlm2sbisPsak8CeeZoZP0xVnuiHWVGVQ2lOcb
 wXyS9CrSEs1U/5kn/+CDEIV++UqOMzXc3EbxvY5NXPjrVQz/H86B5iKtTa0qOXXW9Rcm2ddoajQ
 tNfbfqbZ186wPV5H3/DgI5NgmI5FhKU7TYIb2gLe8pnA73vqw6058brLiCw/eMBp771hrLBk886
 V+AgtehO+LA17dSVydHeriebsQ0R4g5B3QbKo5A9YclffyBT4Fei9bZEAEIui9KKTns0b3P/Cmk
 rHcPLs+RKS7yfDIdbdjXhKzRAYwjNdlsZs7/06DGjhJNKTQXlDV/17SwfMLQh8N7RMv8N1+Hofw
 EBeNSbUNcoOJD2DCWAw==
X-Proofpoint-GUID: Bw-k96-z7zVWdrnetlByW4mYwHYJfEyr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190066

On Mon, 19 Oct 2026 16:56:08 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> With CONFIG_ACPI_EXTLOG=n and with the following command:
> make -j4 drivers/acpi/acpi_extlog.o drivers/acpi/
> 
> trace_extlog_mem_event() is not defined. Add a extlog_mem_err_event()
> wrapper to fix the build issue.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

I'm lost.  This file is normally only built if
CONFIG_ACPI_EXTLOG is not = "n" so how do you get to this code.
Ah you are forcing build of a file...

If you do need to do this sort of ifdefery it belongs in a header with
the function cleanly stubbed rather than in here.

Anyhow, far as I can tell this doesn't make any sense for
upstream.

J

> ---
>  drivers/acpi/acpi_extlog.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 7ad3b36013cc..e764d61f71ca 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -180,6 +180,15 @@ extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>  #endif
>  }
>  
> +static void
> +extlog_mem_err_event(struct cper_sec_mem_err *mem, u32 err_seq,
> +		     const guid_t *fru_id, const char *fru_text, u8 sev)
> +{
> +#if defined(CONFIG_ACPI_EXTLOG) || defined(CONFIG_ACPI_EXTLOG_MODULE)
> +	trace_extlog_mem_event(mem, err_seq, fru_id, fru_text, sev);
> +#endif
> +}
> +
>  static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			void *data)
>  {
> @@ -229,8 +238,9 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			struct cper_sec_mem_err *mem = acpi_hest_get_payload(gdata);
>  
>  			if (gdata->error_data_length >= sizeof(*mem))
> -				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
> -						       (u8)gdata->error_severity);
> +				extlog_mem_err_event(mem, err_seq, fru_id,
> +						     fru_text,
> +						     (u8)gdata->error_severity);
>  		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
>  			struct cxl_cper_sec_prot_err *prot_err =
>  				acpi_hest_get_payload(gdata);

