Content-Type: multipart/mixed; boundary="===============5446918945226459379=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [RFC 4/4] ACPI: fix ECDT EC probe ordering issues
Date: Tue, 28 Jun 2022 21:15:34 +0200
Message-ID: <CAJZ5v0g=8ZDCFnZH_j4BkpjLGPaEn1SQPq7+7=A0SBp8we+cHg@mail.gmail.com>
In-Reply-To: eaa10b85-17fe-fd4b-8230-1caf92ffcd34@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5446918945226459379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 27, 2022 at 5:03 PM Hans de Goede <hdegoede(a)redhat.com> wrote:
>
> Hi,
>
> On 6/27/22 16:21, Rafael J. Wysocki wrote:
> > First off, thanks for taking care of this issue!
>
> You're welcome.
>
> > On Wed, Jun 15, 2022 at 9:57 PM Hans de Goede <hdegoede(a)redhat.com> w=
rote:
> >>
> >> ACPI-2.0 says that the EC OpRegion handler must be available immediate=
ly
> >> (like the standard default OpRegion handlers). So acpi_bus_init() calls
> >> acpi_ec_ecdt_probe(), which calls acpi_install_address_space_handler()=
 to
> >> install the EC's OpRegion handler, early on.
> >
> > I think that the key question is what Windows does in this respect.
> >
> > I honestly don't think that it uses an allowlist to early call _INI
> > for a few specific devices.
>
> Right, I guess that windows does things more hierarchicallly first
> calling \._INI then \._SB._INI and then calling other _INI-s around
> the time it enters there parts of the ACPI device hierarchy.
>
> I have the feeling that Windows e.g. has the root PCI bridge fully
> setup before even parsing any ACPI objects under it.

Which means that if the EC object is under PCI0, it will not evaluate
its _REG before enumerating the PCI bus.

> This is quite different from how Linux (or ACPICa for that manner)
> works. So ATM I believe that the fixed list of object paths to
> call _INI on early is the best we can do.

Well, ACPICA follows the spec quite literally in that respect (and the
spec says that _INI should be evaluated "at the table load time"
IIRC).

> >
> >> This not only installs the OpRegion handler, but also calls the EC's
> >> _REG method. The _REG method call is a problem because it may rely on
> >> initialization done by the _INI methods of one of the PCI / _SB root d=
evs,
> >> see for example: https://bugzilla.kernel.org/show_bug.cgi?id=3D214899 .
> >>
> >> This _REG depends on _INI problem can be fixed by calling the new ACPI=
CA
> >> acpi_early_initialize_objects() function before acpi_ec_ecdt_probe().
> >>
> >> But on some boards (e.g. Lenovo X1C8) the root devices _INI method
> >> relies on the EC OpRegion so executing the _INI methods before
> >> registering the EC OpRegion handler leads to errors there.
> >>
> >> To allow fixing this the ACPICA code now allows to do the OpRegion han=
dler
> >> installation early on (without calling _REG) and to do the EC's _REG
> >> execution later on as a separate step.
> >>
> >> This commit uses this new ACPICA functions to fix the EC probe ordering
> >> by changing the acpi_bus_init() initialization order to this:
> >>
> >> 1. acpi_load_tables()
> >> 2. acpi_ec_ecdt_probe()
> >>    This now calls acpi_install_address_space_handler(ACPI_NO_EXEC__REG)
> >>    which installs the OpRegion handler without executing _REG
> >
> > I'm not sure if installing an opregion without evaluating _REG for it
> > is particularly useful.
>
> We already do this for the SystemMemory / SystemIO and PCI_Config OpRegio=
ns.
> The handlers for these get installed from acpi_enable_subsystem()
> and their _REG functions get called later from acpi_initialize_objects().
>
> This patch basically makes the EmbeddedControl OpRegion behave the
> same and according to the current code:

I think that the evaluation of _REG can be deferred in this case.

