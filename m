Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792878655;
	b=gXva8M84RZe2lN+ny8FuAE/3hDUpYsd62YwziyDKo7ait1OsAyeNgfy1oPvqi718e+ob
	 kCLypDWY0awI3E8TG2/0RbjtmbziCuTBzlZv9+JMXQSWbBfBMalxtA9bvfn9hAyNGlIo9
	 5srpQlRsDtwVmLsYA25gNCyyJIafIP4Zm1mgNzN/Cz+KNAOqgF9v0CfHuZClo69ojKqNi
	 1/oBTnmksCoNxlXlaY/I2EDnBIPiSGR4UKNrgKzeuOE4M6l3SiiPCXR8t4j9jdTNDDVYm
	 qBxC0QqQbEK0S6kv0ufHzL106um2vwQr5JjO9c/2e/MUYRNIEard51gw9n10YexHU9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792878655;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=BrGoEFHtqBmKXcb+UUckvq2KsUQ5PsLAHRWOdAWZVZY=;
	b=D0dYPux5miSJ1XmISiyiWxNGjCR1jbmtBuzNaZDWrhkXQVumzkwKa6hstWZ9cLWgYrSM
	 h5ifJGhXfT31Pjnb3xb2vgSyy4NMU3GOtR55ARW3/zYttyI5s+TgFs1bD0DSOo1xHqpjS
	 3vOPIjq15eknSwf3nYO+xekpuu1i6w3OJkj52Dp97v5dy4pfwF/VWCZgpOTVdFFX+FYsU
	 cRzb95c59eR/lRj6HjjowUFMOVZNbA9MyXwRejKtd1iQsVaFBmCoEv0jAdD0L9YpKzbiP
	 spZX5+kI9XGUYKuhQZpQnm/bF26SAyqvb+Vi4WWMkRkZUFFqpy8gTwjGHA95sMh1aQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bF5tMPeK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U9qYpkSY;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D1D606A31D
	for <acpica-devel@lists.linux.dev>; Sat, 24 Oct 2026 21:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88D1D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bF5tMPeK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U9qYpkSY
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69OLb4os2705726
	for <acpica-devel@lists.linux.dev>; Sat, 24 Oct 2026 21:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BrGoEFHtqBmKXcb+UUckvq2K
	sUQ5PsLAHRWOdAWZVZY=; b=bF5tMPeKlBMtr38JagLlRF0GW+2Glwt87ZjNrMnh
	F5Sb6vnT+dP/VBXFjdEchNoDnzT1Sm6ssiOSbJ64BXBzFWzoGFoweWNRvQwXyy8P
	PDzkJLpeIcamWSQPmK08XOApNAQE5QiCH9Q3pzLHd49XFjPuv2t5lUnCNvt3avtS
	aNq5dXakjDg6KiukX/pkBrMzxSfLfYtbin+JA2uJGDRyFg2TYg0sAxbVFLx0dRMD
	ddrV6HLFIU9S8PGnDLxpluQAVOIgXEF7V8rA0Mx7lXGe6/9eMH2UA9qfEr97BTMF
	4aHyr9lB3WnowrVEoSZhg1I/KLdI5TfsbOVBPP480lR+Hw==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3huku-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Sat, 24 Oct 2026 21:50:53 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-45a07949855so2301108fac.2
        for <acpica-devel@lists.linux.dev>; Sat, 24 Oct 2026 14:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792878653; x=1793483453; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BrGoEFHtqBmKXcb+UUckvq2KsUQ5PsLAHRWOdAWZVZY=;
        b=U9qYpkSYlxHFEStFLCe0zA8ljCcOqBg1dCZikJCqLWaFLHVNs8coebdGUGGedsotam
         SKkZEXS7tuV6+j2Zo+nm5bRo4uKW2PURD5cX/ZDhgDnhL9wXuopN/6pCZxCvEs0hXXSD
         FiqjY2SuQEHjmmErMZCAQcoqu/cPnMGE3uM2qJGSytyHrxVzPBIyT9CRkn4Y8ytbYW1n
         dtihxatPZHCTk3Qs2Fm46M9oKEaOsScYNup4VY8c0X/MH9SYmqvmM1N2Xzt/4+twQhop
         TQf8otMS7/n9yAwnLPJn82vhYznI++JgWm552JFYLeh8zL9Nwx8JDs9MH28dfBkjvf52
         q5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792878653; x=1793483453;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BrGoEFHtqBmKXcb+UUckvq2KsUQ5PsLAHRWOdAWZVZY=;
        b=S1CCmF5s/242SvFEYktAUAJFJu/LPoZTVTZBBB0qRxbiFJMowybINYBchtukFjSaIH
         FV8kEMImrsKnwg46Q6l3krHqrv050fZnPl95kGFmXRye9QzQPAFvQ9/rhnDNSxd0UCqF
         t+UZe23tW3F/XHFbkZ1tGKGNqn86UMz862W+d7ZVSWElujHkhJR0PY2iubLoccSAn7Zp
         I1PXIekL+WRod6yYc0JIbqbeJfz7rmUKkXvkQAmK4d4KGhlVflm46I9U6MkAcKUtMDmM
         1DFfJ/uZF89h3YQigZ7FpfazSi/38BPURhpDOss6RkiFqbzENHB/Lg7Ann0eFUfthkoC
         44PA==
