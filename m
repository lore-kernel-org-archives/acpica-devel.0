Content-Type: multipart/mixed; boundary="===============3000611805999419153=="
MIME-Version: 1.0
From: Hanjun Guo <hanjun.guo at linaro.org>
Subject: Re: [Devel] [PATCH v5 00/14] ACPI NUMA support for ARM64
Date: Wed, 27 Apr 2016 01:49:45 +0000
Message-ID: <57201AB0.9050202@linaro.org>
In-Reply-To: 20160426133500.GQ27312@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3000611805999419153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Will,

On 2016/4/26 21:35, Will Deacon wrote:
> On Tue, Apr 26, 2016 at 09:03:25PM +0800, Hanjun Guo wrote:
>> On 2016/4/26 20:15, Will Deacon wrote:
>>> On Tue, Apr 26, 2016 at 01:31:07PM +0800, Hanjun Guo wrote:
>>>> On 2016/4/26 0:47, David Daney wrote:
>>>>> On 04/25/2016 04:13 AM, Will Deacon wrote:
>>>>>> On Tue, Apr 19, 2016 at 06:40:25PM -0700, David Daney wrote:
>>>>>>> From: David Daney <david.daney(a)cavium.com>
>>>>>>>
>>>>>>> Based on v16 of device-tree NUMA patch set for arm64 [1],this patch
>>>>>>> set introduce the ACPI based configuration to provide NUMA
>>>>>>> information.
>>>>>>>
>>>>>>> ACPI 5.1 already introduced NUMA support for ARM64, which can get t=
he
>>>>>>> NUMA domain information from SRAT and SLIT table, so parse those two
>>>>>>> tables to get mappings from cpu/mem to numa node configuration and
>>>>>>> system locality.
>>>>>>
>>>>>> Whilst I've queued the main NUMA series for arm64, I'd really like to
>>>>>> see more movement on the generic header file cleanups that you posted
>>>>>> separately:
>>>>>>
>>>>>> http://lkml.kernel.org/r/1456358528-24213-1-git-send-email-ddaney.ca=
vm(a)gmail.com
>>>>>>
>>>>>
>>>>> FWIW:  Those patches should still apply.  I am carrying them in my
>>>>> development trees, and have not changed them in any way.
>>>
>>> What's your plan for getting them merged?
>>
>> This patch set touches lots of ACPI related file in arch/x86,
>> arch/ia64, and drivers/acpi/ (also arch/arm64), I think it can be
>> merged via ACPI tree by Rafael with your ack to ARM64 code, does
>> it make sense?
>
> It doesn't touch anything in drivers/acpi/... are you following the link
> above?

Sorry, my bad, I though you were talking about this ACPI NUMA support
for ARM64 patch set.

>
>>>>>> Given that this ACPI series already requires some significant cross-=
arch
>>>>>> interaction (which is actually good!), perhaps extending the clean-up
>>>>>> patches to encompass some of the ACPI bits might make sense, and we =
can
>>>>>> get that queued as a pre-requisite.
>>>>>
>>>>> The cleanup patches you mention above are really independent of the A=
CPI
>>>>> things.  I have applied them both before and after the ACPI patches, =
and
>>>>> both seem to work.  With a quick perusal of the ACPI patches nothing
>>>>> jumps out at me as being a candidate for inclusion in the header file
>>>>> cleanup series.
>>>>
>>>> I agree. My patch set is ACPI related enablement, cleanups and
>>>> consolidations, it would be good to merge as a single patch set
>>>> as it's self-contained.
>>>
>>> Up to you. I just thought you might want to avoid having two sets of
>>> cross-arch changes and the associated merging headaches that go with
>>> that.
>>
>> Good point, as I suggested above, it can go with ACPI tree if it's ok
>> to you and Rafael. The problem we have now is that dt based core NUMA
>> support for ARM64 is queued in your tree, that would be the headache.
>
> Sorry, but if you wanted me *not* to queue the patches, then you should
> have said so (similarly, if you wanted a stable branch). I'm not rebasing
> our for-next/core branch now.

I misread the message above, I'm really sorry if I did something
offending you, I didn't mean that.

How about this patch set? We only get few comments on it, your
comments on it are appreciated.

Thanks
Hanjun

--===============3000611805999419153==--

