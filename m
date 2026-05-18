Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC17037CD50
	for <acpica-devel@lists.linux.dev>; Mon, 18 May 2026 03:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779073616; cv=pass; b=RcRO0K77t6CnO6DfQaAOV3TcNYJRhX67fXkf+Dl1k0MXNNHT6BNveDLmS90k5qVqG3VIc4yCYX1PhMSCUDc7JBguTlQpRfMY+Ok3QdQP0bGbkBIkQOxwh7pD8ozxlQO/qjb8grGIx27qBr9Pl/sGMEKoEud8BLVaKtHxDhOd10s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779073616; c=relaxed/simple;
	bh=fO0syQPa6DgAL6Biu5LOpvUimHkt27lXFQ4HIpa68wE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1nyyfI03sR9Wrs7L6XpqGKu01Yk+C11b4FimGGm0SaVRp2ArqASu7pN9AUPqXVkERipmtlUMb9+jnAuZ8lWyz59/Xk6Nwl1j0EHmSG4Sb+zAtrFntKpH58+/WNTGQN0RbgF9kdN3rVBOCB9TBgRJHpRAx4KkBgoVTeyT90gvPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mAEEYiqL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FxlAllah; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mAEEYiqL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FxlAllah"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HLvYOd756636
	for <acpica-devel@lists.linux.dev>; Mon, 18 May 2026 03:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X708K6u8SzSx52/GxLg4ntRNIqhO0X/cHHFOcijQWfw=; b=mAEEYiqLjDj3ISSj
	U5DTIyGChBAQ/hDH6mDWkV6zMwT8BOQuX2+8nzAyS9aaOYA0uF35nWjqMAnPO9CO
	kDURFnlI2SvtZVFtL2PMfoSaJwmZkWBzsUTC0cnUSVkhA6e+rZcH8vMNrK/YHxrv
	NjyQV02h7yktq+80nCCu2aPwj3jeGUzsnYijL010Z5NCWM+E7/iezZiQ9ZVkGZxV
	ha8zvgvtHH05doMuKKYrYfQ1p2puHZypDxlp6iANSMc14+Muu/dft+LVBA/Wk8wG
	yqDsVg+F2SCwMf70CJ/xSX5we1QXkH4hbl5d3oaco9SCSGaPGCmTXgUiPaYuclDx
	2WjEtQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6tvck4fk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Mon, 18 May 2026 03:06:54 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7dbd60b7ecbso4400821a34.1
        for <acpica-devel@lists.linux.dev>; Sun, 17 May 2026 20:06:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779073613; cv=none;
        d=google.com; s=arc-20240605;
        b=Ie5+EdV+eBy7OJMOpqZ6Hn1Z+rih94HeHEyrQkkbAF6pxTlvsSZ6AiJFmcBozMifOb
         ZCMDhu1LDKcBQR+m2u0MOgM68igyUpK9Y3xOoAAdacp9Gx/k40EdayRr5r2u0dmP0/PV
         aROr0yR/zB0wlwaB/JkEsvw9Po8/43kCtX/ZkJ7h+6O5UhfWJzj1KDHjbA4wai9We+9V
         uowxDuVjuU6RY0xuVfJjKkwYzYuOINzl19muhoYoi6pNOqKzQMmu/SURxuHJdKBl+XOl
         QmhDOwUTaJkwd8CTFYSuDmY/LR4yOGuLfXdrtnQuEVr7syBwfcFd3Ajo5n8NuVblwYli
         f1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X708K6u8SzSx52/GxLg4ntRNIqhO0X/cHHFOcijQWfw=;
        fh=UVE4n/9v6jPtcLprC9t+33iLEl8pBm7nfTQ+9kdvsiU=;
        b=Z6fIipORiGrpD+7+wQT3yMNCyPKcvA5qios/cK9vdJjTdp261iNqUW2Vw4cemm25g9
         dThFmo8MTOdIYbsw+ELGnkWs80u6tCR4MWDBEs2tOm5sw4BXCD+5E9TMt0pOfSolMlGj
         wikU1WWSFeGani6iRi1vd/YdYBP0Of3Ov5+xmvGD1iCHgc3qH9YJx2PWho5tSIXPQvpr
         GsjuK11Qb/tiO6eLCABjrUYshSIJ3krBSth9PmjH+j2Eu+kFMiAKi1rHUG6F08cOmZ51
         Hf+Cz5KPhTg5rKqPP4X1MxEC0WvSSWYeGNtz3ukM1Gb3mB98OccQbj/P8wS2YPU8TFsZ
         V3ow==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779073613; x=1779678413; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X708K6u8SzSx52/GxLg4ntRNIqhO0X/cHHFOcijQWfw=;
        b=FxlAllahV5NTk3fqqCcmaNPGH1ZSy9X4QLwTWiJKgMt3ZPr+AxFTv5yK34Ay4lcH0C
         olLydCOVKkEuOg01rn8Kuh1uVwmow9IU8V4SaPf2Uz3F+0viB91SpfOFRNrebsLBC9Wl
         I2B63sWYKiVilHCcLMHNVoEjFK2enMbMhNg5eRH4ycI95eaN2OHluVOGkK3DY1kdfcCd
         eVVgx9VCmrf+P/l3w6MVsy1EPgZPfkx7Z+GrAJAXni5rstNQ82U/JwjHMfCA0X1hnoaS
         QNC31SgWMZeE0CAuqy/PB2W0PZxC4kfHyicszBvWysL+F8VOQImY4/YhYP3N9C5bQxYv
         SlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779073613; x=1779678413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X708K6u8SzSx52/GxLg4ntRNIqhO0X/cHHFOcijQWfw=;
        b=V7T6KkOEN8e2+v1xlTrw493REfw1rUy+5dq4wHqoVmW/CahPUiGHpqe0X57TkYndSJ
         3/5O1xZWHxWp2tjfe4RTqX70chqfTaGRkoTX2ZIxXu41RAI+O3UBIkM6GIPBOZFnLuEF
         b4dH5eZAEt0U22gITym6G+3tE1GJ9wtLjEpX+tpIBoNZ+W/pLRlOfcNPXTuKrpykwKlm
         sFiwL7DxVWhy1kSm1lXyzZGjwNc/Kl/QQwnla7SfUmDzNZbK44zWzoFbVGRxxb4uwJdk
         h8SIzxNCmeD93atA+TwJMr/wz1zkElOG/9diE4B+TQxBjrEzwu6uDcWma4tUdnoKe2D7
         +eQA==
