Content-Type: multipart/mixed; boundary="===============6015714016899383324=="
MIME-Version: 1.0
From: Naresh Bhat <naresh.bhat at linaro.org>
Subject: Re: [Devel] [PATCH 1/2] Fix config so it will compile with GCC
 versions that do not have -m32/-m64
Date: Thu, 09 May 2013 10:26:58 +0530
Message-ID: <CAFoFrHa1yMjmZBqbTJk1vdvOd3N7FLiZm9aqHzzdEGtLAaJ0-g@mail.gmail.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E36FE54574@ORSMSX103.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6015714016899383324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks the issue is solved.


On 9 May 2013 01:15, Moore, Robert <robert.moore(a)intel.com> wrote:

> We just removed the cross-compilation support from the ACPICA application
> makefiles, so this should cease to be a problem.
>
> See the acpica git tree for the commit.
> Bob
>
> > -----Original Message-----
> > From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On
> Behalf
> > Of Naresh Bhat
> > Sent: Wednesday, May 08, 2013 6:54 AM
> > To: devel(a)acpica.org
> > Cc: al.stone(a)linaro.org
> > Subject: [Devel] [PATCH 1/2] Fix config so it will compile with GCC
> > versions that do not have -m32/-m64
> >
> > Signed-off-by: Naresh Bhat <naresh.bhat(a)linaro.org>
> > Signed-off-by: Al Stone <ahs3(a)redhat.com>
> >
> > While compiling the ACPI test suite on ARM architecture got the followi=
ng
> > compilation error .
> > ...
> > ....
> > Copy intermediate file:
> > `obj32/prparserparse.h' -> `obj32/prparser.y.h'
> > gcc -c -m32 -D_CYGWIN -D_GNU_SOURCE -I../../../source/include -
> > DACPI_ASL_COMPILER -I../../../source/compiler -Iobj32 -Wall -Werror -
> > oobj32/as
> > gcc: error: unrecognized command line option '-m32'
> > make[1]: *** [obj32/aslcompilerlex.o] Error 1 ....
> > .....
> >
> > This patch fix config so it will compile with GCC versions that do not
> > have -m32/-m64
> > ---
> >  generate/unix/Makefile.config |    1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/generate/unix/Makefile.config
> b/generate/unix/Makefile.config
> > index 65242e0..fcda7a6 100644
> > --- a/generate/unix/Makefile.config
> > +++ b/generate/unix/Makefile.config
> > @@ -41,7 +41,6 @@ CC =3D    gcc
> >  #
> >  OBJDIR =3D     obj$(BITS)
> >  BINDIR =3D     bin$(BITS)
> > -BITSFLAG =3D   -m$(BITS)
> >  COMPILEOBJ =3D $(CC) -c $(CFLAGS) $(OPT_CFLAGS) -o $@ $<
> >  LINKPROG =3D   $(CC) $(OBJECTS) -o $(PROG) $(LDFLAGS)
> >  INSTALLDIR =3D /usr/bin
> > --
> > 1.7.9.5
> >
> > _______________________________________________
> > Devel mailing list
> > Devel(a)acpica.org
> > https://lists.acpica.org/mailman/listinfo/devel
>

