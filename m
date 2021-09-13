Content-Type: multipart/mixed; boundary="===============7535305363943954053=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH AUTOSEL 4.4 24/35] ACPICA: iASL: Fix for WPBT
 table with no command-line arguments
Date: Mon, 13 Sep 2021 14:20:35 +0200
Message-ID: <CAJZ5v0hze08S1ORK7Pwa3N5TBX5Jj=jeKqye=wv7dpzDArss3Q@mail.gmail.com>
In-Reply-To: YTy/etsK39d/+Zhh@sashalap
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7535305363943954053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 11, 2021 at 4:38 PM Sasha Levin <sashal(a)kernel.org> wrote:
>
> On Fri, Sep 10, 2021 at 09:45:36AM +0200, Pavel Machek wrote:
> >Hi!
> >
> >> Handle the case where the Command-line Arguments table field
> >> does not exist.
> >>
> >> ACPICA commit d6487164497fda170a1b1453c5d58f2be7c873d6
> >
> >I'm not sure what is going on here, but adding unused definition will
> >not make any difference for 4.4 users, so we don't need this in
> >-stable...?
>
> Ugh, dropped, thanks!
>
> I wonder what this patch actually does upstream.

There are AML compiler changes in it, but the compiler is not included
into the Linux kernel.
--===============7535305363943954053==--

