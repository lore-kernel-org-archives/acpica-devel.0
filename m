Content-Type: multipart/mixed; boundary="===============2776760014699438123=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: [Devel] Re: [PATCH] PCI: Put power resources not tied to a physical
 node in D3cold
Date: Fri, 08 Oct 2021 19:07:14 +0200
Message-ID: <5504370.DvuYhMxLoT@kreacher>
In-Reply-To: 8c8df41d-265a-637d-bc26-cdaf0e4e93a8@amd.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2776760014699438123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday, October 8, 2021 5:47:53 PM CEST Limonciello, Mario wrote:
> On 10/8/2021 09:05, Rafael J. Wysocki wrote:
> > On Thursday, October 7, 2021 10:51:26 PM CEST Mario Limonciello wrote:
> >> I found a case that a system that two physical SATA controllers share
> >> the same ACPI Power Resource.  When a drive is connected to one of
> >> the controllers then it will bind with PCI devices with the ahci driver
> >> and form a relationship with the firmware node and physical node.  Dur=
ing
> >> s2idle I see that the constraints are met for this device as it is
> >> transitioned into the appropriate state. However the second ACPI node
> >> doesn't have any relationship with a physical node and stays in "D0":
> >>
> >> ```
> >> ACPI: \_SB_.PCI0.GP18.SATA: ACPI: PM: Power state change: D0 -> D3cold
> >> ACPI: PM: Power resource [P0SA] still in use
> >> acpi device:2a: Power state changed to D3cold
> >> ```
> >>
> >> Due to the refcounting used on the shared power resource putting the
> >> device with a physical node into D3 doesn't result in the _OFF method
> >> being called.
> >>
> >> To help with this type of problem, make a new helper function that can
> >> be used to check all the children of an ACPI device and put any firmwa=
re
> >> nodes that don't have physical devices into D3cold to allow shared
> >> resources to transition. Call this helper function after PCI devices h=
ave
> >> been scanned and ACPI companions have had a chance to associate.
> >>
> >> After making this change, here is what the flow looks like:
> >> ```
> >> <snip:bootup>
> >> ACPI: \_SB_.PCI0.GP18.SAT1: ACPI: PM: Power state change: D0 -> D3cold
> >> ACPI: PM: Power resource [P0SA] still in use
> >> acpi device:2c: Power state changed to D3cold
> >> <snip:suspend>
> >> ACPI: \_SB_.PCI0.GP18.SATA: ACPI: PM: Power state change: D0 -> D3cold
> >> ACPI: PM: Power resource [P0SA] turned off
> >> acpi device:2a: Power state changed to D3cold
> >> ```
> >>
> >> Link: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flore.kernel.org%2Flinux-acpi%2F0571292a-286b-18f2-70ad-12b125a61469%40a=
md.com%2FT%2F%23m042055c5ca1e49c2829655511f04b0311c142559&amp;data=3D04%7C0=
1%7Cmario.limonciello%40amd.com%7Ce54614dae1624dfb240408d98a64b8da%7C3dd896=
1fe4884e608e11a82d994e183d%7C0%7C0%7C637692988971446528%7CUnknown%7CTWFpbGZ=
sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3=
000&amp;sdata=3D9fYSZ4d2cA2TnM453MQxqmOlGN%2FU6WNi7By7pVP2EV4%3D&amp;reserv=
ed=3D0
> >> BugLink: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D214091&amp;data=3D04%7C01%=
7Cmario.limonciello%40amd.com%7Ce54614dae1624dfb240408d98a64b8da%7C3dd8961f=
e4884e608e11a82d994e183d%7C0%7C0%7C637692988971446528%7CUnknown%7CTWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300=
0&amp;sdata=3DvsjQOgqzadLYXTfRW2sui5Dp7%2B0EYf14rUCiIDNofoI%3D&amp;reserved=
=3D0
> >> Signed-off-by: Mario Limonciello <mario.limonciello(a)amd.com>
> >> ---
> >>   drivers/acpi/device_pm.c | 34 ++++++++++++++++++++++++++++++++++
> >>   drivers/pci/probe.c      |  5 +++++
> >>   include/acpi/acpi_bus.h  |  1 +
> >>   3 files changed, 40 insertions(+)
> >>
> >> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> >> index 0028b6b51c87..0fb0bbeeae9e 100644
> >> --- a/drivers/acpi/device_pm.c
> >> +++ b/drivers/acpi/device_pm.c
> >> @@ -149,6 +149,40 @@ static int acpi_dev_pm_explicit_set(struct acpi_d=
evice *adev, int state)
> >>   	return 0;
> >>   }
> >>   =

