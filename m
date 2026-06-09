Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE363DBD7C
	for <acpica-devel@lists.linux.dev>; Tue,  9 Jun 2026 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993038; cv=pass; b=iGiZtGZYUfnZHKAB5QjFEwkRbkpS1dVzu0pGLc7iFAawVN7xPfwYNUY0c/l8z7xkSCzZDQaMBU4tB5/7VvOa5ZNRUIKQ12Xf1fA+HA0opWeUC2HnewlPhO5tWuv9hBB5FxcZIMEatGXnePog8Scg24sQ/mZ3jB3Zp6VA8FU/iVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993038; c=relaxed/simple;
	bh=dWJx//JOEjj26wHu7ehYPbCtKxGVYW0K8EvQVYpijNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7SebFvIXq12R/MVWv4W2jZWTVzzWVOmyBWCovAVamA1jswxG9CrHIjgoLSRRLiBefgNoSVIgsUUuMYtpTPLWj2GeXcf0H0mRfqYzPGp/3D7DFeEuRUUwMtDufUn3BymWh4H4hTBFBDJgZG04jHunSbervFB+oQ5dZiftkq2TAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eQk5Xu9b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PDoU2xEy; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eQk5Xu9b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PDoU2xEy"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rhpf2034898
	for <acpica-devel@lists.linux.dev>; Tue, 9 Jun 2026 08:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=jvupPNCldiQKAIDZ/DjgPDJckTZ6qUBUmQZPH8bK9Sg=; b=eQ
	k5Xu9bgZXNXJ4bQsWSdE0Q/hF3srxk9yTe3JRQkdC40uDEowSMrqS7QQqHTqZxVk
	eCGeFEusOg+w5sz7cCmeEO1aHxb2d3NamlhES9kf/HO2CDCbvfCjo2vAo9ww7EUB
	qr/0zdDRAgFFq2ypYQ28gc8ntwbaW+2G8MtoKN3iiteLwr3qDzMPGyi0kXSuOpay
	DrYLUpeGo41/qmgvY5kLPgIM+o7n+zoNoKMpXZUOMwx1w6psgTzgWXpXhSyQi2j/
	kpMrZ82TNStzxJqvdx+xZgnohrv2T+eGo/F5vXVaGUhCqXsDhaUJqx5NkU79XOzW
	kX0G8azJRS4o4VXLdPwQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeear6js-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Tue, 09 Jun 2026 08:17:15 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7e25a5f1057so104696947b3.0
        for <acpica-devel@lists.linux.dev>; Tue, 09 Jun 2026 01:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780993035; cv=none;
        d=google.com; s=arc-20240605;
        b=fftLPu4Xgo0903XDBd0+gRaJ7xOvLKeIn1g7z1XSYbPugLX2HPHEpflGOMJflNlfFf
         2C+RVXf19akrvrsRZBcKP2v40M+IozH4SW2GoSgQMeJ+if0bTsnHGkw6soZwfv6FzMXj
         w/QQPQz1/55COdV5k/E1Gwlx1nFMYDNubuey9TMtnVwrQQBEEEHqPJPB0mA6hLsuhRhd
         F69R7EHQ4Nt3HO7VuLmpyR47lkip+ZTN62NvvgmhEikcSFOtI4z0v36IEpK4X5TrGWg/
         uPX+7QH2FyEHbQ4joCMGy8PvbQNEZQKORJXNM27B9L2O1MX+9ZlMENTjvWi3rvt8VuYZ
         +cBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=jvupPNCldiQKAIDZ/DjgPDJckTZ6qUBUmQZPH8bK9Sg=;
        fh=4XGxC6T7gQJahtXmNhdLbEvlulFnVr9KKVwO8PdlsP8=;
        b=D7wEzcsZ6Q/8519FHxL2IFAmW0yXeWzddzx9qFlwHJ8n1DI66cOOuwD0UXZhtolfv5
         /sy/69AvOZIjZY0ABOMuoh+nBs+a149BS+73b3FemHdBgyZGVPDmvpIj6ZBIrfQNwUZZ
         21g/C59zWzBJlj4YWTBX9SBD8xLlRuoy5GW/F/MF6paxQcDKpr4XBlo+sv97+zlFJwHn
         uk1pFxcosjq/SQy649cWXy0vETrL4QNXKsCOyODAraxaEXgCquv252/Y0wo9+OF1Kph3
         LKLynPESo2NkWUuIfBB9rFbqRkdyiUdja3r7kMwaeEnAH1TsjioKRol3TeljNc7FVEkU
         b7NA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780993035; x=1781597835; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jvupPNCldiQKAIDZ/DjgPDJckTZ6qUBUmQZPH8bK9Sg=;
        b=PDoU2xEyoVS10fbnQCrUx8nSr4h8kxwHiCyi2Aw5NlsFxbYdY6cxE+13ocg+0DTmNi
         Vu/n3VdwhuisW8hy9eH6ebVj2Selc030VeQMyzr/0hys2cTbkI9EuCIJI1PJUoiVojtJ
         c8+Obkq7UJzus3gbQ8UP56Re8k8qsUG7v06NOarhB1/Ib48gLvl9EH9IkGILby9nJubm
         gU53LncseT1Y8B681sQ8nFrxJ+M1XMFN9LzRBMrkn8fpYXasETjgEZV9IfUvvc3K2Oy2
         R3VvHwVjJHbrKeSbmFk29z6iDY++ASqytUIBB3QF9OCuuojbqzJzOH1TzcgD6taRZpYa
         K6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780993035; x=1781597835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvupPNCldiQKAIDZ/DjgPDJckTZ6qUBUmQZPH8bK9Sg=;
        b=X5dIgxnMgn21JHsanOI0CRYOF8y4IzFnTwFfc+q8vaZZLIql+fIUE7vh20YuQlLd0p
         BKE4pN7kvCOMSP5vahJm4pYHIPOwqXmta08lS9J2isTMOD0USA/K2P/RV4GsiYvDobjb
         n3SWokDs68el5vXE/EaLjB/k0T/uZxapSTOC9XICa7Vl3Dd9dLKNi/RIXwok4OmiXmiS
         1P5FQ/NWa+nrmps6tzhORFGNOLVkIzs4B3/9tfO5UPZLHSFS6EGgbKHIKF752aSbS1oF
         DhhiOwhJ+Ez4YUXtBQI6DtJ4aq+hLcNUMmoEJSEAWu2noOoUvB+WPmHM5/7exLzivj72
         7Wug==
