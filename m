Content-Type: multipart/mixed; boundary="===============3579370597830114344=="
MIME-Version: 1.0
From: Liang Qi <cavendish.qi at gmail.com>
Subject: Re: [Devel] Patch for building on Mac
Date: Sat, 11 May 2013 22:16:10 +0200
Message-ID: <CAHceRriFFK8ai7JBMsT=Rdf+9uV+SD6eddBLVaYhRNrv0RSvBw@mail.gmail.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E36FE54316@ORSMSX103.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3579370597830114344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I think I fixed in makefile side now, in new Pull Request, #8
https://github.com/acpica/acpica/pull/8

Could you guys help to test it on Linux and Cygwin? Hope I didn't break the
build there.

Regards,
Liang


On 8 May 2013 14:57, Moore, Robert <robert.moore(a)intel.com> wrote:

>  That=E2=80=99s fine, but there is not much we can do with this.****
>
> ** **
>
> We expect that the makefile(s) may need customization for other platforms.
> The existing makefiles build on Linux and Cygwin.****
>
> ** **
>
> Bob****
>
> ** **
>
> ** **
>
> *From:* devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] *On
> Behalf Of *Liang Qi
> *Sent:* Wednesday, May 08, 2013 2:10 AM
> *To:* devel(a)acpica.org
> *Subject:* [Devel] Patch for building on Mac****
>
> ** **
>
> https://github.com/acpica/acpica/pull/7****
>
> ** **
>
> I only tested on 10.8.3, the build works.****
>
> ** **
>
> Just for your information, because I found there is another pending Pull
> Request, which was opened about a month ago.****
>
> ** **
>
> Regards,****
>
> Liang
> ****
>
> ** **
>

