Content-Type: multipart/mixed; boundary="===============3481535713692450793=="
MIME-Version: 1.0
From: David Renz <sun.kisses.horizon at gmail.com>
Subject: [Devel] Linux getting compromised by the execution of ACPI code
Date: Sun, 31 Jul 2016 14:58:43 +0200
Message-ID: <CAB=Lj3Qaaxu0NVNm7SzUfO3mAX3bb012wg57saaybJU9a92rtg@mail.gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3481535713692450793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I just posted this message on the volatility mailing list, and when
considering that the system obviously got compromised while considering the
ACPI related dmesg output (plus considering that its execution on a Windows
system is responsible for its manipulation, s. malwr.com links), I think it
is safe to assume that the execution of the ACPI code on Linux is
responsible for what shows up in the results of the various tests I
performed.

Since this should be the best place for reaching experts about ACPI code, I
can only repeat what I already said in my forwarded message: It would be
highly interesting to see how exactly the ACPI code's execution interacts
with the kernel in order to compromise the system. Maybe there's someone
who could take a look at the code extracted from my system or give me some
advice on how to perform a debugging which would be able to provide some
further information about this.


Thanks in advance and kind regards

David


---------- Forwarded message ----------
From: David Renz <sun.kisses.horizon(a)gmail.com>
Date: Sun, Jul 31, 2016 at 2:45 PM
Subject: Request for advice on how to proceed with further analysis
To: vol-users(a)volatilesystems.com


Hello,

I recently posted a message, where I asked how to create a profile which
could be used with ArchLinux, but now I just solved this by having
installed Lubuntu 16.04 (4.4.0-31-generic 64-bit), so that I was able to
analyze my system's dumped memory using the pre-built Ubuntu 16.04 image I
found on GitHub (the image I created by myself couldn't be used by
Volatility, although I definitely followed each step precisely).

The checks I performed confirmed my suspicion that my system would be
compromised, as one can see by taking a look at the results I uploaded on
GoogleDrive:
https://drive.google.com/open?id=3D0B62Y5Qk_rdbWTnNYWlJRWXpsZUE

E.g.:
linux_check_afinfo
Symbol Name                                Member
Address
------------------------------------------ ------------------------------
------------------
udplite6_seq_afinfo                        next
0xffffffff81effcc8
udplite6_seq_afinfo                        stop
0xffffffff81eff808
udplite4_seq_afinfo                        next
0xffffffff81efeac8
udplite4_seq_afinfo                        stop
0xffffffff81efbce8
udp4_seq_afinfo                            start
 0xffffffff81efae00
udp4_seq_afinfo                            stop
0xffffffff81efa3a0

linux_check_inline_kernel
Name                                             Member           Hook Type
Hook Address
------------------------------------------------ ---------------- ---------
------------------
udp4_seq_afinfo                                  stop             JMP
0x0000000000000000

[A huge number of hooks shown by linux_check_syscall]


Using the netstat plugin shows no result at all (none of the connections
shown by using the normal Linux netstat command). Neither linux_lsmod nor
linux_hidden_modules give any output as well.


I assume that my system is infected by an ACPI rootkit, which is able to
compromise both Linux and Windows systems. After having submitted the
extracted the ACPI tables' code to malwr.com, where it gets executed on a
Windows sandbox, it shows that the system gets manipulated in the following
way:
https://malwr.com/analysis/ODkxOThjOTk1MDAzNGE4M2JhOWNhNzk1ZTJjM2IyYWQ/

It might be interesting that the ACPI code of four different systems being
used by me seems to have been manipulated in the same way, since the
extracted code found on one of the other systems leads to the same result
when submitting it to malwr.com. E.g., the link above shows the result for
the analysis of ACPI code on my AMD 64-bit desktop computer (Asus-M4N68T-M
LE mainboard), while the ACPI code extracted from my Lenovo G710 notebook
leads to the same when executed on a Windows system:
https://malwr.com/analysis/MjZkOGU4Y2ZmMGM5NDQ1Njg5OTc4NTVlOTQ5NThiMmY/