>
>         /*
>          * ACPI 2.0 requires the EC driver to be loaded and work before t=
he EC
>          * device is found in the namespace.
>          *
>          * This is accomplished by looking for the ECDT table and getting=
 the EC
>          * parameters out of that.
>          *
>          * Do that before calling acpi_initialize_objects() which may tri=
gger EC
>          * address space accesses.
>          */
>         acpi_ec_ecdt_probe();
>
> This is mandated by ACPI-2.0 which also seems to match my analysis
> of this problem where on e.g. my Lenovo X1 carbon gen 8
> the \_SB.PCI0._INI method uses an EmbeddedControl OpRegion without
> any _REG related checks.
> > No AML should use it before _REG is evaluated anyway.
>
> See above, ACPI 2.x seems to allow this, like how it allows it
> for SystemIO / SystemMemory / PCI_Config. This seems to be the
> whole reason why there is a separate table describing the EC
> (the ECDT) so that the EC can be made available before any parsing
> of the DSDT has been done.
>
> So we need to have the OpRegion available before running the
> "early" _INI methods. And because of _REG relying on the OSYS
> GVNS variable in some cases, which gets set from _INI on the
> PCI root bridge, that means running _REG after running
> (some) _INI methods.

OK, so at least on some systems the EC address space will be accessed
regardless of the _REG for it.

> >> 3. acpi_enable_subsystem()
> >> 4. acpi_early_initialize_objects()
> >>    This calls the _INI method of the PCI and _SB root devices
> >
> > So this is a change in behavior that will affect every system using
> > ACPI on the planet, not just the ones where the problem at hand is
> > present.  This appears to be somewhat risky to me.
>
> The ACPICA code already calls \.INI and \_SB._INI at the start of
> acpi_initialize_objects(), before evalutating any _REG methods,
> so this call in itself is no a change.
>
> Except that \_SB.PCI0._INI and \_SB.PC0._INI are now also
> run early (patch 2/4).
> >> 5. acpi_ec_ecdt_exec_reg();
> >>    This executes the EC's _REG now that the root devices _INI has run
>
> This is the actual change moving the calling of _REG for the EC to after
> the running of the "early" _INI calls.
>
> >> 6. acpi_initialize_objects(ACPI_NO_EARLY_DEVICE_INIT)
> >>
> >> This allows the EC's _REG method to depend on e.g. the \OSYS global/GV=
NS
> >> variable often set by a root-device's _INI method, while at the same t=
ime
> >> allowing these _INI methods to access EmbeddedController OpRegions.
> >
> > I'm wondering if it is possible to change the ordering of
> > acpi_ec_ecdt_probe() or the part of it that installs the oprtegion
> > handler to be called later?
>
> Note splitting the install vs _REG calling of OpRegion handlers
> requires ACPICA changes (patch 3/4).
>
> Assuming those changes are in place then we could delay calling
> of _REG also until the actual acpi-ec driver binds. This would
> put it a lot later in the init sequence though. So that would
> be much more of a change to the ordering then done in this
> RFC series.
>
> I did consider this and I do think it makes sense to only call
> _REG once we actually have fully setup the ACPI device for
> the EC (rather then just parsed the ECDT as we do now), but
> it is a big change.

That's what I would like to do here.

> This would also put the _REG late enough that the _INI
> setting the OSYS variable has already run, avoiding
> the need for the "early" _INI calls from the EC _REG
> evaluation pov (1).
>
> If we go this route then acpi_bus_init() would not need any
> changes. In this case the changes would be:
>
> 1. Change  acpi_ec_ecdt_probe(); to only install the
> OpRegion handler and not call _REG
>
> 2. Call _REG from acpi_ec_add() before it calls
> acpi_dev_clear_dependencies(device);
>
> If you think that is better I can implement this and ask
> the reporter of:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D214899
>
> to give this new approach a test run.

Yes, please.
--===============5446918945226459379==--

