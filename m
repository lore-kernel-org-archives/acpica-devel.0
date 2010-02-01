Content-Type: multipart/mixed; boundary="===============0240598444763455084=="
MIME-Version: 1.0
From: chittaraiah pabba <chittaraiahp at ami.com>
Subject: Re: [Devel] How to read ACPI table from Linux application
Date: Mon, 01 Feb 2010 09:59:05 -0500
Message-ID: <9B4771B4D9FB73498B40311D4E7E8EE5112F1504@atl-ms2.us.megatrends.com>
In-Reply-To: 1264991558.25564.239.camel@minggr.sh.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0240598444763455084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Lin,

Thanks for quick reply. It's true that ACPICA API are used in driver code b=
ut I saw the utility called "acpixtract" tool in acpi tools directory. I th=
ink this tool xtract system ACPI tables from dsdt file then users can read =
the ACPI tables and object information from extracted dsdt.dsl file.

Here is my requirements:
1) Every system has dsdt file in /proc/acpi/ folder
2) I can convert dsdt file from binary format to ASCII format with iasl com=
piler
3) Now I have dsdt.dsl file to read ACPI tables and objects in human readab=
le format. Now onwards I need your help
4) I Know ACPIxtract tool also have input argument of dsdt file to extract =
the ACPI tables
5) Similar way I want use ACPI code to walk through the dsdt.dsl file and r=
eturn processor block/object information from dsdt.file


Here is the processor block object and highlighted fields I like to read fr=
om dsdt.dsl file.

Scope (_PR)
    {
        OperationRegion (SSDT, SystemMemory, 0x7F3EBC10, 0x02CC)
        Name (DCOR, 0x01)
        Name (NCST, 0x01)
        Name (NPSS, 0x02)
        Name (HNDL, 0x80000000)
        Name (CINT, Zero)
        Name (APSS, Package (0x02)
        {
            Package (0x06)
            {
                0x0898, =

                0x00006978, =

                0x000A, =

                0x000A, =

                0x0B2A, =

                0x0B2A
            }, =


            Package (0x06)
            {
                0x04B0, =

                0x000035E8, =

                0x000A, =

                0x000A, =

                0x061D, =

                0x061D
            }
        })

I am more interest to read APSS package information of P states like proces=
sor supported P states and there usage of maximum power of in respected P s=
tates for power management of Legacy servers.

I didn't see any power usage of processor in following folder: /sys/devices=
/system/cpu/cpu0/cpufreq/*. =


I really appreciate your service and valuable suggestions. Let me know if y=
ou need any further information to understand the problem. Please help me t=
o read the processor block object from dsdt.dsl file.

--Chittari


-----Original Message-----
From: Lin Ming [mailto:ming.m.lin(a)intel.com] =

Sent: Sunday, January 31, 2010 9:33 PM
To: chittaraiah pabba
Cc: devel(a)acpica.org
Subject: Re: [Devel] How to read ACPI table from Linux application

On Sat, 2010-01-30 at 05:31 +0800, chittaraiah pabba wrote:
> Hi,
> =

> I am new to ACPICA community. We are planning to use ACPICA API=E2=80=99s=
 in
> one of power management application to get ACPI Processor block
> information from dsdt file in Linux server. =

> =

> I am planning to use ACPICA libraries to read ACPI Processor block
> information from Linux application. Information like: processor
> supported P-states and power usage of p states

Hi,

ACPICA API is used in driver code.
You can't use it in userspace application to get hardware dependent
info.

Instead, see /sys/devices/system/cpu/cpu0/cpufreq/* for the info.

Lin Ming

> =

> We wrote small application to initialize ACPI tables but it=E2=80=99s fai=
ling
> and saw below error:
> =

> ////////////////////
> =

> ACPI Exception: AE_NOT_FOUND, While initializing Table Manager
> (20091214/examples-247)
> =

> ACPI example
> =

> examples-0206 [00] main                  : Example Debug output
> =

> ACPI: ACPICA example info message
> =

> ACPI Warning: ACPICA example warning message (20091214/examples-211)
> =

> ACPI Error: ACPICA example error message (20091214/examples-212)
> =

> ACPI Exception: AE_AML_OPERAND_TYPE, Example exception message
> (20091214/examples-213)
> =

> ACPI: Executing OSI method
> =

> ACPI: _OSI returned FFFFFFFF
> =

> ///////////////////////////////////////////
> =

> Can anyone guide me how to read processor information block dsdt file
> with ACPICA code?
> =

> --Chittari
> =

> The information contained in this message may be confidential and
> proprietary to American Megatrends, Inc.  This communication is
> intended to be read only by the individual or entity to whom it is
> addressed or by their designee. If the reader of this message is not
> the intended recipient, you are on notice that any distribution of
> this message, in any form, is strictly prohibited.  Please promptly
> notify the sender by reply e-mail or by telephone at 770-246-8600, and
> then delete or destroy all copies of the transmission.
> =



--===============0240598444763455084==--

