Content-Type: multipart/mixed; boundary="===============5135806875493097716=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: make acpi_load_table() return table index
Date: Fri, 13 Sep 2019 17:40:57 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B967AEC9@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 7625fe37-1710-056d-fb9e-39c33fd962a1@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5135806875493097716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



-----Original Message-----
From: Ferry Toth [mailto:fntoth(a)gmail.com] =

Sent: Friday, September 13, 2019 9:48 AM
To: Shevchenko, Andriy <andriy.shevchenko(a)intel.com>; Moore, Robert <robe=
rt.moore(a)intel.com>
Cc: Nikolaus Voss <nv(a)vosn.de>; Schmauss, Erik <erik.schmauss(a)intel.com=
>; Rafael J. Wysocki <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.org>; =
Jacek Anaszewski <jacek.anaszewski(a)gmail.com>; Pavel Machek <pavel(a)ucw.=
cz>; Dan Murphy <dmurphy(a)ti.com>; linux-acpi(a)vger.kernel.org; devel(a)a=
cpica.org; linux-kernel(a)vger.kernel.org; nikolaus.voss(a)loewensteinmedic=
al.de; Jan Kiszka <jan.kiszka(a)siemens.com>
Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table index

Hello all,

Sorry to have sent our message with cancelled e-mail address. I have correc=
t this now.

Op 13-09-19 om 17:12 schreef Shevchenko, Andriy:
> On Fri, Sep 13, 2019 at 05:20:21PM +0300, Moore, Robert wrote:
>> -----Original Message-----
>> From: Nikolaus Voss [mailto:nv(a)vosn.de]
>> Sent: Friday, September 13, 2019 12:44 AM
>> To: Moore, Robert <robert.moore(a)intel.com>
>> Cc: Shevchenko, Andriy <andriy.shevchenko(a)intel.com>; Schmauss, Erik =

>> <erik.schmauss(a)intel.com>; Rafael J. Wysocki <rjw(a)rjwysocki.net>; Le=
n =

>> Brown <lenb(a)kernel.org>; Jacek Anaszewski =

>> <jacek.anaszewski(a)gmail.com>; Pavel Machek <pavel(a)ucw.cz>; Dan Murph=
y =

>> <dmurphy(a)ti.com>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; =

>> linux-kernel(a)vger.kernel.org; Ferry Toth <ftoth(a)telfort.nl>; =

>> nikolaus.voss(a)loewensteinmedical.de
>> Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table =

>> index
>>
>> Bob,
>>
>> On Thu, 12 Sep 2019, Moore, Robert wrote:
>>> The ability to unload an ACPI table (especially AML tables such as
>>> SSDTs) is in the process of being deprecated in ACPICA -- since it =

>>> is also deprecated in the current ACPI specification. This is being =

>>> done because of the difficulty of deleting the namespace entries for =

>>> the table.  FYI, Windows does not properly support this function either.
>>
>> ok, I see it can be a problem to unload an AML table with all it's =

>> consequences e.g. with respect to driver unregistering in setups with =

>> complex dependencies. It will only work properly under certain =

>> conditions
>> - nevertheless acpi_tb_unload_table() is still exported in ACPICA and we=
 should get this working as it worked before.
>>
>> AcpiTbUnloadTable is not exported, it is an internal interface only =

>> -- as recognized by the "AcpiTb".
> =

> In Linux it became a part of ABI when the
> =

> commit 772bf1e2878ecfca0d1f332071c83e021dd9cf01
> Author: Jan Kiszka <jan.kiszka(a)siemens.com>
> Date:   Fri Jun 9 20:36:31 2017 +0200
> =

>      ACPI: configfs: Unload SSDT on configfs entry removal
> =

> appeared in the kernel.

And the commit message explains quite well why it is an important feature:

"This allows to change SSDTs without rebooting the system.
It also allows to destroy devices again that a dynamically loaded SSDT crea=
ted.

The biggest problem AFAIK is that under linux, many drivers cannot be unloa=
ded. Also, there are many race conditions as the namespace entries "owned" =
by an SSDT being unloaded are deleted (out from underneath a driver).

This is widely similar to the DT overlay behavior."

>> I'm not sure that I want to change the interface to AcpiLoadTable =

>> just for something that is being deprecated. Already, we throw an =

>> ACPI_EXCEPTION if the Unload operator is encountered in the AML byte =

>> stream. The same thing with AcpiUnloadParentTable - it is being deprecat=
ed.
>>
>>      ACPI_EXCEPTION ((AE_INFO, AE_NOT_IMPLEMENTED,
>>          "AML Unload operator is not supported"));
> =



--===============5135806875493097716==--