X-Forwarded-Encrypted: i=1; AFNElJ8GENqgP28skCBTL7r+gQXdnFzqnjswEmniMHMXgle8sSZWyj2DLORFte6lyKaz2rT1+cp6ZWUOtlmBy9E=@lists.linux.dev
X-Gm-Message-State: AOJu0YzAjYwXXVNtSXCfaHTh1DdP2W+xOZUwgV/yzwtem5CRMeQw2i26
	+hBbYogo6/g+Vau9rD4XiQeh9IUyuh7jsdsiPkdVVcziR68zo5+646nOgWeMMc/sBiDCWi0k6rJ
	bWMHbe+RPzy0ug1ieDo8I5V8Hj7Ug8eQbEdcHlMuaLkzu0zP2fZfudmqcDH00K9x4hDF7o/DgDs
	nosHd6WfQorh95K4Gejdkr/3hWgXFr8RKAFvFvteaiwQ==
X-Gm-Gg: Acq92OGavALx4BCsFb8Eise4i/9iUv/OCHTVAI54IQpgHJkzHCBJMVWM4aOwYxjX6sz
	moRnV5FTaWooRq7wBd8AxIGRBrHKh8RqxsMcD3b+EvdSpwkXgK8QmtQuflIYA6ak7nqKRiGk31N
	tUvoZZaJnPF8ToNA831SFeO8k6TVuKuHXoPD07gJnH6ts5OXhiIUZRjFr6QDfl6C0/mJOJYFhtD
	rtpHrdi3Ca+/jDPJw==
X-Received: by 2002:a05:690e:4105:b0:660:2f29:9d9c with SMTP id 956f58d0204a3-6614f8195bfmr1177964d50.57.1780993035310;
        Tue, 09 Jun 2026 01:17:15 -0700 (PDT)
X-Received: by 2002:a05:690e:4105:b0:660:2f29:9d9c with SMTP id
 956f58d0204a3-6614f8195bfmr1177943d50.57.1780993034797; Tue, 09 Jun 2026
 01:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com> <20260513084325.2176952-6-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260513084325.2176952-6-himanshu.chauhan@oss.qualcomm.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 13:47:03 +0530
X-Gm-Features: AVVi8CewdCgb0dSR_aOfcZlf5FZmhKTqxG1BVy6uKMuIOJaJR9mdub3hX1vwY7s
Message-ID: <CAB19ukEWxUTnouJLG9pVBkS9VcfdFP_nVdG9T6V_4dAVLDNKxQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] riscv: conditionally compile GHES NMI spool function
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
X-Proofpoint-ORIG-GUID: FJN1mhfghaHpzFZFlpnN559lnlN9lD83
X-Authority-Analysis: v=2.4 cv=Iey3n2qa c=1 sm=1 tr=0 ts=6a27cc0b cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=9L7PnyXcnU1f3mQPG5kA:9
 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NyBTYWx0ZWRfX52qmUVdAxWfT
 9LYykwkY0NBcLRIDPeo64p/ZdHnYavlTDyfg3EtX0slUWd4U1GRHAcbTFidSfsdX5yjceU/oxMQ
 lhu7t7EsE1AWcjwmqxKn+cGQpuDtRilYwRgGDgkM7u7DLW2qQFTpQ/X67jGZnUJvAtXvmB6+QMr
 xQrZ6WrTAYNy060Ih5lyWcoAPZf3xkNp7/i0C/SwCW5xoaYtodkWEIVr276SeMq14PiN6WTqjc+
 SMjtXRXwuVXkjVzJebTIqPgmj4AnrCTh48lfMwqdfYDkTDTBPcHd9MrFm2cNHl++c8nhLfDOIGL
 1h6IqFgz6ggsW/WqpuCfCOnE+76Er2V9Kud+OUit1VWduq2jJaRQ/l70U5hO2xGWIchQPtBTmA7
 /JejlJiAIqGwimE/ty5RJdQaWkrz2aqdz1AxHlILseBp3Yht3XL3SvgvNqbDSIWc1BT4Lo15OoJ
 PptxHkrD8Lt2/p19JSw==
X-Proofpoint-GUID: FJN1mhfghaHpzFZFlpnN559lnlN9lD83
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090077

On Wed, May 13, 2026 at 2:14=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> Compile ghes_in_nmi_spool_from_list only when NMI and SEA
> is enabled. Otherwise compilation fails with "defined but
> not used" error.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  drivers/acpi/apei/ghes.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6..8edc2c8db1bb 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1397,6 +1397,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes =
*ghes,
>         return rc;
>  }
>
> +#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
>
>  static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
>                                        enum fixed_addresses fixmap_idx)
>  {
> @@ -1415,6 +1416,7 @@ static int ghes_in_nmi_spool_from_list(struct list_=
head *rcu_list,
>
>         return ret;
>  }
> +#endif
>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
