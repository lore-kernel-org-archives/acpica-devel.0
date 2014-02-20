Content-Type: multipart/mixed; boundary="===============2466436751285871229=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] 6 second boot delay if processing SSDT tables
Date: Thu, 20 Feb 2014 06:05:19 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88024B1DFA@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 20140218083856.GB1741@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2466436751285871229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I created a bug entry here:
https://bugzilla.kernel.org/show_bug.cgi?id=3D70891

Possibly this is a known issue.
We have a series to cleanup table related code where Linux specific logics =
are embedded.
In that series, there are several issues detected.
Could you please first upload an acpidump output there to let me check if t=
here is a known fix matching this bug?

Thanks and best regards
-Lv

> From: linux-acpi-owner(a)vger.kernel.org [mailto:linux-acpi-owner(a)vger.=
kernel.org] On Behalf Of Stanislaw Gruszka
> Sent: Tuesday, February 18, 2014 4:39 PM
> =

> Hi,
> =

> On bugzilla https://bugzilla.redhat.com/show_bug.cgi?id=3D1055228 ,
> Gareth reported 6 second boot delay on 3.12 kernel. Delay does not
> happen if acpi_no_auto_ssdt option is used, nor if kernel is compiled
> with various debug facilities like LOCKDEP (fedora kernel-debug
> variant). We tried to compile kernel with just CONFIG_ACPI_DEBUG=3Dy, on
> that kernel issue was reproducible, but after enable printing messages,
> again issue disappeared (we tried acpi.debug_layer=3D0xffffffff together
> with acip.debug_level=3D0x0307ff4f and acip.debug_level=3D0x03000000,
> links to logs are provided in bugzilla).
> =

> On affected kernels interesting dmesg part looks like below:
> =

> [    0.212035] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
> [    0.217930] ACPI: SSDT 0000000092e6ac18 003D3 (v01  PmRef  Cpu0Cst 000=
03001 INTL 20121220)
> [    0.218512] ACPI: Dynamic OEM Table Load:
> [    0.218514] ACPI: SSDT           (null) 003D3 (v01  PmRef  Cpu0Cst 000=
03001 INTL 20121220)
> [    0.222109] ACPI: SSDT 0000000092e6a618 005AA (v01  PmRef    ApIst 000=
03000 INTL 20121220)
> [    0.222792] ACPI: Dynamic OEM Table Load:
> [    0.222799] ACPI: SSDT           (null) 005AA (v01  PmRef    ApIst 000=
03000 INTL 20121220)
> [    0.226920] ACPI: SSDT 0000000092e69d98 00119 (v01  PmRef    ApCst 000=
03000 INTL 20121220)
> [    0.227495] ACPI: Dynamic OEM Table Load:
> [    0.227497] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst 000=
03000 INTL 20121220)
> [    6.812869] ACPI: Interpreter enabled
> =

> With acpi_no_auto_ssdt option interesting part looks like this:
> =

> [    0.203230] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
> [    0.203595] ACPI Error: [SGMD] Namespace lookup failure, AE_NOT_FOUND =
(20130725/psargs-359)
> [    0.203601] ACPI Error: Method parse/execution failed [\_SB_._OSC] (No=
de ffff880253859438), AE_NOT_FOUND (20130725/psparse-
> 536)
> [    0.206093] ACPI Error: [\_PR_.CPU0._PPC] Namespace lookup failure, AE=
_NOT_FOUND (20130725/psargs-359)
> [    0.206102] ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB=
.EC0_.SASU] (Node ffff8802538570a0), AE_NOT_FOUND
> (20130725/psparse-536)
> [    0.206108] ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB=
.EC0_.ECMI] (Node ffff880253857078), AE_NOT_FOUND
> (20130725/psparse-536)
> [    0.206113] ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB=
.EC0_._REG] (Node ffff880253856910), AE_NOT_FOUND
> (20130725/psparse-536)
> [    0.206122] Fail in evaluating the _REG object of EC device. Broken bi=
os is suspected.
> [    0.206127] ACPI: Interpreter enabled
> =

> Any help to solving this bug would be appreciate. I'm CCing Gareth, he
> can provide more informations if needed.
> =

> Thanks
> Stanislaw
> =

> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo(a)vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--===============2466436751285871229==--

