Content-Type: multipart/mixed; boundary="===============1992656721661975058=="
MIME-Version: 1.0
From: Devin Steffler <devinsteffler at gmail.com>
Subject: [Devel] Re: Wake On LAN steps for QNX from S5
Date: Thu, 15 Oct 2020 07:30:59 -0400
Message-ID: <CAAuRk_g7GM8uGrbGYsA7WChyD37=-dAGjZ6YegryiFfYfEkgww@mail.gmail.com>
In-Reply-To: CAAuRk_hD6MHQ53LXCu9ndjvCm0x8ixFV_8hLcCLA7RxN0zTUWQ@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1992656721661975058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Will,

Just wanted to confirm that setting the WUC bits did the trick. I'm
guessing that there's no way to do that from ACPICA, correct?

Thanks,
Devin


On Wed, Oct 14, 2020 at 6:18 PM Devin Steffler <devinsteffler(a)gmail.com>
wrote:

> Hi Will,
>
> I think you hit the nail on the head. I just found out about the WUC
> register as well via various online searches.
>
> I am going to give that a shot and let you know.
>
> If it is due to WUC bits, then do you know if there is a way to toggle
> that programmatically with ACPICA in an agnostic way? Otherwise I have a
> feeling I'll need to write lots of code for different chipsets and it wou=
ld
> not be very future proof. This applies for different vendors as well
> (although QNX is really just Intel, Realtek or ASIX).
>
> Many thanks for your email.
>
> Devin
>
>
> On Wed, Oct 14, 2020, 1:15 PM Will Miles <wmiles(a)sgl.com> wrote:
>
>> Hi Devin,
>>
>> I did some of the initial porting work to compile ACPICA for use in QNX
>> userspace.   I'm glad to hear you've had some success with it!
>>
>> I can't speak for current revisions; but at least as far as the BSP
>> supplied with QNX 6.6, QNX's e1000 driver explicitly disables
>> wake-on-LAN when loaded by writing to the wakeup control (WUC) register
>> on the device.   My recommendation would be to get a copy of the
>> datasheet for your device
>> (
>> http://www.intel.com/content/www/us/en/embedded/products/networking/ethe=
rnet-connection-i219-datasheet.html
>> ?) and then, as part of your shutdown routine, explicitly terminate the
>> QNX network drivers and then manually re-enable APM wakeup by directly
>> interacting with the ethernet device registers.
>>
>> Hope this is of some help,
>>
>> -Will
>>
>> On 10/14/2020 12:02 PM, devinsteffler(a)gmail.com wrote:
>> > Hello,
>> >
>> > I raised a case with QNX about this last week but I haven't heard back
>> from them yet. In the meantime, I'm wondering if the kind folks at ACPICA
>> might be able to help with this. I'm hoping that I'm not missing anything
>> obvious.
>> >
>> > I'm using an Intel based x86_64 PC with QNX on it (an Intel NUC
>> NUC7i5DNB to be precise). QNX does not have ACPI support built-in. As an
>> example, QNX does not have a way to read battery status or power down (s=
oft
>> off, S5) an x86 based PC.
>> >
>> > So I'm making my own ACPI driver for QNX based off of the ACPICA code
>> base. I've done this previously with success for reading AC power/battery
>> information on laptops using things like _PSR from a ACPI0003 device as
>> well as _STA, _BIF, and _BST from PNP0C0A devices.
>> >
>> > Now I would like to try and get Wake On LAN working from a soft off
>> (S5) state.
>> >
>> > I'm able to enter S5 via the following code:
>> > -----------------------------------------------
>> >       AcpiEnterSleepStatePrep(5);
>> >
>> >       // disable interrupts, optional?
>> >       ThreadCtl( _NTO_TCTL_IO, 0 );
>> >       InterruptDisable();
>> >
>> >       AcpiEnterSleepState(5);
>> > -----------------------------------------------
>> >
>> > Unfortunately, when I enter S5 using that code, then Wake On LAN no
>> longer works when powered off. Although as you'll see below, Wake On LAN=
 no
>> longer works if I go to S5 after having used the QNX e1000 driver. If I
>> don't use the e1000 driver then Wake On LAN works. Although, I need the =
QNX
>> e1000 driver to have networking when running.
>> >
>> > I've made the following observations:
>> > - When I boot my device with Linux and power it off using software,
>> then I'm able to Wake On LAN just fine.
>> >    - in this case, the NIC LEDs blink while powered off
>> > - If I boot into QNX and hold the power button for 10 seconds or so, it
>> powers off and Wake On LAN works (whether the QNX e1000 driver is loaded=
 or
>> not).
>> >    - in this case, the NIC LEDs blink while powered off
>> > - If I boot into QNX and use software (the code above) to power down,
>> then Wake On LAN does not work.
>> >    - in this case, the NIC LEDs remain off while powered off
>> > - If I boot into QNX but do not start their networking stack (or their
>> e1000 driver) and use software (the code above) to power down, then Wake=
 On
