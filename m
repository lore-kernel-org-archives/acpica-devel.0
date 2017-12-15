Content-Type: multipart/mixed; boundary="===============6663376947423626187=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v3 1/3] acpi: HMAT support in
 acpi_parse_entries_array()
Date: Fri, 15 Dec 2017 01:49:47 +0100
Message-ID: <CAJZ5v0iBoUpUK-RFq6Hn7OrJY+ZaVk7qnXpntwUjTo15KmTtZg@mail.gmail.com>
In-Reply-To: 20171214021019.13579-2-ross.zwisler@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6663376947423626187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2017 at 3:10 AM, Ross Zwisler
<ross.zwisler(a)linux.intel.com> wrote:
> The current implementation of acpi_parse_entries_array() assumes that each
> subtable has a standard ACPI subtable entry of type struct
> acpi_subtable_header.  This standard subtable header has a one byte length
> followed by a one byte type.
>
> The HMAT subtables have to allow for a longer length so they have subtable
> headers of type struct acpi_hmat_structure which has a 2 byte type and a 4
> byte length.
>
> Enhance the subtable parsing in acpi_parse_entries_array() so that it can
> handle these new HMAT subtables.
>
> Signed-off-by: Ross Zwisler <ross.zwisler(a)linux.intel.com>

This one is fine by me.

--===============6663376947423626187==--

