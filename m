Content-Type: multipart/mixed; boundary="===============1155451627102783601=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] acpica: Fix double-free in acpi_ns_repair_CID()
Date: Tue, 07 Feb 2017 21:07:26 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E564357@ORSMSX110.amr.corp.intel.com>
In-Reply-To: CA+A7VXXNk58unA+k6743VV7=cHTTbW8YHVf_5GAYdv1EPA5dPw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1155451627102783601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We are looking at this. It might also help if you could send a full acpidum=
p for the machine. Thanks.


> -----Original Message-----
> From: Jo=C3=A3o Paulo Rechi Vita [mailto:jprvita(a)gmail.com]
> Sent: Monday, February 6, 2017 6:46 AM
> To: Zheng, Lv <lv.zheng(a)intel.com>
> Cc: Moore, Robert <robert.moore(a)intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki(a)intel.com>; Len Brown <lenb(a)kernel.org>; Lin Ming
> <ming.m.lin(a)intel.com>; linux-acpi(a)vger.kernel.org; devel(a)acpica.or=
g;
> linux-kernel(a)vger.kernel.org; Daniel Drake <drake(a)endlessm.com>;
> linux(a)endlessm.com; Jo?o Paulo Rechi Vita <jprvita(a)endlessm.com>; Box,
> David E <david.e.box(a)intel.com>; Schmauss, Erik
> <erik.schmauss(a)intel.com>
> Subject: Re: [PATCH] acpica: Fix double-free in acpi_ns_repair_CID()
> =

> On 5 February 2017 at 20:44, Zheng, Lv <lv.zheng(a)intel.com> wrote:
> >> From: Moore, Robert
> >> Subject: RE: [PATCH] acpica: Fix double-free in acpi_ns_repair_CID()
> >>
> >> Here's the sequence of events as I see it:
> >>
> >> Repair_HID is a standalone function that removes one reference on the
> >> incoming object. For simple _HID objects, this in fact deletes the
> object.
> >>
> >> For _CID, all elements of the package are examined. If a repair was
> >> made on a _HID within the _CID function, one reference on the
> >> original object was removed by Repair_HID. However, since the object
> >> is part of a package, it has an extra reference to reflect this fact.
> >> Thus, in the case in question, the elements of the package all have
> >> at least two references. Repair_HID removes one reference, thus the
> extra RemoveReference is needed in Repair_CID to bring the reference
> count down to zero actually delete the object (in the typical case where
> the object had two references).
> >>
> =

> This is not what is happening on this machine. Bellow you can see some
> printks I've added in acpi_ns_repair_CID(), right before and after
> acpi_ns_repair_HID() is called:
> =

> [    0.244942] acpi_ns_repair_CID: calling acpi_ns_repair_HID for
> element ffff9a67b3a44f30, refcount=3D1 [\_SB.PCI0.I2C1.TPL1._CID]
> [    0.245072] acpi_ns_repair_CID: returned from acpi_ns_repair_HID
> for element ffff9a67b3a44f30, refcount=3D0 [\_SB.PCI0.I2C1.TPL1._CID]
> [    0.245202] acpi_ns_repair_CID: element was replaced by element_ptr
> ffff9a67b3a44828, refcount=3D1 [\_SB.PCI0.I2C1.TPL1._CID]
> =

> Here we would call
> acpi_ut_remove_reference(original_element=3D=3Dffff9a67b3a44f30), which
> already has refcount=3D=3D0. Maybe there is a refcount increment missing
> from somewhere else?
> =

> > Hi,
> >
> > So if a real problem related to package reference counting is
> triggered, the problem should be fixed elsewhere IMO.
> =

> Yes, the real problem is i2c_hid not being probed for the touchpad
> device on this platform (sorry, should have added this information to
> the commit message as well). What brought me to this unref was following
> messages on the kernel log:
> =

> [    0.317002] ACPI Warning: Obj ffffa00472a445e8, Reference Count is
> already zero, cannot decrement
> [    0.317178]  (20160422/utdelete-442)
> =

> > See this bug for reference:
> > https://bugs.acpica.org/show_bug.cgi?id=3D1336
> >
> =

> Looks like it could be the same problem, indeed. I'm attaching a kernel
> log with acpi.trace_debug_layer=3D0x10091 acpi.trace_debug_level=3D0x107F=
FF
> acpi.trace_method_name=3D_SB.PCI0.I2C1.TPL1._CID
> acpi.trace_state=3Dopcode, which is what I was using to investigate the
> problem, and the machine's DSDT. Please let me know if there is any
> other information I can provide to help clarify this issue.
> =

> Thanks,
> =

> --
> Jo=C3=A3o Paulo Rechi Vita
> http://about.me/jprvita

--===============1155451627102783601==--

