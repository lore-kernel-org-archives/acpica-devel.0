Content-Type: multipart/mixed; boundary="===============0094358459518688877=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH v2] Introduce AcpiOs(Read|Write)Cmos and enable
 these in AcpiExCmosSpaceHandler
Date: Thu, 14 Apr 2016 15:49:19 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4746B0@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 570FB4DC.4070607@yahoo.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0094358459518688877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm not sure what the status of this is in ACPICA. But it does sound like w=
e could supply a default handler that only accesses the addresses 0-63


> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Anthony Jenk=
ins
> Sent: Thursday, April 14, 2016 8:19 AM
> To: devel(a)acpica.org
> Subject: Re: [Devel] [PATCH v2] Introduce AcpiOs(Read|Write)Cmos and
> enable these in AcpiExCmosSpaceHandler
> =

> On Thu Feb 18 08:05:56 PST 2016, Robert Moore wrote:
> > To clarify:
> >
> > The ACPI specification defines three _HID values for the supported
> RTC/CMOS devices:
> >
> > 1) PNP0B00 (PC/AT-compatible)
> > 2) PNP0B01 (Intel PIIX4-compatible)
> > 3) PNP0B02 (Dallas Semiconductor-compatible)
> >
> > This is the reason that ACPICA has never defined low-level CMOS
> interfaces, since there are 3 different devices. Therefore, the model that
> is used by ACPICA is this:
> >
> > The host OS scans the ACPI namespace for the various devices with _HIDs.
> > Upon detection of _HID PNP0B00, PNP0B01, or PNP0B02, the host loads the
> appropriate CMOS driver.
> > The driver installs an operation region handler that hands off all CMOS
> requests to the driver.
> > ACPICA will invoke the handler on any CMOS address space access.
> > The driver then accesses the CMOS device as appropriate.
> >
> > It appears that the first 64 bytes of the CMOS may be common between the
> chips. Accessing anything past 64 bytes seems to be device-dependent. So,
> any "common" CMOS code is playing with fire, I would think. For example,
> For PNP0B01, the ACPI specification has this to say: "The upper 192 bytes
> are accessed through an interface that is only used on Intel chips. (See
> 82371AB PCI-TO-ISA / IDEXCELERATOR (PIIX4) for details)"
> >
> > Bob
> =

> Hi,
> =

> I've proposed a patch to FreeBSD-11(CURRENT) to add an ACPI CMOS region
> handler to its atrtc(4) device, which supports PNP0B00 devices, exactly as
> you've suggested in your model.  Is there anything ACPICA can/will provide
> to support this effort, or should my patch represent the the complete
> implementation of CMOS region support in our OSPM (at least for this
> particular CMOS device)?  At least the HP Envy line of laptops requires
> this support to enable FreeBSD to suspend/power-down.
> =

> Thanks,
> =

> --
> Anthony Jenkins
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============0094358459518688877==--

