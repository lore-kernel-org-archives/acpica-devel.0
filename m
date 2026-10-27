Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079141;
	b=L5aqDKXPqpGK8vB9xaR5HOvmP5Ds1Cytiu1CvpJX7dBijArU54Da8wnmO/XictXzP2hl
	 P67JdtO2u8RQrNNWET9wM+jaHydq9rgJLDQUP8o8VKqY7HZI1/1OiaFBRgMCO+/7eDPIw
	 U6I0GO7zTqR9uj3X6KhL1y0NVNm9bbv1Nuke1AHTmScQuRenPU+i8B1WHV2qqRJ8QAbFO
	 bfHJuHqx4sleRploAxjH+E+hkV4SwhBiiiTAmIQwFUC7KumbdqspBo6ZIaJdeyLI2I5nd
	 IWsvapsVn9OLqCAjnepzaZ2ErwWTuUqApycQH8olU/1zTcdP1gYJ5JGHcuORLbA6aoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079141;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VpHSucyNN1LDa5ApCaatg77B1Q+sqWuq080vIR/b0Fs=;
	b=LAm9C/DTzTLeSh0av+UMO8HAczAUfNUGNRznA1LB4EDIZmN28IJSPl5yritnvN9DGOSI
	 kaOwJyn+OF7SjA9jo+cB7W/AWCZIr7cwu4LbKfa2McJm273RZ325aJZkMYz1VNCY5Hpxi
	 PquoxnMKAFf5lig9syJ+bGf+E+DJ1+DBtkma/b7d/W1EoUSVzjZS1xlhz9yRmUSpQyYVN
	 dwxESpS5xuaERKLh3tVFMhKvVDTXJ4dYBq8Xhzv8tfMINqDnXFq6+KkI/VXGS4UcS9zk1
	 tIjN4zPWXecwy+OldZuMGGZzf8fAs9yj3SSON/ADuSv6K9HxCR0k/3m3ZMLranSXQFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S5u+X6ID;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kIo2zXhA;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC48F606A31E
	for <acpica-devel@lists.linux.dev>; Tue, 27 Oct 2026 05:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC48F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S5u+X6ID;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kIo2zXhA
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R2F5VL1421273
	for <acpica-devel@lists.linux.dev>; Tue, 27 Oct 2026 05:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VpHSucyNN1LDa5ApCaatg77B
	1Q+sqWuq080vIR/b0Fs=; b=S5u+X6IDdAqSFMJ/sWFXego0TywOvH3i2WaDBwXL
	mfDX8VulUGbMrrfYuEcCZ1izjFgzaIrtWd9yxtNA0qeqD7VOsM4ia5hN2HGXcOml
	uTQb9ugVR7xpwkYbLrCl6fiksvHkkO3Dd5ubaWPUyuxgkBtpIiw/h/Di7Lbko6as
	j/UPCPe3ww0utvfbRS54B5/lukNbt4BfwSkRCc6Yr4gmm9g2ggWG1idnUE+APZtG
	OHifiAhrl9MpdF6EFICaQa9Ufp7aMytkMHUCmcpLhjgnZvisX5hrbi6HSsSRWE25
	AksywJxYyO7jNCA0Y1dQSI6nbsRFx2rf/pb1AFANpAhyqQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4sf3w8t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Tue, 27 Oct 2026 05:32:19 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-147be78cd56so2087389c88.1
        for <acpica-devel@lists.linux.dev>; Mon, 26 Oct 2026 22:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793079139; x=1793683939; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VpHSucyNN1LDa5ApCaatg77B1Q+sqWuq080vIR/b0Fs=;
        b=kIo2zXhAUVBO/yfJ3V3mWxlMYRuXNEesLmhkTyrFPlA9KhVlqEruhlitlZunMUuCaT
         aPRdcxlB0HKqZVYxwRKdXvBJw3uChxUfpPGbNtTceyqnXVvuV0qamMop7RuhWmGkKnqE
         kGj57b1d65JavXjMdFYg08JtjW6YCJD2oKOImIyt3KARI1PEPA1+1Uzj53iJQysgneKc
         KDGTHzJHucPPSJiw0bDL0sLQepEpAMnMXcGyvMukhEjFNFlj4HDrqXOToyT88P8TacAS
         VkZVCBQn3+i3nzu9pogNZzVjJHPhKE3epbN181W2KwNFA+Nq1gKfiWQ8h/j6dH8/ROEE
         5oHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793079139; x=1793683939;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VpHSucyNN1LDa5ApCaatg77B1Q+sqWuq080vIR/b0Fs=;
        b=ItVZmtwENduwD5qMmSG3rH9Rsc/Y6pWaws/+ceT4yNmIsuEmWGX8of7YIaoJw8otpv
         nMPvMAgkW+vTxpFY45ucQrVZRvCODro6zcrwgeVYlSuvwo48U/iKuZwgupgbtG9CLs3Y
         O1F6VVmr7Gc1MQxQAYpmO715VmpxLOXNcH5YJ2uYBrUejlRQ+WM2IzFJPU7oA+SXeWf8
         zOSe8cnFt0Mt1Rcn2j0HQhTZlWULgsnKO5QBfMvW2s2CMtXzyn/zSoT152NdH+rxSz+P
         850yWGtqhEZirpG6FOOE1/SOsEcssJcfZRbvEDFbtmKWZd043+/uuNhjxwjB5EiAQQNF
         3QGQ==
