Content-Type: multipart/mixed; boundary="===============3229021573502922268=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20130517 released
Date: Fri, 17 May 2013 17:00:57 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE6CCED@ORSMSX103.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3229021573502922268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

17 May 2013. Summary of changes for version 20130517:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Fixed a regression introduced in version 20130328 for _INI methods. This ch=
ange fixes a problem introduced in 20130328 where _INI methods are no longe=
r executed properly because of a memory block that was not initialized corr=
ectly. ACPICA BZ 1016. Tomasz Nowicki <tomasz.nowicki(a)linaro.org>.

Fixed a possible problem with the new extended sleep registers in the ACPI =
5.0 FADT. Do not use these registers (even if populated) unless the HW-redu=
ced bit is set in the FADT (as per the ACPI specification). ACPICA BZ 1020.=
 Lv Zheng.

Implemented return value repair code for _CST predefined objects: Sort the =
list and detect/remove invalid entries. ACPICA BZ 890. Lv Zheng.

Implemented a debug-only option to disable loading of SSDTs from the RSDT/X=
SDT during ACPICA initialization. This can be useful for debugging ACPI pro=
blems on some machines. Set AcpiGbl_DisableSsdtTableLoad in acglobal.h - AC=
PICA BZ 1005. Lv Zheng.

Fixed some issues in the ACPICA initialization and termination code: Tomasz=
 Nowicki <tomasz.nowicki(a)linaro.org>
1) Clear events initialized flag upon event component termination. ACPICA B=
Z 1013.
2) Fixed a possible memory leak in GPE init error path. ACPICA BZ 1018. =

3) Delete global lock pending lock during termination. ACPICA BZ 1012.
4) Clear debug buffer global on termination to prevent possible multiple de=
lete. ACPICA BZ 1010.

Standardized all switch() blocks across the entire source base. After many =
years, different formatting for switch() had crept in. This change makes th=
e formatting of every switch block identical. ACPICA BZ 997. Chao Guan.

Split some files to enhance ACPICA modularity and configurability:
1) Split buffer dump routines into utilities/utbuffer.c
2) Split internal error message routines into utilities/uterror.c
3) Split table print utilities into tables/tbprint.c
4) Split iASL command-line option processing into asloptions.c

Makefile enhancements:
1) Support for all new files above.
2) Abort make on errors from any subcomponent. Chao Guan.
3) Add build support for Apple Mac OS X. Liang Qi.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version:  96.0K Code, 27.0K Data, 123.0K Total
    Debug Version:     184.1K Code, 76.8K Data, 260.9K Total
  Previous Release:
    Non-Debug Version:  95.6K Code, 26.8K Data, 122.4K Total
    Debug Version:     183.5K Code, 76.6K Data, 260.1K Total


2) iASL Compiler/Disassembler and Tools:

New utility: Implemented an easily portable version of the acpidump utility=
 to extract ACPI tables from the system (or a file) in an ASCII hex dump fo=
rmat. The top-level code implements the various command line options, file =
I/O, and table dump routines. To port to a new host, only three functions n=
eed to be implemented to get tables -- since this functionality is OS-depen=
dent. See the tools/acpidump/apmain.c module and the ACPICA reference for p=
orting instructions. ACPICA BZ 859. Notes:
1) The Windows version obtains the ACPI tables from the Registry.
2) The Linux version is under development.
3) Other hosts - If an OS-dependent module is submitted, it will be distrib=
uted with ACPICA.

iASL: Fixed a regression for -D preprocessor option (define symbol). A rest=
ructuring/change to the initialization sequence caused this option to no lo=
nger work properly.

iASL: Implemented a mechanism to disable specific warnings and remarks. Add=
s a new command line option, "-vw <messageid> as well as "#pragma disable <=
messageid>". ACPICA BZ 989. Chao Guan, Bob Moore.

iASL: Fix for too-strict package object validation. The package object vali=
dation for return values from the predefined names is a bit too strict, it =
does not allow names references within the package (which will be resolved =
at runtime.) These types of references cannot be validated at compile time.=
 This change ignores named references within package objects for names that=
 return or define static packages.

Debugger: Fixed the 80-character command line limitation for the History co=
mmand. Now allows lines of arbitrary length. ACPICA BZ 1000. Chao Guan.

iASL: Added control method and package support for the -so option (generate=
s AML offset table for BIOS support.)

iASL: issue a remark if a non-serialized method creates named objects. If a=
 thread blocks within the method for any reason, and another thread enters =
the method, the method will fail because an attempt will be made to create =
the same (named) object twice. In this case, issue a remark that the method=
 should be marked serialized. NOTE: may become a warning later. ACPICA BZ 9=
09.


--===============3229021573502922268==--

