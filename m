Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437194;
	b=HQFIRhjmA4KNn4SGQwnv8SGV3uHyJD+R3isYp52+Gzn2JOPV35nyhAfxX2JtW6ljtEYm
	 ++IBt+7mHsNsHXZTyLWjOxfNWZWYY61LNVTGvNZR9WHxo7YqFFp5tev0PjSsBZlXVxbu9
	 X8pIJWmsBOYtLDx13Ln8pduxJYNvkx2pzskpSCLKf5Q4j6bYcpwpLJnl8Z/CPKsGe9YKD
	 ya8qNyxmO014scpgDSOXluGwdOy9LAC7KJWYbhsasTjJb22j5PMgUNemXM9lx0R1mslc8
	 TLdhA01IDL+BNeq+/XRUe0ODRShLKz6RSXqrrJw5P03uvZAx9NDpr/KStCQIJz1N8dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437194;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jS+Bq8s7EUDu4GSq8520KkV5KJNW6foagnSih0NwpR0=;
	b=g7pRFOJzLMWEM0xsJji+Bcij6xs3cYXU0wHHA3EpARsRBX5rzE3Dpn1s0pXb42dF8gqD
	 kC88AynjUZk/gM0ZVsx89dyU3nRlqX4mRAehmSp6+3nC73UxblkOsRL7h3LKBEqFQUTLJ
	 veCbkkFM9lUU9z1FBLtRLMiLpdyU0JqPAllvnPr5PayVlkx/A79rHGITmpCbkwlTgqj46
	 uolIVSQijthR6TMnpLaCC4vIe+TZVnD4ojRmq0Moy3fAgSB+N0PDD5I5C1GKVey1OmrZe
	 ouJJZ7KY7/UWmEVpeaPNjKMW0zohxOJ9Vzh9JrdMqJq+wR5eyQHYLOEK4wWe2WenGZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M0fMUZ6F;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bLoblojc;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A5B606A330
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 19:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1A5B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M0fMUZ6F;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bLoblojc
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JJ5ss13298689
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 19:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jS+Bq8s7EUDu4GSq8520KkV5KJNW6foagnSih0NwpR0=; b=M0fMUZ6Fb4oNf5TM
	zLzNK2cgNvEfObJYq99kohKPazYP4z8CkhpecWaWG4uSRg/lDykGnxTofvOJFGij
	6is1UhUrjNIFLkzLYxGvLgo7s3t3+ymqXPoigLv8NYw+gIBI26wSaQofbhJO//Xk
	MozR5BsMBJ/nYXNnm68HrQpH9gKFKePu0KbV341ILBBDE/A2hKbmUOjIXFXJVUaj
	D8FEAJkg0Hvb0l/YgQtt3EO8IVJtweE1cWzips2vKQ8gh94OUoXisX85WicpcHZw
	ql7bYEGXh4GI+31H2fl2IDU/DEn1sq4QlnIW0AnbBxaF/NEQySYRHPltk6LadYNt
	hPasyw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdkmfhn85-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 19:13:12 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35fb6be0f9fso6331404eec.0
        for <acpica-devel@lists.linux.dev>; Mon, 19 Oct 2026 12:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792437191; x=1793041991; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jS+Bq8s7EUDu4GSq8520KkV5KJNW6foagnSih0NwpR0=;
        b=bLoblojch+Cd9Vb3R5De6vaZr4mY+nq9uUS1GUyXUQ5HeySZdnkPvmY+jrmKiS3V3q
         +nGkhysbTNgl73yE3xttgp7mipyuf5QHDAmD0fdPOOwqAjwUtOhriZwRF5uZ2O7gJhGI
         eDfNmMTA7JJRRlmeWFWeKpasDhvkTdwElG6NySLJKRsFC8mBcgCrn6CXhKeProZbt6eA
         Mfrk2KFHQF6Q82+qz7WNCVv/6/0KCziKRSNV0z2PVL/1ZL4kVGPj3yPtaw++Wx8eDIcC
         uIiFm/H7IW8mHp+rICT7uTNhSpb2EyjjF5oKRwkQFWJJssZkWn9Lj3iE2qum2/y6MYOy
         Akmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437191; x=1793041991;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jS+Bq8s7EUDu4GSq8520KkV5KJNW6foagnSih0NwpR0=;
        b=bMOqegop8QAixT9MPqKjQNS43gLiWjUZjoBY4RihjeLhFOizCv/U255TWcZ3VISDK9
         k9uIQ5rH9YbC5NsmWQIIh/cD1WJjIjQ7rhM7L1yfwNwrklVjQsoSHTYzwIZJ2gPLBGLp
         pBQ7dSUbuVHVzibd7RR7yF59V5PwYox6DlCuz7o0c9+JGMSsEvCTYFq8nvP65c5168gp
         i/MCZTzaIG0sIhFI7aiF1qdMsxH9C8nd4gKBemNggUhGFAWjrQLQej4G8LnHhZgUOSwx
         CBH/CITiC4pV7uB4T0EOllbTs/YsBrFg/XlgIgXUAl8jDar1FpG+rvZr8XglhgZ0EG6L
         h+uA==
