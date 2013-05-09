Content-Type: multipart/mixed; boundary="===============5327035154583938434=="
MIME-Version: 1.0
From: Naresh Bhat <naresh.bhat at linaro.org>
Subject: Re: [Devel] [PATCH 2/2] Resolve problem where -Werror fails to build
 when compiling iasl
Date: Thu, 09 May 2013 10:26:20 +0530
Message-ID: <CAFoFrHaTyBJj1_O3u=GdZD_h_WAhuDTf8criOrWrxijx0JaXvw@mail.gmail.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E36FE5459B@ORSMSX103.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5327035154583938434==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bob,

I am using following GCC version

linaro(a)localhost:~/opensource/acpica$ gcc -v
Using built-in specs.
COLLECT_GCC=3Dgcc
COLLECT_LTO_WRAPPER=3D/usr/lib/gcc/arm-linux-gnueabihf/4.7/lto-wrapper
Target: arm-linux-gnueabihf
Configured with: ../src/configure -v --with-pkgversion=3D'Ubuntu/Linaro
4.7.2-2ubuntu1' --with-bugurl=3Dfile:///usr/share/doc/gcc-4.7/README.Bugs
--enable-languages=3Dc,c++,go,fortran,objc,obj-c++ --prefix=3D/usr
--program-suffix=3D-4.7 --enable-shared --enable-linker-build-id
--with-system-zlib --libexecdir=3D/usr/lib --without-included-gettext
--enable-threads=3Dposix --with-gxx-include-dir=3D/usr/include/c++/4.7
--libdir=3D/usr/lib --enable-nls --with-sysroot=3D/ --enable-clocale=3Dgnu
--enable-libstdcxx-debug --enable-libstdcxx-time=3Dyes
--enable-gnu-unique-object --disable-libitm --enable-plugin
--enable-objc-gc --enable-multilib --disable-sjlj-exceptions
--with-arch=3Darmv7-a --with-fpu=3Dvfpv3-d16 --with-float=3Dhard
--with-mode=3Dthumb --disable-werror --enable-checking=3Drelease
--build=3Darm-linux-gnueabihf --host=3Darm-linux-gnueabihf
--target=3Darm-linux-gnueabihf
Thread model: posix
gcc version 4.7.2 (Ubuntu/Linaro 4.7.2-2ubuntu1)
linaro(a)localhost:~/opensource/acpica$


yes I can see the commit  87bda94f5754477da3d11a3f7fb7f5dc6630e681

But looks like is not solved the issue.  I am still getting the following
message after running the test suite

linaro(a)localhost:~/opensource/acpica/tests$ ./aslts.sh
...
......

