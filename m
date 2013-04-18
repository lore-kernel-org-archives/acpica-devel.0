Content-Type: multipart/mixed; boundary="===============8069684937857837660=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20130418 released
Date: Thu, 18 Apr 2013 20:30:04 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE42948@FMSMSX153.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8069684937857837660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

18 April 2013. Summary of changes for version 20130418:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Fixed a possible buffer overrun during some rare but specific field unit re=
ad operations. This overrun can only happen if the DSDT version is 1 -- mea=
ning that all AML integers are 32 bits -- and the field length is between 3=
3 and 55 bits long. During the read, an internal buffer object is created f=
or the field unit because the field is larger than an integer (32 bits). Ho=
wever, in this case, the buffer will be incorrectly written beyond the end =
because the buffer length is less than the internal minimum of 64 bits (8 b=
ytes) long. The buffer will be either 5, 6, or 7 bytes long, but a full 8 b=
ytes will be written.

Updated the Embedded Controller "orphan" _REG method support. This refers t=
o _REG methods under the EC device that have no corresponding operation reg=
ion. This is allowed by the ACPI specification. This update removes a depen=
dency on the existence an ECDT table. It will execute an orphan _REG method=
 as long as the operation region handler for the EC is installed at the EC =
device node and not the namespace root. Rui Zhang (original update), Bob Mo=
ore (update/integrate).

Implemented run-time argument typechecking for all predefined ACPI names (_=
STA, _BIF, etc.) This change performs object typechecking on all incoming a=
rguments for all predefined names executed via AcpiEvaluateObject. This ens=
ures that ACPI-related device drivers are passing correct object types as w=
ell as the correct number of arguments (therefore identifying any issues im=
mediately). Also, the ASL/namespace definition of the predefined name is ch=
ecked against the ACPI specification for the proper argument count. Adds on=
e new file, nsarguments.c

Changed an exception code for the ASL UnLoad() operator. Changed the except=
ion code for the case where the input DdbHandle is invalid, from AE_BAD_PAR=
AMETER to the more appropriate AE_AML_OPERAND_TYPE.

Unix/Linux makefiles: Removed the use of the -O2 optimization flag in the g=
lobal makefile. The use of this flag causes compiler errors on earlier vers=
ions of GCC, so it has been removed for compatibility.

Miscellaneous cleanup:
1) Removed some unused/obsolete macros
2) Fixed a possible memory leak in the _OSI support
3) Removed an unused variable in the predefined name support
4) Windows OSL: remove obsolete reference to a memory list field

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Current Release:
    Non-Debug Version:  95.2K Code, 26.4K Data, 121.6K Total
    Debug Version:     183.0K Code, 76.0K Data, 259.0K Total
  Previous Release:
    Non-Debug Version:  95.6K Code, 26.8K Data, 122.4K Total
    Debug Version:     183.5K Code, 76.6K Data, 260.1K Total


2) iASL Compiler/Disassembler and Tools:

AcpiExec: Added installation of a handler for the SystemCMOS address space.=
 This prevents control method abort if a method accesses this space.

AcpiExec: Added support for multiple EC devices, and now install EC operati=
on region handler(s) at the actual EC device instead of the namespace root.=
 This reflects the typical behavior of host operating systems.

AcpiExec: Updated to ensure that all operation region handlers are installe=
d before the _REG methods are executed. This prevents a _REG method from ab=
orting if it accesses an address space has no handler. AcpiExec installs a =
handler for every possible address space.

Debugger: Enhanced the "handlers" command to display non-root handlers. Thi=
s change enhances the handlers command to display handlers associated with =
individual devices throughout the namespace, in addition to the currently s=
upported display of handlers associated with the root namespace node.

ASL Test Suite: Several test suite errors have been identified and resolved=
, reducing the total error count during execution. Chao Guan.


--===============8069684937857837660==--

