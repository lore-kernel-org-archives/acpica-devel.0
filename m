Content-Type: multipart/mixed; boundary="===============7257171364318116364=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: Re: [Devel] [PATCH] handle Linux systems without /dev/mem
Date: Mon, 15 Jun 2015 15:42:26 -0600
Message-ID: <557F46C2.10904@redhat.com>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E8802730A72@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7257171364318116364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 06/14/2015 07:13 PM, Zheng, Lv wrote:
> Hi,
> =

>> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Zheng, Lv
>> Sent: Monday, June 15, 2015 8:49 AM
>>
>> Hi,
>>
>>> From: Zheng, Lv
>>> Sent: Monday, June 15, 2015 8:40 AM
>>>
>>> Hi,
>>>
>>>> From: Al Stone [mailto:ahs3(a)redhat.com]
>>>> Sent: Saturday, June 13, 2015 6:00 AM
>>>>
>>>> On 06/09/2015 12:16 AM, Zheng, Lv wrote:
>>>>> Hi,
>>>>>
>>>>> The patch is wrong.
>>>>> If we want to dump tables without accessing /dev/mem, we have acpidum=
p -c.
>>>>> The only problem here is:
>>>>> There is a bug that even with -c specified, acpidump cannot work with=
out accessing /dev/mem.
>>>>> So we shouldn't introduce a new portable acpidump OSL but should fix =
the very problem.
>>>>>
>>>>> We've noticed the similar issue in handling this kernel bug:
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D87971
>>>>> The fix for this issue can be found here:
>>>>> https://github.com/acpica/acpica/pull/77
>>>>>
>>>>> Thanks and best regards
>>>>> -Lv
>>>>
>>>> The problem I have with this fix for the issue is that this command:
>>>>
>>>> 	# acpidump -n APIC
>>>>
>>>> will work on x86 but fail on arm64.  Getting the -c option to work pro=
perly
>>>> is a good thing, and should be done regardless.  But, this means we ha=
ve to
>>>> use "acpidump -c -n APIC" on systems without /dev/mem.  For my part:
>>>>
>>>>    (a) these are not really customized tables, but the standard ACPI t=
ables
>>>>        used to boot the system, so using -c is a little confusing, and
>>>>
>>>>    (b) we now have to use different commands on different architecture=
s to
>>>>        get the same result.
>>>>
>>>> My preference would be that the same command has the same behavior eve=
rywhere,
>>>> which is why I patched it the way I did.
>>>
>>> This is not our preference, though...
>>> I've been in the trouble of being easily confused by the bug reporters.
>>> And I cannot distinguish if the table has been customized or root cause=
 the bugs if the reporter did what I asked for but hid what he
>>> silently did.
>>> If we cannot distinguish the BIOS provided tables and the user customiz=
ed tables from users' output, we'll likely lose the capability of
>>> taking evidence...
>>>
>>>>
>>>> This happens to be very useful on arm64 where /dev/mem is not reliable=
, but it
>>>> could also be usable on any system that does not want to expose /dev/m=
em for
>>>> some reason.  I think the advantage of the patch sent is that the user=
 command
>>>> stays the same no matter what the situation.
>>>
>>> My suggestion would be to support this via kernel.
>>> Let the kernel exposes 2 kind of tables (customized or not customized) =
into the /sys/firmware/acpi/tables.
>>> Which can meet both of the requirements.
>>
>> Or we currently can make the "-c" mode the default behavior and add a ne=
w option for dumping the BIOS tables.
> =

> And you can check if this commit is acceptable:
> https://github.com/acpica/acpica/pull/80

Hrm.  I guess if we have to have the -c option, I would prefer the first pa=
tch
where we just get rid of the dependence on /dev/mem.  I think it is easier =
to
explain that -c must always be used rather than trying to explain how to use
the -c on/off options.

I think the path I would like to see long term is to split up /sys as you
suggested so that there is a run-time version of the ACPI tables, and a copy
of the tables from UEFI.  That way, no one has to rely on /dev/mem at all,
and acpidump can go back to parameters operating exactly the same way on all
possible platforms.

> Thanks and best regards
> -Lv
> =

>>
>> Thanks and best regards
>> -Lv
>>
>>
>>>
>>> Thanks and best regards
>>> -Lv
>>>
>>>>
>>>>>> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Al Stone
>>>>>> Sent: Thursday, June 04, 2015 8:43 AM
>>>>>>
>>>>>> On arm64 systems in particular, the use of /dev/mem is not recommend=
ed.  The
>>>>>> contents may or may not be valid depending on the memory map being u=
sed, since
>>>>>> they are not standardized.
>>>>>>
>>>>>> The attached patch will cause arm64 (aka ARMv8 or AArch64) Linux sys=
tems to
>>>>>> use a new file called source/os_specific/service_layers/oslinuxtbl_n=
odevmem.c
>>>>>> (a subset of the oslinuxtbl.c code) that allows acpidump to read all=
 ACPI
>>>>>> tables from /sys/firmware/acpi instead of from /dev/mem.  This will =
help ensure
>>>>>> that the tables retrieved are the ones actually being used and that =
their
>>>>>> content is correct.
>>>>>>
>>>>>> This patch applies on top of the 20150515 version, and I have includ=
ed it in
>>>>>> the 20150515-2 versions of the Fedora and Debian packages.  I've tri=
ed the
>>>>>> resulting acpidump on x86, x86_64 and arm64 systems and it seems to =
work well.
>>>>>>
>>>>>> Signed-off-by: Al Stone <ahs3(a)redhat.com>
>>>>>>
>>>>>> --
>>>>>> ciao,
>>>>>> al
>>>>>> -----------------------------------
>>>>>> Al Stone
>>>>>> Software Engineer
>>>>>> Red Hat, Inc.
>>>>>> ahs3(a)redhat.com
>>>>>> -----------------------------------
>>>>
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
>> _______________________________________________
>> Devel mailing list
>> Devel(a)acpica.org
>> https://lists.acpica.org/mailman/listinfo/devel


-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============7257171364318116364==--

