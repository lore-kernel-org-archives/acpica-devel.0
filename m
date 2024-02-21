Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5712A4D59B
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 21 Feb 2024 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517105; cv=none; b=VVs4Zx09m1mjlbsREYdd9tSypKvYS6jWz8r7CLiE4z4cggiJQmV16aIklCnWHqx8pZaNzsLnCrzOE3dZaH12lqWarQMqeVlu500VSSoe58rfs/NTYPOHMUUt8Zi7AZEfp/nWzOEotUgm83oxjpl2fzKWX0pIP4a8/2UJoDuviEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517105; c=relaxed/simple;
	bh=FUiL7Sai6eHgLUPNSBxzFpKmZumr4AKqeHY88JAN8u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fM8JAulvAGDz25+ctRsokX7rfRho1Q8SD03sxvHx60yBc6qOq3nGU+1kJAaY3vwed2BPy+IyqMCVW/WAtLsk2QpCKbtQEfqabwZVaGEI1v7RLS+g8gmzG3tTjoQubwGB1UU/XZsPwxOJ5Zk/KtGk+nRFYg74J0xHO8iJNFVPNSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E4853400C6
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 21 Feb 2024 12:05:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.398
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 48BPaLFd6kDF
	for <acpica-devel@lists.linuxfoundation.org>;
	Wed, 21 Feb 2024 12:04:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.44; helo=mail-ot1-f44.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AB80A40017
