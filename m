Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6731F992
	for <acpica-devel@lists.linux.dev>; Tue,  9 Jun 2026 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015450; cv=pass; b=TJSu6HhhM/22Gj8o0gAve1cg7lLwXZ4hI9ImRqUZh7n9Urq2j763ZN9bNBRMrofO817RYpWLJV61i7x5saHZGVuw6WAnTE9AMnwr5HBFe8eKmOJsH2tJbtaimpsgEZSKW2acQHwLmMvxtblKfOxDXxoS4z/4/VzJ3VtXEhN3sMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015450; c=relaxed/simple;
	bh=qUt22HVRDHTLE/STP9WjivjbEVbcJJjbvLyeAgzpexw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eu37L455Jg++j3RE4Argrk0c4d0QVtggVzUYxcRn6WgqCXMJyrnht3NDJrb6kCsES+A41Me8RVmvFe/qlwDw/aWNZQR1/IVsXTGgz6P9uIhBFMUhkPKtJ78nIwPkuu+hMyzJ5X6Cc/v4cnNGyl9RYPwZpsC9NZqitXE8zlC7OJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fthfLPGW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cZxI361B; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fthfLPGW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cZxI361B"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ClLoG652209
	for <acpica-devel@lists.linux.dev>; Tue, 9 Jun 2026 14:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=n2ZoTe9MZ9DLe7zQEw5ul/Iirw7q5Hetu2UB3w96zKw=; b=ft
	hfLPGWXHW1tH05MGW+QkewmxBy1Qv1V5JZ1bg1jJl3Rmo0OZAHZS1Ti6DGfbnuQq
	Wke6OSRaNbWX2DrJrThCm5nZmCBPypmaW6HFWWeYTaWJtSQ32r8hjLGBM0e4Ma74
	XvLousMzr7VkLfoUz15z1bjMeTNOieUtev0MsrKZ0qfswdGbnYV05JCa6Bym7IHa
	NF/S3WZR1NMkA64Kf/r172K7fuWMmaqpR4zdP3ZC77W6P1TBhLRm/HqFVa9kQFvl
	s+yrnow19Pd/K8omAHQN+8c/cbkR+0Ry6G2B8Ju1rWrJLqtcJTNXXLykt53TNjjM
	gpPW1Xu7r7+I4xexTORw==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epf0ssquw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Tue, 09 Jun 2026 14:30:47 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-660313cb3a3so2894851d50.1
        for <acpica-devel@lists.linux.dev>; Tue, 09 Jun 2026 07:30:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781015447; cv=none;
        d=google.com; s=arc-20240605;
        b=D/+8gRQvo4VPpXTCkdftXoTB3khAYy/JuFs8bDokFYD4I3uEu4iQQTCptyk4pruj4N
         +PW2wNbjlpj6Bak0O+FkGNOzz+GDmxJ06q1YlgwQLHX1IAxHCJsYTrc9WAwch0yLpgwo
         4pbR+1ENlI++3E7srkqzzNwRQvvYa0UHLNQAAqqCgIpJwP0qzDKSaiSCqZ9Lq0cVsWJx
         OgVzXtMO6t6y2ULBW0WDr3P2lyudH4OEES07mrV1z+1dFSTAxoHSj16bygAEVDTnMhOY
         /wVM/vFW8ENEmTnsf+Mmz0k/bp4be9/sjQ9H9gmqsDDzGet81JtasPhvLKt7E2e0rrk8
         9T4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=n2ZoTe9MZ9DLe7zQEw5ul/Iirw7q5Hetu2UB3w96zKw=;
        fh=///nrEKFQiAeVFYAf2cOiLBtegOy9vfrCEkuvPNZTpw=;
        b=N78MMAXvL2PXSE347gckM5EgYd4kyHT0XfUvjI2OFOvfKaqFb23hBtF6FJW40h5wlw
         dypy+AT9nviJjF+xgexLqOwxGRIWoEfqJoZev8vX+lD5LZE+1Z0l5zySCUsAyATxfuMy
         l+awqaUxqi1Gm0tgro1jzYDfQ0+cBdLxymZ4WFao14J9VQQNhBX2wkA1yRbGIMNC3wlY
         4iE8J36Nlrtp//NRiplqPEsSggDvC2Ws6VrNnwmukYZU13tDaX4+b19hw3kBD+G0Ai8+
         vGk9Xam3k0xz0uUUUnw4u/qUYObZJ60Ga6BxZdhlr393fzoSMxVzTgkR37cX71JaFBPb
         GN2Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781015447; x=1781620247; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n2ZoTe9MZ9DLe7zQEw5ul/Iirw7q5Hetu2UB3w96zKw=;
        b=cZxI361B+C4k+ySSztRDQ4EUORTCoBScQdxf1gFTtuEnPxQa0H+TEz8Cs5i0WKBsWV
         es7M5t/9S1TrXiJoxJgJSpxlrOuyEPTozYUo2ag5QEm9k7eXUet0DMA/UPSn2ZEGnew9
         DqD829Bpu61QFqQv4VeOav/qVC1NXL6omx22hyTXLmhzN+BR0GJYpCpTiYsXHeSpFpTF
         nyEX9WrJGTQ7+WwsO7+id3LW6IatAhVrW3BI+ro6vhcQXPmN+LsgLtW3uQh+wQ8S8AEj
         opD6/Dark9mL6dXhFKFhgt895kaN73e5DfFHTiwMhx5neCSJ61eGoNQnwTuxDebahNQg
         GXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015447; x=1781620247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2ZoTe9MZ9DLe7zQEw5ul/Iirw7q5Hetu2UB3w96zKw=;
        b=oT9U49yxQPOTyzgsJMc206STiKqx2+jBX7sLCnWSR2GOMfuhgG2/a95lxh59uaddp1
         ClGejxdoQh5W4VYUOQrs46YLay7FQ8GdunovprRozAgBOlcWrFFEBL9dN2VGZzs/wM7u
         a07tKJwHkaER0cNvXOvIHOeacXc1b7YIOc2yrH7OvyTjNm63nGgVZQ5nQ7X0r7zZKMBb
         qn6FFkR9K7NQnS6XAMTowYYyS0Vqr7ovydHUfdbPVhh91KlQyuwj0CnkPfhdR8tDnFY0
         OBZ0/3pHC+udQV5/ukBl4I7Q2FaoegW7bNvD2sHajf8k2Zr+Vuad9gTvUukBZgITYCe9
         /ZOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6+2qC4P2/m1iJ5PtQvKFRLQSb58rtG7YjBJA9caUaq060LKIZ+hGjQo/UKRNkg9c8+YL8m1oUuDQFfoY=@lists.linux.dev
