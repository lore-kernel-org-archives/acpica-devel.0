Content-Type: multipart/mixed; boundary="===============7398196272901093099=="
MIME-Version: 1.0
From: Lin Ming <ming.m.lin at intel.com>
Subject: Re: [Devel] How to read ACPI table from Linux application
Date: Mon, 01 Feb 2010 10:32:38 +0800
Message-ID: <1264991558.25564.239.camel@minggr.sh.intel.com>
In-Reply-To: 9B4771B4D9FB73498B40311D4E7E8EE5112F1362@atl-ms2.us.megatrends.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7398196272901093099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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



--===============7398196272901093099==--

