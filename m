Content-Type: multipart/mixed; boundary="===============8814847839770365408=="
MIME-Version: 1.0
From: Anthony Jenkins <Scoobi_doo at yahoo.com>
Subject: [Devel] iasl -d and duplicate symbols (ACPI Error: AE_ALREADY_EXISTS)
Date: Mon, 06 May 2019 09:45:28 -0400
Message-ID: <1e3328ab-0b00-7abf-7182-b4291f18f197@yahoo.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8814847839770365408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I am trying to patch the ACPI tables on my Dell XPS 15 9570 running =

FreeBSD 13.0-CURRENT @ git commit 68c8581f772. 'acpidump -d -t' gives =

error AE_ALREADY_EXISTS when trying to add symbol =

\_SB.PCI0.XHC.RHUB.HS01._UPC.?? Google says this is because my BIOS' set =

of ACPI tables contains two duplicate tables, and it fails to add =

symbols from the 2nd table because they already exist from the 1st.

Q: By "duplicate table", does this mean the entire body of the table =

(excluding its header) is duplicated?

What's the standard practice for handling this error? I assume I have to:

 1. Identify the two duplicate tables
 2. Tell 'iasl -d' (which is what 'acpidump' calls to do the
    disassembly) to exclude one of the two tables

I have no idea how to do either of these two tasks with the set of =

acpica tools I have (iasl version 20190108)...anyone have any pointers?

Is there a way to extract (using acpica tools) the body of a single =

named ACPI table?

I have some ideas for patches to acpica to help with this increasingly =

common issue:

  * Patch iasl(1) to emit more information about the origins of the
    symbols it parses, such that an AE_ALREADY_EXISTS error would also
    emit the origin (table name) of the existing symbol and that of the
    current table it's trying to add.
  * Patch iasl(1) to add a user option (flag) to ignore tables with
    duplicate symbols, possibly adding a parameter indicating number of
    duplicates or percentage of duplication before dropping that table.

Would any/all of these patches be useful/considered for acceptance into =

acpica?

Thanks in advance,
Anthony Jenkins


--===============8814847839770365408==--

