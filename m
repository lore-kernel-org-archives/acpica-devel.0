Content-Type: multipart/mixed; boundary="===============5027520974609875159=="
MIME-Version: 1.0
From: devinsteffler at gmail.com
Subject: [Devel] Wake On LAN steps for QNX from S5
Date: Wed, 14 Oct 2020 16:02:42 +0000
Message-ID: <20201014160242.2619.13006@ml01.vlan13.01.org>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5027520974609875159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I raised a case with QNX about this last week but I haven't heard back from=
 them yet. In the meantime, I'm wondering if the kind folks at ACPICA might=
 be able to help with this. I'm hoping that I'm not missing anything obviou=
s.

I'm using an Intel based x86_64 PC with QNX on it (an Intel NUC NUC7i5DNB t=
o be precise). QNX does not have ACPI support built-in. As an example, QNX =
does not have a way to read battery status or power down (soft off, S5) an =
x86 based PC.

So I'm making my own ACPI driver for QNX based off of the ACPICA code base.=
 I've done this previously with success for reading AC power/battery inform=
ation on laptops using things like _PSR from a ACPI0003 device as well as _=
STA, _BIF, and _BST from PNP0C0A devices.

Now I would like to try and get Wake On LAN working from a soft off (S5) st=
ate.

I'm able to enter S5 via the following code:
-----------------------------------------------
	AcpiEnterSleepStatePrep(5);

	// disable interrupts, optional?
	ThreadCtl( _NTO_TCTL_IO, 0 );
	InterruptDisable();

	AcpiEnterSleepState(5);
-----------------------------------------------

Unfortunately, when I enter S5 using that code, then Wake On LAN no longer =
works when powered off. Although as you'll see below, Wake On LAN no longer=
 works if I go to S5 after having used the QNX e1000 driver. If I don't use=
 the e1000 driver then Wake On LAN works. Although, I need the QNX e1000 dr=
iver to have networking when running.

I've made the following observations:
- When I boot my device with Linux and power it off using software, then I'=
m able to Wake On LAN just fine.
  - in this case, the NIC LEDs blink while powered off
- If I boot into QNX and hold the power button for 10 seconds or so, it pow=
ers off and Wake On LAN works (whether the QNX e1000 driver is loaded or no=
t).
  - in this case, the NIC LEDs blink while powered off
- If I boot into QNX and use software (the code above) to power down, then =
Wake On LAN does not work.
  - in this case, the NIC LEDs remain off while powered off
- If I boot into QNX but do not start their networking stack (or their e100=
0 driver) and use software (the code above) to power down, then Wake On LAN=
 does work.
  - in this case, the NIC LEDs blink while powered off (they momentarily st=
op blinking, but then blink again shortly afterwards)

QNX has a pci-tool (similar to Linux's lspci tool). I can use it to see the=
 following:
---------------------------------------------------------------------------=
-------
# pci-tool -vvvv -d0:31:6

B000:D31:F06 @ idx 0
        vid/did: 8086/156f
                Intel Corporation, <device id - unknown>
        class/subclass/reg: 02/00/00
                Ethernet Network Controller
<snip>
        PMI Capability Details
                PMI supported states: D0 D3hot D3cold *
                PMI current state: D0
                PME's supported from states: D0 D3hot D3cold *
                PME's are disabled
                PMI data: [idx] val scale
                        [00]  00  01  [01]  --  --  [02]  --  --  [03]  00 =
 01
                        [04]  00  01  [05]  --  --  [06]  --  --  [07]  00 =
 01
                        [08]  --  --  [09]  --  --  [10]  --  --  [11]  -- =
 --
                        [12]  --  --  [13]  --  --  [14]  --  --  [15]  -- =
 --
---------------------------------------------------------------------------=
-------

I can use this method in ACPI to get "PME's are enabled" output:
\_SB.PCI0.GLAN._DSW

i.e.
---------------------------------------------------------------------------=
-------
# pci-tool -vvvv -d0:31:6

B000:D31:F06 @ idx 0
<snip>
        PMI Capability Details
                PMI supported states: D0 D3hot D3cold *
                PMI current state: D0
                PME's supported from states: D0 D3hot D3cold *
                PME's are enabled
                PMI data: [idx] val scale
                        [00]  00  01  [01]  --  --  [02]  --  --  [03]  00 =
 01
                        [04]  00  01  [05]  --  --  [06]  --  --  [07]  00 =
 01
                        [08]  --  --  [09]  --  --  [10]  --  --  [11]  -- =
 --
                        [12]  --  --  [13]  --  --  [14]  --  --  [15]  -- =
 --
---------------------------------------------------------------------------=
-------

Although that doesn't help.

Do I need to get the PMI current state to be D3hot prior to entering S5 in =
order for Wake On LAN to work?

However, I noticed that if I boot without the QNX e1000 driver, then Wake O=
n LAN works by just going to S5 alone, without _DSW. In this case:
---------------------------------------------------------------------------=
-------
# pci-tool -vvvv -d0:31:6

B000:D31:F06 @ idx 0
<snip>
        PMI Capability Details
                PMI supported states: D0 D3hot D3cold *
                PMI current state: D0
                PME's supported from states: D0 D3hot D3cold *
                PME's are disabled
                PMI data: [idx] val scale
                        [00]  00  01  [01]  --  --  [02]  --  --  [03]  00 =
 01
                        [04]  00  01  [05]  --  --  [06]  --  --  [07]  00 =
 01
                        [08]  --  --  [09]  --  --  [10]  --  --  [11]  -- =
 --
                        [12]  --  --  [13]  --  --  [14]  --  --  [15]  -- =
 --
---------------------------------------------------------------------------=
-------

It's almost like the QNX e1000 driver is putting the NIC into some state th=
at EFI does not recover from when transitioning to S5. Maybe the PHY is bei=
ng turned off. If this is the case, then should calls to things like _DSW, =
_PRW (and enabling GPE it returns), or even the LPI function 5 put the PHY =
back on? The NIC LEDs shut off at the same time as the power LED when enter=
ing S5 and do not come back on.

For LPI I'm referring to this:
https://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_=
Idle.pdf

Any help is appreciated.

Thanks,
Devin
--===============5027520974609875159==--

