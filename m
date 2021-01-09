Content-Type: multipart/mixed; boundary="===============4415446473420840866=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH 18/18] ipu3: Add driver for dummy INT3472 ACPI
 device
Date: Sat, 09 Jan 2021 09:17:54 +0000
Message-ID: <CAHp75Vcy878xKUUUDH5ory9uS-Vhhx_W1PZc=S6hsSLYJ0i60w@mail.gmail.com>
In-Reply-To: 360b3783-b0ff-bdb8-5bcf-ec88a554503f@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4415446473420840866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Saturday, January 9, 2021, Daniel Scally <djrscally(a)gmail.com> wrote:

> Hi Andy
>
> On 08/01/2021 12:17, Andy Shevchenko wrote:
> > On Fri, Jan 8, 2021 at 1:56 AM Daniel Scally <djrscally(a)gmail.com>
> wrote:
> >> On 30/11/2020 20:07, Andy Shevchenko wrote:
> >>> On Mon, Nov 30, 2020 at 01:31:29PM +0000, Daniel Scally wrote:
> > ...
> >
> >>> It's solely Windows driver design...
> >>> Luckily I found some information and can clarify above table:
> >>>
> >>> 0x00 Reset
> >>> 0x01 Power down
> >>> 0x0b Power enable
> >>> 0x0c Clock enable
> >>> 0x0d LED (active high)
> >>>
> >>> The above text perhaps should go somewhere under Documentation.
> >> Coming back to this; there's a bit of an anomaly with the 0x01 Power
> >> Down pin for at least one platform.  As listed above, the OV2680 on one
> >> of my platforms has 3 GPIOs defined, and the table above gives them as
> >> type Reset, Power down and Clock enable. I'd assumed from this table
> >> that "power down" meant a powerdown GPIO (I.E. the one usually called
> >> PWDNB in Omnivision datasheets and "powerdown" in drivers), but the
> >> datasheet for the OV2680 doesn't list a separate reset and powerdown
> >> pin, but rather a single pin that performs both functions.
> > All of them are GPIOs, the question here is how they are actually
> > connected on PCB level and I have no answer to that. You have to find
> > schematics somewhere.
>
> Yeah; I've been trying to get those but so far, no dice.
>
>
Can you share the exact name / model of the hardware in question here? I
would try to search for the schematics.



> >
> >> Am I wrong to treat that as something that ought to be mapped as a
> >> powerdown GPIO to the sensors? Or do you know of any other way to
> >> reconcile that discrepancy?
> > The GPIOs can go directly to the sensors or be a control pin for
> > separate discrete power gates.
> > So, we can do one of the following:
> >  a) present PD GPIO as fixed regulator;
> >  b) present PD & Reset GPIOs as regulator;
> >  c) provide them as is to the sensor and sensor driver must do what it
> > considers right.
> >
> > Since we don't have schematics (yet?) and we have plenty of variations
> > of sensors, I would go to c) and update the driver of the affected
> > sensor as needed. Because even if you have separate discrete PD for
> > one sensor on one platform there is no guarantee that it will be the
> > same on another. Providing a "virtual" PD in a sensor that doesn't
> > support it is the best choice I think. Let's hear what Sakari and
> > other experienced camera sensor developers say.
> >
> > My vision is purely based on electrical engineering background,
> > experience with existing (not exactly camera) sensor drivers and
> > generic cases.
>
> Alright; thanks. I'm happy with C being the answer, so unless someone
> thinks differently I'll work on that basis.
>
>
Laurent answered that it is not the best choice from camera sensor driver
perspective.