> >> +/**
> >> + * acpi_device_turn_off_absent_children - Turn off power resources for
> >> + *					  children not physically present.
> >> + * @parent: ACPI bridge device
> >> + */
> >> +int acpi_device_turn_off_absent_children(struct acpi_device *parent)
> >> +{
> >> +	struct acpi_device *adev;
> >> +	int ret =3D 0;
> >> +
> >> +	if (!parent)
> >> +		return -EINVAL;
> >> +
> >> +	list_for_each_entry(adev, &parent->children, node) {
> > =

> > It is better to use device_for_each_child() for this, walking the child=
ren list
> > without locking is questionable.
> > =

> >> +		int state;
> >> +
> >> +		if (!adev->flags.power_manageable ||
> > =

> > This need not be checked, acpi_device_set_power() checks it.
> > =

> >> +		    !adev->power.flags.power_resources)
> > =

> > And I'm not sure about this too.  Even if there are no power resources,=
 it
> > would be still prudent to release PM resources referred to by unused de=
vice
> > objects by calling _PS3 on them.
> > =

> >> +			continue;
> >> +		if (acpi_get_first_physical_node(adev))
> >> +			continue;
> > =

> > In addition to this, I would check if the device object has _ADR, becau=
se
> > there are legitimate cases when device objects with a _HID have no phys=
ical
> > nodes.
> > =

> >> +		ret =3D acpi_device_get_power(adev, &state);
> >> +		if (ret)
> >> +			return ret;
> >> +		if (state =3D=3D ACPI_STATE_D3_COLD)
> >> +			continue;
> > =

> > The above is not necessary.
> > =

> >> +		ret =3D acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(acpi_device_turn_off_absent_children);
> > =

> > And I would put this function into glue.c.
> > =

> >> +
> >>   /**
> >>    * acpi_device_set_power - Set power state of an ACPI device.
> >>    * @device: Device to set the power state of.
> >> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >> index 79177ac37880..1a45182394d1 100644
> >> --- a/drivers/pci/probe.c
> >> +++ b/drivers/pci/probe.c
> >> @@ -2939,6 +2939,11 @@ static unsigned int pci_scan_child_bus_extend(s=
truct pci_bus *bus,
> >>   		}
> >>   	}
> >>   =

> >> +	/* check for and turn off dangling power resources */
> >> +	for_each_pci_bridge(dev, bus) {
> >> +		acpi_device_turn_off_absent_children(ACPI_COMPANION(&dev->dev));
> > =

> > IMO it would be better to call this from inside of the ACPI subsystem a=
nd
> > after scanning the entire bus.
> > =

> >> +	}
> >> +
> >>   	/*
> >>   	 * We've scanned the bus and so we know all about what's on
> >>   	 * the other side of any bridges that may be on this bus plus
> >> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> >> index 13d93371790e..0eba08b60e13 100644
> >> --- a/include/acpi/acpi_bus.h
> >> +++ b/include/acpi/acpi_bus.h
> >> @@ -510,6 +510,7 @@ int acpi_bus_get_status(struct acpi_device *device=
);
> >>   =

> >>   int acpi_bus_set_power(acpi_handle handle, int state);
> >>   const char *acpi_power_state_string(int state);
> >> +int acpi_device_turn_off_absent_children(struct acpi_device *parent);
> >>   int acpi_device_set_power(struct acpi_device *device, int state);
> >>   int acpi_bus_init_power(struct acpi_device *device);
> >>   int acpi_device_fix_up_power(struct acpi_device *device);
> >>
> > =

> > Overall, something like the appended patch might work. >
> > Note that on my test-bed machine it makes no difference, though.
> =

> Yes this helps the resources on the identified problematic machine.
> =

> > =

> > ---
> >   drivers/acpi/glue.c     |   28 ++++++++++++++++++++++++++++
> >   drivers/acpi/internal.h |    2 ++
> >   drivers/acpi/pci_root.c |    1 +
> >   3 files changed, 31 insertions(+)
> > =

> > Index: linux-pm/drivers/acpi/glue.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/acpi/glue.c
> > +++ linux-pm/drivers/acpi/glue.c
> > @@ -350,3 +350,31 @@ void acpi_device_notify_remove(struct de
> >   =

> >   	acpi_unbind_one(dev);
> >   }
> > +
> > +static int acpi_dev_turn_off_if_unused(struct device *dev, void *not_u=
sed)
> > +{
> > +	struct acpi_device *adev =3D to_acpi_device(dev);
> > +
> > +	acpi_dev_turn_off_unused_descendants(adev);
> > +
> > +	if (adev->pnp.type.bus_address && !acpi_get_first_physical_node(adev))
> > +		acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * acpi_dev_turn_off_unused_descendants - Put unused descendants into =
D3cold.
> > + * @adev: ACPI device object at the top of a branch of device hierarch=
y.
> > + *
> > + * Walk the branch of the hierarchy of ACPI device objects starting at=
 @adev
> > + * and put all of the objects in it that have _ADR and have no corresp=
onding
> > + * physical nodes into D3cold.
> > + *
> > + * This allows power resources that are only referred to by unused ACP=
I device
> > + * objects to be turned off.
> > + */
> > +void acpi_dev_turn_off_unused_descendants(struct acpi_device *adev)
> > +{
> > +	device_for_each_child(&adev->dev, NULL, acpi_dev_turn_off_if_unused);
> > +}
> > Index: linux-pm/drivers/acpi/internal.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/acpi/internal.h
> > +++ linux-pm/drivers/acpi/internal.h
> > @@ -88,6 +88,8 @@ bool acpi_scan_is_offline(struct acpi_de
> >   acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *co=
ntext);
> >   void acpi_scan_table_notify(void);
> >   =

> > +void acpi_dev_turn_off_unused_descendants(struct acpi_device *adev);
> > +
> >   /* ------------------------------------------------------------------=
--------
> >                        Device Node Initialization / Removal
> >      ------------------------------------------------------------------=
-------- */
> > Index: linux-pm/drivers/acpi/pci_root.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/acpi/pci_root.c
> > +++ linux-pm/drivers/acpi/pci_root.c
> > @@ -630,6 +630,7 @@ static int acpi_pci_root_add(struct acpi
> >   =

> >   	pci_lock_rescan_remove();
> >   	pci_bus_add_devices(root->bus);
> > +	acpi_dev_turn_off_unused_descendants(root->device);
> >   	pci_unlock_rescan_remove();
> >   	return 1;
> >   =

> > =

> > =

> > =

> =

> When you submit this if no other changes, please include:
> =

> Tested-by: Mario Limonciello <mario.limonciello(a)amd.com>

Thanks, but we may do better in a couple of ways.

First off, there's no particular reason to restrict the walk to the device
objects below the host bridge one.

Second, if the physical node appears while we're removing power from the
device, whoever adds it may be confused, so it's better to avoid that.

Please check if the appended one still works for you.

---
 drivers/acpi/glue.c     |   16 ++++++++++++++++
 drivers/acpi/internal.h |    1 +
 drivers/acpi/scan.c     |    6 ++++++
 3 files changed, 23 insertions(+)

Index: linux-pm/drivers/acpi/scan.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2559,6 +2559,12 @@ int __init acpi_scan_init(void)
 		}
 	}
 =

+	/*
+	 * Make sure that power management resources are not blocked by ACPI
+	 * device objects with no users.
+	 */
+	bus_for_each_dev(&acpi_bus_type, NULL, NULL, acpi_dev_turn_off_if_unused);
+
 	acpi_turn_off_unused_power_resources();
 =

 	acpi_scan_initialized =3D true;
Index: linux-pm/drivers/acpi/glue.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/acpi/glue.c
+++ linux-pm/drivers/acpi/glue.c
@@ -350,3 +350,19 @@ void acpi_device_notify_remove(struct de
 =

 	acpi_unbind_one(dev);
 }
+
+int acpi_dev_turn_off_if_unused(struct device *dev, void *not_used)
+{
+	struct acpi_device *adev =3D to_acpi_device(dev);
+
+	if (adev->pnp.type.bus_address) {
+		mutex_lock(&adev->physical_node_lock);
+
+		if (list_empty(&adev->physical_node_list))
+			acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
+
+		mutex_unlock(&adev->physical_node_lock);
+	}
+
+	return 0;
+}
Index: linux-pm/drivers/acpi/internal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -117,6 +117,7 @@ bool acpi_device_is_battery(struct acpi_
 bool acpi_device_is_first_physical_node(struct acpi_device *adev,
 					const struct device *dev);
 int acpi_bus_register_early_device(int type);
+int acpi_dev_turn_off_if_unused(struct device *dev, void *not_used);
 =

 /* -----------------------------------------------------------------------=
---
                      Device Matching and Notification



--===============2776760014699438123==--

