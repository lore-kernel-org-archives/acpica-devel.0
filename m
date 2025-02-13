Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D4F1547F0
	for <acpica-devel@lists.linux.dev>; Thu, 13 Feb 2025 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477536; cv=none; b=cPgw8gJoDP5UghIdH00c7agv6GdTkH0gmKMj+wtV+tTJs09BkfFWJ6xOytOpl7wtV0y6OGtP8S6YlgRdvzpF/kEUJc9jdBA1hS3KYfr0P6qy/8OprjBsp0iNf6nXmbMCMpKrxI52+FTKcZBgdKzl6Eu4QeWsc/gzcvWFvAZMHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477536; c=relaxed/simple;
	bh=4UtfTY9zieaOYjwynH0tPvjHVW4IZ0oEF4cXexzyaOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMmpYYKWw+546LlaFTDPYjC9MrHf43dQIThqKukEPNokww54PQ3WTz6L4aldDZ89IPSNjo8+CDnnI8/6JnuRQzLlVjdVLXy90FSvqfH5SnBGpZAFFTl/fjAAbynGW6rv6AZA0bYUK5NT4bjH5yOEs/aqVShmz6t6lmkQbkEZMZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhj+NZB0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhj+NZB0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403EFC4CEE4
	for <acpica-devel@lists.linux.dev>; Thu, 13 Feb 2025 20:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739477536;
	bh=4UtfTY9zieaOYjwynH0tPvjHVW4IZ0oEF4cXexzyaOo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dhj+NZB0nBvCV4NhBKdZKMW8jZREcMnEWIqfPM/NZYyb3TS4oTO5+PSAXV55hk9JW
	 K+iR+Xl4tC5WkhlVtXQ9kmjRV9b2pl1m3iqpW36Hi9FsEi2S5XuIKRaO92ORvn5VxY
	 UNHmUkyayXjK0KJo9fjsvJDNQxmyZZbSpFvK8isWGVy+QbCbImcbQaauCC8aya55Z7
	 5w9PjvzU1C74wo0oymsAJWg5hhRMNXBIJTpLW5tkb5sHA6u95Yv4elGmHW+TwWJy+O
	 B/kxMrUP3FkxnzRh8BSjujefcKBZ4MHw4Wel2KFl+SD7cMjeBMAYfRqNE9Pziye+Sj
	 ZeWlh2E9EXkbA==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-726e9659704so375658a34.0
        for <acpica-devel@lists.linux.dev>; Thu, 13 Feb 2025 12:12:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMkNUhsUkOYrq037uKjx2/Ipp1IhgIOEeWVzbEZVs9cTNyq+081dyms41Nuw+KY85Dj1g6DUmuhkqiIsQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YyrwAY55MOy0oMlOSn6w5NszM6Okr5QQEoR5DO1qxwU1zdvov4Y
	OZdu//egZ0+B1HOoqaLpdn3I3ZOqiW2vbvsBO+NK7xVWGs0XsXeJ4z95ngwU3Nq17oGls05vRtE
	6iZhr8Crgy5tRbKI2Uzst+FnUBRs=
X-Google-Smtp-Source: AGHT+IHUb925K+afVeLFlaj2tLrsB841+HPBuvUK3nvJjp5zoYsavuU53gy6ED6o8N8crHrEpNh1OQtHS+MqOVVNVTI=
X-Received: by 2002:a05:6830:391c:b0:71e:1392:80b5 with SMTP id
 46e09a7af769-726fe7fdd85mr3619137a34.24.1739477535534; Thu, 13 Feb 2025
 12:12:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Z64iUD8EeF82k9Nt@agluck-desk3>
In-Reply-To: <Z64iUD8EeF82k9Nt@agluck-desk3>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Feb 2025 21:12:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iW44uZU96M-zKC7gpSfAwaL6-mZrJJnsm6Q0AQANHtFA@mail.gmail.com>
X-Gm-Features: AWEUYZmqdeUERatOcU1WB6Mvb6sNW97xyfnG7l4cccLLPQ-di7dmfmxUTbbppIc
Message-ID: <CAJZ5v0iW44uZU96M-zKC7gpSfAwaL6-mZrJJnsm6Q0AQANHtFA@mail.gmail.com>
Subject: Re: ACPICA MRRM support
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Saket

On Thu, Feb 13, 2025 at 5:48=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> [Resnd in plain text for mailing list]
>
> I=E2=80=99m making a stab at support for the MRRM table (needed for =E2=
=80=9Cregion aware=E2=80=9D perf and RDT).
> Described in the RDT architecture specification. Public version here: htt=
ps://cdrdv2.intel.com/v1/dl/getContent/789566
>
> I think I=E2=80=99m 95% of the way there in this tree:
>
> https://github.com/aegl/acpica
>
> This code can =E2=80=9C-d=E2=80=9D decompile the MRRM table from Simics (=
and the output look right to me).
>
> It can create a template with the =E2=80=9C-T MRRM=E2=80=9D option (creat=
es the table).
>
> But I=E2=80=99m stuck on the =E2=80=9Ccompile=E2=80=9D section. Input fro=
m a .dsl file seems to be parsed correctly.
> But output of the first subsection doesn=E2=80=99t fill in the =E2=80=9CL=
ength=E2=80=9D field (which I thought the DT_LENGTH =E2=80=9Ctype=E2=80=9D =
should do).
>
> None of the other 4 subsections make it into the output file.
>
> My code is based around how the SRAT DtCompileSrat() function is written.
>
> Did I miss something while simplifying that down to what is needed?
>
> Any pointers gratefully received.
>
> -Tony
>
>