X-Forwarded-Encrypted: i=1; AKwUvBzM9YHXbe6usotgcCgnW8WK1HMBEMQvuGKs8QfZ3x0xRk4tI2Gx2EuIXK6h4t5QnwKq7vwDbd/fwH9BSPY=@lists.linux.dev
X-Gm-Message-State: AFq9FYIvNUZbIifwUlwMfavCzi3qPzz2WpZRBW23yrikOpdiZaMHTQci
	OR4bAy3ff9/bm9heNs/dCFW6s5JxoOdi4QmLo4/+hnpOhj9Mi5WfskNj8AYFhT4Tz7YsFcPs0Fu
	py4AmKf5CCcVIk5GU8OjwN5yOcegetKXw6yC+pR2Riyyvk8Mu8CqINNlWfmA9ArR1bsA=
X-Gm-Gg: AYBFou3s8NDj3SiDJdVZpI4wdiphieyBguVRZfBnaIhtnHiq200MF5UoDXCnj+1CIhZ
	Vm2XXd/nbyAc9eEuAIu3I0O4YpRFmRPM5YdBiXXmimGkoRxfjV3CX28p+mK5y0k+AxwyDx7jg9w
	rN4vvkU7M5ONFlCEbUK3YOM/UXIP5TNKrFsw10KP57e/gl/2dwpsw32R+HXWSgnHi12IhKW8gyG
	OpGvsLEyGEhpgTxFn0MsAkQESfFlH7KOtM/lVJBoH4HoRayqvfNvanaa0MVvPvO+6Rd7AUM1c/o
	hpR4rKrjMWI17IUyx3Efq8YFI0U6nK8KWzRgvFUq+cPZlh0iPgqjuIRqeffm5ZJIVWsU7KM1Kn0
	WDeDbnZUaW7ch7u9zasOXhLrH1SPQJzr4MAASpcHF8A==
X-Received: by 2002:a05:693c:87ca:b0:35b:c1d2:eab9 with SMTP id 5a478bee46e88-361a2e3d3abmr11230584eec.39.1792437191378;
        Mon, 19 Oct 2026 12:13:11 -0700 (PDT)
