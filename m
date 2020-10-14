Content-Type: multipart/mixed; boundary="===============1511162337518266881=="
MIME-Version: 1.0
From: Devin Steffler <devinsteffler at gmail.com>
Subject: [Devel] Re: Wake On LAN steps for QNX from S5
Date: Wed, 14 Oct 2020 18:18:46 -0400
Message-ID: <CAAuRk_hD6MHQ53LXCu9ndjvCm0x8ixFV_8hLcCLA7RxN0zTUWQ@mail.gmail.com>
In-Reply-To: 488f332a-5635-7cd7-ce50-bca18181e043@sgl.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1511162337518266881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Will,

I think you hit the nail on the head. I just found out about the WUC
register as well via various online searches.

I am going to give that a shot and let you know.

If it is due to WUC bits, then do you know if there is a way to toggle that
programmatically with ACPICA in an agnostic way? Otherwise I have a feeling
I'll need to write lots of code for different chipsets and it would not be
very future proof. This applies for different vendors as well (although QNX
is really just Intel, Realtek or ASIX).

Many thanks for your email.

Devin


On Wed, Oct 14, 2020, 1:15 PM Will Miles <wmiles(a)sgl.com> wrote:

> Hi Devin,
>
> I did some of the initial porting work to compile ACPICA for use in QNX
> userspace.   I'm glad to hear you've had some success with it!
>
> I can't speak for current revisions; but at least as far as the BSP
> supplied with QNX 6.6, QNX's e1000 driver explicitly disables
> wake-on-LAN when loaded by writing to the wakeup control (WUC) register
> on the device.   My recommendation would be to get a copy of the
> datasheet for your device
> (
> http://www.intel.com/content/www/us/en/embedded/products/networking/ether=
net-connection-i219-datasheet.html
> ?) and then, as part of your shutdown routine, explicitly terminate the
> QNX network drivers and then manually re-enable APM wakeup by directly
> interacting with the ethernet device registers.
>
> Hope this is of some help,
>
> -Will
>
> On 10/14/2020 12:02 PM, devinsteffler(a)gmail.com wrote:
> > Hello,
> >
> > I raised a case with QNX about this last week but I haven't heard back
> from them yet. In the meantime, I'm wondering if the kind folks at ACPICA
> might be able to help with this. I'm hoping that I'm not missing anything
> obvious.
> >
> > I'm using an Intel based x86_64 PC with QNX on it (an Intel NUC
> NUC7i5DNB to be precise). QNX does not have ACPI support built-in. As an
> example, QNX does not have a way to read battery status or power down (so=
ft
> off, S5) an x86 based PC.
> >
> > So I'm making my own ACPI driver for QNX based off of the ACPICA code
> base. I've done this previously with success for reading AC power/battery
> information on laptops using things like _PSR from a ACPI0003 device as
> well as _STA, _BIF, and _BST from PNP0C0A devices.
> >
> > Now I would like to try and get Wake On LAN working from a soft off (S5)
> state.
> >
> > I'm able to enter S5 via the following code:
> > -----------------------------------------------
> >       AcpiEnterSleepStatePrep(5);
> >
> >       // disable interrupts, optional?
> >       ThreadCtl( _NTO_TCTL_IO, 0 );
> >       InterruptDisable();
> >
> >       AcpiEnterSleepState(5);
> > -----------------------------------------------
> >
> > Unfortunately, when I enter S5 using that code, then Wake On LAN no
> longer works when powered off. Although as you'll see below, Wake On LAN =
no
> longer works if I go to S5 after having used the QNX e1000 driver. If I
> don't use the e1000 driver then Wake On LAN works. Although, I need the Q=
NX
> e1000 driver to have networking when running.
> >
> > I've made the following observations:
> > - When I boot my device with Linux and power it off using software, then
> I'm able to Wake On LAN just fine.
> >    - in this case, the NIC LEDs blink while powered off
> > - If I boot into QNX and hold the power button for 10 seconds or so, it
> powers off and Wake On LAN works (whether the QNX e1000 driver is loaded =
or
> not).
> >    - in this case, the NIC LEDs blink while powered off
> > - If I boot into QNX and use software (the code above) to power down,
> then Wake On LAN does not work.
> >    - in this case, the NIC LEDs remain off while powered off
> > - If I boot into QNX but do not start their networking stack (or their
> e1000 driver) and use software (the code above) to power down, then Wake =
On
> LAN does work.
> >    - in this case, the NIC LEDs blink while powered off (they
> momentarily stop blinking, but then blink again shortly afterwards)
> >
> > QNX has a pci-tool (similar to Linux's lspci tool). I can use it to see
> the following:
> >
> -------------------------------------------------------------------------=
---------
> > # pci-tool -vvvv -d0:31:6
> >
> > B000:D31:F06 @ idx 0
> >          vid/did: 8086/156f
> >                  Intel Corporation, <device id - unknown>
> >          class/subclass/reg: 02/00/00
> >                  Ethernet Network Controller
> > <snip>
> >          PMI Capability Details
> >                  PMI supported states: D0 D3hot D3cold *
> >                  PMI current state: D0
> >                  PME's supported from states: D0 D3hot D3cold *
> >                  PME's are disabled
> >                  PMI data: [idx] val scale
> >                          [00]  00  01  [01]  --  --  [02]  --  --  [03]
> 00  01
> >                          [04]  00  01  [05]  --  --  [06]  --  --  [07]
> 00  01
> >                          [08]  --  --  [09]  --  --  [10]  --  --  [11]
> --  --
> >                          [12]  --  --  [13]  --  --  [14]  --  --  [15]
> --  --
> >
> -------------------------------------------------------------------------=
---------
> >
> > I can use this method in ACPI to get "PME's are enabled" output:
> > \_SB.PCI0.GLAN._DSW
> >
> > i.e.
> >
> -------------------------------------------------------------------------=
---------
> > # pci-tool -vvvv -d0:31:6
> >
> > B000:D31:F06 @ idx 0
> > <snip>
> >          PMI Capability Details
> >                  PMI supported states: D0 D3hot D3cold *
> >                  PMI current state: D0
> >                  PME's supported from states: D0 D3hot D3cold *
> >                  PME's are enabled
> >                  PMI data: [idx] val scale
> >                          [00]  00  01  [01]  --  --  [02]  --  --  [03]
> 00  01
> >                          [04]  00  01  [05]  --  --  [06]  --  --  [07]
> 00  01
> >                          [08]  --  --  [09]  --  --  [10]  --  --  [11]
> --  --
> >                          [12]  --  --  [13]  --  --  [14]  --  --  [15]
> --  --
> >
> -------------------------------------------------------------------------=
---------
> >
> > Although that doesn't help.
> >
> > Do I need to get the PMI current state to be D3hot prior to entering S5
> in order for Wake On LAN to work?
> >
> > However, I noticed that if I boot without the QNX e1000 driver, then
> Wake On LAN works by just going to S5 alone, without _DSW. In this case:
> >
> -------------------------------------------------------------------------=
---------
> > # pci-tool -vvvv -d0:31:6
> >
> > B000:D31:F06 @ idx 0
> > <snip>
> >          PMI Capability Details
> >                  PMI supported states: D0 D3hot D3cold *
> >                  PMI current state: D0
> >                  PME's supported from states: D0 D3hot D3cold *
> >                  PME's are disabled
> >                  PMI data: [idx] val scale
> >                          [00]  00  01  [01]  --  --  [02]  --  --  [03]
> 00  01
> >                          [04]  00  01  [05]  --  --  [06]  --  --  [07]
> 00  01
> >                          [08]  --  --  [09]  --  --  [10]  --  --  [11]
> --  --
> >                          [12]  --  --  [13]  --  --  [14]  --  --  [15]
> --  --
> >
> -------------------------------------------------------------------------=
---------
> >
> > It's almost like the QNX e1000 driver is putting the NIC into some state
> that EFI does not recover from when transitioning to S5. Maybe the PHY is
> being turned off. If this is the case, then should calls to things like
> _DSW, _PRW (and enabling GPE it returns), or even the LPI function 5 put
> the PHY back on? The NIC LEDs shut off at the same time as the power LED
> when entering S5 and do not come back on.
> >
> > For LPI I'm referring to this:
> >
> https://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S=
0_Idle.pdf
> >
> > Any help is appreciated.
> >
> > Thanks,
> > Devin
> > _______________________________________________
> > Devel mailing list -- devel(a)acpica.org
> > To unsubscribe send an email to devel-leave(a)acpica.org
> > %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
> _______________________________________________
> Devel mailing list -- devel(a)acpica.org
> To unsubscribe send an email to devel-leave(a)acpica.org
> %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
>

--===============1511162337518266881==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9ImF1dG8iPkhpIFdpbGwsPGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRp
cj0iYXV0byI+SSB0aGluayB5b3UgaGl0IHRoZSBuYWlsIG9uIHRoZSBoZWFkLiBJIGp1c3QgZm91
bmQgb3V0IGFib3V0IHRoZSBXVUMgcmVnaXN0ZXIgYXMgd2VsbCB2aWEgdmFyaW91cyBvbmxpbmUg
c2VhcmNoZXMuPC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+
SSBhbSBnb2luZyB0byBnaXZlIHRoYXQgYSBzaG90IGFuZCBsZXQgeW91IGtub3cuPC9kaXY+PGRp
diBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+SWYgaXQgaXMgZHVlIHRvIFdV
QyBiaXRzLCB0aGVuIGRvIHlvdSBrbm93IGlmIHRoZXJlIGlzIGEgd2F5IHRvIHRvZ2dsZSB0aGF0
IHByb2dyYW1tYXRpY2FsbHkgd2l0aCBBQ1BJQ0EgaW4gYW4gYWdub3N0aWMgd2F5PyBPdGhlcndp
c2UgSSBoYXZlIGEgZmVlbGluZyBJJiMzOTtsbCBuZWVkIHRvIHdyaXRlIGxvdHMgb2YgY29kZSBm
b3IgZGlmZmVyZW50IGNoaXBzZXRzIGFuZCBpdCB3b3VsZCBub3QgYmUgdmVyeSBmdXR1cmUgcHJv
b2YuIFRoaXMgYXBwbGllcyBmb3IgZGlmZmVyZW50IHZlbmRvcnMgYXMgd2VsbCAoYWx0aG91Z2gg
UU5YIGlzIHJlYWxseSBqdXN0IEludGVsLCBSZWFsdGVrIG9yIEFTSVgpLjwvZGl2PjxkaXYgZGly
PSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPk1hbnkgdGhhbmtzIGZvciB5b3VyIGVt
YWlsLjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPkRldmlu
PC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21h
aWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBXZWQsIE9jdCAx
NCwgMjAyMCwgMToxNSBQTSBXaWxsIE1pbGVzICZsdDs8YSBocmVmPSJtYWlsdG86d21pbGVzQHNn
bC5jb20iPndtaWxlc0BzZ2wuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0
OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPkhpIERldmluLDxicj4KPGJyPgpJIGRp
ZCBzb21lIG9mIHRoZSBpbml0aWFsIHBvcnRpbmcgd29yayB0byBjb21waWxlIEFDUElDQSBmb3Ig
dXNlIGluIFFOWCA8YnI+CnVzZXJzcGFjZS7CoMKgIEkmIzM5O20gZ2xhZCB0byBoZWFyIHlvdSYj
Mzk7dmUgaGFkIHNvbWUgc3VjY2VzcyB3aXRoIGl0ITxicj4KPGJyPgpJIGNhbiYjMzk7dCBzcGVh
ayBmb3IgY3VycmVudCByZXZpc2lvbnM7IGJ1dCBhdCBsZWFzdCBhcyBmYXIgYXMgdGhlIEJTUCA8
YnI+CnN1cHBsaWVkIHdpdGggUU5YIDYuNiwgUU5YJiMzOTtzIGUxMDAwIGRyaXZlciBleHBsaWNp
dGx5IGRpc2FibGVzIDxicj4Kd2FrZS1vbi1MQU4gd2hlbiBsb2FkZWQgYnkgd3JpdGluZyB0byB0
aGUgd2FrZXVwIGNvbnRyb2wgKFdVQykgcmVnaXN0ZXIgPGJyPgpvbiB0aGUgZGV2aWNlLsKgwqAg
TXkgcmVjb21tZW5kYXRpb24gd291bGQgYmUgdG8gZ2V0IGEgY29weSBvZiB0aGUgPGJyPgpkYXRh
c2hlZXQgZm9yIHlvdXIgZGV2aWNlIDxicj4KKDxhIGhyZWY9Imh0dHA6Ly93d3cuaW50ZWwuY29t
L2NvbnRlbnQvd3d3L3VzL2VuL2VtYmVkZGVkL3Byb2R1Y3RzL25ldHdvcmtpbmcvZXRoZXJuZXQt
Y29ubmVjdGlvbi1pMjE5LWRhdGFzaGVldC5odG1sIiByZWw9Im5vcmVmZXJyZXIgbm9yZWZlcnJl
ciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly93d3cuaW50ZWwuY29tL2NvbnRlbnQvd3d3L3VzL2Vu
L2VtYmVkZGVkL3Byb2R1Y3RzL25ldHdvcmtpbmcvZXRoZXJuZXQtY29ubmVjdGlvbi1pMjE5LWRh
dGFzaGVldC5odG1sPC9hPiA8YnI+Cj8pIGFuZCB0aGVuLCBhcyBwYXJ0IG9mIHlvdXIgc2h1dGRv
d24gcm91dGluZSwgZXhwbGljaXRseSB0ZXJtaW5hdGUgdGhlIDxicj4KUU5YIG5ldHdvcmsgZHJp
dmVycyBhbmQgdGhlbiBtYW51YWxseSByZS1lbmFibGUgQVBNIHdha2V1cCBieSBkaXJlY3RseSA8
YnI+CmludGVyYWN0aW5nIHdpdGggdGhlIGV0aGVybmV0IGRldmljZSByZWdpc3RlcnMuPGJyPgo8
YnI+CkhvcGUgdGhpcyBpcyBvZiBzb21lIGhlbHAsPGJyPgo8YnI+Ci1XaWxsPGJyPgo8YnI+Ck9u
IDEwLzE0LzIwMjAgMTI6MDIgUE0sIDxhIGhyZWY9Im1haWx0bzpkZXZpbnN0ZWZmbGVyQGdtYWls
LmNvbSIgdGFyZ2V0PSJfYmxhbmsiIHJlbD0ibm9yZWZlcnJlciI+ZGV2aW5zdGVmZmxlckBnbWFp
bC5jb208L2E+IHdyb3RlOjxicj4KJmd0OyBIZWxsbyw8YnI+CiZndDs8YnI+CiZndDsgSSByYWlz
ZWQgYSBjYXNlIHdpdGggUU5YIGFib3V0IHRoaXMgbGFzdCB3ZWVrIGJ1dCBJIGhhdmVuJiMzOTt0
IGhlYXJkIGJhY2sgZnJvbSB0aGVtIHlldC4gSW4gdGhlIG1lYW50aW1lLCBJJiMzOTttIHdvbmRl
cmluZyBpZiB0aGUga2luZCBmb2xrcyBhdCBBQ1BJQ0EgbWlnaHQgYmUgYWJsZSB0byBoZWxwIHdp
dGggdGhpcy4gSSYjMzk7bSBob3BpbmcgdGhhdCBJJiMzOTttIG5vdCBtaXNzaW5nIGFueXRoaW5n
IG9idmlvdXMuPGJyPgomZ3Q7PGJyPgomZ3Q7IEkmIzM5O20gdXNpbmcgYW4gSW50ZWwgYmFzZWQg
eDg2XzY0IFBDIHdpdGggUU5YIG9uIGl0IChhbiBJbnRlbCBOVUMgTlVDN2k1RE5CIHRvIGJlIHBy
ZWNpc2UpLiBRTlggZG9lcyBub3QgaGF2ZSBBQ1BJIHN1cHBvcnQgYnVpbHQtaW4uIEFzIGFuIGV4
YW1wbGUsIFFOWCBkb2VzIG5vdCBoYXZlIGEgd2F5IHRvIHJlYWQgYmF0dGVyeSBzdGF0dXMgb3Ig
cG93ZXIgZG93biAoc29mdCBvZmYsIFM1KSBhbiB4ODYgYmFzZWQgUEMuPGJyPgomZ3Q7PGJyPgom
Z3Q7IFNvIEkmIzM5O20gbWFraW5nIG15IG93biBBQ1BJIGRyaXZlciBmb3IgUU5YIGJhc2VkIG9m
ZiBvZiB0aGUgQUNQSUNBIGNvZGUgYmFzZS4gSSYjMzk7dmUgZG9uZSB0aGlzIHByZXZpb3VzbHkg
d2l0aCBzdWNjZXNzIGZvciByZWFkaW5nIEFDIHBvd2VyL2JhdHRlcnkgaW5mb3JtYXRpb24gb24g
bGFwdG9wcyB1c2luZyB0aGluZ3MgbGlrZSBfUFNSIGZyb20gYSBBQ1BJMDAwMyBkZXZpY2UgYXMg
d2VsbCBhcyBfU1RBLCBfQklGLCBhbmQgX0JTVCBmcm9tIFBOUDBDMEEgZGV2aWNlcy48YnI+CiZn
dDs8YnI+CiZndDsgTm93IEkgd291bGQgbGlrZSB0byB0cnkgYW5kIGdldCBXYWtlIE9uIExBTiB3
b3JraW5nIGZyb20gYSBzb2Z0IG9mZiAoUzUpIHN0YXRlLjxicj4KJmd0Ozxicj4KJmd0OyBJJiMz
OTttIGFibGUgdG8gZW50ZXIgUzUgdmlhIHRoZSBmb2xsb3dpbmcgY29kZTo8YnI+CiZndDsgLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+CiZndDvCoCDC
oCDCoCDCoEFjcGlFbnRlclNsZWVwU3RhdGVQcmVwKDUpOzxicj4KJmd0Ozxicj4KJmd0O8KgIMKg
IMKgIMKgLy8gZGlzYWJsZSBpbnRlcnJ1cHRzLCBvcHRpb25hbD88YnI+CiZndDvCoCDCoCDCoCDC
oFRocmVhZEN0bCggX05UT19UQ1RMX0lPLCAwICk7PGJyPgomZ3Q7wqAgwqAgwqAgwqBJbnRlcnJ1
cHREaXNhYmxlKCk7PGJyPgomZ3Q7PGJyPgomZ3Q7wqAgwqAgwqAgwqBBY3BpRW50ZXJTbGVlcFN0
YXRlKDUpOzxicj4KJmd0OyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLTxicj4KJmd0Ozxicj4KJmd0OyBVbmZvcnR1bmF0ZWx5LCB3aGVuIEkgZW50ZXIgUzUg
dXNpbmcgdGhhdCBjb2RlLCB0aGVuIFdha2UgT24gTEFOIG5vIGxvbmdlciB3b3JrcyB3aGVuIHBv
d2VyZWQgb2ZmLiBBbHRob3VnaCBhcyB5b3UmIzM5O2xsIHNlZSBiZWxvdywgV2FrZSBPbiBMQU4g
bm8gbG9uZ2VyIHdvcmtzIGlmIEkgZ28gdG8gUzUgYWZ0ZXIgaGF2aW5nIHVzZWQgdGhlIFFOWCBl
MTAwMCBkcml2ZXIuIElmIEkgZG9uJiMzOTt0IHVzZSB0aGUgZTEwMDAgZHJpdmVyIHRoZW4gV2Fr
ZSBPbiBMQU4gd29ya3MuIEFsdGhvdWdoLCBJIG5lZWQgdGhlIFFOWCBlMTAwMCBkcml2ZXIgdG8g
aGF2ZSBuZXR3b3JraW5nIHdoZW4gcnVubmluZy48YnI+CiZndDs8YnI+CiZndDsgSSYjMzk7dmUg
bWFkZSB0aGUgZm9sbG93aW5nIG9ic2VydmF0aW9uczo8YnI+CiZndDsgLSBXaGVuIEkgYm9vdCBt
eSBkZXZpY2Ugd2l0aCBMaW51eCBhbmQgcG93ZXIgaXQgb2ZmIHVzaW5nIHNvZnR3YXJlLCB0aGVu
IEkmIzM5O20gYWJsZSB0byBXYWtlIE9uIExBTiBqdXN0IGZpbmUuPGJyPgomZ3Q7wqAgwqAgLSBp
biB0aGlzIGNhc2UsIHRoZSBOSUMgTEVEcyBibGluayB3aGlsZSBwb3dlcmVkIG9mZjxicj4KJmd0
OyAtIElmIEkgYm9vdCBpbnRvIFFOWCBhbmQgaG9sZCB0aGUgcG93ZXIgYnV0dG9uIGZvciAxMCBz
ZWNvbmRzIG9yIHNvLCBpdCBwb3dlcnMgb2ZmIGFuZCBXYWtlIE9uIExBTiB3b3JrcyAod2hldGhl
ciB0aGUgUU5YIGUxMDAwIGRyaXZlciBpcyBsb2FkZWQgb3Igbm90KS48YnI+CiZndDvCoCDCoCAt
IGluIHRoaXMgY2FzZSwgdGhlIE5JQyBMRURzIGJsaW5rIHdoaWxlIHBvd2VyZWQgb2ZmPGJyPgom
Z3Q7IC0gSWYgSSBib290IGludG8gUU5YIGFuZCB1c2Ugc29mdHdhcmUgKHRoZSBjb2RlIGFib3Zl
KSB0byBwb3dlciBkb3duLCB0aGVuIFdha2UgT24gTEFOIGRvZXMgbm90IHdvcmsuPGJyPgomZ3Q7
wqAgwqAgLSBpbiB0aGlzIGNhc2UsIHRoZSBOSUMgTEVEcyByZW1haW4gb2ZmIHdoaWxlIHBvd2Vy
ZWQgb2ZmPGJyPgomZ3Q7IC0gSWYgSSBib290IGludG8gUU5YIGJ1dCBkbyBub3Qgc3RhcnQgdGhl
aXIgbmV0d29ya2luZyBzdGFjayAob3IgdGhlaXIgZTEwMDAgZHJpdmVyKSBhbmQgdXNlIHNvZnR3
YXJlICh0aGUgY29kZSBhYm92ZSkgdG8gcG93ZXIgZG93biwgdGhlbiBXYWtlIE9uIExBTiBkb2Vz
IHdvcmsuPGJyPgomZ3Q7wqAgwqAgLSBpbiB0aGlzIGNhc2UsIHRoZSBOSUMgTEVEcyBibGluayB3
aGlsZSBwb3dlcmVkIG9mZiAodGhleSBtb21lbnRhcmlseSBzdG9wIGJsaW5raW5nLCBidXQgdGhl
biBibGluayBhZ2FpbiBzaG9ydGx5IGFmdGVyd2FyZHMpPGJyPgomZ3Q7PGJyPgomZ3Q7IFFOWCBo
YXMgYSBwY2ktdG9vbCAoc2ltaWxhciB0byBMaW51eCYjMzk7cyBsc3BjaSB0b29sKS4gSSBjYW4g
dXNlIGl0IHRvIHNlZSB0aGUgZm9sbG93aW5nOjxicj4KJmd0OyAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tPGJyPgomZ3Q7ICMgcGNpLXRvb2wgLXZ2dnYgLWQwOjMxOjY8YnI+CiZndDs8YnI+CiZn
dDsgQjAwMDpEMzE6RjA2IEAgaWR4IDA8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCB2aWQvZGlkOiA4
MDg2LzE1NmY8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJbnRlbCBDb3Jwb3Jh
dGlvbiwgJmx0O2RldmljZSBpZCAtIHVua25vd24mZ3Q7PGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAg
Y2xhc3Mvc3ViY2xhc3MvcmVnOiAwMi8wMC8wMDxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIEV0aGVybmV0IE5ldHdvcmsgQ29udHJvbGxlcjxicj4KJmd0OyAmbHQ7c25pcCZndDs8
YnI+CiZndDvCoCDCoCDCoCDCoCDCoCBQTUkgQ2FwYWJpbGl0eSBEZXRhaWxzPGJyPgomZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1JIHN1cHBvcnRlZCBzdGF0ZXM6IEQwIEQzaG90IEQz
Y29sZCAqPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1JIGN1cnJlbnQgc3Rh
dGU6IEQwPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1FJiMzOTtzIHN1cHBv
cnRlZCBmcm9tIHN0YXRlczogRDAgRDNob3QgRDNjb2xkICo8YnI+CiZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBQTUUmIzM5O3MgYXJlIGRpc2FibGVkPGJyPgomZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgUE1JIGRhdGE6IFtpZHhdIHZhbCBzY2FsZTxicj4KJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFswMF3CoCAwMMKgIDAxwqAgWzAxXcKgIC0t
wqAgLS3CoCBbMDJdwqAgLS3CoCAtLcKgIFswM13CoCAwMMKgIDAxPGJyPgomZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgWzA0XcKgIDAwwqAgMDHCoCBbMDVdwqAgLS3C
oCAtLcKgIFswNl3CoCAtLcKgIC0twqAgWzA3XcKgIDAwwqAgMDE8YnI+CiZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBbMDhdwqAgLS3CoCAtLcKgIFswOV3CoCAtLcKg
IC0twqAgWzEwXcKgIC0twqAgLS3CoCBbMTFdwqAgLS3CoCAtLTxicj4KJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFsxMl3CoCAtLcKgIC0twqAgWzEzXcKgIC0twqAg
LS3CoCBbMTRdwqAgLS3CoCAtLcKgIFsxNV3CoCAtLcKgIC0tPGJyPgomZ3Q7IC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS08YnI+CiZndDs8YnI+CiZndDsgSSBjYW4gdXNlIHRoaXMgbWV0aG9kIGlu
IEFDUEkgdG8gZ2V0ICZxdW90O1BNRSYjMzk7cyBhcmUgZW5hYmxlZCZxdW90OyBvdXRwdXQ6PGJy
PgomZ3Q7IFxfU0IuUENJMC5HTEFOLl9EU1c8YnI+CiZndDs8YnI+CiZndDsgaS5lLjxicj4KJmd0
OyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPgomZ3Q7ICMgcGNpLXRvb2wgLXZ2dnYgLWQw
OjMxOjY8YnI+CiZndDs8YnI+CiZndDsgQjAwMDpEMzE6RjA2IEAgaWR4IDA8YnI+CiZndDsgJmx0
O3NuaXAmZ3Q7PGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgUE1JIENhcGFiaWxpdHkgRGV0YWlsczxi
cj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBNSSBzdXBwb3J0ZWQgc3RhdGVzOiBE
MCBEM2hvdCBEM2NvbGQgKjxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBNSSBj
dXJyZW50IHN0YXRlOiBEMDxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBNRSYj
Mzk7cyBzdXBwb3J0ZWQgZnJvbSBzdGF0ZXM6IEQwIEQzaG90IEQzY29sZCAqPGJyPgomZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1FJiMzOTtzIGFyZSBlbmFibGVkPGJyPgomZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1JIGRhdGE6IFtpZHhdIHZhbCBzY2FsZTxicj4KJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFswMF3CoCAwMMKgIDAxwqAg
WzAxXcKgIC0twqAgLS3CoCBbMDJdwqAgLS3CoCAtLcKgIFswM13CoCAwMMKgIDAxPGJyPgomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgWzA0XcKgIDAwwqAgMDHCoCBb
MDVdwqAgLS3CoCAtLcKgIFswNl3CoCAtLcKgIC0twqAgWzA3XcKgIDAwwqAgMDE8YnI+CiZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBbMDhdwqAgLS3CoCAtLcKgIFsw
OV3CoCAtLcKgIC0twqAgWzEwXcKgIC0twqAgLS3CoCBbMTFdwqAgLS3CoCAtLTxicj4KJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFsxMl3CoCAtLcKgIC0twqAgWzEz
XcKgIC0twqAgLS3CoCBbMTRdwqAgLS3CoCAtLcKgIFsxNV3CoCAtLcKgIC0tPGJyPgomZ3Q7IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+CiZndDs8YnI+CiZndDsgQWx0aG91Z2ggdGhhdCBk
b2VzbiYjMzk7dCBoZWxwLjxicj4KJmd0Ozxicj4KJmd0OyBEbyBJIG5lZWQgdG8gZ2V0IHRoZSBQ
TUkgY3VycmVudCBzdGF0ZSB0byBiZSBEM2hvdCBwcmlvciB0byBlbnRlcmluZyBTNSBpbiBvcmRl
ciBmb3IgV2FrZSBPbiBMQU4gdG8gd29yaz88YnI+CiZndDs8YnI+CiZndDsgSG93ZXZlciwgSSBu
b3RpY2VkIHRoYXQgaWYgSSBib290IHdpdGhvdXQgdGhlIFFOWCBlMTAwMCBkcml2ZXIsIHRoZW4g
V2FrZSBPbiBMQU4gd29ya3MgYnkganVzdCBnb2luZyB0byBTNSBhbG9uZSwgd2l0aG91dCBfRFNX
LiBJbiB0aGlzIGNhc2U6PGJyPgomZ3Q7IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+CiZn
dDsgIyBwY2ktdG9vbCAtdnZ2diAtZDA6MzE6Njxicj4KJmd0Ozxicj4KJmd0OyBCMDAwOkQzMTpG
MDYgQCBpZHggMDxicj4KJmd0OyAmbHQ7c25pcCZndDs8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCBQ
TUkgQ2FwYWJpbGl0eSBEZXRhaWxzPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
UE1JIHN1cHBvcnRlZCBzdGF0ZXM6IEQwIEQzaG90IEQzY29sZCAqPGJyPgomZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgUE1JIGN1cnJlbnQgc3RhdGU6IEQwPGJyPgomZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgUE1FJiMzOTtzIHN1cHBvcnRlZCBmcm9tIHN0YXRlczogRDAgRDNo
b3QgRDNjb2xkICo8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQTUUmIzM5O3Mg
YXJlIGRpc2FibGVkPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1JIGRhdGE6
IFtpZHhdIHZhbCBzY2FsZTxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIFswMF3CoCAwMMKgIDAxwqAgWzAxXcKgIC0twqAgLS3CoCBbMDJdwqAgLS3CoCAtLcKg
IFswM13CoCAwMMKgIDAxPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgWzA0XcKgIDAwwqAgMDHCoCBbMDVdwqAgLS3CoCAtLcKgIFswNl3CoCAtLcKgIC0twqAg
WzA3XcKgIDAwwqAgMDE8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBbMDhdwqAgLS3CoCAtLcKgIFswOV3CoCAtLcKgIC0twqAgWzEwXcKgIC0twqAgLS3CoCBb
MTFdwqAgLS3CoCAtLTxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIFsxMl3CoCAtLcKgIC0twqAgWzEzXcKgIC0twqAgLS3CoCBbMTRdwqAgLS3CoCAtLcKgIFsx
NV3CoCAtLcKgIC0tPGJyPgomZ3Q7IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+CiZndDs8
YnI+CiZndDsgSXQmIzM5O3MgYWxtb3N0IGxpa2UgdGhlIFFOWCBlMTAwMCBkcml2ZXIgaXMgcHV0
dGluZyB0aGUgTklDIGludG8gc29tZSBzdGF0ZSB0aGF0IEVGSSBkb2VzIG5vdCByZWNvdmVyIGZy
b20gd2hlbiB0cmFuc2l0aW9uaW5nIHRvIFM1LiBNYXliZSB0aGUgUEhZIGlzIGJlaW5nIHR1cm5l
ZCBvZmYuIElmIHRoaXMgaXMgdGhlIGNhc2UsIHRoZW4gc2hvdWxkIGNhbGxzIHRvIHRoaW5ncyBs
aWtlIF9EU1csIF9QUlcgKGFuZCBlbmFibGluZyBHUEUgaXQgcmV0dXJucyksIG9yIGV2ZW4gdGhl
IExQSSBmdW5jdGlvbiA1IHB1dCB0aGUgUEhZIGJhY2sgb24/IFRoZSBOSUMgTEVEcyBzaHV0IG9m
ZiBhdCB0aGUgc2FtZSB0aW1lIGFzIHRoZSBwb3dlciBMRUQgd2hlbiBlbnRlcmluZyBTNSBhbmQg
ZG8gbm90IGNvbWUgYmFjayBvbi48YnI+CiZndDs8YnI+CiZndDsgRm9yIExQSSBJJiMzOTttIHJl
ZmVycmluZyB0byB0aGlzOjxicj4KJmd0OyA8YSBocmVmPSJodHRwczovL3d3dy51ZWZpLm9yZy9z
aXRlcy9kZWZhdWx0L2ZpbGVzL3Jlc291cmNlcy9JbnRlbF9BQ1BJX0xvd19Qb3dlcl9TMF9JZGxl
LnBkZiIgcmVsPSJub3JlZmVycmVyIG5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczov
L3d3dy51ZWZpLm9yZy9zaXRlcy9kZWZhdWx0L2ZpbGVzL3Jlc291cmNlcy9JbnRlbF9BQ1BJX0xv
d19Qb3dlcl9TMF9JZGxlLnBkZjwvYT48YnI+CiZndDs8YnI+CiZndDsgQW55IGhlbHAgaXMgYXBw
cmVjaWF0ZWQuPGJyPgomZ3Q7PGJyPgomZ3Q7IFRoYW5rcyw8YnI+CiZndDsgRGV2aW48YnI+CiZn
dDsgX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+CiZn
dDsgRGV2ZWwgbWFpbGluZyBsaXN0IC0tIDxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eub3Jn
IiB0YXJnZXQ9Il9ibGFuayIgcmVsPSJub3JlZmVycmVyIj5kZXZlbEBhY3BpY2Eub3JnPC9hPjxi
cj4KJmd0OyBUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIDxhIGhyZWY9Im1haWx0bzpk
ZXZlbC1sZWF2ZUBhY3BpY2Eub3JnIiB0YXJnZXQ9Il9ibGFuayIgcmVsPSJub3JlZmVycmVyIj5k
ZXZlbC1sZWF2ZUBhY3BpY2Eub3JnPC9hPjxicj4KJmd0OyAlKHdlYl9wYWdlX3VybClzbGlzdGlu
Zm8lKGNnaWV4dClzLyUoX2ludGVybmFsX25hbWUpczxicj4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX188YnI+CkRldmVsIG1haWxpbmcgbGlzdCAtLSA8YSBo
cmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyIgdGFyZ2V0PSJfYmxhbmsiIHJlbD0ibm9yZWZl
cnJlciI+ZGV2ZWxAYWNwaWNhLm9yZzwvYT48YnI+ClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1h
aWwgdG8gPGEgaHJlZj0ibWFpbHRvOmRldmVsLWxlYXZlQGFjcGljYS5vcmciIHRhcmdldD0iX2Js
YW5rIiByZWw9Im5vcmVmZXJyZXIiPmRldmVsLWxlYXZlQGFjcGljYS5vcmc8L2E+PGJyPgolKHdl
Yl9wYWdlX3VybClzbGlzdGluZm8lKGNnaWV4dClzLyUoX2ludGVybmFsX25hbWUpczxicj4KPC9i
bG9ja3F1b3RlPjwvZGl2Pgo=

--===============1511162337518266881==--

