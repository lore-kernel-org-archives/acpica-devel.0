Content-Type: multipart/mixed; boundary="===============0235668921760842884=="
MIME-Version: 1.0
From: Colin Ian King <colin.king at canonical.com>
Subject: Re: [Devel] [PATCH] Check for failed string allocation and set Status
 accordingly
Date: Thu, 24 Mar 2016 17:24:15 +0000
Message-ID: <56F422BF.8090106@canonical.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37E453D69@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0235668921760842884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 24/03/16 17:18, Moore, Robert wrote:
> The "temporary" part is true. We were using the code block to test the Ex=
ternalOp that came from ACPi 6.0.
> =

> In truth, the interpreter should never see an external opcode because it =
will be surrounded by an If(0) conditional. So, the code block in question =
should probably go away completely.
> =

> Bob

OK, so either this code gets ripped out, or we fix it with the small
fix, at least either way we clean up the code.

Colin

> =

> =

>> -----Original Message-----
>> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Colin King
>> Sent: Tuesday, March 22, 2016 3:17 PM
>> To: devel(a)acpica.org
>> Subject: [Devel] [PATCH] Check for failed string allocation and set Stat=
us
>> accordingly
>>
>> From: Colin Ian King <colin.king(a)canonical.com>
>>
>> It is possible that AcpiUtCreateStringObject fails to allocate a string
>> object, so check for this condition and set Status to AE_NO_MEMORY to
>> indicate a memory allocation failure.
>>
>> Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
>> ---
>>  source/components/dispatcher/dsutils.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/source/components/dispatcher/dsutils.c
>> b/source/components/dispatcher/dsutils.c
>> index 52e9ca8..124dc67 100644
>> --- a/source/components/dispatcher/dsutils.c
>> +++ b/source/components/dispatcher/dsutils.c
>> @@ -678,9 +678,15 @@ AcpiDsCreateOperand (
>>                      /* TBD: May only be temporary */
>>
>>                      ObjDesc =3D AcpiUtCreateStringObject ((ACPI_SIZE)
>> NameLength);
>> -
>> -                    strncpy (ObjDesc->String.Pointer, NameString,
>> NameLength);
>> -                    Status =3D AE_OK;
>> +                    if (!ObjDesc)
>> +                    {
>> +                        Status =3D AE_NO_MEMORY;
>> +                    }
>> +                    else
>> +                    {
>> +                        strncpy (ObjDesc->String.Pointer, NameString,
>> NameLength);
>> +                        Status =3D AE_OK;
>> +                    }
>>                  }
>>                  else
>>                  {
>> --
>> 2.7.3
>>
>> _______________________________________________
>> Devel mailing list
>> Devel(a)acpica.org
>> https://lists.acpica.org/mailman/listinfo/devel


--===============0235668921760842884==--

