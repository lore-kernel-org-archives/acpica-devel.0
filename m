Content-Type: multipart/mixed; boundary="===============8625590348505304644=="
MIME-Version: 1.0
From: David Renz <sun.kisses.horizon at gmail.com>
Subject: [Devel] Executation of manipulated ACPI code results in compromising
 any OS
Date: Fri, 24 Mar 2017 03:35:44 +0100
Message-ID: <CAB=Lj3Q9VuDNnhS9PrrbcC20vp9Y+_hK8CNN+oyDwBE7LER39g@mail.gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8625590348505304644==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

maybe some of you can still remember me, since I posted in this mailing
list previously - The relevant postings are:

1)
https://lists.acpica.org/pipermail/devel/2016-August/000945.html

2)
https://lists.acpica.org/pipermail/devel/2015-November/000847.html


At that time I extracted the ACPI code from my Lenovo G710 notebook using
the Windows tool "Read&Write Everything", which I then submitted to
malwr.com. On that site the ACPI code gets executed on a virtualized Cuckoo
Sandbox, afterwards one can see in every detail which numberous effects
this execution resulted in:

https://malwr.com/analysis/ODkxOThjOTk1MDAzNGE4M2JhOWNhNzk1ZTJjM2IyYWQ/

I assume that I'm talking with people who have a decent understanding of
IT-related things, so it almost feels like an insult to me that I have to
exaplain the results of this thorough analysis:
1) "Summery" --> "Files" shows which files are deployed after the ACPI got
executed. Just do some googling on some of these files and draw your own
conclusions.

2) "Summary" --> "Registry Keys" shows (among other things) how an Inprox
server is set up, how security policy changes are made for obvious reasons
and other measurements for carrying through illegitimate data
transfer/enabling remote access. To give only two examples: "
Interface\{85CB6900-4D95-11CF-960C-0080C7F4EE85}\ProxyStubClsid32",
"HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Installer\Use=
rData\S-1-5-18\Components\6EA7B711503001246845051536B6A26B".
The latter one enables remote access, you might want to have a screenshot
at these hidden registry entries found by GMER:

http://pasteboard.co/N6dOjItFG.png

This misterious user "S-5-18" doesn't appear there, but he appears at
another system log (I can take a screenshot if this as well if required).

3) The section "Summery" --> "Mutexes" telling which mutexes were created
after the ACPI code's execution hopefully don't need any further
explanation.

The extracted ACPI code from my Lenovo G710 can be downloaded from malwr.com
after registering there for free, if anyone would like to check this by
himself.


Now for me (at the present point of time) it's really interesting to read
what Mr. Robert Moore, Senior ACPI developer at Intel, had to say regarding
all this:
https://lists.acpica.org/pipermail/devel/2015-November/000847.html

> I just remembered something about Lenovo machines using one of the ACPI
> tables to install =E2=80=9Cunwanted software=E2=80=9D. If you delete the =
files, they just
> keep coming back."
[...]
> I don=E2=80=99t think they know what they are talking about. [referring to
malwr.com - anyone who would like to visit their site may feel free to
judge whether these people know what they are talking about (well, what
they are testing in a very sophisticated manner to be concrete)]
[...]
> I don=E2=80=99t know all of the windows internals, but what exactly makes=
 you
> think that this stuff is related to ACPI?

Well, let me think... Maybe it could be related to ACPI, because all what
malwr.com did was to have the extracted ACPI code be executed in a
sandboxed environment to show which modifications this leads to (which
means total a compromise of a Windows system)?

[...]

> I just remembered something about Lenovo machines using one of the ACPI
> tables to install =E2=80=9Cunwanted software=E2=80=9D. If you delete the =
files, they just
> keep coming back.

Ok, so this time I extracted the ACPI code from a completely different
system (a desktop PC based on an MSI Z97 PC Mate mainboard) - And guess
what? The results are EXACTLY the same:

https://malwr.com/analysis/MGJiYjFlZmExYWY3NGYwZGE0YmIzNWU5YTdmNDc2YTY/


