Content-Type: multipart/mixed; boundary="===============1980940485495548981=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] ACPICA version 20150818 released
Date: Tue, 25 Aug 2015 20:50:38 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D34055E@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 55DCC2CA.7010406@FreeBSD.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1980940485495548981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Unfortunately, AcpiNames does not build because
> source/tools/acpinames/acpinames.h is wrongly included as AcpiNames.h in
> the release tarballs.


Is this something new?


> -----Original Message-----
> From: Jung-uk Kim [mailto:jkim(a)FreeBSD.org]
> Sent: Tuesday, August 25, 2015 12:32 PM
> To: Moore, Robert; acpica.org list
> Subject: Re: [Devel] ACPICA version 20150818 released
> =

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> =

> On 08/18/2015 16:27, Moore, Robert wrote:
> > 18 August 2015. Summary of changes for version 20150818:
> >
> > This release is available at https://acpica.org/downloads
> >
> > 1) ACPICA kernel-resident subsystem:
> >
> > Fix a regression for AcpiGetTableByIndex interface causing it to fail.
> > Lv Zheng. ACPICA BZ 1186.
> >
> > Completed development to ensure that the ACPICA Disassembler and
> > Debugger are fully standalone components of ACPICA. Removed
> > cross-component dependences. Lv Zheng.
> >
> > The max-number-of-AML-loops is now runtime configurable (previously
> > was compile-time only). This is essentially a loop timeout to
> > force-abort infinite AML loops. ACPCIA BZ 1192.
> >
> > Debugger: Cleanup output to dump ACPI names and namepaths without any
> > trailing underscores. Lv Zheng. ACPICA BZ 1135.
> >
> > Removed unnecessary conditional compilations across the Debugger and
> > Disassembler components where entire modules could be left uncompiled.
> >
> > The aapits test is deprecated and has been removed from the ACPICA git
> > tree. The test has never been completed and has not been maintained,
> > thus becoming rather useless. ACPICA BZ 1015, 794.
> >
> > A batch of small changes to close bugzilla and other reports: - Remove
> > duplicate code for _PLD processing. ACPICA BZ 1176. - Correctly
> > cleanup after a ACPI table load failure. ACPICA BZ 1185.
> > - iASL: Support POSIX yacc again in makefile. Jung-uk Kim. - ACPI
> > table support: general cleanup and simplification. Lv Zheng, Bob
> > Moore. - ACPI table support: fix for a buffer read overrun in
> > AcpiTbFindTable. ACPICA BZ 1184. - Enhance parameter validation for
> > DataTableRegion and LoadTable ASL/AML operators. - Debugger: Split
> > debugger initialization/termination interfaces. Lv Zheng. -
> > AcpiExec: Emit OemTableId for SSDTs during the load phase for table
> > identification. - AcpiExec: Add debug message during _REG method phase
> > during table load/init. - AcpiNames: Fix a regression where some
> > output was missing and no longer emitted. - Debugger: General cleanup
> > and simplification. Lv Zheng. - Disassembler: Cleanup use of several
> > global option variables. Lv Zheng.
> >
> > Example Code and Data Size: These are the sizes for the OS-independent
> > acpica.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler.
> > The debug version of the code includes the debug output trace
> > mechanism and has a much larger code and data size.
> >
> > Current Release: Non-Debug Version: 101.3K Code, 27.7K Data, 129.0K
> > Total Debug Version:     198.6K Code, 80.9K Data, 279.5K Total
> > Previous Release: Non-Debug Version: 100.9K Code, 24.5K Data,
> > 125.4K Total Debug Version:     197.8K Code, 81.5K Data, 279.3K
> > Total
> >
> >
> > 2) iASL Compiler/Disassembler and Tools:
> >
> > AcpiExec: Fixed a problem where any more than 32 ACPI tables in the
> > XSDT were not handled properly and caused load errors. Now, properly
> > invoke and use the ACPICA auto-reallocate mechanism for ACPI table
> > data structures. ACPICA BZ 1188
> >
> > AcpiNames: Add command-line wildcard support for ACPI table files.
> > ACPICA BZ 1190.
> >
> > AcpiExec and AcpiNames: Add -l option to load ACPI tables only. For
> > AcpiExec, this means that no control methods (like _REG/_INI/_STA) are
> > executed during initialization. ACPICA BZ 1187, 1189.
> >
> > iASL/Disassembler: Implemented a prototype "listing" mode that emits
> > AML that corresponds to each disassembled ASL statement, to simplify
> > debugging. ACPICA BZ 1191.
> >
> > Debugger: Add option to the "objects" command to display a summary of
> > the current namespace objects (Object type and count). This is
> > displayed if the command is entered with no arguments.
> >
> > AcpiNames: Add -x option to specify debug level, similar to AcpiExec.
> =

> Unfortunately, AcpiNames does not build because
> source/tools/acpinames/acpinames.h is wrongly included as AcpiNames.h in
> the release tarballs.
> =

> Jung-uk Kim
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2
> =

> iQEcBAEBCAAGBQJV3MLFAAoJEHyflib82/FGeEMIAJDq/QxudIf9sWxM+2BuINzQ
> 7QButUDMtoZNdiNbwR2up62N4/5l6zBxrN04L17RhsjYmcSWMU9yiIgs5InRSQE6
> XkEkCarqUbP9EIgTYR1x/YuOFCI5zBUz0YS7vEKK/gcBGaeyVeL8ivGuDTxf4y3w
> kHQTmNDSM8IyTGOJNf8pv9FsQJBLUc2BJtXIYwzgYlPrDx8EiIwZ4m838EUUO/7u
> T37pRhYWJpPNN6QWBBJQa3fkYLMcH/TtvErlZj3JBe3d7B8MXQQzmfZESTMIIr0R
> mRX+I3h91CzhOVPMBQFg7G++4tYVqlwIdo9JrBBLUW6zQ+Hqcpi4LEDly062cK4=3D
> =3DBoS3
> -----END PGP SIGNATURE-----

--===============1980940485495548981==--

