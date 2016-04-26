Content-Type: multipart/mixed; boundary="===============0842757111955610259=="
MIME-Version: 1.0
From: Hanjun Guo <hanjun.guo at linaro.org>
Subject: Re: [Devel] [PATCH v5 00/14] ACPI NUMA support for ARM64
Date: Tue, 26 Apr 2016 05:31:18 +0000
Message-ID: <571EFD1B.1070609@linaro.org>
In-Reply-To: 571E4A2A.8070908@caviumnetworks.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0842757111955610259==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Will, David,

On 2016/4/26 0:47, David Daney wrote:
> On 04/25/2016 04:13 AM, Will Deacon wrote:
>> Hi David,
>>
>> On Tue, Apr 19, 2016 at 06:40:25PM -0700, David Daney wrote:
>>> From: David Daney <david.daney(a)cavium.com>
>>>
>>> Based on v16 of device-tree NUMA patch set for arm64 [1],this patch
>>> set introduce the ACPI based configuration to provide NUMA
>>> information.
>>>
>>> ACPI 5.1 already introduced NUMA support for ARM64, which can get the
>>> NUMA domain information from SRAT and SLIT table, so parse those two
>>> tables to get mappings from cpu/mem to numa node configuration and
>>> system locality.
>>
>> Whilst I've queued the main NUMA series for arm64, I'd really like to
>> see more movement on the generic header file cleanups that you posted
>> separately:
>>
>> http://lkml.kernel.org/r/1456358528-24213-1-git-send-email-ddaney.cavm(a=
)gmail.com
>>
>
> FWIW:  Those patches should still apply.  I am carrying them in my
> development trees, and have not changed them in any way.
>
>>
>> Given that this ACPI series already requires some significant cross-arch
>> interaction (which is actually good!), perhaps extending the clean-up
>> patches to encompass some of the ACPI bits might make sense, and we can
>> get that queued as a pre-requisite.
>
> The cleanup patches you mention above are really independent of the ACPI
> things.  I have applied them both before and after the ACPI patches, and
> both seem to work.  With a quick perusal of the ACPI patches nothing
> jumps out at me as being a candidate for inclusion in the header file
> cleanup series.

I agree. My patch set is ACPI related enablement, cleanups and
consolidations, it would be good to merge as a single patch set
as it's self-contained.

Thanks
Hanjun

--===============0842757111955610259==--