X-Gm-Message-State: AFq9FYKYa043PT3vEEfpKPE4CTgcd3Y44HQ1b/Tz6BJ21WEmA4HSb+la
	9f7WfQqpCqFV0L/JmRwzYWw59cRhGNJdP42Zhm9k1MCgHpQ0+xNKF8HtGdBb60mo6o1jILXeygv
	hh6DIHz48F6/A+tspS+PayLbqwmGbNxg9C5KVfcAUMSU3QbQ4P/8GNYF9dORccT2w214=
X-Gm-Gg: AYBFou1+j+fQRKrcaYjqmkFo9l1Jk0lIJL7TFkOgwyGLbrUX+a0KxYA7cNPGc1kgqwD
	pKvloBOjdTcud7zrqR8qjUD/MYQeWbneJjAOeZ1RZrLxE63okb+urRE+e5Km2d0gBivrHbA9ukE
	K8l2OqNCRUu5vshYkw6wKLFoph8W8a4L6E0H6zR4yOVPiP+d6aGr7Vs/rasDRQe45z9P4rg+1xz
	MvqyRbQVLQhdD99iezOpKJnv4iG9bycX414OPsnYopLeXbYazGsIgQi7UasLVAI60NFr8FBaKmp
	ySAGs3oNTiE3zLp4uEzcXxKOnnBDq22ibsgYICFbRL8yA2/CQ21R4Hh5xViyFHXmodu+XSfTNsV
	7EjXNIHvBkAa9Cd8IszrZk5VF4Kkm5Rejcl4t33TQWNY+n/R8MjbRBYr8la8nmfu8uDUBDdAnF7
	Bh6HF4CEOsA/AxMNVrPayfH6M=
X-Received: by 2002:a05:7022:68f:b0:1a4:c892:b130 with SMTP id a92af1059eb24-1a4c892b30emr987457c88.15.1793079138424;
        Mon, 26 Oct 2026 22:32:18 -0700 (PDT)
X-Received: by 2002:a05:7022:68f:b0:1a4:c892:b130 with SMTP id a92af1059eb24-1a4c892b30emr987444c88.15.1793079137877;
        Mon, 26 Oct 2026 22:32:17 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a37c88aasm27316225c88.23.2026.10.26.22.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:32:17 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:02:09 +0530
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        rafael@kernel.org
Cc: acpica-devel@lists.linux.dev, anup.patel@oss.qualcomm.com, ardb@kernel.org,
        conor@kernel.org, james.morse@arm.com, lenb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robert.moore@intel.com,
        sunilvl@oss.qualcomm.com, tony.luck@intel.com,
        zhangzhanpeng.jasper@bytedance.com
