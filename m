Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88A3EDACB
	for <acpica-devel@lists.linux.dev>; Tue,  9 Jun 2026 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993659; cv=pass; b=iGHjSDNgX3WLWxzM/tsLZb3xEHdBskw0Obwg26Xl8WganAHkHp8Ui7HO9H/SYbTQOaECNgZvg0E6p5nXT7XnWbgawXe87L6WO4nxGK5qEhsz5Uzfz1ww/McAJwNzC6swlp7GGI4MAKPZ+sfB957f4ml8IgtE/5LUk15dtPYrycU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993659; c=relaxed/simple;
	bh=1yq6NLeTXKn2qxQnfkuIZx97MltL8Uj5Dvhjzl5v+/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/1x+VzpVAKk6apjTkHvgisoEr1qrXPiDsH9V1T/iNYJMNJlNNGpu7MBMLJOhNAvzgD4oiYq03gpVar+EPZIbRYEe6cmKs+L58gO7jZMGQOmxnZCh1M+OjAHSxZMNdpIhFbRzkB5ZNp9Lx5NaiHJTEOScZvxXvGHG+QWwnm+Zww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a9+ay0tN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f1jpaR9S; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a9+ay0tN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f1jpaR9S"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rZ2h1923143
	for <acpica-devel@lists.linux.dev>; Tue, 9 Jun 2026 08:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=TFkSAnnuzu4vpgPtCevU9biue3ziTEZcQbHKJrTFV8s=; b=a9
	+ay0tNlJqbfko3akJd6ZxVnaymemUIb0U4vMaEBJicsXy3mKJoGs4l9LMFjwToas
	Ojj+KBqwFXM0pWv2Z/iXLzdwRNb1/8tZv1AzHBofi5WkV0a9WQWg9u6oc5yAvspm
	S3Ie84Q1u7WKdC7oRtNE4tTvTabbfG3i3Kdxv1IH/KxuRbJSqQ5PPfOFmISACeVt
	Ro//6yjwkHHPgyWNQcJKzVSqGuX1CorJ82ERYhwgBJZtuycC7QT4QAPAJ5tiqjQY
	/BAW39z9JHJ8s+kZOnEy3P+UypuFrtR3/ZP/k5EDax/A4OXikUiXhFgI66oZJ4kb
	8pBNoBGn22Lb+NeK2OpA==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epee4g8hr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Tue, 09 Jun 2026 08:27:35 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-66049ff89c9so3471678d50.2
        for <acpica-devel@lists.linux.dev>; Tue, 09 Jun 2026 01:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780993655; cv=none;
        d=google.com; s=arc-20240605;
        b=R1d17cl9bX3bit4wk75CLsZP1dWmPcvJNBUEdaenggCesUtpsWYpLLDCNdw51pM98r
         luMVYwEIN/ABqNd2EEVFm8AEer+3x5k1KWF6N+jtYQ0q4zbZ39TYHYa5w8K6V/aOTE5X
         QQ1wPEbh7BCd46m8IWvgt4K+8R4Ru4d4cCNMSYeKfL0RmM/GPTThZ1DqZAT/qAMD4jjY
         bL4ns0fwInrdPdyynSBm3X+qJNuPee5ZrNIMndBSP7ql+tN0JlhwVqb3IkZbH9Jl4ovd
         oWhRi9acZg+99CzcjeCWtfMASUTsalr5JqzEPKz97++VnpU/Uh1wUsbc6+PFw4VukkEb
         IHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=TFkSAnnuzu4vpgPtCevU9biue3ziTEZcQbHKJrTFV8s=;
        fh=HUcWskX6F0G4eFJAYHXx4F8HHXaWpy5dDid7oMzxN+8=;
        b=CCcvZlYDavCoPOEfbYDAoxqPmQnwlU0gBmP6zlYcugOrDVm6C8x+PA/ZVHMWhJKE6x
         qR6KXTlRKlNvLQdu5zt3MGqewdlUPB3YZeZ4e3soRPN2/HYICk4c1Meftc/0GE47TTTR
         csk5hdtQa2UQeec6nsgeOKijo2eeticJ5gIB8ZA5I96EM88MMPMw3hWS2LBK/gecKAhJ
         ChSm0lf40eHdVX/P4m+aJ1NxIQvfF8tRiqIGZpSfe+v9h1of+IhT6zaVEM3yc81ubMGE
         7ZcHK0dmfnaFLPvCkgx7hP2EdPGh/KaS4RkTn7eH0uoHRGAF6+uYsNgwpC07qHa7/nhN
         tgSA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780993655; x=1781598455; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TFkSAnnuzu4vpgPtCevU9biue3ziTEZcQbHKJrTFV8s=;
        b=f1jpaR9SXpNrUURox/cfCZZ/8q94aoBvxOq9MJjXns+CWECUvVUln3eNXi4KGNJ+Kr
         7ayPRkMrPUZBcam5+FCn659Yh3Sn2YrPiVBwCDoSnzUgHr5iq1AgyXWTvynbKCLw0FK4
         hbvBWY4BfZScpzZn32p/FIznUodj1Vl7iPyg4FzeQRzH13fHRfdXmy9Y3+8m7ATraN6D
         t6qaJX6GlnkntOdw4BGpwn8VpS8K817rBdfRgqG3Pb1MF0UqbB6sfvGRzXzut63/ZFef
         WwMZEm0eK4908yMRpI2Gf/p7AvWEHKi7N1eXdaOSPICQ4YDxCNsElqJTQghzFxrWeeeU
         YuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780993655; x=1781598455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFkSAnnuzu4vpgPtCevU9biue3ziTEZcQbHKJrTFV8s=;
        b=TIyGbDFBlZTOZQefPjrwYg3P4PSPLgK8fSU1NoWxIqqK3wWWw4NaVZda7hIklUyEsv
         5xSIssSAGsBTwDOcG6ynMg3Vley+sfdYFQtxttL9XCSE7vzSAfBrJFTPXQmyrPbpCP/X
         T62VX7ue0BTwuAaembQdAjSNZw1O6t3ieJ5SCjtNs7JnqYTsYvImnnnHp0vC0cwKylD3
         IYwb3L2sOpQpJ7CzQCI/B2YUOdt2r/joeiivta7mc6ZMya88pckevDPRw0uSZxrVwTrJ
         zNBBdVNzlQgCO3mgwHKLMpzh9MvUO0WHDk3dfUAeoF+QF8J3w9qtoA0LqZ/PL/im7MIN
         l06Q==
