Content-Type: multipart/mixed; boundary="===============1051694764939402981=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] handle Linux systems without /dev/mem
Date: Tue, 16 Jun 2015 00:33:54 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802731DEA@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 557F46C2.10904@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1051694764939402981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Al Stone [mailto:ahs3(a)redhat.com]
> Sent: Tuesday, June 16, 2015 5:42 AM
> =

> On 06/14/2015 07:13 PM, Zheng, Lv wrote:
> > Hi,
> >
> >> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Zheng, Lv
> >> Sent: Monday, June 15, 2015 8:49 AM
> >>
> >> Hi,
> >>
> >>> From: Zheng, Lv
> >>> Sent: Monday, June 15, 2015 8:40 AM
> >>>
> >>> Hi,
> >>>
> >>>> From: Al Stone [mailto:ahs3(a)redhat.com]
> >>>> Sent: Saturday, June 13, 2015 6:00 AM
> >>>>
> >>>> On 06/09/2015 12:16 AM, Zheng, Lv wrote:
> >>>>> Hi,
> >>>>>
> >>>>> The patch is wrong.
> >>>>> If we want to dump tables without accessing /dev/mem, we have acpid=
ump -c.
> >>>>> The only problem here is:
> >>>>> There is a bug that even with -c specified, acpidump cannot work wi=
thout accessing /dev/mem.
> >>>>> So we shouldn't introduce a new portable acpidump OSL but should fi=
x the very problem.
> >>>>>
> >>>>> We've noticed the similar issue in handling this kernel bug:
> >>>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D87971
> >>>>> The fix for this issue can be found here:
> >>>>> https://github.com/acpica/acpica/pull/77
> >>>>>
> >>>>> Thanks and best regards
> >>>>> -Lv
> >>>>
> >>>> The problem I have with this fix for the issue is that this command:
> >>>>
> >>>> 	# acpidump -n APIC
> >>>>
> >>>> will work on x86 but fail on arm64.  Getting the -c option to work p=
roperly
> >>>> is a good thing, and should be done regardless.  But, this means we =
have to
> >>>> use "acpidump -c -n APIC" on systems without /dev/mem.  For my part:
> >>>>
> >>>>    (a) these are not really customized tables, but the standard ACPI=
 tables
> >>>>        used to boot the system, so using -c is a little confusing, a=
nd
> >>>>
> >>>>    (b) we now have to use different commands on different architectu=
res to
> >>>>        get the same result.
> >>>>
> >>>> My preference would be that the same command has the same behavior e=
verywhere,
> >>>> which is why I patched it the way I did.
> >>>
> >>> This is not our preference, though...
> >>> I've been in the trouble of being easily confused by the bug reporter=
s.
> >>> And I cannot distinguish if the table has been customized or root cau=
se the bugs if the reporter did what I asked for but hid what
> he
> >>> silently did.
> >>> If we cannot distinguish the BIOS provided tables and the user custom=
ized tables from users' output, we'll likely lose the capability
> of
> >>> taking evidence...
> >>>
> >>>>
> >>>> This happens to be very useful on arm64 where /dev/mem is not reliab=
le, but it
> >>>> could also be usable on any system that does not want to expose /dev=
/mem for
> >>>> some reason.  I think the advantage of the patch sent is that the us=
er command
> >>>> stays the same no matter what the situation.
> >>>
> >>> My suggestion would be to support this via kernel.
> >>> Let the kernel exposes 2 kind of tables (customized or not customized=
) into the /sys/firmware/acpi/tables.
> >>> Which can meet both of the requirements.
> >>
> >> Or we currently can make the "-c" mode the default behavior and add a =
new option for dumping the BIOS tables.
> >
> > And you can check if this commit is acceptable:
> > https://github.com/acpica/acpica/pull/80
> =

> Hrm.  I guess if we have to have the -c option, I would prefer the first =
patch
> where we just get rid of the dependence on /dev/mem.  I think it is easie=
r to
> explain that -c must always be used rather than trying to explain how to =
use
> the -c on/off options.

We can switch this option back when the support is ready.

> =

> I think the path I would like to see long term is to split up /sys as you
> suggested so that there is a run-time version of the ACPI tables, and a c=
opy
> of the tables from UEFI.  That way, no one has to rely on /dev/mem at all,
> and acpidump can go back to parameters operating exactly the same way on =
all
> possible platforms.

Removing the dependency of /dev/mem and exporting BIOS table via /sys or ev=
en better - making all acpidump functionalities a part of the kernel.
I think we need to add one more pointer in acpi_table_desc first.

Thanks and best regards
-Lv

> =

> > Thanks and best regards
> > -Lv
> >
> >>
> >> Thanks and best regards
> >> -Lv
> >>
> >>
> >>>
> >>> Thanks and best regards
> >>> -Lv
> >>>
> >>>>
> >>>>>> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Al St=
one
> >>>>>> Sent: Thursday, June 04, 2015 8:43 AM
> >>>>>>
> >>>>>> On arm64 systems in particular, the use of /dev/mem is not recomme=
nded.  The
> >>>>>> contents may or may not be valid depending on the memory map being=
 used, since
> >>>>>> they are not standardized.
> >>>>>>
> >>>>>> The attached patch will cause arm64 (aka ARMv8 or AArch64) Linux s=
ystems to
> >>>>>> use a new file called source/os_specific/service_layers/oslinuxtbl=
_nodevmem.c
> >>>>>> (a subset of the oslinuxtbl.c code) that allows acpidump to read a=
ll ACPI
> >>>>>> tables from /sys/firmware/acpi instead of from /dev/mem.  This wil=
l help ensure
> >>>>>> that the tables retrieved are the ones actually being used and tha=
t their
> >>>>>> content is correct.
> >>>>>>
> >>>>>> This patch applies on top of the 20150515 version, and I have incl=
uded it in
> >>>>>> the 20150515-2 versions of the Fedora and Debian packages.  I've t=
ried the
> >>>>>> resulting acpidump on x86, x86_64 and arm64 systems and it seems t=
o work well.
> >>>>>>
> >>>>>> Signed-off-by: Al Stone <ahs3(a)redhat.com>
> >>>>>>
> >>>>>> --
> >>>>>> ciao,
> >>>>>> al
> >>>>>> -----------------------------------
> >>>>>> Al Stone
> >>>>>> Software Engineer
> >>>>>> Red Hat, Inc.
> >>>>>> ahs3(a)redhat.com
> >>>>>> -----------------------------------
> >>>>
> >>>>
> >>>> --
> >>>> ciao,
> >>>> al
> >>>> -----------------------------------
> >>>> Al Stone
> >>>> Software Engineer
> >>>> Red Hat, Inc.
> >>>> ahs3(a)redhat.com
> >>>> -----------------------------------
> >> _______________________________________________
> >> Devel mailing list
> >> Devel(a)acpica.org
> >> https://lists.acpica.org/mailman/listinfo/devel
> =

> =

> --
> ciao,
> al
> -----------------------------------
> Al Stone
> Software Engineer
> Red Hat, Inc.
> ahs3(a)redhat.com
> -----------------------------------

--===============1051694764939402981==--

