Content-Type: multipart/mixed; boundary="===============9036281271103762663=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20201113 released
Date: Fri, 13 Nov 2020 17:58:34 +0000
Message-ID: <BYAPR11MB325623E70C833C82CB2892FE87E60@BYAPR11MB3256.namprd11.prod.outlook.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9036281271103762663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

13 November 2020. Summary of changes for version 20201113:

This release is available at https://acpica.org/downloads


1) ACPICA kernel-resident subsystem:

Interpreter: fixed a memory leak by using use existing buffer in _HID repai=
r. There was a memory leak that occurred when a _CID object is defined as a=
 package containing string objects. When _CID is checked for any possible r=
epairs, it calls a helper function to repair _HID (because _CID basically c=
ontains multiple _HID entries). The _HID repair function assumes that strin=
g objects are standalone objects that are not contained inside of any packa=
ges. The _HID repair function replaced the string object with a brand new o=
bject and attempted to delete the old object by decrementing the reference =
count of the old object. Strings inside of packages have a reference count =
of 2 so the _HID repair function leaves this object in a dangling state and=
 causes a memory leak. Instead of allocating a brand new object and removin=
g the old object, use the existing object when repairing the _HID object.

Added function trace macros to improve namespace debugging. The namespace r=
epair mechanism does not have function tracing macros. Add several trace ma=
cros to improve debuggability.

Handle "orphan" _REG methods for GPIO OpRegions. Before this change AcpiEvE=
xecuteRegMethods() had special handling to handle "orphan" (no matching OpR=
egion declared) _REG methods for EC nodes. On Intel Cherry Trail devices th=
ere are 2 possible ACPI OpRegions for accessing GPIOs. The standard General=
PurposeIo OpRegion and the Cherry Trail - specific UserDefined 0x9X OpRegio=
ns. Having 2 different types of OpRegions leads to potential issues with ch=
ecks for OpRegion availability, or in other words checks if _REG has been c=
alled for the OpRegion which the ACPI code wants to use. Except for the "or=
phan" EC handling, ACPICA core does not call _REG on an ACPI node which doe=
s not define an OpRegion matching the type being registered; and the refere=
nce design DSDT, from which most Cherry Trail DSDTs are derived, does not d=
efine GeneralPurposeIo, nor UserDefined(0x93) OpRegions for the GPO2 (UID 3=
) device, because no pins were assigned ACPI controlled functions in the re=
ference design. Together this leads to the perfect storm, at least on the C=
herry Trail based Medion Akayo E1239T. This design does use a GPO2 pin from=
 its ACPI code and has added the Cherry Trail specific UserDefined(0x93) op=
region to its GPO2 ACPI node to access this pin. But it uses a "has _REG be=
en called" availability check for the standard GeneralPurposeIo OpRegion. T=
his clearly is a bug in the DSDT, but this does work under Windows. This is=
sue leads to the intel vbtn driver reporting the device always being in tab=
let-mode at boot, even if it is in laptop mode. Which in turn causes usersp=
ace to ignore touchpad events. So in other words, this issue causes the tou=
chpad to not work at boot. This change fixes this by extending the "orphan"=
 _REG method handling to also apply to GPIO address-space handlers.


2) iASL Compiler/Disassembler and ACPICA tools: =


iASL: Added more info to namespace dump file (-ln option). In a separate se=
ction of the dump file (after the main namespace dump), emit the full pathn=
ame for each namespace node, its type, and the ASL filename and line number=
 where it is declared.

AcpiHelp: Added an option to display/decode iASL exceptions. Option is: -x =
[Hex Value] where "Hex Value" is the iASL exception code. If Hex Value is o=
mitted, all iASL exceptions are displayed.

iASL: Use StringLiteral instead of StringData for some ASL macros. The use =
of the stringData rule allows for some "string" oriented opcodes (Such as T=
oString, ToHexString, etc.) None of which make sense with the macros in que=
stion. This change modifies the StringData part of the rule for these macro=
s to a simple string  literal - thus disallowing the use of ToString, ToHex=
String, etc.
The following ASL operators (macros) are affected:
EisaId
Fprintf
Printf
ToUuid
Unicode
Note: The MS compiler requires the use of string literals for these operato=
rs also.

iASL: Added a remark for an unknown UUID: ASL_MSG_UUID_NOT_FOUND. Search th=
e list of "known" UUIDs for the input to the ToUUID macro.

Added 5 new UUIDs to the known UUID table. All related to NVDIMM and the NF=
IT table.

--===============9036281271103762663==--

