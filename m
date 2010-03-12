Content-Type: multipart/mixed; boundary="===============6946592059846387338=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: [Devel] Reserved method has too many arguments (_OSC requires 4)
Date: Fri, 12 Mar 2010 15:00:53 +0100
Message-ID: <201003121500.53220.trenn@suse.de>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6946592059846387338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I have a laptop freezing early, acpi=3Doff and noapic helps.
I wonder whether this could have to do with the broken _OSC method.

I cannot access the machine myself, eventually I can get more info
if needed, but the machine is freezing really early (after ACPI
initialization, somewhere around bringing up CPUs (possibly when
starting PCI init already?).

This is not the first time I see this message.
It would be great to get (from include/linux/kernel.h):
#define FW_BUG          "[Firmware Bug]: "
#define FW_WARN         "[Firmware Warn]: "
#define FW_INFO         "[Firmware Info]: "
marked messages into ACPICA and blame the guys who are responsible
for that.

My other concern/question is: what exactly happens in such a case?
Will _OSC get invoked at all?
If yes, what will be the last argument, zero, -1?

Hmm, I doubt it has to do with the freeze, but it would still be
great if someone knowing these parts could comment what people
with such a BIOS could expect to happen.

Thanks,

  Thomas

Method (_OSC, 5, NotSerialized)
{
   Store (Arg3, Local0)
   Multiply (Local0, 0x04, Local1)
   Name (BUF1, Buffer (Local1) {})
   Store (Arg4, BUF1)
   Store (Zero, Local1)
   Store (Zero, Local2)
   While (Local0)
   {
       Multiply (Local1, 0x04, Local2)
       CreateDWordField (BUF1, Local2, CAPB)
       If (Arg2)
       {
           If (LEqual (Local1, Zero))
           {
               And (CAPB, 0xFFFFFFFC)
           }
       }
       Increment (Local1)
       Decrement (Local0)
   }
   Return (BUF1)
}

--===============6946592059846387338==--