--===============6015714016899383324==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+VGhhbmtzIHRoZSBpc3N1ZSBpcyBzb2x2ZWQuPC9kaXY+PGRpdiBjbGFz
cz0iZ21haWxfZXh0cmEiPjxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIDkgTWF5
IDIwMTMgMDE6MTUsIE1vb3JlLCBSb2JlcnQgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJt
YWlsdG86cm9iZXJ0Lm1vb3JlQGludGVsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnJvYmVydC5tb29y
ZUBpbnRlbC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPgo8YmxvY2txdW90ZSBjbGFzcz0i
Z21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2Nj
YyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5XZSBqdXN0IHJlbW92ZWQgdGhlIGNyb3NzLWNvbXBp
bGF0aW9uIHN1cHBvcnQgZnJvbSB0aGUgQUNQSUNBIGFwcGxpY2F0aW9uIG1ha2VmaWxlcywgc28g
dGhpcyBzaG91bGQgY2Vhc2UgdG8gYmUgYSBwcm9ibGVtLjxicj4KCjxicj4KU2VlIHRoZSBhY3Bp
Y2EgZ2l0IHRyZWUgZm9yIHRoZSBjb21taXQuPGJyPgpCb2I8YnI+CjxkaXYgY2xhc3M9ImltIj48
YnI+CiZndDsgLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS08YnI+CiZndDsgRnJvbTogPGEgaHJl
Zj0ibWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyI+ZGV2ZWwtYm91bmNlc0BhY3BpY2Eu
b3JnPC9hPiBbbWFpbHRvOjxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmci
PmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZzwvYT5dIE9uIEJlaGFsZjxicj4KJmd0OyBPZiBOYXJl
c2ggQmhhdDxicj4KJmd0OyBTZW50OiBXZWRuZXNkYXksIE1heSAwOCwgMjAxMyA2OjU0IEFNPGJy
PgomZ3Q7IFRvOiA8YSBocmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyI+ZGV2ZWxAYWNwaWNh
Lm9yZzwvYT48YnI+CiZndDsgQ2M6IDxhIGhyZWY9Im1haWx0bzphbC5zdG9uZUBsaW5hcm8ub3Jn
Ij5hbC5zdG9uZUBsaW5hcm8ub3JnPC9hPjxicj4KJmd0OyBTdWJqZWN0OiBbRGV2ZWxdIFtQQVRD
SCAxLzJdIEZpeCBjb25maWcgc28gaXQgd2lsbCBjb21waWxlIHdpdGggR0NDPGJyPgomZ3Q7IHZl
cnNpb25zIHRoYXQgZG8gbm90IGhhdmUgLW0zMi8tbTY0PGJyPgomZ3Q7PGJyPgo8L2Rpdj48ZGl2
PjxkaXYgY2xhc3M9Img1Ij4mZ3Q7IFNpZ25lZC1vZmYtYnk6IE5hcmVzaCBCaGF0ICZsdDs8YSBo
cmVmPSJtYWlsdG86bmFyZXNoLmJoYXRAbGluYXJvLm9yZyI+bmFyZXNoLmJoYXRAbGluYXJvLm9y
ZzwvYT4mZ3Q7PGJyPgomZ3Q7IFNpZ25lZC1vZmYtYnk6IEFsIFN0b25lICZsdDs8YSBocmVmPSJt
YWlsdG86YWhzM0ByZWRoYXQuY29tIj5haHMzQHJlZGhhdC5jb208L2E+Jmd0Ozxicj4KJmd0Ozxi
cj4KJmd0OyBXaGlsZSBjb21waWxpbmcgdGhlIEFDUEkgdGVzdCBzdWl0ZSBvbiBBUk0gYXJjaGl0
ZWN0dXJlIGdvdCB0aGUgZm9sbG93aW5nPGJyPgomZ3Q7IGNvbXBpbGF0aW9uIGVycm9yIC48YnI+
CiZndDsgLi4uPGJyPgomZ3Q7IC4uLi48YnI+CiZndDsgQ29weSBpbnRlcm1lZGlhdGUgZmlsZTo8
YnI+CiZndDsgYG9iajMyL3BycGFyc2VycGFyc2UuaCYjMzk7IC0mZ3Q7IGBvYmozMi9wcnBhcnNl
ci55LmgmIzM5Ozxicj4KJmd0OyBnY2MgLWMgLW0zMiAtRF9DWUdXSU4gLURfR05VX1NPVVJDRSAt
SS4uLy4uLy4uL3NvdXJjZS9pbmNsdWRlIC08YnI+CiZndDsgREFDUElfQVNMX0NPTVBJTEVSIC1J
Li4vLi4vLi4vc291cmNlL2NvbXBpbGVyIC1Jb2JqMzIgLVdhbGwgLVdlcnJvciAtPGJyPgomZ3Q7
IG9vYmozMi9hczxicj4KJmd0OyBnY2M6IGVycm9yOiB1bnJlY29nbml6ZWQgY29tbWFuZCBsaW5l
IG9wdGlvbiAmIzM5Oy1tMzImIzM5Ozxicj4KJmd0OyBtYWtlWzFdOiAqKiogW29iajMyL2FzbGNv
bXBpbGVybGV4Lm9dIEVycm9yIDEgLi4uLjxicj4KJmd0OyAuLi4uLjxicj4KJmd0Ozxicj4KJmd0
OyBUaGlzIHBhdGNoIGZpeCBjb25maWcgc28gaXQgd2lsbCBjb21waWxlIHdpdGggR0NDIHZlcnNp
b25zIHRoYXQgZG8gbm90PGJyPgomZ3Q7IGhhdmUgLW0zMi8tbTY0PGJyPgomZ3Q7IC0tLTxicj4K
Jmd0OyCgZ2VuZXJhdGUvdW5peC9NYWtlZmlsZS5jb25maWcgfCCgIKAxIC08YnI+CiZndDsgoDEg
ZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pPGJyPgomZ3Q7PGJyPgomZ3Q7IGRpZmYgLS1naXQg
YS9nZW5lcmF0ZS91bml4L01ha2VmaWxlLmNvbmZpZyBiL2dlbmVyYXRlL3VuaXgvTWFrZWZpbGUu
Y29uZmlnPGJyPgomZ3Q7IGluZGV4IDY1MjQyZTAuLmZjZGE3YTYgMTAwNjQ0PGJyPgomZ3Q7IC0t
LSBhL2dlbmVyYXRlL3VuaXgvTWFrZWZpbGUuY29uZmlnPGJyPgomZ3Q7ICsrKyBiL2dlbmVyYXRl
L3VuaXgvTWFrZWZpbGUuY29uZmlnPGJyPgomZ3Q7IEBAIC00MSw3ICs0MSw2IEBAIENDID0goCCg
Z2NjPGJyPgomZ3Q7IKAjPGJyPgomZ3Q7IKBPQkpESVIgPSCgIKAgb2JqJChCSVRTKTxicj4KJmd0
OyCgQklORElSID0goCCgIGJpbiQoQklUUyk8YnI+CiZndDsgLUJJVFNGTEFHID0goCAtbSQoQklU
Uyk8YnI+CiZndDsgoENPTVBJTEVPQkogPSAkKENDKSAtYyAkKENGTEFHUykgJChPUFRfQ0ZMQUdT
KSAtbyAkQCAkJmx0Ozxicj4KJmd0OyCgTElOS1BST0cgPSCgICQoQ0MpICQoT0JKRUNUUykgLW8g
JChQUk9HKSAkKExERkxBR1MpPGJyPgomZ3Q7IKBJTlNUQUxMRElSID0gL3Vzci9iaW48YnI+CiZn
dDsgLS08YnI+CiZndDsgMS43LjkuNTxicj4KJmd0Ozxicj4KPC9kaXY+PC9kaXY+Jmd0OyBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj4KJmd0OyBEZXZl
bCBtYWlsaW5nIGxpc3Q8YnI+CiZndDsgPGEgaHJlZj0ibWFpbHRvOkRldmVsQGFjcGljYS5vcmci
PkRldmVsQGFjcGljYS5vcmc8L2E+PGJyPgomZ3Q7IDxhIGhyZWY9Imh0dHBzOi8vbGlzdHMuYWNw
aWNhLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RldmVsIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9s
aXN0cy5hY3BpY2Eub3JnL21haWxtYW4vbGlzdGluZm8vZGV2ZWw8L2E+PGJyPgo8L2Jsb2NrcXVv
dGU+PC9kaXY+PGJyPjwvZGl2Pgo=

--===============6015714016899383324==--

