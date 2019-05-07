Content-Type: multipart/mixed; boundary="===============1839067623138136268=="
MIME-Version: 1.0
From: Anthony Jenkins <Scoobi_doo at yahoo.com>
Subject: Re: [Devel] iasl -d and duplicate symbols (ACPI Error:
 AE_ALREADY_EXISTS)
Date: Tue, 07 May 2019 10:09:52 -0400
Message-ID: <e619b5de-f31e-b948-97de-dde13e5bd1e5@yahoo.com>
In-Reply-To: CF6A88132359CE47947DB4C6E1709ED53C5A994E@ORSMSX122.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1839067623138136268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 5/6/19 2:03 PM, Schmauss, Erik wrote:
>
>> -----Original Message-----
>> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Anthony
>> Jenkins
>> Sent: Monday, May 6, 2019 6:45 AM
>> To: freebsd-acpi(a)FreeBSD.org; Devel(a)acpica.org
>> Subject: [Devel] iasl -d and duplicate symbols (ACPI Error:
>> AE_ALREADY_EXISTS)
>>
>> Hi all,
>>
>> I am trying to patch the ACPI tables on my Dell XPS 15 9570 running Free=
BSD
>> 13.0-CURRENT @ git commit 68c8581f772. 'acpidump -d -t' gives error
>> AE_ALREADY_EXISTS when trying to add symbol
>> \_SB.PCI0.XHC.RHUB.HS01._UPC.?? Google says this is because my BIOS' set
>> of ACPI tables contains two duplicate tables, and it fails to add symbol=
s from
>> the 2nd table because they already exist from the 1st.
>>
> [Schmauss, Erik]
> +JK
> Hi,
>
>> Q: By "duplicate table", does this mean the entire body of the table
>> (excluding its header) is duplicated?
> It depends. A single table can declare multiple named objects. This messa=
ge indicates that these symbols have been declared in multiple tables. If t=
he entire body of the table is duplicated you should get a lot of these err=
ors. However, it does not necessarily mean that there are duplicate tables.=
 Some content may be different.

Okay, thanks.?? Understand I'm only talking about the extraction and =

decompilation of the ACPI tables /after/ booting, _not_ the FreeBSD =

kernel's acpica implementation parsing those tables during boot =

(although I'm sure they probably both use the same underlying =

functions).?? The command-line decompiler, 'iasl -d', stops with error =

when hitting the first duplicate symbol, but the kernel boot process =

trudges on.

>> What's the standard practice for handling this error? I assume I have to:
> In order to solve this issue, it must be done in the firmware. Please mak=
e sure that you have the latest firmware from dell.

I updated to BIOS rev 1.10.1 dated 2019-04-30 last night =

(https://www.dell.com/support/home/us/en/19/drivers/driversdetails?driverid=
=3Dkkwch&oscode=3Dbiosa&productcode=3Dxps-15-9570-laptop). =

Same error using iasl -d / acpidump -d -t.
> Once you do, please attach a dmesg of free BSD booting with the latest fi=
rmware. The dmesg should also contain these ACPI errors.

Done. http://www.qtchat.org/~ajenkins/dmesg.today

Excerpt from dmesg (just the AE_ALREADY_EXISTS errors):

acpi0: <DELL CBX3???? > on motherboard
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS01._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS01._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS02._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS02._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS03._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS03._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS04._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS04._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS05._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS05._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS06._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS06._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS07._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS07._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS08._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS08._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS09._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS09._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS10._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS10._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS11._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS11._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS12._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.HS12._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.USR1._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.USR1._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.USR2._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.USR2._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS01._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS01._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS02._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS02._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS03._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS03._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS04._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS04._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS05._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS05._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS06._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS06._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS07._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS07._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS08._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS08._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS09._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS09._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS10._UPC], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
Firmware Error (ACPI): Failure creating =

[\134_SB.PCI0.XHC.RHUB.SS10._PLD], AE_ALREADY_EXISTS (20190108/dswload2-477)
ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog =

(20190108/psobject-372)
ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
ACPI: 13 ACPI AML tables successfully acquired and loaded
PCIe: Memory Mapped configuration base @ 0xf0000000
ioapic0: routing intpin 9 (ISA IRQ 9) to lapic 0 vector 48
acpi0: Power Button (fixed)
acpi0: wakeup code va 0xfffffe0005dff000 pa 0x9e000
unknown: memory range not supported


> There are similar issues with Linux that I've been seeing but I would lik=
e to make sure that you have their latest firmware before involving dell...

I don't think I understand involving Dell at all. Granted, I would LOVE =

to enjoin Dell to fix their firmware, but large computer manufacturer =

historically could care less about my open-source OS' acpica symbol =

parsing errors.?? I thought that because of this, the general process for =

us open-source folks was to disassemble their buggy ACPI tables, patch =

them, reassemble them and tell the kernel to parse those fixed tables =

instead of the resident buggy ones.

https://docs.freebsd.org/doc/handbook/acpi-overview.html - 11.13.3 =

Overriding the Default AML

>>   1. Identify the two duplicate tables
>>   2. Tell 'iasl -d' (which is what 'acpidump' calls to do the
>>      disassembly) to exclude one of the two tables
>>
>> I have no idea how to do either of these two tasks with the set of acpic=
a tools
>> I have (iasl version 20190108)...anyone have any pointers?
>>
>> Is there a way to extract (using acpica tools) the body of a single name=
d ACPI
>> table?
> No
>> I have some ideas for patches to acpica to help with this increasingly c=
ommon
>> issue:
>>
>>    * Patch iasl(1) to emit more information about the origins of the
>>      symbols it parses, such that an AE_ALREADY_EXISTS error would also
>>      emit the origin (table name) of the existing symbol and that of the
>>      current table it's trying to add.
>>    * Patch iasl(1) to add a user option (flag) to ignore tables with
>>      duplicate symbols, possibly adding a parameter indicating number of
>>      duplicates or percentage of duplication before dropping that table.
>>
>> Would any/all of these patches be useful/considered for acceptance into
>> acpica?
> Possibly, I think the second option hides things from the user which can =
be even more confusing.

Right, the second option would purposely ignore duplicate symbols (in =

iasl(8) only) just so the user can get some disassembled AML to try to =

patch.?? (aside: I'd modify that option's granularity to ignore =

individual duplicate symbols, not whole tables with duplicate symbols.)?? =

Right now the tool throws up its hands at the first symbol collision and =

I get nothing.?? As an option to the command-line tool, the user has to =

choose to specify it, meaning he/she chooses to ignore those collisions.

Again, my hope was to patch the buggy ACPI tables by disassembling them =

with the command-line tool, reassembling them and passing the patched =

tables to the kernel at boot time.?? I can't even get iasl(8) to give me =

the table code because of the symbol collisions.

> First option seems better but it might be non-trivial. I'll bring it up w=
ith Bob.

Depends on there being metadata associated with each symbol.?? If the =

table origin of each symbol isn't in there already, I'd just have to add =

each parsed table to a dynamic list of origins, then add a pointer to =

the current table being parsed to each parsed symbol's metadata.?? A =

collision error (AE_ALREADY_EXISTS) would follow the existing symbol's =

pointer to its origin table and print that in the error message; =

similarly with the symbol that's being added.

Thanks again for your response!
Anthony

> I hope this helps. Let me know if you have any other questions
>
> Erik
>
>> Thanks in advance,
>> Anthony Jenkins
>>
>> _______________________________________________
>> Devel mailing list
>> Devel(a)acpica.org
>> https://lists.acpica.org/mailman/listinfo/devel


--===============1839067623138136268==--

