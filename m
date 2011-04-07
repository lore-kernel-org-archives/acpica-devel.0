Content-Type: multipart/mixed; boundary="===============6843602914581222224=="
MIME-Version: 1.0
From: ktckd <ktckd9 at gmail.com>
Subject: Re: [Devel] Acpiexec
Date: Thu, 07 Apr 2011 16:25:56 -0500
Message-ID: <BANLkTimZ4KKGxrjhhFKt7FuTrNdLG2UwhA@mail.gmail.com>
In-Reply-To: 4911F71203A09E4D9981D27F9D830858D3E4DF84@orsmsx503.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6843602914581222224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robert,

Thanks for the reply. I actually did come across this section before. But I
guess I am not following it correctly or may be I am not clear.

Below is my asl code:
DefinitionBlock ("dsdt.aml", "DSDT", 2, "Intel", "Template", 0x00000001)
{
    Method (MAIN, 2, NotSerialized)
    {
        Store (__FILE__, Debug)
        Store (__LINE__, Debug)
        Store (__DATE__, Debug)
        Store (Arg0,Debug)
        Store (DerefOf(Index(Arg1,0)),Local0)
        Store (Local0,Debug)

        Return (Package(4){
           0x08,
           0x40,
           0x01,
           0x00
        })
    }

    Method (TEST, 2, NotSerialized)
    {
        Store (Arg0,Debug)
        Store (Arg1,Debug)
    }
}

I compiled the above code (iasl dsdt.asl) and started debugging it using the
acpiexec (acpiexec -v dsdt.aml). However, when I try 'execute main 1 1' I
keep getting the below error message:
Needed [Buffer/String/Package], found [Integer] 004B7F98

I  understand that we need to follow a specific format while passing
package/string/buffer arguments in the above scenario. I tried to play
around various formats (e.g. execute main 1, buffer(){0x01,0x02}) but none
of them worked.

Can you please provide some more insight into this?

Thanks


On Thu, Apr 7, 2011 at 3:51 PM, Moore, Robert <robert.moore(a)intel.com>wro=
te:

>
>
> In the ACPI Component Architecture User Guide and Programmer Reference,
> Revision 4.08,
>
>
>
> See section 6.2.10 =E2=80=9CACPI_OBJECT =E2=80=93 Method Parameters and R=
eturn Objects
>
>
>
> *From:* ktckd [mailto:ktckd9(a)gmail.com]
> *Sent:* Thursday, April 07, 2011 1:16 PM
> *To:* Moore, Robert
> *Cc:* devel(a)acpica.org
> *Subject:* Re: [Devel] Acpiexec
>
>
>
> That is correct. I can send integer arguments (e.g. execute main 1 1) But
> have no idea how to send a buffer/package or string as argument.
>
> On Thu, Apr 7, 2011 at 3:09 PM, Moore, Robert <robert.moore(a)intel.com>
> wrote:
>
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
>
>