X-Forwarded-Encrypted: i=1; AKwUvBwc4RsT9wx2uL6KpCJnuj/+AFIV8zYdTfzsFkQEC14FpRRXxdeeQrqLBlpHwVl/h6CMiRL5vGcWtf0PU+A=@lists.linux.dev
X-Gm-Message-State: AFq9FYIlZhcZBSrcLl3n/l00aMnRzlCSHlDu9P8KyYtuLSPIvgV2YQlH
	GhjxU3qSmFmP4x5TCjB+i0lAfqMqJXhakMjQamlfrou4NMlr/FbGLLI467npyAO9x1MYvNQpmnF
	3zyxjngUt+3mx2NpJ/SVTNdfRg6xsjEMBoeBIascUg2tC5EypW5zjrCSzOmogVJ/uZoI=
X-Gm-Gg: AYBFou23gN/ZhpUJkE66m8BKyOjtjVTWGOhAeQJvl4d4RFpTu1/wYCK+O8J+JSDJj7h
	IpnWVEnC5dPX3WaxR4rDQmy35HweICwAKq4QhxwB3oGZfrZ7axyayAar5CCO+D/210GQO1HcK1o
	DeffunXxXioU2svI22V53SZ6tRQ1hjE0quoLQfiGLBnkPBwLCIytupvg0YS+TLxEFh7qs/E45Rs
	qaeuDJ+YZM6/AGGOQN+YaoIAOnaIR+9tWo7XR6x8/3AcUG4gmWuYEFGrfUSWoPRWHkMgQFH3ex7
	tjFJERQOKkAQZ1GknamwEN5LICLiaePrhuhtZqQIP1P0S+tH17rDQU9WnAB+yGoIujeQLh8Y7IR
	ssjoL1Z8v52fBA9g74KFchlbZmpJup43tupNlWIpzS7PfEBNN1A==
X-Received: by 2002:a05:6870:a2cc:b0:48f:e107:317b with SMTP id 586e51a60fabf-4a83f5bda63mr1957128fac.46.1792878652718;
        Sat, 24 Oct 2026 14:50:52 -0700 (PDT)
X-Received: by 2002:a05:6870:a2cc:b0:48f:e107:317b with SMTP id 586e51a60fabf-4a83f5bda63mr1957110fac.46.1792878652228;
        Sat, 24 Oct 2026 14:50:52 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a84315c274sm1783227fac.9.2026.10.24.14.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 14:50:51 -0700 (PDT)
Date: Sat, 24 Oct 2026 14:50:48 -0700
From: Ashok Raj <ashok.raj@oss.qualcomm.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Hanjun Guo <guohanjun@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
        Breno Leitao <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
        Dan Williams <djbw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev,
        Ashok Raj <ashok.raj@oss.qualcomm.com>,
        Ashok Raj <ashoraj@qti.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 5/6] ACPI: APEI: add separate Memory Error Section 2
 handlers
