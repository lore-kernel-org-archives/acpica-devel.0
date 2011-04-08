Content-Type: multipart/mixed; boundary="===============0249560028993716900=="
MIME-Version: 1.0
From: ktckd <ktckd9 at gmail.com>
Subject: Re: [Devel] Acpiexec
Date: Fri, 08 Apr 2011 10:15:00 -0500
Message-ID: <BANLkTikrW=BfkYJ4R5Me-WxLQ=+Qixe6NA@mail.gmail.com>
In-Reply-To: 4911F71203A09E4D9981D27F9D830858D3E4E08F@orsmsx503.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0249560028993716900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Oh ok, so there is no other way to debug my code in this case?

Thanks

On Thu, Apr 7, 2011 at 4:39 PM, Moore, Robert <robert.moore(a)intel.com>wro=
te:

> Ok. From AcpiExec command line, only integers and strings are supported as
> arguments to methods.
>
>
>
>
>
> *From:* ktckd [mailto:ktckd9(a)gmail.com]
> *Sent:* Thursday, April 07, 2011 2:26 PM
>
> *To:* Moore, Robert
> *Cc:* devel(a)acpica.org
> *Subject:* Re: [Devel] Acpiexec
>
>
>
> Hi Robert,
>
> Thanks for the reply. I actually did come across this section before. But=
 I
> guess I am not following it correctly or may be I am not clear.
>
> Below is my asl code:
> DefinitionBlock ("dsdt.aml", "DSDT", 2, "Intel", "Template", 0x00000001)
> {
>     Method (MAIN, 2, NotSerialized)
>     {
>         Store (__FILE__, Debug)
>         Store (__LINE__, Debug)
>         Store (__DATE__, Debug)
>         Store (Arg0,Debug)
>         Store (DerefOf(Index(Arg1,0)),Local0)
>         Store (Local0,Debug)
>
>         Return (Package(4){
>            0x08,
>            0x40,
>            0x01,
>            0x00
>         })
>     }
>
>     Method (TEST, 2, NotSerialized)
>     {
>         Store (Arg0,Debug)
>         Store (Arg1,Debug)
>     }
> }
>
> I compiled the above code (iasl dsdt.asl) and started debugging it using
> the acpiexec (acpiexec -v dsdt.aml). However, when I try 'execute main 1 =
1'
> I keep getting the below error message:
> Needed [Buffer/String/Package], found [Integer] 004B7F98
>
> I  understand that we need to follow a specific format while passing
> package/string/buffer arguments in the above scenario. I tried to play
> around various formats (e.g. execute main 1, buffer(){0x01,0x02}) but none
> of them worked.
>
> Can you please provide some more insight into this?
>
> Thanks
>
> On Thu, Apr 7, 2011 at 3:51 PM, Moore, Robert <robert.moore(a)intel.com>
> wrote:
>
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
>
>

--===============0249560028993716900==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

