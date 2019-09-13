Content-Type: multipart/mixed; boundary="===============1714716101966439627=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: make acpi_load_table() return table index
Date: Fri, 13 Sep 2019 14:20:21 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B967ADF6@ORSMSX110.amr.corp.intel.com>
In-Reply-To: alpine.DEB.2.20.1909130911180.20316@fox.voss.local
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1714716101966439627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



-----Original Message-----
From: Nikolaus Voss [mailto:nv(a)vosn.de] =

Sent: Friday, September 13, 2019 12:44 AM
To: Moore, Robert <robert.moore(a)intel.com>
Cc: Shevchenko, Andriy <andriy.shevchenko(a)intel.com>; Schmauss, Erik <eri=
k.schmauss(a)intel.com>; Rafael J. Wysocki <rjw(a)rjwysocki.net>; Len Brown=
 <lenb(a)kernel.org>; Jacek Anaszewski <jacek.anaszewski(a)gmail.com>; Pave=
l Machek <pavel(a)ucw.cz>; Dan Murphy <dmurphy(a)ti.com>; linux-acpi(a)vger=
.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.kernel.org; Ferry Toth=
 <ftoth(a)telfort.nl>; nikolaus.voss(a)loewensteinmedical.de
Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table index

Bob,

On Thu, 12 Sep 2019, Moore, Robert wrote:
> The ability to unload an ACPI table (especially AML tables such as
> SSDTs) is in the process of being deprecated in ACPICA -- since it is =

> also deprecated in the current ACPI specification. This is being done =

> because of the difficulty of deleting the namespace entries for the =

> table.  FYI, Windows does not properly support this function either.

ok, I see it can be a problem to unload an AML table with all it's conseque=
nces e.g. with respect to driver unregistering in setups with complex depen=
dencies. It will only work properly under certain conditions
- nevertheless acpi_tb_unload_table() is still exported in ACPICA and we sh=
ould get this working as it worked before.

AcpiTbUnloadTable is not exported, it is an internal interface only -- as r=
ecognized by the "AcpiTb". I'm not sure that I want to change the interface=
 to AcpiLoadTable just for something that is being deprecated. Already, we =
throw an ACPI_EXCEPTION if the Unload operator is encountered in the AML by=
te stream. The same thing with AcpiUnloadParentTable - it is being deprecat=
ed.


    ACPI_EXCEPTION ((AE_INFO, AE_NOT_IMPLEMENTED,
        "AML Unload operator is not supported"));


The API change I request is not directly related to table unloading, it's j=
ust that the index of the loaded table is returned for future reference:

[...]

>> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h index =

>> 3845c8fcc94e5..c90bbdc4146a6 100644
>> --- a/include/acpi/acpixf.h
>> +++ b/include/acpi/acpixf.h
>> @@ -452,7 +452,8 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FU=
NCTION
>> 					       u8 physical))
>>
>> ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>> -			    acpi_load_table(struct acpi_table_header *table))
>> +			    acpi_load_table(struct acpi_table_header *table,
>> +					    u32 *table_idx))
>>
>> ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>> 			    acpi_unload_parent_table(acpi_handle object))
>> --
>> 2.17.1
>>

This allows for a simple fix of the regression and doesn't imply future sup=
port for table unloading. Would this be acceptable?

Niko

--===============1714716101966439627==--

