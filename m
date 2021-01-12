Content-Type: multipart/mixed; boundary="===============3630080493476747932=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v5 00/15] Add functionality to ipu3-cio2 driver
 allowing software_node connections to sensors on platforms designed for
 Windows
Date: Tue, 12 Jan 2021 20:34:03 +0100
Message-ID: <CAJZ5v0gb9c-kWM4aAKm6UqbVKt7dyp6xJS5E=7yoPRnPP+msbw@mail.gmail.com>
In-Reply-To: 20210107132838.396641-1-djrscally@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3630080493476747932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 7, 2021 at 2:30 PM Daniel Scally <djrscally(a)gmail.com> wrote:
>
>
> Hello all
>
> v4:
> https://lore.kernel.org/linux-media/20210103231235.792999-1-djrscally(a)g=
mail.com/T/#m11b7cb977e1b73fba1e625c3d6a189e2943a7783
> v3:
> https://lore.kernel.org/linux-media/20201224010907.263125-1-djrscally(a)g=
mail.com/T/#m37b831bb2b406917d6db5da9acf9ed35df65d72d
> v2:
> https://lore.kernel.org/linux-media/20201217234337.1983732-1-djrscally(a)=
gmail.com/T/#md93fd090009b42a6a98aed892aff0d38cf07e0cd
> v1:
> https://lore.kernel.org/linux-media/20201130133129.1024662-1-djrscally(a)=
gmail.com/T/#m91934e12e3d033da2e768e952ea3b4a125ee3e67
>
> This series is to start adding support for webcams on laptops with ACPI t=
ables
> designed for use with CIO2 on Windows. This series extends the ipu3-cio2
> driver to allow for patching the firmware via software_nodes if endpoints
> aren't defined by ACPI.
>
> I'm hopeful that most or all of this series could get picked up for 5.12.
> We touch a few different areas (listed below), but I think the easiest
> approach would be to merge everything through media tree. Rafael, Greg,
> Mauro and Sergey; are you ok with that plan, or would you prefer a
> different approach? Mauro; if that plan is ok (and of course assuming that
> the rest of the patches are acked by their respective maintainers) could
> we get a dedicated feature branch just in case the following series ends
> up being ready in time too?
>
> lib
>   lib/test_printf.c: Use helper function to unwind array of
>     software_nodes
>
> base
>   software_node: Fix refcounts in software_node_get_next_child()
>   property: Return true in fwnode_device_is_available for NULL ops
>   property: Call fwnode_graph_get_endpoint_by_id() for fwnode->secondary
>   software_node: Enforce parent before child ordering of nodes arrays
>   software_node: unregister software_nodes in reverse order
>   include: fwnode.h: Define format macros for ports and endpoints
>
> acpi
>   acpi: Add acpi_dev_get_next_match_dev() and helper macro
>
> media
>   media: v4l2-core: v4l2-async: Check sd->fwnode->secondary in
>     match_fwnode()
>   ipu3-cio2: Add T: entry to MAINTAINERS
>   ipu3-cio2: Rename ipu3-cio2.c
>   ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
>   include: media: v4l2-fwnode: Include v4l2_fwnode_bus_type
>
> Series-level changelog:
>         - Rebased onto 5.11-rc1
>
> Thanks
> Dan
>
> Andy Shevchenko (1):
>   media: ipu3-cio2: Add headers that ipu3-cio2.h is direct user of
>
> Daniel Scally (13):
>   software_node: Fix refcounts in software_node_get_next_child()
>   device property: Return true in fwnode_device_is_available for NULL
>     ops
>   device property: Call fwnode_graph_get_endpoint_by_id() for
>     fwnode->secondary
>   software_node: Enforce parent before child ordering of nodes arrays
>   software_node: unregister software_nodes in reverse order
>   device property: Define format macros for ports and endpoints
>   lib/test_printf.c: Use helper function to unwind array of
>     software_nodes
>   ipu3-cio2: Add T: entry to MAINTAINERS
>   ipu3-cio2: Rename ipu3-cio2.c
>   media: v4l2-core: v4l2-async: Check sd->fwnode->secondary in
>     match_fwnode()
>   ACPI / bus: Add acpi_dev_get_next_match_dev() and helper macro
>   media: v4l2-fwnode: Include v4l2_fwnode_bus_type
>   ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
>
> Heikki Krogerus (1):
>   software_node: Add support for fwnode_graph*() family of functions

Please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>

to all of the device properties patches in this series if that helps.

Thanks!
--===============3630080493476747932==--

