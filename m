Content-Type: multipart/mixed; boundary="===============5962337718623594183=="
MIME-Version: 1.0
From: Andriy Gapon <avg at FreeBSD.org>
Subject: [Devel] AcpiGetEventStatus: interface with behavior
Date: Wed, 26 Dec 2012 10:42:15 +0200
Message-ID: <50DAB867.4050402@FreeBSD.org>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5962337718623594183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


AcpiGetEventStatus has an out parameter of type ACPI_EVENT_STATUS.
My impression that values of that type should conform to bit definitions
provided near the type declaration (ACPI_EVENT_FLAG_ENABLED,
ACPI_EVENT_FLAG_SET, etc).
But it seems that currently AcpiGetEventStatus returns only values zero and=
 one
corresponding to inactive and active status.

The linux (adaption of the) code here
http://lxr.linux.no/#linux+v3.7.1/drivers/acpi/acpica/evxfevnt.c#L313
seems to be a bit more elaborate.  It actually tries to produce a value that
conforms to the definitions by examining not only the status register but a=
lso
enable register.

It looks like AcpiHwGetGpeStatus is the model for how ACPI_EVENT_STATUS sho=
uld
be populated.  I am not sure if AcpiGetEventStatus should be made compatible
with ACPI_EVENT_STATUS or if its out type should be changed to something el=
se.

Also, it looks that the comment near ACPI_EVENT_STATUS definitions is a lit=
tle
bit out of sync.

-- =

Andriy Gapon

--===============5962337718623594183==--