X-Received: by 2002:a05:693c:87ca:b0:35b:c1d2:eab9 with SMTP id 5a478bee46e88-361a2e3d3abmr11230522eec.39.1792437190619;
        Mon, 19 Oct 2026 12:13:10 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608258aa66sm42939717eec.20.2026.10.19.12.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:13:09 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:13:05 -0700
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
Subject: Re: [PATCH 4/6] cper: add helpers to handle Memory Error Section 2
Message-ID: <20261019121305.0000433f@oss.qualcomm.com>
In-Reply-To: <20261019145643.1877246-5-pierre.gondois@arm.com>
References: <20261019145643.1877246-1-pierre.gondois@arm.com>
	<20261019145643.1877246-5-pierre.gondois@arm.com>
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
X-Proofpoint-GUID: kZcbPK2RZJjpz7QNqLfrT3RLWagOqc20
X-Authority-Analysis: v=2.4 cv=O+isLx9W c=1 sm=1 tr=0 ts=6ad66bc8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=sh56xHOc4yr7ZHq0_TkA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3NiBTYWx0ZWRfXyoIEqiFHRMYT
 caFjzNd/bdySEh0lhHZjqT5bzQXEkVwKENDF/lMiE+MCqDn4iWvsicdGP9jIDu6sULO2WnefoWc
 b5EHC+BTONtMnBuNPpd0WUDBbGJrzbQU+za4mztvBIB+ulEeJpXKL+GqvZRoIobmACAezaNx82g
 L9BdBloLKjlKFbQ596C/U+wLQjGe6oo5rXAIBt/kmu5uws91lQSMfNMQLyAQbi5s0JqVvo3VEIO
 oMVlVBWvq6iDmrk6MeQPAD8LIzEMQpmz71koMls+F9+8b9CFrPVVifec7H97zT9SkyzOfQEn/Ep
 y9AFgpsmTDt1C9BYs/LSCG+fu+YvJC217Wn636sTev3Zjyju+bdoR2/HOCdHeMvC0/XGm7pDY9K
 Vdn4oO8oa/kBWuIzxf7gUsmG+lZx0gDkYc4ZQZhCVfaI2jh98nJYs9Ekueln3UW3UNuQwSc+Co9
 mgD02/JIEtYWiIxy5fw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3NiBTYWx0ZWRfXzKuONCsWYgHM
 OmZhU9GoEwEC77F7xypBMtfHgtvZpd/i/FMO789LP1YX/4LK4WgmIft1UgTMCEP9ZElu+CJpyZ9
 LXF19U9HuwREu9qFFfM/Ikm7WJv3co8=
X-Proofpoint-ORIG-GUID: kZcbPK2RZJjpz7QNqLfrT3RLWagOqc20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190076

