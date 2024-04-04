Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A23813C3F9
	for <acpica-devel@lists.linux.dev>; Thu,  4 Apr 2024 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272592; cv=none; b=CX7hccePm1YnKu7qsrrbELr9rhaysc1lPJLC5m8xHi+1HjdIM1J0bP3P7C5RviiwvLpdWKmklpY4ZnkwO2Ft31PM0L1LNB6T8m3yPrxwvZWabenTUk+6NyNIBpeD9pmGLhdQzs7hXODHFj0pHTWqJfkbIXUFbTt52JcS2ZDJbCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272592; c=relaxed/simple;
	bh=APEooEWI1lH4C+bL4GyHHSZ5KchOvO14ONUoet0RRr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glmV+DTD96EkOb9wlUMt8gMTpnqyMu79MqbbG1HfnMklsdNeDIRiIgqVKbD1OmNeDNwSESolhvFDJdMz2TxWKV0paVi2KLSjIeAJC5G1pig1qpht4I/oGS0k539nMsg7S68zRPv1MIpTsAMR6wJrfMFA85JRU60uzSB45Go8EYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k6uJnnRy; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6uJnnRy"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc74435c428so1624565276.2
        for <acpica-devel@lists.linux.dev>; Thu, 04 Apr 2024 16:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712272588; x=1712877388; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=px33Bjt2eInHJiP0NeuRgUTO3pjhGqqLrEOvRjM23DI=;
        b=k6uJnnRyelfMoRtV/5qfV0rHvduD8GP6W0g9NyQP1+OY0Of3J1pYQqqgy7KwmqV0ly
         Va2PARGEin+V8jSMVKstcS2nobJtejRS2AGB+/p2K689uPJbAI3CPMDNt1n8pXPK2B50
         ikEyci6b9s1ulYRBPp/TQ01IstkFukK5newMWja6h6Y1JIr7nEFWSetRf2F2cH3aI0HN
         ZgadBcaPbEViyDm0A8gOazV39cj+IK8HX/v33pNII+SBgMY0I9IoNRAkEv7JX3ZWlpak
         957NjNJiXFt2o1rGKLsaUtLbjFMG1DdFA7LmFPopxVpl690jNiMtc5iWfCXYyAJFOriO
         gC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712272588; x=1712877388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=px33Bjt2eInHJiP0NeuRgUTO3pjhGqqLrEOvRjM23DI=;
        b=C+JEfniRr4r6slxOsxSxKXnd5s/LE/BOlML0LVD7a0TyaGnSWesAmJJbTIwSPxflL0
         H5yRfyAtVX9Yq+9I3S+87PK55r1qjWZaGxYW8oJkp6PFH0ICtJEmxWSAuicA2gaDR8yw
         rBZaYar2SI6Ou1nZuSFZYfiuHixqhFoLFyGwj3jd11OZJ8p9hiMwzW7EBwtizLu699n5
         RK/hOGjtR+Hm5E2SLxfJcj0zOSf8CN57lbhM88yI/+Bnz7eA4peJRxbqQ0/wPvEC+mMD
         Doawkfe78xwqk+sX09Sizss3U7SthPr+lecLymG6y12lsz6tehETdYXVpR8Pk/lrAENQ
         UBEA==
X-Forwarded-Encrypted: i=1; AJvYcCV731yItmQzciLGXOsjp/AjmRkx3leq8CMRW8uAXDZmbwTd8qROTJpesVnnTF7dl+d8U8vYr+FnUvGRcjhuChZXVZ/JefcMmLgDUNJB
X-Gm-Message-State: AOJu0Yy95FQXzZYKl78f03EFKPhyTq2WgbRHaBVZr5t8h24oR9dX7C9E
	PB7TPDUjdo37GRMTtrC6iMBH0S6j2hWU294KkuPogT7C2pQDgWPy2yVodTxLepBNAY86MMw4cfD
	SzIdRf52icOxDcqJb4AE2dIXy4hLTnlFlB8Jz
X-Google-Smtp-Source: AGHT+IFqOT0sdB5Mq8Em3ez8wUqwsDenflcnFBaGGydYTj8cPQz4oQR3/fK7VmQ9yLCyTSRCqikRdMTTYcQR8Kj+db8=
X-Received: by 2002:a25:c7c6:0:b0:dcc:d5aa:af36 with SMTP id
 w189-20020a25c7c6000000b00dccd5aaaf36mr1095387ybe.44.1712272587959; Thu, 04
 Apr 2024 16:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240404165404.3805498-1-surenb@google.com> <Zg7dmp5VJkm1nLRM@casper.infradead.org>
 <CAJuCfpHbTCwDERz+Hh+aLZzNdtSFKA+Q7sW-xzvmFmtyHCqROg@mail.gmail.com>
 <CAJuCfpHy5Xo76S7h9rEuA3cQ1pVqurL=wmtQ2cx9-xN1aa_C_A@mail.gmail.com>
 <Zg8qstJNfK07siNn@casper.infradead.org> <jb25mtkveqf63bv74jhynf6ncxmums5s37esveqsv52yurh4z7@5q55ttv34bia>
 <20240404154150.c25ba3a0b98023c8c1eff3a4@linux-foundation.org> <jpaw4hdd73ngt7mvtcdryqscivx6m2ic76ikfkcopceb47becp@vox5czt5bec3>