X-Forwarded-Encrypted: i=1; AFNElJ+AgF6JB9Cmyc9emRp1RWgwqRu7jgD4jJpgUmpPMUdo7kpqW5ZZ7SBvS5lmNp+fPTRwvi7tsS4HlI9lDig=@lists.linux.dev
X-Gm-Message-State: AOJu0YxpCjZXZ186ajILafH23taHbWjdfbQKwfDY6xEmKBzWT62IgibP
	t2haT5srtYM2pGZMERqmQ+MxN9LmSlxUJ5pbbiQUQbRFBe5/eucBfw5Q0PTopGCpcSyHAXDH/C8
	pZeSsurok46/2YlP7f5Cx5sAi6OodneFCa7JF2oxBx2cV0YVDoTpL7g47WIfcfopWkhShZm6li6
	AAgy0lOZb8UD3occ6aMYTndEcAp9FaOj3CF6Ea4E1fuw==
X-Gm-Gg: Acq92OEDQW21PS1aeY+w8AvGrV46ogN2IhRLLTZvucHfHgq5aIPZsdVscT+CLKCpt9k
	fL8Z3DLtowl/pWB/VdL2faqVqZDewPLP7VLPNFhUzE9wqL2LFIKoCLxf7LeGbeZ3JW7MFBo2jau
	w9Bt/cqBgfKzciDdcgxpTRLsmjBC6SnFn3mYBaRxPAPhteQO8TZZ5svHGB0o7SQ5NLeU1AbzXV3
	qszFMDdoSIFiZX9ZA==
X-Received: by 2002:a05:6830:828b:b0:7e3:7697:9b5a with SMTP id 46e09a7af769-7e4f2b9bfd7mr9164810a34.18.1779073613217;
        Sun, 17 May 2026 20:06:53 -0700 (PDT)
