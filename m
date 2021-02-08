Content-Type: multipart/mixed; boundary="===============8085280691298583098=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] Revert "ACPICA: Interpreter: fix memory leak by
 using existing buffer"
Date: Mon, 08 Feb 2021 14:00:58 +0100
Message-ID: <CAJZ5v0hMJnaHhUYib9d3yQ1CMHLE+Hu3UM4VoN=dOiyriTPmOw@mail.gmail.com>
In-Reply-To: 20210206104854.GC27503@dragon
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8085280691298583098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 6, 2021 at 11:49 AM Shawn Guo <shawn.guo(a)linaro.org> wrote:
>
> On Sat, Feb 06, 2021 at 09:49:37AM +0100, Ard Biesheuvel wrote:
> > This reverts commit 32cf1a12cad43358e47dac8014379c2f33dfbed4.
> >
> > The 'exisitng buffer' in this case is the firmware provided table, and
> > we should not modify that in place. This fixes a crash on arm64 with
> > initrd table overrides, in which case the DSDT is not mapped with
> > read/write permissions.
> >
> > Cc: Robert Moore <robert.moore(a)intel.com>
> > Cc: Erik Kaneda <erik.kaneda(a)intel.com>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki(a)intel.com>
> > Cc: Len Brown <lenb(a)kernel.org>
> > Reported-by: Shawn Guo <shawn.guo(a)linaro.org>
> > Signed-off-by: Ard Biesheuvel <ardb(a)kernel.org>
>
> Tested-by: Shawn Guo <shawn.guo(a)linaro.org>

Applied, thanks!

Erik, the upstream will need to sync up with this revert.
--===============8085280691298583098==--

