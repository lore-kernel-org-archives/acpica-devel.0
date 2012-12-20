Content-Type: multipart/mixed; boundary="===============7721810945572129153=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] ACPICA version 20121220 released
Date: Thu, 20 Dec 2012 18:42:45 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346BF2E72@ORSMSX101.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7721810945572129153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

20 December 2012. Summary of changes for version 20121220:

This release is available at https://www.acpica.org/downloads
The ACPI 5.0 specification is available at www.acpi.info

1) ACPICA Kernel-resident Subsystem:

Implemented a new interface, AcpiWalkResourceBuffer. This interface is an a=
lternate entry point for AcpiWalkResources and improves the usability of th=
e resource manager by accepting as input a buffer containing the output of =
either a _CRS, _PRS, or _AEI method. The key functionality is that the inpu=
t buffer is not deleted by this interface so that it can be used by the hos=
t later. See the ACPICA reference for details.

Interpreter: Add a warning if a 64-bit constant appears in a 32-bit table (=
DSDT version < 2). The constant will be truncated and this warning reflects=
 that behavior.

Resource Manager: Add support for the new ACPI 5.0 wake bit in the IRQ, Ext=
endedInterrupt, and GpioInt descriptors. This change adds support to both g=
et and set the new wake bit in these descriptors, separately from the exist=
ing share bit. Reported by Aaron Lu.

Interpreter: Fix Store() when an implicit conversion is not possible. For e=
xample, in the cases such as a store of a string to an existing package obj=
ect, implement the store as a CopyObject(). This is a small departure from =
the ACPI specification which states that the control method should be abort=
ed in this case. However, the ASLTS suite depends on this behavior.

Performance improvement for the various FUNCTION_TRACE and DEBUG_PRINT macr=
os: check if debug output is currently enabled as soon as possible to minim=
ize performance impact if debug is in fact not enabled.

Source code restructuring: Cleanup to improve modularity. The following new=
 files have been added: dbconvert.c, evhandler.c, nsprepkg.c, psopinfo.c, p=
sobject.c, rsdumpinfo.c, utstring.c, and utownerid.c. Associated makefiles =
and project files have been updated.

Changed an exception code for LoadTable operator. For the case where one of=
 the input strings is too long, change the returned exception code from AE_=
BAD_PARAMETER to AE_AML_STRING_LIMIT.

Fixed a possible memory leak in dispatcher error path. On error, delete the=
 mutex object created during method mutex creation. Reported by tim.gardner=
(a)canonical.com.

Example Code and Data Size: These are the sizes for the OS-independent acpi=
ca.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The debug =
version of the code includes the debug output trace mechanism and has a muc=
h larger code and data size.

  Previous Release:
    Non-Debug Version:  94.3K Code, 25.3K Data, 119.6K Total
    Debug Version:     175.5K Code, 74.5K Data, 250.0K Total
  Current Release:
    Non-Debug Version:  94.5K Code, 25.5K Data, 120.0K Total
    Debug Version:     182.2K Code, 74.9K Data, 257.1K Total


2) iASL Compiler/Disassembler and Tools:

iASL: Disallow a method call as argument to the ObjectType ASL operator. Th=
is change tracks an errata to the ACPI 5.0 document. The AML grammar will n=
ot allow the interpreter to differentiate between a method and a method inv=
ocation when these are used as an argument to the ObjectType operator. The =
ACPI specification change is to disallow a method invocation (UserTerm) for=
 the ObjectType operator.

Finish support for the TPM2 and CSRT tables in the headers, table compiler,=
 and disassembler.

Unix user-space OSL: Fix a problem with WaitSemaphore where the timeout alw=
ays expires immediately if the semaphore is not available. The original cod=
e was using a relative-time timeout, but sem_timedwait requires the use of =
an absolute time.

iASL: Added a remark if the Timer() operator is used within a 32-bit table.=
 This operator returns a 64-bit time value that will be truncated within a =
32-bit table.

iASL Source code restructuring: Cleanup to improve modularity. The followin=
g new files have been added: aslhex.c, aslxref.c, aslnamesp.c, aslmethod.c,=
 and aslfileio.c. Associated makefiles and project files have been updated.



--===============7721810945572129153==--