X-Gm-Message-State: AOJu0YxYv3xIR6Ih47usmC4J0bKNkoxo8j6IIGYB7d1XsgUn8SYv69cj
	is4XPDjQzRocB1HzwnkpzExb4IdHGBot8d9dQ9rHek533wRitLNRePYQp0s2tZ6rhU2CkakJove
	VYDIv/hSpQIol0Vid6I5vDfxCqDPExs6moiAs/WYyohixyIyE5DSeA7qZ5TH5gbN6jvhpDDFT7G
	UwNq1maa1QYDPSh/43EqW9MVk7YSHn5LGv92D8+YfryA==
X-Gm-Gg: Acq92OGcstWktDhayyFjyNu/qRkaQINyXFrhrklz3gMUCZkAqg0XAj7hWu00+bQmAMD
	9SjbJov3A0opjJsSwlrj3ueqvO4Ady+XI6BwrzXEPX002+ne/MrZUtA5fXyzJMLd/jT6W5duLbZ
	gWxrY6sdpcYDNZjW/At5yD6/TGvaYFRPYddksxkMzysZrAUzU0nPQCPyflBzWHWXVXI6zZo2KeC
	hDN0Se5wKAZwNbTLg==
X-Received: by 2002:a05:690e:5cd:b0:657:e42c:ef3f with SMTP id 956f58d0204a3-6610707c453mr14362593d50.47.1781015446800;
        Tue, 09 Jun 2026 07:30:46 -0700 (PDT)
X-Received: by 2002:a05:690e:5cd:b0:657:e42c:ef3f with SMTP id
 956f58d0204a3-6610707c453mr14362545d50.47.1781015446306; Tue, 09 Jun 2026
 07:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com> <20260513084325.2176952-10-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260513084325.2176952-10-himanshu.chauhan@oss.qualcomm.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 20:00:34 +0530
X-Gm-Features: AVVi8CeCCuwpN-K9EkxyrVCpMYmKH1wrm2WzWm0aWwYK4PiS3mEB9S1-HswUmmQ
Message-ID: <CAB19ukGeM=v=G10r_tX2SC603Tej5Q6nFOCddcPF8BaKwxFxrg@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] riscv: Select HAVE_ACPI_APEI required for RAS
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzOCBTYWx0ZWRfX1vTU6TZP/ZvI
 NlUUYSGkydJr2Xg3Y/78PzYiU5rgp8IHGl/hYBW1Bc+yqmkDEUOR5Dknt/Oxl7TqYxY8b27AvD1
 2+SXhsEtjY7S4RTTAG9YC1cGLYIzITy69ug6GDXh6XOuFuqDekHbnoTG+AxwfQjCZM5pUyE+rhD
 fhEAzaIXp16RT3TEPn+mW4s8Y9oFNdSp2nNIMX1MLlDgY2CoTk5l8BX2aOTjO56mN0NuKwsFbcN
 YW1qHU8SlMo8KWimyGlbydVCfDpYdQ6s41z5/53c8aRUduqFkMreXiAISg7bYm8yeEqVMY+sAzS
 r9N+yYARdmFdCPK26wlvP5E6xYZq8cRNQbUKCedMqWvQHJgFWperq9Ye2+7OFLU4QcwBKxVoRST
 Rcn5am1gf7RGG4JxDOUrJd7K5sAVHrEnRnGCzVDRTTH37DQHozmfmv9OzPI4MNFZBMwfu5Pkssd
 nRs/tJdqWOPTzgkiYWw==
X-Proofpoint-ORIG-GUID: xBi_ZG-gGc-6X5fWyTEH-w7XL4qtiM1R
X-Proofpoint-GUID: xBi_ZG-gGc-6X5fWyTEH-w7XL4qtiM1R
X-Authority-Analysis: v=2.4 cv=GeonWwXL c=1 sm=1 tr=0 ts=6a282397 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=GsIs01FLSDa8B7WPS-oA:9
 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090138

On Wed, May 13, 2026 at 2:14=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> Select the HAVE_ACPI_APEI option so that APEI GHES config options
> are visible.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d235396c4514..b94b19fb4249 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -187,6 +187,7 @@ config RISCV
>         select HAVE_MOVE_PUD
>         select HAVE_PAGE_SIZE_4KB
>         select HAVE_PCI
> +       select HAVE_ACPI_APEI if ACPI
>         select HAVE_PERF_EVENTS
>         select HAVE_PERF_REGS
>         select HAVE_PERF_USER_STACK_DUMP
>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
