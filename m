Content-Type: multipart/mixed; boundary="===============2274458936963939597=="
MIME-Version: 1.0
From: David Renz <sun.kisses.horizon at gmail.com>
Subject: Re: [Devel] Strange behavior of ACPI code
Date: Sat, 30 Jul 2016 03:44:58 +0200
Message-ID: <CAB=Lj3QvLGsqb6s6+XwsJii0=B=F1giiFo70bC8TdELHXoexCQ@mail.gmail.com>
In-Reply-To: CAB=Lj3TRfo52A3Rgwp2tF+tz8ZDCy3iej4Wt+VTtsUUp7cXx+Q@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2274458936963939597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I loaded the extracted ACPI code with acpiexec, whose initial output was
this:
"ACPI: RSDP 0x00000000006854E0 000024 (v02 Intel )
ACPI: XSDT 0x0000000000BEAA80 00003C (v00 Intel  AcpiExec 00001001 INTL
20160729)
ACPI: FACP 0x0000000000BE4E20 0000F4 (v03 061210 FACP1416 20100612 MSFT
00000097)
ACPI: DSDT 0x0000000000BDD420 0079CA (v01 A1556  A1556000 00000000 INTL
20060113)
ACPI: FACS 0x00000000006854A0 000040
ACPI: SSDT 0x0000000000BEBCC0 000DA4 (v01 A M I  POWERNOW 00000001 AMD
00000001)
Initializing General Purpose Events (GPEs):
    Initialized GPE 00 to 1F [_GPE] 4 regs on interrupt 0x9 (SCI)
    Initialized GPE 20 to 5F [_GPE] 8 regs on interrupt 0x9 (SCI)

Initializing Namespace objects:
Table [DSDT: A1556000] (id 01) - 1088 Objects with  65 Devices,  23
Regions,  360 Methods (62/298/43 Serial/Non/Cvt)
ACPI: Executed 1 blocks of module-level executable AML code
Table [SSDT: POWERNOW] (id 02) -   36 Objects with   0 Devices,   0
Regions,    0 Methods (0/0/0 Serial/Non/Cvt)
ACPI: 2 ACPI AML tables successfully acquired and loaded

Completing Region/Field/Buffer/Package initialization:
    Initialized 22/23 Regions 38/38 Fields 53/53 Buffers 117/117 Packages
(1133 nodes)
Initializing Device/Processor/Thermal objects and executing _INI/_STA
methods:
    Executed 1 _INI methods requiring 1 _STA executions (examined 73
objects)
Unexpected AE_BAD_ADDRESS from AcpiWriteBitRegister (aeexec-609)
Unexpected AE_BAD_ADDRESS from AcpiReadBitRegister (aeexec-622)
Unexpected AE_BAD_PARAMETER from AcpiInstallGpeHandler (aeexec-898)
Unexpected AE_BAD_PARAMETER from AcpiEnableGpe (aeexec-901)
Unexpected AE_BAD_PARAMETER from AcpiDisableGpe (aeexec-904)"

The full output including the methods found by it can be seen in the file
acpiexec.out, which I uploaded on GoogleDrive:
https://drive.google.com/open?id=3D0B62Y5Qk_rdbWYzhPTHhHM1RxRTg

However, although I definitely don't know enough about the ACPI system, I
guess it would in fact not be realistic to understand how this ACPI code
compromises a Linux system using acpiexec. Probably there's no other way
than debugging the kernel with ACPI debug output enabled...


On Fri, Jul 29, 2016 at 5:25 PM, David Renz <sun.kisses.horizon(a)gmail.com>
wrote:

> Hello,
>
> I addressed this issue before on the ACPI developers' mailing list, where
> I observed a strange/suspicious behavior of my system's ACPI code in the
> case of a Lenovo G710 notebook. I concluded that this might be explained =
by
> the fact that Lenovo employs ACPI code in order to install harmless
> crapware on Windows, but finally I can definitely say that this conclusion
> can not be true, since the ACPI code of four different systems I'm using,
> which I extracted and submitted to malwr.com, led to the same results in
> each case. E. g., this is the result for the ACPI I extracted from an AMD
> x64 desktop PC:
> https://malwr.com/analysis/ODkxOThjOTk1MDAzNGE4M2JhOWNhNzk1ZTJjM2IyYWQ/
> It shows what happens when the ACPI code gets executed on a Windows
> system, and if you google some of files which get deployed or take a look
> at the registry modifications being made, it should be obvious to everyone
> that it compromises the system in order to gain full remote access over it
> and forward its' network traffic (which I can also observe in Wireshark).
> Recently someone from the Comodo support also confirmed me that my system
> is compromised, but even the Comodo software itself seems to have been
> gotten manipulated, so the Comodo firewall doesn't block the remote access
> (they're investigating about this now).
>
> However, this ACPI not only compromises Windows systems, but also every
> Linux and BSD distro I've tested for the purpose of analysis so far. The
> files in this Dropbox folder will give you only a first impression of thi=
s:
> https://www.dropbox.com/sh/x6vf2fqsbqdx0k8/AACdgsdbN_UA4w2XDaob9Maia?dl=
=3D0
> "modified_files.out" shows a list of files having been modified during the
> first 10 minutes after the first boot of a freshly installed system,
> dmesg.out shows various ACPI related errors and the netstat output shows
> that the UDP and UDP6 ports 50988 and 47815 are open, which shouldn't be
> the case normally. (Wireshark gives the same impression of traffic being
> forwared like it does on Windows.)
> The folder also contains the ACPI code extracted and disassembled using
> the IASL code.
>
>
> Would anyone be able to perform a debugging of this code in order to make
> visible what its execution on a Linux system does in detail?
>
>
> Thanks in advance and kind regards
>
> David
>
>

--===============2274458936963939597==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PkkgbG9hZGVkIHRoZSBleHRyYWN0ZWQgQUNQSSBjb2Rl
IHdpdGggYWNwaWV4ZWMsIHdob3NlIGluaXRpYWwgb3V0cHV0IHdhcyB0aGlzOjxicj4mcXVvdDtB
Q1BJOiBSU0RQIDB4MDAwMDAwMDAwMDY4NTRFMCAwMDAwMjQgKHYwMiBJbnRlbCApPGJyPkFDUEk6
IFhTRFQgMHgwMDAwMDAwMDAwQkVBQTgwIDAwMDAzQyAodjAwIEludGVswqAgQWNwaUV4ZWMgMDAw
MDEwMDEgSU5UTCAyMDE2MDcyOSk8YnI+QUNQSTogRkFDUCAweDAwMDAwMDAwMDBCRTRFMjAgMDAw
MEY0ICh2MDMgMDYxMjEwIEZBQ1AxNDE2IDIwMTAwNjEyIE1TRlQgMDAwMDAwOTcpPGJyPkFDUEk6
IERTRFQgMHgwMDAwMDAwMDAwQkRENDIwIDAwNzlDQSAodjAxIEExNTU2wqAgQTE1NTYwMDAgMDAw
MDAwMDAgSU5UTCAyMDA2MDExMyk8YnI+QUNQSTogRkFDUyAweDAwMDAwMDAwMDA2ODU0QTAgMDAw
MDQwPGJyPkFDUEk6IFNTRFQgMHgwMDAwMDAwMDAwQkVCQ0MwIDAwMERBNCAodjAxIEEgTSBJwqAg
UE9XRVJOT1cgMDAwMDAwMDEgQU1EwqAgMDAwMDAwMDEpPGJyPkluaXRpYWxpemluZyBHZW5lcmFs
IFB1cnBvc2UgRXZlbnRzIChHUEVzKTo8YnI+wqDCoMKgIEluaXRpYWxpemVkIEdQRSAwMCB0byAx
RiBbX0dQRV0gNCByZWdzIG9uIGludGVycnVwdCAweDkgKFNDSSk8YnI+wqDCoMKgIEluaXRpYWxp
emVkIEdQRSAyMCB0byA1RiBbX0dQRV0gOCByZWdzIG9uIGludGVycnVwdCAweDkgKFNDSSk8YnI+
PGJyPkluaXRpYWxpemluZyBOYW1lc3BhY2Ugb2JqZWN0czo8YnI+VGFibGUgW0RTRFQ6IEExNTU2
MDAwXSAoaWQgMDEpIC0gMTA4OCBPYmplY3RzIHdpdGjCoCA2NSBEZXZpY2VzLMKgIDIzIFJlZ2lv
bnMswqAgMzYwIE1ldGhvZHMgKDYyLzI5OC80MyBTZXJpYWwvTm9uL0N2dCk8YnI+QUNQSTogRXhl
Y3V0ZWQgMSBibG9ja3Mgb2YgbW9kdWxlLWxldmVsIGV4ZWN1dGFibGUgQU1MIGNvZGU8YnI+VGFi
bGUgW1NTRFQ6IFBPV0VSTk9XXSAoaWQgMDIpIC3CoMKgIDM2IE9iamVjdHMgd2l0aMKgwqAgMCBE
ZXZpY2VzLMKgwqAgMCBSZWdpb25zLMKgwqDCoCAwIE1ldGhvZHMgKDAvMC8wIFNlcmlhbC9Ob24v
Q3Z0KTxicj5BQ1BJOiAyIEFDUEkgQU1MIHRhYmxlcyBzdWNjZXNzZnVsbHkgYWNxdWlyZWQgYW5k
IGxvYWRlZDxicj48YnI+Q29tcGxldGluZyBSZWdpb24vRmllbGQvQnVmZmVyL1BhY2thZ2UgaW5p
dGlhbGl6YXRpb246PGJyPsKgwqDCoCBJbml0aWFsaXplZCAyMi8yMyBSZWdpb25zIDM4LzM4IEZp
ZWxkcyA1My81MyBCdWZmZXJzIDExNy8xMTcgUGFja2FnZXMgKDExMzMgbm9kZXMpPGJyPkluaXRp
YWxpemluZyBEZXZpY2UvUHJvY2Vzc29yL1RoZXJtYWwgb2JqZWN0cyBhbmQgZXhlY3V0aW5nIF9J
TkkvX1NUQSBtZXRob2RzOjxicj7CoMKgwqAgRXhlY3V0ZWQgMSBfSU5JIG1ldGhvZHMgcmVxdWly
aW5nIDEgX1NUQSBleGVjdXRpb25zIChleGFtaW5lZCA3MyBvYmplY3RzKTxicj5VbmV4cGVjdGVk
IEFFX0JBRF9BRERSRVNTIGZyb20gQWNwaVdyaXRlQml0UmVnaXN0ZXIgKGFlZXhlYy02MDkpPGJy
PlVuZXhwZWN0ZWQgQUVfQkFEX0FERFJFU1MgZnJvbSBBY3BpUmVhZEJpdFJlZ2lzdGVyIChhZWV4
ZWMtNjIyKTxicj5VbmV4cGVjdGVkIEFFX0JBRF9QQVJBTUVURVIgZnJvbSBBY3BpSW5zdGFsbEdw
ZUhhbmRsZXIgKGFlZXhlYy04OTgpPGJyPlVuZXhwZWN0ZWQgQUVfQkFEX1BBUkFNRVRFUiBmcm9t
IEFjcGlFbmFibGVHcGUgKGFlZXhlYy05MDEpPGJyPlVuZXhwZWN0ZWQgQUVfQkFEX1BBUkFNRVRF
UiBmcm9tIEFjcGlEaXNhYmxlR3BlIChhZWV4ZWMtOTA0KSZxdW90Ozxicj48YnI+PC9kaXY+VGhl
IGZ1bGwgb3V0cHV0IGluY2x1ZGluZyB0aGUgbWV0aG9kcyBmb3VuZCBieSBpdCBjYW4gYmUgc2Vl
biBpbiB0aGUgZmlsZSBhY3BpZXhlYy5vdXQsIHdoaWNoIEkgdXBsb2FkZWQgb24gR29vZ2xlRHJp
dmU6PGJyPjxhIGhyZWY9Imh0dHBzOi8vZHJpdmUuZ29vZ2xlLmNvbS9vcGVuP2lkPTBCNjJZNVFr
X3JkYldZemhQVEhoSE0xUnhSVGciPmh0dHBzOi8vZHJpdmUuZ29vZ2xlLmNvbS9vcGVuP2lkPTBC
NjJZNVFrX3JkYldZemhQVEhoSE0xUnhSVGc8L2E+PGJyPjxicj48L2Rpdj5Ib3dldmVyLCBhbHRo
b3VnaCBJIGRlZmluaXRlbHkgZG9uJiMzOTt0IGtub3cgZW5vdWdoIGFib3V0IHRoZSBBQ1BJIHN5
c3RlbSwgSSBndWVzcyBpdCB3b3VsZCBpbiBmYWN0IG5vdCBiZSByZWFsaXN0aWMgdG8gdW5kZXJz
dGFuZCBob3cgdGhpcyBBQ1BJIGNvZGUgY29tcHJvbWlzZXMgYSBMaW51eCBzeXN0ZW0gdXNpbmcg
YWNwaWV4ZWMuIFByb2JhYmx5IHRoZXJlJiMzOTtzIG5vIG90aGVyIHdheSB0aGFuIGRlYnVnZ2lu
ZyB0aGUga2VybmVsIHdpdGggQUNQSSBkZWJ1ZyBvdXRwdXQgZW5hYmxlZC4uLjxicj48YnI+PC9k
aXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+
T24gRnJpLCBKdWwgMjksIDIwMTYgYXQgNToyNSBQTSwgRGF2aWQgUmVueiA8c3BhbiBkaXI9Imx0
ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpzdW4ua2lzc2VzLmhvcml6b25AZ21haWwuY29tIiB0YXJn
ZXQ9Il9ibGFuayI+c3VuLmtpc3Nlcy5ob3Jpem9uQGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3
cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAg
MCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRp
diBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+PGRpdj48ZGl2PjxkaXY+PGRpdj48ZGl2PkhlbGxv
LDxicj48YnI+PC9kaXY+SSBhZGRyZXNzZWQgdGhpcyBpc3N1ZSBiZWZvcmUgb24gdGhlIEFDUEkg
ZGV2ZWxvcGVycyYjMzk7IG1haWxpbmcgbGlzdCwgd2hlcmUgSSBvYnNlcnZlZCBhIHN0cmFuZ2Uv
c3VzcGljaW91cyBiZWhhdmlvciBvZiBteSBzeXN0ZW0mIzM5O3MgQUNQSSBjb2RlIGluIHRoZSBj
YXNlIG9mIGEgTGVub3ZvIEc3MTAgbm90ZWJvb2suIEkgY29uY2x1ZGVkIHRoYXQgdGhpcyBtaWdo
dCBiZSBleHBsYWluZWQgYnkgdGhlIGZhY3QgdGhhdCBMZW5vdm8gZW1wbG95cyBBQ1BJIGNvZGUg
aW4gb3JkZXIgdG8gaW5zdGFsbCBoYXJtbGVzcyBjcmFwd2FyZSBvbiBXaW5kb3dzLCBidXQgZmlu
YWxseSBJIGNhbiBkZWZpbml0ZWx5IHNheSB0aGF0IHRoaXMgY29uY2x1c2lvbiBjYW4gbm90IGJl
IHRydWUsIHNpbmNlIHRoZSBBQ1BJIGNvZGUgb2YgZm91ciBkaWZmZXJlbnQgc3lzdGVtcyBJJiMz
OTttIHVzaW5nLCB3aGljaCBJIGV4dHJhY3RlZCBhbmQgc3VibWl0dGVkIHRvIDxhIGhyZWY9Imh0
dHA6Ly9tYWx3ci5jb20iIHRhcmdldD0iX2JsYW5rIj5tYWx3ci5jb208L2E+LCBsZWQgdG8gdGhl
IHNhbWUgcmVzdWx0cyBpbiBlYWNoIGNhc2UuIEUuIGcuLCB0aGlzIGlzIHRoZSByZXN1bHQgZm9y
IHRoZSBBQ1BJIEkgZXh0cmFjdGVkIGZyb20gYW4gQU1EIHg2NCBkZXNrdG9wIFBDOjxicj48YSBo
cmVmPSJodHRwczovL21hbHdyLmNvbS9hbmFseXNpcy9PRGt4T1Roak9UazFNREF6TkdFNE0ySmhP
V05oTnprMVpUSmpNMkl5WVdRLyIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vbWFsd3IuY29tL2Fu
YWx5c2lzL09Ea3hPVGhqT1RrMU1EQXpOR0U0TTJKaE9XTmhOemsxWlRKak0ySXlZV1EvPC9hPjxi
cj48L2Rpdj5JdCBzaG93cyB3aGF0IGhhcHBlbnMgd2hlbiB0aGUgQUNQSSBjb2RlIGdldHMgZXhl
Y3V0ZWQgb24gYSBXaW5kb3dzIHN5c3RlbSwgYW5kIGlmIHlvdSBnb29nbGUgc29tZSBvZiBmaWxl
cyB3aGljaCBnZXQgZGVwbG95ZWQgb3IgdGFrZSBhIGxvb2sgYXQgdGhlIHJlZ2lzdHJ5IG1vZGlm
aWNhdGlvbnMgYmVpbmcgbWFkZSwgaXQgc2hvdWxkIGJlIG9idmlvdXMgdG8gZXZlcnlvbmUgdGhh
dCBpdCBjb21wcm9taXNlcyB0aGUgc3lzdGVtIGluIG9yZGVyIHRvIGdhaW4gZnVsbCByZW1vdGUg
YWNjZXNzIG92ZXIgaXQgYW5kIGZvcndhcmQgaXRzJiMzOTsgbmV0d29yayB0cmFmZmljICh3aGlj
aCBJIGNhbiBhbHNvIG9ic2VydmUgaW4gV2lyZXNoYXJrKS4gUmVjZW50bHkgc29tZW9uZSBmcm9t
IHRoZSBDb21vZG8gc3VwcG9ydCBhbHNvIGNvbmZpcm1lZCBtZSB0aGF0IG15IHN5c3RlbSBpcyBj
b21wcm9taXNlZCwgYnV0IGV2ZW4gdGhlIENvbW9kbyBzb2Z0d2FyZSBpdHNlbGYgc2VlbXMgdG8g
aGF2ZSBiZWVuIGdvdHRlbiBtYW5pcHVsYXRlZCwgc28gdGhlIENvbW9kbyBmaXJld2FsbCBkb2Vz
biYjMzk7dCBibG9jayB0aGUgcmVtb3RlIGFjY2VzcyAodGhleSYjMzk7cmUgaW52ZXN0aWdhdGlu
ZyBhYm91dCB0aGlzIG5vdykuPGJyPjxicj48L2Rpdj5Ib3dldmVyLCB0aGlzIEFDUEkgbm90IG9u
bHkgY29tcHJvbWlzZXMgV2luZG93cyBzeXN0ZW1zLCBidXQgYWxzbyBldmVyeSBMaW51eCBhbmQg
QlNEIGRpc3RybyBJJiMzOTt2ZSB0ZXN0ZWQgZm9yIHRoZSBwdXJwb3NlIG9mIGFuYWx5c2lzIHNv
IGZhci4gVGhlIGZpbGVzIGluIHRoaXMgRHJvcGJveCBmb2xkZXIgd2lsbCBnaXZlIHlvdSBvbmx5
IGEgZmlyc3QgaW1wcmVzc2lvbiBvZiB0aGlzOjxicj48YSBocmVmPSJodHRwczovL3d3dy5kcm9w
Ym94LmNvbS9zaC94NnZmMmZxc2JxZHgwazgvQUFDZGdzZGJOX1VBNHcyWERhb2I5TWFpYT9kbD0w
IiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cuZHJvcGJveC5jb20vc2gveDZ2ZjJmcXNicWR4
MGs4L0FBQ2Rnc2RiTl9VQTR3MlhEYW9iOU1haWE/ZGw9MDwvYT48YnI+PC9kaXY+JnF1b3Q7bW9k
aWZpZWRfZmlsZXMub3V0JnF1b3Q7IHNob3dzIGEgbGlzdCBvZiBmaWxlcyBoYXZpbmcgYmVlbiBt
b2RpZmllZCBkdXJpbmcgdGhlIGZpcnN0IDEwIG1pbnV0ZXMgYWZ0ZXIgdGhlIGZpcnN0IGJvb3Qg
b2YgYSBmcmVzaGx5IGluc3RhbGxlZCBzeXN0ZW0sIGRtZXNnLm91dCBzaG93cyB2YXJpb3VzIEFD
UEkgcmVsYXRlZCBlcnJvcnMgYW5kIHRoZSBuZXRzdGF0IG91dHB1dCBzaG93cyB0aGF0IHRoZSBV
RFAgYW5kIFVEUDYgcG9ydHMgNTA5ODggYW5kIDQ3ODE1IGFyZSBvcGVuLCB3aGljaCBzaG91bGRu
JiMzOTt0IGJlIHRoZSBjYXNlIG5vcm1hbGx5LiAoV2lyZXNoYXJrIGdpdmVzIHRoZSBzYW1lIGlt
cHJlc3Npb24gb2YgdHJhZmZpYyBiZWluZyBmb3J3YXJlZCBsaWtlIGl0IGRvZXMgb24gV2luZG93
cy4pPGJyPjwvZGl2PlRoZSBmb2xkZXIgYWxzbyBjb250YWlucyB0aGUgQUNQSSBjb2RlIGV4dHJh
Y3RlZCBhbmQgZGlzYXNzZW1ibGVkIHVzaW5nIHRoZSBJQVNMIGNvZGUuPGJyPjxicj48YnI+PC9k
aXY+V291bGQgYW55b25lIGJlIGFibGUgdG8gcGVyZm9ybSBhIGRlYnVnZ2luZyBvZiB0aGlzIGNv
ZGUgaW4gb3JkZXIgdG8gbWFrZSB2aXNpYmxlIHdoYXQgaXRzIGV4ZWN1dGlvbiBvbiBhIExpbnV4
IHN5c3RlbSBkb2VzIGluIGRldGFpbD88YnI+PGJyPjxicj48L2Rpdj5UaGFua3MgaW4gYWR2YW5j
ZSBhbmQga2luZCByZWdhcmRzPHNwYW4gY2xhc3M9IkhPRW5aYiI+PGZvbnQgY29sb3I9IiM4ODg4
ODgiPjxicj48YnI+PC9mb250Pjwvc3Bhbj48L2Rpdj48c3BhbiBjbGFzcz0iSE9FblpiIj48Zm9u
dCBjb2xvcj0iIzg4ODg4OCI+RGF2aWQ8YnI+PGJyPjwvZm9udD48L3NwYW4+PC9kaXY+CjwvYmxv
Y2txdW90ZT48L2Rpdj48YnI+PC9kaXY+Cg==

--===============2274458936963939597==--