Authentication-Results: smtp2.osuosl.org; dmarc=fail (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB80A40017
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AB80A40017
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 21 Feb 2024 12:04:56 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e46cfe4696so7222a34.0
        for <acpica-devel@lists.linuxfoundation.org>; Wed, 21 Feb 2024 04:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708517095; x=1709121895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bd70CzVDcJLuCi0Mf2lAcBkkasP1RaXoMIQ30r8qKRE=;
        b=XFWvhu+x9YXPwjrXf2FGnXQdBzXYtJSQKy4R+XnS9Knau467K+3JkACY65gszL+NU4
         wj8xBgEOTrWobA8UB2nZUMZ798MeAmreFlRIBEwJK9ItR3vyiVgQRkOCs0P7EdmfQmYn
         F5DBea/z7190NrT+ti2ND1bLfQL9UcF/7CPX8up2xlt6LmNMKNd6obUQGy9ivZBVoNU6
         dBed77AydLgAt74WBn1t/tXFLZDMwpaFkQmTqm1wPdH6zSOMAseK3EfGIfYk8a5rJ3nL
         dMCO+hZLPJouALXcxoXYGXoz9SmRuw3Q3KDtUJMstBn+MCDb195IVMHT6pp3TplS/j6I
         seaA==
X-Forwarded-Encrypted: i=1; AJvYcCXdkpfm2KzkmYJo6uLNtvPJPK1BdjA8ZYCR8Ujt3iHXdu8N9LfgoywYdmWc/dI7se8sNoAYZ/Z55B63Fi5FmIntciYJ7UQSqsDAABkIQWgTYUCoREO+yw==
X-Gm-Message-State: AOJu0Yz0bdUuytwsr/FwI/GPJzhSbyDEKDXh/3NGAXDUGv2WnU53Tejk
	pxc69uv5LGMAIBAZWlOD2bGZjONYzYH0+UnEvuyE7QvFKIvPazpgSg7MokLnKk60vYUHwX3557C
	Z/2UZJ6eiHCJr1t6qMnBfkIohTpM=
X-Google-Smtp-Source: AGHT+IHeaissm6JEdH7EPypXS7T8sNhbX/Qz4NatOo4m9Df9Q37Mfl1C4Kc8/AZCO27nxtnXyK+7klVD3+esvTxFkJA=
X-Received: by 2002:a05:6820:1f8c:b0:59f:f650:61bb with SMTP id
 eq12-20020a0568201f8c00b0059ff65061bbmr5425790oob.0.1708517095273; Wed, 21
 Feb 2024 04:04:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk> <E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
 <CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
 <ZdSMk93c1I6x973h@shell.armlinux.org.uk> <ZdTBtt0oR6Q1RcAB@shell.armlinux.org.uk>
 <20240220162406.00005b59@Huawei.com> <CAJZ5v0i0c3bg8E9yuRk00VAEW5isZ4N-mbnhRuTR8aiFLXo1_A@mail.gmail.com>
In-Reply-To: <CAJZ5v0i0c3bg8E9yuRk00VAEW5isZ4N-mbnhRuTR8aiFLXo1_A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Feb 2024 13:04:43 +0100
Message-ID: <CAJZ5v0hu32UCLPO6txptfn1DxCNqdYc+Ls-yNa09LdzhroyddQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from acpi_processor_get_info()
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, linux-pm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	kvmarm@lists.linux.dev, x86@kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, 
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 8:59=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Feb 20, 2024 at 5:24=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Tue, 20 Feb 2024 15:13:58 +0000
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >
> > > On Tue, Feb 20, 2024 at 11:27:15AM +0000, Russell King (Oracle) wrote=
:
> > > > On Thu, Feb 15, 2024 at 08:22:29PM +0100, Rafael J. Wysocki wrote:
> > > > > On Wed, Jan 31, 2024 at 5:50=E2=80=AFPM Russell King <rmk+kernel@=
armlinux.org.uk> wrote:
> > > > > > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_=
processor.c
> > > > > > index cf7c1cca69dd..a68c475cdea5 100644
> > > > > > --- a/drivers/acpi/acpi_processor.c
> > > > > > +++ b/drivers/acpi/acpi_processor.c
> > > > > > @@ -314,6 +314,18 @@ static int acpi_processor_get_info(struct =
acpi_device *device)
> > > > > >                         cpufreq_add_device("acpi-cpufreq");
> > > > > >         }
> > > > > >
> > > > > > +       /*
> > > > > > +        * Register CPUs that are present. get_cpu_device() is =
used to skip
> > > > > > +        * duplicate CPU descriptions from firmware.
> > > > > > +        */
> > > > > > +       if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->i=
d) &&
> > > > > > +           !get_cpu_device(pr->id)) {
> > > > > > +               int ret =3D arch_register_cpu(pr->id);
> > > > > > +
> > > > > > +               if (ret)
> > > > > > +                       return ret;
> > > > > > +       }
> > > > > > +
> > > > > >         /*
> > > > > >          *  Extra Processor objects may be enumerated on MP sys=
tems with
> > > > > >          *  less than the max # of CPUs. They should be ignored=
 _iff
> > > > >
> > > > > This is interesting, because right below there is the following c=
ode:
> > > > >
> > > > >     if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> > > > >         int ret =3D acpi_processor_hotadd_init(pr);
> > > > >
> > > > >         if (ret)
> > > > >             return ret;
> > > > >     }
> > > > >
> > > > > and acpi_processor_hotadd_init() essentially calls arch_register_=
cpu()
> > > > > with some extra things around it (more about that below).
> > > > >
> > > > > I do realize that acpi_processor_hotadd_init() is defined under
> > > > > CONFIG_ACPI_HOTPLUG_CPU, so for the sake of the argument let's
> > > > > consider an architecture where CONFIG_ACPI_HOTPLUG_CPU is set.
> > > > >
> > > > > So why are the two conditionals that almost contradict each other=
 both
> > > > > needed?  It looks like the new code could be combined with
> > > > > acpi_processor_hotadd_init() to do the right thing in all cases.
> > > > >
> > > > > Now, acpi_processor_hotadd_init() does some extra things that loo=
k
> > > > > like they should be done by the new code too.
> > > > >
> > > > > 1. It checks invalid_phys_cpuid() which appears to be a good idea=
 to me.
> > > > >
> > > > > 2. It uses locking around arch_register_cpu() which doesn't seem
> > > > > unreasonable either.
> > > > >
> > > > > 3. It calls acpi_map_cpu() and I'm not sure why this is not done =
by
> > > > > the new code.
> > > > >
> > > > > The only thing that can be dropped from it is the _STA check AFAI=
CS,
> > > > > because acpi_processor_add() won't even be called if the CPU is n=
ot
> > > > > present (and not enabled after the first patch).
> > > > >
> > > > > So why does the code not do 1 - 3 above?
> > > >
> > > > Honestly, I'm out of my depth with this and can't answer your
> > > > questions - and I really don't want to try fiddling with this code
> > > > because it's just too icky (even in its current form in mainline)
> > > > to be understandable to anyone who hasn't gained a detailed knowled=
ge
> > > > of this code.
> > > >
> > > > It's going to require a lot of analysis - how acpi_map_cpuid() beha=
ves
> > > > in all circumstances, what this means for invalid_logical_cpuid() a=
nd
> > > > invalid_phys_cpuid(), what paths will be taken in each case. This c=
ode
> > > > is already just too hairy for someone who isn't an experienced ACPI
> > > > hacker to be able to follow and I don't see an obvious way to make =
it
> > > > more readable.
> > > >
> > > > James' additions make it even more complex and less readable.
> > >
> > > As an illustration of the problems I'm having here, I was just writin=
g
> > > a reply to this with a suggestion of transforming this code ultimatel=
y
> > > to:
> > >
> > >       if (!get_cpu_device(pr->id)) {
> > >               int ret;
> > >
> > >               if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->i=
d))
> > >                       ret =3D acpi_processor_make_enabled(pr);
> > >               else
> > >                       ret =3D acpi_processor_make_present(pr);
> > >
> > >               if (ret)
> > >                       return ret;
> > >       }
> > >
> > > (acpi_processor_make_present() would be acpi_processor_hotadd_init()
> > > and acpi_processor_make_enabled() would be arch_register_cpu() at thi=
s
> > > point.)
> > >
> > > Then I realised that's a bad idea - because we really need to check
> > > that pr->id is valid before calling get_cpu_device() on it, so this
> > > won't work. That leaves us with:
> > >
> > >       int ret;
> > >
> > >       if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> > >               /* x86 et.al. path */
> > >               ret =3D acpi_processor_make_present(pr);
> > >       } else if (!get_cpu_device(pr->id)) {
> > >               /* Arm64 path */
> > >               ret =3D acpi_processor_make_enabled(pr);
> > >       } else {
> > >               ret =3D 0;
> > >       }
> > >
> > >       if (ret)
> > >               return ret;
> > >
> > > Now, the next transformation would be to move !get_cpu_device(pr->id)
> > > into acpi_processor_make_enabled() which would eliminate one of those
> > > if() legs.
> > >
> > > Now, if we want to somehow make the call to arch_regster_cpu() common
> > > in these two paths, the next question is what are the _precise_
> > > semantics of acpi_map_cpu(), particularly with respect to it
> > > modifying pr->id. Is it guaranteed to always give the same result
> > > for the same processor described in ACPI? What acpi_map_cpu() anyway,
> > > I can find no documentation for it.
> > >
> > > Then there's the question whether calling acpi_unmap_cpu() should be
> > > done on the failure path if arch_register_cpu() fails, which is done
> > > for the x86 path but not the Arm64 path. Should it be done for the
> > > Arm64 path? I've no idea, but as Arm64 doesn't implement either of
> > > these two functions, I guess they could be stubbed out and thus be
> > > no-ops - but then we open a hole where if pr->id is invalid, we
> > > end up passing that invalid value to arch_register_cpu() which I'm
> > > quite sure will explode with a negative CPU number.
> > >
> > > So, to my mind, what you're effectively asking for is a total rewrite
> > > of all the code in and called by acpi_processor_get_info()... and tha=
t
> > > is not something I am willing to do (because it's too far outside of
> > > my knowledge area.)
> > >
> > > As I said in my reply to patch 1, I think your comments on patch 2
> > > make Arm64 vcpu hotplug unachievable in a reasonable time frame, and
> > > certainly outside the bounds of what I can do to progress this.
> > >
> > > So, at this point I'm going to stand down from further participation
> > > with this patch set as I believe I've reached the limit of what I can
> > > do to progress it.
> > >
> >
> > Thanks for your hard work on this Russell - we have moved forwards.
> >
> > Short of anyone else stepping up I'll pick this up with
> > the help of some my colleagues. As such I'm keen on getting patch
> > 1 upstream ASAP so that we can exclude the need for some of the
> > other workarounds from earlier versions of this series (the ones
> > dropped before now).
>
> Applied (as 6.9 material).

And I'm going to drop it, because it is not correct.

The problem is that it is going to affect non-processor devices, but
let me comment on that patch itself.