>> LAN does work.
>> >    - in this case, the NIC LEDs blink while powered off (they
>> momentarily stop blinking, but then blink again shortly afterwards)
>> >
>> > QNX has a pci-tool (similar to Linux's lspci tool). I can use it to see
>> the following:
>> >
>> ------------------------------------------------------------------------=
----------
>> > # pci-tool -vvvv -d0:31:6
>> >
>> > B000:D31:F06 @ idx 0
>> >          vid/did: 8086/156f
>> >                  Intel Corporation, <device id - unknown>
>> >          class/subclass/reg: 02/00/00
>> >                  Ethernet Network Controller
>> > <snip>
>> >          PMI Capability Details
>> >                  PMI supported states: D0 D3hot D3cold *
>> >                  PMI current state: D0
>> >                  PME's supported from states: D0 D3hot D3cold *
>> >                  PME's are disabled
>> >                  PMI data: [idx] val scale
>> >                          [00]  00  01  [01]  --  --  [02]  --  --
>> [03]  00  01
>> >                          [04]  00  01  [05]  --  --  [06]  --  --
>> [07]  00  01
>> >                          [08]  --  --  [09]  --  --  [10]  --  --
>> [11]  --  --
>> >                          [12]  --  --  [13]  --  --  [14]  --  --
>> [15]  --  --
>> >
>> ------------------------------------------------------------------------=
----------
>> >
>> > I can use this method in ACPI to get "PME's are enabled" output:
>> > \_SB.PCI0.GLAN._DSW
>> >
>> > i.e.
>> >
>> ------------------------------------------------------------------------=
----------
>> > # pci-tool -vvvv -d0:31:6
>> >
>> > B000:D31:F06 @ idx 0
>> > <snip>
>> >          PMI Capability Details
>> >                  PMI supported states: D0 D3hot D3cold *
>> >                  PMI current state: D0
>> >                  PME's supported from states: D0 D3hot D3cold *
>> >                  PME's are enabled
>> >                  PMI data: [idx] val scale
>> >                          [00]  00  01  [01]  --  --  [02]  --  --
>> [03]  00  01
>> >                          [04]  00  01  [05]  --  --  [06]  --  --
>> [07]  00  01
>> >                          [08]  --  --  [09]  --  --  [10]  --  --
>> [11]  --  --
>> >                          [12]  --  --  [13]  --  --  [14]  --  --
>> [15]  --  --
>> >
>> ------------------------------------------------------------------------=
----------
>> >
>> > Although that doesn't help.
>> >
>> > Do I need to get the PMI current state to be D3hot prior to entering S5
>> in order for Wake On LAN to work?
>> >
>> > However, I noticed that if I boot without the QNX e1000 driver, then
>> Wake On LAN works by just going to S5 alone, without _DSW. In this case:
>> >
>> ------------------------------------------------------------------------=
----------
>> > # pci-tool -vvvv -d0:31:6
>> >
>> > B000:D31:F06 @ idx 0
>> > <snip>
>> >          PMI Capability Details
>> >                  PMI supported states: D0 D3hot D3cold *
>> >                  PMI current state: D0
>> >                  PME's supported from states: D0 D3hot D3cold *
>> >                  PME's are disabled
>> >                  PMI data: [idx] val scale
>> >                          [00]  00  01  [01]  --  --  [02]  --  --
>> [03]  00  01
>> >                          [04]  00  01  [05]  --  --  [06]  --  --
>> [07]  00  01
>> >                          [08]  --  --  [09]  --  --  [10]  --  --
>> [11]  --  --
>> >                          [12]  --  --  [13]  --  --  [14]  --  --
>> [15]  --  --
>> >
>> ------------------------------------------------------------------------=
----------
>> >
>> > It's almost like the QNX e1000 driver is putting the NIC into some
>> state that EFI does not recover from when transitioning to S5. Maybe the
>> PHY is being turned off. If this is the case, then should calls to things
>> like _DSW, _PRW (and enabling GPE it returns), or even the LPI function 5
>> put the PHY back on? The NIC LEDs shut off at the same time as the power
>> LED when entering S5 and do not come back on.
>> >
>> > For LPI I'm referring to this:
>> >
>> https://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_=
S0_Idle.pdf
>> >
>> > Any help is appreciated.
>> >
>> > Thanks,
>> > Devin
>> > _______________________________________________
>> > Devel mailing list -- devel(a)acpica.org
>> > To unsubscribe send an email to devel-leave(a)acpica.org
>> > %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
>> _______________________________________________
>> Devel mailing list -- devel(a)acpica.org
>> To unsubscribe send an email to devel-leave(a)acpica.org
>> %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
>>
>

--===============1992656721661975058==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBXaWxsLDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SnVz
dCB3YW50ZWQgdG8gY29uZmlybSB0aGF0IHNldHRpbmcgdGhlIFdVQyBiaXRzIGRpZCB0aGUgdHJp
Y2suIEkmIzM5O20gZ3Vlc3NpbmcgdGhhdCB0aGVyZSYjMzk7cyBubyB3YXkgdG8gZG8gdGhhdCBm
cm9tIEFDUElDQSwgY29ycmVjdD88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rcyw8YnI+
PC9kaXY+PGRpdj5EZXZpbjwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNz
PSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFdlZCwg
T2N0IDE0LCAyMDIwIGF0IDY6MTggUE0gRGV2aW4gU3RlZmZsZXIgJmx0OzxhIGhyZWY9Im1haWx0
bzpkZXZpbnN0ZWZmbGVyQGdtYWlsLmNvbSI+ZGV2aW5zdGVmZmxlckBnbWFpbC5jb208L2E+Jmd0
OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIw
NCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJhdXRvIj5IaSBXaWxsLDxkaXYgZGly
PSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPkkgdGhpbmsgeW91IGhpdCB0aGUgbmFp
bCBvbiB0aGUgaGVhZC4gSSBqdXN0IGZvdW5kIG91dCBhYm91dCB0aGUgV1VDIHJlZ2lzdGVyIGFz
IHdlbGwgdmlhIHZhcmlvdXMgb25saW5lIHNlYXJjaGVzLjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48
YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPkkgYW0gZ29pbmcgdG8gZ2l2ZSB0aGF0IGEgc2hvdCBh
bmQgbGV0IHlvdSBrbm93LjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9
ImF1dG8iPklmIGl0IGlzIGR1ZSB0byBXVUMgYml0cywgdGhlbiBkbyB5b3Uga25vdyBpZiB0aGVy
ZSBpcyBhIHdheSB0byB0b2dnbGUgdGhhdCBwcm9ncmFtbWF0aWNhbGx5IHdpdGggQUNQSUNBIGlu
IGFuIGFnbm9zdGljIHdheT8gT3RoZXJ3aXNlIEkgaGF2ZSBhIGZlZWxpbmcgSSYjMzk7bGwgbmVl
ZCB0byB3cml0ZSBsb3RzIG9mIGNvZGUgZm9yIGRpZmZlcmVudCBjaGlwc2V0cyBhbmQgaXQgd291
bGQgbm90IGJlIHZlcnkgZnV0dXJlIHByb29mLiBUaGlzIGFwcGxpZXMgZm9yIGRpZmZlcmVudCB2
ZW5kb3JzIGFzIHdlbGwgKGFsdGhvdWdoIFFOWCBpcyByZWFsbHkganVzdCBJbnRlbCwgUmVhbHRl
ayBvciBBU0lYKS48L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGJyPjwvZGl2PjxkaXYgZGlyPSJhdXRv
Ij5NYW55IHRoYW5rcyBmb3IgeW91ciBlbWFpbC48L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGJyPjwv
ZGl2PjxkaXYgZGlyPSJhdXRvIj5EZXZpbjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+
PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0i
Z21haWxfYXR0ciI+T24gV2VkLCBPY3QgMTQsIDIwMjAsIDE6MTUgUE0gV2lsbCBNaWxlcyAmbHQ7
PGEgaHJlZj0ibWFpbHRvOndtaWxlc0BzZ2wuY29tIiB0YXJnZXQ9Il9ibGFuayI+d21pbGVzQHNn
bC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1
b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xp
ZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPkhpIERldmluLDxicj4KPGJyPgpJ
IGRpZCBzb21lIG9mIHRoZSBpbml0aWFsIHBvcnRpbmcgd29yayB0byBjb21waWxlIEFDUElDQSBm
b3IgdXNlIGluIFFOWCA8YnI+CnVzZXJzcGFjZS7CoMKgIEkmIzM5O20gZ2xhZCB0byBoZWFyIHlv
dSYjMzk7dmUgaGFkIHNvbWUgc3VjY2VzcyB3aXRoIGl0ITxicj4KPGJyPgpJIGNhbiYjMzk7dCBz
cGVhayBmb3IgY3VycmVudCByZXZpc2lvbnM7IGJ1dCBhdCBsZWFzdCBhcyBmYXIgYXMgdGhlIEJT
UCA8YnI+CnN1cHBsaWVkIHdpdGggUU5YIDYuNiwgUU5YJiMzOTtzIGUxMDAwIGRyaXZlciBleHBs
aWNpdGx5IGRpc2FibGVzIDxicj4Kd2FrZS1vbi1MQU4gd2hlbiBsb2FkZWQgYnkgd3JpdGluZyB0
byB0aGUgd2FrZXVwIGNvbnRyb2wgKFdVQykgcmVnaXN0ZXIgPGJyPgpvbiB0aGUgZGV2aWNlLsKg
wqAgTXkgcmVjb21tZW5kYXRpb24gd291bGQgYmUgdG8gZ2V0IGEgY29weSBvZiB0aGUgPGJyPgpk
YXRhc2hlZXQgZm9yIHlvdXIgZGV2aWNlIDxicj4KKDxhIGhyZWY9Imh0dHA6Ly93d3cuaW50ZWwu
Y29tL2NvbnRlbnQvd3d3L3VzL2VuL2VtYmVkZGVkL3Byb2R1Y3RzL25ldHdvcmtpbmcvZXRoZXJu
ZXQtY29ubmVjdGlvbi1pMjE5LWRhdGFzaGVldC5odG1sIiByZWw9Im5vcmVmZXJyZXIgbm9yZWZl
cnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly93d3cuaW50ZWwuY29tL2NvbnRlbnQvd3d3L3Vz
L2VuL2VtYmVkZGVkL3Byb2R1Y3RzL25ldHdvcmtpbmcvZXRoZXJuZXQtY29ubmVjdGlvbi1pMjE5
LWRhdGFzaGVldC5odG1sPC9hPiA8YnI+Cj8pIGFuZCB0aGVuLCBhcyBwYXJ0IG9mIHlvdXIgc2h1
dGRvd24gcm91dGluZSwgZXhwbGljaXRseSB0ZXJtaW5hdGUgdGhlIDxicj4KUU5YIG5ldHdvcmsg
ZHJpdmVycyBhbmQgdGhlbiBtYW51YWxseSByZS1lbmFibGUgQVBNIHdha2V1cCBieSBkaXJlY3Rs
eSA8YnI+CmludGVyYWN0aW5nIHdpdGggdGhlIGV0aGVybmV0IGRldmljZSByZWdpc3RlcnMuPGJy
Pgo8YnI+CkhvcGUgdGhpcyBpcyBvZiBzb21lIGhlbHAsPGJyPgo8YnI+Ci1XaWxsPGJyPgo8YnI+
Ck9uIDEwLzE0LzIwMjAgMTI6MDIgUE0sIDxhIGhyZWY9Im1haWx0bzpkZXZpbnN0ZWZmbGVyQGdt
YWlsLmNvbSIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+ZGV2aW5zdGVmZmxlckBn
bWFpbC5jb208L2E+IHdyb3RlOjxicj4KJmd0OyBIZWxsbyw8YnI+CiZndDs8YnI+CiZndDsgSSBy
YWlzZWQgYSBjYXNlIHdpdGggUU5YIGFib3V0IHRoaXMgbGFzdCB3ZWVrIGJ1dCBJIGhhdmVuJiMz
OTt0IGhlYXJkIGJhY2sgZnJvbSB0aGVtIHlldC4gSW4gdGhlIG1lYW50aW1lLCBJJiMzOTttIHdv
bmRlcmluZyBpZiB0aGUga2luZCBmb2xrcyBhdCBBQ1BJQ0EgbWlnaHQgYmUgYWJsZSB0byBoZWxw
IHdpdGggdGhpcy4gSSYjMzk7bSBob3BpbmcgdGhhdCBJJiMzOTttIG5vdCBtaXNzaW5nIGFueXRo
aW5nIG9idmlvdXMuPGJyPgomZ3Q7PGJyPgomZ3Q7IEkmIzM5O20gdXNpbmcgYW4gSW50ZWwgYmFz
ZWQgeDg2XzY0IFBDIHdpdGggUU5YIG9uIGl0IChhbiBJbnRlbCBOVUMgTlVDN2k1RE5CIHRvIGJl
IHByZWNpc2UpLiBRTlggZG9lcyBub3QgaGF2ZSBBQ1BJIHN1cHBvcnQgYnVpbHQtaW4uIEFzIGFu
IGV4YW1wbGUsIFFOWCBkb2VzIG5vdCBoYXZlIGEgd2F5IHRvIHJlYWQgYmF0dGVyeSBzdGF0dXMg
b3IgcG93ZXIgZG93biAoc29mdCBvZmYsIFM1KSBhbiB4ODYgYmFzZWQgUEMuPGJyPgomZ3Q7PGJy
PgomZ3Q7IFNvIEkmIzM5O20gbWFraW5nIG15IG93biBBQ1BJIGRyaXZlciBmb3IgUU5YIGJhc2Vk
IG9mZiBvZiB0aGUgQUNQSUNBIGNvZGUgYmFzZS4gSSYjMzk7dmUgZG9uZSB0aGlzIHByZXZpb3Vz
bHkgd2l0aCBzdWNjZXNzIGZvciByZWFkaW5nIEFDIHBvd2VyL2JhdHRlcnkgaW5mb3JtYXRpb24g
b24gbGFwdG9wcyB1c2luZyB0aGluZ3MgbGlrZSBfUFNSIGZyb20gYSBBQ1BJMDAwMyBkZXZpY2Ug
YXMgd2VsbCBhcyBfU1RBLCBfQklGLCBhbmQgX0JTVCBmcm9tIFBOUDBDMEEgZGV2aWNlcy48YnI+
CiZndDs8YnI+CiZndDsgTm93IEkgd291bGQgbGlrZSB0byB0cnkgYW5kIGdldCBXYWtlIE9uIExB
TiB3b3JraW5nIGZyb20gYSBzb2Z0IG9mZiAoUzUpIHN0YXRlLjxicj4KJmd0Ozxicj4KJmd0OyBJ
JiMzOTttIGFibGUgdG8gZW50ZXIgUzUgdmlhIHRoZSBmb2xsb3dpbmcgY29kZTo8YnI+CiZndDsg
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+CiZndDvC
oCDCoCDCoCDCoEFjcGlFbnRlclNsZWVwU3RhdGVQcmVwKDUpOzxicj4KJmd0Ozxicj4KJmd0O8Kg
IMKgIMKgIMKgLy8gZGlzYWJsZSBpbnRlcnJ1cHRzLCBvcHRpb25hbD88YnI+CiZndDvCoCDCoCDC
oCDCoFRocmVhZEN0bCggX05UT19UQ1RMX0lPLCAwICk7PGJyPgomZ3Q7wqAgwqAgwqAgwqBJbnRl
cnJ1cHREaXNhYmxlKCk7PGJyPgomZ3Q7PGJyPgomZ3Q7wqAgwqAgwqAgwqBBY3BpRW50ZXJTbGVl
cFN0YXRlKDUpOzxicj4KJmd0OyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLTxicj4KJmd0Ozxicj4KJmd0OyBVbmZvcnR1bmF0ZWx5LCB3aGVuIEkgZW50ZXIg
UzUgdXNpbmcgdGhhdCBjb2RlLCB0aGVuIFdha2UgT24gTEFOIG5vIGxvbmdlciB3b3JrcyB3aGVu
IHBvd2VyZWQgb2ZmLiBBbHRob3VnaCBhcyB5b3UmIzM5O2xsIHNlZSBiZWxvdywgV2FrZSBPbiBM
QU4gbm8gbG9uZ2VyIHdvcmtzIGlmIEkgZ28gdG8gUzUgYWZ0ZXIgaGF2aW5nIHVzZWQgdGhlIFFO
WCBlMTAwMCBkcml2ZXIuIElmIEkgZG9uJiMzOTt0IHVzZSB0aGUgZTEwMDAgZHJpdmVyIHRoZW4g
V2FrZSBPbiBMQU4gd29ya3MuIEFsdGhvdWdoLCBJIG5lZWQgdGhlIFFOWCBlMTAwMCBkcml2ZXIg
dG8gaGF2ZSBuZXR3b3JraW5nIHdoZW4gcnVubmluZy48YnI+CiZndDs8YnI+CiZndDsgSSYjMzk7
dmUgbWFkZSB0aGUgZm9sbG93aW5nIG9ic2VydmF0aW9uczo8YnI+CiZndDsgLSBXaGVuIEkgYm9v
dCBteSBkZXZpY2Ugd2l0aCBMaW51eCBhbmQgcG93ZXIgaXQgb2ZmIHVzaW5nIHNvZnR3YXJlLCB0
aGVuIEkmIzM5O20gYWJsZSB0byBXYWtlIE9uIExBTiBqdXN0IGZpbmUuPGJyPgomZ3Q7wqAgwqAg
LSBpbiB0aGlzIGNhc2UsIHRoZSBOSUMgTEVEcyBibGluayB3aGlsZSBwb3dlcmVkIG9mZjxicj4K
Jmd0OyAtIElmIEkgYm9vdCBpbnRvIFFOWCBhbmQgaG9sZCB0aGUgcG93ZXIgYnV0dG9uIGZvciAx
MCBzZWNvbmRzIG9yIHNvLCBpdCBwb3dlcnMgb2ZmIGFuZCBXYWtlIE9uIExBTiB3b3JrcyAod2hl
dGhlciB0aGUgUU5YIGUxMDAwIGRyaXZlciBpcyBsb2FkZWQgb3Igbm90KS48YnI+CiZndDvCoCDC
oCAtIGluIHRoaXMgY2FzZSwgdGhlIE5JQyBMRURzIGJsaW5rIHdoaWxlIHBvd2VyZWQgb2ZmPGJy
PgomZ3Q7IC0gSWYgSSBib290IGludG8gUU5YIGFuZCB1c2Ugc29mdHdhcmUgKHRoZSBjb2RlIGFi
b3ZlKSB0byBwb3dlciBkb3duLCB0aGVuIFdha2UgT24gTEFOIGRvZXMgbm90IHdvcmsuPGJyPgom
Z3Q7wqAgwqAgLSBpbiB0aGlzIGNhc2UsIHRoZSBOSUMgTEVEcyByZW1haW4gb2ZmIHdoaWxlIHBv
d2VyZWQgb2ZmPGJyPgomZ3Q7IC0gSWYgSSBib290IGludG8gUU5YIGJ1dCBkbyBub3Qgc3RhcnQg
dGhlaXIgbmV0d29ya2luZyBzdGFjayAob3IgdGhlaXIgZTEwMDAgZHJpdmVyKSBhbmQgdXNlIHNv
ZnR3YXJlICh0aGUgY29kZSBhYm92ZSkgdG8gcG93ZXIgZG93biwgdGhlbiBXYWtlIE9uIExBTiBk
b2VzIHdvcmsuPGJyPgomZ3Q7wqAgwqAgLSBpbiB0aGlzIGNhc2UsIHRoZSBOSUMgTEVEcyBibGlu
ayB3aGlsZSBwb3dlcmVkIG9mZiAodGhleSBtb21lbnRhcmlseSBzdG9wIGJsaW5raW5nLCBidXQg
dGhlbiBibGluayBhZ2FpbiBzaG9ydGx5IGFmdGVyd2FyZHMpPGJyPgomZ3Q7PGJyPgomZ3Q7IFFO
WCBoYXMgYSBwY2ktdG9vbCAoc2ltaWxhciB0byBMaW51eCYjMzk7cyBsc3BjaSB0b29sKS4gSSBj
YW4gdXNlIGl0IHRvIHNlZSB0aGUgZm9sbG93aW5nOjxicj4KJmd0OyAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tPGJyPgomZ3Q7ICMgcGNpLXRvb2wgLXZ2dnYgLWQwOjMxOjY8YnI+CiZndDs8YnI+
CiZndDsgQjAwMDpEMzE6RjA2IEAgaWR4IDA8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCB2aWQvZGlk
OiA4MDg2LzE1NmY8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJbnRlbCBDb3Jw
b3JhdGlvbiwgJmx0O2RldmljZSBpZCAtIHVua25vd24mZ3Q7PGJyPgomZ3Q7wqAgwqAgwqAgwqAg
wqAgY2xhc3Mvc3ViY2xhc3MvcmVnOiAwMi8wMC8wMDxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIEV0aGVybmV0IE5ldHdvcmsgQ29udHJvbGxlcjxicj4KJmd0OyAmbHQ7c25pcCZn
dDs8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCBQTUkgQ2FwYWJpbGl0eSBEZXRhaWxzPGJyPgomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1JIHN1cHBvcnRlZCBzdGF0ZXM6IEQwIEQzaG90
IEQzY29sZCAqPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1JIGN1cnJlbnQg
c3RhdGU6IEQwPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1FJiMzOTtzIHN1
cHBvcnRlZCBmcm9tIHN0YXRlczogRDAgRDNob3QgRDNjb2xkICo8YnI+CiZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBQTUUmIzM5O3MgYXJlIGRpc2FibGVkPGJyPgomZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgUE1JIGRhdGE6IFtpZHhdIHZhbCBzY2FsZTxicj4KJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFswMF3CoCAwMMKgIDAxwqAgWzAxXcKg
IC0twqAgLS3CoCBbMDJdwqAgLS3CoCAtLcKgIFswM13CoCAwMMKgIDAxPGJyPgomZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgWzA0XcKgIDAwwqAgMDHCoCBbMDVdwqAg
LS3CoCAtLcKgIFswNl3CoCAtLcKgIC0twqAgWzA3XcKgIDAwwqAgMDE8YnI+CiZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBbMDhdwqAgLS3CoCAtLcKgIFswOV3CoCAt
LcKgIC0twqAgWzEwXcKgIC0twqAgLS3CoCBbMTFdwqAgLS3CoCAtLTxicj4KJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFsxMl3CoCAtLcKgIC0twqAgWzEzXcKgIC0t
wqAgLS3CoCBbMTRdwqAgLS3CoCAtLcKgIFsxNV3CoCAtLcKgIC0tPGJyPgomZ3Q7IC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS08YnI+CiZndDs8YnI+CiZndDsgSSBjYW4gdXNlIHRoaXMgbWV0aG9k
IGluIEFDUEkgdG8gZ2V0ICZxdW90O1BNRSYjMzk7cyBhcmUgZW5hYmxlZCZxdW90OyBvdXRwdXQ6
PGJyPgomZ3Q7IFxfU0IuUENJMC5HTEFOLl9EU1c8YnI+CiZndDs8YnI+CiZndDsgaS5lLjxicj4K
Jmd0OyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPgomZ3Q7ICMgcGNpLXRvb2wgLXZ2dnYg
LWQwOjMxOjY8YnI+CiZndDs8YnI+CiZndDsgQjAwMDpEMzE6RjA2IEAgaWR4IDA8YnI+CiZndDsg
Jmx0O3NuaXAmZ3Q7PGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgUE1JIENhcGFiaWxpdHkgRGV0YWls
czxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBNSSBzdXBwb3J0ZWQgc3RhdGVz
OiBEMCBEM2hvdCBEM2NvbGQgKjxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBN
SSBjdXJyZW50IHN0YXRlOiBEMDxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBN
RSYjMzk7cyBzdXBwb3J0ZWQgZnJvbSBzdGF0ZXM6IEQwIEQzaG90IEQzY29sZCAqPGJyPgomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1FJiMzOTtzIGFyZSBlbmFibGVkPGJyPgomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1JIGRhdGE6IFtpZHhdIHZhbCBzY2FsZTxicj4K
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFswMF3CoCAwMMKgIDAx
wqAgWzAxXcKgIC0twqAgLS3CoCBbMDJdwqAgLS3CoCAtLcKgIFswM13CoCAwMMKgIDAxPGJyPgom
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgWzA0XcKgIDAwwqAgMDHC
oCBbMDVdwqAgLS3CoCAtLcKgIFswNl3CoCAtLcKgIC0twqAgWzA3XcKgIDAwwqAgMDE8YnI+CiZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBbMDhdwqAgLS3CoCAtLcKg
IFswOV3CoCAtLcKgIC0twqAgWzEwXcKgIC0twqAgLS3CoCBbMTFdwqAgLS3CoCAtLTxicj4KJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFsxMl3CoCAtLcKgIC0twqAg
WzEzXcKgIC0twqAgLS3CoCBbMTRdwqAgLS3CoCAtLcKgIFsxNV3CoCAtLcKgIC0tPGJyPgomZ3Q7
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+CiZndDs8YnI+CiZndDsgQWx0aG91Z2ggdGhh
dCBkb2VzbiYjMzk7dCBoZWxwLjxicj4KJmd0Ozxicj4KJmd0OyBEbyBJIG5lZWQgdG8gZ2V0IHRo
ZSBQTUkgY3VycmVudCBzdGF0ZSB0byBiZSBEM2hvdCBwcmlvciB0byBlbnRlcmluZyBTNSBpbiBv
cmRlciBmb3IgV2FrZSBPbiBMQU4gdG8gd29yaz88YnI+CiZndDs8YnI+CiZndDsgSG93ZXZlciwg
SSBub3RpY2VkIHRoYXQgaWYgSSBib290IHdpdGhvdXQgdGhlIFFOWCBlMTAwMCBkcml2ZXIsIHRo
ZW4gV2FrZSBPbiBMQU4gd29ya3MgYnkganVzdCBnb2luZyB0byBTNSBhbG9uZSwgd2l0aG91dCBf
RFNXLiBJbiB0aGlzIGNhc2U6PGJyPgomZ3Q7IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+
CiZndDsgIyBwY2ktdG9vbCAtdnZ2diAtZDA6MzE6Njxicj4KJmd0Ozxicj4KJmd0OyBCMDAwOkQz
MTpGMDYgQCBpZHggMDxicj4KJmd0OyAmbHQ7c25pcCZndDs8YnI+CiZndDvCoCDCoCDCoCDCoCDC
oCBQTUkgQ2FwYWJpbGl0eSBEZXRhaWxzPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgUE1JIHN1cHBvcnRlZCBzdGF0ZXM6IEQwIEQzaG90IEQzY29sZCAqPGJyPgomZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1JIGN1cnJlbnQgc3RhdGU6IEQwPGJyPgomZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1FJiMzOTtzIHN1cHBvcnRlZCBmcm9tIHN0YXRlczogRDAg
RDNob3QgRDNjb2xkICo8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQTUUmIzM5
O3MgYXJlIGRpc2FibGVkPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1JIGRh
dGE6IFtpZHhdIHZhbCBzY2FsZTxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIFswMF3CoCAwMMKgIDAxwqAgWzAxXcKgIC0twqAgLS3CoCBbMDJdwqAgLS3CoCAt
LcKgIFswM13CoCAwMMKgIDAxPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgWzA0XcKgIDAwwqAgMDHCoCBbMDVdwqAgLS3CoCAtLcKgIFswNl3CoCAtLcKgIC0t
wqAgWzA3XcKgIDAwwqAgMDE8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBbMDhdwqAgLS3CoCAtLcKgIFswOV3CoCAtLcKgIC0twqAgWzEwXcKgIC0twqAgLS3C
oCBbMTFdwqAgLS3CoCAtLTxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIFsxMl3CoCAtLcKgIC0twqAgWzEzXcKgIC0twqAgLS3CoCBbMTRdwqAgLS3CoCAtLcKg
IFsxNV3CoCAtLcKgIC0tPGJyPgomZ3Q7IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+CiZn
dDs8YnI+CiZndDsgSXQmIzM5O3MgYWxtb3N0IGxpa2UgdGhlIFFOWCBlMTAwMCBkcml2ZXIgaXMg
cHV0dGluZyB0aGUgTklDIGludG8gc29tZSBzdGF0ZSB0aGF0IEVGSSBkb2VzIG5vdCByZWNvdmVy
IGZyb20gd2hlbiB0cmFuc2l0aW9uaW5nIHRvIFM1LiBNYXliZSB0aGUgUEhZIGlzIGJlaW5nIHR1
cm5lZCBvZmYuIElmIHRoaXMgaXMgdGhlIGNhc2UsIHRoZW4gc2hvdWxkIGNhbGxzIHRvIHRoaW5n
cyBsaWtlIF9EU1csIF9QUlcgKGFuZCBlbmFibGluZyBHUEUgaXQgcmV0dXJucyksIG9yIGV2ZW4g
dGhlIExQSSBmdW5jdGlvbiA1IHB1dCB0aGUgUEhZIGJhY2sgb24/IFRoZSBOSUMgTEVEcyBzaHV0
IG9mZiBhdCB0aGUgc2FtZSB0aW1lIGFzIHRoZSBwb3dlciBMRUQgd2hlbiBlbnRlcmluZyBTNSBh
bmQgZG8gbm90IGNvbWUgYmFjayBvbi48YnI+CiZndDs8YnI+CiZndDsgRm9yIExQSSBJJiMzOTtt
IHJlZmVycmluZyB0byB0aGlzOjxicj4KJmd0OyA8YSBocmVmPSJodHRwczovL3d3dy51ZWZpLm9y
Zy9zaXRlcy9kZWZhdWx0L2ZpbGVzL3Jlc291cmNlcy9JbnRlbF9BQ1BJX0xvd19Qb3dlcl9TMF9J
ZGxlLnBkZiIgcmVsPSJub3JlZmVycmVyIG5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRw
czovL3d3dy51ZWZpLm9yZy9zaXRlcy9kZWZhdWx0L2ZpbGVzL3Jlc291cmNlcy9JbnRlbF9BQ1BJ
X0xvd19Qb3dlcl9TMF9JZGxlLnBkZjwvYT48YnI+CiZndDs8YnI+CiZndDsgQW55IGhlbHAgaXMg
YXBwcmVjaWF0ZWQuPGJyPgomZ3Q7PGJyPgomZ3Q7IFRoYW5rcyw8YnI+CiZndDsgRGV2aW48YnI+
CiZndDsgX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+
CiZndDsgRGV2ZWwgbWFpbGluZyBsaXN0IC0tIDxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eu
b3JnIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5kZXZlbEBhY3BpY2Eub3JnPC9h
Pjxicj4KJmd0OyBUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIDxhIGhyZWY9Im1haWx0
bzpkZXZlbC1sZWF2ZUBhY3BpY2Eub3JnIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5r
Ij5kZXZlbC1sZWF2ZUBhY3BpY2Eub3JnPC9hPjxicj4KJmd0OyAlKHdlYl9wYWdlX3VybClzbGlz
dGluZm8lKGNnaWV4dClzLyUoX2ludGVybmFsX25hbWUpczxicj4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+CkRldmVsIG1haWxpbmcgbGlzdCAtLSA8
YSBocmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9
Il9ibGFuayI+ZGV2ZWxAYWNwaWNhLm9yZzwvYT48YnI+ClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4g
ZW1haWwgdG8gPGEgaHJlZj0ibWFpbHRvOmRldmVsLWxlYXZlQGFjcGljYS5vcmciIHJlbD0ibm9y
ZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmRldmVsLWxlYXZlQGFjcGljYS5vcmc8L2E+PGJyPgol
KHdlYl9wYWdlX3VybClzbGlzdGluZm8lKGNnaWV4dClzLyUoX2ludGVybmFsX25hbWUpczxicj4K
PC9ibG9ja3F1b3RlPjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============1992656721661975058==--

