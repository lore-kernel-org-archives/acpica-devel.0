Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEC528A2C1
	for <acpica-devel@lists.linux.dev>; Thu, 13 Feb 2025 21:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739482580; cv=none; b=AfifFw3A2zXMF5/fgK071ozIjcy1ZM5QQ6wYPQ8FR9Pe/l4pJTD2IQS4YoO/FMCpO4If5m/K1Ur2jMJe/ucNAdsTaGtUUHx9ttTpIxwoVw5QIa2izvT9yIuqIr0YT65lMEzafzp547ykn+jayaHF2zNbFJ5aFDNJdz+3wJylD/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739482580; c=relaxed/simple;
	bh=CK+vbXcbSgW4rGdSQOrgX37aHaOo6VgVNeLHQCkbKts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucp8zTPJ+7S2c57RNg4vqRhUttdN80h0pvk567m/S/Dvp/fDHpZX3RQHW39T2xS7L0qyajBbSZWB6ftKciyw0h00pq260aEpzEdXtT2TjuXueDBWmVza+gRn1YitFB3U2Vo+8kvltbdRxIDg2fTmjvucoXplalJr17l1fQD+EsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPtplcf/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPtplcf/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967E3C4CED1
	for <acpica-devel@lists.linux.dev>; Thu, 13 Feb 2025 21:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739482579;
	bh=CK+vbXcbSgW4rGdSQOrgX37aHaOo6VgVNeLHQCkbKts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hPtplcf/5bzDhLESuVE8Bh/rlSUbQoY739FfT6pT9DzgV6c2uWCpnP/1h5y7DfghY
	 k5wI0DJBVoyPdOmr+a9O6BJn0dPvuHpQc4sIlcDJLufieRITwfHq8QoUKP85MJ+vV+
	 oLztJrJSgNm5LYMS6xida6BNrGMnJd5qgir24vzmXwxNdr0Md+n+ZU7q7yCAYrZUYS
	 Gw7g8GCUmO812sFszdhqst2EMllN7LMctMOAP67IzY8XM/MTZqVMp2xAqujEgB4Ine
	 Xcv4snydNgheR9qC5hhiWiQutYpKC2dz/LHmX2tXXYMD//YF8nRoQ0v5ILhLOKuWGU
	 mqCpVrSKFMwLg==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f4d935084aso613335eaf.2
        for <acpica-devel@lists.linux.dev>; Thu, 13 Feb 2025 13:36:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXr6YnxksfxKNeBQr8Jm96Isduj4vF4Bsh1qRWc/6lFQGXDRtSceTMVSpjfawgzFZb8aLEZcYSPssIHZ0A=@lists.linux.dev
X-Gm-Message-State: AOJu0YwbDCosVeFeYw4L/Kgybn4Q6oxDyPYQ0vkNipfBVeKi+KjbWdbA
	Tr9hrq7wGKX/MRh6dZWaBxk0RVhLz+BzCTSkyHrklfZai0DK35S+vn6q1rmYoHgP/vPhL+6OrpW
	u+kLKeJYC+uvYPo4JlfmNGafB5Yk=
X-Google-Smtp-Source: AGHT+IEFtiQ+UpM2ZtRoj8CTUtLwrkGMcE2jX3wJsB3J96xvLwWFsmOFco5nfniYBNpejwVOOZu0rK5tUOLpFx39oWM=
X-Received: by 2002:a05:6870:ec94:b0:29e:29ac:5ade with SMTP id
 586e51a60fabf-2b8daf9798fmr5677846fac.35.1739482578963; Thu, 13 Feb 2025
 13:36:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Z64iUD8EeF82k9Nt@agluck-desk3>
In-Reply-To: <Z64iUD8EeF82k9Nt@agluck-desk3>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Feb 2025 22:36:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jDOoNb8y5Ht6rUP7OouWWknOKf3ZTcAcuCV+5ZEvbs_g@mail.gmail.com>
X-Gm-Features: AWEUYZmMdONyKlXBJmk2k2btt7NwvxNOpwT88FaXzsvZTMVL7eES7-B4xPe18Sk
Message-ID: <CAJZ5v0jDOoNb8y5Ht6rUP7OouWWknOKf3ZTcAcuCV+5ZEvbs_g@mail.gmail.com>
Subject: Re: ACPICA MRRM support
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, 
	acpica-devel@lists.linux.dev, Saket Dumbre <saket.dumbre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Saket (again)

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