From my personal point of view I can't understand at all why Mr. Moore
wrote these comments full of 'non-competent statements' ("what exactly
makes you think that this stuff is related to ACPI?")?


The download links from my previous postings are dead now, but I will soon
uploaded the disassembled ACPI code, share the link and also describe how
the exection of this code compromised any Linux system as well.


Kind regards

--===============8625590348505304644==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+PGRpdj5IZWxsbyw8YnI+PGJyPm1heWJlIHNv
bWUgb2YgeW91IGNhbiBzdGlsbCByZW1lbWJlciBtZSwgc2luY2UgSSBwb3N0ZWQgaW4gdGhpcyBt
YWlsaW5nIGxpc3QgcHJldmlvdXNseSAtIFRoZSByZWxldmFudCBwb3N0aW5ncyBhcmU6PGJyPjxi
cj4xKTxicj48YSBocmVmPSJodHRwczovL2xpc3RzLmFjcGljYS5vcmcvcGlwZXJtYWlsL2RldmVs
LzIwMTYtQXVndXN0LzAwMDk0NS5odG1sIj5odHRwczovL2xpc3RzLmFjcGljYS5vcmcvcGlwZXJt
YWlsL2RldmVsLzIwMTYtQXVndXN0LzAwMDk0NS5odG1sPC9hPjxicj48YnI+Mik8YnI+PGEgaHJl
Zj0iaHR0cHM6Ly9saXN0cy5hY3BpY2Eub3JnL3BpcGVybWFpbC9kZXZlbC8yMDE1LU5vdmVtYmVy
LzAwMDg0Ny5odG1sIj5odHRwczovL2xpc3RzLmFjcGljYS5vcmcvcGlwZXJtYWlsL2RldmVsLzIw
MTUtTm92ZW1iZXIvMDAwODQ3Lmh0bWw8L2E+PGJyPjxicj48YnI+QXQgdGhhdCB0aW1lIEkgZXh0
cmFjdGVkIHRoZSBBQ1BJIGNvZGUgZnJvbSBteSBMZW5vdm8gRzcxMCBub3RlYm9vayB1c2luZyB0
aGUgV2luZG93cyB0b29sICZxdW90O1JlYWQmYW1wO1dyaXRlIEV2ZXJ5dGhpbmcmcXVvdDssIHdo
aWNoIEkgdGhlbiBzdWJtaXR0ZWQgdG8gPGEgaHJlZj0iaHR0cDovL21hbHdyLmNvbSI+bWFsd3Iu
Y29tPC9hPi4gT24gdGhhdCBzaXRlIHRoZSBBQ1BJIGNvZGUgZ2V0cyBleGVjdXRlZCBvbiBhIHZp
cnR1YWxpemVkIEN1Y2tvbyBTYW5kYm94LCBhZnRlcndhcmRzIG9uZSBjYW4gc2VlIGluIGV2ZXJ5
IGRldGFpbCB3aGljaCBudW1iZXJvdXMgZWZmZWN0cyB0aGlzIGV4ZWN1dGlvbiByZXN1bHRlZCBp
bjo8YnI+PGJyPjxhIGhyZWY9Imh0dHBzOi8vbWFsd3IuY29tL2FuYWx5c2lzL09Ea3hPVGhqT1Rr
MU1EQXpOR0U0TTJKaE9XTmhOemsxWlRKak0ySXlZV1EvIj5odHRwczovL21hbHdyLmNvbS9hbmFs
eXNpcy9PRGt4T1Roak9UazFNREF6TkdFNE0ySmhPV05oTnprMVpUSmpNMkl5WVdRLzwvYT48YnI+
PGJyPkkgYXNzdW1lIHRoYXQgSSYjMzk7bSB0YWxraW5nIHdpdGggcGVvcGxlIHdobyBoYXZlIGEg
ZGVjZW50IHVuZGVyc3RhbmRpbmcgb2YgSVQtcmVsYXRlZCB0aGluZ3MsIHNvIGl0IGFsbW9zdCBm
ZWVscyBsaWtlIGFuIGluc3VsdCB0byBtZSB0aGF0IEkgaGF2ZSB0byBleGFwbGFpbiB0aGUgcmVz
dWx0cyBvZiB0aGlzIHRob3JvdWdoIGFuYWx5c2lzOjxicj4xKSAmcXVvdDtTdW1tZXJ5JnF1b3Q7
IC0tJmd0OyAmcXVvdDtGaWxlcyZxdW90OyBzaG93cyB3aGljaCBmaWxlcyBhcmUgZGVwbG95ZWQg
YWZ0ZXIgdGhlIEFDUEkgZ290IGV4ZWN1dGVkLiBKdXN0IGRvIHNvbWUgZ29vZ2xpbmcgb24gc29t
ZSBvZiB0aGVzZSBmaWxlcyBhbmQgZHJhdyB5b3VyIG93biBjb25jbHVzaW9ucy48YnI+PGJyPjIp
ICZxdW90O1N1bW1hcnkmcXVvdDsgLS0mZ3Q7ICZxdW90O1JlZ2lzdHJ5IEtleXMmcXVvdDsgc2hv
d3MgKGFtb25nIG90aGVyIHRoaW5ncykgaG93IGFuIElucHJveCBzZXJ2ZXIgaXMgc2V0IHVwLCBo
b3cgc2VjdXJpdHkgcG9saWN5IGNoYW5nZXMgYXJlIG1hZGUgZm9yIG9idmlvdXMgcmVhc29ucyBh
bmQgb3RoZXIgbWVhc3VyZW1lbnRzIGZvciBjYXJyeWluZyB0aHJvdWdoIGlsbGVnaXRpbWF0ZSBk
YXRhIHRyYW5zZmVyL2VuYWJsaW5nIHJlbW90ZSBhY2Nlc3MuIFRvIGdpdmUgb25seSB0d28gZXhh
bXBsZXM6ICZxdW90OyBJbnRlcmZhY2Vcezg1Q0I2OTAwLTREOTUtMTFDRi05NjBDLTAwODBDN0Y0
RUU4NX1cUHJveHlTdHViQ2xzaWQzMiZxdW90OywgJnF1b3Q7SEtFWV9MT0NBTF9NQUNISU5FXFNv
ZnR3YXJlXE1pY3Jvc29mdFxXaW5kb3dzXEN1cnJlbnRWZXJzaW9uXEluc3RhbGxlclxVc2VyRGF0
YVxTLTEtNS0xOFxDb21wb25lbnRzXDZFQTdCNzExNTAzMDAxMjQ2ODQ1MDUxNTM2QjZBMjZCJnF1
b3Q7LiBUaGUgbGF0dGVyIG9uZSBlbmFibGVzIHJlbW90ZSBhY2Nlc3MsIHlvdSBtaWdodCB3YW50
IHRvIGhhdmUgYSBzY3JlZW5zaG90IGF0IHRoZXNlIGhpZGRlbiByZWdpc3RyeSBlbnRyaWVzIGZv
dW5kIGJ5IEdNRVI6PGJyPjxicj48YSBocmVmPSJodHRwOi8vcGFzdGVib2FyZC5jby9ONmRPakl0
RkcucG5nIj5odHRwOi8vcGFzdGVib2FyZC5jby9ONmRPakl0RkcucG5nPC9hPjxicj48YnI+VGhp
cyBtaXN0ZXJpb3VzIHVzZXIgJnF1b3Q7Uy01LTE4JnF1b3Q7IGRvZXNuJiMzOTt0IGFwcGVhciB0
aGVyZSwgYnV0IGhlIGFwcGVhcnMgYXQgYW5vdGhlciBzeXN0ZW0gbG9nIChJIGNhbiB0YWtlIGEg
c2NyZWVuc2hvdCBpZiB0aGlzIGFzIHdlbGwgaWYgcmVxdWlyZWQpLjxicj48YnI+MykgVGhlIHNl
Y3Rpb24gJnF1b3Q7U3VtbWVyeSZxdW90OyAtLSZndDsgJnF1b3Q7TXV0ZXhlcyZxdW90OyB0ZWxs
aW5nIHdoaWNoIG11dGV4ZXMgd2VyZSBjcmVhdGVkIGFmdGVyIHRoZSBBQ1BJIGNvZGUmIzM5O3Mg
ZXhlY3V0aW9uIGhvcGVmdWxseSBkb24mIzM5O3QgbmVlZCBhbnkgZnVydGhlciBleHBsYW5hdGlv
bi48YnI+PGJyPlRoZSBleHRyYWN0ZWQgQUNQSSBjb2RlIGZyb20gbXkgTGVub3ZvIEc3MTAgY2Fu
IGJlIGRvd25sb2FkZWQgZnJvbSA8YSBocmVmPSJodHRwOi8vbWFsd3IuY29tIj5tYWx3ci5jb208
L2E+IGFmdGVyIHJlZ2lzdGVyaW5nIHRoZXJlIGZvciBmcmVlLCBpZiBhbnlvbmUgd291bGQgbGlr
ZSB0byBjaGVjayB0aGlzIGJ5IGhpbXNlbGYuPGJyPjxicj48YnI+Tm93IGZvciBtZSAoYXQgdGhl
IHByZXNlbnQgcG9pbnQgb2YgdGltZSkgaXQmIzM5O3MgcmVhbGx5IGludGVyZXN0aW5nIHRvIHJl
YWQgd2hhdCBNci4gUm9iZXJ0IE1vb3JlLCBTZW5pb3IgQUNQSSBkZXZlbG9wZXIgYXQgSW50ZWws
IGhhZCB0byBzYXkgcmVnYXJkaW5nIGFsbCB0aGlzOjxicj48YSBocmVmPSJodHRwczovL2xpc3Rz
LmFjcGljYS5vcmcvcGlwZXJtYWlsL2RldmVsLzIwMTUtTm92ZW1iZXIvMDAwODQ3Lmh0bWwiPmh0
dHBzOi8vbGlzdHMuYWNwaWNhLm9yZy9waXBlcm1haWwvZGV2ZWwvMjAxNS1Ob3ZlbWJlci8wMDA4
NDcuaHRtbDwvYT48YnI+PGJyPiZndDsgSSBqdXN0IHJlbWVtYmVyZWQgc29tZXRoaW5nIGFib3V0
IExlbm92byBtYWNoaW5lcyB1c2luZyBvbmUgb2YgdGhlIEFDUEk8YnI+Jmd0OyB0YWJsZXMgdG8g
aW5zdGFsbCDigJx1bndhbnRlZCBzb2Z0d2FyZeKAnS4gSWYgeW91IGRlbGV0ZSB0aGUgZmlsZXMs
IHRoZXkganVzdDxicj4mZ3Q7IGtlZXAgY29taW5nIGJhY2suJnF1b3Q7PGJyPlsuLi5dPGJyPiZn
dDsgSSBkb27igJl0IHRoaW5rIHRoZXkga25vdyB3aGF0IHRoZXkgYXJlIHRhbGtpbmcgYWJvdXQu
IFtyZWZlcnJpbmcgdG8gPGEgaHJlZj0iaHR0cDovL21hbHdyLmNvbSI+bWFsd3IuY29tPC9hPiAt
IGFueW9uZSB3aG8gd291bGQgbGlrZSB0byB2aXNpdCB0aGVpciBzaXRlIG1heSBmZWVsIGZyZWUg
dG8ganVkZ2Ugd2hldGhlciB0aGVzZSBwZW9wbGUga25vdyB3aGF0IHRoZXkgYXJlIHRhbGtpbmcg
YWJvdXQgKHdlbGwsIHdoYXQgdGhleSBhcmUgdGVzdGluZyBpbiBhIHZlcnkgc29waGlzdGljYXRl
ZCBtYW5uZXIgdG8gYmUgY29uY3JldGUpXTxicj5bLi4uXTxicj4mZ3Q7IEkgZG9u4oCZdCBrbm93
IGFsbCBvZiB0aGUgd2luZG93cyBpbnRlcm5hbHMsIGJ1dCB3aGF0IGV4YWN0bHkgbWFrZXMgeW91
PGJyPiZndDsgdGhpbmsgdGhhdCB0aGlzIHN0dWZmIGlzIHJlbGF0ZWQgdG8gQUNQST88YnI+PGJy
PldlbGwsIGxldCBtZSB0aGluay4uLiBNYXliZSBpdCBjb3VsZCBiZSByZWxhdGVkIHRvIEFDUEks
IGJlY2F1c2UgYWxsIHdoYXQgPGEgaHJlZj0iaHR0cDovL21hbHdyLmNvbSI+bWFsd3IuY29tPC9h
PiBkaWQgd2FzIHRvIGhhdmUgdGhlIGV4dHJhY3RlZCBBQ1BJIGNvZGUgYmUgZXhlY3V0ZWQgaW4g
YSBzYW5kYm94ZWQgZW52aXJvbm1lbnQgdG8gc2hvdyB3aGljaCBtb2RpZmljYXRpb25zIHRoaXMg
bGVhZHMgdG8gKHdoaWNoIG1lYW5zIHRvdGFsIGEgY29tcHJvbWlzZSBvZiBhIFdpbmRvd3Mgc3lz
dGVtKT88YnI+PGJyPlsuLi5dPGJyPjxicj4mZ3Q7IEkganVzdCByZW1lbWJlcmVkIHNvbWV0aGlu
ZyBhYm91dCBMZW5vdm8gbWFjaGluZXMgdXNpbmcgb25lIG9mIHRoZSBBQ1BJPGJyPiZndDsgdGFi
bGVzIHRvIGluc3RhbGwg4oCcdW53YW50ZWQgc29mdHdhcmXigJ0uIElmIHlvdSBkZWxldGUgdGhl
IGZpbGVzLCB0aGV5IGp1c3Q8YnI+Jmd0OyBrZWVwIGNvbWluZyBiYWNrLjxicj48YnI+PC9kaXY+
T2ssIHNvIHRoaXMgdGltZSBJIGV4dHJhY3RlZCB0aGUgQUNQSSBjb2RlIGZyb20gYSBjb21wbGV0
ZWx5IGRpZmZlcmVudCBzeXN0ZW0gKGEgZGVza3RvcCBQQyBiYXNlZCBvbiBhbiBNU0kgWjk3IFBD
IE1hdGUgbWFpbmJvYXJkKSAtIEFuZCBndWVzcyB3aGF0PyBUaGUgcmVzdWx0cyBhcmUgRVhBQ1RM
WSB0aGUgc2FtZTo8YnI+PGJyPjxhIGhyZWY9Imh0dHBzOi8vbWFsd3IuY29tL2FuYWx5c2lzL01H
SmlZakZsWm1FeFlXWTNOR1l3WkdFMFltSXpOV1U1WVRkbU5EYzJZVFkvIj5odHRwczovL21hbHdy
LmNvbS9hbmFseXNpcy9NR0ppWWpGbFptRXhZV1kzTkdZd1pHRTBZbUl6TldVNVlUZG1ORGMyWVRZ
LzwvYT48YnI+PGJyPjxicj48L2Rpdj5Gcm9tIG15IHBlcnNvbmFsIHBvaW50IG9mIHZpZXcgSSBj
YW4mIzM5O3QgdW5kZXJzdGFuZCBhdCBhbGwgd2h5IE1yLiBNb29yZSB3cm90ZSB0aGVzZSBjb21t
ZW50cyBmdWxsIG9mICYjMzk7bm9uLWNvbXBldGVudCBzdGF0ZW1lbnRzJiMzOTsgKCZxdW90O3do
YXQgZXhhY3RseSBtYWtlcyB5b3UgdGhpbmsgdGhhdCB0aGlzIHN0dWZmIGlzIHJlbGF0ZWQgdG8g
QUNQST8mcXVvdDspPzxicj48YnI+PGJyPjwvZGl2PlRoZSBkb3dubG9hZCBsaW5rcyBmcm9tIG15
IHByZXZpb3VzIHBvc3RpbmdzIGFyZSBkZWFkIG5vdywgYnV0IEkgd2lsbCBzb29uIHVwbG9hZGVk
IHRoZSBkaXNhc3NlbWJsZWQgQUNQSSBjb2RlLCBzaGFyZSB0aGUgbGluayBhbmQgYWxzbyBkZXNj
cmliZSBob3cgdGhlIGV4ZWN0aW9uIG9mIHRoaXMgY29kZSBjb21wcm9taXNlZCBhbnkgTGludXgg
c3lzdGVtIGFzIHdlbGwuPGJyPjxicj48YnI+PC9kaXY+S2luZCByZWdhcmRzPGJyPjwvZGl2Pgo=

--===============8625590348505304644==--