On Mon, 19 Oct 2026 16:56:11 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Add separate location and printing helpers for Memory Error
> Section 2:
> - cper_mem_err2_location()
> - cper_dimm_err2_location()
> - cper_print_mem2()
> 
> Similar functions/logic exists for Memory Error Section (1),
> but require a compact version of the record. To avoid relying
> and propagating a non-standard record format, the new functions
> diretly rely on struct cper_sec_mem_err2.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
A few comments but they are about spec confusion or trivial.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/firmware/efi/cper.c | 108 ++++++++++++++++++++++++++++++++++++
>  include/linux/cper.h        |   3 +
>  2 files changed, 111 insertions(+)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 06b4fdb59917..5c9b832b67a1 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -445,6 +445,106 @@ static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
>  		printk("%s%s\n", pfx, rcd_decode_str);
>  }
>  
> +int cper_mem_err2_location(const struct cper_sec_mem_err2 *mem, char *msg)
> +{
> +	u32 len, n;
> +
> +	if (!msg)
> +		return 0;
> +
> +	n = 0;
> +	len = CPER_REC_LEN;
> +	if (mem->validation_bits & CPER_MEM2_VALID_NODE)
> +		n += scnprintf(msg + n, len - n, "node:%d ", mem->node);
> +	if (mem->validation_bits & CPER_MEM2_VALID_CARD)
> +		n += scnprintf(msg + n, len - n, "card:%d ", mem->card);
> +	if (mem->validation_bits & CPER_MEM2_VALID_MODULE)
> +		n += scnprintf(msg + n, len - n, "module:%d ", mem->module);
> +	if (mem->validation_bits & CPER_MEM2_VALID_RANK_NUMBER)
> +		n += scnprintf(msg + n, len - n, "rank:%u ", mem->rank);
> +	if (mem->validation_bits & CPER_MEM2_VALID_BANK)
> +		n += scnprintf(msg + n, len - n, "bank:%d ", mem->bank);
> +	if (mem->validation_bits & CPER_MEM2_VALID_BANK_GROUP)
> +		n += scnprintf(msg + n, len - n, "bank_group:%d ",
> +			       mem->bank >> CPER_MEM_BANK_GROUP_SHIFT);
> +	if (mem->validation_bits & CPER_MEM2_VALID_BANK_ADDRESS)
> +		n += scnprintf(msg + n, len - n, "bank_address:%d ",
> +			       mem->bank & CPER_MEM_BANK_ADDRESS_MASK);

I guess this makes sense. I couldn't figure out from the spec if there
are rules that say whether expected that VALID_BANK is not set when
VALID_BANK_GROUP and/or VALID_BANK_ADDRESS are set.
Safer to just over print than read stuff into the spec that isn't there.

> +	if (mem->validation_bits & CPER_MEM2_VALID_DEVICE)
> +		n += scnprintf(msg + n, len - n, "device:%u ", mem->device);
> +	if (mem->validation_bits & CPER_MEM2_VALID_ROW)
> +		n += scnprintf(msg + n, len - n, "row:%u ", mem->row);
> +	if (mem->validation_bits & CPER_MEM2_VALID_COLUMN)
> +		n += scnprintf(msg + n, len - n, "column:%u ", mem->column);
> +	if (mem->validation_bits & CPER_MEM2_VALID_BIT_POSITION)
> +		n += scnprintf(msg + n, len - n, "bit_position:%u ",
> +			       mem->bit_pos);
> +	if (mem->validation_bits & CPER_MEM2_VALID_REQUESTOR_ID)
> +		n += scnprintf(msg + n, len - n, "requestor_id:0x%016llx ",
> +			       mem->requestor_id);
> +	if (mem->validation_bits & CPER_MEM2_VALID_RESPONDER_ID)
> +		n += scnprintf(msg + n, len - n, "responder_id:0x%016llx ",
> +			       mem->responder_id);
> +	if (mem->validation_bits & CPER_MEM2_VALID_TARGET_ID)
> +		n += scnprintf(msg + n, len - n, "target_id:0x%016llx ",
> +			       mem->target_id);
> +	if (mem->validation_bits & CPER_MEM2_VALID_CHIP_ID)
> +		n += scnprintf(msg + n, len - n, "chip_id:%d ",
> +			       mem->chip_id);
> +
> +	return n;
> +}
> +EXPORT_SYMBOL_GPL(cper_mem_err2_location);
> +
> +int cper_dimm_err2_location(const struct cper_sec_mem_err2 *mem, char *msg)
> +{
> +	u32 len, n;
> +	const char *bank = NULL, *device = NULL;
> +
> +	if (!msg || !(mem->validation_bits & CPER_MEM2_VALID_MODULE_HANDLE))
> +		return 0;
> +
> +	len = CPER_REC_LEN;

I'd move this to...

> +	/* SMBIOS handles are 16 bits; never truncate a Section 2 handle. */
> +	if (mem->mem_dev_handle <= U16_MAX)
> +		dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
> +	else
> +		pr_warn(FW_WARN "Memory Error Section 2 module handle 0x%x exceeds SMBIOS range\n",
> +			mem->mem_dev_handle);

here just because it isn't used until down here.

> +	if (bank && device)
> +		n = snprintf(msg, len, "DIMM location: %s %s ", bank, device);
> +	else
> +		n = snprintf(msg, len,
> +			     "DIMM location: not present. DMI handle: 0x%.8x ",
> +			     mem->mem_dev_handle);
> +
> +	return n;
> +}
> +EXPORT_SYMBOL_GPL(cper_dimm_err2_location);
> +
> +static void cper_print_mem2(const char *pfx, const struct cper_sec_mem_err2 *mem)
> +{
> +	char rcd_decode_str[CPER_REC_LEN];
> +
> +	if (mem->validation_bits & CPER_MEM2_VALID_ERROR_STATUS)
> +		printk("%serror_status: %s (0x%016llx)\n", pfx,
> +		       cper_mem_err_status_str(mem->error_status), mem->error_status);
> +	if (mem->validation_bits & CPER_MEM2_VALID_PA)
> +		printk("%sphysical_address: 0x%016llx\n", pfx, mem->physical_addr);
> +	if (mem->validation_bits & CPER_MEM2_VALID_PA_MASK)
> +		printk("%sphysical_address_mask: 0x%016llx\n", pfx,
> +		       mem->physical_addr_mask);
> +	if (cper_mem_err2_location(mem, rcd_decode_str))
> +		printk("%s%s\n", pfx, rcd_decode_str);
> +	if (mem->validation_bits & CPER_MEM2_VALID_ERROR_TYPE)
> +		printk("%serror_type: %u, %s\n", pfx, mem->error_type,
> +		       cper_mem_err_type_str(mem->error_type));
> +	if (mem->validation_bits & CPER_MEM2_VALID_STATUS)
> +		printk("%sstatus: 0x%02x\n", pfx, mem->status);
> +	if (cper_dimm_err2_location(mem, rcd_decode_str))
> +		printk("%s%s\n", pfx, rcd_decode_str);
> +}


