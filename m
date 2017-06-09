Content-Type: multipart/mixed; boundary="===============8771901950396147164=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Remove unnecessary call to debugger
Date: Fri, 09 Jun 2017 00:35:21 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CECBB71@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: CAJZ5v0i=7CyVNT=CeEbB2Xrn7mEmi21URtS8gCZ_CinzAgLCHQ@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8771901950396147164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: rjwysocki(a)gmail.com [mailto:rjwysocki(a)gmail.com] On Behalf Of R=
afael J. Wysocki
> Subject: Re: [PATCH] ACPICA: Remove unnecessary call to debugger
> =

> On Thu, Jun 8, 2017 at 11:31 PM, Adam Borowski <kilobyte(a)angband.pl> wr=
ote:
> > This is a port of https://github.com/acpica/acpica/commit/eaa455ac by
> > Robert Moore to the kernel:
> >
> >> This call was simply wrong, and resulted in a -1 index into the operand
> >> stack.
> >
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D120351
> > Signed-off-by: Adam Borowski <kilobyte(a)angband.pl>
> > ---
> > You guys fixed this in your tool months ago, but it's still unfixed in =
the
> > kernel.  Let's apply that patch, then.  The coding styles differ so muc=
h the
> > patch is hardly recognizable, but it's a direct port.
> =

> Lv, any comments?

The commit was originally sent by me with this commit:
https://github.com/zetalog/linux/commit/2cd640e5fd50
You can see full bug triage story here:
https://bugzilla.kernel.org/show_bug.cgi?id=3D194845
And upstream ACPICA discussion here:
https://github.com/acpica/acpica/pull/245
After the merge, bob helped to close another bug report:
https://bugzilla.kernel.org/show_bug.cgi?id=3D120351

I already sent linuxized commit to you in the ACPICA release with restored =
patch description:
https://patchwork.kernel.org/patch/9765837/
Such modification is what we need to do in release cycle according to the c=
ommunity work.
You don't need to take this one.

Thanks and best regards
Lv

> >  drivers/acpi/acpica/dsutils.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutil=
s.c
> > index 406edec20de7..0dabd9b95684 100644
> > --- a/drivers/acpi/acpica/dsutils.c
> > +++ b/drivers/acpi/acpica/dsutils.c
> > @@ -633,15 +633,6 @@ acpi_ds_create_operand(struct acpi_walk_state *wal=
k_state,
> >
> >                 if ((op_info->flags & AML_HAS_RETVAL) ||
> >                     (arg->common.flags & ACPI_PARSEOP_IN_STACK)) {
> > -                       ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
> > -                                         "Argument previously created,=
 already stacked\n"));
> > -
> > -                       acpi_db_display_argument_object(walk_state->
> > -                                                       operands[walk_s=
tate->
> > -                                                                num_op=
erands -
> > -                                                                1],
> > -                                                       walk_state);
> > -
> >                         /*
> >                          * Use value that was already previously return=
ed
> >                          * by the evaluation of this argument
> > --
> > 2.11.0

--===============8771901950396147164==--