I guess everyone can see that the results show how the Windows system gets
compromised for being able to monitor it and gaining remote access over it,
if you take a look at the file and registry activities (just googling some
of the file names makes that clear).

Since a Linux system running on the same machine gets compromised as well,
it would be reasonable to assume that this also takes place by the ACPI
code's execution. Taking a look at the dmesg output, which I also uploaded
on GoogleDrive, seems to confirm this assumption:
[    0.225468] ACPI: Added _OSI(Module Device)
[    0.225470] ACPI: Added _OSI(Processor Device)
[    0.225471] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.225472] ACPI: Added _OSI(Processor Aggregator Device)
[    0.227433] ACPI: Executed 1 blocks of module-level executable AML code
[    0.293448] ACPI: Interpreter enabled
[    0.293458] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State
[\_S2_] (20150930/hwxface-580)
[    0.293469] ACPI: (supports S0 S1 S3 S4 S5)
[    0.293470] ACPI: Using IOAPIC for interrupt routing
[    0.293491] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xe0000000-0xefffffff] (base 0xe0000000)
[    0.294509] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in
ACPI motherboard resources
[    0.294522] PCI: Using host bridge windows from ACPI; if necessary, use
"pci=3Dnocrs" and report a bug
[    0.298938] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.298943] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
[    0.299051] acpi PNP0A03:00: _OSC: platform does not support
[PCIeHotplug PCIeCapability]
[    0.299099] acpi PNP0A03:00: _OSC: not requesting control; platform does
not support [PCIeCapability]
[    0.299101] acpi PNP0A03:00: _OSC: OS requested [PCIeHotplug PME AER
PCIeCapability]
[    0.299103] acpi PNP0A03:00: _OSC: platform willing to grant [PME AER]
[    0.299104] acpi PNP0A03:00: _OSC failed (AE_SUPPORT); disabling ASPM
[    8.647712] ACPI Warning: SystemIO range
0x0000000000000600-0x000000000000063F conflicts with OpRegion
0x0000000000000600-0x00000000000006FF (\_SB_.PCI0.SBRG.ASOC.SMRG)
(20150930/utaddress-254)

The extracted and disassembled ACPI code of my AMD system can be downloaded
from here:
https://drive.google.com/open?id=3D0B62Y5Qk_rdbWYzhPTHhHM1RxRTg


So I would appreciate it, if anyone would have an idea on how to proceed
with a further analysis. It would be interesting, if one would be able to
see how exactly the ACPI code's execution interacts with the kernel in
order to compromise the system. And of course it would be interesting to
discover where the relevant network traffic gets forwarded to / comes in
from (for remote access), since the checks I already performed showed that
the networking structure got manipulated, so that the usage of Wireshark
etc. won't show anything.


Kind regards and thanks in advance

David