Copied obj/acpiexec to ../bin/acpiexec
make[1]: Leaving directory
`/home/linaro/opensource/acpica/generate/unix/acpiexec'
32-bit version of acpiexec:
-rwxrwxr-x 1 linaro linaro 494206 May  9 04:53 ../bin/acpiexec

Could not find iASL/acpiexec tools
linaro(a)localhost:~/opensource/acpica/tests$

Thanks and Regards
-Naresh Bhat



On 9 May 2013 01:26, Moore, Robert <robert.moore(a)intel.com> wrote:

> What version of gcc is this?
>
> Anyway, this is not quite the final patch, but I think we have it correct.
> See the git commit.
>
> Thanks,
> Bob
>
>
> > -----Original Message-----
> > From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On
> Behalf
> > Of Naresh Bhat
> > Sent: Wednesday, May 08, 2013 6:54 AM
> > To: devel(a)acpica.org
> > Cc: al.stone(a)linaro.org
> > Subject: [Devel] [PATCH 2/2] Resolve problem where -Werror fails to bui=
ld
> > when compiling iasl
> >
> > Signed-off-by: Naresh Bhat <naresh.bhat(a)linaro.org>
> > Signed-off-by: Al Stone <ahs3(a)redhat.com>
> >
> > While compiling ACPI test suite on ARM architecture got the following
> > error .
> > ..
> > ...
> > mits -o obj32/dtio.o ../../../source/compiler/dtio.c
> > ../../../source/compiler/dtio.c: In function 'DtGetNextLine':
> > ../../../source/compiler/dtio.c:516:9: error: comparison is always false
> > due to limited range of data type [-Werror=3Dtype-limits]
> > cc1: all warnings being treated as errors
> > make[1]: *** [obj32/dtio.o] Error 1
> > ...
> > ....
> > This patch will resolve problem where -Werror fails to build when
> > compiling iasl
> > ---
> >  source/compiler/dtio.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/source/compiler/dtio.c b/source/compiler/dtio.c index
> > 724115c..1593afb 100644
> > --- a/source/compiler/dtio.c
> > +++ b/source/compiler/dtio.c
> > @@ -498,7 +498,7 @@ DtGetNextLine (
> >      UINT32                  State =3D DT_NORMAL_TEXT;
> >      UINT32                  CurrentLineOffset;
> >      UINT32                  i;
> > -    char                    c;
> > +    int                     c;
> >
> >
> >      for (i =3D 0; ;)
> > @@ -512,7 +512,7 @@ DtGetNextLine (
> >              UtExpandLineBuffers ();
> >          }
> >
> > -        c =3D (char) getc (Handle);
> > +        c =3D getc (Handle);
> >          if (c =3D=3D EOF)
> >          {
> >              switch (State)
> > --
> > 1.7.9.5
> >
> > _______________________________________________
> > Devel mailing list
> > Devel(a)acpica.org
> > https://lists.acpica.org/mailman/listinfo/devel
>

--===============5327035154583938434==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgQm9iLDxkaXY+PGJyPjwvZGl2PjxkaXYgc3R5bGU+SSBhbSB1c2lu
ZyBmb2xsb3dpbmcgR0NDIHZlcnNpb248L2Rpdj48ZGl2IHN0eWxlPjxicj48L2Rpdj48ZGl2IHN0
eWxlPjxkaXY+bGluYXJvQGxvY2FsaG9zdDp+L29wZW5zb3VyY2UvYWNwaWNhJCBnY2MgLXY8L2Rp
dj48ZGl2PlVzaW5nIGJ1aWx0LWluIHNwZWNzLjwvZGl2PjxkaXY+Q09MTEVDVF9HQ0M9Z2NjPC9k
aXY+CjxkaXY+Q09MTEVDVF9MVE9fV1JBUFBFUj0vdXNyL2xpYi9nY2MvYXJtLWxpbnV4LWdudWVh
YmloZi80LjcvbHRvLXdyYXBwZXI8L2Rpdj48ZGl2PlRhcmdldDogYXJtLWxpbnV4LWdudWVhYmlo
ZjwvZGl2PjxkaXY+Q29uZmlndXJlZCB3aXRoOiAuLi9zcmMvY29uZmlndXJlIC12IC0td2l0aC1w
a2d2ZXJzaW9uPSYjMzk7VWJ1bnR1L0xpbmFybyA0LjcuMi0ydWJ1bnR1MSYjMzk7IC0td2l0aC1i
dWd1cmw9ZmlsZTovLy91c3Ivc2hhcmUvZG9jL2djYy00LjcvUkVBRE1FLkJ1Z3MgLS1lbmFibGUt
bGFuZ3VhZ2VzPWMsYysrLGdvLGZvcnRyYW4sb2JqYyxvYmotYysrIC0tcHJlZml4PS91c3IgLS1w
cm9ncmFtLXN1ZmZpeD0tNC43IC0tZW5hYmxlLXNoYXJlZCAtLWVuYWJsZS1saW5rZXItYnVpbGQt
aWQgLS13aXRoLXN5c3RlbS16bGliIC0tbGliZXhlY2Rpcj0vdXNyL2xpYiAtLXdpdGhvdXQtaW5j
bHVkZWQtZ2V0dGV4dCAtLWVuYWJsZS10aHJlYWRzPXBvc2l4IC0td2l0aC1neHgtaW5jbHVkZS1k
aXI9L3Vzci9pbmNsdWRlL2MrKy80LjcgLS1saWJkaXI9L3Vzci9saWIgLS1lbmFibGUtbmxzIC0t
d2l0aC1zeXNyb290PS8gLS1lbmFibGUtY2xvY2FsZT1nbnUgLS1lbmFibGUtbGlic3RkY3h4LWRl
YnVnIC0tZW5hYmxlLWxpYnN0ZGN4eC10aW1lPXllcyAtLWVuYWJsZS1nbnUtdW5pcXVlLW9iamVj
dCAtLWRpc2FibGUtbGliaXRtIC0tZW5hYmxlLXBsdWdpbiAtLWVuYWJsZS1vYmpjLWdjIC0tZW5h
YmxlLW11bHRpbGliIC0tZGlzYWJsZS1zamxqLWV4Y2VwdGlvbnMgLS13aXRoLWFyY2g9YXJtdjct
YSAtLXdpdGgtZnB1PXZmcHYzLWQxNiAtLXdpdGgtZmxvYXQ9aGFyZCAtLXdpdGgtbW9kZT10aHVt
YiAtLWRpc2FibGUtd2Vycm9yIC0tZW5hYmxlLWNoZWNraW5nPXJlbGVhc2UgLS1idWlsZD1hcm0t
bGludXgtZ251ZWFiaWhmIC0taG9zdD1hcm0tbGludXgtZ251ZWFiaWhmIC0tdGFyZ2V0PWFybS1s
aW51eC1nbnVlYWJpaGY8L2Rpdj4KPGRpdj5UaHJlYWQgbW9kZWw6IHBvc2l4PC9kaXY+PGRpdj5n
Y2MgdmVyc2lvbiA0LjcuMiAoVWJ1bnR1L0xpbmFybyA0LjcuMi0ydWJ1bnR1MSmgPC9kaXY+PGRp
dj5saW5hcm9AbG9jYWxob3N0On4vb3BlbnNvdXJjZS9hY3BpY2EkPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdiBzdHlsZT55ZXMgSSBjYW4gc2VlIHRoZSBjb21taXQgoDg3
YmRhOTRmNTc1NDQ3N2RhM2QxMWEzZjdmYjdmNWRjNjYzMGU2ODE8L2Rpdj4KPGRpdiBzdHlsZT48
YnI+PC9kaXY+PGRpdiBzdHlsZT5CdXQgbG9va3MgbGlrZSBpcyBub3Qgc29sdmVkIHRoZSBpc3N1
ZS4goEkgYW0gc3RpbGwgZ2V0dGluZyB0aGUgZm9sbG93aW5nIG1lc3NhZ2UgYWZ0ZXIgcnVubmlu
ZyB0aGUgdGVzdCBzdWl0ZTwvZGl2PjxkaXYgc3R5bGU+PGJyPjwvZGl2PjxkaXYgc3R5bGU+bGlu
YXJvQGxvY2FsaG9zdDp+L29wZW5zb3VyY2UvYWNwaWNhL3Rlc3RzJCAuL2FzbHRzLnNoPGJyPgo8
L2Rpdj48ZGl2IHN0eWxlPi4uLjwvZGl2PjxkaXYgc3R5bGU+Li4uLi4uPC9kaXY+PGRpdiBzdHls
ZT48YnI+PC9kaXY+PGRpdiBzdHlsZT48ZGl2PkNvcGllZCBvYmovYWNwaWV4ZWMgdG8gLi4vYmlu
L2FjcGlleGVjPC9kaXY+PGRpdj5tYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL2hvbWUvbGlu
YXJvL29wZW5zb3VyY2UvYWNwaWNhL2dlbmVyYXRlL3VuaXgvYWNwaWV4ZWMmIzM5OzwvZGl2Pgo8
ZGl2PjMyLWJpdCB2ZXJzaW9uIG9mIGFjcGlleGVjOjwvZGl2PjxkaXY+LXJ3eHJ3eHIteCAxIGxp
bmFybyBsaW5hcm8gNDk0MjA2IE1heSCgOSAwNDo1MyAuLi9iaW4vYWNwaWV4ZWM8L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PkNvdWxkIG5vdCBmaW5kIGlBU0wvYWNwaWV4ZWMgdG9vbHM8L2Rpdj48
ZGl2PmxpbmFyb0Bsb2NhbGhvc3Q6fi9vcGVuc291cmNlL2FjcGljYS90ZXN0cyQ8L2Rpdj4KPC9k
aXY+PGRpdiBzdHlsZT48YnI+PC9kaXY+PGRpdiBzdHlsZT5UaGFua3MgYW5kIFJlZ2FyZHM8L2Rp
dj48ZGl2IHN0eWxlPi1OYXJlc2ggQmhhdDwvZGl2PjwvZGl2PjxkaXYgc3R5bGU+PGJyPjwvZGl2
PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj5PbiA5IE1heSAyMDEzIDAxOjI2LCBNb29yZSwgUm9iZXJ0IDxzcGFuIGRpcj0ibHRy
Ij4mbHQ7PGEgaHJlZj0ibWFpbHRvOnJvYmVydC5tb29yZUBpbnRlbC5jb20iIHRhcmdldD0iX2Js
YW5rIj5yb2JlcnQubW9vcmVAaW50ZWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj4KPGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+V2hhdCB2ZXJzaW9uIG9m
IGdjYyBpcyB0aGlzPzxicj4KPGJyPgpBbnl3YXksIHRoaXMgaXMgbm90IHF1aXRlIHRoZSBmaW5h
bCBwYXRjaCwgYnV0IEkgdGhpbmsgd2UgaGF2ZSBpdCBjb3JyZWN0Ljxicj4KU2VlIHRoZSBnaXQg
Y29tbWl0Ljxicj4KPGJyPgpUaGFua3MsPGJyPgpCb2I8YnI+CjxkaXY+PGRpdiBjbGFzcz0iaDUi
Pjxicj4KPGJyPgomZ3Q7IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tPGJyPgomZ3Q7IEZyb206
IDxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmciPmRldmVsLWJvdW5jZXNA
YWNwaWNhLm9yZzwvYT4gW21haWx0bzo8YSBocmVmPSJtYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3Bp
Y2Eub3JnIj5kZXZlbC1ib3VuY2VzQGFjcGljYS5vcmc8L2E+XSBPbiBCZWhhbGY8YnI+CiZndDsg
T2YgTmFyZXNoIEJoYXQ8YnI+CiZndDsgU2VudDogV2VkbmVzZGF5LCBNYXkgMDgsIDIwMTMgNjo1
NCBBTTxicj4KJmd0OyBUbzogPGEgaHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmciPmRldmVs
QGFjcGljYS5vcmc8L2E+PGJyPgomZ3Q7IENjOiA8YSBocmVmPSJtYWlsdG86YWwuc3RvbmVAbGlu
YXJvLm9yZyI+YWwuc3RvbmVAbGluYXJvLm9yZzwvYT48YnI+CiZndDsgU3ViamVjdDogW0RldmVs
XSBbUEFUQ0ggMi8yXSBSZXNvbHZlIHByb2JsZW0gd2hlcmUgLVdlcnJvciBmYWlscyB0byBidWls
ZDxicj4KJmd0OyB3aGVuIGNvbXBpbGluZyBpYXNsPGJyPgomZ3Q7PGJyPgomZ3Q7IFNpZ25lZC1v
ZmYtYnk6IE5hcmVzaCBCaGF0ICZsdDs8YSBocmVmPSJtYWlsdG86bmFyZXNoLmJoYXRAbGluYXJv
Lm9yZyI+bmFyZXNoLmJoYXRAbGluYXJvLm9yZzwvYT4mZ3Q7PGJyPgomZ3Q7IFNpZ25lZC1vZmYt
Ynk6IEFsIFN0b25lICZsdDs8YSBocmVmPSJtYWlsdG86YWhzM0ByZWRoYXQuY29tIj5haHMzQHJl
ZGhhdC5jb208L2E+Jmd0Ozxicj4KJmd0Ozxicj4KJmd0OyBXaGlsZSBjb21waWxpbmcgQUNQSSB0
ZXN0IHN1aXRlIG9uIEFSTSBhcmNoaXRlY3R1cmUgZ290IHRoZSBmb2xsb3dpbmc8YnI+CiZndDsg
ZXJyb3IgLjxicj4KJmd0OyAuLjxicj4KJmd0OyAuLi48YnI+CiZndDsgbWl0cyAtbyBvYmozMi9k
dGlvLm8gLi4vLi4vLi4vc291cmNlL2NvbXBpbGVyL2R0aW8uYzxicj4KJmd0OyAuLi8uLi8uLi9z
b3VyY2UvY29tcGlsZXIvZHRpby5jOiBJbiBmdW5jdGlvbiAmIzM5O0R0R2V0TmV4dExpbmUmIzM5
Ozo8YnI+CiZndDsgLi4vLi4vLi4vc291cmNlL2NvbXBpbGVyL2R0aW8uYzo1MTY6OTogZXJyb3I6
IGNvbXBhcmlzb24gaXMgYWx3YXlzIGZhbHNlPGJyPgomZ3Q7IGR1ZSB0byBsaW1pdGVkIHJhbmdl
IG9mIGRhdGEgdHlwZSBbLVdlcnJvcj10eXBlLWxpbWl0c108YnI+CiZndDsgY2MxOiBhbGwgd2Fy
bmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnM8YnI+CiZndDsgbWFrZVsxXTogKioqIFtvYmoz
Mi9kdGlvLm9dIEVycm9yIDE8YnI+CiZndDsgLi4uPGJyPgomZ3Q7IC4uLi48YnI+CiZndDsgVGhp
cyBwYXRjaCB3aWxsIHJlc29sdmUgcHJvYmxlbSB3aGVyZSAtV2Vycm9yIGZhaWxzIHRvIGJ1aWxk
IHdoZW48YnI+CiZndDsgY29tcGlsaW5nIGlhc2w8YnI+CiZndDsgLS0tPGJyPgomZ3Q7IKBzb3Vy
Y2UvY29tcGlsZXIvZHRpby5jIHwgoCCgNCArKy0tPGJyPgomZ3Q7IKAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKTxicj4KJmd0Ozxicj4KJmd0OyBkaWZmIC0t
Z2l0IGEvc291cmNlL2NvbXBpbGVyL2R0aW8uYyBiL3NvdXJjZS9jb21waWxlci9kdGlvLmMgaW5k
ZXg8YnI+CiZndDsgNzI0MTE1Yy4uMTU5M2FmYiAxMDA2NDQ8YnI+CiZndDsgLS0tIGEvc291cmNl
L2NvbXBpbGVyL2R0aW8uYzxicj4KJmd0OyArKysgYi9zb3VyY2UvY29tcGlsZXIvZHRpby5jPGJy
PgomZ3Q7IEBAIC00OTgsNyArNDk4LDcgQEAgRHRHZXROZXh0TGluZSAoPGJyPgomZ3Q7IKAgoCCg
VUlOVDMyIKAgoCCgIKAgoCCgIKAgoCCgU3RhdGUgPSBEVF9OT1JNQUxfVEVYVDs8YnI+CiZndDsg
oCCgIKBVSU5UMzIgoCCgIKAgoCCgIKAgoCCgIKBDdXJyZW50TGluZU9mZnNldDs8YnI+CiZndDsg
oCCgIKBVSU5UMzIgoCCgIKAgoCCgIKAgoCCgIKBpOzxicj4KJmd0OyAtIKAgoGNoYXIgoCCgIKAg
oCCgIKAgoCCgIKAgoGM7PGJyPgomZ3Q7ICsgoCCgaW50IKAgoCCgIKAgoCCgIKAgoCCgIKAgYzs8
YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDsgoCCgIKBmb3IgKGkgPSAwOyA7KTxicj4KJmd0OyBA
QCAtNTEyLDcgKzUxMiw3IEBAIER0R2V0TmV4dExpbmUgKDxicj4KJmd0OyCgIKAgoCCgIKAgoCCg
VXRFeHBhbmRMaW5lQnVmZmVycyAoKTs8YnI+CiZndDsgoCCgIKAgoCCgfTxicj4KJmd0Ozxicj4K
Jmd0OyAtIKAgoCCgIKBjID0gKGNoYXIpIGdldGMgKEhhbmRsZSk7PGJyPgomZ3Q7ICsgoCCgIKAg
oGMgPSBnZXRjIChIYW5kbGUpOzxicj4KJmd0OyCgIKAgoCCgIKBpZiAoYyA9PSBFT0YpPGJyPgom
Z3Q7IKAgoCCgIKAgoHs8YnI+CiZndDsgoCCgIKAgoCCgIKAgoHN3aXRjaCAoU3RhdGUpPGJyPgom
Z3Q7IC0tPGJyPgomZ3Q7IDEuNy45LjU8YnI+CiZndDs8YnI+CjwvZGl2PjwvZGl2PiZndDsgX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+CiZndDsgRGV2
ZWwgbWFpbGluZyBsaXN0PGJyPgomZ3Q7IDxhIGhyZWY9Im1haWx0bzpEZXZlbEBhY3BpY2Eub3Jn
Ij5EZXZlbEBhY3BpY2Eub3JnPC9hPjxicj4KJmd0OyA8YSBocmVmPSJodHRwczovL2xpc3RzLmFj
cGljYS5vcmcvbWFpbG1hbi9saXN0aW5mby9kZXZlbCIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8v
bGlzdHMuYWNwaWNhLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RldmVsPC9hPjxicj4KPC9ibG9ja3F1
b3RlPjwvZGl2Pjxicj48L2Rpdj4K

--===============5327035154583938434==--