--===============6843602914581222224==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgUm9iZXJ0LCA8YnI+PGJyPlRoYW5rcyBmb3IgdGhlIHJlcGx5LiBJIGFjdHVhbGx5IGRpZCBj
b21lIGFjcm9zcyB0aGlzIHNlY3Rpb24gYmVmb3JlLiBCdXQgSSBndWVzcyBJIGFtIG5vdCBmb2xs
b3dpbmcgaXQgY29ycmVjdGx5IG9yIG1heSBiZSBJIGFtIG5vdCBjbGVhci4gPGJyPjxicj5CZWxv
dyBpcyBteSBhc2wgY29kZTo8YnI+RGVmaW5pdGlvbkJsb2NrICgmcXVvdDtkc2R0LmFtbCZxdW90
OywgJnF1b3Q7RFNEVCZxdW90OywgMiwgJnF1b3Q7SW50ZWwmcXVvdDssICZxdW90O1RlbXBsYXRl
JnF1b3Q7LCAweDAwMDAwMDAxKTxicj4KCns8YnI+oKCgIE1ldGhvZCAoTUFJTiwgMiwgTm90U2Vy
aWFsaXplZCk8YnI+oKCgIHs8YnI+oKCgoKCgoCBTdG9yZSAoX19GSUxFX18sIERlYnVnKTxicj6g
oKCgoKCgIFN0b3JlIChfX0xJTkVfXywgRGVidWcpPGJyPqCgoKCgoKAgU3RvcmUgKF9fREFURV9f
LCBEZWJ1Zyk8YnI+oKCgoKCgoCBTdG9yZSAoQXJnMCxEZWJ1Zyk8YnI+oKCgoKCgoCBTdG9yZSAo
RGVyZWZPZihJbmRleChBcmcxLDApKSxMb2NhbDApPGJyPgoKoKCgoKCgoCBTdG9yZSAoTG9jYWww
LERlYnVnKTxicj6goKCgoKCgIDxicj6goKCgoKCgIFJldHVybiAoUGFja2FnZSg0KXs8YnI+oKCg
oKCgoKCgoCAweDA4LDxicj6goKCgoKCgoKCgIDB4NDAsPGJyPqCgoKCgoKCgoKAgMHgwMSw8YnI+
oKCgoKCgoKCgoCAweDAwPGJyPqCgoKCgoKAgfSk8YnI+oKCgIH08YnI+PGJyPqCgoCBNZXRob2Qg
KFRFU1QsIDIsIE5vdFNlcmlhbGl6ZWQpPGJyPgqgoKAgezxicj4KoKCgoKCgoCBTdG9yZSAoQXJn
MCxEZWJ1Zyk8YnI+oKCgoKCgoCBTdG9yZSAoQXJnMSxEZWJ1Zyk8YnI+oKCgIH08YnI+fTxicj48
YnI+SSBjb21waWxlZCB0aGUgYWJvdmUgY29kZSAoaWFzbCBkc2R0LmFzbCkgYW5kIHN0YXJ0ZWQg
ZGVidWdnaW5nIGl0IHVzaW5nIHRoZSBhY3BpZXhlYyAoYWNwaWV4ZWMgLXYgZHNkdC5hbWwpLiBI
b3dldmVyLCB3aGVuIEkgdHJ5ICYjMzk7ZXhlY3V0ZSBtYWluIDEgMSYjMzk7IEkga2VlcCBnZXR0
aW5nIHRoZSBiZWxvdyBlcnJvciBtZXNzYWdlOjxicj4KCk5lZWRlZCBbQnVmZmVyL1N0cmluZy9Q
YWNrYWdlXSwgZm91bmQgW0ludGVnZXJdIDAwNEI3Rjk4PGJyPjxicj5JoCB1bmRlcnN0YW5kIHRo
YXQgd2UgbmVlZCB0byBmb2xsb3cgYSBzcGVjaWZpYyBmb3JtYXQgd2hpbGUgcGFzc2luZyBwYWNr
YWdlL3N0cmluZy9idWZmZXIgYXJndW1lbnRzIGluIHRoZSBhYm92ZSBzY2VuYXJpby4gSSB0cmll
ZCB0byBwbGF5IGFyb3VuZCB2YXJpb3VzIGZvcm1hdHMgKGUuZy4gZXhlY3V0ZSBtYWluIDEsIGJ1
ZmZlcigpezB4MDEsMHgwMn0pIGJ1dCBub25lIG9mIHRoZW0gd29ya2VkLiA8YnI+Cgo8YnI+Q2Fu
IHlvdSBwbGVhc2UgcHJvdmlkZSBzb21lIG1vcmUgaW5zaWdodCBpbnRvIHRoaXM/PGJyPjxicj5U
aGFua3M8YnI+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gVGh1LCBBcHIgNywg
MjAxMSBhdCAzOjUxIFBNLCBNb29yZSwgUm9iZXJ0IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJl
Zj0ibWFpbHRvOnJvYmVydC5tb29yZUBpbnRlbC5jb20iPnJvYmVydC5tb29yZUBpbnRlbC5jb208
L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPgoKPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0iYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IG1hcmdp
bjogMHB0IDBwdCAwcHQgMC44ZXg7IHBhZGRpbmctbGVmdDogMWV4OyI+PGRpdiBsaW5rPSJibHVl
IiB2bGluaz0icHVycGxlIiBsYW5nPSJFTi1VUyI+PGRpdj48cCBjbGFzcz0iTXNvTm9ybWFsIj48
c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMXB0OyBjb2xvcjogcmdiKDMxLCA3MywgMTI1KTsiPqA8
L3NwYW4+PC9wPgoKPHAgc3R5bGU9ImxpbmUtaGVpZ2h0OiBub3JtYWw7Ij48c3BhbiBzdHlsZT0i
Zm9udC1zaXplOiAxMXB0OyBjb2xvcjogcmdiKDMxLCA3MywgMTI1KTsiPkluIHRoZSA8L3NwYW4+
QUNQSSBDb21wb25lbnQgQXJjaGl0ZWN0dXJlIFVzZXIgR3VpZGUgYW5kIFByb2dyYW1tZXIgUmVm
ZXJlbmNlLCBSZXZpc2lvbiA0LjA4LDwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHls
ZT0iZm9udC1zaXplOiAxMXB0OyBjb2xvcjogcmdiKDMxLCA3MywgMTI1KTsiPqA8L3NwYW4+PC9w
PgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTFwdDsgY29s
b3I6IHJnYigzMSwgNzMsIDEyNSk7Ij5TZWUgc2VjdGlvbiA2LjIuMTAgk0FDUElfT0JKRUNUIJYg
TWV0aG9kIFBhcmFtZXRlcnMgYW5kIFJldHVybiBPYmplY3RzPC9zcGFuPjwvcD48cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMXB0OyBjb2xvcjogcmdiKDMxLCA3
MywgMTI1KTsiPqA8L3NwYW4+PC9wPgoKPGRpdiBzdHlsZT0iYm9yZGVyLXN0eWxlOiBub25lIG5v
bmUgbm9uZSBzb2xpZDsgYm9yZGVyLWNvbG9yOiAtbW96LXVzZS10ZXh0LWNvbG9yIC1tb3otdXNl
LXRleHQtY29sb3IgLW1vei11c2UtdGV4dC1jb2xvciBibHVlOyBib3JkZXItd2lkdGg6IG1lZGl1
bSBtZWRpdW0gbWVkaXVtIDEuNXB0OyBwYWRkaW5nOiAwaW4gMGluIDBpbiA0cHQ7Ij48ZGl2Pjxk
aXYgc3R5bGU9ImJvcmRlci1zdHlsZTogc29saWQgbm9uZSBub25lOyBib3JkZXItY29sb3I6IHJn
YigxODEsIDE5NiwgMjIzKSAtbW96LXVzZS10ZXh0LWNvbG9yIC1tb3otdXNlLXRleHQtY29sb3I7
IGJvcmRlci13aWR0aDogMXB0IG1lZGl1bSBtZWRpdW07IHBhZGRpbmc6IDNwdCAwaW4gMGluOyI+
Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48Yj48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyI+
RnJvbTo8L3NwYW4+PC9iPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDEwcHQ7Ij4ga3Rja2QgW21h
aWx0bzo8YSBocmVmPSJtYWlsdG86a3Rja2Q5QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmt0
Y2tkOUBnbWFpbC5jb208L2E+XSA8YnI+PGI+U2VudDo8L2I+IFRodXJzZGF5LCBBcHJpbCAwNywg
MjAxMSAxOjE2IFBNPGJyPgoKPGI+VG86PC9iPiBNb29yZSwgUm9iZXJ0PGJyPjxiPkNjOjwvYj4g
PGEgaHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmciIHRhcmdldD0iX2JsYW5rIj5kZXZlbEBh
Y3BpY2Eub3JnPC9hPjxicj48Yj5TdWJqZWN0OjwvYj4gUmU6IFtEZXZlbF0gQWNwaWV4ZWM8L3Nw
YW4+PC9wPjwvZGl2PjwvZGl2PjxkaXY+PGRpdj48L2Rpdj48ZGl2IGNsYXNzPSJoNSI+PHAgY2xh
c3M9Ik1zb05vcm1hbCI+CgqgPC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtYXJnaW4t
Ym90dG9tOiAxMnB0OyI+VGhhdCBpcyBjb3JyZWN0LiBJIGNhbiBzZW5kIGludGVnZXIgYXJndW1l
bnRzIChlLmcuIGV4ZWN1dGUgbWFpbiAxIDEpIEJ1dCBoYXZlIG5vIGlkZWEgaG93IHRvIHNlbmQg
YSBidWZmZXIvcGFja2FnZSBvciBzdHJpbmcgYXMgYXJndW1lbnQuIDwvcD48ZGl2PjxwIGNsYXNz
PSJNc29Ob3JtYWwiPgoKT24gVGh1LCBBcHIgNywgMjAxMSBhdCAzOjA5IFBNLCBNb29yZSwgUm9i
ZXJ0ICZsdDs8YSBocmVmPSJtYWlsdG86cm9iZXJ0Lm1vb3JlQGludGVsLmNvbSIgdGFyZ2V0PSJf
YmxhbmsiPnJvYmVydC5tb29yZUBpbnRlbC5jb208L2E+Jmd0OyB3cm90ZTo8L3A+PGRpdj48ZGl2
PjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDExcHQ7IGNvbG9y
OiByZ2IoMzEsIDczLCAxMjUpOyI+RG8geW91IG1lYW4gdGhhdCB5b3Uga25vdyBob3cgdG8gc2Vu
ZCBhbiBpbnRlZ2VyIGFyZ3VtZW50LCBidXQgbm90IGEgYnVmZmVyIG9yIHBhY2thZ2U/PC9zcGFu
PjwvcD4KCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDExcHQ7
IGNvbG9yOiByZ2IoMzEsIDczLCAxMjUpOyI+oDwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1h
bCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTFwdDsgY29sb3I6IHJnYigzMSwgNzMsIDEyNSk7
Ij6gPC9zcGFuPjwvcD48ZGl2IHN0eWxlPSJib3JkZXItc3R5bGU6IG5vbmUgbm9uZSBub25lIHNv
bGlkOyBib3JkZXItY29sb3I6IC1tb3otdXNlLXRleHQtY29sb3IgLW1vei11c2UtdGV4dC1jb2xv
ciAtbW96LXVzZS10ZXh0LWNvbG9yIGJsdWU7IGJvcmRlci13aWR0aDogbWVkaXVtIG1lZGl1bSBt
ZWRpdW0gMS41cHQ7IHBhZGRpbmc6IDBpbiAwaW4gMGluIDRwdDsiPgoKPGRpdj48ZGl2IHN0eWxl
PSJib3JkZXItc3R5bGU6IHNvbGlkIG5vbmUgbm9uZTsgYm9yZGVyLWNvbG9yOiAtbW96LXVzZS10
ZXh0LWNvbG9yOyBib3JkZXItd2lkdGg6IDFwdCBtZWRpdW0gbWVkaXVtOyBwYWRkaW5nOiAzcHQg
MGluIDBpbjsiPjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6
IDEwcHQ7Ij5Gcm9tOjwvc3Bhbj48L2I+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsiPiA8
YSBocmVmPSJtYWlsdG86ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnIiB0YXJnZXQ9Il9ibGFuayI+
ZGV2ZWwtYm91bmNlc0BhY3BpY2Eub3JnPC9hPiBbbWFpbHRvOjxhIGhyZWY9Im1haWx0bzpkZXZl
bC1ib3VuY2VzQGFjcGljYS5vcmciIHRhcmdldD0iX2JsYW5rIj5kZXZlbC1ib3VuY2VzQGFjcGlj
YS5vcmc8L2E+XSA8Yj5PbiBCZWhhbGYgT2YgPC9iPmt0Y2tkPGJyPgoKPGI+U2VudDo8L2I+IFRo
dXJzZGF5LCBBcHJpbCAwNywgMjAxMSAxMTozNiBBTTxicj48Yj5Ubzo8L2I+IDxhIGhyZWY9Im1h
aWx0bzpkZXZlbEBhY3BpY2Eub3JnIiB0YXJnZXQ9Il9ibGFuayI+ZGV2ZWxAYWNwaWNhLm9yZzwv
YT48YnI+PGI+U3ViamVjdDo8L2I+IFtEZXZlbF0gQWNwaWV4ZWM8L3NwYW4+PC9wPjwvZGl2Pjwv
ZGl2PjxkaXY+PHAgY2xhc3M9Ik1zb05vcm1hbCI+oDwvcD4KCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PkhpLCA8YnI+PGJyPkkgYW0gdHJ5aW5nIHRvIGRlYnVnIG15IGFzbCBjb2RlIHVzaW5nIGFjcGll
eGVjIGFuZCBnb3Qgc3R1Y2sgYXQgYSBwbGFjZSB3aGVyZSBJIG5lZWQgdG8gc2VuZCBhIGJ1ZmZl
ci9wYWNrYWdlIGFzIGFyZ3VtZW50IHRvIG15IG1ldGhvZCAoZXhlY3V0ZSAmbHQ7bWV0aG9kJmd0
OyBbQXJndW1lbnRzXSkuIEkgdHJpZWQgc2VhcmNoaW5nIHRoZSBkb2N1bWVudGF0aW9uIGJ1dCBj
b3VsZG4mIzM5O3QgZmluZCBhbnkgaW5mb3JtYXRpb24uIENhbiBzb21lb25lIHBsZWFzZSBoZWxw
IG1lIHByb3ZpZGUgaW5mb3JtYXRpb24gb24gaG93IHRvIGRvIHRoaXM/PGJyPgoKPGJyPlRoYW5r
czwvcD48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48cCBjbGFzcz0iTXNvTm9ybWFsIj6g
PC9wPjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48YnI+
Cg==

--===============6843602914581222224==--

