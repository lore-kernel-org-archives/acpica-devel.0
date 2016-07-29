Content-Type: multipart/mixed; boundary="===============1156744474108769666=="
MIME-Version: 1.0
From: David Renz <sun.kisses.horizon at gmail.com>
Subject: [Devel] Strange behavior of ACPI code
Date: Fri, 29 Jul 2016 17:25:34 +0200
Message-ID: <CAB=Lj3TRfo52A3Rgwp2tF+tz8ZDCy3iej4Wt+VTtsUUp7cXx+Q@mail.gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1156744474108769666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I addressed this issue before on the ACPI developers' mailing list, where I
observed a strange/suspicious behavior of my system's ACPI code in the case
of a Lenovo G710 notebook. I concluded that this might be explained by the
fact that Lenovo employs ACPI code in order to install harmless crapware on
Windows, but finally I can definitely say that this conclusion can not be
true, since the ACPI code of four different systems I'm using, which I
extracted and submitted to malwr.com, led to the same results in each case.
E. g., this is the result for the ACPI I extracted from an AMD x64 desktop
PC:
https://malwr.com/analysis/ODkxOThjOTk1MDAzNGE4M2JhOWNhNzk1ZTJjM2IyYWQ/
It shows what happens when the ACPI code gets executed on a Windows system,
and if you google some of files which get deployed or take a look at the
registry modifications being made, it should be obvious to everyone that it
compromises the system in order to gain full remote access over it and
forward its' network traffic (which I can also observe in Wireshark).
Recently someone from the Comodo support also confirmed me that my system
is compromised, but even the Comodo software itself seems to have been
gotten manipulated, so the Comodo firewall doesn't block the remote access
(they're investigating about this now).

However, this ACPI not only compromises Windows systems, but also every
Linux and BSD distro I've tested for the purpose of analysis so far. The
files in this Dropbox folder will give you only a first impression of this:
https://www.dropbox.com/sh/x6vf2fqsbqdx0k8/AACdgsdbN_UA4w2XDaob9Maia?dl=3D0
"modified_files.out" shows a list of files having been modified during the
first 10 minutes after the first boot of a freshly installed system,
dmesg.out shows various ACPI related errors and the netstat output shows
that the UDP and UDP6 ports 50988 and 47815 are open, which shouldn't be
the case normally. (Wireshark gives the same impression of traffic being
forwared like it does on Windows.)
The folder also contains the ACPI code extracted and disassembled using the
IASL code.


Would anyone be able to perform a debugging of this code in order to make
visible what its execution on a Linux system does in detail?


Thanks in advance and kind regards

David

--===============1156744474108769666==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+PGRpdj48ZGl2PjxkaXY+PGRpdj48ZGl2Pkhl
bGxvLDxicj48YnI+PC9kaXY+SSBhZGRyZXNzZWQgdGhpcyBpc3N1ZSBiZWZvcmUgb24gdGhlIEFD
UEkgZGV2ZWxvcGVycyYjMzk7IG1haWxpbmcgbGlzdCwgd2hlcmUgSSBvYnNlcnZlZCBhIHN0cmFu
Z2Uvc3VzcGljaW91cyBiZWhhdmlvciBvZiBteSBzeXN0ZW0mIzM5O3MgQUNQSSBjb2RlIGluIHRo
ZSBjYXNlIG9mIGEgTGVub3ZvIEc3MTAgbm90ZWJvb2suIEkgY29uY2x1ZGVkIHRoYXQgdGhpcyBt
aWdodCBiZSBleHBsYWluZWQgYnkgdGhlIGZhY3QgdGhhdCBMZW5vdm8gZW1wbG95cyBBQ1BJIGNv
ZGUgaW4gb3JkZXIgdG8gaW5zdGFsbCBoYXJtbGVzcyBjcmFwd2FyZSBvbiBXaW5kb3dzLCBidXQg
ZmluYWxseSBJIGNhbiBkZWZpbml0ZWx5IHNheSB0aGF0IHRoaXMgY29uY2x1c2lvbiBjYW4gbm90
IGJlIHRydWUsIHNpbmNlIHRoZSBBQ1BJIGNvZGUgb2YgZm91ciBkaWZmZXJlbnQgc3lzdGVtcyBJ
JiMzOTttIHVzaW5nLCB3aGljaCBJIGV4dHJhY3RlZCBhbmQgc3VibWl0dGVkIHRvIDxhIGhyZWY9
Imh0dHA6Ly9tYWx3ci5jb20iPm1hbHdyLmNvbTwvYT4sIGxlZCB0byB0aGUgc2FtZSByZXN1bHRz
IGluIGVhY2ggY2FzZS4gRS4gZy4sIHRoaXMgaXMgdGhlIHJlc3VsdCBmb3IgdGhlIEFDUEkgSSBl
eHRyYWN0ZWQgZnJvbSBhbiBBTUQgeDY0IGRlc2t0b3AgUEM6PGJyPjxhIGhyZWY9Imh0dHBzOi8v
bWFsd3IuY29tL2FuYWx5c2lzL09Ea3hPVGhqT1RrMU1EQXpOR0U0TTJKaE9XTmhOemsxWlRKak0y
SXlZV1EvIj5odHRwczovL21hbHdyLmNvbS9hbmFseXNpcy9PRGt4T1Roak9UazFNREF6TkdFNE0y
SmhPV05oTnprMVpUSmpNMkl5WVdRLzwvYT48YnI+PC9kaXY+SXQgc2hvd3Mgd2hhdCBoYXBwZW5z
IHdoZW4gdGhlIEFDUEkgY29kZSBnZXRzIGV4ZWN1dGVkIG9uIGEgV2luZG93cyBzeXN0ZW0sIGFu
ZCBpZiB5b3UgZ29vZ2xlIHNvbWUgb2YgZmlsZXMgd2hpY2ggZ2V0IGRlcGxveWVkIG9yIHRha2Ug
YSBsb29rIGF0IHRoZSByZWdpc3RyeSBtb2RpZmljYXRpb25zIGJlaW5nIG1hZGUsIGl0IHNob3Vs
ZCBiZSBvYnZpb3VzIHRvIGV2ZXJ5b25lIHRoYXQgaXQgY29tcHJvbWlzZXMgdGhlIHN5c3RlbSBp
biBvcmRlciB0byBnYWluIGZ1bGwgcmVtb3RlIGFjY2VzcyBvdmVyIGl0IGFuZCBmb3J3YXJkIGl0
cyYjMzk7IG5ldHdvcmsgdHJhZmZpYyAod2hpY2ggSSBjYW4gYWxzbyBvYnNlcnZlIGluIFdpcmVz
aGFyaykuIFJlY2VudGx5IHNvbWVvbmUgZnJvbSB0aGUgQ29tb2RvIHN1cHBvcnQgYWxzbyBjb25m
aXJtZWQgbWUgdGhhdCBteSBzeXN0ZW0gaXMgY29tcHJvbWlzZWQsIGJ1dCBldmVuIHRoZSBDb21v
ZG8gc29mdHdhcmUgaXRzZWxmIHNlZW1zIHRvIGhhdmUgYmVlbiBnb3R0ZW4gbWFuaXB1bGF0ZWQs
IHNvIHRoZSBDb21vZG8gZmlyZXdhbGwgZG9lc24mIzM5O3QgYmxvY2sgdGhlIHJlbW90ZSBhY2Nl
c3MgKHRoZXkmIzM5O3JlIGludmVzdGlnYXRpbmcgYWJvdXQgdGhpcyBub3cpLjxicj48YnI+PC9k
aXY+SG93ZXZlciwgdGhpcyBBQ1BJIG5vdCBvbmx5IGNvbXByb21pc2VzIFdpbmRvd3Mgc3lzdGVt
cywgYnV0IGFsc28gZXZlcnkgTGludXggYW5kIEJTRCBkaXN0cm8gSSYjMzk7dmUgdGVzdGVkIGZv
ciB0aGUgcHVycG9zZSBvZiBhbmFseXNpcyBzbyBmYXIuIFRoZSBmaWxlcyBpbiB0aGlzIERyb3Bi
b3ggZm9sZGVyIHdpbGwgZ2l2ZSB5b3Ugb25seSBhIGZpcnN0IGltcHJlc3Npb24gb2YgdGhpczo8
YnI+PGEgaHJlZj0iaHR0cHM6Ly93d3cuZHJvcGJveC5jb20vc2gveDZ2ZjJmcXNicWR4MGs4L0FB
Q2Rnc2RiTl9VQTR3MlhEYW9iOU1haWE/ZGw9MCI+aHR0cHM6Ly93d3cuZHJvcGJveC5jb20vc2gv
eDZ2ZjJmcXNicWR4MGs4L0FBQ2Rnc2RiTl9VQTR3MlhEYW9iOU1haWE/ZGw9MDwvYT48YnI+PC9k
aXY+JnF1b3Q7bW9kaWZpZWRfZmlsZXMub3V0JnF1b3Q7IHNob3dzIGEgbGlzdCBvZiBmaWxlcyBo
YXZpbmcgYmVlbiBtb2RpZmllZCBkdXJpbmcgdGhlIGZpcnN0IDEwIG1pbnV0ZXMgYWZ0ZXIgdGhl
IGZpcnN0IGJvb3Qgb2YgYSBmcmVzaGx5IGluc3RhbGxlZCBzeXN0ZW0sIGRtZXNnLm91dCBzaG93
cyB2YXJpb3VzIEFDUEkgcmVsYXRlZCBlcnJvcnMgYW5kIHRoZSBuZXRzdGF0IG91dHB1dCBzaG93
cyB0aGF0IHRoZSBVRFAgYW5kIFVEUDYgcG9ydHMgNTA5ODggYW5kIDQ3ODE1IGFyZSBvcGVuLCB3
aGljaCBzaG91bGRuJiMzOTt0IGJlIHRoZSBjYXNlIG5vcm1hbGx5LiAoV2lyZXNoYXJrIGdpdmVz
IHRoZSBzYW1lIGltcHJlc3Npb24gb2YgdHJhZmZpYyBiZWluZyBmb3J3YXJlZCBsaWtlIGl0IGRv
ZXMgb24gV2luZG93cy4pPGJyPjwvZGl2PlRoZSBmb2xkZXIgYWxzbyBjb250YWlucyB0aGUgQUNQ
SSBjb2RlIGV4dHJhY3RlZCBhbmQgZGlzYXNzZW1ibGVkIHVzaW5nIHRoZSBJQVNMIGNvZGUuPGJy
Pjxicj48YnI+PC9kaXY+V291bGQgYW55b25lIGJlIGFibGUgdG8gcGVyZm9ybSBhIGRlYnVnZ2lu
ZyBvZiB0aGlzIGNvZGUgaW4gb3JkZXIgdG8gbWFrZSB2aXNpYmxlIHdoYXQgaXRzIGV4ZWN1dGlv
biBvbiBhIExpbnV4IHN5c3RlbSBkb2VzIGluIGRldGFpbD88YnI+PGJyPjxicj48L2Rpdj5UaGFu
a3MgaW4gYWR2YW5jZSBhbmQga2luZCByZWdhcmRzPGJyPjxicj48L2Rpdj5EYXZpZDxicj48YnI+
PC9kaXY+Cg==

--===============1156744474108769666==--

