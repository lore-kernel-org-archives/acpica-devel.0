Content-Type: multipart/mixed; boundary="===============2623402538963566030=="
MIME-Version: 1.0
From: Mike Gerdts <mike.gerdts at joyent.com>
Subject: Re: [Devel] fix for 1831 broke AcpiEvaluateObjectTyped, maybe
Date: Mon, 04 Dec 2017 11:38:17 -0600
Message-ID: <CAAxFYUGG953qX5qXr_QAbPo2X27cnxKkpoYGcJ_wOgt7JQk3Sw@mail.gmail.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E3B74E8553@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2623402538963566030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks for the quick confirmation. I've filed:

Bug 1431 - fix for 1831 broke AcpiEvaluateObjectTyped

Regards,
Mike


On Mon, Dec 4, 2017 at 11:08 AM, Moore, Robert <robert.moore(a)intel.com>
wrote:

> Pathname is indeed optional
>
>
>
> *From:* Devel [mailto:devel-bounces(a)acpica.org] *On Behalf Of *Mike Ger=
dts
> *Sent:* Monday, December 4, 2017 8:56 AM
> *To:* devel(a)acpica.org
> *Subject:* [Devel] fix for 1831 broke AcpiEvaluateObjectTyped, maybe
>
>
>
> The comment above AcpiEvaluateObjectTyped says that the Pathname option is
> optional.  The ACPICA User and and Programmer Reference Revision 6.2 makes
> no mention of it being optional.
>
>
>
> It seems as though the fix for
>
>
>
> Bug 1381 - More improved error messages for predefined methods (return
> value)
>
>
>
> was either a bad fix or incomplete.  If Pathname is intended to be
> optional, it was a bad fix.  If it is not optional, the fix should have
> corrected the comment above the function body.
>
>
>
> Any advice on what the correct behavior is would be most appreciated.
>
>
>
> TIA,
>
> Mike
>

