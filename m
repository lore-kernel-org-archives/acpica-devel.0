Content-Type: multipart/mixed; boundary="===============6920126445716912265=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH 05/11] drivers: acpi: Include appropriate header
 file in utstate.c
Date: Wed, 18 Dec 2013 06:17:33 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88024987F6@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37C7B99F5@ORSMSX103.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6920126445716912265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Currently we didn't do much on automatically optimized out ACPI_FUTURE_USAG=
E functions as long as they do not affect the generation of vmlinux binary.

> From: Moore, Robert
> Sent: Wednesday, December 18, 2013 1:36 AM
> =

> I'm not sure what version of ACPICA you are looking at, but in the master=
 git tree for ACPICA, the file accommon.h includes "acutils.h".
> =

> > -----Original Message-----
> > From: Rashika Kheria [mailto:rashika.kheria(a)gmail.com]
> > Sent: Tuesday, December 17, 2013 1:22 AM
> > To: linux-kernel(a)vger.kernel.org
> > Cc: Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len Brown; linux-
> > acpi(a)vger.kernel.org; josh(a)joshtriplett.org; devel(a)acpica.org
> > Subject: [PATCH 05/11] drivers: acpi: Include appropriate header file in
> > utstate.c
> >
> > Include appropriate header file acutils.h in acpica/utstate.c because
> > function acpi_ut_create_pkg_state_and_push() has its prototype declarat=
ion
> > in acutils.h. Also, encloses the function in acpica/utstate.c in ifdef
> > condition of ACPI_FUTURE_USAGE.
> >
> > This eliminates the following warning in utstate.c:
> > drivers/acpi/acpica/utstate.c:64:1: warning: no previous prototype for
> > =E2=80=98acpi_ut_create_pkg_state_and_push=E2=80=99 [-Wmissing-prototyp=
es]
> >
> > Signed-off-by: Rashika Kheria <rashika.kheria(a)gmail.com>
> > Reviewed-by: Josh Triplett <josh(a)joshtriplett.org>
> > ---
> >  drivers/acpi/acpica/utstate.c |    3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/acpi/acpica/utstate.c b/drivers/acpi/acpica/utstat=
e.c
> > index 03c4c2f..0920d23 100644
> > --- a/drivers/acpi/acpica/utstate.c
> > +++ b/drivers/acpi/acpica/utstate.c
> > @@ -43,6 +43,7 @@
> >
> >  #include <acpi/acpi.h>
> >  #include "accommon.h"
> > +#include "acutils.h"

IMO, this line is useless.

> >
> >  #define _COMPONENT          ACPI_UTILITIES
> >  ACPI_MODULE_NAME("utstate")
> > @@ -60,6 +61,7 @@ ACPI_MODULE_NAME("utstate")
> >   * DESCRIPTION: Create a new state and push it
> >   *
> >
> > ***********************************************************************=
***
> > ****/
> > +#ifdef  ACPI_FUTURE_USAGE
> >  acpi_status
> >  acpi_ut_create_pkg_state_and_push(void *internal_object,
> >  				  void *external_object,
> > @@ -79,6 +81,7 @@ acpi_ut_create_pkg_state_and_push(void *internal_obje=
ct,
> >  	acpi_ut_push_generic_state(state_list, state);
> >  	return (AE_OK);
> >  }
> > +#endif

IMO, these lines are useful.
I have a plan to do a cleanup on all ACPICA build warnings so that such inc=
onsistencies can be sorted out.
Maybe it is time to do it right now.

Thanks
-Lv

> >
> >
> > /**********************************************************************=
***
> > ******
> >   *
> > --
> > 1.7.9.5


--===============6920126445716912265==--

