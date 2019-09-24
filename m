Content-Type: multipart/mixed; boundary="===============2715878357474502562=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: make acpi_load_table() return table index
Date: Tue, 24 Sep 2019 19:41:26 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B968B639@ORSMSX110.amr.corp.intel.com>
In-Reply-To: alpine.DEB.2.20.1909231100190.16390@fox.voss.local
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2715878357474502562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

How about this:
Go back to using acpi_tb_install_and_load_table(), but then call acpi_ns_in=
itialize_objects afterwards This is what acpi_load_table does.


    ACPI_INFO (("Host-directed Dynamic ACPI Table Load:"));
    Status =3D AcpiTbInstallAndLoadTable (ACPI_PTR_TO_PHYSADDR (Table),
        ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL, FALSE, &TableIndex);
    if (ACPI_SUCCESS (Status))
    {
        /* Complete the initialization/resolution of new objects */

        AcpiNsInitializeObjects ();
    }


-----Original Message-----
From: Nikolaus Voss <nv(a)vosn.de> =

Sent: Monday, September 23, 2019 2:05 AM
To: Moore, Robert <robert.moore(a)intel.com>
Cc: Ferry Toth <fntoth(a)gmail.com>; Shevchenko, Andriy <andriy.shevchenko(=
a)intel.com>; Schmauss, Erik <erik.schmauss(a)intel.com>; Rafael J. Wysocki=
 <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.org>; Jacek Anaszewski <ja=
cek.anaszewski(a)gmail.com>; Pavel Machek <pavel(a)ucw.cz>; Dan Murphy <dmu=
rphy(a)ti.com>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-ker=
nel(a)vger.kernel.org; Jan Kiszka <jan.kiszka(a)siemens.com>
Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table index

On Thu, 19 Sep 2019, Moore, Robert wrote:
>
>
> -----Original Message-----
> From: Nikolaus Voss [mailto:nv(a)vosn.de]
> Sent: Wednesday, September 18, 2019 7:32 AM
> To: Moore, Robert <robert.moore(a)intel.com>
> Cc: Ferry Toth <fntoth(a)gmail.com>; Shevchenko, Andriy =

> <andriy.shevchenko(a)intel.com>; Schmauss, Erik =

> <erik.schmauss(a)intel.com>; Rafael J. Wysocki <rjw(a)rjwysocki.net>; Len =

> Brown <lenb(a)kernel.org>; Jacek Anaszewski =

> <jacek.anaszewski(a)gmail.com>; Pavel Machek <pavel(a)ucw.cz>; Dan Murphy =

> <dmurphy(a)ti.com>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; =

> linux-kernel(a)vger.kernel.org; Jan Kiszka <jan.kiszka(a)siemens.com>
> Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table index
>
> On Wed, 18 Sep 2019, Moore, Robert wrote:
>>
>>
>> -----Original Message-----
>> From: Nikolaus Voss [mailto:nv(a)vosn.de]
>> Sent: Monday, September 16, 2019 2:47 AM
>> To: Moore, Robert <robert.moore(a)intel.com>
>> Cc: Ferry Toth <fntoth(a)gmail.com>; Shevchenko, Andriy =

>> <andriy.shevchenko(a)intel.com>; Schmauss, Erik =

>> <erik.schmauss(a)intel.com>; Rafael J. Wysocki <rjw(a)rjwysocki.net>; Le=
n =

>> Brown <lenb(a)kernel.org>; Jacek Anaszewski =

>> <jacek.anaszewski(a)gmail.com>; Pavel Machek <pavel(a)ucw.cz>; Dan Murph=
y =

>> <dmurphy(a)ti.com>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; =

>> linux-kernel(a)vger.kernel.org; Jan Kiszka <jan.kiszka(a)siemens.com>
>> Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table =

>> index
>>
>> On Fri, 13 Sep 2019, Moore, Robert wrote:
>>>
>>>
>>> -----Original Message-----
>>> From: Ferry Toth [mailto:fntoth(a)gmail.com]
>>> Sent: Friday, September 13, 2019 9:48 AM
>>> To: Shevchenko, Andriy <andriy.shevchenko(a)intel.com>; Moore, Robert =

>>> <robert.moore(a)intel.com>
>>> Cc: Nikolaus Voss <nv(a)vosn.de>; Schmauss, Erik =

>>> <erik.schmauss(a)intel.com>; Rafael J. Wysocki <rjw(a)rjwysocki.net>; =

>>> Len Brown <lenb(a)kernel.org>; Jacek Anaszewski =

>>> <jacek.anaszewski(a)gmail.com>; Pavel Machek <pavel(a)ucw.cz>; Dan =

>>> Murphy <dmurphy(a)ti.com>; linux-acpi(a)vger.kernel.org; =

>>> devel(a)acpica.org; linux-kernel(a)vger.kernel.org; =

>>> nikolaus.voss(a)loewensteinmedical.de;
>>> Jan Kiszka <jan.kiszka(a)siemens.com>
>>> Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table =

