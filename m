Content-Type: multipart/mixed; boundary="===============6133963140580054076=="
MIME-Version: 1.0
From: Will Miles <wmiles at sgl.com>
Subject: [Devel] Re: Wake On LAN steps for QNX from S5
Date: Thu, 15 Oct 2020 09:19:52 -0400
Message-ID: <2a69f79d-cfaa-8a90-b6d8-3fdc784fc144@sgl.com>
In-Reply-To: CAAuRk_g7GM8uGrbGYsA7WChyD37=-dAGjZ6YegryiFfYfEkgww@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6133963140580054076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Devin,

Glad to hear it worked for you!=C2=A0=C2=A0 I honestly don't know if there'=
s an =

ACPI procedure for configuring the WUC state, but I doubt it -- I would =

expect that sort of feature to be managed by the operating system's =

hardware drivers.=C2=A0=C2=A0 I didn't spend too much time studying the x86=
 BIOS =

standards, though; my requirement was to implement a hardware enumerator =

for legacy PC devices such as serial ports for QNX 6.6, we didn't need =

to dig in to power management much.=C2=A0=C2=A0 I just happened to have a c=
opy of =

the QNX 6.6 e1000 driver sources on hand and thought you'd be interested =

to know that WUC was explicitly disabled there.=C2=A0=C2=A0 If anything, I =
expect =

you'll find that the drivers have overridden the state set by the BIOS, =

and so the BIOS expects that this feature is already enabled.

If you really want to be certain, you could try decompiling the ACPI =

tables on your target board, identify the ethernet device, and walk =

through all the function bytecode looking for relevant register =

operations.=C2=A0 I did this once to patch up the power management procedur=
es =

for an old laptop with switchable graphics to find out how to address =

the LCD panel switch; it had been tied to ACPI power management calls to =

power up and down the discrete graphics chip, and unfortunately that =

approach was not supported by the chip vendor's graphics drivers after =

2011.=C2=A0 It's a bit of a chore but it can be done.

Sorry I can't be of more help,

-Will

On 10/15/2020 7:30 AM, Devin Steffler wrote:
> Hi Will,
>
> Just wanted to confirm that setting the WUC bits did the trick. I'm =

> guessing that there's no way to do that from ACPICA, correct?
>
> Thanks,
> Devin
>
>
> On Wed, Oct 14, 2020 at 6:18 PM Devin Steffler =

