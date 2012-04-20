Content-Type: multipart/mixed; boundary="===============5162574266611486884=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20120420 released
Date: Fri, 20 Apr 2012 20:37:32 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346A72E15@ORSMSX101.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5162574266611486884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

20 April 2012. Summary of changes for version 20120420:

This release is available at www.acpica.org/downloads.
The ACPI 5.0 specification is available at www.acpi.info.

1) ACPICA Core Subsystem:

Implemented support for multiple notify handlers. This change adds support =
to allow multiple system and device notify handlers on Device, Thermal Zone=
, and Processor objects. This can simplify the host OS notification impleme=
ntation. Also re-worked and restructured the entire notify support code to =
simplify handler installation, handler removal, notify event queuing, and n=
otify dispatch to handler(s). Note: there can still only be two global noti=
fy handlers - one for system notifies and one for device notifies. There ar=
e no changes to the existing handler install/remove interfaces. Lin Ming, B=
ob Moore, Rafael Wysocki.

Fixed a regression in the package repair code where the object reference co=
unt was calculated incorrectly. Regression was introduced in the commit "Su=
pport to add Package wrappers".

Fixed a couple possible memory leaks in the AML parser, in the error recove=
ry path. Jesper Juhl, Lin Ming.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  92.9K Code, 25.0K Data, 117.9K Total
    Debug Version:     172.5K Code, 73.2K Data, 245.7K Total
  Current Release:
    Non-Debug Version:  92.9K Code, 25.0K Data, 117.9K Total
    Debug Version:     172.6K Code, 73.4K Data, 246.0K Total


2) iASL Compiler/Disassembler and Tools:

iASL: Fixed a problem with the resource descriptor support where the length=
 of the StartDependentFn and StartDependentFnNoPrio descriptors were not in=
cluded in cumulative descriptor offset, resulting in incorrect values for r=
esource tags within resource descriptors appearing after a StartDependent* =
descriptor. Reported by Petr Vandrovec. ACPICA BZ 949.

iASL and Preprocessor: Implemented full support for the #line directive to =
correctly track original source file line numbers through the .i preprocess=
or output file - for error and warning messages.

iASL: Expand the allowable byte constants for address space IDs. Previously=
, the allowable range was 0x80-0xFF (user-defined spaces), now the range is=
 0x0A-0xFF to allow for custom and new IDs without changing the compiler.

iASL: Add option to treat all warnings as errors (-we). ACPICA BZ 948.

iASL: Add option to completely disable the preprocessor (-Pn).

iASL: Now emit all error/warning messages to standard error (stderr) by def=
ault (instead of the previous stdout).

ASL Test Suite (ASLTS): Reduce iASL warnings due to use of Switch(). Update=
 for resource descriptor offset fix above. Update/cleanup error output rout=
ines. Enable and send iASL errors/warnings to an error logfile (error.txt).=
 Send all other iASL output to a logfile (compiler.txt). Fixed several extr=
aneous "unrecognized operator" messages.


--===============5162574266611486884==--

