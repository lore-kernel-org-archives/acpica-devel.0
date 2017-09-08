Content-Type: multipart/mixed; boundary="===============4849006276304628654=="
MIME-Version: 1.0
From: James Morse <james.morse at arm.com>
Subject: Re: [Devel] [PATCH v6 3/7] acpi: apei: remove the unused code
Date: Fri, 08 Sep 2017 19:17:30 +0100
Message-ID: <59B2DEBA.6030608@arm.com>
In-Reply-To: 45c69f99-61dd-e847-368b-20acb61b4d50@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4849006276304628654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi gengdongjiu,

On 04/09/17 12:43, gengdongjiu wrote:
> On 2017/9/1 1:50, James Morse wrote:
>> On 28/08/17 11:38, Dongjiu Geng wrote:
>>> In current code logic, the two functions ghes_sea_add() and
>>> ghes_sea_remove() are only called when CONFIG_ACPI_APEI_SEA
>>> is defined. If not, it will return errors in the ghes_probe()
>>> and not contiue. Hence, remove the unnecessary handling when
>>> CONFIG_ACPI_APEI_SEI is not defined.
>>
>> This doesn't match what the patch does. I get this feeling this is neede=
d for
>> some future patch you haven't included.
> =

> James, let check the code, when the ghes_probe, if the CONFIG_ACPI_APEI_S=
EA is not defined.
> it will return -ENOTSUPP and goto error, and the ghes_sea_add has no chan=
ce to execute.
> similar, if the probe is failed, it should not have chance to execute ghe=
s_sea_remove.

It's the 'unnecessary handling when CONFIG_ACPI_APEI_SEI' in the commit mes=
sage
that confuses me: this patch doesn't reference that Kconfig symbol. I guess=
 that
sentence needs removing for this v6?

Re-reading without that part of the commit-message:

You're relying on the compiler's dead-code elimination to spot unused static
functions and silently drop them. Great!
(there is the small risk that gcc 3.2[0] can't do this, x86 still has to su=
pport
this gcc version)

As this is just clean-up patch can you break it out of this series, it isn't
needed to add support for SEI.

(This series adds support for what should be an APEI notification, but the =
only
code that touches APEI removes some code from a different notification meth=
od.)


>> Setting NOTIFY_SEI as the GHES entry's notification type means the OS sh=
ould
>> check the GHES->ErrorStatusAddress for CPER records when it receives an
>> SError-Interrupt, as it may be a notification of an error from this erro=
r source.

> previously I added the NOTIFY_SEI support,

(Yes, I saw that in v5 and expected this series to add some APEI support co=
de )


> but consider the error address in CPER is not accurate and calling memory=
_failure() may not make sense.
> so I remove it.

'not accurate'... this is going to be a problem, but lets keep that discuss=
ion
on the cover-letter.


>> If you aren't handling the notification, why is this is in the HEST at a=
ll?
>> (and if its not: its not firmware-first)

> For the SEI notification, may be we can parse and handle the CPER record =
other than the Error physical address

Sure, but I only see this cleanup patch in this series, where does APEI lea=
rn
about NOTIFY_SEI? As this is nothing will ever touch those CPER records, if
you're using GHESv2 firmware will be prevented from delivering subsequent
notifications.


Thanks,

James

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/admin-guide/README.rst#n251

--===============4849006276304628654==--

