Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEE5314A64
	for <acpica-devel@lists.linux.dev>; Tue,  3 Feb 2026 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770116605; cv=pass; b=cEzPg3iZcxsK9dRAqt708Yxiwv9h87y098QHRDnL+813ZM51+uxiFkc7ZcHmVMxA2Nf1jjGzyjERREghPrC4xjEoxVgb8Bvisx6n6/4Raxo9XHUg5Om1aw7vUlwcR643dsyKoLPb9KNylAxG4q4gS/fzZLMyR35eYQiU5ASQgtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770116605; c=relaxed/simple;
	bh=UkNMgpktyLGxh/cFTtfeZZZty1SnTeDWasdVswM1t1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/8FKD2gs7LlxU22RJPXThJ4X9RU2m5bXJDH9HVgbjHqxOufsiHT+kjj/bccaikNgaPAAkkVvHgyvJ5LExig6XWsT3HGAzcnyyf4obY+khd15t6hn0lYM/JBUTwfEOeqM3ywjhhGuKgnUw+D0vc9ComgKyOSVXO9Is+tZHshQiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7N2Y0cD; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7N2Y0cD"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d1890f7cefso4488079a34.3
        for <acpica-devel@lists.linux.dev>; Tue, 03 Feb 2026 03:03:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770116602; cv=none;
        d=google.com; s=arc-20240605;
        b=UM5yRTPwjbJ1L3ULda/PJ29euAwTPJIOy0C913XLwNS53xFF84LEomJS39pd+/4vYn
         NgZRIwDxdgl3ly4sQtaBbunWwF4VmiGJK2oYlJPTDnxaTH5g6pOSdKS0R0oKLih1uizj
         ZFP5RjtwaSRjKQqr+fl+yQO7R62wen7iXcqEe6DASRH7Ls2bR56Mh7jPN59KpxrWohMP
         NIYJB1n5mk0dqH3qE44Y+ktzToWKK+ybixUDOFaQHUuQDjAZzQTOnjQVTVNObmHgjK06
         E9t/1feLFMZyoxRk2Ec+asDoRkQL7M9bvQN9wqaSOqR5L45Rv1pkb4a5mnIcXJ7ZZuNy
         yitg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h/fgvm9k9I3pQj36j4/Ol8L8Z8tktEJAYn/oo6tMALo=;
        fh=OgUUiOu8Q0qM2yVYSW9wae5/mlbcFXNKOd3VyE8aJMc=;
        b=bKErxgMqh64yy496MBn2bHV+M2+X0V0k6EJ0ffoPX2orcGtd/qpMUTRHmP5A7xlZXG
         4HhHPoYqTNqr32NY/7tDsH/lLU0w0+cSb4f+67uMT0K6UCEXN31oFPPfYT45aqIwM7xg
         aGPkzDMU15WWDfXXfXxo+1EapjcWV8qoqr5b4TRqIn18q5Ji/7ec4/EymLW4o76tWFsB
         P1GR4A1nFTwGBIrlVcfhpQYzKcgTYgZF4/RWTDrd0008ioNPmydtLZpEkdhrBV28rere
         AROJIa8IaJY19+d+hafH15efbaTZQ6vTu/5PorQPV26YD2zByb8QwlGPtQ5/4M8J7ORr
         qFnA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770116602; x=1770721402; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/fgvm9k9I3pQj36j4/Ol8L8Z8tktEJAYn/oo6tMALo=;
        b=A7N2Y0cDtjeK9qBSfH0iXdbdI1OGPeXf1s1PngnEGxIXqXzRwUCcGih29d9aCOptJT
         kUJTrvo+I1Id2GiCGQWyd4bnoINxF0WOxRPYkyDmq6JXgCKIjjCU2gAYp/fR1arQC3Ck
         HnBqRFoYY/e+ZIQ8QqKWv6JGYQOl4BopxFNNPFncIQp4chWoHx9cCBGVbaBN6ABaASia
         zgZyFXaL41vYmJbThPX2nVhMB+WnnB3cQQ+Mriu3LwOJMPO3oIq01RZgE3nOHMtkJdj7
         ORHROhHSYiyufqwPA6sLj20GmHpMLbAY4HevSorKoGPogbBJaIYgZXJ0CHGsBo196nOP
         Dx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770116602; x=1770721402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h/fgvm9k9I3pQj36j4/Ol8L8Z8tktEJAYn/oo6tMALo=;
        b=g5BBpy3ntoWNpapFMChLDYOYuOOPvNHsNfdUVHsTaaRLbaKoAsJHr7yPRQzeZnFPB5
         RXdXfOSEvNamgc2mdbcmU8KLLeiycpvWsJygA0U6YO1pI6/dVDPbOnieZwkHKwvuU37O
         O8UM93UxqnNEPrzjsfq8Fn5uyJnEDZZ9Y+59Ai6g5z/ZkLVcdlRvgUNop1WIXArEYUpq
         CBOBRuS6s/nQU/YTdUG6NgMtJ6GalO9QkS4kScq0EOTQ4ICmiMshDbZO/Pa6WR/hzyri
         gJowRrgtBjtoeNXRe9naBL436/dNdMGJ1bEBN7oMXORzQf5j/FYxBpCjct0KFkoL3TXk
         /9uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKs9+lDMV7f80LBglNgKrca2n80Z+wUIsRQJPu4E1/dIJwRNa3YkVDd7B7Ys9Gv3X2PWUykMHrktaM4AQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxfEmoZZitu+7Rmai6+jQ8OzbcWQ27QiXkbZJTr3ghH0lMRlhc5
	Gg3kXydV3SlotxmTfqgxZMxhvTbgiEdxXscd+fYZcK6kCjAglJt7gyY3ZBRAPIIw4A9DSGyA6Ep
	1W2lhwJOUcdLFQuwC9krLm3Kd/ipssnU=
