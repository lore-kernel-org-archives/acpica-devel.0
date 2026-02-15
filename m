Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79B81519B4
	for <acpica-devel@lists.linux.dev>; Sun, 15 Feb 2026 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771118798; cv=pass; b=osGMEsNuBWVPYyyIaRhgTodoBOJqYXRgysJUauM5YgitSFRSMxALHqccuJHMIJdJiu8n6UHFjHPYNcWgDPbTeTugYvaYnraonyKr0FC+okf2qFJ6QVJukbCpv7QZjmbI7rflvcc+kb9YdG5DcqZY7edjRH0e2ET/RGLZ7rpQRDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771118798; c=relaxed/simple;
	bh=IzdGBGFCpilT6AeHHAkF6quAsV2MXMS40zGkPPdg0HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4n8jwuBvHfhbvLn9KkoeEogBKSnU8kMIP5TtaT0ZQeCnlEj8wQCOIjxXKFJeMinlOtwgP2/5c9Vi1qf7kRat/DdmYCMK2+dltacTTToS1DRZ4gSXZlVpZHhis3RCle4Z8vEXEaKJ01nheHP4Zyn3sfpgyWQwVWtI7e17BgFZmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7FcJDQK; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7FcJDQK"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d195166b2cso1475909a34.3
        for <acpica-devel@lists.linux.dev>; Sat, 14 Feb 2026 17:26:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771118796; cv=none;
        d=google.com; s=arc-20240605;
        b=dZZtsAM8VRfZozjzLTl7Jevm2gqyCUK8D/3CBo7JaZL0jUhW5vrxMXdXPnbgHAxwRo
         LKjfkhsbpZQRDXyqcwzzBNhI4HLgqWMUNCLiypSjdZQCjBQIZFSqBocBhabOMT+/kPWU
         ieG84tX7EB4bnJ793lOnwxEQbytTYYcTmBtOrbg/im+AVV7Z4GGKqLyjBobsvCVA6XTM
         MUb6YTs1LlbZie55ARraQw+TXZZrijtMXd6Pw9OEDHOUNiCLGqIUDQF2uZug2Y32ZSuX
         Vy+ymVPB6dvyPUAZ9q58G5VOw5wrjru/dSGt8Fpy77VE0FFOlTMhWLDLsQm/q6YBXwxr
         R2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oc6M0vaTZcmARSII2t0Y1J43OpPVtanNHASTzTLjxa4=;
        fh=zpevZr2dOPyUaUClmlbWnNbM0bb8xVKTJ8reREtnZfE=;
        b=FY41sT3Jbe70TCmd+vXgdRelRtVQsMm4R5h/IIFFwY5iPHuwjQoHiivkX8Hhb4/04v
         Xuqc0dCBw37D4fOpsGzlSj/iQgvjhYwDVQBv5Ipocc25bDInviXQ1DfKB90hBURL+H/t
         /GBRR5dqOF49Azovd4jhA27fqJSK6uosfUoty/Jq2WVtQSGXsx3/+1725qTx04ApvBg0
         it5MLWdnJQH3udLvhSEb266//Gq4ucLLx1zYqR3ZLb7IwLdAk0KO/S8JIBpKybcbHzRe
         GN8vrYDAkDQloY0swo9tkle8tmiu2JK2/S2kMzPwa8721oBJHqlu2dbgO9lnM2+b/v1p
         rGLA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771118796; x=1771723596; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oc6M0vaTZcmARSII2t0Y1J43OpPVtanNHASTzTLjxa4=;
        b=e7FcJDQK7ZzlI7FW6t4f1PAY7QiBgluUBf8N3FcNDm73ocL/YVbGXm5S190nNzA0+U
         xjXgBXS5pf8EoCDCsPBxyrt9F+mkebTRRxwjs9grUlM/ygr/kZ4OxJZ3n5uso2yxmYhc
         UkBPdXRvVVnIRkYb2XViWwv+d8dSsdZnn3EweKNxI0jA9VMdhrJgKDEBam3ORDsNvtTI
         JWSUuJOjkVjyqGZUzzS6kBo5cOJxnwCzzNNUVIs/lOGE0Wg4RpWp2OwDjAERrOTs4TyF
         ACqL/wG+PPAfuDSGtjahsSPW45i3KT28/3p+GxGK6apqunuTp9ivmyS/G4W8TshcBkgd
         1xQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771118796; x=1771723596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oc6M0vaTZcmARSII2t0Y1J43OpPVtanNHASTzTLjxa4=;
        b=FW82ibdXk7WeDYfqyA5OQMs2xCe0pqGv9gIJjZzboTJfAcaAN5NkYsR2xe2Qloft1D
         AN5G/uLCJIf3W0y7FxKr8E9IYJVSYAEPi+gdBFM05p5ckAgLHJCimKOrUD8gnIUYQKx0
         j9X1LpD16REjTx5a0QD2ltsURSYPHBsL8NvW009IuL0yxvSXEMTyAFV8B6ZQ60perFes
         26XFOlIto09dIrZ5Z6haz1I58K0gfp9wkXmRkLXnaYqN6Htn6lHms/bSKPtGYfKSHjAr
         qZEX19RvjGdW1SPcSmfHhEq1tXC4CEgs5S/YCjRw6PI5EZjCVTTiiMyuRK5YJdololNI
         UNpg==
