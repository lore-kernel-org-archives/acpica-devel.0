Content-Type: multipart/mixed; boundary="===============6381203143310340348=="
MIME-Version: 1.0
From: Anthony Jenkins <Scoobi_doo at yahoo.com>
Subject: Re: [Devel] [PATCH v2] Introduce AcpiOs(Read|Write)Cmos and enable
 these in AcpiExCmosSpaceHandler
Date: Thu, 14 Apr 2016 11:18:52 -0400
Message-ID: <570FB4DC.4070607@yahoo.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37E446E4C@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6381203143310340348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu Feb 18 08:05:56 PST 2016, Robert Moore wrote:
> To clarify:
>
> The ACPI specification defines three _HID values for the supported RTC/CM=
OS devices:
>
> 1) PNP0B00 (PC/AT-compatible)
> 2) PNP0B01 (Intel PIIX4-compatible)
> 3) PNP0B02 (Dallas Semiconductor-compatible)
>
> This is the reason that ACPICA has never defined low-level CMOS interface=
s, since there are 3 different devices. Therefore, the model that is used b=
y ACPICA is this:
>
> The host OS scans the ACPI namespace for the various devices with _HIDs.
> Upon detection of _HID PNP0B00, PNP0B01, or PNP0B02, the host loads the a=
ppropriate CMOS driver.
> The driver installs an operation region handler that hands off all CMOS r=
equests to the driver.
> ACPICA will invoke the handler on any CMOS address space access.
> The driver then accesses the CMOS device as appropriate.
>
> It appears that the first 64 bytes of the CMOS may be common between the =
chips. Accessing anything past 64 bytes seems to be device-dependent. So, a=
ny "common" CMOS code is playing with fire, I would think. For example, For=
 PNP0B01, the ACPI specification has this to say: "The upper 192 bytes are =
accessed through an interface that is only used on Intel chips. (See 82371A=
B PCI-TO-ISA / IDEXCELERATOR (PIIX4) for details)"
>
> Bob

Hi,
 =

I've proposed a patch to FreeBSD-11(CURRENT) to add an ACPI CMOS region
handler to its atrtc(4) device, which supports PNP0B00 devices, exactly
as you've suggested in your model.  Is there anything ACPICA can/will
provide to support this effort, or should my patch represent the the
complete implementation of CMOS region support in our OSPM (at least for
this particular CMOS device)?  At least the HP Envy line of laptops
requires this support to enable FreeBSD to suspend/power-down.

Thanks,

-- =

Anthony Jenkins


--===============6381203143310340348==--

