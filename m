Content-Type: multipart/mixed; boundary="===============0859259877430789303=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH v2] acpi: Use kstrtoul() instead of
 strtoul()/simple_strtoul()
Date: Fri, 06 Nov 2015 16:21:41 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D991668@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 55BDD287.70004@roeck-us.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0859259877430789303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


> Subject: Re: [PATCH v2] acpi: Use kstrtoul() instead of
> strtoul()/simple_strtoul()

So, this would fix the issue(s) (in aclinux.h):

#define strtoul                     kstrtoul



strtoul is used frequently in with the ACPICA in-kernel AML Debugger:

dbcmds.c(188):        Address =3D strtoul (InString, NULL, 16);
dbcmds.c(266):    SleepState =3D (UINT8) strtoul (ObjectArg, NULL, 0);
dbcmds.c(1283):    GpeNumber =3D strtoul (GpeArg, NULL, 0);
dbcmds.c(1291):        BlockNumber =3D strtoul (BlockArg, NULL, 0);
dbdisply.c(213):    Address =3D strtoul (Target, NULL, 16);
dbdisply.c(749):    Handle =3D ACPI_TO_POINTER (strtoul (ObjectArg, NULL, 1=
6));
dbexec.c(769):    NumThreads =3D strtoul (NumThreadsArg, NULL, 0);
dbexec.c(770):    NumLoops =3D strtoul (NumLoopsArg, NULL, 0);
dbhistry.c(292):        CmdNum =3D strtoul (CommandNumArg, NULL, 0);
dbinput.c(1018):                strtoul (AcpiGbl_DbArgs[1], NULL, 16);
dbinput.c(1026):            AcpiGbl_DbDebugLevel =3D strtoul (AcpiGbl_DbArg=
s[1], NULL, 16);
dbinput.c(1060):        Temp =3D strtoul (AcpiGbl_DbArgs[2], NULL, 0);
dbmethod.c(162):    Address =3D strtoul (Location, NULL, 16);
dbmethod.c(249):    Value =3D strtoul (ValueArg, NULL, 16);
dbmethod.c(271):    Index =3D strtoul (IndexArg, NULL, 16);
dbmethod.c(381):        NumStatements =3D strtoul (Statements, NULL, 0);
dbnames.c(334):            MaxDepth =3D strtoul (DepthArg, NULL, 0);
dbnames.c(405):    OwnerId =3D (ACPI_OWNER_ID) strtoul (OwnerArg, NULL, 0);
dbnames.c(411):        MaxDepth =3D strtoul (DepthArg, NULL, 0);
dbnames.c(990):    Address =3D strtoul (ObjectArg, NULL, 16);
dbtest.c(1046):        Info.MaxCount =3D strtoul (CountArg, NULL, 0);






> -----Original Message-----
> From: Guenter Roeck [mailto:linux(a)roeck-us.net]
> Sent: Sunday, August 02, 2015 1:19 AM
> To: Pavel Machek
> Cc: rjw(a)rjwysocki.net; lenb(a)kernel.org; Moore, Robert; Zheng, Lv; lin=
ux-
> acpi(a)vger.kernel.org; linux-kernel(a)vger.kernel.org; devel(a)acpica.org
> Subject: Re: [PATCH v2] acpi: Use kstrtoul() instead of
> strtoul()/simple_strtoul()
> =

> On 08/02/2015 12:16 AM, Pavel Machek wrote:
> > On Mon 2015-07-27 17:32:22, Guenter Roeck wrote:
> >> simple_strtoul() is deprecated; replace with kstrtoul() and
> kstrtouint().
> >> Return an error if the value passed to the sysfs attribute is not a
> >> number.
> >>
> >> Drop the definition of strtoul() since it is no longer needed.
> >>
> >> Signed-off-by: Guenter Roeck <linux(a)roeck-us.net>
> >> ---
> >> v2: An additional use of strtoul() was introduced with commit 4fa4616e.
> >>      Replace it as well.
> >>
> >>   drivers/acpi/acpica/evgpeinit.c | 5 +++--
> >>   drivers/acpi/sysfs.c            | 8 ++++++--
> >>   include/acpi/platform/aclinux.h | 1 -
> >>   3 files changed, 9 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/acpi/acpica/evgpeinit.c
> >> b/drivers/acpi/acpica/evgpeinit.c index ea4c0d3fca2d..aa1e8c1f2d4a
> >> 100644
> >> --- a/drivers/acpi/acpica/evgpeinit.c
> >> +++ b/drivers/acpi/acpica/evgpeinit.c
> >> @@ -326,6 +326,7 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
> >>   	u32 gpe_number;
> >>   	char name[ACPI_NAME_SIZE + 1];
> >>   	u8 type;
> >> +	int err;
> >>
> >>   	ACPI_FUNCTION_TRACE(ev_match_gpe_method);
> >>
> >> @@ -377,8 +378,8 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
> >>
> >>   	/* 4) The last two characters of the name are the hex GPE Number
> >> */
> >>
> >> -	gpe_number =3D strtoul(&name[2], NULL, 16);
> >> -	if (gpe_number =3D=3D ACPI_UINT32_MAX) {
> >> +	er =3D kstrtouint(&name[2], 16, &gpe_number);
> >> +	if (err < 0 || gpe_number =3D=3D ACPI_UINT32_MAX) {
> >
> > Are you sure you compile-tested this?
> >
> =

> I was, but maybe not ;-). Since the patch was rejected it does not really
> matter.
> =

> Guenter


--===============0859259877430789303==--

