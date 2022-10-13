Content-Type: multipart/mixed; boundary="===============6449219243909065471=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [RFC v3 0/4] ACPI[CA]: fix ECDT EC probe ordering issues
Date: Thu, 13 Oct 2022 18:53:10 +0200
Message-ID: <CAJZ5v0gaCYVTSk2wCBVEj9xXCMjtt=Ce8t88Me1kb_MCAuYfBw@mail.gmail.com>
In-Reply-To: 20221003144214.345279-1-hdegoede@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6449219243909065471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Mon, Oct 3, 2022 at 4:42 PM Hans de Goede <hdegoede(a)redhat.com> wrote:
>
> Hi All,
>
> Here is v3 of my series fixing some ECDT EC probe ordering issues which
> are causing issues om some laptops:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D214899
>
> This is a RFC because fixing this requires some ACPICA changes which
> obviously need to go upstream through the ACPICA project:
> https://github.com/acpica/acpica/pull/786

I've just approved your pull request.

Also, as soon as it gets merged, you can resubmit the series with a
proper ACPICA  commit ID and I will be able to apply the patches right
away then.

> The problem this fixed is best described by the commit message of patch 4:
>
> ACPI-2.0 says that the EC OpRegion handler must be available immediately
> (like the standard default OpRegion handlers):
>
> Quoting from the ACPI spec version 6.3: "6.5.4 _REG (Region) ...
> 2. OSPM must make Embedded Controller operation regions, accessed via
> the Embedded Controllers described in ECDT, available before executing
> any control method. These operation regions may become inaccessible
> after OSPM runs _REG(EmbeddedControl, 0)."
>
> So acpi_bus_init() calls acpi_ec_ecdt_probe(), which calls
> acpi_install_address_space_handler() to install the EC's OpRegion
> handler, early on.
>
> This not only installs the OpRegion handler, but also calls the EC's
> _REG method. The _REG method call is a problem because it may rely on
> initialization done by the _INI methods of one of the PCI / _SB root devs,
> see for example: https://bugzilla.kernel.org/show_bug.cgi?id=3D214899 .
>
> Generally speaking _REG methods are executed when the ACPI-device they
> are part of has a driver bound to it. Where as _INI methods must be
> executed at table load time (according to the spec). The problem here
> is that the early acpi_install_address_space_handler() call causes
> the _REG handler to run too early.
>
> To allow fixing this the ACPICA code now allows to split the OpRegion
> handler installation and the executing of _REG into 2 separate steps.
>
> This commit uses this ACPICA functionality to fix the EC probe ordering
> by delaying the executing of _REG for ECDT described ECs till the matching
> EC device in the DSDT gets parsed and acpi_ec_add() for it gets called.
> This moves the calling of _REG for the EC on devices with an ECDT to
> the same point in time where it is called on devices without an ECDT tabl=
e.
>
> Changes in v3:
> - Add a prep patch to fix an indentation issue in Linux' acpixf.h to fix
>   the patch from ACPICA's script not applying
> - Add 2 new functions to ACPICA for this instead of a flags argument
>   1. acpi_install_address_space_handler_no_reg()
>   2. acpi_execute_reg_methods()
> - Add a patch to fix EC handler removal in the ECDT case
>
> From my pov this series is ready for merging once the ACPICA changes
> are accepted.

I agree, please resubmit as soon as the upstream ACPICA pull request
gets merged.

Thanks!
--===============6449219243909065471==--

