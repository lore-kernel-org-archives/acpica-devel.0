Content-Type: multipart/mixed; boundary="===============5672411511335902201=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: Re: [Devel] [PATCH] handle Linux systems without /dev/mem
Date: Mon, 15 Jun 2015 15:36:47 -0600
Message-ID: <557F456F.5060904@redhat.com>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E8802730A2E@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5672411511335902201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 06/14/2015 06:39 PM, Zheng, Lv wrote:
> Hi, =

> =

>> From: Al Stone [mailto:ahs3(a)redhat.com]
>> Sent: Saturday, June 13, 2015 6:00 AM
>>
>> On 06/09/2015 12:16 AM, Zheng, Lv wrote:
>>> Hi,
>>>
>>> The patch is wrong.
>>> If we want to dump tables without accessing /dev/mem, we have acpidump =
-c.
>>> The only problem here is:
>>> There is a bug that even with -c specified, acpidump cannot work withou=
t accessing /dev/mem.
>>> So we shouldn't introduce a new portable acpidump OSL but should fix th=
e very problem.
>>>
>>> We've noticed the similar issue in handling this kernel bug:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D87971
>>> The fix for this issue can be found here:
>>> https://github.com/acpica/acpica/pull/77
>>>
>>> Thanks and best regards
>>> -Lv
>>
>> The problem I have with this fix for the issue is that this command:
>>
>> 	# acpidump -n APIC
>>
>> will work on x86 but fail on arm64.  Getting the -c option to work prope=
rly
>> is a good thing, and should be done regardless.  But, this means we have=
 to
>> use "acpidump -c -n APIC" on systems without /dev/mem.  For my part:
>>
>>    (a) these are not really customized tables, but the standard ACPI tab=
les
>>        used to boot the system, so using -c is a little confusing, and
>>
>>    (b) we now have to use different commands on different architectures =
to
>>        get the same result.
>>
>> My preference would be that the same command has the same behavior every=
where,
>> which is why I patched it the way I did.
> =

> This is not our preference, though...
> I've been in the trouble of being easily confused by the bug reporters.
> And I cannot distinguish if the table has been customized or root cause t=
he bugs if the reporter did what I asked for but hid what he silently did.
> If we cannot distinguish the BIOS provided tables and the user customized=
 tables from users' output, we'll likely lose the capability of taking evid=
ence...

Understood; I was in technical support roles for many years.

Perhaps I am misunderstanding this use of the word "customized."  On ARM, t=
he
only way I can be sure to get the tables supplied by UEFI is to use the UEFI
shell and dump them.  Once the OS has booted, the tables in /sys/firmware/a=
cpi
are what the system is currently using, and those are the ones I'm interest=
ed
in using for debugging when something breaks.  So, unless I have replaced t=
he
DSDT in the initrd, or added SSDTs, /sys/firmware/acpi will be exactly the =
same
as what UEFI provided.  Even then, those are the tables I want to see if th=
ere
is a problem since those are the ones being used.  Is that what "customized"
means, in this case: the actual run-time tables and not the tables provided=
 by
UEFI?

>> This happens to be very useful on arm64 where /dev/mem is not reliable, =
but it
>> could also be usable on any system that does not want to expose /dev/mem=
 for
>> some reason.  I think the advantage of the patch sent is that the user c=
ommand
>> stays the same no matter what the situation.
> =

> My suggestion would be to support this via kernel.
> Let the kernel exposes 2 kind of tables (customized or not customized) in=
to the /sys/firmware/acpi/tables.
> Which can meet both of the requirements.

Okay, this sort of answers my questions.  "Customized" is not the word I wo=
uld
have chosen for this -- I think I would have made it
/sys/firmware/acpi/tables/current (i.e., "customized") and
/sys/firmware/acpi/tables/boot (i.e.,
not "customized").  When I was thinking of tables as being customized, I was
thinking of new versions of all kinds of tables, not just the DSDT and SSDT=
s.
On ARM, going in and out of ACPI mode is just not allowed so there's really=
 no
opportunity to customize the tables much, other than adding SSDTs.

Creating new sysfs entries in a kernel driver would be simple enough to do;
the issue would be getting it accepted.  On x86, there's no guarantee that
the BIOS tables and run-time tables are the same, so customized and not
customized may be very different, and these kernel changes would make sense.
On ARMv8, the boot and run-time tables will be essentially identical most of
the time so it's not clear there's a lot of value in adding more stuff to
sysfs.  If I create this kernel code, though, it seems to me it would make
sense to change acpidump so it does not use /dev/mem for any architecture, =
but
always uses sysfs on all architectures -- do you agree?

I'll take a look at doing this on the kernel side...

> Thanks and best regards
> -Lv
> =

>>
>>>> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Al Stone
>>>> Sent: Thursday, June 04, 2015 8:43 AM
>>>>
>>>> On arm64 systems in particular, the use of /dev/mem is not recommended=
.  The
>>>> contents may or may not be valid depending on the memory map being use=
d, since
>>>> they are not standardized.
>>>>
>>>> The attached patch will cause arm64 (aka ARMv8 or AArch64) Linux syste=
ms to
>>>> use a new file called source/os_specific/service_layers/oslinuxtbl_nod=
evmem.c
>>>> (a subset of the oslinuxtbl.c code) that allows acpidump to read all A=
CPI
>>>> tables from /sys/firmware/acpi instead of from /dev/mem.  This will he=
lp ensure
>>>> that the tables retrieved are the ones actually being used and that th=
eir
>>>> content is correct.
>>>>
>>>> This patch applies on top of the 20150515 version, and I have included=
 it in
>>>> the 20150515-2 versions of the Fedora and Debian packages.  I've tried=
 the
>>>> resulting acpidump on x86, x86_64 and arm64 systems and it seems to wo=
rk well.
>>>>
>>>> Signed-off-by: Al Stone <ahs3(a)redhat.com>
>>>>
>>>> --
>>>> ciao,
>>>> al
>>>> -----------------------------------
>>>> Al Stone
>>>> Software Engineer
>>>> Red Hat, Inc.
>>>> ahs3(a)redhat.com
>>>> -----------------------------------
>>
>>
>> --
>> ciao,
>> al
>> -----------------------------------
>> Al Stone
>> Software Engineer
>> Red Hat, Inc.
>> ahs3(a)redhat.com
>> -----------------------------------


-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============5672411511335902201==--

