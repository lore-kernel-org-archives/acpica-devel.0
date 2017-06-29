Content-Type: multipart/mixed; boundary="===============3998233541035822375=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v2] ACPI: surface3_power: MSHW0011 rev-eng
 implementation
Date: Thu, 29 Jun 2017 22:22:50 +0200
Message-ID: <CAJZ5v0hq1YSECBGD9QvqKuzmaFW2+jhWPSzvTb64yTxd6yH06w@mail.gmail.com>
In-Reply-To: CAHp75Vdn1-m0gDSHtZXX2A=Q07xG9j1eBiV8iM4e11Qk=oJfZg@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3998233541035822375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2017 at 4:22 PM, Andy Shevchenko
<andy.shevchenko(a)gmail.com> wrote:
> +Cc: Hans (he might give some advice regarding to the below)
>
> On Thu, Jun 29, 2017 at 3:10 PM, Benjamin Tissoires
> <benjamin.tissoires(a)redhat.com> wrote:
>> MSHW0011 replaces the battery firmware by using ACPI operation regions.
>> The values have been obtained by reverse engineering, and are subject to
>> errors. Looks like it works on overall pretty well.
>
> What devices (laptops, tablets) have it?
> Surface 3. What else?
>
>> I couldn't manage to get the IRQ correctly triggered, so I am using a
>> good old polling thread to check for changes.
>
> It might be
>
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D106231
>
>> +config ACPI_SURFACE3_POWER_OPREGION
>> +       tristate "Surface 3 battery platform operation region support"
>
> depends on ACPI ?
>
>> +       help
>> +         Select this option to enable support for ACPI operation
>> +         region of the Surface 3 battery platform driver.
>
>> +/*
>> + * Supports for the power IC on the Surface 3 tablet.
>
> Shouldn't it go to drivers/acpi/pmic folder ?

Surely not directly into drivers/acpi/ in any case.

Thanks,
Rafael

--===============3998233541035822375==--

