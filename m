Content-Type: multipart/mixed; boundary="===============0364916464583308564=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20091214 released
Date: Mon, 14 Dec 2009 13:34:42 -0800
Message-ID: <4911F71203A09E4D9981D27F9D8308584100E201@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0364916464583308564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

14 December 2009. Summary of changes for version 20091214:

This release is available at www.acpica.org/downloads

1) ACPI CA Core Subsystem:

Enhanced automatic data type conversions for predefined name repairs. This =
change expands the automatic repairs/conversions for predefined name return=
 values to make Integers, Strings, and Buffers fully interchangeable. Also,=
 a Buffer can be converted to a Package of Integers if necessary. The nsrep=
air.c module was completely restructured. Lin Ming, Bob Moore.

Implemented automatic removal of null package elements during predefined na=
me repairs. This change will automatically remove embedded and trailing NUL=
L package elements from returned package objects that are defined to contai=
n a variable number of sub-packages. The driver is then presented with a pa=
ckage with no null elements to deal with. ACPICA BZ 819.

Implemented a repair for the predefined _FDE and _GTM names. The expected r=
eturn value for both names is a Buffer of 5 DWORDs. This repair fixes two p=
ossible problems (both seen in the field), where a package of integers is r=
eturned, or a buffer of BYTEs is returned. With assistance from Jung-uk Kim.

Implemented additional module-level code support. This change will properly=
 execute module-level code that is not at the root of the namespace (under =
a Device object, etc.). Now executes the code within the current scope inst=
ead of the root. ACPICA BZ 762. Lin Ming.

Fixed possible mutex acquisition errors when running _REG methods. Fixes a =
problem where mutex errors can occur when running a _REG method that is in =
the same scope as a method-defined operation region or an operation region =
under a module-level IF block. This type of code is rare, so the problem ha=
s not been seen before. ACPICA BZ 826. Lin Ming, Bob Moore.

Fixed a possible memory leak during module-level code execution. An object =
could be leaked for each block of executed module-level code if the interpr=
eter slack mode is enabled This change deletes any implicitly returned obje=
ct from the module-level code block. Lin Ming.

Removed messages for successful predefined repair(s). The repair mechanism =
was considered too wordy. Now, messages are only unconditionally emitted if=
 the return object cannot be repaired. Existing messages for successful rep=
airs were converted to ACPI_DEBUG_PRINT messages for now. ACPICA BZ 827.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 6.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  86.6K Code, 18.2K Data, 104.8K Total
    Debug Version:     162.7K Code, 50.8K Data, 213.5K Total
  Current Release:
    Non-Debug Version:  87.0K Code, 18.0K Data, 105.0K Total
    Debug Version:     163.4K Code, 50.8K Data, 214.2K Total

2) iASL Compiler/Disassembler and Tools:

iASL: Fixed a regression introduced in 20091112 where intermediate .SRC fil=
es were no longer automatically removed at the termination of the compile.

acpiexec: Implemented the -f option to specify default region fill value. T=
his option specifies the value used to initialize buffers that simulate ope=
ration regions. Default value is zero. Useful for debugging problems that d=
epend on a specific initial value for a region or field.


--===============0364916464583308564==--

