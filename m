Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6135BDCD
	for <acpica-devel@lists.linux.dev>; Fri,  9 Jan 2026 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964909; cv=none; b=asUGKqsly5rOPYhraF7Ljbg6tpxzEFv+/nF/ke3T9dtGz3TcOJNYrZSkSpF9iWjS9N1IkJZgMkb1FF6Kys7Uw13GkmYxn7uiye5FXUksvpXGv617WQia2zykiPk1UREuYyMmNjZbaY/D5klte9ZvKCyYwP2TiEhNGW8jOyvncxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964909; c=relaxed/simple;
	bh=eVCQ0zFZa3LMWhX4okqjj1sUXYynRau7Uwu2NGHlf4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhHqn9/cK2pR6CDrpROeGDuewV4SjAuzQct6K5M7kSixS7+Z/5tY/NONWxUK3uEY9WEo2alSmdVZBbRG4X9RdEQd4tdRdmODKlyBAE4fr0XO4WUjocgWZqxJf79SKnSgplYsVcsqro/e3VuzQv2f5x0omSMy97Noc1iYY3QLkdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WXhEiw/2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aIhP/hFy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXhEiw/2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aIhP/hFy"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6098RAZo2327455
	for <acpica-devel@lists.linux.dev>; Fri, 9 Jan 2026 13:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=BJpvv9CAxjxya3vDiC3pvKGJRe500UKGEV+RGwaO2ls=; b=WX
	hEiw/2oKmYNFFdOqfMrcNoWZvCEqAypOl56bXLBwan+58yVJepe2ID5MXdOKx5Th
	svf0Hvm2K9pBhc5BaFMmbV6+ixlWG/qY7PUoPmPj6UQYkiYUSi1Zuexh9iym6On5
	OtOrOgO6976pOqwrSe+Pg1b0qq+rI01wWSmKgB5bvPUyRzdO2lOhYsJH4zOV81X8
	DUTESvIyxrLj3UaUcVWBd0d3oos4IN6JqirVx+/x8K+UbCXvzSVRKIvmIj9AQs/k
	5jmls5NVpKBnrJ95uT0v5OdFluZW1/o2jTQ+LwUCHoHai+/gdC6Eqm58vy/Idl0+
	zrDP8C+Rq+GjnXW6RD/w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjfdabe4f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 13:21:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f4a92bf359so117813221cf.2
        for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 05:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767964907; x=1768569707; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BJpvv9CAxjxya3vDiC3pvKGJRe500UKGEV+RGwaO2ls=;
        b=aIhP/hFyshRHvJ/acyYlABemvbu2P9RuYiTzqD9yFhNKWobkyDmCojUkB7d7jnWHwI
         atIJ+PSK4XB9qVaIXdIWHAhy+Np4NUc9vihpHG1c8frOQQ+orTguMLiGFq5eCs6jI1Z6
         nLjGCqN+j3vtRwMMn9GUFhV1MoTYJexUG7pvOmpVo0nGcErRzyazAdQ1QCfi95JSA7Jw
         3j3E3yMCkPuDAVV9KxCQIDs47WgwjnEpoghYEbRVg7gizIsvuUtaQOQj3Z4fub4qcN04
         38NsT3BoBCXz/ouxJN7o/hGCrtH8aZKlGsp09ksiAcxT7ZKZg80dLYBrT/HlLHF5D9LO
         DZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964907; x=1768569707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJpvv9CAxjxya3vDiC3pvKGJRe500UKGEV+RGwaO2ls=;
        b=LS8/4Ir9YiBYxYY2gx3A6I7LqAbPxtLBy0x8QdjCpDji5NXNOaLao/2LNr8T/JO7xy
         UY26DamjS8yVIihdkinEUTcWrsrlsgpj382bDBRjHAC6tDekzIQ4Fkix9T1/KTA7VuQg
         OBNiCJcraK1PI03C4UCOkWhwMqrVQhblEsmnNPQ4LV6CCDVs/HZnt+HVdpBNYbj0MkbS
         krgCoBupxS+gCBY1GhhiMT8Muw6Iwk7YaO1dJqc+HpaghKizF7ny0oQyl/HZBWg4ZYhX
         RhXN67UzSLe+u6UsDETBGCA27mHQLXYG1mudX8zO5PT/Ee8Az7cHK9d9AiUCPWB3BPmN
         sBgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWin9PepKXmbiPd7buqePjlVL5edG7o8l4iJHaduixsSSxE9GaroUh1ZYmLaHp43VGUiVeI7f7nT7LXNHI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9mJyqaXu5MiO5R/wMhgrVAarxD/M2cooMXN2WaAkDEmvbXHVs
	47QNjlWvyH9CjkUbslMWkqlHXrjeHPNx9BeX5ohyvTfmOjQIHpLAJNRF5T6+FHGC5Iyw9803+fj
	VX6p4+XSKmirCFwr9a4aeRwXJu0DjTliFd71ApVmLh7vAFW5e/jFMVhNVM73V5VMgpvnHTHYQe3
	1/AwLjVkxmWVeXnbA9++8uo1nzo/i9gSxBiLwOaGOgKw==
