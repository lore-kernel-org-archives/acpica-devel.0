Content-Type: multipart/mixed; boundary="===============0411278734740689029=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] ACPI: Also allow ACPI table adding via initrd not only
 overriding
Date: Wed, 19 Feb 2014 12:14:38 +0100
Message-ID: <2779111.V9OOdv2fEJ@skinner>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37C7D78A7@ORSMSX103.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0411278734740689029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, February 18, 2014 07:59:17 PM Moore, Robert wrote:
> Maybe not exactly "running", but at the very least, ACPICA must be
> initialized.
> =

> All of this of course depends on how early the table needs to be loaded.

I'd say as early as possible.
Not sure about Thomas' use case.
I expect most of the extra tables are needed before ACPICA gets
initialized otherwise it could have been specified to put the info
into DSDT/SSDT via ASL.
Sooner or later people will hit the "I need it earlier" limit and
patch:
ACPICA: Introduce new acpi_os_physical_table_add OS callback
shows that it can be done early and that it integrates nicely
with only some additional lines.

   Thomas

--===============0411278734740689029==--

