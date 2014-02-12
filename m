Content-Type: multipart/mixed; boundary="===============6289402664132457339=="
MIME-Version: 1.0
From: Sascha Wildner <swildner at gmail.com>
Subject: Re: [Devel] Wrong license in acpica-unix2-20140114/.../aehandlers.c
Date: Wed, 12 Feb 2014 20:04:20 +0100
Message-ID: <CABC13nH4sxGZCEJY0y9O16262LS9qymGck2s9VWBxde6ySVgzg@mail.gmail.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37C7D6748@ORSMSX103.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6289402664132457339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

No, but thanks anyway. When I brought 20140114 into DragonFly BSD I
restored the previous correct license and bumped the copyright year. :)

Thanks for all the good work,
Sascha
 Am 12.02.2014 19:09 schrieb "Moore, Robert" <robert.moore(a)intel.com>:

>  We will continue to look at the generation process.
>
>
>
> In the meantime, would you like a copy of this file with the correct
> license?
>
> Bob
>
>
>
>
>
> *From:* Devel [mailto:devel-bounces(a)acpica.org] *On Behalf Of *Sascha
> Wildner
> *Sent:* Tuesday, February 11, 2014 9:31 PM
> *To:* Zheng, Lv
> *Cc:* devel(a)acpica.org
> *Subject:* Re: [Devel] Wrong license in
> acpica-unix2-20140114/.../aehandlers.c
>
>
>
> No, I didn't change anything anywhere. I just wanted to report that in
> https://acpica.org/sites/acpica/files/acpica-unix2-20140114.tar.gzaehandl=
ers.c's license is the Intel one, for some reason, while in
> https://acpica.org/sites/acpica/files/acpica-unix2-20131218.tar.gz it was
> still the dual one. :)
>
>
>
> Sascha
>
>
>
>
>
> On Wed, Feb 12, 2014 at 6:19 AM, Zheng, Lv <lv.zheng(a)intel.com> wrote:
>
> Hi, Sascha
>
> Have you modified the aehandlers.c?
> I ran acpisrc -h -y manually on aehandlers.c, no false generation of dual
> license header could be found.
>
> You can try:
> # cd <acpica srcdir>
> # make acpisrc
> # generate/unix/bin/acpisrc -h -y source/tools/acpiexec/aehandlers.c
> aehandlers.c
> And take a look at =E2=80=9C./aehandlers.c=E2=80=9D.
>
> Please make sure that the header of aehandlers.c has contained the lines
> indicated by the =E2=80=9CHeaderBegin=E2=80=9D in source/tools/acpisrc/as=
convert.c.
> And please also make sure that there is no additional =E2=80=9C\r=E2=80=
=9D, "\n" or spaces
> among these lines.
>
> Thanks and best regards
> -Lv
>
>
>
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Sascha Wildn=
er
>
> Sent: Tuesday, February 11, 2014 5:54 PM
>
>
> Hello,
>
> in acpica-unix2-20140114/source/tools/acpiexec/aehandlers.c, i.e. the
> dual-licensed version, the license was (accidentally, I suppose) exchanged
> with the Intel license, when just the copyright year should have been
> bumped.
>
> Regards,
> Sascha
>
>
>