> >> Failing that; the only way I can think to handle this is to register
> >> proxy GPIO pins assigned to the sensors as you suggested previously, a=
nd
> >> have them toggle the GPIO's assigned to the INT3472 based on platform
> >> specific mapping data (I.E. we register a pin called "reset", which on
> >> most platforms just toggles the 0x00 pin, but on this specific platform
> >> would drive both 0x00 and 0x01 together. We're already heading that way
> >> for the regulator consumer supplies so it's sort of nothing new, but I=
'd
> >> still rather not if it can be avoided.
> >
>


-- =

With Best Regards,
Andy Shevchenko

--===============4415446473420840866==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGJyPjxicj5PbiBTYXR1cmRheSwgSmFudWFyeSA5LCAyMDIxLCBEYW5pZWwgU2NhbGx5ICZsdDs8
YSBocmVmPSJtYWlsdG86ZGpyc2NhbGx5QGdtYWlsLmNvbSI+ZGpyc2NhbGx5QGdtYWlsLmNvbTwv
YT4mZ3Q7IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4Ij5IaSBBbmR5PGJyPgo8YnI+Ck9uIDA4LzAxLzIwMjEgMTI6MTcsIEFuZHkgU2hldmNoZW5r
byB3cm90ZTo8YnI+CiZndDsgT24gRnJpLCBKYW4gOCwgMjAyMSBhdCAxOjU2IEFNIERhbmllbCBT
Y2FsbHkgJmx0OzxhIGhyZWY9Im1haWx0bzpkanJzY2FsbHlAZ21haWwuY29tIj5kanJzY2FsbHlA
Z21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPgomZ3Q7Jmd0OyBPbiAzMC8xMS8yMDIwIDIwOjA3
LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6PGJyPgomZ3Q7Jmd0OyZndDsgT24gTW9uLCBOb3YgMzAs
IDIwMjAgYXQgMDE6MzE6MjlQTSArMDAwMCwgRGFuaWVsIFNjYWxseSB3cm90ZTo8YnI+CiZndDsg
Li4uPGJyPgomZ3Q7PGJyPgomZ3Q7Jmd0OyZndDsgSXQmIzM5O3Mgc29sZWx5IFdpbmRvd3MgZHJp
dmVyIGRlc2lnbi4uLjxicj4KJmd0OyZndDsmZ3Q7IEx1Y2tpbHkgSSBmb3VuZCBzb21lIGluZm9y
bWF0aW9uIGFuZCBjYW4gY2xhcmlmeSBhYm92ZSB0YWJsZTo8YnI+CiZndDsmZ3Q7Jmd0Ozxicj4K
Jmd0OyZndDsmZ3Q7IDB4MDAgUmVzZXQ8YnI+CiZndDsmZ3Q7Jmd0OyAweDAxIFBvd2VyIGRvd248
YnI+CiZndDsmZ3Q7Jmd0OyAweDBiIFBvd2VyIGVuYWJsZTxicj4KJmd0OyZndDsmZ3Q7IDB4MGMg
Q2xvY2sgZW5hYmxlPGJyPgomZ3Q7Jmd0OyZndDsgMHgwZCBMRUQgKGFjdGl2ZSBoaWdoKTxicj4K
Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7Jmd0OyZndDsgVGhlIGFib3ZlIHRleHQgcGVyaGFwcyBzaG91
bGQgZ28gc29tZXdoZXJlIHVuZGVyIERvY3VtZW50YXRpb24uPGJyPgomZ3Q7Jmd0OyBDb21pbmcg
YmFjayB0byB0aGlzOyB0aGVyZSYjMzk7cyBhIGJpdCBvZiBhbiBhbm9tYWx5IHdpdGggdGhlIDB4
MDEgUG93ZXI8YnI+CiZndDsmZ3Q7IERvd24gcGluIGZvciBhdCBsZWFzdCBvbmUgcGxhdGZvcm0u
wqAgQXMgbGlzdGVkIGFib3ZlLCB0aGUgT1YyNjgwIG9uIG9uZTxicj4KJmd0OyZndDsgb2YgbXkg
cGxhdGZvcm1zIGhhcyAzIEdQSU9zIGRlZmluZWQsIGFuZCB0aGUgdGFibGUgYWJvdmUgZ2l2ZXMg
dGhlbSBhczxicj4KJmd0OyZndDsgdHlwZSBSZXNldCwgUG93ZXIgZG93biBhbmQgQ2xvY2sgZW5h
YmxlLiBJJiMzOTtkIGFzc3VtZWQgZnJvbSB0aGlzIHRhYmxlPGJyPgomZ3Q7Jmd0OyB0aGF0ICZx
dW90O3Bvd2VyIGRvd24mcXVvdDsgbWVhbnQgYSBwb3dlcmRvd24gR1BJTyAoSS5FLiB0aGUgb25l
IHVzdWFsbHkgY2FsbGVkPGJyPgomZ3Q7Jmd0OyBQV0ROQiBpbiBPbW5pdmlzaW9uIGRhdGFzaGVl
dHMgYW5kICZxdW90O3Bvd2VyZG93biZxdW90OyBpbiBkcml2ZXJzKSwgYnV0IHRoZTxicj4KJmd0
OyZndDsgZGF0YXNoZWV0IGZvciB0aGUgT1YyNjgwIGRvZXNuJiMzOTt0IGxpc3QgYSBzZXBhcmF0
ZSByZXNldCBhbmQgcG93ZXJkb3duPGJyPgomZ3Q7Jmd0OyBwaW4sIGJ1dCByYXRoZXIgYSBzaW5n
bGUgcGluIHRoYXQgcGVyZm9ybXMgYm90aCBmdW5jdGlvbnMuPGJyPgomZ3Q7IEFsbCBvZiB0aGVt
IGFyZSBHUElPcywgdGhlIHF1ZXN0aW9uIGhlcmUgaXMgaG93IHRoZXkgYXJlIGFjdHVhbGx5PGJy
PgomZ3Q7IGNvbm5lY3RlZCBvbiBQQ0IgbGV2ZWwgYW5kIEkgaGF2ZSBubyBhbnN3ZXIgdG8gdGhh
dC4gWW91IGhhdmUgdG8gZmluZDxicj4KJmd0OyBzY2hlbWF0aWNzIHNvbWV3aGVyZS48YnI+Cjxi
cj4KWWVhaDsgSSYjMzk7dmUgYmVlbiB0cnlpbmcgdG8gZ2V0IHRob3NlIGJ1dCBzbyBmYXIsIG5v
IGRpY2UuPGJyPgo8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+Q2FuIHlvdSBz
aGFyZSB0aGUgZXhhY3QgbmFtZSAvIG1vZGVsIG9mIHRoZSBoYXJkd2FyZSBpbiBxdWVzdGlvbiBo
ZXJlPyBJIHdvdWxkIHRyeSB0byBzZWFyY2ggZm9yIHRoZSBzY2hlbWF0aWNzLjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0
eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5n
LWxlZnQ6MWV4Ij4KJmd0Ozxicj4KJmd0OyZndDsgQW0gSSB3cm9uZyB0byB0cmVhdCB0aGF0IGFz
IHNvbWV0aGluZyB0aGF0IG91Z2h0IHRvIGJlIG1hcHBlZCBhcyBhPGJyPgomZ3Q7Jmd0OyBwb3dl
cmRvd24gR1BJTyB0byB0aGUgc2Vuc29ycz8gT3IgZG8geW91IGtub3cgb2YgYW55IG90aGVyIHdh
eSB0bzxicj4KJmd0OyZndDsgcmVjb25jaWxlIHRoYXQgZGlzY3JlcGFuY3k/PGJyPgomZ3Q7IFRo
ZSBHUElPcyBjYW4gZ28gZGlyZWN0bHkgdG8gdGhlIHNlbnNvcnMgb3IgYmUgYSBjb250cm9sIHBp
biBmb3I8YnI+CiZndDsgc2VwYXJhdGUgZGlzY3JldGUgcG93ZXIgZ2F0ZXMuPGJyPgomZ3Q7IFNv
LCB3ZSBjYW4gZG8gb25lIG9mIHRoZSBmb2xsb3dpbmc6PGJyPgomZ3Q7wqAgYSkgcHJlc2VudCBQ
RCBHUElPIGFzIGZpeGVkIHJlZ3VsYXRvcjs8YnI+CiZndDvCoCBiKSBwcmVzZW50IFBEICZhbXA7
IFJlc2V0IEdQSU9zIGFzIHJlZ3VsYXRvcjs8YnI+CiZndDvCoCBjKSBwcm92aWRlIHRoZW0gYXMg
aXMgdG8gdGhlIHNlbnNvciBhbmQgc2Vuc29yIGRyaXZlciBtdXN0IGRvIHdoYXQgaXQ8YnI+CiZn
dDsgY29uc2lkZXJzIHJpZ2h0Ljxicj4KJmd0Ozxicj4KJmd0OyBTaW5jZSB3ZSBkb24mIzM5O3Qg
aGF2ZSBzY2hlbWF0aWNzICh5ZXQ/KSBhbmQgd2UgaGF2ZSBwbGVudHkgb2YgdmFyaWF0aW9uczxi
cj4KJmd0OyBvZiBzZW5zb3JzLCBJIHdvdWxkIGdvIHRvIGMpIGFuZCB1cGRhdGUgdGhlIGRyaXZl
ciBvZiB0aGUgYWZmZWN0ZWQ8YnI+CiZndDsgc2Vuc29yIGFzIG5lZWRlZC4gQmVjYXVzZSBldmVu
IGlmIHlvdSBoYXZlIHNlcGFyYXRlIGRpc2NyZXRlIFBEIGZvcjxicj4KJmd0OyBvbmUgc2Vuc29y
IG9uIG9uZSBwbGF0Zm9ybSB0aGVyZSBpcyBubyBndWFyYW50ZWUgdGhhdCBpdCB3aWxsIGJlIHRo
ZTxicj4KJmd0OyBzYW1lIG9uIGFub3RoZXIuIFByb3ZpZGluZyBhICZxdW90O3ZpcnR1YWwmcXVv
dDsgUEQgaW4gYSBzZW5zb3IgdGhhdCBkb2VzbiYjMzk7dDxicj4KJmd0OyBzdXBwb3J0IGl0IGlz
IHRoZSBiZXN0IGNob2ljZSBJIHRoaW5rLiBMZXQmIzM5O3MgaGVhciB3aGF0IFNha2FyaSBhbmQ8
YnI+CiZndDsgb3RoZXIgZXhwZXJpZW5jZWQgY2FtZXJhIHNlbnNvciBkZXZlbG9wZXJzIHNheS48
YnI+CiZndDs8YnI+CiZndDsgTXkgdmlzaW9uIGlzIHB1cmVseSBiYXNlZCBvbiBlbGVjdHJpY2Fs
IGVuZ2luZWVyaW5nIGJhY2tncm91bmQsPGJyPgomZ3Q7IGV4cGVyaWVuY2Ugd2l0aCBleGlzdGlu
ZyAobm90IGV4YWN0bHkgY2FtZXJhKSBzZW5zb3IgZHJpdmVycyBhbmQ8YnI+CiZndDsgZ2VuZXJp
YyBjYXNlcy48YnI+Cjxicj4KQWxyaWdodDsgdGhhbmtzLiBJJiMzOTttIGhhcHB5IHdpdGggQyBi
ZWluZyB0aGUgYW5zd2VyLCBzbyB1bmxlc3Mgc29tZW9uZTxicj4KdGhpbmtzIGRpZmZlcmVudGx5
IEkmIzM5O2xsIHdvcmsgb24gdGhhdCBiYXNpcy48YnI+Cjxicj48L2Jsb2NrcXVvdGU+PGRpdj48
YnI+PC9kaXY+PGRpdj5MYXVyZW50IGFuc3dlcmVkIHRoYXQgaXQgaXMgbm90IHRoZSBiZXN0IGNo
b2ljZSBmcm9tIGNhbWVyYSBzZW5zb3IgZHJpdmVyIHBlcnNwZWN0aXZlLjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxl
PSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxl
ZnQ6MWV4Ij4KJmd0OyZndDsgRmFpbGluZyB0aGF0OyB0aGUgb25seSB3YXkgSSBjYW4gdGhpbmsg
dG8gaGFuZGxlIHRoaXMgaXMgdG8gcmVnaXN0ZXI8YnI+CiZndDsmZ3Q7IHByb3h5IEdQSU8gcGlu
cyBhc3NpZ25lZCB0byB0aGUgc2Vuc29ycyBhcyB5b3Ugc3VnZ2VzdGVkIHByZXZpb3VzbHksIGFu
ZDxicj4KJmd0OyZndDsgaGF2ZSB0aGVtIHRvZ2dsZSB0aGUgR1BJTyYjMzk7cyBhc3NpZ25lZCB0
byB0aGUgSU5UMzQ3MiBiYXNlZCBvbiBwbGF0Zm9ybTxicj4KJmd0OyZndDsgc3BlY2lmaWMgbWFw
cGluZyBkYXRhIChJLkUuIHdlIHJlZ2lzdGVyIGEgcGluIGNhbGxlZCAmcXVvdDtyZXNldCZxdW90
Oywgd2hpY2ggb248YnI+CiZndDsmZ3Q7IG1vc3QgcGxhdGZvcm1zIGp1c3QgdG9nZ2xlcyB0aGUg
MHgwMCBwaW4sIGJ1dCBvbiB0aGlzIHNwZWNpZmljIHBsYXRmb3JtPGJyPgomZ3Q7Jmd0OyB3b3Vs
ZCBkcml2ZSBib3RoIDB4MDAgYW5kIDB4MDEgdG9nZXRoZXIuIFdlJiMzOTtyZSBhbHJlYWR5IGhl
YWRpbmcgdGhhdCB3YXk8YnI+CiZndDsmZ3Q7IGZvciB0aGUgcmVndWxhdG9yIGNvbnN1bWVyIHN1
cHBsaWVzIHNvIGl0JiMzOTtzIHNvcnQgb2Ygbm90aGluZyBuZXcsIGJ1dCBJJiMzOTtkPGJyPgom
Z3Q7Jmd0OyBzdGlsbCByYXRoZXIgbm90IGlmIGl0IGNhbiBiZSBhdm9pZGVkLjxicj4KJmd0Ozxi
cj4KPC9ibG9ja3F1b3RlPjxicj48YnI+LS0gPGJyPldpdGggQmVzdCBSZWdhcmRzLDxicj5BbmR5
IFNoZXZjaGVua288YnI+PGJyPjxicj4K

--===============4415446473420840866==--

