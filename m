Content-Type: multipart/mixed; boundary="===============2656347439644193420=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: Re: [Devel] [PATCH 1/3] thinkpad_acpi: add support for inhibit_charge
Date: Mon, 14 May 2018 13:41:33 +0300
Message-ID: <CAHp75VdPOH7J1X4ZXmRsQ1yrB5n5RRmhPneWOnu7TFOAysgE6Q@mail.gmail.com>
In-Reply-To: 20180514094620.wfoom4mwwyqb7qe5@localhost
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2656347439644193420==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 12:46 PM, Christoph B=C3=B6hmwalder
<christoph(a)boehmwalder.at> wrote:
> On Sun, May 13, 2018 at 05:29:37PM +0200, Ognjen Galic wrote:
>> Lenovo ThinkPad systems support the prevention of
>> battery charging via a manual override called Inhibit Charge.
>>
>> This patch adds support for that attribute and exposes it via the
>> battery ACPI driver in the generic location:
>>
>> /sys/class/power_supply/BATX/inhibit_charge

>> +             /* When setting inhbitit charge, we set a default vaulue of
>
> This comment does not adhere to the Linux coding style

While you are right in principle, the whole driver is so old and uses
this style. So, for such cases we, as maintainers, prefer less
deviation work, i.e. keeping the
style is a good thing to do.

>> +             /* The only valid values are 1 and 0 */
>> +             if (value !=3D 0 && value !=3D 1)
>
> I'm not sure, but maybe `if (value < 2)` is better here?

Since it's about integer-as-a-boolean, test for bit 0 would be
sufficient, i.e. ~BIT(0). Though, I find this form not so readable
since the input comes actually from the user.
It would be nice to have just kstrtobool() called instead for such
options, but see above. It would need a (huge) refactoring of the
driver first.

-- =

With Best Regards,
Andy Shevchenko

--===============2656347439644193420==--

