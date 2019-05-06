Content-Type: multipart/mixed; boundary="===============5182952000315357170=="
MIME-Version: 1.0
From: Schmauss, Erik <erik.schmauss at intel.com>
Subject: Re: [Devel] iasl -d and duplicate symbols (ACPI Error:
 AE_ALREADY_EXISTS)
Date: Mon, 06 May 2019 18:03:56 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C5A994E@ORSMSX122.amr.corp.intel.com>
In-Reply-To: 1e3328ab-0b00-7abf-7182-b4291f18f197@yahoo.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5182952000315357170==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Anthony
> Jenkins
> Sent: Monday, May 6, 2019 6:45 AM
> To: freebsd-acpi(a)FreeBSD.org; Devel(a)acpica.org
> Subject: [Devel] iasl -d and duplicate symbols (ACPI Error:
> AE_ALREADY_EXISTS)
> =

> Hi all,
> =

> I am trying to patch the ACPI tables on my Dell XPS 15 9570 running FreeB=
SD
> 13.0-CURRENT @ git commit 68c8581f772. 'acpidump -d -t' gives error
> AE_ALREADY_EXISTS when trying to add symbol
> \_SB.PCI0.XHC.RHUB.HS01._UPC.?? Google says this is because my BIOS' set
> of ACPI tables contains two duplicate tables, and it fails to add symbols=
 from
> the 2nd table because they already exist from the 1st.
> =

[Schmauss, Erik] =

+JK
Hi,

> Q: By "duplicate table", does this mean the entire body of the table
> (excluding its header) is duplicated?

It depends. A single table can declare multiple named objects. This message=
 indicates that these symbols have been declared in multiple tables. If the=
 entire body of the table is duplicated you should get a lot of these error=
s. However, it does not necessarily mean that there are duplicate tables. S=
ome content may be different.

> =

> What's the standard practice for handling this error? I assume I have to:
> =

In order to solve this issue, it must be done in the firmware. Please make =
sure that you have the latest firmware from dell.

Once you do, please attach a dmesg of free BSD booting with the latest firm=
ware. The dmesg should also contain these ACPI errors.

There are similar issues with Linux that I've been seeing but I would like =
to make sure that you have their latest firmware before involving dell...

>  1. Identify the two duplicate tables
>  2. Tell 'iasl -d' (which is what 'acpidump' calls to do the
>     disassembly) to exclude one of the two tables
> =

> I have no idea how to do either of these two tasks with the set of acpica=
 tools
> I have (iasl version 20190108)...anyone have any pointers?
> =

> Is there a way to extract (using acpica tools) the body of a single named=
 ACPI
> table?

No
> =

> I have some ideas for patches to acpica to help with this increasingly co=
mmon
> issue:
> =

>   * Patch iasl(1) to emit more information about the origins of the
>     symbols it parses, such that an AE_ALREADY_EXISTS error would also
>     emit the origin (table name) of the existing symbol and that of the
>     current table it's trying to add.
>   * Patch iasl(1) to add a user option (flag) to ignore tables with
>     duplicate symbols, possibly adding a parameter indicating number of
>     duplicates or percentage of duplication before dropping that table.
> =

> Would any/all of these patches be useful/considered for acceptance into
> acpica?

Possibly, I think the second option hides things from the user which can be=
 even more confusing.
First option seems better but it might be non-trivial. I'll bring it up wit=
h Bob.

I hope this helps. Let me know if you have any other questions

Erik

> =

> Thanks in advance,
> Anthony Jenkins
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============5182952000315357170==--

