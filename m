Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423B625D540
	for <acpica-devel@lists.linux.dev>; Fri,  9 May 2025 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746818771; cv=none; b=sy1JJ0vXmb5YPUnpBqkcHfk3G0Mvam6tNHxhRkWEX/3Yq/vETp1c9tCMkiLYHERebzwzHb859z1F4RIZ+hfwlUkMY46S3lRxA4zlHI4R9qgRbSbCp3P/3wHxgNd8HwwPp1osc3Yne22Gqsyqarx3eOwdiFvmR+k16HobB5/LbNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746818771; c=relaxed/simple;
	bh=KX5wDv025P3mKqHFA4TQwWOmuFq2r9EE0CNJ7idXzJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2uP/nixg9LaXU6qLwbK3EgFWj2mu6E08mlYjrjVsgfMxhKBoxzpNtkZvi3YpWwiA6RRvp7nuqNKVXAE8gyLrjbJzwkivreHH/55usOkh9RVj+4I7p9qNjt1G/mcxh3oku/BjchlddPEDmhDqFx4ZKsjV19mDlp+SAdQW2yPuSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr8WBHF/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr8WBHF/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EF4C4CEF6
	for <acpica-devel@lists.linux.dev>; Fri,  9 May 2025 19:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746818770;
	bh=KX5wDv025P3mKqHFA4TQwWOmuFq2r9EE0CNJ7idXzJU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xr8WBHF/As8nQMEvL8FaQrG2ELOdaZhH6DDcTkuOQLzv33IjcDnrAhhZsw1ybmXKs
	 am+6romLsSY6fCFrD36JV02epI5VtEaGjKNuEM6ZY7K8KfVF323TJXcjULBPnwbNiZ
	 9fvot9g/9IFOW48/XRjkIXj9XIglO0frK6X3WqfdfDR1wy4Ugdkwedp9Fl9mgYHUOs
	 UfNNQX/8nrK3hcu7HIn+A8+6myAg1ZiTTQ3WHHuIXgT0Nl3uPAS4gLvKMyPHBxJLB6
	 Z2xJ6RrqZDMOIw+lim974APvwNisG2s1rAELeNj3anfeE+c5Q5EGQCFRe/LyBFHUZs
	 rAiWFoWj4ODFA==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-731e277a6b0so2315468a34.1
        for <acpica-devel@lists.linux.dev>; Fri, 09 May 2025 12:26:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9/2I2KW3SAkpfennHfL428WXd32t4CcUk/pi18jrLSg7TgpWK3L2lNZ9Qgtei8wXat0/25pfsldc/YJw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxgJlQCkYzgzcTfhQU6936S39mDO/I06fi4QfPuA3i0USAiWARF
	5FPyRu9lRcwNQ2eeJDRWfUWxpgc3UV2pyEXxlhTdgP0gGQXZc3GO5qtV25tOvDRHQS/NekwFBTs
	pWBTiSIrIiIsLrdklcVcrzxC0Cac=
X-Google-Smtp-Source: AGHT+IE8GmkxlxVpNu70SxPUR8JfgrMMof4cUdqC8atc5kXLt5jTxXJF796doymX5wIonc+sU/pvkvYOVBUg3NqQh7A=
X-Received: by 2002:a05:6871:6a2:b0:2d4:edac:d9a9 with SMTP id
 586e51a60fabf-2dba42a3b8bmr3120008fac.10.1746818759173; Fri, 09 May 2025
 12:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-5-zaidal@os.amperecomputing.com> <CAJZ5v0j-84MDP10YEL48GTPWy1SqHWAA_Dbq+X-k3PFi9brZPw@mail.gmail.com>
 <aBzwpS6t3V4zwrxn@zaid-VirtualBox>
In-Reply-To: <aBzwpS6t3V4zwrxn@zaid-VirtualBox>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 21:25:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g9qbKWHgL5gmSQN3vAbj3DUZH0LSdxtY2O5JXscbsGFg@mail.gmail.com>
X-Gm-Features: ATxdqUHdAxHQrEBtvpSUAWFQbifenSse2G705J-U4DlXfrsupwkHQXQctlVxRWs
Message-ID: <CAJZ5v0g9qbKWHgL5gmSQN3vAbj3DUZH0LSdxtY2O5JXscbsGFg@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] ACPI: APEI: EINJ: Remove redundant calls to einj_get_available_error_type
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, james.morse@arm.com, 
	tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com, 
	Jonathan.Cameron@huawei.com, ira.weiny@intel.com, Benjamin.Cheatham@amd.com, 
	dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com, 
	u.kleine-koenig@pengutronix.de, john.allen@amd.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 7:58=E2=80=AFPM Zaid Alali <zaidal@os.amperecomputin=
g.com> wrote:
>
> On Wed, May 07, 2025 at 01:34:35PM +0200, Rafael J. Wysocki wrote:
> > On Tue, May 6, 2025 at 11:38=E2=80=AFPM Zaid Alali
> > <zaidal@os.amperecomputing.com> wrote:
> > >
> > > A single call to einj_get_available_error_type in init function is
> > > sufficient to save the return value in a global variable to be used
> > > later in various places in the code. This commit does not introduce
> > > any functional changes, but only removing unnecessary redundant
> > > function calls.
> > >
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> >
> > Does this patch depend on patches [1-3/7]?  If not, I can pick it up
> > as an optimization.
> Hi Rafael,
>
> No, this patch is does not depend on 1-3 patches. You can pick it up!

Now applied as 6.16 material, thanks!