X-Gm-Gg: AY/fxX5Yd1lvNIZ5AMJjMIqz9XPate8LH8Y3VJ53RLx/50stzcXwoJ9AW7/wGWmkkt3
	78ahXK+lOR7bEKukWTtPx4IhMJHSxGSs+JqH2eQMmERiXyNgpqItomERSDIS+SVPm8KYdpnPK8T
	/t8oOFjiQb0Z8FAMnaJAqaE2sIq+MGHV8AecOCH+5KSGIJOxqwdrs+4yUR9R1/U/H734c=
X-Received: by 2002:a05:622a:14c8:b0:4ee:61f8:68d6 with SMTP id d75a77b69052e-4ffb485404emr127525401cf.6.1767964906835;
        Fri, 09 Jan 2026 05:21:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECkusQZQQHBVt2A44gSkXhBbZXUvr9pmoh9OZwBivjqjivaJRNE2lJCJ8geRdznbFg0XMQMJzEHdBSKjeUGqY=
X-Received: by 2002:a05:622a:14c8:b0:4ee:61f8:68d6 with SMTP id
 d75a77b69052e-4ffb485404emr127525011cf.6.1767964906406; Fri, 09 Jan 2026
 05:21:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com> <20260109090224.3105465-4-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260109090224.3105465-4-himanshu.chauhan@oss.qualcomm.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 18:51:35 +0530
X-Gm-Features: AZwV_QjUVwGXO2R47NOUKBNVW8AqeLgnl_83gTKQ6qB3PBktNV8dMcQ64Qr-7zI
Message-ID: <CAB19ukG+_a+q8htOMxXnQRByprAmfPjCfNeHBh-3GqVeQbNMMg@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] acpi: Introduce SSE in HEST notification types
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
X-Authority-Analysis: v=2.4 cv=Ue1ciaSN c=1 sm=1 tr=0 ts=696100eb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=h0uksLzaAAAA:8
 a=a1NblK7KE1KWh-jXdIsA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-ORIG-GUID: 8puLyEC53qLmg4FqMPgabIAqhSDIJth-
X-Proofpoint-GUID: 8puLyEC53qLmg4FqMPgabIAqhSDIJth-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA5OSBTYWx0ZWRfX+8ojcm3WL1VM
 ey0Lf/bAUpUJ5lNaK1dURrFqkgPbdNOcxO4I3/kVTvPxzQ4SgOyVCHWjTP42obbLLSIXNAcl/zN
 eI8u7ULCrSktYf0OLokiS5TyZE4LAA6Mz5+InM/LQ04zzLqgHEVtTufLrf2Y6L6WURt5IyTgR/P
 FTs6vU5TY/iRAl9Q+ExWyOLG6xkh5L/xyNg6S7e0wx4JDynIILT1dK8x0MX3RcJgkBWJTuyji56
 Xpk/HjEDLCV4NI7qHIrtdI3H6jrae9QQ7BI6Ib7kvh6xXS67HJEfVeW94M+57ZsNXD1/uiaFfRv
 amqDIJfphJlEGLR75nXjWUK3JQVjQAMJ0jabXQVptv2NzOzuBU9n1aFQDHFhKPPaAvxZtP595l3
 uuJmal+k0k2obgwvsUqY0EgtNY5LkqI0LbYIj+ogsNQ2jSXmhUfjpabGEqBoYVXf97cX4ZDJoHO
 3grSGXx1WDqFM+DzMLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090099

Hi Himanshu,

On Fri, Jan 9, 2026 at 2:32=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> Introduce a new HEST notification type for RISC-V SSE events.
> The GHES entry's notification structure contains the notification
> to be used for a given error source. For error sources delivering
> events over SSE, it should contain the new SSE notification type.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> Reviewed-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  include/acpi/actbl1.h | 3 ++-
This is an ACPICA change. Please submit a PR to the ACPICA repo first.

Regards,
Sunil
