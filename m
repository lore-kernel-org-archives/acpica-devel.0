Content-Type: multipart/mixed; boundary="===============6574378777477865460=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] [PATCH 1/2] ACPICA: Introduce acpi_os_phys_table_override
 function
Date: Wed, 31 Aug 2011 11:28:49 +0200
Message-ID: <201108311128.50256.trenn@suse.de>
In-Reply-To: 1314758622.6486.74.camel@minggr.sh.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6574378777477865460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, August 31, 2011 04:43:42 AM Lin Ming wrote:
> On Wed, 2011-08-24 at 17:48 +0800, Thomas Renninger wrote:
...
> You add a new interface.
Yes, is this a bigger problem?

> Can we just extend the existing interface: acpi_os_table_override?
Not sure how to do that without OS/ACPICA API changes.
The virtual address handling is nasty. You have to differ
early mappings (early_ioremap) and later mappings (io/memremap).
Re-mapping later is not possible because the physical address is
lost with the current overriding interface.
The physical address usage is transparent and from what I can
see the only way to provide proper table overriding.

If it's ok to add more paramters to acpi_os_table_override and
either pass the virtual (as before) or the physical address,
this would work:
acpi_os_table_override(struct acpi_table_header *existing_table,
                      struct acpi_table_header **new_table,
                      acpi_physical_address *address, u32 *table_length);

This would be an interface change which looked even worse to me, than =

adding a new function.

   Thomas

--===============6574378777477865460==--

