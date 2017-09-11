Content-Type: multipart/mixed; boundary="===============1752200845854567493=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v6 3/7] acpi: apei: remove the unused code
Date: Mon, 11 Sep 2017 20:04:21 +0800
Message-ID: <b06c680c-93a3-7e20-1118-c6a9a24704df@huawei.com>
In-Reply-To: 59B2DEBA.6030608@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1752200845854567493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

James,
   Thanks for the review.

On 2017/9/9 2:17, James Morse wrote:
> Hi gengdongjiu,
> =

> On 04/09/17 12:43, gengdongjiu wrote:
>> On 2017/9/1 1:50, James Morse wrote:
>>> On 28/08/17 11:38, Dongjiu Geng wrote:
>>>> In current code logic, the two functions ghes_sea_add() and
>>>> ghes_sea_remove() are only called when CONFIG_ACPI_APEI_SEA
>>>> is defined. If not, it will return errors in the ghes_probe()
>>>> and not contiue. Hence, remove the unnecessary handling when
>>>> CONFIG_ACPI_APEI_SEI is not defined.
>>>
>>> This doesn't match what the patch does. I get this feeling this is need=
ed for
>>> some future patch you haven't included.
>>
>> James, let check the code, when the ghes_probe, if the CONFIG_ACPI_APEI_=
SEA is not defined.
>> it will return -ENOTSUPP and goto error, and the ghes_sea_add has no cha=
nce to execute.
>> similar, if the probe is failed, it should not have chance to execute gh=
es_sea_remove.
> =

> It's the 'unnecessary handling when CONFIG_ACPI_APEI_SEI' in the commit m=
essage
> that confuses me: this patch doesn't reference that Kconfig symbol. I gue=
ss that
> sentence needs removing for this v6?
 thanks for the pointing out, That needs to be removed for v6.

> =

> Re-reading without that part of the commit-message:
> =

> You're relying on the compiler's dead-code elimination to spot unused sta=
tic
> functions and silently drop them. Great!
> (there is the small risk that gcc 3.2[0] can't do this, x86 still has to =
support
> this gcc version)
> =

> As this is just clean-up patch can you break it out of this series, it is=
n't
> needed to add support for SEI.
sure, I will.

> =

> (This series adds support for what should be an APEI notification, but th=
e only
> code that touches APEI removes some code from a different notification me=
thod.)

understand.

> =

> =

>>> Setting NOTIFY_SEI as the GHES entry's notification type means the OS s=
hould
>>> check the GHES->ErrorStatusAddress for CPER records when it receives an
>>> SError-Interrupt, as it may be a notification of an error from this err=
or source.
> =

>> previously I added the NOTIFY_SEI support,
> =

> (Yes, I saw that in v5 and expected this series to add some APEI support =
code )
> =

> =

>> but consider the error address in CPER is not accurate and calling memor=
y_failure() may not make sense.
>> so I remove it.
> =

> 'not accurate'... this is going to be a problem, but lets keep that discu=
ssion
> on the cover-letter.

Ok.


> =

> =

>>> If you aren't handling the notification, why is this is in the HEST at =
all?
>>> (and if its not: its not firmware-first)
> =

>> For the SEI notification, may be we can parse and handle the CPER record=
 other than the Error physical address
> =

> Sure, but I only see this cleanup patch in this series, where does APEI l=
earn
> about NOTIFY_SEI? As this is nothing will ever touch those CPER records, =
if
> you're using GHESv2 firmware will be prevented from delivering subsequent
> notifications.
James, whether it is possible you can review the previous v5 patch which ad=
ds the support for NOTIFY_SEI? thanks in advancecIn that patch, I share the=
 SEI notification handling with the SEA notification handling to avoid dupl=
icated code.

https://www.spinics.net/lists/arm-kernel/msg601767.html

> =

> =

> Thanks,
> =

> James
> =

> [0]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/admin-guide/README.rst#n251
> =

> .
> =



--===============1752200845854567493==--