X-Forwarded-Encrypted: i=1; AJvYcCUJwEe4wf1VsHw1VdDwam71db0sIN0HIkzSImYY0H7u6DwnIqyxNqutWjngvVGWib1HVZ+n+Wdz5kB0iaA=@lists.linux.dev
X-Gm-Message-State: AOJu0YxZkANiAfa4gaRHPk6KY/UHSkQ/p48YHgdBXgKqlBTeeUWBOnuM
	6//dbBf6pHAwcMlneKNs2jAKbRvcQv2+0vvlqde8A5F7pK+6M2O8vhfiCW/TwqpimnzsGwO5NnQ
	GZxr5yKGIz3G1mRAGqMmh7D+va6sSF+Q=
X-Gm-Gg: AZuq6aITAE6MzNQW8U6ND1/74ZnjphTJ2aZZFAI/T6p76Yxdvs6CMMsGDZbfwpVu/CI
	ymd2di04pFJraLKsIwLAkvE40ZRSImyYkWSP1nrYWVaBMVwOHVVU6KP3p/4V7QlQiJOBIeckWV/
	VpR2bBz2NlfFw5K2hyTjeflWk6fhqhb8b00NTXfE9BAZEv58rfKoYqnyC2lhXBjry3YzYe3sNOe
	aUGttt8UkbvpvY9WhdwT1w1ommgScjVhouiaKNWqsRvJptdGaiUNHKnvRLH0BZcXX8SZ7SEQQSr
	JAOXN1CUV6sZJiIfYE6Io6BTPuIC9nRLsI+Nj1g2ug==
X-Received: by 2002:a05:6830:90d:b0:7d1:9160:7b98 with SMTP id
 46e09a7af769-7d4c302911dmr3548600a34.15.1771118796565; Sat, 14 Feb 2026
 17:26:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260201130334.3107-1-sef1548@gmail.com> <CAJZ5v0jtroqWSwjF3KQsmVLPYEE4a59-cxg5ZV1BAGmJtf-Q_Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jtroqWSwjF3KQsmVLPYEE4a59-cxg5ZV1BAGmJtf-Q_Q@mail.gmail.com>
From: Nick Huang <sef1548@gmail.com>
Date: Sun, 15 Feb 2026 09:26:25 +0800
X-Gm-Features: AaiRm53qbm9Rwn1Tz4PKVW8wtkl0gZZcYDHeT8RMibrNYsmuPOhzM3hobI7ScGM
Message-ID: <CABZAGRH7SAd2r-n4q4u=7Dt-KJnAtUTLqmWM-H8GAejq=zgttA@mail.gmail.com>
Subject: Re: [PATCH 0/2] nsrepair2: Improve sorting performance and add tests
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	paladin@ntub.edu.tw, kusogame68@gmail.com, ceyanglab@gmail.com, 
	n1136402@ntub.edu.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rafael J. Wysocki <rafael@kernel.org> =E6=96=BC 2026=E5=B9=B42=E6=9C=8813=
=E6=97=A5=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:40=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Sun, Feb 1, 2026 at 2:03=E2=80=AFPM Nick Huang <sef1548@gmail.com> wro=
te:
> >
> >    This patch series improves the ACPI nsrepair2 sorting implementation
> >    and adds comprehensive KUnit tests.
> >
> >    Patch 1 replaces the O(n=C2=B2) bubble sort algorithm in acpi_ns_sor=
t_list()
> >    with the kernel's sort_r() function, which uses heapsort to achieve
> >    O(n log n) time complexity. This improves performance when sorting
> >    large ACPI package lists (e.g., _PSS, _TSS) while reducing code
> >    complexity by leveraging the existing kernel sort API.
> >
> >    Patch 2 adds KUnit tests to verify the repair functions in nsrepair2=
.c,
> >    covering:
> >      - ACPI operand object creation (integer, string, buffer, package)
> >      - Namespace node creation and NAMESEG comparison
> >      - Package structures for _PSS, _CST, _ALR, _PRT methods
> >      - _HID string format verification
> >      - _FDE buffer expansion
> >      - Sorting logic with ascending/descending order
> >
> >
> >
> > Nick Huang (2):
> >   ACPI: nsrepair2: Replace O(n=C2=B2) bubble sort with O(n log n) sort_=
r()
> >   ACPI: acpica: Add KUnit tests for nsrepair2 repair functions
> >
> >  drivers/acpi/acpica/nsrepair2.c      |  87 ++-
> >  drivers/acpi/acpica/nsrepair2_test.c | 854 +++++++++++++++++++++++++++
> >  2 files changed, 916 insertions(+), 25 deletions(-)
> >  create mode 100644 drivers/acpi/acpica/nsrepair2_test.c
> >
> > --
>
> The ACPICA code in the kernel comes from the upstream ACPICA project
> (hosted on GitHub) as described in
> Documentation/driver-api/acpi/linuxized-acpica.rst.
>
> Changes to that code need to be made upstream from where they are
> picked up automatically after every upstream ACPICA release (or you
> can speed that up if need be by sending a Linux patch based on an
> upstream ACPICA commit).
>
> As for the test part, I'm not sure how useful it would be given the above=
.
>
> Thanks!

Hi Rafael J. Wysocki

Thank you for the reply. I will submit the changes via a Pull Request
to the upstream ACPICA GitHub repository as suggested.
--=20
Regards,
Nick Huang
