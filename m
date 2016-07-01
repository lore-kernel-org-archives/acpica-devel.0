Content-Type: multipart/mixed; boundary="===============5309579650002083641=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 3/6] ACPICA: make use of new strtolower() function
Date: Fri, 01 Jul 2016 04:32:12 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4C388A@ORSMSX110.amr.corp.intel.com>
In-Reply-To: CAGt4E5tRhiFtx-JsB2unQ2JMMZRv9Td_5jXcU9N4wG_Taedqng@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5309579650002083641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Markus Mayer [mailto:markus.mayer(a)broadcom.com]
> Sent: Thursday, June 30, 2016 9:13 PM
> To: Moore, Robert
> Cc: Zheng, Lv; Wysocki, Rafael J; Len Brown; linux-acpi(a)vger.kernel.org;
> devel(a)acpica.org; linux-kernel(a)vger.kernel.org; Box, David E
> Subject: Re: [PATCH 3/6] ACPICA: make use of new strtolower() function
> =

> On 30 June 2016 at 19:59, Moore, Robert <robert.moore(a)intel.com> wrote:
> > This is linux-specific code, ACPICA is os-independent. So we cannot
> > accept such patch.
> =

> Understood. I wasn't aware that this was shared code.

Ok. Glad to take fixes and optimizations, however.
Bob



> =

> > From: Markus Mayer [mailto:markus.mayer(a)broadcom.com]
> > Sent: Thursday, June 30, 2016 7:50 PM
> > To: Moore, Robert
> > Cc: Zheng, Lv; Wysocki, Rafael J; Len Brown;
> > linux-acpi(a)vger.kernel.org; devel(a)acpica.org;
> > linux-kernel(a)vger.kernel.org; Box, David E
> > Subject: Re: [PATCH 3/6] ACPICA: make use of new strtolower() function
> >
> > On Thursday, 30 June 2016, Moore, Robert <robert.moore(a)intel.com> wro=
te:
> >
> > Where is "strtolower" implemented?
> >
> > First patch of the series:
> >
> > https://lkml.org/lkml/2016/6/30/733
> >
> >> -----Original Message-----
> >> From: Markus Mayer [mailto:mmayer(a)broadcom.com]
> >> Sent: Thursday, June 30, 2016 4:50 PM
> >> To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len Brown
> >> Cc: Markus Mayer; linux-acpi(a)vger.kernel.org; devel(a)acpica.org;
> >> linux- kernel(a)vger.kernel.org
> >> Subject: [PATCH 3/6] ACPICA: make use of new strtolower() function
> >>
> >> Call strtolower() rather than walking the string explicitly to
> >> convert it to lowercase.
> >>
> >> Signed-off-by: Markus Mayer <mmayer(a)broadcom.com>
> >> ---
> >>
> >> *** Please note that there don't seem to be any callers of
> >> acpi_ut_strlwr().
> >> *** It may be possible to remove the function altogether.
> >>
> >>  drivers/acpi/acpica/utnonansi.c | 13 +------------
> >>  1 file changed, 1 insertion(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/acpi/acpica/utnonansi.c
> >> b/drivers/acpi/acpica/utnonansi.c index 3465fe2..b6e11dc 100644
> >> --- a/drivers/acpi/acpica/utnonansi.c
> >> +++ b/drivers/acpi/acpica/utnonansi.c
> >> @@ -64,19 +64,8 @@ ACPI_MODULE_NAME("utnonansi")
> >>
> >> *********************************************************************
> >> *****
> >> ****/
> >>  void acpi_ut_strlwr(char *src_string)  {
> >> -     char *string;
> >> -
> >>       ACPI_FUNCTION_ENTRY();
> >> -
> >> -     if (!src_string) {
> >> -             return;
> >> -     }
> >> -
> >> -     /* Walk entire string, lowercasing the letters */
> >> -
> >> -     for (string =3D src_string; *string; string++) {
> >> -             *string =3D (char)tolower((int)*string);
> >> -     }
> >> +     strtolower(src_string);
> >>  }
> >>
> >>
> >> /********************************************************************
> >> *****
> >> ******
> >> --
> >> 2.7.4

--===============5309579650002083641==--

