Content-Type: multipart/mixed; boundary="===============4093123570802674581=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] handle Linux systems without /dev/mem
Date: Tue, 16 Jun 2015 00:41:42 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802731E27@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 557F456F.5060904@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4093123570802674581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Al Stone [mailto:ahs3(a)redhat.com]
> Sent: Tuesday, June 16, 2015 5:37 AM
> =

> On 06/14/2015 06:39 PM, Zheng, Lv wrote:
> > Hi,
> >
> >> From: Al Stone [mailto:ahs3(a)redhat.com]
> >> Sent: Saturday, June 13, 2015 6:00 AM
> >>
> >> On 06/09/2015 12:16 AM, Zheng, Lv wrote:
> >>> Hi,
> >>>
> >>> The patch is wrong.
> >>> If we want to dump tables without accessing /dev/mem, we have acpidum=
p -c.
> >>> The only problem here is:
> >>> There is a bug that even with -c specified, acpidump cannot work with=
out accessing /dev/mem.
> >>> So we shouldn't introduce a new portable acpidump OSL but should fix =
the very problem.
> >>>
> >>> We've noticed the similar issue in handling this kernel bug:
> >>> https://bugzilla.kernel.org/show_bug.cgi?id=3D87971
> >>> The fix for this issue can be found here:
> >>> https://github.com/acpica/acpica/pull/77
> >>>
> >>> Thanks and best regards
> >>> -Lv
> >>
> >> The problem I have with this fix for the issue is that this command:
> >>
> >> 	# acpidump -n APIC
> >>
> >> will work on x86 but fail on arm64.  Getting the -c option to work pro=
perly
> >> is a good thing, and should be done regardless.  But, this means we ha=
ve to
> >> use "acpidump -c -n APIC" on systems without /dev/mem.  For my part:
> >>
> >>    (a) these are not really customized tables, but the standard ACPI t=
ables
> >>        used to boot the system, so using -c is a little confusing, and
> >>
> >>    (b) we now have to use different commands on different architecture=
s to
> >>        get the same result.
> >>
> >> My preference would be that the same command has the same behavior eve=
rywhere,
> >> which is why I patched it the way I did.
> >
> > This is not our preference, though...
> > I've been in the trouble of being easily confused by the bug reporters.
> > And I cannot distinguish if the table has been customized or root cause=
 the bugs if the reporter did what I asked for but hid what he
> silently did.
> > If we cannot distinguish the BIOS provided tables and the user customiz=
ed tables from users' output, we'll likely lose the capability of
> taking evidence...
> =

> Understood; I was in technical support roles for many years.
> =

> Perhaps I am misunderstanding this use of the word "customized."  On ARM,=
 the
> only way I can be sure to get the tables supplied by UEFI is to use the U=
EFI
> shell and dump them.  Once the OS has booted, the tables in /sys/firmware=
/acpi
> are what the system is currently using, and those are the ones I'm intere=
sted
> in using for debugging when something breaks.  So, unless I have replaced=
 the
> DSDT in the initrd, or added SSDTs, /sys/firmware/acpi will be exactly th=
e same
> as what UEFI provided.  Even then, those are the tables I want to see if =
there
> is a problem since those are the ones being used.  Is that what "customiz=
ed"
> means, in this case: the actual run-time tables and not the tables provid=
ed by
> UEFI?

Yes, so the "customized" tables should be dumped by default as you've sugge=
sted.

> =

> >> This happens to be very useful on arm64 where /dev/mem is not reliable=
, but it
> >> could also be usable on any system that does not want to expose /dev/m=
em for
> >> some reason.  I think the advantage of the patch sent is that the user=
 command
> >> stays the same no matter what the situation.
> >
> > My suggestion would be to support this via kernel.
> > Let the kernel exposes 2 kind of tables (customized or not customized) =
into the /sys/firmware/acpi/tables.
> > Which can meet both of the requirements.
> =

> Okay, this sort of answers my questions.  "Customized" is not the word I =
would
> have chosen for this -- I think I would have made it
> /sys/firmware/acpi/tables/current (i.e., "customized") and
> /sys/firmware/acpi/tables/boot (i.e.,
> not "customized").  When I was thinking of tables as being customized, I =
was
> thinking of new versions of all kinds of tables, not just the DSDT and SS=
DTs.
> On ARM, going in and out of ACPI mode is just not allowed so there's real=
ly no
> opportunity to customize the tables much, other than adding SSDTs.
> =

> Creating new sysfs entries in a kernel driver would be simple enough to d=
o;
> the issue would be getting it accepted.  On x86, there's no guarantee that
> the BIOS tables and run-time tables are the same, so customized and not
> customized may be very different, and these kernel changes would make sen=
se.
> On ARMv8, the boot and run-time tables will be essentially identical most=
 of
> the time so it's not clear there's a lot of value in adding more stuff to
> sysfs.  If I create this kernel code, though, it seems to me it would make
> sense to change acpidump so it does not use /dev/mem for any architecture=
, but
> always uses sysfs on all architectures -- do you agree?

IMO, we could do this better.
Users won't want to see the original BIOS tables.
So the BIOS tables needn't appear in the userspace unless required, thus we=
 could export them via debugfs.

Or even better:
We could provide some ioctl or sysctl from kernel to allow acpidump to obta=
in what it want, for example:
1. Find RSDP
2. Validate and dump a table from any address (we need to support Load/Load=
Table opcodes)

> =

> I'll take a look at doing this on the kernel side...

Thanks.

Best regards
-Lv

> =

> > Thanks and best regards
> > -Lv
> >
> >>
> >>>> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Al Stone
> >>>> Sent: Thursday, June 04, 2015 8:43 AM
> >>>>
> >>>> On arm64 systems in particular, the use of /dev/mem is not recommend=
ed.  The
> >>>> contents may or may not be valid depending on the memory map being u=
sed, since
> >>>> they are not standardized.
> >>>>
> >>>> The attached patch will cause arm64 (aka ARMv8 or AArch64) Linux sys=
tems to
> >>>> use a new file called source/os_specific/service_layers/oslinuxtbl_n=
odevmem.c
> >>>> (a subset of the oslinuxtbl.c code) that allows acpidump to read all=
 ACPI
> >>>> tables from /sys/firmware/acpi instead of from /dev/mem.  This will =
help ensure
> >>>> that the tables retrieved are the ones actually being used and that =
their
> >>>> content is correct.
> >>>>
> >>>> This patch applies on top of the 20150515 version, and I have includ=
ed it in
> >>>> the 20150515-2 versions of the Fedora and Debian packages.  I've tri=
ed the
> >>>> resulting acpidump on x86, x86_64 and arm64 systems and it seems to =
work well.
> >>>>
> >>>> Signed-off-by: Al Stone <ahs3(a)redhat.com>
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
> >>
> >>
> >> --
> >> ciao,
> >> al
> >> -----------------------------------
> >> Al Stone
> >> Software Engineer
> >> Red Hat, Inc.
> >> ahs3(a)redhat.com
> >> -----------------------------------
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

--===============4093123570802674581==--