In-Reply-To: <jpaw4hdd73ngt7mvtcdryqscivx6m2ic76ikfkcopceb47becp@vox5czt5bec3>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 4 Apr 2024 16:16:15 -0700
Message-ID: <CAJuCfpF10COO2nh1nt3CcaZOFe4iSXszsup+a0qAEQ1ngyy5tQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: change inlined allocation helpers to account at
 the call site
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, joro@8bytes.org, 
	will@kernel.org, trond.myklebust@hammerspace.com, anna@kernel.org, 
	arnd@arndb.de, herbert@gondor.apana.org.au, davem@davemloft.net, 
	jikos@kernel.org, benjamin.tissoires@redhat.com, tytso@mit.edu, jack@suse.com, 
	dennis@kernel.org, tj@kernel.org, cl@linux.com, jakub@cloudflare.com, 
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
	vbabka@suse.cz, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-ext4@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 4:01=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Apr 04, 2024 at 03:41:50PM -0700, Andrew Morton wrote:
> > On Thu, 4 Apr 2024 18:38:39 -0400 Kent Overstreet <kent.overstreet@linu=
x.dev> wrote:
> >
> > > On Thu, Apr 04, 2024 at 11:33:22PM +0100, Matthew Wilcox wrote:
> > > > On Thu, Apr 04, 2024 at 03:17:43PM -0700, Suren Baghdasaryan wrote:
> > > > > Ironically, checkpatch generates warnings for these type casts:
> > > > >
> > > > > WARNING: unnecessary cast may hide bugs, see
> > > > > http://c-faq.com/malloc/mallocnocast.html
> > > > > #425: FILE: include/linux/dma-fence-chain.h:90:
> > > > > + ((struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chai=
n),
> > > > > GFP_KERNEL))
> > > > >
> > > > > I guess I can safely ignore them in this case (since we cast to t=
he
> > > > > expected type)?
> > > >
> > > > I find ignoring checkpatch to be a solid move 99% of the time.
> > > >
> > > > I really don't like the codetags.  This is so much churn, and it co=
uld
> > > > all be avoided by just passing in _RET_IP_ or _THIS_IP_ depending o=
n
> > > > whether we wanted to profile this function or its caller.  vmalloc
> > > > has done it this way since 2008 (OK, using __builtin_return_address=
())
> > > > and lockdep has used _THIS_IP_ / _RET_IP_ since 2006.
> > >
> > > Except you can't. We've been over this; using that approach for traci=
ng
> > > is one thing, using it for actual accounting isn't workable.
> >
> > I missed that.  There have been many emails.  Please remind us of the
> > reasoning here.
>
> I think it's on the other people claiming 'oh this would be so easy if
> you just do it this other way' to put up some code - or at least more
> than hot takes.
>
> But, since you asked - one of the main goals of this patchset was to be
> fast enough to run in production, and if you do it by return address
> then you've added at minimum a hash table lookup to every allocate and
> free; if you do that, running it in production is completely out of the
> question.
>
> Besides that - the issues with annotating and tracking the correct
> callsite really don't go away, they just shift around a bit. It's true
> that the return address approach would be easier initially, but that's
> not all we're concerned with; we're concerned with making sure
> allocations get accounted to the _correct_ callsite so that we're giving
> numbers that you can trust, and by making things less explicit you make
> that harder.
>
> Additionally: the alloc_hooks() macro is for more than this. It's also
> for more usable fault injection - remember every thread we have where
> people are begging for every allocation to be __GFP_NOFAIL - "oh, error
> paths are hard to test, let's just get rid of them" - never mind that
> actually do have to have error paths - but _per callsite_ selectable
> fault injection will actually make it practical to test memory error
> paths.
>
> And Kees working on stuff that'll make use of the alloc_hooks() macro
> for segregating kmem_caches.

Yeah, that pretty much summarizes it. Note that we don't have to make
the conversions in this patch and accounting will still work but then
all allocations from different callers will be accounted to the helper
function and that's less useful than accounting at the call site.
It's a sizable churn but the conversions are straight-forward and we
do get accurate, performant and easy to use memory accounting.

>
> This is all stuff that I've explained before; let's please dial back on
> the whining - or I'll just bookmark this for next time...
