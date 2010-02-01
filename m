Content-Type: multipart/mixed; boundary="===============8472205553361554982=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] How to read ACPI table from Linux application
Date: Mon, 01 Feb 2010 12:14:31 -0800
Message-ID: <4911F71203A09E4D9981D27F9D83085855AF835F@orsmsx503.amr.corp.intel.com>
In-Reply-To: 9B4771B4D9FB73498B40311D4E7E8EE5112F1504@atl-ms2.us.megatrends.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8472205553361554982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



>-----Original Message-----
>From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On Be=
half
>Of chittaraiah pabba
>Sent: Monday, February 01, 2010 6:59 AM
>To: Lin, Ming M
>Cc: devel(a)acpica.org
>Subject: Re: [Devel] How to read ACPI table from Linux application
>
>Lin,
>
>Thanks for quick reply. It's true that ACPICA API are used in driver code
>but I saw the utility called "acpixtract" tool in acpi tools directory. I
>think this tool xtract system ACPI tables from dsdt file then users can
>read the ACPI tables and object information from extracted dsdt.dsl file.
>

The acpixtract utility is used to extract binary ACPI tables (including DSD=
T) from an ascii file created by the acpidump utility. The acpidump utility=
 gets all of the ACPI tables for the machine and dumps them to an ascii (he=
x dump) text file.



>Here is my requirements:
>1) Every system has dsdt file in /proc/acpi/ folder
>2) I can convert dsdt file from binary format to ASCII format with iasl
>compiler
>3) Now I have dsdt.dsl file to read ACPI tables and objects in human
>readable format. Now onwards I need your help
>4) I Know ACPIxtract tool also have input argument of dsdt file to extract
>the ACPI tables
>5) Similar way I want use ACPI code to walk through the dsdt.dsl file and
>return processor block/object information from dsdt.file
>

I'm not sure what you mean by "walk through the dsdt.dsl file" in number (5=
) above.

There is another utility called "acpiexec". This utility contains the entir=
e ACPICA code, and runs it in user space. It can load a DSDT from a file, a=
nd it can execute control methods within the DSDT. It simulates any attempt=
s to access actual hardware, however.

>
>Here is the processor block object and highlighted fields I like to read
>from dsdt.dsl file.
>
>Scope (_PR)
>    {
>        OperationRegion (SSDT, SystemMemory, 0x7F3EBC10, 0x02CC)
>        Name (DCOR, 0x01)
>        Name (NCST, 0x01)
>        Name (NPSS, 0x02)
>        Name (HNDL, 0x80000000)
>        Name (CINT, Zero)
>        Name (APSS, Package (0x02)
>        {
>            Package (0x06)
>            {
>                0x0898,
>                0x00006978,
>                0x000A,
>                0x000A,
>                0x0B2A,
>                0x0B2A
>            },
>
>            Package (0x06)
>            {
>                0x04B0,
>                0x000035E8,
>                0x000A,
>                0x000A,
>                0x061D,
>                0x061D
>            }
>        })
>
>I am more interest to read APSS package information of P states like
>processor supported P states and there usage of maximum power of in
>respected P states for power management of Legacy servers.


Again, not sure what you mean by this. Once you have the disassembled DSDT =
(dsdt.dsl), you have the actual ASL BIOS code. Above, you have the exact co=
de that implements APSS. Presumably, APSS is called by a _PSS method (which=
 returns the Performance Supported States.)

From APSS, it looks like there are 2 performance states supported.

Each sub-package in APSS has the form:

Core Frequency,
Power,
Latency,
Bus Master Latency,
Control,
Status

This information is available in the ACPI specification, in the description=
 for the predefined _PSS method.

Bob



>
>I didn't see any power usage of processor in following folder:
>/sys/devices/system/cpu/cpu0/cpufreq/*.
>
>I really appreciate your service and valuable suggestions. Let me know if
>you need any further information to understand the problem. Please help me
>to read the processor block object from dsdt.dsl file.
>
>--Chittari
>
>
>-----Original Message-----
>From: Lin Ming [mailto:ming.m.lin(a)intel.com]
>Sent: Sunday, January 31, 2010 9:33 PM
>To: chittaraiah pabba
>Cc: devel(a)acpica.org
>Subject: Re: [Devel] How to read ACPI table from Linux application
>
>On Sat, 2010-01-30 at 05:31 +0800, chittaraiah pabba wrote:
>> Hi,
>>
>> I am new to ACPICA community. We are planning to use ACPICA API's in
>> one of power management application to get ACPI Processor block
>> information from dsdt file in Linux server.
>>
>> I am planning to use ACPICA libraries to read ACPI Processor block
>> information from Linux application. Information like: processor
>> supported P-states and power usage of p states
>
>Hi,
>
>ACPICA API is used in driver code.
>You can't use it in userspace application to get hardware dependent
>info.
>
>Instead, see /sys/devices/system/cpu/cpu0/cpufreq/* for the info.
>
>Lin Ming
>
>>
>> We wrote small application to initialize ACPI tables but it's failing
>> and saw below error:
>>
>> ////////////////////
>>
>> ACPI Exception: AE_NOT_FOUND, While initializing Table Manager
>> (20091214/examples-247)
>>
>> ACPI example
>>
>> examples-0206 [00] main                  : Example Debug output
>>
>> ACPI: ACPICA example info message
>>
>> ACPI Warning: ACPICA example warning message (20091214/examples-211)
>>
>> ACPI Error: ACPICA example error message (20091214/examples-212)
>>
>> ACPI Exception: AE_AML_OPERAND_TYPE, Example exception message
>> (20091214/examples-213)
>>
>> ACPI: Executing OSI method
>>
>> ACPI: _OSI returned FFFFFFFF
>>
>> ///////////////////////////////////////////
>>
>> Can anyone guide me how to read processor information block dsdt file
>> with ACPICA code?
>>
>> --Chittari
>>
>> The information contained in this message may be confidential and
>> proprietary to American Megatrends, Inc.  This communication is
>> intended to be read only by the individual or entity to whom it is
>> addressed or by their designee. If the reader of this message is not
>> the intended recipient, you are on notice that any distribution of
>> this message, in any form, is strictly prohibited.  Please promptly
>> notify the sender by reply e-mail or by telephone at 770-246-8600, and
>> then delete or destroy all copies of the transmission.
>>
>
>_______________________________________________
>Devel mailing list
>Devel(a)acpica.org
>http://lists.acpica.org/listinfo/devel

--===============8472205553361554982==--