--===============3579370597830114344==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsLHNhbnMtc2VyaWY7
Zm9udC1zaXplOjEzcHgiPkkgdGhpbmsgSSBmaXhlZCBpbiBtYWtlZmlsZSBzaWRlIG5vdywgaW4g
bmV3IFB1bGwgUmVxdWVzdCwgIzg8L3NwYW4+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6YXJpYWws
c2Fucy1zZXJpZjtmb250LXNpemU6MTNweCI+PGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL2Fj
cGljYS9hY3BpY2EvcHVsbC84IiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRodWIuY29tL2Fj
cGljYS9hY3BpY2EvcHVsbC84PC9hPjxicj4KPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6
YXJpYWwsc2Fucy1zZXJpZjtmb250LXNpemU6MTNweCI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9ImZv
bnQtZmFtaWx5OmFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEzcHgiPkNvdWxkIHlvdSBndXlz
IGhlbHAgdG8gdGVzdCBpdCBvbiBMaW51eCBhbmQgQ3lnd2luPyBIb3BlIEkgZGlkbiYjMzk7dCBi
cmVhayB0aGUgYnVpbGQgdGhlcmUuPC9kaXY+CjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFs
LHNhbnMtc2VyaWY7Zm9udC1zaXplOjEzcHgiPjxicj48L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZh
bWlseTphcmlhbCxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxM3B4Ij5SZWdhcmRzLDwvZGl2PjxkaXYg
c3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEzcHgiPkxpYW5n
PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPgo8YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj5PbiA4IE1heSAyMDEzIDE0OjU3LCBNb29yZSwgUm9iZXJ0IDxzcGFuIGRpcj0ibHRy
Ij4mbHQ7PGEgaHJlZj0ibWFpbHRvOnJvYmVydC5tb29yZUBpbnRlbC5jb20iIHRhcmdldD0iX2Js
YW5rIj5yb2JlcnQubW9vcmVAaW50ZWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3Jk
ZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KCgoKCgoKPGRpdiBsYW5n
PSJFTi1VUyIgbGluaz0iYmx1ZSIgdmxpbms9InB1cnBsZSI+CjxkaXY+CjxwIGNsYXNzPSJNc29O
b3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0Nh
bGlicmkmcXVvdDssJnF1b3Q7c2Fucy1zZXJpZiZxdW90Oztjb2xvcjojMWY0OTdkIj5UaGF04oCZ
cyBmaW5lLCBidXQgdGhlcmUgaXMgbm90IG11Y2ggd2UgY2FuIGRvIHdpdGggdGhpcy48dT48L3U+
PHU+PC91Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250
LXNpemU6MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssJnF1b3Q7c2Fucy1z
ZXJpZiZxdW90Oztjb2xvcjojMWY0OTdkIj48dT48L3U+wqA8dT48L3U+PC9zcGFuPjwvcD4KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1mYW1p
bHk6JnF1b3Q7Q2FsaWJyaSZxdW90OywmcXVvdDtzYW5zLXNlcmlmJnF1b3Q7O2NvbG9yOiMxZjQ5
N2QiPldlIGV4cGVjdCB0aGF0IHRoZSBtYWtlZmlsZShzKSBtYXkgbmVlZCBjdXN0b21pemF0aW9u
IGZvciBvdGhlciBwbGF0Zm9ybXMuIFRoZSBleGlzdGluZyBtYWtlZmlsZXMgYnVpbGQgb24gTGlu
dXggYW5kIEN5Z3dpbi48dT48L3U+PHU+PC91Pjwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9y
bWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxp
YnJpJnF1b3Q7LCZxdW90O3NhbnMtc2VyaWYmcXVvdDs7Y29sb3I6IzFmNDk3ZCI+PHU+PC91PsKg
PHU+PC91Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250
LXNpemU6MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssJnF1b3Q7c2Fucy1z
ZXJpZiZxdW90Oztjb2xvcjojMWY0OTdkIj5Cb2I8dT48L3U+PHU+PC91Pjwvc3Bhbj48L3A+Cjxw
IGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTEuMHB0O2ZvbnQtZmFt
aWx5OiZxdW90O0NhbGlicmkmcXVvdDssJnF1b3Q7c2Fucy1zZXJpZiZxdW90Oztjb2xvcjojMWY0
OTdkIj48dT48L3U+wqA8dT48L3U+PC9zcGFuPjwvcD4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNw
YW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90
OywmcXVvdDtzYW5zLXNlcmlmJnF1b3Q7O2NvbG9yOiMxZjQ5N2QiPjx1PjwvdT7CoDx1PjwvdT48
L3NwYW4+PC9wPgo8ZGl2IHN0eWxlPSJib3JkZXI6bm9uZTtib3JkZXItbGVmdDpzb2xpZCBibHVl
IDEuNXB0O3BhZGRpbmc6MGluIDBpbiAwaW4gNC4wcHQiPgo8ZGl2Pgo8ZGl2IHN0eWxlPSJib3Jk
ZXI6bm9uZTtib3JkZXItdG9wOnNvbGlkICNiNWM0ZGYgMS4wcHQ7cGFkZGluZzozLjBwdCAwaW4g
MGluIDBpbiI+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6
MTAuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O1RhaG9tYSZxdW90OywmcXVvdDtzYW5zLXNlcmlmJnF1
b3Q7Ij5Gcm9tOjwvc3Bhbj48L2I+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMC4wcHQ7Zm9udC1m
YW1pbHk6JnF1b3Q7VGFob21hJnF1b3Q7LCZxdW90O3NhbnMtc2VyaWYmcXVvdDsiPiA8YSBocmVm
PSJtYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnIiB0YXJnZXQ9Il9ibGFuayI+ZGV2ZWwt
Ym91bmNlc0BhY3BpY2Eub3JnPC9hPiBbbWFpbHRvOjxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3Vu
Y2VzQGFjcGljYS5vcmciIHRhcmdldD0iX2JsYW5rIj5kZXZlbC1ib3VuY2VzQGFjcGljYS5vcmc8
L2E+XQo8Yj5PbiBCZWhhbGYgT2YgPC9iPkxpYW5nIFFpPGJyPgo8Yj5TZW50OjwvYj4gV2VkbmVz
ZGF5LCBNYXkgMDgsIDIwMTMgMjoxMCBBTTxicj4KPGI+VG86PC9iPiA8YSBocmVmPSJtYWlsdG86
ZGV2ZWxAYWNwaWNhLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmRldmVsQGFjcGljYS5vcmc8L2E+PGJy
Pgo8Yj5TdWJqZWN0OjwvYj4gW0RldmVsXSBQYXRjaCBmb3IgYnVpbGRpbmcgb24gTWFjPHU+PC91
Pjx1PjwvdT48L3NwYW4+PC9wPgo8L2Rpdj4KPC9kaXY+PGRpdj48ZGl2IGNsYXNzPSJoNSI+Cjxw
IGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+CjxkaXY+CjxwIGNsYXNzPSJN
c29Ob3JtYWwiPjxhIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9hY3BpY2EvYWNwaWNhL3B1bGwv
NyIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vZ2l0aHViLmNvbS9hY3BpY2EvYWNwaWNhL3B1bGwv
NzwvYT48dT48L3U+PHU+PC91PjwvcD4KPGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91
PsKgPHU+PC91PjwvcD4KPC9kaXY+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPkkgb25seSB0
ZXN0ZWQgb24gMTAuOC4zLCB0aGUgYnVpbGQgd29ya3MuPHU+PC91Pjx1PjwvdT48L3A+CjxkaXY+
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+CjwvZGl2Pgo8ZGl2Pgo8
cCBjbGFzcz0iTXNvTm9ybWFsIj5KdXN0IGZvciB5b3VyIGluZm9ybWF0aW9uLCBiZWNhdXNlIEkg
Zm91bmQgdGhlcmUgaXMgYW5vdGhlciBwZW5kaW5nIFB1bGwgUmVxdWVzdCwgd2hpY2ggd2FzIG9w
ZW5lZCBhYm91dCBhIG1vbnRoIGFnby48dT48L3U+PHU+PC91PjwvcD4KPC9kaXY+CjxkaXY+Cjxw
IGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+CjwvZGl2Pgo8ZGl2Pgo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5SZWdhcmRzLDx1PjwvdT48dT48L3U+PC9wPgo8L2Rpdj4KPGRpdj4K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+TGlhbmc8YnIgY2xlYXI9ImFsbCI+Cjx1PjwvdT48dT48L3U+
PC9wPgo8ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48dT48L3U+wqA8dT48L3U+PC9wPgo8L2Rp
dj4KPC9kaXY+CjwvZGl2Pgo8L2Rpdj4KPC9kaXY+PC9kaXY+PC9kaXY+CjwvZGl2Pgo8L2Rpdj4K
CjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PGJyPjwvZGl2PjwvZGl2Pgo=

--===============3579370597830114344==--