>>> index
>>>
>>> Hello all,
>>>
>>> Sorry to have sent our message with cancelled e-mail address. I have co=
rrect this now.
>>>
>>> Op 13-09-19 om 17:12 schreef Shevchenko, Andriy:
>>>> On Fri, Sep 13, 2019 at 05:20:21PM +0300, Moore, Robert wrote:
>>>>> -----Original Message-----
>>>>> From: Nikolaus Voss [mailto:nv(a)vosn.de]
>>>>> Sent: Friday, September 13, 2019 12:44 AM
>>>>> To: Moore, Robert <robert.moore(a)intel.com>
>>>>> Cc: Shevchenko, Andriy <andriy.shevchenko(a)intel.com>; Schmauss, =

>>>>> Erik <erik.schmauss(a)intel.com>; Rafael J. Wysocki =

>>>>> <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.org>; Jacek Anaszewsk=
i =

>>>>> <jacek.anaszewski(a)gmail.com>; Pavel Machek <pavel(a)ucw.cz>; Dan =

>>>>> Murphy <dmurphy(a)ti.com>; linux-acpi(a)vger.kernel.org; =

>>>>> devel(a)acpica.org; linux-kernel(a)vger.kernel.org; Ferry Toth =

>>>>> <ftoth(a)telfort.nl>; nikolaus.voss(a)loewensteinmedical.de
>>>>> Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table =

>>>>> index
>>>>>
>>>>> Bob,
>>>>>
>>>>> On Thu, 12 Sep 2019, Moore, Robert wrote:
>>>>>> The ability to unload an ACPI table (especially AML tables such =

>>>>>> as
>>>>>> SSDTs) is in the process of being deprecated in ACPICA -- since =

>>>>>> it is also deprecated in the current ACPI specification. This is =

>>>>>> being done because of the difficulty of deleting the namespace =

>>>>>> entries for the table.  FYI, Windows does not properly support this =
function either.
>>>>>
>>>>> ok, I see it can be a problem to unload an AML table with all it's =

>>>>> consequences e.g. with respect to driver unregistering in setups =

>>>>> with complex dependencies. It will only work properly under =

>>>>> certain conditions
>>>>> - nevertheless acpi_tb_unload_table() is still exported in ACPICA and=
 we should get this working as it worked before.
>>>>>
>>>>> AcpiTbUnloadTable is not exported, it is an internal interface =

>>>>> only
>>>>> -- as recognized by the "AcpiTb".
>>>>
>>>> In Linux it became a part of ABI when the
>>>>
>>>> commit 772bf1e2878ecfca0d1f332071c83e021dd9cf01
>>>> Author: Jan Kiszka <jan.kiszka(a)siemens.com>
>>>> Date:   Fri Jun 9 20:36:31 2017 +0200
>>>>
>>>>      ACPI: configfs: Unload SSDT on configfs entry removal
>>>>
>>>> appeared in the kernel.
>>>
>>> And the commit message explains quite well why it is an important featu=
re:
>>>
>>> "This allows to change SSDTs without rebooting the system.
>>> It also allows to destroy devices again that a dynamically loaded SSDT =
created.
>>>
>>> The biggest problem AFAIK is that under linux, many drivers cannot be u=
nloaded. Also, there are many race conditions as the namespace entries "own=
ed" by an SSDT being unloaded are deleted (out from underneath a driver).
>>>
>>> This is widely similar to the DT overlay behavior."
>>>
>>>>> I'm not sure that I want to change the interface to AcpiLoadTable =

>>>>> just for something that is being deprecated. Already, we throw an =

>>>>> ACPI_EXCEPTION if the Unload operator is encountered in the AML =

>>>>> byte stream. The same thing with AcpiUnloadParentTable - it is being =
deprecated.
>>>>>
>>>>>      ACPI_EXCEPTION ((AE_INFO, AE_NOT_IMPLEMENTED,
>>>>>          "AML Unload operator is not supported"));
>>
>> Bob, what is your suggestion to fix the regression then?
>>
>> We could revert acpi_configfs.c to use
>> acpi_tb_install_and_load_table() instead of acpi_load_table(), =

>> leaving loaded APCI objects uninitalized, but at least, unloading will w=
ork again.
>>
>> I guess my next question is: why do you want to unload a table in the =

>> first place?
>
> Because it worked before and there are people who rely on it. If it's =

> deprecated there should be a user notification and a reasonable =

> end-of-life timeline to give these users a chance to develop an =

> alternative solution.
>
> So, I still don't understand why this no longer works. We did not make =

> any purposeful changes in this area - AFAIK. Bob

It's because the acpi_configfs driver formerly used
acpi_tb_install_and_load_table() which returns the table index, but doesn't=
 resolve the references. It now uses acpi_load_table() which resolves the r=
eferences, but doesn't return the table index, so unloading doesn't work an=
y more.

>
> Niko
>
>>
>>
>> Do we have any other options?
>>
>> Niko
>>
>

--===============2715878357474502562==--

