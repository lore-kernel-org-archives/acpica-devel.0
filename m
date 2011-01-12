Content-Type: multipart/mixed; boundary="===============6782968836546137821=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] FW: ACPICA version 20110112 released
Date: Wed, 12 Jan 2011 10:26:46 -0800
Message-ID: <4911F71203A09E4D9981D27F9D830858BFE77078@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6782968836546137821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

12 January 2011. Summary of changes for version 20110112:

This release is available at www.acpica.org/downloads

1) ACPI CA Core Subsystem:

Fixed a race condition between method execution and namespace walks that ca=
n possibly cause a fault. The problem was apparently introduced in version =
20100528 as a result of a performance optimization that reduces the number =
of namespace walks upon method exit by using the delete_namespace_subtree f=
unction instead of the delete_namespace_by_owner function used previously. =
Bug is a missing namespace lock in the delete_namespace_subtree function. d=
ana.myers(a)oracle.com

Fixed several issues and a possible fault with the automatic "serialized" m=
ethod support. History: This support changes a method to "serialized" on th=
e fly if the method generates an AE_ALREADY_EXISTS error, indicating the po=
ssibility that it cannot handle reentrancy. This fix repairs a couple of is=
sues seen in the field, especially on machines with many cores:

    1) Delete method children only upon the exit of the last thread,
       so as to not delete objects out from under other running threads
      (and possibly causing a fault.)
    2) Set the "serialized" bit for the method only upon the exit of the
       Last thread, so as to not cause deadlock when running threads
       attempt to exit.
    3) Cleanup the use of the AML "MethodFlags" and internal method flags
       so that there is no longer any confusion between the two.

    Lin Ming, Bob Moore. Reported by dana.myers(a)oracle.com.

Debugger: Now lock the namespace for duration of a namespace dump. Prevents=
 issues if the namespace is changing dynamically underneath the debugger. E=
specially affects temporary namespace nodes, since the debugger displays th=
ese also.

Updated the ordering of include files. The ACPICA headers should appear bef=
ore any compiler-specific headers (stdio.h, etc.) so that acenv.h can set a=
ny necessary compiler-specific defines, etc. Affects the ACPI-related tools=
 and utilities.

Updated all ACPICA copyrights and signons to 2011. Added the 2011 copyright=
 to all module headers and signons, including the Linux header. This affect=
s virtually every file in the ACPICA core subsystem, iASL compiler, and all=
 utilities.

Added project files for MS Visual Studio 2008 (VC++ 9.0). The original proj=
ect files for VC++ 6.0 are now obsolete. New project files can be found und=
er acpica/generate/msvc9. See acpica/generate/msvc9/readme.txt for details.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release (VC 6.0):
    Non-Debug Version:  89.8K Code, 18.9K Data, 108.7K Total
    Debug Version:     166.6K Code, 52.1K Data, 218.7K Total
  Current Release (VC 9.0):
    Non-Debug Version:  89.7K Code, 23.7K Data, 113.4K Total
    Debug Version:     163.9K Code, 67.5K Data, 231.4K Total

2) iASL Compiler/Disassembler and Tools:

iASL: Added generic data types to the Data Table compiler. Add "generic" da=
ta types such as UINT32, String, Unicode, etc., to simplify the generation =
of platform-defined tables such as UEFI. Lin Ming.

iASL: Added listing support for the Data Table Compiler. Adds listing suppo=
rt (-l) to display actual binary output for each line of input code.


--===============6782968836546137821==--