T2ggb2ssIHNvIHRoZXJlIGlzIG5vIG90aGVyIHdheSB0byBkZWJ1ZyBteSBjb2RlIGluIHRoaXMg
Y2FzZT88YnI+PGJyPlRoYW5rczxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIFRo
dSwgQXByIDcsIDIwMTEgYXQgNDozOSBQTSwgTW9vcmUsIFJvYmVydCA8c3BhbiBkaXI9Imx0ciI+
Jmx0OzxhIGhyZWY9Im1haWx0bzpyb2JlcnQubW9vcmVAaW50ZWwuY29tIj5yb2JlcnQubW9vcmVA
aW50ZWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj4KCjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9ImJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAy
MDQpOyBtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBwYWRkaW5nLWxlZnQ6IDFleDsiPjxkaXYg
bGluaz0iYmx1ZSIgdmxpbms9InB1cnBsZSIgbGFuZz0iRU4tVVMiPjxkaXY+PHAgY2xhc3M9Ik1z
b05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTFwdDsgY29sb3I6IHJnYigzMSwgNzMs
IDEyNSk7Ij5Pay4gRnJvbSBBY3BpRXhlYyBjb21tYW5kIGxpbmUsIG9ubHkgaW50ZWdlcnMgYW5k
IHN0cmluZ3MgYXJlIHN1cHBvcnRlZCBhcyBhcmd1bWVudHMgdG8gbWV0aG9kcy48L3NwYW4+PC9w
PgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTFwdDsgY29s
b3I6IHJnYigzMSwgNzMsIDEyNSk7Ij6gPC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIj48
c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMXB0OyBjb2xvcjogcmdiKDMxLCA3MywgMTI1KTsiPqA8
L3NwYW4+PC9wPjxkaXYgc3R5bGU9ImJvcmRlci1zdHlsZTogbm9uZSBub25lIG5vbmUgc29saWQ7
IGJvcmRlci1jb2xvcjogLW1vei11c2UtdGV4dC1jb2xvciAtbW96LXVzZS10ZXh0LWNvbG9yIC1t
b3otdXNlLXRleHQtY29sb3IgYmx1ZTsgYm9yZGVyLXdpZHRoOiBtZWRpdW0gbWVkaXVtIG1lZGl1
bSAxLjVwdDsgcGFkZGluZzogMGluIDBpbiAwaW4gNHB0OyI+Cgo8ZGl2PjxkaXYgc3R5bGU9ImJv
cmRlci1zdHlsZTogc29saWQgbm9uZSBub25lOyBib3JkZXItY29sb3I6IHJnYigxODEsIDE5Niwg
MjIzKSAtbW96LXVzZS10ZXh0LWNvbG9yIC1tb3otdXNlLXRleHQtY29sb3I7IGJvcmRlci13aWR0
aDogMXB0IG1lZGl1bSBtZWRpdW07IHBhZGRpbmc6IDNwdCAwaW4gMGluOyI+PHAgY2xhc3M9Ik1z
b05vcm1hbCI+PGI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsiPkZyb206PC9zcGFuPjwv
Yj48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyI+IGt0Y2tkIFttYWlsdG86PGEgaHJlZj0i
bWFpbHRvOmt0Y2tkOUBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5rdGNrZDlAZ21haWwuY29t
PC9hPl0gPGJyPgoKPGI+U2VudDo8L2I+IFRodXJzZGF5LCBBcHJpbCAwNywgMjAxMSAyOjI2IFBN
PGRpdj48ZGl2PjwvZGl2PjxkaXYgY2xhc3M9Img1Ij48YnI+PGI+VG86PC9iPiBNb29yZSwgUm9i
ZXJ0PGJyPjxiPkNjOjwvYj4gPGEgaHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmciIHRhcmdl
dD0iX2JsYW5rIj5kZXZlbEBhY3BpY2Eub3JnPC9hPjxicj48Yj5TdWJqZWN0OjwvYj4gUmU6IFtE
ZXZlbF0gQWNwaWV4ZWM8L2Rpdj4KCjwvZGl2Pjwvc3Bhbj48L3A+PC9kaXY+PC9kaXY+PGRpdj48
ZGl2PjwvZGl2PjxkaXYgY2xhc3M9Img1Ij48cCBjbGFzcz0iTXNvTm9ybWFsIj6gPC9wPjxwIGNs
YXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtYXJnaW4tYm90dG9tOiAxMnB0OyI+SGkgUm9iZXJ0LCA8
YnI+PGJyPlRoYW5rcyBmb3IgdGhlIHJlcGx5LiBJIGFjdHVhbGx5IGRpZCBjb21lIGFjcm9zcyB0
aGlzIHNlY3Rpb24gYmVmb3JlLiBCdXQgSSBndWVzcyBJIGFtIG5vdCBmb2xsb3dpbmcgaXQgY29y
cmVjdGx5IG9yIG1heSBiZSBJIGFtIG5vdCBjbGVhci4gPGJyPgoKPGJyPkJlbG93IGlzIG15IGFz
bCBjb2RlOjxicj5EZWZpbml0aW9uQmxvY2sgKCZxdW90O2RzZHQuYW1sJnF1b3Q7LCAmcXVvdDtE
U0RUJnF1b3Q7LCAyLCAmcXVvdDtJbnRlbCZxdW90OywgJnF1b3Q7VGVtcGxhdGUmcXVvdDssIDB4
MDAwMDAwMDEpPGJyPns8YnI+oKCgIE1ldGhvZCAoTUFJTiwgMiwgTm90U2VyaWFsaXplZCk8YnI+
oKCgIHs8YnI+oKCgoKCgoCBTdG9yZSAoX19GSUxFX18sIERlYnVnKTxicj4KCqCgoKCgoKAgU3Rv
cmUgKF9fTElORV9fLCBEZWJ1Zyk8YnI+oKCgoKCgoCBTdG9yZSAoX19EQVRFX18sIERlYnVnKTxi
cj6goKCgoKCgIFN0b3JlIChBcmcwLERlYnVnKTxicj6goKCgoKCgIFN0b3JlIChEZXJlZk9mKElu
ZGV4KEFyZzEsMCkpLExvY2FsMCk8YnI+oKCgoKCgoCBTdG9yZSAoTG9jYWwwLERlYnVnKTxicj6g
oKCgoKCgIDxicj6goKCgoKCgIFJldHVybiAoUGFja2FnZSg0KXs8YnI+CgqgoKCgoKCgoKCgIDB4
MDgsPGJyPqCgoKCgoKCgoKAgMHg0MCw8YnI+oKCgoKCgoKCgoCAweDAxLDxicj6goKCgoKCgoKCg
IDB4MDA8YnI+oKCgoKCgoCB9KTxicj6goKAgfTxicj48YnI+oKCgIE1ldGhvZCAoVEVTVCwgMiwg
Tm90U2VyaWFsaXplZCk8YnI+oKCgIHs8YnI+oKCgoKCgoCBTdG9yZSAoQXJnMCxEZWJ1Zyk8YnI+
oKCgoKCgoCBTdG9yZSAoQXJnMSxEZWJ1Zyk8YnI+oKCgIH08YnI+Cgp9PGJyPjxicj5JIGNvbXBp
bGVkIHRoZSBhYm92ZSBjb2RlIChpYXNsIGRzZHQuYXNsKSBhbmQgc3RhcnRlZCBkZWJ1Z2dpbmcg
aXQgdXNpbmcgdGhlIGFjcGlleGVjIChhY3BpZXhlYyAtdiBkc2R0LmFtbCkuIEhvd2V2ZXIsIHdo
ZW4gSSB0cnkgJiMzOTtleGVjdXRlIG1haW4gMSAxJiMzOTsgSSBrZWVwIGdldHRpbmcgdGhlIGJl
bG93IGVycm9yIG1lc3NhZ2U6PGJyPk5lZWRlZCBbQnVmZmVyL1N0cmluZy9QYWNrYWdlXSwgZm91
bmQgW0ludGVnZXJdIDAwNEI3Rjk4PGJyPgoKPGJyPkmgIHVuZGVyc3RhbmQgdGhhdCB3ZSBuZWVk
IHRvIGZvbGxvdyBhIHNwZWNpZmljIGZvcm1hdCB3aGlsZSBwYXNzaW5nIHBhY2thZ2Uvc3RyaW5n
L2J1ZmZlciBhcmd1bWVudHMgaW4gdGhlIGFib3ZlIHNjZW5hcmlvLiBJIHRyaWVkIHRvIHBsYXkg
YXJvdW5kIHZhcmlvdXMgZm9ybWF0cyAoZS5nLiBleGVjdXRlIG1haW4gMSwgYnVmZmVyKCl7MHgw
MSwweDAyfSkgYnV0IG5vbmUgb2YgdGhlbSB3b3JrZWQuIDxicj4KCjxicj5DYW4geW91IHBsZWFz
ZSBwcm92aWRlIHNvbWUgbW9yZSBpbnNpZ2h0IGludG8gdGhpcz88YnI+PGJyPlRoYW5rczxicj48
YnI+PC9wPjxkaXY+PHAgY2xhc3M9Ik1zb05vcm1hbCI+T24gVGh1LCBBcHIgNywgMjAxMSBhdCAz
OjUxIFBNLCBNb29yZSwgUm9iZXJ0ICZsdDs8YSBocmVmPSJtYWlsdG86cm9iZXJ0Lm1vb3JlQGlu
dGVsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnJvYmVydC5tb29yZUBpbnRlbC5jb208L2E+Jmd0OyB3
cm90ZTo8L3A+Cgo8ZGl2PjxkaXY+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZv
bnQtc2l6ZTogMTFwdDsgY29sb3I6IHJnYigzMSwgNzMsIDEyNSk7Ij6gPC9zcGFuPjwvcD48cD48
c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMXB0OyBjb2xvcjogcmdiKDMxLCA3MywgMTI1KTsiPklu
IHRoZSA8L3NwYW4+QUNQSSBDb21wb25lbnQgQXJjaGl0ZWN0dXJlIFVzZXIgR3VpZGUgYW5kIFBy
b2dyYW1tZXIgUmVmZXJlbmNlLCBSZXZpc2lvbiA0LjA4LDwvcD4KCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDExcHQ7IGNvbG9yOiByZ2IoMzEsIDczLCAxMjUp
OyI+oDwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6
ZTogMTFwdDsgY29sb3I6IHJnYigzMSwgNzMsIDEyNSk7Ij5TZWUgc2VjdGlvbiA2LjIuMTAgk0FD
UElfT0JKRUNUIJYgTWV0aG9kIFBhcmFtZXRlcnMgYW5kIFJldHVybiBPYmplY3RzPC9zcGFuPjwv
cD4KCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDExcHQ7IGNv
bG9yOiByZ2IoMzEsIDczLCAxMjUpOyI+oDwvc3Bhbj48L3A+PGRpdiBzdHlsZT0iYm9yZGVyLXN0
eWxlOiBub25lIG5vbmUgbm9uZSBzb2xpZDsgYm9yZGVyLWNvbG9yOiAtbW96LXVzZS10ZXh0LWNv
bG9yIC1tb3otdXNlLXRleHQtY29sb3IgLW1vei11c2UtdGV4dC1jb2xvciBibHVlOyBib3JkZXIt
d2lkdGg6IG1lZGl1bSBtZWRpdW0gbWVkaXVtIDEuNXB0OyBwYWRkaW5nOiAwaW4gMGluIDBpbiA0
cHQ7Ij4KCjxkaXY+PGRpdiBzdHlsZT0iYm9yZGVyLXN0eWxlOiBzb2xpZCBub25lIG5vbmU7IGJv
cmRlci1jb2xvcjogLW1vei11c2UtdGV4dC1jb2xvcjsgYm9yZGVyLXdpZHRoOiAxcHQgbWVkaXVt
IG1lZGl1bTsgcGFkZGluZzogM3B0IDBpbiAwaW47Ij48cCBjbGFzcz0iTXNvTm9ybWFsIj48Yj48
c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyI+RnJvbTo8L3NwYW4+PC9iPjxzcGFuIHN0eWxl
PSJmb250LXNpemU6IDEwcHQ7Ij4ga3Rja2QgW21haWx0bzo8YSBocmVmPSJtYWlsdG86a3Rja2Q5
QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmt0Y2tkOUBnbWFpbC5jb208L2E+XSA8YnI+Cgo8
Yj5TZW50OjwvYj4gVGh1cnNkYXksIEFwcmlsIDA3LCAyMDExIDE6MTYgUE08YnI+PGI+VG86PC9i
PiBNb29yZSwgUm9iZXJ0PGJyPjxiPkNjOjwvYj4gPGEgaHJlZj0ibWFpbHRvOmRldmVsQGFjcGlj
YS5vcmciIHRhcmdldD0iX2JsYW5rIj5kZXZlbEBhY3BpY2Eub3JnPC9hPjxicj48Yj5TdWJqZWN0
OjwvYj4gUmU6IFtEZXZlbF0gQWNwaWV4ZWM8L3NwYW4+PC9wPjwvZGl2PjwvZGl2PgoKPGRpdj48
ZGl2PjxwIGNsYXNzPSJNc29Ob3JtYWwiPqA8L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9
Im1hcmdpbi1ib3R0b206IDEycHQ7Ij5UaGF0IGlzIGNvcnJlY3QuIEkgY2FuIHNlbmQgaW50ZWdl
ciBhcmd1bWVudHMgKGUuZy4gZXhlY3V0ZSBtYWluIDEgMSkgQnV0IGhhdmUgbm8gaWRlYSBob3cg
dG8gc2VuZCBhIGJ1ZmZlci9wYWNrYWdlIG9yIHN0cmluZyBhcyBhcmd1bWVudC4gPC9wPgoKPGRp
dj48cCBjbGFzcz0iTXNvTm9ybWFsIj5PbiBUaHUsIEFwciA3LCAyMDExIGF0IDM6MDkgUE0sIE1v
b3JlLCBSb2JlcnQgJmx0OzxhIGhyZWY9Im1haWx0bzpyb2JlcnQubW9vcmVAaW50ZWwuY29tIiB0
YXJnZXQ9Il9ibGFuayI+cm9iZXJ0Lm1vb3JlQGludGVsLmNvbTwvYT4mZ3Q7IHdyb3RlOjwvcD48
ZGl2PjxkaXY+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTFw
dDsgY29sb3I6IHJnYigzMSwgNzMsIDEyNSk7Ij5EbyB5b3UgbWVhbiB0aGF0IHlvdSBrbm93IGhv
dyB0byBzZW5kIGFuIGludGVnZXIgYXJndW1lbnQsIGJ1dCBub3QgYSBidWZmZXIgb3IgcGFja2Fn
ZT88L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6
ZTogMTFwdDsgY29sb3I6IHJnYigzMSwgNzMsIDEyNSk7Ij6gPC9zcGFuPjwvcD48cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMXB0OyBjb2xvcjogcmdiKDMxLCA3
MywgMTI1KTsiPqA8L3NwYW4+PC9wPjxkaXYgc3R5bGU9ImJvcmRlci1zdHlsZTogbm9uZSBub25l
IG5vbmUgc29saWQ7IGJvcmRlci1jb2xvcjogLW1vei11c2UtdGV4dC1jb2xvciAtbW96LXVzZS10
ZXh0LWNvbG9yIC1tb3otdXNlLXRleHQtY29sb3IgYmx1ZTsgYm9yZGVyLXdpZHRoOiBtZWRpdW0g
bWVkaXVtIG1lZGl1bSAxLjVwdDsgcGFkZGluZzogMGluIDBpbiAwaW4gNHB0OyI+Cgo8ZGl2Pjxk
aXYgc3R5bGU9ImJvcmRlci1zdHlsZTogc29saWQgbm9uZSBub25lOyBib3JkZXItY29sb3I6IC1t
b3otdXNlLXRleHQtY29sb3I7IGJvcmRlci13aWR0aDogMXB0IG1lZGl1bSBtZWRpdW07IHBhZGRp
bmc6IDNwdCAwaW4gMGluOyI+PHAgY2xhc3M9Ik1zb05vcm1hbCI+PGI+PHNwYW4gc3R5bGU9ImZv
bnQtc2l6ZTogMTBwdDsiPkZyb206PC9zcGFuPjwvYj48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAx
MHB0OyI+IDxhIGhyZWY9Im1haWx0bzpkZXZlbC1ib3VuY2VzQGFjcGljYS5vcmciIHRhcmdldD0i
X2JsYW5rIj5kZXZlbC1ib3VuY2VzQGFjcGljYS5vcmc8L2E+IFttYWlsdG86PGEgaHJlZj0ibWFp
bHRvOmRldmVsLWJvdW5jZXNAYWNwaWNhLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmRldmVsLWJvdW5j
ZXNAYWNwaWNhLm9yZzwvYT5dIDxiPk9uIEJlaGFsZiBPZiA8L2I+a3Rja2Q8YnI+Cgo8Yj5TZW50
OjwvYj4gVGh1cnNkYXksIEFwcmlsIDA3LCAyMDExIDExOjM2IEFNPGJyPjxiPlRvOjwvYj4gPGEg
aHJlZj0ibWFpbHRvOmRldmVsQGFjcGljYS5vcmciIHRhcmdldD0iX2JsYW5rIj5kZXZlbEBhY3Bp
Y2Eub3JnPC9hPjxicj48Yj5TdWJqZWN0OjwvYj4gW0RldmVsXSBBY3BpZXhlYzwvc3Bhbj48L3A+
PC9kaXY+PC9kaXY+PGRpdj48cCBjbGFzcz0iTXNvTm9ybWFsIj6gPC9wPgoKPHAgY2xhc3M9Ik1z
b05vcm1hbCI+SGksIDxicj48YnI+SSBhbSB0cnlpbmcgdG8gZGVidWcgbXkgYXNsIGNvZGUgdXNp
bmcgYWNwaWV4ZWMgYW5kIGdvdCBzdHVjayBhdCBhIHBsYWNlIHdoZXJlIEkgbmVlZCB0byBzZW5k
IGEgYnVmZmVyL3BhY2thZ2UgYXMgYXJndW1lbnQgdG8gbXkgbWV0aG9kIChleGVjdXRlICZsdDtt
ZXRob2QmZ3Q7IFtBcmd1bWVudHNdKS4gSSB0cmllZCBzZWFyY2hpbmcgdGhlIGRvY3VtZW50YXRp
b24gYnV0IGNvdWxkbiYjMzk7dCBmaW5kIGFueSBpbmZvcm1hdGlvbi4gQ2FuIHNvbWVvbmUgcGxl
YXNlIGhlbHAgbWUgcHJvdmlkZSBpbmZvcm1hdGlvbiBvbiBob3cgdG8gZG8gdGhpcz88YnI+Cgo8
YnI+VGhhbmtzPC9wPjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjxwIGNsYXNzPSJNc29O
b3JtYWwiPqA8L3A+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PHAgY2xhc3M9
Ik1zb05vcm1hbCI+oDwvcD48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVv
dGU+PC9kaXY+PGJyPgo=

--===============0249560028993716900==--