> <devinsteffler(a)gmail.com <mailto:devinsteffler(a)gmail.com>> wrote:
>
>     Hi Will,
>
>     I think you hit the nail on the head. I just found out about the
>     WUC register as well via various online searches.
>
>     I am going to give that a shot and let you know.
>
>     If it is due to WUC bits, then do you know if there is a way to
>     toggle that programmatically with ACPICA in an agnostic way?
>     Otherwise I have a feeling I'll need to write lots of code for
>     different chipsets and it would not be very future proof. This
>     applies for different vendors as well (although QNX is really just
>     Intel, Realtek or ASIX).
>
>     Many thanks for your email.
>
>     Devin
>
>
>     On Wed, Oct 14, 2020, 1:15 PM Will Miles <wmiles(a)sgl.com
>     <mailto:wmiles(a)sgl.com>> wrote:
>
>         Hi Devin,
>
>         I did some of the initial porting work to compile ACPICA for
>         use in QNX
>         userspace.=C2=A0=C2=A0 I'm glad to hear you've had some success w=
ith it!
>
>         I can't speak for current revisions; but at least as far as
>         the BSP
>         supplied with QNX 6.6, QNX's e1000 driver explicitly disables
>         wake-on-LAN when loaded by writing to the wakeup control (WUC)
>         register
>         on the device.=C2=A0=C2=A0 My recommendation would be to get a co=
py of the
>         datasheet for your device
>         (http://www.intel.com/content/www/us/en/embedded/products/network=
ing/ethernet-connection-i219-datasheet.html
>         <http://www.intel.com/content/www/us/en/embedded/products/network=
ing/ethernet-connection-i219-datasheet.html>
>
>         ?) and then, as part of your shutdown routine, explicitly
>         terminate the
>         QNX network drivers and then manually re-enable APM wakeup by
>         directly
>         interacting with the ethernet device registers.
>
>         Hope this is of some help,
>
>         -Will
>
>         On 10/14/2020 12:02 PM, devinsteffler(a)gmail.com
>         <mailto:devinsteffler(a)gmail.com> wrote:
>         > Hello,
>         >
>         > I raised a case with QNX about this last week but I haven't
>         heard back from them yet. In the meantime, I'm wondering if
>         the kind folks at ACPICA might be able to help with this. I'm
>         hoping that I'm not missing anything obvious.
>         >
>         > I'm using an Intel based x86_64 PC with QNX on it (an Intel
>         NUC NUC7i5DNB to be precise). QNX does not have ACPI support
>         built-in. As an example, QNX does not have a way to read
>         battery status or power down (soft off, S5) an x86 based PC.
>         >
>         > So I'm making my own ACPI driver for QNX based off of the
>         ACPICA code base. I've done this previously with success for
>         reading AC power/battery information on laptops using things
>         like _PSR from a ACPI0003 device as well as _STA, _BIF, and
>         _BST from PNP0C0A devices.
>         >
>         > Now I would like to try and get Wake On LAN working from a
>         soft off (S5) state.
>         >
>         > I'm able to enter S5 via the following code:
>         > -----------------------------------------------
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0AcpiEnterSleepStatePrep(5);
>         >
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0// disable interrupts, optional?
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0ThreadCtl( _NTO_TCTL_IO, 0 );
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0InterruptDisable();
>         >
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0AcpiEnterSleepState(5);
>         > -----------------------------------------------
>         >
>         > Unfortunately, when I enter S5 using that code, then Wake On
>         LAN no longer works when powered off. Although as you'll see
>         below, Wake On LAN no longer works if I go to S5 after having
>         used the QNX e1000 driver. If I don't use the e1000 driver
>         then Wake On LAN works. Although, I need the QNX e1000 driver
>         to have networking when running.
>         >
>         > I've made the following observations:
>         > - When I boot my device with Linux and power it off using
>         software, then I'm able to Wake On LAN just fine.
>         >=C2=A0 =C2=A0 - in this case, the NIC LEDs blink while powered o=
ff
>         > - If I boot into QNX and hold the power button for 10
>         seconds or so, it powers off and Wake On LAN works (whether
>         the QNX e1000 driver is loaded or not).
>         >=C2=A0 =C2=A0 - in this case, the NIC LEDs blink while powered o=
ff
>         > - If I boot into QNX and use software (the code above) to
>         power down, then Wake On LAN does not work.
>         >=C2=A0 =C2=A0 - in this case, the NIC LEDs remain off while powe=
red off
>         > - If I boot into QNX but do not start their networking stack
>         (or their e1000 driver) and use software (the code above) to
>         power down, then Wake On LAN does work.
>         >=C2=A0 =C2=A0 - in this case, the NIC LEDs blink while powered o=
ff
>         (they momentarily stop blinking, but then blink again shortly
>         afterwards)
>         >
>         > QNX has a pci-tool (similar to Linux's lspci tool). I can
>         use it to see the following:
>         >
>         -----------------------------------------------------------------=
-----------------
>         > # pci-tool -vvvv -d0:31:6
>         >
>         > B000:D31:F06 @ idx 0
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vid/did: 8086/156f
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I=
ntel Corporation, <device id - unknown>
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 class/subclass/reg: 02/00/00
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 E=
thernet Network Controller
>         > <snip>
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PMI Capability Details
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 P=
MI supported states: D0 D3hot D3cold *
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 P=
MI current state: D0
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 P=
ME's supported from states: D0 D3hot D3cold *
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 P=
ME's are disabled
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 P=
MI data: [idx] val scale
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [00]=C2=A0 00=C2=A0 01=C2=A0 [01]=C2=A0 --=C2=
=A0 -- [02]=C2=A0
>         --=C2=A0 --=C2=A0 [03]=C2=A0 00=C2=A0 01
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [04]=C2=A0 00=C2=A0 01=C2=A0 [05]=C2=A0 --=C2=
=A0 -- [06]=C2=A0
>         --=C2=A0 --=C2=A0 [07]=C2=A0 00=C2=A0 01
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [08]=C2=A0 --=C2=A0 --=C2=A0 [09]=C2=A0 --=C2=
=A0 -- [10]=C2=A0
>         --=C2=A0 --=C2=A0 [11]=C2=A0 --=C2=A0 --
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [12]=C2=A0 --=C2=A0 --=C2=A0 [13]=C2=A0 --=C2=
=A0 -- [14]=C2=A0
>         --=C2=A0 --=C2=A0 [15]=C2=A0 --=C2=A0 --
>         >
>         -----------------------------------------------------------------=
-----------------
>         >
>         > I can use this method in ACPI to get "PME's are enabled" output:
>         > \_SB.PCI0.GLAN._DSW
>         >
>         > i.e.
>         >
>         -----------------------------------------------------------------=
-----------------
>         > # pci-tool -vvvv -d0:31:6
>         >
>         > B000:D31:F06 @ idx 0
>         > <snip>
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PMI Capability Details
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 P=
MI supported states: D0 D3hot D3cold *
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 P=
MI current state: D0
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 P=
ME's supported from states: D0 D3hot D3cold *
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 P=
ME's are enabled
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 P=
MI data: [idx] val scale
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [00]=C2=A0 00=C2=A0 01=C2=A0 [01]=C2=A0 --=C2=
=A0 -- [02]=C2=A0
>         --=C2=A0 --=C2=A0 [03]=C2=A0 00=C2=A0 01
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [04]=C2=A0 00=C2=A0 01=C2=A0 [05]=C2=A0 --=C2=
=A0 -- [06]=C2=A0
>         --=C2=A0 --=C2=A0 [07]=C2=A0 00=C2=A0 01
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [08]=C2=A0 --=C2=A0 --=C2=A0 [09]=C2=A0 --=C2=
=A0 -- [10]=C2=A0
>         --=C2=A0 --=C2=A0 [11]=C2=A0 --=C2=A0 --
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [12]=C2=A0 --=C2=A0 --=C2=A0 [13]=C2=A0 --=C2=
=A0 -- [14]=C2=A0
>         --=C2=A0 --=C2=A0 [15]=C2=A0 --=C2=A0 --
>         >
>         -----------------------------------------------------------------=
-----------------
>         >
>         > Although that doesn't help.
>         >
>         > Do I need to get the PMI current state to be D3hot prior to
>         entering S5 in order for Wake On LAN to work?
>         >
>         > However, I noticed that if I boot without the QNX e1000
>         driver, then Wake On LAN works by just going to S5 alone,
>         without _DSW. In this case:
>         >
>         -----------------------------------------------------------------=
-----------------
>         > # pci-tool -vvvv -d0:31:6
>         >
>         > B000:D31:F06 @ idx 0
>         > <snip>
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PMI Capability Details
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 P=
MI supported states: D0 D3hot D3cold *
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 P=
MI current state: D0
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 P=
ME's supported from states: D0 D3hot D3cold *
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 P=
ME's are disabled
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 P=
MI data: [idx] val scale
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [00]=C2=A0 00=C2=A0 01=C2=A0 [01]=C2=A0 --=C2=
=A0 -- [02]=C2=A0
>         --=C2=A0 --=C2=A0 [03]=C2=A0 00=C2=A0 01
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [04]=C2=A0 00=C2=A0 01=C2=A0 [05]=C2=A0 --=C2=
=A0 -- [06]=C2=A0
>         --=C2=A0 --=C2=A0 [07]=C2=A0 00=C2=A0 01
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [08]=C2=A0 --=C2=A0 --=C2=A0 [09]=C2=A0 --=C2=
=A0 -- [10]=C2=A0
>         --=C2=A0 --=C2=A0 [11]=C2=A0 --=C2=A0 --
>         >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [12]=C2=A0 --=C2=A0 --=C2=A0 [13]=C2=A0 --=C2=
=A0 -- [14]=C2=A0
>         --=C2=A0 --=C2=A0 [15]=C2=A0 --=C2=A0 --
>         >
>         -----------------------------------------------------------------=
-----------------
>         >
>         > It's almost like the QNX e1000 driver is putting the NIC
>         into some state that EFI does not recover from when
>         transitioning to S5. Maybe the PHY is being turned off. If
>         this is the case, then should calls to things like _DSW, _PRW
>         (and enabling GPE it returns), or even the LPI function 5 put
>         the PHY back on? The NIC LEDs shut off at the same time as the
>         power LED when entering S5 and do not come back on.
>         >
>         > For LPI I'm referring to this:
>         >
>         https://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low=
_Power_S0_Idle.pdf
>         <https://www.uefi.org/sites/default/files/resources/Intel_ACPI_Lo=
w_Power_S0_Idle.pdf>
>         >
>         > Any help is appreciated.
>         >
>         > Thanks,
>         > Devin
>         > _______________________________________________
>         > Devel mailing list -- devel(a)acpica.org <mailto:devel(a)acpica=
.org>
>         > To unsubscribe send an email to devel-leave(a)acpica.org
>         <mailto:devel-leave(a)acpica.org>
>         > %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
>         _______________________________________________
>         Devel mailing list -- devel(a)acpica.org <mailto:devel(a)acpica.o=
rg>
>         To unsubscribe send an email to devel-leave(a)acpica.org
>         <mailto:devel-leave(a)acpica.org>
>         %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
>

--===============6133963140580054076==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRl
bnQ9InRleHQvaHRtbDsgY2hhcnNldD1VVEYtOCI+CiAgPC9oZWFkPgogIDxib2R5PgogICAgPHA+
SGkgRGV2aW4sPC9wPgogICAgPHA+R2xhZCB0byBoZWFyIGl0IHdvcmtlZCBmb3IgeW91IcKgwqAg
SSBob25lc3RseSBkb24ndCBrbm93IGlmCiAgICAgIHRoZXJlJ3MgYW4gQUNQSSBwcm9jZWR1cmUg
Zm9yIGNvbmZpZ3VyaW5nIHRoZSBXVUMgc3RhdGUsIGJ1dCBJCiAgICAgIGRvdWJ0IGl0IC0tIEkg
d291bGQgZXhwZWN0IHRoYXQgc29ydCBvZiBmZWF0dXJlIHRvIGJlIG1hbmFnZWQgYnkKICAgICAg
dGhlIG9wZXJhdGluZyBzeXN0ZW0ncyBoYXJkd2FyZSBkcml2ZXJzLsKgwqAgSSBkaWRuJ3Qgc3Bl
bmQgdG9vIG11Y2gKICAgICAgdGltZSBzdHVkeWluZyB0aGUgeDg2IEJJT1Mgc3RhbmRhcmRzLCB0
aG91Z2g7IG15IHJlcXVpcmVtZW50IHdhcwogICAgICB0byBpbXBsZW1lbnQgYSBoYXJkd2FyZSBl
bnVtZXJhdG9yIGZvciBsZWdhY3kgUEMgZGV2aWNlcyBzdWNoIGFzCiAgICAgIHNlcmlhbCBwb3J0
cyBmb3IgUU5YIDYuNiwgd2UgZGlkbid0IG5lZWQgdG8gZGlnIGluIHRvIHBvd2VyCiAgICAgIG1h
bmFnZW1lbnQgbXVjaC7CoMKgIEkganVzdCBoYXBwZW5lZCB0byBoYXZlIGEgY29weSBvZiB0aGUg
UU5YIDYuNgogICAgICBlMTAwMCBkcml2ZXIgc291cmNlcyBvbiBoYW5kIGFuZCB0aG91Z2h0IHlv
dSdkIGJlIGludGVyZXN0ZWQgdG8KICAgICAga25vdyB0aGF0IFdVQyB3YXMgZXhwbGljaXRseSBk
aXNhYmxlZCB0aGVyZS7CoMKgIElmIGFueXRoaW5nLCBJCiAgICAgIGV4cGVjdCB5b3UnbGwgZmlu
ZCB0aGF0IHRoZSBkcml2ZXJzIGhhdmUgb3ZlcnJpZGRlbiB0aGUgc3RhdGUgc2V0CiAgICAgIGJ5
IHRoZSBCSU9TLCBhbmQgc28gdGhlIEJJT1MgZXhwZWN0cyB0aGF0IHRoaXMgZmVhdHVyZSBpcyBh
bHJlYWR5CiAgICAgIGVuYWJsZWQuPGJyPgogICAgPC9wPgogICAgPHA+SWYgeW91IHJlYWxseSB3
YW50IHRvIGJlIGNlcnRhaW4sIHlvdSBjb3VsZCB0cnkgZGVjb21waWxpbmcgdGhlCiAgICAgIEFD
UEkgdGFibGVzIG9uIHlvdXIgdGFyZ2V0IGJvYXJkLCBpZGVudGlmeSB0aGUgZXRoZXJuZXQgZGV2
aWNlLAogICAgICBhbmQgd2FsayB0aHJvdWdoIGFsbCB0aGUgZnVuY3Rpb24gYnl0ZWNvZGUgbG9v
a2luZyBmb3IgcmVsZXZhbnQKICAgICAgcmVnaXN0ZXIgb3BlcmF0aW9ucy7CoCBJIGRpZCB0aGlz
IG9uY2UgdG8gcGF0Y2ggdXAgdGhlIHBvd2VyCiAgICAgIG1hbmFnZW1lbnQgcHJvY2VkdXJlcyBm
b3IgYW4gb2xkIGxhcHRvcCB3aXRoIHN3aXRjaGFibGUgZ3JhcGhpY3MKICAgICAgdG8gZmluZCBv
dXQgaG93IHRvIGFkZHJlc3MgdGhlIExDRCBwYW5lbCBzd2l0Y2g7IGl0IGhhZCBiZWVuIHRpZWQK
ICAgICAgdG8gQUNQSSBwb3dlciBtYW5hZ2VtZW50IGNhbGxzIHRvIHBvd2VyIHVwIGFuZCBkb3du
IHRoZSBkaXNjcmV0ZQogICAgICBncmFwaGljcyBjaGlwLCBhbmQgdW5mb3J0dW5hdGVseSB0aGF0
IGFwcHJvYWNoIHdhcyBub3Qgc3VwcG9ydGVkCiAgICAgIGJ5IHRoZSBjaGlwIHZlbmRvcidzIGdy
YXBoaWNzIGRyaXZlcnMgYWZ0ZXIgMjAxMS7CoCBJdCdzIGEgYml0IG9mIGEKICAgICAgY2hvcmUg
YnV0IGl0IGNhbiBiZSBkb25lLjwvcD4KICAgIDxwPlNvcnJ5IEkgY2FuJ3QgYmUgb2YgbW9yZSBo
ZWxwLDwvcD4KICAgIDxwPi1XaWxsPGJyPgogICAgPC9wPgogICAgPGRpdiBjbGFzcz0ibW96LWNp
dGUtcHJlZml4Ij5PbiAxMC8xNS8yMDIwIDc6MzAgQU0sIERldmluIFN0ZWZmbGVyCiAgICAgIHdy
b3RlOjxicj4KICAgIDwvZGl2PgogICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIKY2l0ZT0ibWlk
OkNBQXVSa19nN0dNOHVHcmJHWXNBN1dDaHlEMzc9LWRBR2paNlllZ3J5aUZmWWZFa2d3d0BtYWls
LmdtYWlsLmNvbSI+CiAgICAgIDxtZXRhIGh0dHAtZXF1aXY9ImNvbnRlbnQtdHlwZSIgY29udGVu
dD0idGV4dC9odG1sOyBjaGFyc2V0PVVURi04Ij4KICAgICAgPGRpdiBkaXI9Imx0ciI+CiAgICAg
ICAgPGRpdj5IaSBXaWxsLDwvZGl2PgogICAgICAgIDxkaXY+PGJyPgogICAgICAgIDwvZGl2Pgog
ICAgICAgIDxkaXY+SnVzdCB3YW50ZWQgdG8gY29uZmlybSB0aGF0IHNldHRpbmcgdGhlIFdVQyBi
aXRzIGRpZCB0aGUKICAgICAgICAgIHRyaWNrLiBJJ20gZ3Vlc3NpbmcgdGhhdCB0aGVyZSdzIG5v
IHdheSB0byBkbyB0aGF0IGZyb20KICAgICAgICAgIEFDUElDQSwgY29ycmVjdD88L2Rpdj4KICAg
ICAgICA8ZGl2Pjxicj4KICAgICAgICA8L2Rpdj4KICAgICAgICA8ZGl2PlRoYW5rcyw8YnI+CiAg
ICAgICAgPC9kaXY+CiAgICAgICAgPGRpdj5EZXZpbjwvZGl2PgogICAgICAgIDxkaXY+PGJyPgog
ICAgICAgIDwvZGl2PgogICAgICA8L2Rpdj4KICAgICAgPGJyPgogICAgICA8ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+CiAgICAgICAgPGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9u
IFdlZCwgT2N0IDE0LCAyMDIwIGF0IDY6MTgKICAgICAgICAgIFBNIERldmluIFN0ZWZmbGVyICZs
dDs8YSBocmVmPSJtYWlsdG86ZGV2aW5zdGVmZmxlckBnbWFpbC5jb20iCiAgICAgICAgICAgIG1v
ei1kby1ub3Qtc2VuZD0idHJ1ZSI+ZGV2aW5zdGVmZmxlckBnbWFpbC5jb208L2E+Jmd0OwogICAg
ICAgICAgd3JvdGU6PGJyPgogICAgICAgIDwvZGl2PgogICAgICAgIDxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweAogICAgICAgICAgMC44ZXg7
Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+
CiAgICAgICAgICA8ZGl2IGRpcj0iYXV0byI+SGkgV2lsbCwKICAgICAgICAgICAgPGRpdiBkaXI9
ImF1dG8iPjxicj4KICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICAgIDxkaXYgZGlyPSJhdXRv
Ij5JIHRoaW5rIHlvdSBoaXQgdGhlIG5haWwgb24gdGhlIGhlYWQuIEkganVzdAogICAgICAgICAg
ICAgIGZvdW5kIG91dCBhYm91dCB0aGUgV1VDIHJlZ2lzdGVyIGFzIHdlbGwgdmlhIHZhcmlvdXMK
ICAgICAgICAgICAgICBvbmxpbmUgc2VhcmNoZXMuPC9kaXY+CiAgICAgICAgICAgIDxkaXYgZGly
PSJhdXRvIj48YnI+CiAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICA8ZGl2IGRpcj0iYXV0
byI+SSBhbSBnb2luZyB0byBnaXZlIHRoYXQgYSBzaG90IGFuZCBsZXQgeW91CiAgICAgICAgICAg
ICAga25vdy48L2Rpdj4KICAgICAgICAgICAgPGRpdiBkaXI9ImF1dG8iPjxicj4KICAgICAgICAg
ICAgPC9kaXY+CiAgICAgICAgICAgIDxkaXYgZGlyPSJhdXRvIj5JZiBpdCBpcyBkdWUgdG8gV1VD
IGJpdHMsIHRoZW4gZG8geW91IGtub3cKICAgICAgICAgICAgICBpZiB0aGVyZSBpcyBhIHdheSB0
byB0b2dnbGUgdGhhdCBwcm9ncmFtbWF0aWNhbGx5IHdpdGgKICAgICAgICAgICAgICBBQ1BJQ0Eg
aW4gYW4gYWdub3N0aWMgd2F5PyBPdGhlcndpc2UgSSBoYXZlIGEgZmVlbGluZyBJJ2xsCiAgICAg
ICAgICAgICAgbmVlZCB0byB3cml0ZSBsb3RzIG9mIGNvZGUgZm9yIGRpZmZlcmVudCBjaGlwc2V0
cyBhbmQgaXQKICAgICAgICAgICAgICB3b3VsZCBub3QgYmUgdmVyeSBmdXR1cmUgcHJvb2YuIFRo
aXMgYXBwbGllcyBmb3IgZGlmZmVyZW50CiAgICAgICAgICAgICAgdmVuZG9ycyBhcyB3ZWxsIChh
bHRob3VnaCBRTlggaXMgcmVhbGx5IGp1c3QgSW50ZWwsCiAgICAgICAgICAgICAgUmVhbHRlayBv
ciBBU0lYKS48L2Rpdj4KICAgICAgICAgICAgPGRpdiBkaXI9ImF1dG8iPjxicj4KICAgICAgICAg
ICAgPC9kaXY+CiAgICAgICAgICAgIDxkaXYgZGlyPSJhdXRvIj5NYW55IHRoYW5rcyBmb3IgeW91
ciBlbWFpbC48L2Rpdj4KICAgICAgICAgICAgPGRpdiBkaXI9ImF1dG8iPjxicj4KICAgICAgICAg
ICAgPC9kaXY+CiAgICAgICAgICAgIDxkaXYgZGlyPSJhdXRvIj5EZXZpbjwvZGl2PgogICAgICAg
ICAgICA8ZGl2IGRpcj0iYXV0byI+PGJyPgogICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgIDwv
ZGl2PgogICAgICAgICAgPGJyPgogICAgICAgICAgPGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPgog
ICAgICAgICAgICA8ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gV2VkLCBPY3Qg
MTQsIDIwMjAsIDE6MTUKICAgICAgICAgICAgICBQTSBXaWxsIE1pbGVzICZsdDs8YSBocmVmPSJt
YWlsdG86d21pbGVzQHNnbC5jb20iCiAgICAgICAgICAgICAgICB0YXJnZXQ9Il9ibGFuayIgbW96
LWRvLW5vdC1zZW5kPSJ0cnVlIj53bWlsZXNAc2dsLmNvbTwvYT4mZ3Q7CiAgICAgICAgICAgICAg
d3JvdGU6PGJyPgogICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgPGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4CiAgICAgICAgICAgICAg
MC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkCiAgICAgICAgICAgICAgcmdiKDIwNCwyMDQsMjA0
KTtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBEZXZpbiw8YnI+CiAgICAgICAgICAgICAgPGJyPgogICAg
ICAgICAgICAgIEkgZGlkIHNvbWUgb2YgdGhlIGluaXRpYWwgcG9ydGluZyB3b3JrIHRvIGNvbXBp
bGUgQUNQSUNBCiAgICAgICAgICAgICAgZm9yIHVzZSBpbiBRTlggPGJyPgogICAgICAgICAgICAg
IHVzZXJzcGFjZS7CoMKgIEknbSBnbGFkIHRvIGhlYXIgeW91J3ZlIGhhZCBzb21lIHN1Y2Nlc3Mg
d2l0aAogICAgICAgICAgICAgIGl0ITxicj4KICAgICAgICAgICAgICA8YnI+CiAgICAgICAgICAg
ICAgSSBjYW4ndCBzcGVhayBmb3IgY3VycmVudCByZXZpc2lvbnM7IGJ1dCBhdCBsZWFzdCBhcyBm
YXIKICAgICAgICAgICAgICBhcyB0aGUgQlNQIDxicj4KICAgICAgICAgICAgICBzdXBwbGllZCB3
aXRoIFFOWCA2LjYsIFFOWCdzIGUxMDAwIGRyaXZlciBleHBsaWNpdGx5CiAgICAgICAgICAgICAg
ZGlzYWJsZXMgPGJyPgogICAgICAgICAgICAgIHdha2Utb24tTEFOIHdoZW4gbG9hZGVkIGJ5IHdy
aXRpbmcgdG8gdGhlIHdha2V1cCBjb250cm9sCiAgICAgICAgICAgICAgKFdVQykgcmVnaXN0ZXIg
PGJyPgogICAgICAgICAgICAgIG9uIHRoZSBkZXZpY2UuwqDCoCBNeSByZWNvbW1lbmRhdGlvbiB3
b3VsZCBiZSB0byBnZXQgYSBjb3B5CiAgICAgICAgICAgICAgb2YgdGhlIDxicj4KICAgICAgICAg
ICAgICBkYXRhc2hlZXQgZm9yIHlvdXIgZGV2aWNlIDxicj4KICAgICAgICAgICAgICAoPGEKaHJl
Zj0iaHR0cDovL3d3dy5pbnRlbC5jb20vY29udGVudC93d3cvdXMvZW4vZW1iZWRkZWQvcHJvZHVj
dHMvbmV0d29ya2luZy9ldGhlcm5ldC1jb25uZWN0aW9uLWkyMTktZGF0YXNoZWV0Lmh0bWwiCiAg
ICAgICAgICAgICAgICByZWw9Im5vcmVmZXJyZXIgbm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsi
CiAgICAgICAgICAgICAgICBtb3otZG8tbm90LXNlbmQ9InRydWUiPmh0dHA6Ly93d3cuaW50ZWwu
Y29tL2NvbnRlbnQvd3d3L3VzL2VuL2VtYmVkZGVkL3Byb2R1Y3RzL25ldHdvcmtpbmcvZXRoZXJu
ZXQtY29ubmVjdGlvbi1pMjE5LWRhdGFzaGVldC5odG1sPC9hPgogICAgICAgICAgICAgIDxicj4K
ICAgICAgICAgICAgICA/KSBhbmQgdGhlbiwgYXMgcGFydCBvZiB5b3VyIHNodXRkb3duIHJvdXRp
bmUsIGV4cGxpY2l0bHkKICAgICAgICAgICAgICB0ZXJtaW5hdGUgdGhlIDxicj4KICAgICAgICAg
ICAgICBRTlggbmV0d29yayBkcml2ZXJzIGFuZCB0aGVuIG1hbnVhbGx5IHJlLWVuYWJsZSBBUE0g
d2FrZXVwCiAgICAgICAgICAgICAgYnkgZGlyZWN0bHkgPGJyPgogICAgICAgICAgICAgIGludGVy
YWN0aW5nIHdpdGggdGhlIGV0aGVybmV0IGRldmljZSByZWdpc3RlcnMuPGJyPgogICAgICAgICAg
ICAgIDxicj4KICAgICAgICAgICAgICBIb3BlIHRoaXMgaXMgb2Ygc29tZSBoZWxwLDxicj4KICAg
ICAgICAgICAgICA8YnI+CiAgICAgICAgICAgICAgLVdpbGw8YnI+CiAgICAgICAgICAgICAgPGJy
PgogICAgICAgICAgICAgIE9uIDEwLzE0LzIwMjAgMTI6MDIgUE0sIDxhCiAgICAgICAgICAgICAg
ICBocmVmPSJtYWlsdG86ZGV2aW5zdGVmZmxlckBnbWFpbC5jb20iIHJlbD0ibm9yZWZlcnJlciIK
ICAgICAgICAgICAgICAgIHRhcmdldD0iX2JsYW5rIiBtb3otZG8tbm90LXNlbmQ9InRydWUiPmRl
dmluc3RlZmZsZXJAZ21haWwuY29tPC9hPgogICAgICAgICAgICAgIHdyb3RlOjxicj4KICAgICAg
ICAgICAgICAmZ3Q7IEhlbGxvLDxicj4KICAgICAgICAgICAgICAmZ3Q7PGJyPgogICAgICAgICAg
ICAgICZndDsgSSByYWlzZWQgYSBjYXNlIHdpdGggUU5YIGFib3V0IHRoaXMgbGFzdCB3ZWVrIGJ1
dCBJCiAgICAgICAgICAgICAgaGF2ZW4ndCBoZWFyZCBiYWNrIGZyb20gdGhlbSB5ZXQuIEluIHRo
ZSBtZWFudGltZSwgSSdtCiAgICAgICAgICAgICAgd29uZGVyaW5nIGlmIHRoZSBraW5kIGZvbGtz
IGF0IEFDUElDQSBtaWdodCBiZSBhYmxlIHRvCiAgICAgICAgICAgICAgaGVscCB3aXRoIHRoaXMu
IEknbSBob3BpbmcgdGhhdCBJJ20gbm90IG1pc3NpbmcgYW55dGhpbmcKICAgICAgICAgICAgICBv
YnZpb3VzLjxicj4KICAgICAgICAgICAgICAmZ3Q7PGJyPgogICAgICAgICAgICAgICZndDsgSSdt
IHVzaW5nIGFuIEludGVsIGJhc2VkIHg4Nl82NCBQQyB3aXRoIFFOWCBvbiBpdCAoYW4KICAgICAg
ICAgICAgICBJbnRlbCBOVUMgTlVDN2k1RE5CIHRvIGJlIHByZWNpc2UpLiBRTlggZG9lcyBub3Qg
aGF2ZSBBQ1BJCiAgICAgICAgICAgICAgc3VwcG9ydCBidWlsdC1pbi4gQXMgYW4gZXhhbXBsZSwg
UU5YIGRvZXMgbm90IGhhdmUgYSB3YXkKICAgICAgICAgICAgICB0byByZWFkIGJhdHRlcnkgc3Rh
dHVzIG9yIHBvd2VyIGRvd24gKHNvZnQgb2ZmLCBTNSkgYW4geDg2CiAgICAgICAgICAgICAgYmFz
ZWQgUEMuPGJyPgogICAgICAgICAgICAgICZndDs8YnI+CiAgICAgICAgICAgICAgJmd0OyBTbyBJ
J20gbWFraW5nIG15IG93biBBQ1BJIGRyaXZlciBmb3IgUU5YIGJhc2VkIG9mZiBvZgogICAgICAg
ICAgICAgIHRoZSBBQ1BJQ0EgY29kZSBiYXNlLiBJJ3ZlIGRvbmUgdGhpcyBwcmV2aW91c2x5IHdp
dGgKICAgICAgICAgICAgICBzdWNjZXNzIGZvciByZWFkaW5nIEFDIHBvd2VyL2JhdHRlcnkgaW5m
b3JtYXRpb24gb24KICAgICAgICAgICAgICBsYXB0b3BzIHVzaW5nIHRoaW5ncyBsaWtlIF9QU1Ig
ZnJvbSBhIEFDUEkwMDAzIGRldmljZSBhcwogICAgICAgICAgICAgIHdlbGwgYXMgX1NUQSwgX0JJ
RiwgYW5kIF9CU1QgZnJvbSBQTlAwQzBBIGRldmljZXMuPGJyPgogICAgICAgICAgICAgICZndDs8
YnI+CiAgICAgICAgICAgICAgJmd0OyBOb3cgSSB3b3VsZCBsaWtlIHRvIHRyeSBhbmQgZ2V0IFdh
a2UgT24gTEFOIHdvcmtpbmcKICAgICAgICAgICAgICBmcm9tIGEgc29mdCBvZmYgKFM1KSBzdGF0
ZS48YnI+CiAgICAgICAgICAgICAgJmd0Ozxicj4KICAgICAgICAgICAgICAmZ3Q7IEknbSBhYmxl
IHRvIGVudGVyIFM1IHZpYSB0aGUgZm9sbG93aW5nIGNvZGU6PGJyPgogICAgICAgICAgICAgICZn
dDsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+CiAg
ICAgICAgICAgICAgJmd0O8KgIMKgIMKgIMKgQWNwaUVudGVyU2xlZXBTdGF0ZVByZXAoNSk7PGJy
PgogICAgICAgICAgICAgICZndDs8YnI+CiAgICAgICAgICAgICAgJmd0O8KgIMKgIMKgIMKgLy8g
ZGlzYWJsZSBpbnRlcnJ1cHRzLCBvcHRpb25hbD88YnI+CiAgICAgICAgICAgICAgJmd0O8KgIMKg
IMKgIMKgVGhyZWFkQ3RsKCBfTlRPX1RDVExfSU8sIDAgKTs8YnI+CiAgICAgICAgICAgICAgJmd0
O8KgIMKgIMKgIMKgSW50ZXJydXB0RGlzYWJsZSgpOzxicj4KICAgICAgICAgICAgICAmZ3Q7PGJy
PgogICAgICAgICAgICAgICZndDvCoCDCoCDCoCDCoEFjcGlFbnRlclNsZWVwU3RhdGUoNSk7PGJy
PgogICAgICAgICAgICAgICZndDsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS08YnI+CiAgICAgICAgICAgICAgJmd0Ozxicj4KICAgICAgICAgICAgICAmZ3Q7
IFVuZm9ydHVuYXRlbHksIHdoZW4gSSBlbnRlciBTNSB1c2luZyB0aGF0IGNvZGUsIHRoZW4KICAg
ICAgICAgICAgICBXYWtlIE9uIExBTiBubyBsb25nZXIgd29ya3Mgd2hlbiBwb3dlcmVkIG9mZi4g
QWx0aG91Z2ggYXMKICAgICAgICAgICAgICB5b3UnbGwgc2VlIGJlbG93LCBXYWtlIE9uIExBTiBu
byBsb25nZXIgd29ya3MgaWYgSSBnbyB0bwogICAgICAgICAgICAgIFM1IGFmdGVyIGhhdmluZyB1
c2VkIHRoZSBRTlggZTEwMDAgZHJpdmVyLiBJZiBJIGRvbid0IHVzZQogICAgICAgICAgICAgIHRo
ZSBlMTAwMCBkcml2ZXIgdGhlbiBXYWtlIE9uIExBTiB3b3Jrcy4gQWx0aG91Z2gsIEkgbmVlZAog
ICAgICAgICAgICAgIHRoZSBRTlggZTEwMDAgZHJpdmVyIHRvIGhhdmUgbmV0d29ya2luZyB3aGVu
IHJ1bm5pbmcuPGJyPgogICAgICAgICAgICAgICZndDs8YnI+CiAgICAgICAgICAgICAgJmd0OyBJ
J3ZlIG1hZGUgdGhlIGZvbGxvd2luZyBvYnNlcnZhdGlvbnM6PGJyPgogICAgICAgICAgICAgICZn
dDsgLSBXaGVuIEkgYm9vdCBteSBkZXZpY2Ugd2l0aCBMaW51eCBhbmQgcG93ZXIgaXQgb2ZmCiAg
ICAgICAgICAgICAgdXNpbmcgc29mdHdhcmUsIHRoZW4gSSdtIGFibGUgdG8gV2FrZSBPbiBMQU4g
anVzdCBmaW5lLjxicj4KICAgICAgICAgICAgICAmZ3Q7wqAgwqAgLSBpbiB0aGlzIGNhc2UsIHRo
ZSBOSUMgTEVEcyBibGluayB3aGlsZSBwb3dlcmVkCiAgICAgICAgICAgICAgb2ZmPGJyPgogICAg
ICAgICAgICAgICZndDsgLSBJZiBJIGJvb3QgaW50byBRTlggYW5kIGhvbGQgdGhlIHBvd2VyIGJ1
dHRvbiBmb3IgMTAKICAgICAgICAgICAgICBzZWNvbmRzIG9yIHNvLCBpdCBwb3dlcnMgb2ZmIGFu
ZCBXYWtlIE9uIExBTiB3b3JrcwogICAgICAgICAgICAgICh3aGV0aGVyIHRoZSBRTlggZTEwMDAg
ZHJpdmVyIGlzIGxvYWRlZCBvciBub3QpLjxicj4KICAgICAgICAgICAgICAmZ3Q7wqAgwqAgLSBp
biB0aGlzIGNhc2UsIHRoZSBOSUMgTEVEcyBibGluayB3aGlsZSBwb3dlcmVkCiAgICAgICAgICAg
ICAgb2ZmPGJyPgogICAgICAgICAgICAgICZndDsgLSBJZiBJIGJvb3QgaW50byBRTlggYW5kIHVz
ZSBzb2Z0d2FyZSAodGhlIGNvZGUKICAgICAgICAgICAgICBhYm92ZSkgdG8gcG93ZXIgZG93biwg
dGhlbiBXYWtlIE9uIExBTiBkb2VzIG5vdCB3b3JrLjxicj4KICAgICAgICAgICAgICAmZ3Q7wqAg
wqAgLSBpbiB0aGlzIGNhc2UsIHRoZSBOSUMgTEVEcyByZW1haW4gb2ZmIHdoaWxlCiAgICAgICAg
ICAgICAgcG93ZXJlZCBvZmY8YnI+CiAgICAgICAgICAgICAgJmd0OyAtIElmIEkgYm9vdCBpbnRv
IFFOWCBidXQgZG8gbm90IHN0YXJ0IHRoZWlyCiAgICAgICAgICAgICAgbmV0d29ya2luZyBzdGFj
ayAob3IgdGhlaXIgZTEwMDAgZHJpdmVyKSBhbmQgdXNlIHNvZnR3YXJlCiAgICAgICAgICAgICAg
KHRoZSBjb2RlIGFib3ZlKSB0byBwb3dlciBkb3duLCB0aGVuIFdha2UgT24gTEFOIGRvZXMKICAg
ICAgICAgICAgICB3b3JrLjxicj4KICAgICAgICAgICAgICAmZ3Q7wqAgwqAgLSBpbiB0aGlzIGNh
c2UsIHRoZSBOSUMgTEVEcyBibGluayB3aGlsZSBwb3dlcmVkCiAgICAgICAgICAgICAgb2ZmICh0
aGV5IG1vbWVudGFyaWx5IHN0b3AgYmxpbmtpbmcsIGJ1dCB0aGVuIGJsaW5rIGFnYWluCiAgICAg
ICAgICAgICAgc2hvcnRseSBhZnRlcndhcmRzKTxicj4KICAgICAgICAgICAgICAmZ3Q7PGJyPgog
ICAgICAgICAgICAgICZndDsgUU5YIGhhcyBhIHBjaS10b29sIChzaW1pbGFyIHRvIExpbnV4J3Mg
bHNwY2kgdG9vbCkuIEkKICAgICAgICAgICAgICBjYW4gdXNlIGl0IHRvIHNlZSB0aGUgZm9sbG93
aW5nOjxicj4KICAgICAgICAgICAgICAmZ3Q7Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+
CiAgICAgICAgICAgICAgJmd0OyAjIHBjaS10b29sIC12dnZ2IC1kMDozMTo2PGJyPgogICAgICAg
ICAgICAgICZndDs8YnI+CiAgICAgICAgICAgICAgJmd0OyBCMDAwOkQzMTpGMDYgQCBpZHggMDxi
cj4KICAgICAgICAgICAgICAmZ3Q7wqAgwqAgwqAgwqAgwqAgdmlkL2RpZDogODA4Ni8xNTZmPGJy
PgogICAgICAgICAgICAgICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJbnRlbCBDb3Jw
b3JhdGlvbiwgJmx0O2RldmljZSBpZCAtCiAgICAgICAgICAgICAgdW5rbm93biZndDs8YnI+CiAg
ICAgICAgICAgICAgJmd0O8KgIMKgIMKgIMKgIMKgIGNsYXNzL3N1YmNsYXNzL3JlZzogMDIvMDAv
MDA8YnI+CiAgICAgICAgICAgICAgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEV0aGVy
bmV0IE5ldHdvcmsgQ29udHJvbGxlcjxicj4KICAgICAgICAgICAgICAmZ3Q7ICZsdDtzbmlwJmd0
Ozxicj4KICAgICAgICAgICAgICAmZ3Q7wqAgwqAgwqAgwqAgwqAgUE1JIENhcGFiaWxpdHkgRGV0
YWlsczxicj4KICAgICAgICAgICAgICAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1J
IHN1cHBvcnRlZCBzdGF0ZXM6IEQwIEQzaG90CiAgICAgICAgICAgICAgRDNjb2xkICo8YnI+CiAg
ICAgICAgICAgICAgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBNSSBjdXJyZW50IHN0
YXRlOiBEMDxicj4KICAgICAgICAgICAgICAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
UE1FJ3Mgc3VwcG9ydGVkIGZyb20gc3RhdGVzOiBEMAogICAgICAgICAgICAgIEQzaG90IEQzY29s
ZCAqPGJyPgogICAgICAgICAgICAgICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQTUUn
cyBhcmUgZGlzYWJsZWQ8YnI+CiAgICAgICAgICAgICAgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIFBNSSBkYXRhOiBbaWR4XSB2YWwgc2NhbGU8YnI+CiAgICAgICAgICAgICAgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFswMF3CoCAwMMKgIDAxwqAgWzAx
XcKgIC0twqAgLS3CoAogICAgICAgICAgICAgIFswMl3CoCAtLcKgIC0twqAgWzAzXcKgIDAwwqAg
MDE8YnI+CiAgICAgICAgICAgICAgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIFswNF3CoCAwMMKgIDAxwqAgWzA1XcKgIC0twqAgLS3CoAogICAgICAgICAgICAgIFsw
Nl3CoCAtLcKgIC0twqAgWzA3XcKgIDAwwqAgMDE8YnI+CiAgICAgICAgICAgICAgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFswOF3CoCAtLcKgIC0twqAgWzA5XcKg
IC0twqAgLS3CoAogICAgICAgICAgICAgIFsxMF3CoCAtLcKgIC0twqAgWzExXcKgIC0twqAgLS08
YnI+CiAgICAgICAgICAgICAgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIFsxMl3CoCAtLcKgIC0twqAgWzEzXcKgIC0twqAgLS3CoAogICAgICAgICAgICAgIFsxNF3C
oCAtLcKgIC0twqAgWzE1XcKgIC0twqAgLS08YnI+CiAgICAgICAgICAgICAgJmd0OwotLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tPGJyPgogICAgICAgICAgICAgICZndDs8YnI+CiAgICAgICAgICAg
ICAgJmd0OyBJIGNhbiB1c2UgdGhpcyBtZXRob2QgaW4gQUNQSSB0byBnZXQgIlBNRSdzIGFyZQog
ICAgICAgICAgICAgIGVuYWJsZWQiIG91dHB1dDo8YnI+CiAgICAgICAgICAgICAgJmd0OyBcX1NC
LlBDSTAuR0xBTi5fRFNXPGJyPgogICAgICAgICAgICAgICZndDs8YnI+CiAgICAgICAgICAgICAg
Jmd0OyBpLmUuPGJyPgogICAgICAgICAgICAgICZndDsKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LTxicj4KICAgICAgICAgICAgICAmZ3Q7ICMgcGNpLXRvb2wgLXZ2dnYgLWQwOjMxOjY8YnI+CiAg
ICAgICAgICAgICAgJmd0Ozxicj4KICAgICAgICAgICAgICAmZ3Q7IEIwMDA6RDMxOkYwNiBAIGlk
eCAwPGJyPgogICAgICAgICAgICAgICZndDsgJmx0O3NuaXAmZ3Q7PGJyPgogICAgICAgICAgICAg
ICZndDvCoCDCoCDCoCDCoCDCoCBQTUkgQ2FwYWJpbGl0eSBEZXRhaWxzPGJyPgogICAgICAgICAg
ICAgICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQTUkgc3VwcG9ydGVkIHN0YXRlczog
RDAgRDNob3QKICAgICAgICAgICAgICBEM2NvbGQgKjxicj4KICAgICAgICAgICAgICAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1JIGN1cnJlbnQgc3RhdGU6IEQwPGJyPgogICAgICAg
ICAgICAgICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQTUUncyBzdXBwb3J0ZWQgZnJv
bSBzdGF0ZXM6IEQwCiAgICAgICAgICAgICAgRDNob3QgRDNjb2xkICo8YnI+CiAgICAgICAgICAg
ICAgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBNRSdzIGFyZSBlbmFibGVkPGJyPgog
ICAgICAgICAgICAgICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQTUkgZGF0YTogW2lk
eF0gdmFsIHNjYWxlPGJyPgogICAgICAgICAgICAgICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBbMDBdwqAgMDDCoCAwMcKgIFswMV3CoCAtLcKgIC0twqAKICAgICAg
ICAgICAgICBbMDJdwqAgLS3CoCAtLcKgIFswM13CoCAwMMKgIDAxPGJyPgogICAgICAgICAgICAg
ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBbMDRdwqAgMDDCoCAw
McKgIFswNV3CoCAtLcKgIC0twqAKICAgICAgICAgICAgICBbMDZdwqAgLS3CoCAtLcKgIFswN13C
oCAwMMKgIDAxPGJyPgogICAgICAgICAgICAgICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBbMDhdwqAgLS3CoCAtLcKgIFswOV3CoCAtLcKgIC0twqAKICAgICAgICAg
ICAgICBbMTBdwqAgLS3CoCAtLcKgIFsxMV3CoCAtLcKgIC0tPGJyPgogICAgICAgICAgICAgICZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBbMTJdwqAgLS3CoCAtLcKg
IFsxM13CoCAtLcKgIC0twqAKICAgICAgICAgICAgICBbMTRdwqAgLS3CoCAtLcKgIFsxNV3CoCAt
LcKgIC0tPGJyPgogICAgICAgICAgICAgICZndDsKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxi
cj4KICAgICAgICAgICAgICAmZ3Q7PGJyPgogICAgICAgICAgICAgICZndDsgQWx0aG91Z2ggdGhh
dCBkb2Vzbid0IGhlbHAuPGJyPgogICAgICAgICAgICAgICZndDs8YnI+CiAgICAgICAgICAgICAg
Jmd0OyBEbyBJIG5lZWQgdG8gZ2V0IHRoZSBQTUkgY3VycmVudCBzdGF0ZSB0byBiZSBEM2hvdAog
ICAgICAgICAgICAgIHByaW9yIHRvIGVudGVyaW5nIFM1IGluIG9yZGVyIGZvciBXYWtlIE9uIExB
TiB0byB3b3JrPzxicj4KICAgICAgICAgICAgICAmZ3Q7PGJyPgogICAgICAgICAgICAgICZndDsg
SG93ZXZlciwgSSBub3RpY2VkIHRoYXQgaWYgSSBib290IHdpdGhvdXQgdGhlIFFOWAogICAgICAg
ICAgICAgIGUxMDAwIGRyaXZlciwgdGhlbiBXYWtlIE9uIExBTiB3b3JrcyBieSBqdXN0IGdvaW5n
IHRvIFM1CiAgICAgICAgICAgICAgYWxvbmUsIHdpdGhvdXQgX0RTVy4gSW4gdGhpcyBjYXNlOjxi
cj4KICAgICAgICAgICAgICAmZ3Q7Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+CiAgICAg
ICAgICAgICAgJmd0OyAjIHBjaS10b29sIC12dnZ2IC1kMDozMTo2PGJyPgogICAgICAgICAgICAg
ICZndDs8YnI+CiAgICAgICAgICAgICAgJmd0OyBCMDAwOkQzMTpGMDYgQCBpZHggMDxicj4KICAg
ICAgICAgICAgICAmZ3Q7ICZsdDtzbmlwJmd0Ozxicj4KICAgICAgICAgICAgICAmZ3Q7wqAgwqAg
wqAgwqAgwqAgUE1JIENhcGFiaWxpdHkgRGV0YWlsczxicj4KICAgICAgICAgICAgICAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1JIHN1cHBvcnRlZCBzdGF0ZXM6IEQwIEQzaG90CiAg
ICAgICAgICAgICAgRDNjb2xkICo8YnI+CiAgICAgICAgICAgICAgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIFBNSSBjdXJyZW50IHN0YXRlOiBEMDxicj4KICAgICAgICAgICAgICAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1FJ3Mgc3VwcG9ydGVkIGZyb20gc3RhdGVzOiBE
MAogICAgICAgICAgICAgIEQzaG90IEQzY29sZCAqPGJyPgogICAgICAgICAgICAgICZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQTUUncyBhcmUgZGlzYWJsZWQ8YnI+CiAgICAgICAgICAg
ICAgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBNSSBkYXRhOiBbaWR4XSB2YWwgc2Nh
bGU8YnI+CiAgICAgICAgICAgICAgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIFswMF3CoCAwMMKgIDAxwqAgWzAxXcKgIC0twqAgLS3CoAogICAgICAgICAgICAgIFsw
Ml3CoCAtLcKgIC0twqAgWzAzXcKgIDAwwqAgMDE8YnI+CiAgICAgICAgICAgICAgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFswNF3CoCAwMMKgIDAxwqAgWzA1XcKg
IC0twqAgLS3CoAogICAgICAgICAgICAgIFswNl3CoCAtLcKgIC0twqAgWzA3XcKgIDAwwqAgMDE8
YnI+CiAgICAgICAgICAgICAgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIFswOF3CoCAtLcKgIC0twqAgWzA5XcKgIC0twqAgLS3CoAogICAgICAgICAgICAgIFsxMF3C
oCAtLcKgIC0twqAgWzExXcKgIC0twqAgLS08YnI+CiAgICAgICAgICAgICAgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFsxMl3CoCAtLcKgIC0twqAgWzEzXcKgIC0t
wqAgLS3CoAogICAgICAgICAgICAgIFsxNF3CoCAtLcKgIC0twqAgWzE1XcKgIC0twqAgLS08YnI+
CiAgICAgICAgICAgICAgJmd0OwotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPgogICAgICAg
ICAgICAgICZndDs8YnI+CiAgICAgICAgICAgICAgJmd0OyBJdCdzIGFsbW9zdCBsaWtlIHRoZSBR
TlggZTEwMDAgZHJpdmVyIGlzIHB1dHRpbmcgdGhlCiAgICAgICAgICAgICAgTklDIGludG8gc29t
ZSBzdGF0ZSB0aGF0IEVGSSBkb2VzIG5vdCByZWNvdmVyIGZyb20gd2hlbgogICAgICAgICAgICAg
IHRyYW5zaXRpb25pbmcgdG8gUzUuIE1heWJlIHRoZSBQSFkgaXMgYmVpbmcgdHVybmVkIG9mZi4g
SWYKICAgICAgICAgICAgICB0aGlzIGlzIHRoZSBjYXNlLCB0aGVuIHNob3VsZCBjYWxscyB0byB0
aGluZ3MgbGlrZSBfRFNXLAogICAgICAgICAgICAgIF9QUlcgKGFuZCBlbmFibGluZyBHUEUgaXQg
cmV0dXJucyksIG9yIGV2ZW4gdGhlIExQSQogICAgICAgICAgICAgIGZ1bmN0aW9uIDUgcHV0IHRo
ZSBQSFkgYmFjayBvbj8gVGhlIE5JQyBMRURzIHNodXQgb2ZmIGF0CiAgICAgICAgICAgICAgdGhl
IHNhbWUgdGltZSBhcyB0aGUgcG93ZXIgTEVEIHdoZW4gZW50ZXJpbmcgUzUgYW5kIGRvIG5vdAog
ICAgICAgICAgICAgIGNvbWUgYmFjayBvbi48YnI+CiAgICAgICAgICAgICAgJmd0Ozxicj4KICAg
ICAgICAgICAgICAmZ3Q7IEZvciBMUEkgSSdtIHJlZmVycmluZyB0byB0aGlzOjxicj4KICAgICAg
ICAgICAgICAmZ3Q7IDxhCmhyZWY9Imh0dHBzOi8vd3d3LnVlZmkub3JnL3NpdGVzL2RlZmF1bHQv
ZmlsZXMvcmVzb3VyY2VzL0ludGVsX0FDUElfTG93X1Bvd2VyX1MwX0lkbGUucGRmIgogICAgICAg
ICAgICAgICAgcmVsPSJub3JlZmVycmVyIG5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIgogICAg
ICAgICAgICAgICAgbW96LWRvLW5vdC1zZW5kPSJ0cnVlIj5odHRwczovL3d3dy51ZWZpLm9yZy9z
aXRlcy9kZWZhdWx0L2ZpbGVzL3Jlc291cmNlcy9JbnRlbF9BQ1BJX0xvd19Qb3dlcl9TMF9JZGxl
LnBkZjwvYT48YnI+CiAgICAgICAgICAgICAgJmd0Ozxicj4KICAgICAgICAgICAgICAmZ3Q7IEFu
eSBoZWxwIGlzIGFwcHJlY2lhdGVkLjxicj4KICAgICAgICAgICAgICAmZ3Q7PGJyPgogICAgICAg
ICAgICAgICZndDsgVGhhbmtzLDxicj4KICAgICAgICAgICAgICAmZ3Q7IERldmluPGJyPgogICAg
ICAgICAgICAgICZndDsgX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX188YnI+CiAgICAgICAgICAgICAgJmd0OyBEZXZlbCBtYWlsaW5nIGxpc3QgLS0gPGEKICAg
ICAgICAgICAgICAgIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eub3JnIiByZWw9Im5vcmVmZXJy
ZXIiCiAgICAgICAgICAgICAgICB0YXJnZXQ9Il9ibGFuayIgbW96LWRvLW5vdC1zZW5kPSJ0cnVl
Ij5kZXZlbEBhY3BpY2Eub3JnPC9hPjxicj4KICAgICAgICAgICAgICAmZ3Q7IFRvIHVuc3Vic2Ny
aWJlIHNlbmQgYW4gZW1haWwgdG8gPGEKICAgICAgICAgICAgICAgIGhyZWY9Im1haWx0bzpkZXZl
bC1sZWF2ZUBhY3BpY2Eub3JnIiByZWw9Im5vcmVmZXJyZXIiCiAgICAgICAgICAgICAgICB0YXJn
ZXQ9Il9ibGFuayIgbW96LWRvLW5vdC1zZW5kPSJ0cnVlIj5kZXZlbC1sZWF2ZUBhY3BpY2Eub3Jn
PC9hPjxicj4KICAgICAgICAgICAgICAmZ3Q7ICUod2ViX3BhZ2VfdXJsKXNsaXN0aW5mbyUoY2dp
ZXh0KXMvJShfaW50ZXJuYWxfbmFtZSlzPGJyPgogICAgICAgICAgICAgIF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgogICAgICAgICAgICAgIERldmVs
IG1haWxpbmcgbGlzdCAtLSA8YSBocmVmPSJtYWlsdG86ZGV2ZWxAYWNwaWNhLm9yZyIKICAgICAg
ICAgICAgICAgIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiIG1vei1kby1ub3Qtc2Vu
ZD0idHJ1ZSI+ZGV2ZWxAYWNwaWNhLm9yZzwvYT48YnI+CiAgICAgICAgICAgICAgVG8gdW5zdWJz
Y3JpYmUgc2VuZCBhbiBlbWFpbCB0byA8YQogICAgICAgICAgICAgICAgaHJlZj0ibWFpbHRvOmRl
dmVsLWxlYXZlQGFjcGljYS5vcmciIHJlbD0ibm9yZWZlcnJlciIKICAgICAgICAgICAgICAgIHRh
cmdldD0iX2JsYW5rIiBtb3otZG8tbm90LXNlbmQ9InRydWUiPmRldmVsLWxlYXZlQGFjcGljYS5v
cmc8L2E+PGJyPgogICAgICAgICAgICAgICUod2ViX3BhZ2VfdXJsKXNsaXN0aW5mbyUoY2dpZXh0
KXMvJShfaW50ZXJuYWxfbmFtZSlzPGJyPgogICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAg
ICAgICA8L2Rpdj4KICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgIDwvZGl2PgogICAgPC9ibG9j
a3F1b3RlPgogIDwvYm9keT4KPC9odG1sPgo=

--===============6133963140580054076==--