X-Received: by 2002:a05:6830:828b:b0:7e3:7697:9b5a with SMTP id
 46e09a7af769-7e4f2b9bfd7mr9164792a34.18.1779073612814; Sun, 17 May 2026
 20:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com>
 <20260513084325.2176952-4-himanshu.chauhan@oss.qualcomm.com> <CAJZ5v0g2kjfAvcTzp8898A8HdMymU1SQ-rHW_DFhZP49c9=s5Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0g2kjfAvcTzp8898A8HdMymU1SQ-rHW_DFhZP49c9=s5Q@mail.gmail.com>
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Date: Mon, 18 May 2026 08:36:40 +0530
X-Gm-Features: AVHnY4IXHSTvGb4jHkiTrfKvQSC_eyAqKXiBE4l4KpJ5S_P8fZyP7mnKGJ0aI8I
Message-ID: <CA+Ht8=YbMLXnCFtoyVosrjS56ye_bUp16awgxnXkEmHB4_5_Dw@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] acpi: Introduce SSE in HEST notification types
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 0ffvR46ehzfNi-lQepdqdW6oz_-BSnnQ
X-Authority-Analysis: v=2.4 cv=UIDt2ify c=1 sm=1 tr=0 ts=6a0a824e cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=h0uksLzaAAAA:8 a=sBTH58jHExCepGOTGfcA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-GUID: 0ffvR46ehzfNi-lQepdqdW6oz_-BSnnQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDAyNyBTYWx0ZWRfX521beLxMyr7J
 vgklUVunReSW9DqlsHeaDAUCLclkjHpdljkBjIq7fAPvlsWR6QEFZMe0N3QNVP2Jodgu0z0Lru6
 g5X2e6uz59nnacX1axwAuzddrWGt4dzLC+gQMBMS7EuJEy5tf3/eOh+pr0R0tMdj791PcP7cpqm
 u3kD+gOBGdJeqe2Tp2ymRj1Q4bJaALuEoshKjt1tcQQEEc2eshqbtO9T+vB9ihXY47eJTTHkFLS
 10buKDBXZbGrUTw9Pn7EeQ7YMM2cITuFi4CNd1pvD8I0YhfMBqQ8rZdxc+yUKWc8S4ISJqewgj5
 mqpehdrX1OD8OxA7SKDM/dE7N9MAGmv/JdG/hL7NdM+YoTmVN2hhww4D8IYNo2exg2FI5aKGhfF
 jkcNQ9g1iuSy+0GD2JWKIz0cDpQoqjarrtzh0JDMSffH/iGRoodL5X3JbTjtQRa7JJeRtbK9d4w
 M49nIbkTZdcLKsOSv9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180027

Hi Rafael,

On Thu, May 14, 2026 at 12:56=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Wed, May 13, 2026 at 10:44=E2=80=AFAM Himanshu Chauhan
> <himanshu.chauhan@oss.qualcomm.com> wrote:
> >
> > Introduce a new HEST notification type for RISC-V SSE events.
> > The GHES entry's notification structure contains the notification
> > to be used for a given error source. For error sources delivering
> > events over SSE, it should contain the new SSE notification type.
> >
> > Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> > Reviewed-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> > ---
> >  include/acpi/actbl1.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> > index f72e00517eb3..2a8167979458 100644
> > --- a/include/acpi/actbl1.h
> > +++ b/include/acpi/actbl1.h
>
> This is an ACPICA change, so it should go through the upstream ACPICA
> project on GitHub.  See
>
> Documentation/driver-api/acpi/linuxized-acpica.rst
>
> for more information.
>
> If there is already an upstream ACPICA commit making this change,
> please add a Link: tag pointing to that commit to the $subject patch.

I have already provided the pull request in ACPICA on github in the
cover letter.
Below is the part of the cover letter.

 - Raised a review request for patch "Introduce SSE in HEST
notification types" in ACPICA
   https://github.com/acpica/acpica/pull/1170
   Keeping the patch here for complete functionality

Thanks
Regards
Himanshu
>
> > @@ -1798,7 +1798,8 @@ enum acpi_hest_notify_types {
> >         ACPI_HEST_NOTIFY_SEI =3D 9,       /* ACPI 6.1 */
> >         ACPI_HEST_NOTIFY_GSIV =3D 10,     /* ACPI 6.1 */
> >         ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED =3D 11,       /* ACPI 6.2 *=
/
> > -       ACPI_HEST_NOTIFY_RESERVED =3D 12  /* 12 and greater are reserve=
d */
> > +       ACPI_HEST_NOTIFY_SSE =3D 12, /* RISCV SSE */
> > +       ACPI_HEST_NOTIFY_RESERVED =3D 13  /* 13 and greater are reserve=
d */
> >  };
> >
> >  /* Values for config_write_enable bitfield above */
> > --
> > 2.43.0
> >
> >
