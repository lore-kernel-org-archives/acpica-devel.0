Content-Type: multipart/mixed; boundary="===============7434106600287309640=="
MIME-Version: 1.0
From: ktckd <ktckd9 at gmail.com>
Subject: Re: [Devel] Acpiexec
Date: Thu, 07 Apr 2011 15:16:06 -0500
Message-ID: <BANLkTi=z0Rrpd85FKkv1MwYS-KyD3aSHew@mail.gmail.com>
In-Reply-To: 4911F71203A09E4D9981D27F9D830858D3E4DEBB@orsmsx503.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7434106600287309640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

That is correct. I can send integer arguments (e.g. execute main 1 1) But
have no idea how to send a buffer/package or string as argument.

On Thu, Apr 7, 2011 at 3:09 PM, Moore, Robert <robert.moore(a)intel.com>wro=
te:

> Do you mean that you know how to send an integer argument, but not a buff=
er
> or package?
>
>
>
>
>
> *From:* devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] *On
> Behalf Of *ktckd
> *Sent:* Thursday, April 07, 2011 11:36 AM
> *To:* devel(a)acpica.org
> *Subject:* [Devel] Acpiexec
>
>
>
> Hi,
>
> I am trying to debug my asl code using acpiexec and got stuck at a place
> where I need to send a buffer/package as argument to my method (execute
> <method> [Arguments]). I tried searching the documentation but couldn't f=
ind
> any information. Can someone please help me provide information on how to=
 do
> this?
>
> Thanks
>

--===============7434106600287309640==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

VGhhdCBpcyBjb3JyZWN0LiBJIGNhbiBzZW5kIGludGVnZXIgYXJndW1lbnRzIChlLmcuIGV4ZWN1
dGUgbWFpbiAxIDEpIEJ1dCBoYXZlIG5vIGlkZWEgaG93IHRvIHNlbmQgYSBidWZmZXIvcGFja2Fn
ZSBvciBzdHJpbmcgYXMgYXJndW1lbnQuIDxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUi
Pk9uIFRodSwgQXByIDcsIDIwMTEgYXQgMzowOSBQTSwgTW9vcmUsIFJvYmVydCA8c3BhbiBkaXI9
Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpyb2JlcnQubW9vcmVAaW50ZWwuY29tIj5yb2JlcnQu
bW9vcmVAaW50ZWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj4KCjxibG9ja3F1b3RlIGNs
YXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9ImJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwg
MjA0LCAyMDQpOyBtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBwYWRkaW5nLWxlZnQ6IDFleDsi
PjxkaXYgbGluaz0iYmx1ZSIgdmxpbms9InB1cnBsZSIgbGFuZz0iRU4tVVMiPjxkaXY+PHAgY2xh
c3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTFwdDsgY29sb3I6IHJnYigz
MSwgNzMsIDEyNSk7Ij5EbyB5b3UgbWVhbiB0aGF0IHlvdSBrbm93IGhvdyB0byBzZW5kIGFuIGlu
dGVnZXIgYXJndW1lbnQsIGJ1dCBub3QgYSBidWZmZXIgb3IgcGFja2FnZT88L3NwYW4+PC9wPgoK
PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTFwdDsgY29sb3I6
IHJnYigzMSwgNzMsIDEyNSk7Ij6gPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3Bh
biBzdHlsZT0iZm9udC1zaXplOiAxMXB0OyBjb2xvcjogcmdiKDMxLCA3MywgMTI1KTsiPqA8L3Nw
YW4+PC9wPjxkaXYgc3R5bGU9ImJvcmRlci1zdHlsZTogbm9uZSBub25lIG5vbmUgc29saWQ7IGJv
cmRlci1jb2xvcjogLW1vei11c2UtdGV4dC1jb2xvciAtbW96LXVzZS10ZXh0LWNvbG9yIC1tb3ot
dXNlLXRleHQtY29sb3IgYmx1ZTsgYm9yZGVyLXdpZHRoOiBtZWRpdW0gbWVkaXVtIG1lZGl1bSAx
LjVwdDsgcGFkZGluZzogMGluIDBpbiAwaW4gNHB0OyI+Cgo8ZGl2PjxkaXYgc3R5bGU9ImJvcmRl
ci1zdHlsZTogc29saWQgbm9uZSBub25lOyBib3JkZXItY29sb3I6IHJnYigxODEsIDE5NiwgMjIz
KSAtbW96LXVzZS10ZXh0LWNvbG9yIC1tb3otdXNlLXRleHQtY29sb3I7IGJvcmRlci13aWR0aDog
MXB0IG1lZGl1bSBtZWRpdW07IHBhZGRpbmc6IDNwdCAwaW4gMGluOyI+PHAgY2xhc3M9Ik1zb05v
cm1hbCI+PGI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsiPkZyb206PC9zcGFuPjwvYj48
c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyI+IDxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3Vu
Y2VzQGFjcGljYS5vcmciIHRhcmdldD0iX2JsYW5rIj5kZXZlbC1ib3VuY2VzQGFjcGljYS5vcmc8
L2E+IFttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyIgdGFy
Z2V0PSJfYmxhbmsiPmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZzwvYT5dIDxiPk9uIEJlaGFsZiBP
ZiA8L2I+a3Rja2Q8YnI+Cgo8Yj5TZW50OjwvYj4gVGh1cnNkYXksIEFwcmlsIDA3LCAyMDExIDEx
OjM2IEFNPGJyPjxiPlRvOjwvYj4gPGEgaHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmciIHRh
cmdldD0iX2JsYW5rIj5kZXZlbEBhY3BpY2Eub3JnPC9hPjxicj48Yj5TdWJqZWN0OjwvYj4gW0Rl
dmVsXSBBY3BpZXhlYzwvc3Bhbj48L3A+PC9kaXY+PC9kaXY+PGRpdiBjbGFzcz0iaW0iPjxwIGNs
YXNzPSJNc29Ob3JtYWwiPgoKoDwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj5IaSwgPGJyPjxicj5J
IGFtIHRyeWluZyB0byBkZWJ1ZyBteSBhc2wgY29kZSB1c2luZyBhY3BpZXhlYyBhbmQgZ290IHN0
dWNrIGF0IGEgcGxhY2Ugd2hlcmUgSSBuZWVkIHRvIHNlbmQgYSBidWZmZXIvcGFja2FnZSBhcyBh
cmd1bWVudCB0byBteSBtZXRob2QgKGV4ZWN1dGUgJmx0O21ldGhvZCZndDsgW0FyZ3VtZW50c10p
LiBJIHRyaWVkIHNlYXJjaGluZyB0aGUgZG9jdW1lbnRhdGlvbiBidXQgY291bGRuJiMzOTt0IGZp
bmQgYW55IGluZm9ybWF0aW9uLiBDYW4gc29tZW9uZSBwbGVhc2UgaGVscCBtZSBwcm92aWRlIGlu
Zm9ybWF0aW9uIG9uIGhvdyB0byBkbyB0aGlzPzxicj4KCjxicj5UaGFua3M8L3A+PC9kaXY+PC9k
aXY+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj4K

--===============7434106600287309640==--

