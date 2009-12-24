Content-Type: multipart/mixed; boundary="===============8267494108877836705=="
MIME-Version: 1.0
From: nisha jain <jain61 at gmail.com>
Subject: Re: [Devel] Regarding ACPI library
Date: Thu, 24 Dec 2009 15:06:24 -0600
Message-ID: <6b4365880912241306y4769ad85mb8e6564587063d14@mail.gmail.com>
In-Reply-To: alpine.LFD.2.00.0912241507390.4159@localhost.localdomain
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8267494108877836705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Len,

Thanks, I have tried using the PowerTop application and modified to see it
for dual core but i am not able to get the proper results (c state
information for second core is not proper) also I have found through the
PowerTop developers that the application is not suitable for full load power
measurement. I am not quite sure what does the idle mode means though i
think it means that no user level applications are running. I am not able to
further use the PowerTop as it doesn't provide mechanism for changing the
processor state by user and I guess there are only few utilities for doing
frequency scaling like cpfreq-set utility, I need to develop customized
utility. I would like to know how I can develop my own utility using ACPI if
it is feasible? Also if any specific development environment is required to
do so?

Thanks and Regards,
Nisha


On Thu, Dec 24, 2009 at 2:16 PM, Len Brown <lenb(a)kernel.org> wrote:

> On Wed, 23 Dec 2009, nisha jain wrote:
>
> > Hi All,
> >
> > I am working on research related to Power management and control for
> single and multiprocessors and I came across ACPI standard. I want
> > to get all CPU power information (c state and frequency p state
> information) for different applications and kernel processes running
> > into system (with load).  I went through user manual of the ACPI and as
> per my understaning there is some information written by the
> > ACPI HW/SW module and ACPI is already a part of most Linux kernels.I we=
nt
> through all the acpi site but there is no sample program to
> > show its usage also i have installed the UNIX Format Source Code and
> Build Environment and  UNIX Format Test Suite of the ACPI and
> > successfully compiled it. I am not sure how and which acpi APIs needs to
> be called to get such information and how to install the ACPI
> > library...Also I want to control CPU frquency and state not sure how to
> achieve it using ACPI library?
> >
> > I am using an environment with Intel Dual Core Tm processor and Ubuntu
> platform.
>
> Hi Nisha,
> ACPI is an interface between the hardware and the OS,
> not an interface between the kernel and user-space.
>
> So generally the ACPICA core is hidden inside the kernel
> and not directly visible to user-space.
>
> So your question is really about the Linux APIs for
> user-space utilities to get to the stuff that is
> implemented by ACPI.
>
> On Linux, we endeavor to expose ACPI directly to application layer
> only for debugging hooks -- eg the old /proc/acpi/*
> and the new /sys/firmware/acpi/*
>
> In general, we try to have generic policy code that doesn't
> directly know if ACPI is involved in the underlying implementation.
> For example, cpufreq abstracts ACPI P-states, cpuidle
> abstracts ACPI C-states, thermal abstracts ACPI thermal & T-states,
> power supply abstracts ACPI battery etc.
>
> Note that the powertop application is available in most recent distros
> to grab and summarize a lot of what you may be seeking.
> It looks in /sys/devices/system/cpu/* for cpufreq and cpuidle info.
>
> cheers,
> -Len Brown
> Intel Open Source Technology Center
>

--===============8267494108877836705==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgTGVuLDxicj48YnI+VGhhbmtzLCBJIGhhdmUgdHJpZWQgdXNpbmcgdGhlIFBvd2VyVG9wIGFw
cGxpY2F0aW9uIGFuZCBtb2RpZmllZCB0byBzZWUgaXQgZm9yIGR1YWwgY29yZSBidXQgaSBhbSBu
b3QgYWJsZSB0byBnZXQgdGhlIHByb3BlciByZXN1bHRzIChjIHN0YXRlIGluZm9ybWF0aW9uIGZv
ciBzZWNvbmQgY29yZSBpcyBub3QgcHJvcGVyKSBhbHNvIEkgaGF2ZSBmb3VuZCB0aHJvdWdoIHRo
ZSBQb3dlclRvcCBkZXZlbG9wZXJzIHRoYXQgdGhlIGFwcGxpY2F0aW9uIGlzIG5vdCBzdWl0YWJs
ZSBmb3IgZnVsbCBsb2FkIHBvd2VyIG1lYXN1cmVtZW50LiBJIGFtIG5vdCBxdWl0ZSBzdXJlIHdo
YXQgZG9lcyB0aGUgaWRsZSBtb2RlIG1lYW5zIHRob3VnaCBpIHRoaW5rIGl0IG1lYW5zIHRoYXQg
bm8gdXNlciBsZXZlbCBhcHBsaWNhdGlvbnMgYXJlIHJ1bm5pbmcuIEkgYW0gbm90IGFibGUgdG8g
ZnVydGhlciB1c2UgdGhlIFBvd2VyVG9wIGFzIGl0IGRvZXNuJiMzOTt0IHByb3ZpZGUgbWVjaGFu
aXNtIGZvciBjaGFuZ2luZyB0aGUgcHJvY2Vzc29yIHN0YXRlIGJ5IHVzZXIgYW5kIEkgZ3Vlc3Mg
dGhlcmUgYXJlIG9ubHkgZmV3IHV0aWxpdGllcyBmb3IgZG9pbmcgZnJlcXVlbmN5IHNjYWxpbmcg
bGlrZSBjcGZyZXEtc2V0IHV0aWxpdHksIEkgbmVlZCB0byBkZXZlbG9wIGN1c3RvbWl6ZWQgdXRp
bGl0eS4gSSB3b3VsZCBsaWtlIHRvIGtub3cgaG93IEkgY2FuIGRldmVsb3AgbXkgb3duIHV0aWxp
dHkgdXNpbmcgQUNQSSBpZiBpdCBpcyBmZWFzaWJsZT8gQWxzbyBpZiBhbnkgc3BlY2lmaWMgZGV2
ZWxvcG1lbnQgZW52aXJvbm1lbnQgaXMgcmVxdWlyZWQgdG8gZG8gc28/IDxicj4KPGJyPlRoYW5r
cyBhbmQgUmVnYXJkcyw8YnI+TmlzaGE8YnI+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90
ZSI+T24gVGh1LCBEZWMgMjQsIDIwMDkgYXQgMjoxNiBQTSwgTGVuIEJyb3duIDxzcGFuIGRpcj0i
bHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmxlbmJAa2VybmVsLm9yZyI+bGVuYkBrZXJuZWwub3Jn
PC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUi
IHN0eWxlPSJib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgbWFyZ2lu
OiAwcHQgMHB0IDBwdCAwLjhleDsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4KPGRpdj48ZGl2PjwvZGl2
PjxkaXYgY2xhc3M9Img1Ij5PbiBXZWQsIDIzIERlYyAyMDA5LCBuaXNoYSBqYWluIHdyb3RlOjxi
cj4KPGJyPgomZ3Q7IEhpIEFsbCw8YnI+CiZndDs8YnI+CiZndDsgSSBhbSB3b3JraW5nIG9uIHJl
c2VhcmNoIHJlbGF0ZWQgdG8gUG93ZXIgbWFuYWdlbWVudCBhbmQgY29udHJvbCBmb3Igc2luZ2xl
IGFuZCBtdWx0aXByb2Nlc3NvcnMgYW5kIEkgY2FtZSBhY3Jvc3MgQUNQSSBzdGFuZGFyZC4gSSB3
YW50PGJyPgomZ3Q7IHRvIGdldCBhbGwgQ1BVIHBvd2VyIGluZm9ybWF0aW9uIChjIHN0YXRlIGFu
ZCBmcmVxdWVuY3kgcCBzdGF0ZSBpbmZvcm1hdGlvbikgZm9yIGRpZmZlcmVudCBhcHBsaWNhdGlv
bnMgYW5kIGtlcm5lbCBwcm9jZXNzZXMgcnVubmluZzxicj4KJmd0OyBpbnRvIHN5c3RlbSAod2l0
aCBsb2FkKS6gIEkgd2VudCB0aHJvdWdoIHVzZXIgbWFudWFsIG9mIHRoZSBBQ1BJIGFuZCBhcyBw
ZXIgbXkgdW5kZXJzdGFuaW5nIHRoZXJlIGlzIHNvbWUgaW5mb3JtYXRpb24gd3JpdHRlbiBieSB0
aGU8YnI+CiZndDsgQUNQSSBIVy9TVyBtb2R1bGUgYW5kIEFDUEkgaXMgYWxyZWFkeSBhIHBhcnQg
b2YgbW9zdCBMaW51eCBrZXJuZWxzLkkgd2VudCB0aHJvdWdoIGFsbCB0aGUgYWNwaSBzaXRlIGJ1
dCB0aGVyZSBpcyBubyBzYW1wbGUgcHJvZ3JhbSB0bzxicj4KJmd0OyBzaG93IGl0cyB1c2FnZSBh
bHNvIGkgaGF2ZSBpbnN0YWxsZWQgdGhlIFVOSVggRm9ybWF0IFNvdXJjZSBDb2RlIGFuZCBCdWls
ZCBFbnZpcm9ubWVudCBhbmSgIFVOSVggRm9ybWF0IFRlc3QgU3VpdGUgb2YgdGhlIEFDUEkgYW5k
PGJyPgomZ3Q7IHN1Y2Nlc3NmdWxseSBjb21waWxlZCBpdC4gSSBhbSBub3Qgc3VyZSBob3cgYW5k
IHdoaWNoIGFjcGkgQVBJcyBuZWVkcyB0byBiZSBjYWxsZWQgdG8gZ2V0IHN1Y2ggaW5mb3JtYXRp
b24gYW5kIGhvdyB0byBpbnN0YWxsIHRoZSBBQ1BJPGJyPgomZ3Q7IGxpYnJhcnkuLi5BbHNvIEkg
d2FudCB0byBjb250cm9sIENQVSBmcnF1ZW5jeSBhbmQgc3RhdGUgbm90IHN1cmUgaG93IHRvIGFj
aGlldmUgaXQgdXNpbmcgQUNQSSBsaWJyYXJ5Pzxicj4KJmd0Ozxicj4KJmd0OyBJIGFtIHVzaW5n
IGFuIGVudmlyb25tZW50IHdpdGggSW50ZWwgRHVhbCBDb3JlIFRtIHByb2Nlc3NvciBhbmQgVWJ1
bnR1IHBsYXRmb3JtLjxicj4KPGJyPgo8L2Rpdj48L2Rpdj5IaSBOaXNoYSw8YnI+CkFDUEkgaXMg
YW4gaW50ZXJmYWNlIGJldHdlZW4gdGhlIGhhcmR3YXJlIGFuZCB0aGUgT1MsPGJyPgpub3QgYW4g
aW50ZXJmYWNlIGJldHdlZW4gdGhlIGtlcm5lbCBhbmQgdXNlci1zcGFjZS48YnI+Cjxicj4KU28g
Z2VuZXJhbGx5IHRoZSBBQ1BJQ0EgY29yZSBpcyBoaWRkZW4gaW5zaWRlIHRoZSBrZXJuZWw8YnI+
CmFuZCBub3QgZGlyZWN0bHkgdmlzaWJsZSB0byB1c2VyLXNwYWNlLjxicj4KPGJyPgpTbyB5b3Vy
IHF1ZXN0aW9uIGlzIHJlYWxseSBhYm91dCB0aGUgTGludXggQVBJcyBmb3I8YnI+CnVzZXItc3Bh
Y2UgdXRpbGl0aWVzIHRvIGdldCB0byB0aGUgc3R1ZmYgdGhhdCBpczxicj4KaW1wbGVtZW50ZWQg
YnkgQUNQSS48YnI+Cjxicj4KT24gTGludXgsIHdlIGVuZGVhdm9yIHRvIGV4cG9zZSBBQ1BJIGRp
cmVjdGx5IHRvIGFwcGxpY2F0aW9uIGxheWVyPGJyPgpvbmx5IGZvciBkZWJ1Z2dpbmcgaG9va3Mg
LS0gZWcgdGhlIG9sZCAvcHJvYy9hY3BpLyo8YnI+CmFuZCB0aGUgbmV3IC9zeXMvZmlybXdhcmUv
YWNwaS8qPGJyPgo8YnI+CkluIGdlbmVyYWwsIHdlIHRyeSB0byBoYXZlIGdlbmVyaWMgcG9saWN5
IGNvZGUgdGhhdCBkb2VzbiYjMzk7dDxicj4KZGlyZWN0bHkga25vdyBpZiBBQ1BJIGlzIGludm9s
dmVkIGluIHRoZSB1bmRlcmx5aW5nIGltcGxlbWVudGF0aW9uLjxicj4KRm9yIGV4YW1wbGUsIGNw
dWZyZXEgYWJzdHJhY3RzIEFDUEkgUC1zdGF0ZXMsIGNwdWlkbGU8YnI+CmFic3RyYWN0cyBBQ1BJ
IEMtc3RhdGVzLCB0aGVybWFsIGFic3RyYWN0cyBBQ1BJIHRoZXJtYWwgJmFtcDsgVC1zdGF0ZXMs
PGJyPgpwb3dlciBzdXBwbHkgYWJzdHJhY3RzIEFDUEkgYmF0dGVyeSBldGMuPGJyPgo8YnI+Ck5v
dGUgdGhhdCB0aGUgcG93ZXJ0b3AgYXBwbGljYXRpb24gaXMgYXZhaWxhYmxlIGluIG1vc3QgcmVj
ZW50IGRpc3Ryb3M8YnI+CnRvIGdyYWIgYW5kIHN1bW1hcml6ZSBhIGxvdCBvZiB3aGF0IHlvdSBt
YXkgYmUgc2Vla2luZy48YnI+Ckl0IGxvb2tzIGluIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1Lyog
Zm9yIGNwdWZyZXEgYW5kIGNwdWlkbGUgaW5mby48YnI+Cjxicj4KY2hlZXJzLDxicj4KPGZvbnQg
Y29sb3I9IiM4ODg4ODgiPi1MZW4gQnJvd248YnI+CkludGVsIE9wZW4gU291cmNlIFRlY2hub2xv
Z3kgQ2VudGVyPGJyPgo8L2ZvbnQ+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj4K

--===============8267494108877836705==--

