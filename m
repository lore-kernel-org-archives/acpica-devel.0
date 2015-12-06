Content-Type: multipart/mixed; boundary="===============7011079586183436088=="
MIME-Version: 1.0
From: Lukas Wunner <lukas at wunner.de>
Subject: Re: [Devel] [PATCH v2 1/2] ACPI / scan: Fix acpi_bus_id_list
 bookkeeping
Date: Sun, 06 Dec 2015 22:09:19 +0100
Message-ID: <20151206210919.GA29070@wunner.de>
In-Reply-To: 565EB24F.8070005@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7011079586183436088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

a gentle ping, not sure if you just haven't had time to look at this
thread or if it's fallen between the cracks.

(Further comments from me below.)

On Wed, Dec 02, 2015 at 04:56:47PM +0800, Hanjun Guo wrote:
> On 2015/12/1 21:08, Lukas Wunner wrote:
> > Hi,
> >
> > On Mon, Nov 30, 2015 at 04:14:32PM +0800, Hanjun Guo wrote:
> >> On 2015/11/30 14:27, Hanjun Guo wrote:
> >>> On 2015/11/26 4:19, Lukas Wunner wrote:
> >>>> acpi_device_add() allocates and adds an element to acpi_bus_id_list
> >>>> (or increments the instance count if the device's HID is already
> >>>> present in the list), but the element is never deleted from the list
> >>>> nor freed. Fix it.
> >>> Hmm, I didn't get it here. Seems the device's ID already freed in dev=
ice core:
> >>>
> >>>  In acpi_add_single_object(), acpi_device_release() registered as a c=
allback,
> >>> ...
> >>>   result =3D acpi_device_add(device, acpi_device_release);
> >>> ...
> >>>
> >>> And in acpi_device_release(), it will call acpi_free_pnp_ids() to fre=
e the
> >>> IDs, did I miss some something?
> >> Sorry, I misread the code, I thought it was the pnn ids connect to the=
 ACPI device,
> >> actually you are referring to HIDs connecting to acpi_bus_id_list, sor=
ry for the noise.
> > Yes, I should have been more clear about this in the first place:
> >
> > When the bus is scanned and acpi_device_add() is called for each device,
> > not only do we initialize a struct acpi_device and attach it to the
> > device tree, but we also add an element to acpi_bus_id_list.
> >
> > Hence there are two ways to detect the presence of a HID: By traversing
> > the device tree or by iterating over the list. I chose the latter becau=
se
> > it is obviously cheaper and requires less code.
> >
> > However elements only ever get added to the list, never deleted. I'm not
> > sure if hotpluggable ACPI devices exist but if they do, this is a bug
> > which is fixed by this patch.
> =

> ACPI devices can be hotpluggable :) , but it will have no memory leak I t=
hink, it
> only increase the instance number for ACPI devices removed and hot-added =
later,
> I don't know if it make sense to do that, for example, if you remove devi=
ce A and
> B with same HID (such as ACPI0007) with your patch added:
> =

> remove processor 0, the sysfs for device A /sys/bus/acpi/devices/ACPI0007=
:00 will be
> removed;
> =

> remove processer 1, the sysfs for device B /sys/bus/acpi/devices/ACPI0007=
:01 will be
> removed;
> =

> But if we add it in reverse with your patch:
> =

> Add dprocesser 1, the sysfs /sys/bus/acpi/devices/ACPI0007:00 will be cre=
ated,
> =

> add processor 0...
> =

> I'm not sure it will confuse user space or not.
> =

> Rafael, what's your opinion here?

Yes, with this patch the instance number is no longer strictly increasing
and if devices are unplugged and replaced, instance numbers are recycled
for the newly plugged devices. I have no idea if this can break things.

If this patch is not acceptable, the semantics of patch [v2 2/2] change
in that acpi_dev_present() doesn't return the presence of a HID at the
time of invocation, but rather whether such a device has ever been present
since boot. It wouldn't be a problem because acpi_dev_present() is
meant for presence detection of devices which are built into the system
(same goes for the PCI counterpart pci_dev_present(), see the kerneldoc
in drivers/pci/search.c). I'd have to adjust the kerneldoc though to
reflect the changed semantics.

The other option would be to traverse the acpi_device tree instead of
iterating over acpi_bus_id_list, then it would be possible to retain
the semantics of detecting presence at the moment of invocation.

Please let me know which of these options makes the most sense to you
so that I can adjust the patches.

Thank you,

Lukas

> =

> Thanks
> Hanjun
>=20

--===============7011079586183436088==--

