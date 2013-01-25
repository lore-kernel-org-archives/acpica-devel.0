Content-Type: multipart/mixed; boundary="===============1837156725647173223=="
MIME-Version: 1.0
From: Andriy Gapon <avg at FreeBSD.org>
Subject: Re: [Devel] AcpiGetEventStatus: interface with behavior
Date: Fri, 25 Jan 2013 10:22:59 +0200
Message-ID: <510240E3.8060603@FreeBSD.org>
In-Reply-To: 50DAB867.4050402@FreeBSD.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1837156725647173223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


[ping]

on 26/12/2012 10:42 Andriy Gapon said the following:
> =

> AcpiGetEventStatus has an out parameter of type ACPI_EVENT_STATUS.
> My impression that values of that type should conform to bit definitions
> provided near the type declaration (ACPI_EVENT_FLAG_ENABLED,
> ACPI_EVENT_FLAG_SET, etc).
> But it seems that currently AcpiGetEventStatus returns only values zero a=
nd one
> corresponding to inactive and active status.
> =

> The linux (adaption of the) code here
> http://lxr.linux.no/#linux+v3.7.1/drivers/acpi/acpica/evxfevnt.c#L313
> seems to be a bit more elaborate.  It actually tries to produce a value t=
hat
> conforms to the definitions by examining not only the status register but=
 also
> enable register.
> =

> It looks like AcpiHwGetGpeStatus is the model for how ACPI_EVENT_STATUS s=
hould
> be populated.  I am not sure if AcpiGetEventStatus should be made compati=
ble
> with ACPI_EVENT_STATUS or if its out type should be changed to something =
else.
> =

> Also, it looks that the comment near ACPI_EVENT_STATUS definitions is a l=
ittle
> bit out of sync.
> =



-- =

Andriy Gapon

--===============1837156725647173223==--

