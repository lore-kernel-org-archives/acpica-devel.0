Content-Type: multipart/mixed; boundary="===============3352534729640670735=="
MIME-Version: 1.0
From: Sascha Wildner <swildner at gmail.com>
Subject: Re: [Devel] Wrong license in acpica-unix2-20140114/.../aehandlers.c
Date: Wed, 12 Feb 2014 06:31:12 +0100
Message-ID: <CABC13nGcFvCN767yc6bpOD0+VTWi2LvHnkR8WNs5Rp9D7gA=LQ@mail.gmail.com>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E88024AFB11@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3352534729640670735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

No, I didn't change anything anywhere. I just wanted to report that in
https://acpica.org/sites/acpica/files/acpica-unix2-20140114.tar.gzaehandler=
s.c's
license is the Intel one, for some reason, while in
https://acpica.org/sites/acpica/files/acpica-unix2-20131218.tar.gz it was
still the dual one. :)

Sascha



On Wed, Feb 12, 2014 at 6:19 AM, Zheng, Lv <lv.zheng(a)intel.com> wrote:

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
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Sascha Wildn=
er
> Sent: Tuesday, February 11, 2014 5:54 PM
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

--===============3352534729640670735==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+Tm8sIEkgZGlkbiYjMzk7dCBjaGFuZ2UgYW55dGhpbmcgYW55d2hlcmUu
IEkganVzdCB3YW50ZWQgdG8gcmVwb3J0IHRoYXQgaW4gPGEgaHJlZj0iaHR0cHM6Ly9hY3BpY2Eu
b3JnL3NpdGVzL2FjcGljYS9maWxlcy9hY3BpY2EtdW5peDItMjAxNDAxMTQudGFyLmd6Ij5odHRw
czovL2FjcGljYS5vcmcvc2l0ZXMvYWNwaWNhL2ZpbGVzL2FjcGljYS11bml4Mi0yMDE0MDExNC50
YXIuZ3o8L2E+IGFlaGFuZGxlcnMuYyYjMzk7cyBsaWNlbnNlIGlzIHRoZSBJbnRlbCBvbmUsIGZv
ciBzb21lIHJlYXNvbiwgd2hpbGUgaW7CoDxhIGhyZWY9Imh0dHBzOi8vYWNwaWNhLm9yZy9zaXRl
cy9hY3BpY2EvZmlsZXMvYWNwaWNhLXVuaXgyLTIwMTMxMjE4LnRhci5neiI+aHR0cHM6Ly9hY3Bp
Y2Eub3JnL3NpdGVzL2FjcGljYS9maWxlcy9hY3BpY2EtdW5peDItMjAxMzEyMTgudGFyLmd6PC9h
PiBpdCB3YXMgc3RpbGwgdGhlIGR1YWwgb25lLiA6KTxkaXY+Cjxicj48L2Rpdj48ZGl2PlNhc2No
YTwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+
PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBXZWQsIEZlYiAxMiwgMjAxNCBhdCA2OjE5
IEFNLCBaaGVuZywgTHYgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86bHYuemhl
bmdAaW50ZWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bHYuemhlbmdAaW50ZWwuY29tPC9hPiZndDs8
L3NwYW4+IHdyb3RlOjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0
OjFleCI+SGksIFNhc2NoYTxicj4KPGJyPgpIYXZlIHlvdSBtb2RpZmllZCB0aGUgYWVoYW5kbGVy
cy5jPzxicj4KSSByYW4gYWNwaXNyYyAtaCAteSBtYW51YWxseSBvbiBhZWhhbmRsZXJzLmMsIG5v
IGZhbHNlIGdlbmVyYXRpb24gb2YgZHVhbCBsaWNlbnNlIGhlYWRlciBjb3VsZCBiZSBmb3VuZC48
YnI+Cjxicj4KWW91IGNhbiB0cnk6PGJyPgojIGNkICZsdDthY3BpY2Egc3JjZGlyJmd0Ozxicj4K
IyBtYWtlIGFjcGlzcmM8YnI+CiMgZ2VuZXJhdGUvdW5peC9iaW4vYWNwaXNyYyAtaCAteSBzb3Vy
Y2UvdG9vbHMvYWNwaWV4ZWMvYWVoYW5kbGVycy5jIGFlaGFuZGxlcnMuYzxicj4KQW5kIHRha2Ug
YSBsb29rIGF0IOKAnC4vYWVoYW5kbGVycy5j4oCdLjxicj4KPGJyPgpQbGVhc2UgbWFrZSBzdXJl
IHRoYXQgdGhlIGhlYWRlciBvZiBhZWhhbmRsZXJzLmMgaGFzIGNvbnRhaW5lZCB0aGUgbGluZXMg
aW5kaWNhdGVkIGJ5IHRoZSDigJxIZWFkZXJCZWdpbuKAnSBpbiBzb3VyY2UvdG9vbHMvYWNwaXNy
Yy9hc2NvbnZlcnQuYy48YnI+CkFuZCBwbGVhc2UgYWxzbyBtYWtlIHN1cmUgdGhhdCB0aGVyZSBp
cyBubyBhZGRpdGlvbmFsIOKAnFxy4oCdLCAmcXVvdDtcbiZxdW90OyBvciBzcGFjZXMgYW1vbmcg
dGhlc2UgbGluZXMuPGJyPgo8YnI+ClRoYW5rcyBhbmQgYmVzdCByZWdhcmRzPGJyPgotTHY8YnI+
CjxkaXYgY2xhc3M9IiI+PGJyPgo8YnI+CkZyb206IERldmVsIFttYWlsdG86PGEgaHJlZj0ibWFp
bHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyI+ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnPC9h
Pl0gT24gQmVoYWxmIE9mIFNhc2NoYSBXaWxkbmVyPGJyPgo8L2Rpdj5TZW50OiBUdWVzZGF5LCBG
ZWJydWFyeSAxMSwgMjAxNCA1OjU0IFBNPGJyPgo8ZGl2IGNsYXNzPSJIT0VuWmIiPjxkaXYgY2xh
c3M9Img1Ij48YnI+CkhlbGxvLDxicj4KPGJyPgppbsKgYWNwaWNhLXVuaXgyLTIwMTQwMTE0L3Nv
dXJjZS90b29scy9hY3BpZXhlYy9hZWhhbmRsZXJzLmMsIGkuZS4gdGhlIGR1YWwtbGljZW5zZWQg
dmVyc2lvbiwgdGhlIGxpY2Vuc2Ugd2FzIChhY2NpZGVudGFsbHksIEkgc3VwcG9zZSkgZXhjaGFu
Z2VkIHdpdGggdGhlIEludGVsIGxpY2Vuc2UsIHdoZW4ganVzdCB0aGUgY29weXJpZ2h0IHllYXIg
c2hvdWxkIGhhdmUgYmVlbiBidW1wZWQuPGJyPgoKPGJyPgpSZWdhcmRzLDxicj4KU2FzY2hhPGJy
Pgo8YnI+CjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PC9kaXY+Cg==

--===============3352534729640670735==--