--===============2623402538963566030==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+VGhhbmtzIGZvciB0aGUgcXVpY2sgY29uZmlybWF0aW9uLiBJJiMzOTt2
ZSBmaWxlZDo8ZGl2Pjxicj48L2Rpdj48ZGl2PkJ1ZyAxNDMxIC0gZml4IGZvciAxODMxIGJyb2tl
IEFjcGlFdmFsdWF0ZU9iamVjdFR5cGVkPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UmVn
YXJkcyw8L2Rpdj48ZGl2Pk1pa2U8L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj48ZGl2IGNsYXNz
PSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBNb24sIERlYyA0
LCAyMDE3IGF0IDExOjA4IEFNLCBNb29yZSwgUm9iZXJ0IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEg
aHJlZj0ibWFpbHRvOnJvYmVydC5tb29yZUBpbnRlbC5jb20iIHRhcmdldD0iX2JsYW5rIj5yb2Jl
cnQubW9vcmVAaW50ZWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDox
cHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KCgoKCgo8ZGl2IGxhbmc9IkVOLVVTIiBs
aW5rPSIjMDU2M0MxIiB2bGluaz0iIzk1NEY3MiI+CjxkaXYgY2xhc3M9Im1fNTM1NjYyODIzMDUz
MTE0NjE3M1dvcmRTZWN0aW9uMSI+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJm
b250LXNpemU6MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJp
Zjtjb2xvcjojMWY0OTdkIj5QYXRobmFtZSBpcyBpbmRlZWQgb3B0aW9uYWw8dT48L3U+PHU+PC91
Pjwvc3Bhbj48L3A+CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6
MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZjtjb2xvcjoj
MWY0OTdkIj48dT48L3U+wqA8dT48L3U+PC9zcGFuPjwvcD4KPGRpdiBzdHlsZT0iYm9yZGVyOm5v
bmU7Ym9yZGVyLWxlZnQ6c29saWQgYmx1ZSAxLjVwdDtwYWRkaW5nOjBpbiAwaW4gMGluIDQuMHB0
Ij4KPGRpdj4KPGRpdiBzdHlsZT0iYm9yZGVyOm5vbmU7Ym9yZGVyLXRvcDpzb2xpZCAjZTFlMWUx
IDEuMHB0O3BhZGRpbmc6My4wcHQgMGluIDBpbiAwaW4iPgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48
YSBuYW1lPSJtXzUzNTY2MjgyMzA1MzExNDYxNzNfX19fX19yZXBseXNlcGFyYXRvciI+PC9hPjxi
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkm
cXVvdDssc2Fucy1zZXJpZiI+RnJvbTo8L3NwYW4+PC9iPjxzcGFuIHN0eWxlPSJmb250LXNpemU6
MTEuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZiI+IERldmVs
IFttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyIgdGFyZ2V0
PSJfYmxhbmsiPmRldmVsLWJvdW5jZXNAYWNwaWNhLjx3YnI+b3JnPC9hPl0KPGI+T24gQmVoYWxm
IE9mIDwvYj5NaWtlIEdlcmR0czxicj4KPGI+U2VudDo8L2I+IE1vbmRheSwgRGVjZW1iZXIgNCwg
MjAxNyA4OjU2IEFNPGJyPgo8Yj5Ubzo8L2I+IDxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eu
b3JnIiB0YXJnZXQ9Il9ibGFuayI+ZGV2ZWxAYWNwaWNhLm9yZzwvYT48YnI+CjxiPlN1YmplY3Q6
PC9iPiBbRGV2ZWxdIGZpeCBmb3IgMTgzMSBicm9rZSBBY3BpRXZhbHVhdGVPYmplY3RUeXBlZCwg
bWF5YmU8dT48L3U+PHU+PC91Pjwvc3Bhbj48L3A+CjwvZGl2Pgo8L2Rpdj48ZGl2PjxkaXYgY2xh
c3M9Img1Ij4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHU+PC91PsKgPHU+PC91PjwvcD4KPGRpdj4K
PGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+VGhlIGNvbW1lbnQgYWJvdmUgQWNwaUV2YWx1YXRl
T2JqZWN0VHlwZWQgc2F5cyB0aGF0IHRoZSBQYXRobmFtZSBvcHRpb24gaXMgb3B0aW9uYWwuwqAg
VGhlIEFDUElDQSBVc2VyIGFuZCBhbmQgUHJvZ3JhbW1lciBSZWZlcmVuY2UgUmV2aXNpb24gNi4y
IG1ha2VzIG5vIG1lbnRpb24gb2YgaXQgYmVpbmcgb3B0aW9uYWwuPHU+PC91Pjx1PjwvdT48L3A+
CjwvZGl2Pgo8ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48dT48L3U+wqA8dT48L3U+PC9wPgo8
L2Rpdj4KPGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SXQgc2VlbXMgYXMgdGhvdWdoIHRoZSBm
aXggZm9yPHU+PC91Pjx1PjwvdT48L3A+CjwvZGl2Pgo8ZGl2Pgo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij48dT48L3U+wqA8dT48L3U+PC9wPgo8L2Rpdj4KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QnVnIDEz
ODEgLSBNb3JlIGltcHJvdmVkIGVycm9yIG1lc3NhZ2VzIGZvciBwcmVkZWZpbmVkIG1ldGhvZHMg
KHJldHVybiB2YWx1ZSk8dT48L3U+PHU+PC91PjwvcD4KPGRpdj4KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+PHU+PC91PsKgPHU+PC91PjwvcD4KPC9kaXY+CjxkaXY+CjxwIGNsYXNzPSJNc29Ob3JtYWwi
PndhcyBlaXRoZXIgYSBiYWQgZml4IG9yIGluY29tcGxldGUuwqAgSWYgUGF0aG5hbWUgaXMgaW50
ZW5kZWQgdG8gYmUgb3B0aW9uYWwsIGl0IHdhcyBhIGJhZCBmaXguwqAgSWYgaXQgaXMgbm90IG9w
dGlvbmFsLCB0aGUgZml4IHNob3VsZCBoYXZlIGNvcnJlY3RlZCB0aGUgY29tbWVudCBhYm92ZSB0
aGUgZnVuY3Rpb24gYm9keS48dT48L3U+PHU+PC91PjwvcD4KPC9kaXY+CjxkaXY+CjxwIGNsYXNz
PSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+CjwvZGl2Pgo8ZGl2Pgo8cCBjbGFzcz0i
TXNvTm9ybWFsIj5BbnkgYWR2aWNlIG9uIHdoYXQgdGhlIGNvcnJlY3QgYmVoYXZpb3IgaXMgd291
bGQgYmUgbW9zdCBhcHByZWNpYXRlZC48dT48L3U+PHU+PC91PjwvcD4KPC9kaXY+CjxkaXY+Cjxw
IGNsYXNzPSJNc29Ob3JtYWwiPjx1PjwvdT7CoDx1PjwvdT48L3A+CjwvZGl2Pgo8ZGl2Pgo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5USUEsPHU+PC91Pjx1PjwvdT48L3A+CjwvZGl2Pgo8ZGl2Pgo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5NaWtlPHU+PC91Pjx1PjwvdT48L3A+CjwvZGl2Pgo8L2Rpdj4KPC9k
aXY+PC9kaXY+PC9kaXY+CjwvZGl2Pgo8L2Rpdj4KCjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PC9k
aXY+Cg==

--===============2623402538963566030==--