--===============3481535713692450793==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGVsbG8sPGJyPjxicj5JIGp1c3QgcG9zdGVkIHRoaXMgbWVzc2FnZSBv
biB0aGUgdm9sYXRpbGl0eSBtYWlsaW5nIGxpc3QsIGFuZCB3aGVuIGNvbnNpZGVyaW5nIHRoYXQg
dGhlIHN5c3RlbSBvYnZpb3VzbHkgZ290IGNvbXByb21pc2VkIHdoaWxlIGNvbnNpZGVyaW5nIHRo
ZSBBQ1BJIHJlbGF0ZWQgZG1lc2cgb3V0cHV0IChwbHVzIGNvbnNpZGVyaW5nIHRoYXQgaXRzIGV4
ZWN1dGlvbiBvbiBhIFdpbmRvd3Mgc3lzdGVtIGlzIHJlc3BvbnNpYmxlIGZvciBpdHMgbWFuaXB1
bGF0aW9uLCBzLiA8YSBocmVmPSJodHRwOi8vbWFsd3IuY29tIj5tYWx3ci5jb208L2E+IGxpbmtz
KSwgSSB0aGluayBpdCBpcyBzYWZlIHRvIGFzc3VtZSB0aGF0IHRoZSBleGVjdXRpb24gb2YgdGhl
IEFDUEkgY29kZSBvbiBMaW51eCBpcyByZXNwb25zaWJsZSBmb3Igd2hhdCBzaG93cyB1cCBpbiB0
aGUgcmVzdWx0cyBvZiB0aGUgdmFyaW91cyB0ZXN0cyBJIHBlcmZvcm1lZC48YnI+PGJyPlNpbmNl
IHRoaXMgc2hvdWxkIGJlIHRoZSBiZXN0IHBsYWNlIGZvciByZWFjaGluZyBleHBlcnRzIGFib3V0
IEFDUEkgY29kZSwgSSBjYW4gb25seSByZXBlYXQgd2hhdCBJIGFscmVhZHkgc2FpZCBpbiBteSBm
b3J3YXJkZWQgbWVzc2FnZTogSXQgd291bGQgYmUgaGlnaGx5IGludGVyZXN0aW5nIHRvIHNlZSBo
b3cgZXhhY3RseSB0aGUgQUNQSSBjb2RlJiMzOTtzIGV4ZWN1dGlvbiBpbnRlcmFjdHMgd2l0aCB0
aGUga2VybmVsIGluIG9yZGVyIHRvIGNvbXByb21pc2UgdGhlIHN5c3RlbS4gTWF5YmUgdGhlcmUm
IzM5O3Mgc29tZW9uZSB3aG8gY291bGQgdGFrZSBhIGxvb2sgYXQgdGhlIGNvZGUgZXh0cmFjdGVk
IGZyb20gbXkgc3lzdGVtIG9yIGdpdmUgbWUgc29tZSBhZHZpY2Ugb24gaG93IHRvIHBlcmZvcm0g
YSBkZWJ1Z2dpbmcgd2hpY2ggd291bGQgYmUgYWJsZSB0byBwcm92aWRlIHNvbWUgZnVydGhlciBp
bmZvcm1hdGlvbiBhYm91dCB0aGlzLjxicj48YnI+PGJyPlRoYW5rcyBpbiBhZHZhbmNlIGFuZCBr
aW5kIHJlZ2FyZHM8YnI+PGJyPkRhdmlkPGJyPjxicj48YnI+LS0tLS0tLS0tLSBGb3J3YXJkZWQg
bWVzc2FnZSAtLS0tLS0tLS0tPGJyPkZyb206IERhdmlkIFJlbnogJmx0OzxhIGhyZWY9Im1haWx0
bzpzdW4ua2lzc2VzLmhvcml6b25AZ21haWwuY29tIj5zdW4ua2lzc2VzLmhvcml6b25AZ21haWwu
Y29tPC9hPiZndDs8YnI+RGF0ZTogU3VuLCBKdWwgMzEsIDIwMTYgYXQgMjo0NSBQTTxicj5TdWJq
ZWN0OiBSZXF1ZXN0IGZvciBhZHZpY2Ugb24gaG93IHRvIHByb2NlZWQgd2l0aCBmdXJ0aGVyIGFu
YWx5c2lzPGJyPlRvOiA8YSBocmVmPSJtYWlsdG86dm9sLXVzZXJzQHZvbGF0aWxlc3lzdGVtcy5j
b20iPnZvbC11c2Vyc0B2b2xhdGlsZXN5c3RlbXMuY29tPC9hPjxicj48YnI+PGJyPkhlbGxvLDxi
cj48YnI+SSByZWNlbnRseSBwb3N0ZWQgYSBtZXNzYWdlLCB3aGVyZSBJIGFza2VkIGhvdyB0byBj
cmVhdGUgYSBwcm9maWxlIHdoaWNoIGNvdWxkIGJlIHVzZWQgd2l0aCBBcmNoTGludXgsIGJ1dCBu
b3cgSSBqdXN0IHNvbHZlZCB0aGlzIGJ5IGhhdmluZyBpbnN0YWxsZWQgTHVidW50dSAxNi4wNCAo
NC40LjAtMzEtZ2VuZXJpYyA2NC1iaXQpLCBzbyB0aGF0IEkgd2FzIGFibGUgdG8gYW5hbHl6ZSBt
eSBzeXN0ZW0mIzM5O3MgZHVtcGVkIG1lbW9yeSB1c2luZyB0aGUgcHJlLWJ1aWx0IFVidW50dSAx
Ni4wNCBpbWFnZSBJIGZvdW5kIG9uIEdpdEh1YiAodGhlIGltYWdlIEkgY3JlYXRlZCBieSBteXNl
bGYgY291bGRuJiMzOTt0IGJlIHVzZWQgYnkgVm9sYXRpbGl0eSwgYWx0aG91Z2ggSSBkZWZpbml0
ZWx5IGZvbGxvd2VkIGVhY2ggc3RlcCBwcmVjaXNlbHkpLjxicj48YnI+VGhlIGNoZWNrcyBJIHBl
cmZvcm1lZCBjb25maXJtZWQgbXkgc3VzcGljaW9uIHRoYXQgbXkgc3lzdGVtIHdvdWxkIGJlIGNv
bXByb21pc2VkLCBhcyBvbmUgY2FuIHNlZSBieSB0YWtpbmcgYSBsb29rIGF0IHRoZSByZXN1bHRz
IEkgdXBsb2FkZWQgb24gR29vZ2xlRHJpdmU6PGJyPjxhIGhyZWY9Imh0dHBzOi8vZHJpdmUuZ29v
Z2xlLmNvbS9vcGVuP2lkPTBCNjJZNVFrX3JkYldUbk5ZV2xKUldYcHNaVUUiPmh0dHBzOi8vZHJp
dmUuZ29vZ2xlLmNvbS9vcGVuP2lkPTBCNjJZNVFrX3JkYldUbk5ZV2xKUldYcHNaVUU8L2E+PGJy
Pjxicj5FLmcuOjxicj5saW51eF9jaGVja19hZmluZm88YnI+U3ltYm9sIE5hbWUgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBNZW1iZXIgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQWRkcmVzcyDCoCDCoCDCoCDCoCDCoDxicj4tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tIC0tLS0tLS0tLS0tLS0tLS0tLTxicj51ZHBsaXRlNl9zZXFfYWZpbmZvIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbmV4dCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAweGZmZmZmZmZmODFlZmZjYzg8YnI+dWRwbGl0ZTZfc2VxX2FmaW5m
byDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0b3AgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHhmZmZmZmZmZjgxZWZmODA4PGJyPnVkcGxpdGU0X3Nl
cV9hZmluZm8gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBuZXh0IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4ZmZmZmZmZmY4MWVmZWFjODxicj51ZHBs
aXRlNF9zZXFfYWZpbmZvIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RvcCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAweGZmZmZmZmZmODFlZmJjZTg8
YnI+dWRwNF9zZXFfYWZpbmZvIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgc3RhcnQgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAweGZmZmZmZmZm
ODFlZmFlMDA8YnI+dWRwNF9zZXFfYWZpbmZvIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgc3RvcCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAw
eGZmZmZmZmZmODFlZmEzYTA8YnI+PGJyPmxpbnV4X2NoZWNrX2lubGluZV9rZXJuZWw8YnI+TmFt
ZSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBNZW1iZXIgwqAgwqAgwqAgwqAgwqAgSG9vayBUeXBlIEhvb2sgQWRkcmVzcyDC
oCDCoCA8YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
IC0tLS0tLS0tLS0tLS0tLS0gLS0tLS0tLS0tIC0tLS0tLS0tLS0tLS0tLS0tLTxicj51ZHA0X3Nl
cV9hZmluZm8gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBzdG9wIMKgIMKgIMKgIMKgIMKgIMKgIEpNUCDCoCDCoCDCoCAweDAwMDAwMDAwMDAwMDAwMDA8
YnI+PGJyPltBIGh1Z2UgbnVtYmVyIG9mIGhvb2tzIHNob3duIGJ5IGxpbnV4X2NoZWNrX3N5c2Nh
bGxdPGJyPjxicj48YnI+VXNpbmcgdGhlIG5ldHN0YXQgcGx1Z2luIHNob3dzIG5vIHJlc3VsdCBh
dCBhbGwgKG5vbmUgb2YgdGhlIGNvbm5lY3Rpb25zIHNob3duIGJ5IHVzaW5nIHRoZSBub3JtYWwg
TGludXggbmV0c3RhdCBjb21tYW5kKS4gTmVpdGhlciBsaW51eF9sc21vZCBub3IgbGludXhfaGlk
ZGVuX21vZHVsZXMgZ2l2ZSBhbnkgb3V0cHV0IGFzIHdlbGwuPGJyPjxicj48YnI+SSBhc3N1bWUg
dGhhdCBteSBzeXN0ZW0gaXMgaW5mZWN0ZWQgYnkgYW4gQUNQSSByb290a2l0LCB3aGljaCBpcyBh
YmxlIHRvIGNvbXByb21pc2UgYm90aCBMaW51eCBhbmQgV2luZG93cyBzeXN0ZW1zLiBBZnRlciBo
YXZpbmcgc3VibWl0dGVkIHRoZSBleHRyYWN0ZWQgdGhlIEFDUEkgdGFibGVzJiMzOTsgY29kZSB0
byA8YSBocmVmPSJodHRwOi8vbWFsd3IuY29tIj5tYWx3ci5jb208L2E+LCB3aGVyZSBpdCBnZXRz
IGV4ZWN1dGVkIG9uIGEgV2luZG93cyBzYW5kYm94LCBpdCBzaG93cyB0aGF0IHRoZSBzeXN0ZW0g
Z2V0cyBtYW5pcHVsYXRlZCBpbiB0aGUgZm9sbG93aW5nIHdheTo8YnI+PGEgaHJlZj0iaHR0cHM6
Ly9tYWx3ci5jb20vYW5hbHlzaXMvT0RreE9UaGpPVGsxTURBek5HRTRNMkpoT1dOaE56azFaVEpq
TTJJeVlXUS8iPmh0dHBzOi8vbWFsd3IuY29tL2FuYWx5c2lzL09Ea3hPVGhqT1RrMU1EQXpOR0U0
TTJKaE9XTmhOemsxWlRKak0ySXlZV1EvPC9hPjxicj48YnI+SXQgbWlnaHQgYmUgaW50ZXJlc3Rp
bmcgdGhhdCB0aGUgQUNQSSBjb2RlIG9mIGZvdXIgZGlmZmVyZW50IHN5c3RlbXMgYmVpbmcgdXNl
ZCBieSBtZSBzZWVtcyB0byBoYXZlIGJlZW4gbWFuaXB1bGF0ZWQgaW4gdGhlIHNhbWUgd2F5LCBz
aW5jZSB0aGUgZXh0cmFjdGVkIGNvZGUgZm91bmQgb24gb25lIG9mIHRoZSBvdGhlciBzeXN0ZW1z
IGxlYWRzIHRvIHRoZSBzYW1lIHJlc3VsdCB3aGVuIHN1Ym1pdHRpbmcgaXQgdG8gPGEgaHJlZj0i
aHR0cDovL21hbHdyLmNvbSI+bWFsd3IuY29tPC9hPi4gRS5nLiwgdGhlIGxpbmsgYWJvdmUgc2hv
d3MgdGhlIHJlc3VsdCBmb3IgdGhlIGFuYWx5c2lzIG9mIEFDUEkgY29kZSBvbiBteSBBTUQgNjQt
Yml0IGRlc2t0b3AgY29tcHV0ZXIgKEFzdXMtTTRONjhULU0gTEUgbWFpbmJvYXJkKSwgd2hpbGUg
dGhlIEFDUEkgY29kZSBleHRyYWN0ZWQgZnJvbSBteSBMZW5vdm8gRzcxMCBub3RlYm9vayBsZWFk
cyB0byB0aGUgc2FtZSB3aGVuIGV4ZWN1dGVkIG9uIGEgV2luZG93cyBzeXN0ZW06PGJyPjxhIGhy
ZWY9Imh0dHBzOi8vbWFsd3IuY29tL2FuYWx5c2lzL01qWmtPR1U0WTJabU1HTTVORFExTmpnNU9U
YzROVFZsT1RRNU5UaGlNbVkvIj5odHRwczovL21hbHdyLmNvbS9hbmFseXNpcy9NalprT0dVNFky
Wm1NR001TkRRMU5qZzVPVGM0TlRWbE9UUTVOVGhpTW1ZLzwvYT48YnI+PGJyPkkgZ3Vlc3MgZXZl
cnlvbmUgY2FuIHNlZSB0aGF0IHRoZSByZXN1bHRzIHNob3cgaG93IHRoZSBXaW5kb3dzIHN5c3Rl
bSBnZXRzIGNvbXByb21pc2VkIGZvciBiZWluZyBhYmxlIHRvIG1vbml0b3IgaXQgYW5kIGdhaW5p
bmcgcmVtb3RlIGFjY2VzcyBvdmVyIGl0LCBpZiB5b3UgdGFrZSBhIGxvb2sgYXQgdGhlIGZpbGUg
YW5kIHJlZ2lzdHJ5IGFjdGl2aXRpZXMgKGp1c3QgZ29vZ2xpbmcgc29tZSBvZiB0aGUgZmlsZSBu
YW1lcyBtYWtlcyB0aGF0IGNsZWFyKS48YnI+PGJyPlNpbmNlIGEgTGludXggc3lzdGVtIHJ1bm5p
bmcgb24gdGhlIHNhbWUgbWFjaGluZSBnZXRzIGNvbXByb21pc2VkIGFzIHdlbGwsIGl0IHdvdWxk
IGJlIHJlYXNvbmFibGUgdG8gYXNzdW1lIHRoYXQgdGhpcyBhbHNvIHRha2VzIHBsYWNlIGJ5IHRo
ZSBBQ1BJIGNvZGUmIzM5O3MgZXhlY3V0aW9uLiBUYWtpbmcgYSBsb29rIGF0IHRoZSBkbWVzZyBv
dXRwdXQsIHdoaWNoIEkgYWxzbyB1cGxvYWRlZCBvbiBHb29nbGVEcml2ZSwgc2VlbXMgdG8gY29u
ZmlybSB0aGlzIGFzc3VtcHRpb246PGJyPlsgwqAgwqAwLjIyNTQ2OF0gQUNQSTogQWRkZWQgX09T
SShNb2R1bGUgRGV2aWNlKTxicj5bIMKgIMKgMC4yMjU0NzBdIEFDUEk6IEFkZGVkIF9PU0koUHJv
Y2Vzc29yIERldmljZSk8YnI+WyDCoCDCoDAuMjI1NDcxXSBBQ1BJOiBBZGRlZCBfT1NJKDMuMCBf
U0NQIEV4dGVuc2lvbnMpPGJyPlsgwqAgwqAwLjIyNTQ3Ml0gQUNQSTogQWRkZWQgX09TSShQcm9j
ZXNzb3IgQWdncmVnYXRvciBEZXZpY2UpPGJyPlsgwqAgwqAwLjIyNzQzM10gQUNQSTogRXhlY3V0
ZWQgMSBibG9ja3Mgb2YgbW9kdWxlLWxldmVsIGV4ZWN1dGFibGUgQU1MIGNvZGU8YnI+WyDCoCDC
oDAuMjkzNDQ4XSBBQ1BJOiBJbnRlcnByZXRlciBlbmFibGVkPGJyPlsgwqAgwqAwLjI5MzQ1OF0g
QUNQSSBFeGNlcHRpb246IEFFX05PVF9GT1VORCwgV2hpbGUgZXZhbHVhdGluZyBTbGVlcCBTdGF0
ZSBbXF9TMl9dICgyMDE1MDkzMC9od3hmYWNlLTU4MCk8YnI+WyDCoCDCoDAuMjkzNDY5XSBBQ1BJ
OiAoc3VwcG9ydHMgUzAgUzEgUzMgUzQgUzUpPGJyPlsgwqAgwqAwLjI5MzQ3MF0gQUNQSTogVXNp
bmcgSU9BUElDIGZvciBpbnRlcnJ1cHQgcm91dGluZzxicj5bIMKgIMKgMC4yOTM0OTFdIFBDSTog
TU1DT05GSUcgZm9yIGRvbWFpbiAwMDAwIFtidXMgMDAtZmZdIGF0IFttZW0gMHhlMDAwMDAwMC0w
eGVmZmZmZmZmXSAoYmFzZSAweGUwMDAwMDAwKTxicj5bIMKgIMKgMC4yOTQ1MDldIFBDSTogTU1D
T05GSUcgYXQgW21lbSAweGUwMDAwMDAwLTB4ZWZmZmZmZmZdIHJlc2VydmVkIGluIEFDUEkgbW90
aGVyYm9hcmQgcmVzb3VyY2VzPGJyPlsgwqAgwqAwLjI5NDUyMl0gUENJOiBVc2luZyBob3N0IGJy
aWRnZSB3aW5kb3dzIGZyb20gQUNQSTsgaWYgbmVjZXNzYXJ5LCB1c2UgJnF1b3Q7cGNpPW5vY3Jz
JnF1b3Q7IGFuZCByZXBvcnQgYSBidWc8YnI+WyDCoCDCoDAuMjk4OTM4XSBBQ1BJOiBQQ0kgUm9v
dCBCcmlkZ2UgW1BDSTBdIChkb21haW4gMDAwMCBbYnVzIDAwLWZmXSk8YnI+WyDCoCDCoDAuMjk4
OTQzXSBhY3BpIFBOUDBBMDM6MDA6IF9PU0M6IE9TIHN1cHBvcnRzIFtFeHRlbmRlZENvbmZpZyBB
U1BNIENsb2NrUE0gU2VnbWVudHMgTVNJXTxicj5bIMKgIMKgMC4yOTkwNTFdIGFjcGkgUE5QMEEw
MzowMDogX09TQzogcGxhdGZvcm0gZG9lcyBub3Qgc3VwcG9ydCBbUENJZUhvdHBsdWcgUENJZUNh
cGFiaWxpdHldPGJyPlsgwqAgwqAwLjI5OTA5OV0gYWNwaSBQTlAwQTAzOjAwOiBfT1NDOiBub3Qg
cmVxdWVzdGluZyBjb250cm9sOyBwbGF0Zm9ybSBkb2VzIG5vdCBzdXBwb3J0IFtQQ0llQ2FwYWJp
bGl0eV08YnI+WyDCoCDCoDAuMjk5MTAxXSBhY3BpIFBOUDBBMDM6MDA6IF9PU0M6IE9TIHJlcXVl
c3RlZCBbUENJZUhvdHBsdWcgUE1FIEFFUiBQQ0llQ2FwYWJpbGl0eV08YnI+WyDCoCDCoDAuMjk5
MTAzXSBhY3BpIFBOUDBBMDM6MDA6IF9PU0M6IHBsYXRmb3JtIHdpbGxpbmcgdG8gZ3JhbnQgW1BN
RSBBRVJdPGJyPlsgwqAgwqAwLjI5OTEwNF0gYWNwaSBQTlAwQTAzOjAwOiBfT1NDIGZhaWxlZCAo
QUVfU1VQUE9SVCk7IGRpc2FibGluZyBBU1BNPGJyPlsgwqAgwqA4LjY0NzcxMl0gQUNQSSBXYXJu
aW5nOiBTeXN0ZW1JTyByYW5nZSAweDAwMDAwMDAwMDAwMDA2MDAtMHgwMDAwMDAwMDAwMDAwNjNG
IGNvbmZsaWN0cyB3aXRoIE9wUmVnaW9uIDB4MDAwMDAwMDAwMDAwMDYwMC0weDAwMDAwMDAwMDAw
MDA2RkYgKFxfU0JfLlBDSTAuU0JSRy5BU09DLlNNUkcpICgyMDE1MDkzMC91dGFkZHJlc3MtMjU0
KTxicj48YnI+VGhlIGV4dHJhY3RlZCBhbmQgZGlzYXNzZW1ibGVkIEFDUEkgY29kZSBvZiBteSBB
TUQgc3lzdGVtIGNhbiBiZSBkb3dubG9hZGVkIGZyb20gaGVyZTo8YnI+PGEgaHJlZj0iaHR0cHM6
Ly9kcml2ZS5nb29nbGUuY29tL29wZW4/aWQ9MEI2Mlk1UWtfcmRiV1l6aFBUSGhITTFSeFJUZyI+
aHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL29wZW4/aWQ9MEI2Mlk1UWtfcmRiV1l6aFBUSGhITTFS
eFJUZzwvYT48YnI+PGJyPjxicj5TbyBJIHdvdWxkIGFwcHJlY2lhdGUgaXQsIGlmIGFueW9uZSB3
b3VsZCBoYXZlIGFuIGlkZWEgb24gaG93IHRvIHByb2NlZWQgd2l0aCBhIGZ1cnRoZXIgYW5hbHlz
aXMuIEl0IHdvdWxkIGJlIGludGVyZXN0aW5nLCBpZiBvbmUgd291bGQgYmUgYWJsZSB0byBzZWUg
aG93IGV4YWN0bHkgdGhlIEFDUEkgY29kZSYjMzk7cyBleGVjdXRpb24gaW50ZXJhY3RzIHdpdGgg
dGhlIGtlcm5lbCBpbiBvcmRlciB0byBjb21wcm9taXNlIHRoZSBzeXN0ZW0uIEFuZCBvZiBjb3Vy
c2UgaXQgd291bGQgYmUgaW50ZXJlc3RpbmcgdG8gZGlzY292ZXIgd2hlcmUgdGhlIHJlbGV2YW50
IG5ldHdvcmsgdHJhZmZpYyBnZXRzIGZvcndhcmRlZCB0byAvIGNvbWVzIGluIGZyb20gKGZvciBy
ZW1vdGUgYWNjZXNzKSwgc2luY2UgdGhlIGNoZWNrcyBJIGFscmVhZHkgcGVyZm9ybWVkIHNob3dl
ZCB0aGF0IHRoZSBuZXR3b3JraW5nIHN0cnVjdHVyZSBnb3QgbWFuaXB1bGF0ZWQsIHNvIHRoYXQg
dGhlIHVzYWdlIG9mIFdpcmVzaGFyayBldGMuIHdvbiYjMzk7dCBzaG93IGFueXRoaW5nLjxicj48
YnI+PGJyPktpbmQgcmVnYXJkcyBhbmQgdGhhbmtzIGluIGFkdmFuY2U8YnI+PGJyPkRhdmlkPGJy
Pjxicj48L2Rpdj4K

--===============3481535713692450793==--

