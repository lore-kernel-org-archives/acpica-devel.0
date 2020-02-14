Content-Type: multipart/mixed; boundary="===============4570592051655705522=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20200214 released
Date: Fri, 14 Feb 2020 18:00:09 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96EA09A@ORSMSX110.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4570592051655705522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

14 February 2020. Summary of changes for version 20200214:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Enable sleep button on ACPI legacy wake:  Hibernation (S4) is triggered in =
a guest when it receives a sleep trigger from the hypervisor. When the gues=
t resumes from this power state, it does not see the SleepEnabled bit. In o=
ther words, the sleepHibernation (S4) is triggered in a guest when it recei=
ves a sleep trigger from the hypervisor. When the guest resumes from this p=
ower state, it does not see the SleepEnabled bit. In other words, the sleep=
 button is not enabled on waking from an S4 state. This causes subsequent i=
nvocation of sleep state to fail since the guest.button is not enabled on w=
aking from an S4 state. This causes subsequent invocation of sleep state to=
 fail in the guest. Fix this problem by enabling the sleep button in ACPI l=
egacy wake. From Anchal Agarwal <anchalag(a)amazon.com>.

Implemented a new external interface, AcpiAnyGpeStatusSet (). To be used fo=
r checking the status bits of all enabled GPEs in one go. It is needed to d=
istinguish spurious SCIs from genuine ones when deciding whether or not to =
wake up the system from suspend-to-idle.

Generic Makefiles: replace HOST name with ACPI_HOST: Some machines may be u=
sing HOST in their environment to represent the host name for their machine=
s. Avoid this problem by renaming this variable from HOST to ACPI_HOST.

MSVC 2017 project files: Enable multiprocessor generation to improve build =
performance.

Added a macro to get the byte width of a Generic Address structure. New ACP=
I_ACCESS_BYTE_WIDTH is in addition to the existing ACPI_ACCESS_BIT_WIDTH. F=
rom Mika Westerberg.


2) iASL Compiler/Disassembler and ACPICA tools: =


iASL: Implemented full support for the (optional, rarely used) ReturnType a=
nd ParameterTypesList for the Method, Function, and External operators. For=
 Method declarations, the number of individual ParameterTypes must match th=
e declaration of the number of arguments (NumArgs). This also Fixes a probl=
em with the External operator where extra/extraneous bytes were emitted in =
the AML code if the optional ReturnType/ParameterTypes were specified for a=
 MethodObj declaration.
New error message:
1) Method NumArgs count does not match length of ParameterTypes list

iASL: Implemented detection of type mismatches between External declaration=
s and named object declarations. Also, detect type mismatches between multi=
ple External declarations of the same Name.
New error messages:
1) Type mismatch between external declaration and actual object declaration=
 detected
2) Type mismatch between multiple external declarations detected

iASL: Implemented new error messages for External operators that specify a =
ReturnType and/or ParameterTypesList for any object type other than control=
 methods (MethodObj).
New error messages:
1) Return type is only allowed for Externals declared as MethodObj
2) Parameter type is only allowed for Externals declared as MethodObj

iASL: Implemented two new remark/warning messages for ASL code that creates=
 named objects from within a control method. This is very inefficient since=
 the named object must be created and deleted each time the method is execu=
ted.
New messages:
1) Creation of named objects within a method is highly inefficient, use glo=
bals or method local variables instead (remark)
2) Static OperationRegion should be declared outside control method (warnin=
g)

iASL: Improved illegal forward reference detection by adding support to det=
ect forward-reference method invocations.

iASL: Detect and issue an error message for NameStrings that contain too ma=
ny individual NameSegs (>255). This is an AML limitation that is defined in=
 the ACPI specification.
New message:
1) NameString contains too many NameSegs (>255)

acpidump: windows: use GetSystemFirmwareTable API for all tables except SSD=
T. By using this API, acpidump is able to get all tables in the XSDT

iASL: Removed unused parser file and updated msvc2017 project files. Remove=
d the obsolete AslCompiler.y from the repository.

iASL: msvc2017: Fixed macros in the file dependency list to prevent unneces=
sary rebuilds. Replace %(Directory) with %(RelativeDir).

Disassembler: Prevent spilling error messages to the output file. All error=
s are directed to the console instead. These error messages prevented re-co=
mpilation of the resulting disassembled ASL output file (.DSL).

--===============4570592051655705522==--