Message-ID: <at0oOH1Pma1MvFlU@hu-ashoraj-lv.qualcomm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
 <20261019203915.2019037-6-pierre.gondois@arm.com>
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
In-Reply-To: <20261019203915.2019037-6-pierre.gondois@arm.com>
X-Proofpoint-GUID: M6u-qvMYUn8pEsjGKPTgxbZovKden3o3
X-Proofpoint-ORIG-GUID: M6u-qvMYUn8pEsjGKPTgxbZovKden3o3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA4NyBTYWx0ZWRfX/ocebmow5asa
 q+QUBXf93cZP19VTwkEfp/dFy/f2mBPHrPZ5/8X3Btjw/+j1FTn1pLqdDJFlBOyBM1S/k61iihc
 b5PNjEYFuUz2VUkN5p6njACYZWaUjxs=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6add283d cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=xNf9USuDAAAA:8 a=7CQSdrXTAAAA:8 a=SBTCx-jMH1C4PCkex7IA:9
 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA4NyBTYWx0ZWRfX7g8wPopCfLvS
 KaICuc0wIjR9+dBqpzBZlXZRK7dYekQ1sc1Rfpm6G4PlnS6T6hS58H6HY/g69/q4PDd1kWPF5km
 /tRqlzcFfdsvrPYtO1Uf/lncTqzf8Gwo+LCjYqbBX2Hq9yHbeS2eqwgRI6rd+P+MfQcZ3q+IZHO
 BK9yJvxHmM3zSRSIFIYVx7uh7kcjkaUDq31rXC1N16FhNLsvIBFupYEz2iHSBuU4LuLJ9Qp1k9h
 urgLYVvQsAIKV36kyeQtDscW5lZVGZsXqIox2R2Y8aalu/ziyg0dN2GacsvjPZFyQRIYPm2XARU
 PIN2/zlPMga2j6PLzbA255C9AUXrKM2b+8Pf6fwdHEgeCjzd373XKDseV9MD2uZSUogmnDU4k0p
 9i8LDcBd0LNCAdsCcei8ICPEUGse+7BtWq8G6nPHcopdF+htsoOn8zSgbboJaIIwxh+wrfeAqek
 qgWuPzRtEMBJREuklWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240087

Hi Pierre,


On Mon, Oct 19, 2026 at 10:38:44PM +0200, Pierre Gondois wrote:
> Add dedicated GHES and EDAC callbacks for Memory Error Section 2
> records. Use a separate GHES notifier chain so existing consumers
> continue to receive legacy memory error sections.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
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

[snip]

> @@ -952,6 +977,16 @@ static void ghes_do_proc(struct ghes *ghes,
>  
>  			arch_apei_report_mem_error(sev, mem_err);
>  			queued = ghes_handle_memory_failure(gdata, sev, sync);
One issue here.

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

could this accumulate queued with |= ? 

queued describes whether any section in this GHES status record queued
memory-failure work. The synchronous GHES path sends SIGBUS after the
section loop when `!queued`.

For example, a synchronous record can contain an eligible legacy memory
section followed by a Memory Error Section 2 record without a valid
physical address. The legacy section queues memory-failure work and sets
queued, but the Section 2 handler returns false and this assignment clears
the previous result. ghes_do_proc() then reaches the `sync && !queued`
path and sends SIGBUS despite having queued recovery work for the earlier
section.

This series appears to be based before the queued accumulation fix [1].
Could the new Memory Error Section 2 branch follow the same pattern?

> +                     queued = ghes_handle_memory_failure2(gdata, sev, sync);

should be:

        queued |= ghes_handle_memory_failure2(gdata, sev, sync);

Otherwise, an earlier section can queue memory-failure work, while a later
Section 2 record for which no work is queued clears `queued`. For a
synchronous GHES record, ghes_do_proc() will then reach `sync && !queued`
and send SIGBUS despite recovery work having been queued for the earlier
section.

Thoughts? 

[1] https://lore.kernel.org/r/20260925-ghes-queued-accumulate-v1-1-df50553957d4@debian.org/

Thanks,
Ashok
