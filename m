Content-Type: multipart/mixed; boundary="===============3271080013903582592=="
MIME-Version: 1.0
From: Jeremy Linton <jeremy.linton at arm.com>
Subject: Re: [Devel] [PATCH v4 3/9] arm64/acpi: Create arch specific cpu to
 acpi id helper
Date: Mon, 20 Nov 2017 11:09:47 -0600
Message-ID: <7a435753-7058-7941-6c83-b21df54fa9de@arm.com>
In-Reply-To: 20171120170634.GB31395@e107155-lin
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3271080013903582592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 11/20/2017 11:06 AM, Sudeep Holla wrote:
> On Thu, Nov 09, 2017 at 03:03:05PM -0600, Jeremy Linton wrote:
>> Its helpful to be able to lookup the acpi_processor_id
>> associated with a logical cpu. Provide an arm64
>> helper to do this.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton(a)arm.com>
>> ---
>>   arch/arm64/include/asm/acpi.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi=
.h
>> index 59cca1d6ec54..408e7989d3a2 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -86,6 +86,10 @@ static inline bool acpi_has_cpu_in_madt(void)
>>   }
>>   =

>>   struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu);
>> +static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
>> +{
>> +	return	acpi_cpu_get_madt_gicc(cpu)->uid;
>> +}
> =

> If I followed the series correctly, this function is used in 2/9 already.
> So this needs to be moved down in the series to avoid build failure during
> bisection.

I don't believe there is a bisection failure here because the code using =

this routine is not yet being compiled until the 4/9.


--===============3271080013903582592==--

