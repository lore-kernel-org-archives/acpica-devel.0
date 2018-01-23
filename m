Content-Type: multipart/mixed; boundary="===============7994207243201891044=="
MIME-Version: 1.0
From: Schmauss, Erik <erik.schmauss at intel.com>
Subject: Re: [Devel] ACPI: Do not call _STA on battery devices with unmet
 dependencies
Date: Tue, 23 Jan 2018 00:24:32 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED5396D7178@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 03b11c2d-0c17-89d2-daa2-d48f4ea656d5@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7994207243201891044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
> -----Original Message-----
> From: Hans de Goede [mailto:hdegoede(a)redhat.com]
> Sent: Saturday, January 20, 2018 4:48 AM
> To: Schmauss, Erik <erik.schmauss(a)intel.com>
> Cc: Rafael J . Wysocki <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.or=
g>;
> Bjorn Helgaas <bhelgaas(a)google.com>; Moore, Robert
> <robert.moore(a)intel.com>; Zheng, Lv <lv.zheng(a)intel.com>; linux-
> acpi(a)vger.kernel.org; linux-pci(a)vger.kernel.org; devel(a)acpica.org
> Subject: Re: ACPI: Do not call _STA on battery devices with unmet depende=
ncies
> =

> Hi,
> =

> On 19-01-18 22:03, Schmauss, Erik wrote:
> >
> >> -----Original Message-----
> >> From: linux-acpi-owner(a)vger.kernel.org [mailto:linux-acpi-
> >> owner(a)vger.kernel.org] On Behalf Of Bjorn Helgaas
> >> Sent: Thursday, January 18, 2018 11:11 AM
> >> To: Hans de Goede <hdegoede(a)redhat.com>
> >> Cc: Rafael J . Wysocki <rjw(a)rjwysocki.net>; Len Brown
> >> <lenb(a)kernel.org>; Bjorn Helgaas <bhelgaas(a)google.com>; Moore, Rob=
ert
> >> <robert.moore(a)intel.com>; Zheng, Lv <lv.zheng(a)intel.com>; linux-
> >> acpi(a)vger.kernel.org; linux-pci(a)vger.kernel.org; devel(a)acpica.org
> >> Subject: Re: ACPI: Do not call _STA on battery devices with unmet
> >> dependencies
> >>
> >> On Thu, Jan 18, 2018 at 05:03:55PM +0100, Hans de Goede wrote:
> >
> > Hi Hans,
> >
> >>> Hi All,
> >>>
> >>> The ACPI code already contains quite a bit of code to not bind the
> >>> ACPI-battery until all deps for an ACPI battery device have been
> >>> met, but on some devices calling _STA before all deps are met is a
> >>> problem too because the _STA method uses an i2c OpRegion there.
> >
> > Could you explain why _STA method using an I2C OpRegion is problematic?
> =

> It is problematic if we call the _STA method before the handler for the O=
pRegion
> has been installed, this series delays / avoids calling _STA before the O=
pRegion
> has been installed.

Thanks for the explanation.
I'm looking at the ACPI spec and from what it said about _STA, I gathered t=
hat _STA is allowed to have side-effects to named objects within the AML na=
mespace. So removing _STA from acpi_get_object_info seems a little dangerou=
s... Is there a reason why you cannot remove or delay the call to acpi_get_=
object_info instead? Chapter 6 section 1 of the ACPI spec also states that =
it's possible for _HID and _ADR to read from operation regions as well. Is =
it common convention that these _HID and _ADR objects do not access operati=
on regions?

Thanks,

Erik
> =

> Regards,
> =

> Hans
> =

> =

> >
> > Thanks,
> > Erik
> >
> >>>
> >>> Here is the DSDT of the device I'm seeing this on:
> >>> https://fedorapeople.org/~jwrdegoede/toshiba-click-mini-dsdt.dsl
> >>
> >> This looks like interesting info, but (a) this link isn't mentioned
> >> in the actual patches, and (b) it's conceivable that fedorapeople.org =
could go
> away someday.
> >> If this were a PCI series, I would suggest opening a report at
> >> bugzilla.kernel.org, attaching the DSL there, and including the link i=
n the
> patch changelog.
> >>
> >>> This series modifies the kernel to not call _STA until all deps are
> >>> met, mirroring the binding behavior of the battery driver.
> >>>
> >>> Without this series a total of 32 ACPI errors get printend to the
> >>> console on boot, there are 4 errors per _STA call, 2 battery devices
> >>> on this system and 4 _STA calls per battery device.
> >>>
> >>> The first commit is a preparation commit for making the ACPICA
> >>> changes in the 4th commit, this commit is necessary to not break
> >>> things after the ACPICA changes.
> >>>
> >>> The second commit modifies acpi_bus_get_status to not call _STA on
> >>> battery devices until all deps are met. This fixes 2 of the 4 too
> >>> early _STA calls triggering these errors.
> >>>
> >>> The third commit makes the device instantiation code use
> >>> acpi_bus_get_status instead of acpi_bus_get_status_handle so that
> >>> the code to get the initial status also does not makes 1 too early _S=
TA call.
> >>>
> >>> The fourth commit changes the ACPICA acpi_get_object_info function
> >>> to not call _STA. Only 1 user (which is fixed in the first commit)
> >>> cares about acpi_device_info.current_status. And the ACPICA code has
> >>> this
> >> comment:
> >>>
> >>>   * Note: This interface is intended to be used during the initial
> >>> device
> >>>   * discovery namespace traversal. Therefore, no complex methods can =
be
> >>>   * executed, especially those that access operation regions.
> >>> Therefore, do
> >>>   * not add any additional methods that could cause problems in this =
area.
> >>>   * Because of this reason support for the following methods has
> >>> been
> >> removed:
> >>>   * this was the fate of the _SUB method which was found to cause such
> >>>   * problems and was removed (11/2015).
> >>>
> >>> The described problems with the _SUB method clearly also apply to
> >>> the _STA method, so removing it from acpi_get_object_info seems like
> >>> it is the right thing to do here. This too fixes 1 too early _STA
> >>> call, so that with all
> >>> 4 patches in place we've fixed all 4 too early _STA calls.
> >>>
> >>> Regards,
> >>>
> >>> Hans
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> >>> in the body of a message to majordomo(a)vger.kernel.org More majordomo
> >>> info at  http://vger.kernel.org/majordomo-info.html
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> >> in the body of a message to majordomo(a)vger.kernel.org More majordomo
> >> info at http://vger.kernel.org/majordomo-info.html

--===============7994207243201891044==--