X-Forwarded-Encrypted: i=1; AFNElJ9N+FtKlwViGWRWsfzdo3hN7R1jqG0lc9FnGf2Tqoo+3uonQSgJr+jPOTEGvQgtA5wyc0n9A6JmL1AvuXk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yza94N20mJjcvWP7ZPMpHv5kO0c/PJgv9RgLA1/sXp2GkAL4s2i
	XCOLntyCOMFU+v3DgxqLCnUTv9KzXL/8oo917PxpEktsn44j93oEMXfbcxc88wLww2mmjsDOuw3
	9RdCKiRd6dgZP6i1v3gkcGQelS7DprXl1uuMGQMROwoAnfXq4eCfetDg+0AYXiHEfk89SJuLJ4F
	xFtTpIltNNkoykc87JuPEX0GCnbxjSewsJMGdc9OH3sg==
X-Gm-Gg: Acq92OGvYL06a6BA9ikx/ROwJnyNxsEkqza5cwVwHx/KlcnTtZSMCtOmtESFY9wpXWu
	G4VKk/Ng7fm4AlALakRUmNap1grOZRZrdrSJWJRtkYNnVrUOs5jWrCoSjGrpB08A3L1OTYN4xqJ
	TnceoDyLXtw/wX/L1rVwUaf8UObuDcS3Jsm6QpkvwQwVZpLDacwnBQyH/6uPZnrxVo91cY/P7FB
	1Bmy69+0Qla04o6cQ==
X-Received: by 2002:a05:690e:168f:b0:660:ea4a:153a with SMTP id 956f58d0204a3-66106f4d882mr16311107d50.22.1780993654670;
        Tue, 09 Jun 2026 01:27:34 -0700 (PDT)
X-Received: by 2002:a05:690e:168f:b0:660:ea4a:153a with SMTP id
 956f58d0204a3-66106f4d882mr16311086d50.22.1780993654159; Tue, 09 Jun 2026
 01:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com> <20260513084325.2176952-8-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260513084325.2176952-8-himanshu.chauhan@oss.qualcomm.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 13:57:23 +0530
X-Gm-Features: AVVi8CfQL2ndPqpNPolnsL7-JCyoUBHFD0_-DueGPSQTd6Hneha3xqLb-1My64o
Message-ID: <CAB19ukHDB6viGCM7FURuqsR_4E=bb8nd-z-Y32+mgrdBT7JB-A@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] riscv: Add RISC-V entries in processor type and
 ISA strings
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com,
        anup.patel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=PIs/P/qC c=1 sm=1 tr=0 ts=6a27ce77 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=_3BUxsq8Yho0MmvbAbQA:9
 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-GUID: Dj3JQud5LdC133-NPO1xaiRAlzyIDdjf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3OCBTYWx0ZWRfX2kMLTOWat3CF
 voV2vPN9uSmb5NDkwo5kReZxrVSPhaW5v2AksOMYeaJ1fz8NlfSTptEVsjFPeWpZDG8cIGduLxN
 eYAZ6ZQP3tIgj0K2X7tHN0QdRYg1lL9GHcooF6kaih4qFNvDz81V4SMrfFSH0KbyCnYg0yenmcu
 TlUIUPa8SD+n96XrVAB6wU9fZ6Zt3qyGPOpOI1oJvNcH9fJ/eCglRv8k2XSypPnNxyTL7V2DVdO
 sqwcBgn22BTnwAo2D+apfHM6pfl2m256W0KmAavgYoHpQdpZaqc8dbq7Q6kQbfcN2GTB8rSvxVj
 BoFwC4Ro1KkrH05q22ifj9RMNZ4qPoWnAinThYNn2ywt6X1J062SOW4Fa0Vm31DQ6cmc+MeLZ0I
 N9SDQPVdtYS8+s+UvTWTF94kkWanu1vXiEdIUqxcB53iXhAILsSCmhWYFBcITYTs9CXhVyRUsJa
 4/Z1PrmW+QvC5W8hJ7Q==
X-Proofpoint-ORIG-GUID: Dj3JQud5LdC133-NPO1xaiRAlzyIDdjf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090078

On Wed, May 13, 2026 at 2:14=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> Add RISCV and RISCV32/64 strings in the in processor type and ISA strings
> respectively. These are defined for cper records.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  drivers/firmware/efi/cper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 06b4fdb59917..1b1ab2f1355b 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -170,6 +170,7 @@ static const char * const proc_type_strs[] =3D {
>         "IA32/X64",
>         "IA64",
>         "ARM",
> +       "RISC-V",
>  };
>
>  static const char * const proc_isa_strs[] =3D {
> @@ -178,6 +179,8 @@ static const char * const proc_isa_strs[] =3D {
>         "X64",
>         "ARM A32/T32",
>         "ARM A64",
> +       "RV32/RV32E",
> +       "RV64",
>  };
>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