--===============6289402664132457339==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+Tm8sIGJ1dCB0aGFua3MgYW55d2F5LiBXaGVuIEkgYnJvdWdodCAyMDE0MDExNCBpbnRvIERy
YWdvbkZseSBCU0QgSSByZXN0b3JlZCB0aGUgcHJldmlvdXMgY29ycmVjdCBsaWNlbnNlIGFuZCBi
dW1wZWQgdGhlIGNvcHlyaWdodCB5ZWFyLiA6KTwvcD4KPHA+VGhhbmtzIGZvciBhbGwgdGhlIGdv
b2Qgd29yayw8YnI+ClNhc2NoYTxicj4KPC9wPgo8ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+QW0g
MTIuMDIuMjAxNCAxOTowOSBzY2hyaWViICZxdW90O01vb3JlLCBSb2JlcnQmcXVvdDsgJmx0Ozxh
IGhyZWY9Im1haWx0bzpyb2JlcnQubW9vcmVAaW50ZWwuY29tIj5yb2JlcnQubW9vcmVAaW50ZWwu
Y29tPC9hPiZndDs6PGJyIHR5cGU9ImF0dHJpYnV0aW9uIj48YmxvY2txdW90ZSBjbGFzcz0iZ21h
aWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBz
b2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KCgoKCgoKPGRpdiBsYW5nPSJFTi1VUyIgbGluaz0iYmx1
ZSIgdmxpbms9InB1cnBsZSI+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxl
PSJmb250LXNpemU6MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssJnF1b3Q7
c2Fucy1zZXJpZiZxdW90Oztjb2xvcjojMWY0OTdkIj5XZSB3aWxsIGNvbnRpbnVlIHRvIGxvb2sg
YXQgdGhlIGdlbmVyYXRpb24gcHJvY2Vzcy48dT48L3U+PHU+PC91Pjwvc3Bhbj48L3A+CjxwIGNs
YXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTEuMHB0O2ZvbnQtZmFtaWx5
OiZxdW90O0NhbGlicmkmcXVvdDssJnF1b3Q7c2Fucy1zZXJpZiZxdW90Oztjb2xvcjojMWY0OTdk
Ij48dT48L3U+wqA8dT48L3U+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4g
c3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90Oywm
cXVvdDtzYW5zLXNlcmlmJnF1b3Q7O2NvbG9yOiMxZjQ5N2QiPkluIHRoZSBtZWFudGltZSwgd291
bGQgeW91IGxpa2UgYSBjb3B5IG9mIHRoaXMgZmlsZSB3aXRoIHRoZSBjb3JyZWN0IGxpY2Vuc2U/
PHU+PC91Pjx1PjwvdT48L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5
bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OywmcXVv
dDtzYW5zLXNlcmlmJnF1b3Q7O2NvbG9yOiMxZjQ5N2QiPkJvYjx1PjwvdT48dT48L3U+PC9zcGFu
PjwvcD4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7
Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OywmcXVvdDtzYW5zLXNlcmlmJnF1b3Q7O2Nv
bG9yOiMxZjQ5N2QiPjx1PjwvdT7CoDx1PjwvdT48L3NwYW4+PC9wPgo8cCBjbGFzcz0iTXNvTm9y
bWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxp
YnJpJnF1b3Q7LCZxdW90O3NhbnMtc2VyaWYmcXVvdDs7Y29sb3I6IzFmNDk3ZCI+PHU+PC91PsKg
PHU+PC91Pjwvc3Bhbj48L3A+CjxkaXYgc3R5bGU9ImJvcmRlcjpub25lO2JvcmRlci1sZWZ0OnNv
bGlkIGJsdWUgMS41cHQ7cGFkZGluZzowaW4gMGluIDBpbiA0LjBwdCI+CjxkaXY+CjxkaXYgc3R5
bGU9ImJvcmRlcjpub25lO2JvcmRlci10b3A6c29saWQgI2I1YzRkZiAxLjBwdDtwYWRkaW5nOjMu
MHB0IDBpbiAwaW4gMGluIj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PGI+PHNwYW4gc3R5bGU9ImZv
bnQtc2l6ZToxMC4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7VGFob21hJnF1b3Q7LCZxdW90O3NhbnMt
c2VyaWYmcXVvdDsiPkZyb206PC9zcGFuPjwvYj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEwLjBw
dDtmb250LWZhbWlseTomcXVvdDtUYWhvbWEmcXVvdDssJnF1b3Q7c2Fucy1zZXJpZiZxdW90OyI+
IERldmVsIFttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyIg
dGFyZ2V0PSJfYmxhbmsiPmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZzwvYT5dCjxiPk9uIEJlaGFs
ZiBPZiA8L2I+U2FzY2hhIFdpbGRuZXI8YnI+CjxiPlNlbnQ6PC9iPiBUdWVzZGF5LCBGZWJydWFy
eSAxMSwgMjAxNCA5OjMxIFBNPGJyPgo8Yj5Ubzo8L2I+IFpoZW5nLCBMdjxicj4KPGI+Q2M6PC9i
PiA8YSBocmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmRldmVs
QGFjcGljYS5vcmc8L2E+PGJyPgo8Yj5TdWJqZWN0OjwvYj4gUmU6IFtEZXZlbF0gV3JvbmcgbGlj
ZW5zZSBpbiBhY3BpY2EtdW5peDItMjAxNDAxMTQvLi4uL2FlaGFuZGxlcnMuYzx1PjwvdT48dT48
L3U+PC9zcGFuPjwvcD4KPC9kaXY+CjwvZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48dT48L3U+
wqA8dT48L3U+PC9wPgo8ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj5ObywgSSBkaWRuJiMzOTt0
IGNoYW5nZSBhbnl0aGluZyBhbnl3aGVyZS4gSSBqdXN0IHdhbnRlZCB0byByZXBvcnQgdGhhdCBp
bgo8YSBocmVmPSJodHRwczovL2FjcGljYS5vcmcvc2l0ZXMvYWNwaWNhL2ZpbGVzL2FjcGljYS11
bml4Mi0yMDE0MDExNC50YXIuZ3oiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2FjcGljYS5vcmcv
c2l0ZXMvYWNwaWNhL2ZpbGVzL2FjcGljYS11bml4Mi0yMDE0MDExNC50YXIuZ3o8L2E+IGFlaGFu
ZGxlcnMuYyYjMzk7cyBsaWNlbnNlIGlzIHRoZSBJbnRlbCBvbmUsIGZvciBzb21lIHJlYXNvbiwg
d2hpbGUgaW7CoDxhIGhyZWY9Imh0dHBzOi8vYWNwaWNhLm9yZy9zaXRlcy9hY3BpY2EvZmlsZXMv
YWNwaWNhLXVuaXgyLTIwMTMxMjE4LnRhci5neiIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vYWNw
aWNhLm9yZy9zaXRlcy9hY3BpY2EvZmlsZXMvYWNwaWNhLXVuaXgyLTIwMTMxMjE4LnRhci5nejwv
YT4KIGl0IHdhcyBzdGlsbCB0aGUgZHVhbCBvbmUuIDopPHU+PC91Pjx1PjwvdT48L3A+CjxkaXY+
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+CjwvZGl2Pgo8ZGl2Pgo8
cCBjbGFzcz0iTXNvTm9ybWFsIj5TYXNjaGE8dT48L3U+PHU+PC91PjwvcD4KPC9kaXY+CjxkaXY+
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+CjwvZGl2Pgo8L2Rpdj4K
PGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1hcmdpbi1ib3R0b206MTIuMHB0Ij48
dT48L3U+wqA8dT48L3U+PC9wPgo8ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj5PbiBXZWQsIEZl
YiAxMiwgMjAxNCBhdCA2OjE5IEFNLCBaaGVuZywgTHYgJmx0OzxhIGhyZWY9Im1haWx0bzpsdi56
aGVuZ0BpbnRlbC5jb20iIHRhcmdldD0iX2JsYW5rIj5sdi56aGVuZ0BpbnRlbC5jb208L2E+Jmd0
OyB3cm90ZTo8dT48L3U+PHU+PC91PjwvcD4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SGksIFNhc2No
YTxicj4KPGJyPgpIYXZlIHlvdSBtb2RpZmllZCB0aGUgYWVoYW5kbGVycy5jPzxicj4KSSByYW4g
YWNwaXNyYyAtaCAteSBtYW51YWxseSBvbiBhZWhhbmRsZXJzLmMsIG5vIGZhbHNlIGdlbmVyYXRp
b24gb2YgZHVhbCBsaWNlbnNlIGhlYWRlciBjb3VsZCBiZSBmb3VuZC48YnI+Cjxicj4KWW91IGNh
biB0cnk6PGJyPgojIGNkICZsdDthY3BpY2Egc3JjZGlyJmd0Ozxicj4KIyBtYWtlIGFjcGlzcmM8
YnI+CiMgZ2VuZXJhdGUvdW5peC9iaW4vYWNwaXNyYyAtaCAteSBzb3VyY2UvdG9vbHMvYWNwaWV4
ZWMvYWVoYW5kbGVycy5jIGFlaGFuZGxlcnMuYzxicj4KQW5kIHRha2UgYSBsb29rIGF0IOKAnC4v
YWVoYW5kbGVycy5j4oCdLjxicj4KPGJyPgpQbGVhc2UgbWFrZSBzdXJlIHRoYXQgdGhlIGhlYWRl
ciBvZiBhZWhhbmRsZXJzLmMgaGFzIGNvbnRhaW5lZCB0aGUgbGluZXMgaW5kaWNhdGVkIGJ5IHRo
ZSDigJxIZWFkZXJCZWdpbuKAnSBpbiBzb3VyY2UvdG9vbHMvYWNwaXNyYy9hc2NvbnZlcnQuYy48
YnI+CkFuZCBwbGVhc2UgYWxzbyBtYWtlIHN1cmUgdGhhdCB0aGVyZSBpcyBubyBhZGRpdGlvbmFs
IOKAnFxy4oCdLCAmcXVvdDtcbiZxdW90OyBvciBzcGFjZXMgYW1vbmcgdGhlc2UgbGluZXMuPGJy
Pgo8YnI+ClRoYW5rcyBhbmQgYmVzdCByZWdhcmRzPGJyPgotTHY8dT48L3U+PHU+PC91PjwvcD4K
PGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PGJyPgo8YnI+CkZyb206IERldmVsIFttYWlsdG86
PGEgaHJlZj0ibWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyIgdGFyZ2V0PSJfYmxhbmsi
PmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZzwvYT5dIE9uIEJlaGFsZiBPZiBTYXNjaGEgV2lsZG5l
cjx1PjwvdT48dT48L3U+PC9wPgo8L2Rpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+U2VudDogVHVl
c2RheSwgRmVicnVhcnkgMTEsIDIwMTQgNTo1NCBQTTx1PjwvdT48dT48L3U+PC9wPgo8ZGl2Pgo8
ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luLWJvdHRvbToxMi4wcHQiPjxi
cj4KSGVsbG8sPGJyPgo8YnI+CmluwqBhY3BpY2EtdW5peDItMjAxNDAxMTQvc291cmNlL3Rvb2xz
L2FjcGlleGVjL2FlaGFuZGxlcnMuYywgaS5lLiB0aGUgZHVhbC1saWNlbnNlZCB2ZXJzaW9uLCB0
aGUgbGljZW5zZSB3YXMgKGFjY2lkZW50YWxseSwgSSBzdXBwb3NlKSBleGNoYW5nZWQgd2l0aCB0
aGUgSW50ZWwgbGljZW5zZSwgd2hlbiBqdXN0IHRoZSBjb3B5cmlnaHQgeWVhciBzaG91bGQgaGF2
ZSBiZWVuIGJ1bXBlZC48YnI+Cgo8YnI+ClJlZ2FyZHMsPGJyPgpTYXNjaGE8dT48L3U+PHU+PC91
PjwvcD4KPC9kaXY+CjwvZGl2Pgo8L2Rpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91PsKg
PHU+PC91PjwvcD4KPC9kaXY+CjwvZGl2Pgo8L2Rpdj4KPC9kaXY+Cgo8L2Jsb2NrcXVvdGU+PC9k
aXY+Cg==

--===============6289402664132457339==--

