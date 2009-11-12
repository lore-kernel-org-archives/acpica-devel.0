Content-Type: multipart/mixed; boundary="===============0325164749268384462=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20091112 released
Date: Thu, 12 Nov 2009 10:42:12 -0800
Message-ID: <4911F71203A09E4D9981D27F9D8308583E3066A4@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0325164749268384462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

12 November 2009. Summary of changes for version 20091112:

This release is available at www.acpica.org/downloads

1) ACPI CA Core Subsystem:

Implemented a post-order callback to AcpiWalkNamespace. The existing interf=
ace only has a pre-order callback. This change adds an additional parameter=
 for a post-order callback which will be more useful for bus scans. ACPICA =
BZ 779. Lin Ming. Updated the ACPICA Programmer Reference.

Modified the behavior of the operation region memory mapping cache for Syst=
emMemory. Ensure that the memory mappings created for operation regions do =
not cross 4K page boundaries. Crossing a page boundary while mapping region=
s can cause kernel warnings on some hosts if the pages have different attri=
butes. Such regions are probably BIOS bugs, and this is the workaround. Lin=
ux BZ 14445. Lin Ming.

Implemented an automatic repair for predefined methods that must return sor=
ted lists. This change will repair (by sorting) packages returned by _ALR, =
_PSS, and _TSS. Drivers can now assume that the packages are correctly sort=
ed and do not contain NULL package elements. Adds one new file, namespace/n=
srepair2.c. ACPICA BZ 784. Lin Ming, Bob Moore.

Fixed a possible fault during predefined name validation if a return Packag=
e object contains NULL elements. Also adds a warning if a NULL element is f=
ollowed by any non-null elements. ACPICA BZ 813, 814. Future enhancement ma=
y include repair or removal of all such NULL elements where possible.

Implemented additional module-level executable AML code support. This chang=
e will execute module-level code that is not at the root of the namespace (=
under a Device object, etc.) at table load time. Module-level executable AM=
L code has been illegal since ACPI 2.0. ACPICA BZ 762. Lin Ming.

Implemented a new internal function to create Integer objects. This functio=
n simplifies miscellaneous object creation code. ACPICA BZ 823.

Reduced the severity of predefined repair messages, Warning to Info. Since =
the object was successfully repaired, a warning is too severe. Reduced to a=
n info message for now. These messages may eventually be changed to debug-o=
nly. ACPICA BZ 812.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 6.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  85.8K Code, 18.0K Data, 103.8K Total
    Debug Version:     161.8K Code, 50.6K Data, 212.4K Total
  Current Release:
    Non-Debug Version:  86.6K Code, 18.2K Data, 104.8K Total
    Debug Version:     162.7K Code, 50.8K Data, 213.5K Total

2) iASL Compiler/Disassembler and Tools:

iASL: Implemented Switch() with While(1) so that Break works correctly. Thi=
s change correctly implements the Switch operator with a surrounding While(=
1) so that the Break operator works as expected. ACPICA BZ 461. Lin Ming.

iASL: Added a message if a package initializer list is shorter than package=
 length. Adds a new remark for a Package() declaration if an initializer li=
st exists, but is shorter than the declared length of the package. Although=
 technically legal, this is probably a coding error and it is seen in the f=
ield. ACPICA BZ 815. Lin Ming, Bob Moore.

iASL: Fixed a problem where the compiler could fault after the maximum numb=
er of errors was reached (200).

acpixtract: Fixed a possible warning for pointer cast if the compiler warni=
ng level set very high.


--===============0325164749268384462==--

