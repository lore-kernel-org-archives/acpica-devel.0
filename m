Content-Type: multipart/mixed; boundary="===============0753573385399508269=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: Re: [Devel] [PATCH v2 1/5] ACPI: move acpi_os_handler() so it can be
 made arch-dependent later
Date: Wed, 04 Feb 2015 22:44:53 +0000
Message-ID: <54D2A0E2.8050504@redhat.com>
In-Reply-To: 3836210.OLr0JokInG@vostro.rjw.lan
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0753573385399508269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 02/04/2015 06:50 AM, Rafael J. Wysocki wrote:
> On Tuesday, February 03, 2015 05:21:40 PM al.stone(a)linaro.org wrote:
>> From: Al Stone <al.stone(a)linaro.org>
>>
>> In order to deprecate the use of _OSI for arm64 or other new architectur=
es,
>> we need to make the default handler something we can change for various
>> platforms.  This patch moves the definition of acpi_osi_handler() -- the
>> function used by ACPICA as a callback for evaluating _OSI -- into a sepa=
rate
>> file.  Subsequent patches will change which files get built so that we c=
an
>> then build the version of _OSI we need for a particular architecture.
>>
>> There is no functional change.
>>
>> Signed-off-by: Al Stone <al.stone(a)linaro.org>
>> ---
>>  drivers/acpi/Makefile |   2 +-
>>  drivers/acpi/osi.c    | 100 +++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  drivers/acpi/osl.c    |  24 ------------
>>  include/linux/acpi.h  |   1 +
>>  4 files changed, 102 insertions(+), 25 deletions(-)
>>  create mode 100644 drivers/acpi/osi.c
>>
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index c346011..df348b3 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -18,7 +18,7 @@ obj-y				+=3D acpi.o \
>>  					acpica/
>>  =

>>  # All the builtin files are in the "acpi." module_param namespace.
>> -acpi-y				+=3D osl.o utils.o reboot.o
>> +acpi-y				+=3D osl.o utils.o reboot.o osi.o
>>  acpi-y				+=3D nvs.o
>>  =

>>  # Power management related files
>> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
>> new file mode 100644
>> index 0000000..fff2b0c
>> --- /dev/null
>> +++ b/drivers/acpi/osi.c
>> @@ -0,0 +1,100 @@
>> +/*
>> + *  osi.c - _OSI implementation (moved from drivers/acpi/osl.c)
>> + *
>> + *  Copyright (C) 2000       Andrew Henroid
>> + *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover(a)intel.com>
>> + *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh(a)int=
el.com>
>> + *  Copyright (c) 2008 Intel Corporation
>> + *   Author: Matthew Wilcox <willy(a)linux.intel.com>
>> + *
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License as published by
>> + *  the Free Software Foundation; either version 2 of the License, or
>> + *  (at your option) any later version.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
> =

> Nit: The street address of the FSF is not really useful here.  What if th=
ey move? :-)

This was one of the things checkpatch complained about, understandably :). =
 It's
a direct cut'n'paste from osl.c.

I can clean these up in the new file; would it help to clean up osl.c (at l=
east
from checkpatch's point of view), as long as I'm at it?

>> + *
>> + *  You should have received a copy of the GNU General Public License
>> + *  along with this program; if not, write to the Free Software
>> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7  USA
>> + *
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
>> + *
>> + */
[snip...]

-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============0753573385399508269==--