Subject: Re: [PATCH v5 3/9] Introduce a new HEST notification type for RISC-V
 SSE events.
Message-ID: <auA3WZf5rLlx4Lve@hu-himchau-blr.qualcomm.com>
References: <20260924073714.1650588-1-himanshu.chauhan@oss.qualcomm.com>
 <20260924073714.1650588-4-himanshu.chauhan@oss.qualcomm.com>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924073714.1650588-4-himanshu.chauhan@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAyMSBTYWx0ZWRfX3nOrI225zcsv
 tk/7Tguu1szxzU0MU9Pyy98XRRjWtnf8xbzMC8tQ/+JTZfFz0NJBYrkcBn8o2XXDjZ/eUke1A/w
 bS7DR3jzzkkR3F4ZtwvsAmlvt3/Hrt0=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6ae03763 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=wNwvQHF-ByPSNzcBtQ4A:9 a=CjuIK1q_8ugA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: OtwtDMBgNz7xRc94qR6aZfgxPll1xlRa
X-Proofpoint-ORIG-GUID: OtwtDMBgNz7xRc94qR6aZfgxPll1xlRa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAyMSBTYWx0ZWRfX6xBCMifv/c6k
 GKn/QgOF/XovInp+GzKUZ1swP34oMyf1rEdkDyIHd2mw2rpdU0GftzmRi4p7yM/QhQHede07GPv
 i0ycr8KXB/FBhR5Q0OjBcKemWniqj1IlQHjyt3bgL8lWnCPy0O49ubwVK3AZEbJZAmjVLZs6LAS
 IK6v4imugBCShE2l8pOlOWLyvGtigBfkbLLnsBMYj7R8uvIRwPTtX9RHUlKjOwKxgF7+6IBn0py
 nP44HEeaqOZv3isfKDfNzGLGp7jUt/IRMVAZXKhvqv45w8HUvkyPoPPOpdWEvQ2evs5zrNaCbew
 snEflXjlIkVye++7uyQ5kGA7s3K6YAd8PjluiIqeJ6YERFdN6yUNURNc7OkiU/Vmghh4kFNecmp
 y5ZfDVnUmWyDveGewAvS5GZegYQskJjzCYoP9aoviAgu+AEQOwqTsMeuefbaW2GhnFIKaYI5EOm
 /ChB3U83oigAYSN4UEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270021

On Thu, Sep 24, 2026 at 01:07:08PM +0530, Himanshu Chauhan wrote:
> The GHES entry's notification structure contains the notification
> to be used for a given error source. For error sources delivering
> events over SSE, it should contain the new SSE notification type.
> acpi: Introduce SSE in HEST notification types
> 
> ACPICA commit f73f39352c1170464afe812cc96b20cc9db1d822

Hi Rafael,

This is merged in ACPICA. Could you please pick it up for Linux kernel?
Once you do that I will drop this patch from here.

Regards
Himanshu

> 
> Link: https://github.com/open-acpica/acpica/commit/f73f3935
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  include/acpi/actbl1.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index d824838cb7af..105fd51f83ec 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1798,7 +1798,8 @@ enum acpi_hest_notify_types {
>  	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
>  	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
>  	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
> -	ACPI_HEST_NOTIFY_RESERVED = 12	/* 12 and greater are reserved */
> +	ACPI_HEST_NOTIFY_SSE = 12, /* RISCV SSE */
> +	ACPI_HEST_NOTIFY_RESERVED = 13	/* 13 and greater are reserved */
>  };
>  
>  /* Values for config_write_enable bitfield above */
> -- 
> 2.43.0
> 
