Content-Type: multipart/mixed; boundary="===============1980700080847774726=="
MIME-Version: 1.0
From: Ross Zwisler <ross.zwisler at linux.intel.com>
Subject: Re: [Devel] [PATCH v3 2/3] hmat: add heterogeneous memory sysfs
 support
Date: Fri, 15 Dec 2017 13:53:36 -0700
Message-ID: <20171215205336.GB5454@linux.intel.com>
In-Reply-To: CAJZ5v0h8=mh9BKa2eZzqbc12T6saB+q19yqSfRLYKOiUjS2Cjg@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1980700080847774726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 01:52:03AM +0100, Rafael J. Wysocki wrote:
<>
> > diff --git a/drivers/acpi/hmat/core.c b/drivers/acpi/hmat/core.c
> > new file mode 100644
> > index 000000000000..61b90dadf84b
> > --- /dev/null
> > +++ b/drivers/acpi/hmat/core.c
> > @@ -0,0 +1,536 @@
> > +/*
> > + * Heterogeneous Memory Attributes Table (HMAT) representation in sysfs
> > + *
> > + * Copyright (c) 2017, Intel Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITH=
OUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
> > + * more details.
> > + */
> =

> Minor nit for starters: you should use SPDX license indentifiers in
> new files and if you do so, the license boilerplace is not necessary
> any more.

Okay, I'll fix that up.

--===============1980700080847774726==--