X-Gm-Gg: AZuq6aLpOtUKOY0NTWXaBEIojkZuEFX9+mXOUoo8hgKC4zbnU6t9oiVPfpbjsVLtslA
	r3xN4Uf2U8JOw2ZpY8MKH64gI1PEuUaUkbSQ/vmRcW7FiA3XazJj7kGl6sKrqO9huk+ZMhAc2wY
	nBbVTRpMTdgHp1Womlzrvvnd/bSrdwH3fFr3eOExLxNqIDX78xjd5hP7rojRlMMKCv0kUuiqn2u
	E1ZngPZkcHdkDUFWURA9pLXBvSFhMReJF+s7vPn29/aNGkMfRu/toTtIWcDFcYVpGIQQK5pzwmK
	cFtXZomwPD/JKVS8QpG8PRYq99GN0Q==
X-Received: by 2002:a05:6830:4129:b0:7cf:e4a1:8a9d with SMTP id
 46e09a7af769-7d1a5297c29mr8159047a34.14.1770116602510; Tue, 03 Feb 2026
 03:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260201130334.3107-1-sef1548@gmail.com> <20260201130334.3107-2-sef1548@gmail.com>
 <20260201224801.609e94d0@pumpkin>
In-Reply-To: <20260201224801.609e94d0@pumpkin>
From: Nick Huang <sef1548@gmail.com>
Date: Tue, 3 Feb 2026 19:03:09 +0800
X-Gm-Features: AZwV_QhdUgCdkKepFW4cAvOKDupDDsaAd1xiSEssbfuI1gzYSGsQjtdmNg1EZyE
Message-ID: <CABZAGREQwVUfRQkkTTXUYD_Uvkf0Wxa=dj7r_r85vMsTnUn67A@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzJdIEFDUEk6IG5zcmVwYWlyMjogUmVwbGFjZSBPKG7CsikgYnViYg==?=
	=?UTF-8?B?bGUgc29ydCB3aXRoIE8obiBsb2cgbikgc29ydF9yKCk=?=
To: David Laight <david.laight.linux@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, paladin@ntub.edu.tw, kusogame68@gmail.com, 
	ceyanglab@gmail.com, n1136402@ntub.edu.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David Laight <david.laight.linux@gmail.com> =E6=96=BC 2026=E5=B9=B42=E6=9C=
=882=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=886:48=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Sun,  1 Feb 2026 13:03:33 +0000
> Nick Huang <sef1548@gmail.com> wrote:
>
> >    Replace the O(n=C2=B2) bubble sort implementation in acpi_ns_sort_li=
st()
> >    with the kernel's sort_r() function which uses heapsort, providing
> >    O(n log n) time complexity.
> >
> >    This improves performance for large ACPI package lists while also
> >    reducing code complexity by leveraging the existing kernel sort API.
>
> What is the break even size?
> While the heapsort is O(n long n) it is also more complicated.
> There is also the cost of the function call - especially with all the
> mitigations that distro kernels are likely to enable.
>
> For large datasets the d-cache locality of both sorts is particularly hor=
rid.
> It is almost certainly better to allocate an array of index:value pairs
> and sort that.
> For very big datasets you want to sort small sections (that fit in the
> d-cache) and then use merge sorts (also O(n log n)) to combine them.
> (Yes - this is how you sort data with 3 mag-tape drives....)
>
> Oh, in any case, write separate functions for ascending/descending.
>
>         David
>
Hi David

  Thank you for your reply and the detailed feedback.


   I ran KUnit benchmarks to investigate your questions.


   =3D=3D=3D Break-Even Point =3D=3D=3D


   I compared bubble sort vs heapsort across various array sizes:


     N  | Bubble(ns) | Heap(ns) | Faster

    ----|------------|----------|--------

      2 |         61 |       99 | bubble

      3 |         63 |      115 | bubble

      4 |         78 |      163 | bubble

      5 |         96 |      215 | bubble

      6 |        119 |      260 | bubble

      8 |        177 |      388 | bubble

     10 |        257 |      539 | bubble

     12 |        415 |      721 | bubble

     16 |        726 |     1044 | bubble

     20 |       1106 |     1484 | bubble

     32 |       2854 |     3091 | bubble


   Bubble sort is faster for all tested sizes. The break-even point was not

   reached within N=3D32, which covers all realistic ACPI use cases:


     - _ALR: 2-10 entries (ambient light response)

     - _CST: 2-8 entries (C-states)

     - _PSS: 5-20 entries (P-states)

     - _TSS: 2-16 entries (T-states)


   As you noted, heapsort has additional overhead from function calls and

   mitigations that outweigh its O(n log n) advantage at small N.


   =3D=3D=3D Separate Ascending/Descending Functions =3D=3D=3D


   I also tested combined vs separate sort functions as you suggested:


     N  | Combined(ns) | Separate(ns) | Saved

    ----|--------------|--------------|------

      4 |           84 |           75 |  11%

      8 |          179 |          175 |   3%

     16 |          737 |          806 |  -9%


   The results are mixed. Separate functions show marginal improvement at

   small N, but the combined function performs better at N=3D16, possibly

   due to instruction cache effects.


   =3D=3D=3D Conclusion =3D=3D=3D


   Given these results, replacing bubble sort with heapsort would likely

   degrade performance for typical ACPI workloads. The existing bubble

   sort implementation appears to be the right choice for this use case.



--=20
Regards,
Nick Huang
