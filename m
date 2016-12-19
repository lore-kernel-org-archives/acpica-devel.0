Content-Type: multipart/mixed; boundary="===============8362105171193557795=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Devel Digest, Vol 72,
 Issue 1: ACPICA version 20161117 released (Moore, Robert)
Date: Mon, 19 Dec 2016 16:40:41 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E547467@ORSMSX110.amr.corp.intel.com>
In-Reply-To: AM5PR0801MB1955129CB8AA0B9CB6A46E999A910@AM5PR0801MB1955.eurprd08.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8362105171193557795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Please open a Bugzilla on this at https://bugs/acpica.org, and we can have =
a look at it.
Thanks,
Bob


> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Alexei
> Fedorov
> Sent: Monday, December 19, 2016 2:33 AM
> To: devel(a)acpica.org
> Subject: Re: [Devel] Devel Digest, Vol 72, Issue 1: ACPICA version
> 20161117 released (Moore, Robert)
> =

> Hi,
> =

> When ACPI IORT template is created with "iasl.exe -T IORT", the
> generated ITS group node also contains 1 entry in the array of ID
> mappings:
> =

> [0001]                               Type : 00
> [0002]                             Length : 002C
> [0001]                           Revision : 00
> [0004]                           Reserved : 00000000
> [0004]                      Mapping Count : 00000001
> [0004]                     Mapping Offset : 00000018
> =

> [0004]                           ItsCount : 00000001
> [0004]                        Identifiers : 00000000
> =

> [0004]                         Input base : 00000000
> [0004]                           ID Count : 00000000
> [0004]                        Output Base : 00000000
> [0004]                   Output Reference : 00000000
> [0004]              Flags (decoded below) : 00000000
>                            Single Mapping : 0
> =

> This contradicts with the IO Remapping Table specification
> (http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_R
> emapping_Table.pdf) Table 11 which reads:
> =

> "Number of ID mappings: This field has a value of 0. ITS groups do not
> have IDs.
> Reference to ID Array: This field has a value of 0. There is no ID
> array."
> =

> That implies that "Mapping Count" and "Mapping Offset" fields should be
> set to 0 and ID array data removed.
> =

> If the Iort.asl template is compiled and then Iort.aml binary
> disassembled to Iort.dsl,
> SMMUv1 node lists incorrect offset for SMMU_NSgCfgIrpt Interrupt which
> has the same [0ECh 0236] value as for SMMU_NSgIrpt:
> =

> [0ECh 0236   8]       SMMU_NSgIrpt Interrupt : 0000000000000000
> [0ECh 0236   8]    SMMU_NSgCfgIrpt Interrupt : 0000000000000000
> =

> but should be set to [0F4h 0244]
> =

> Alexei.
> =

> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of devel-
> request(a)acpica.org
> Sent: 19 December 2016 06:05
> To: devel(a)acpica.org
> Subject: Devel Digest, Vol 72, Issue 1
> =

> Send Devel mailing list submissions to
> devel(a)acpica.org
> =

> To subscribe or unsubscribe via the World Wide Web, visit
> https://lists.acpica.org/mailman/listinfo/devel
> or, via email, send a message with subject or body 'help' to devel-
> request(a)acpica.org
> =

> You can reach the person managing the list at devel-owner(a)acpica.org
> =

> When replying, please edit your Subject line so it is more specific than
> "Re: Contents of Devel digest..."
> =

> =

> Today's Topics:
> =

>    1. Re: [PATCH] ACPI: allow compilation with bare metal compilers
>       (Al Stone)
>    2. patch request for tbxfload.c (scole_mail)
>    3. ACPICA version 20161117 released (Moore, Robert)
>    4. Re: Question about the code in
>       source/components/hardware/hwxfsleep.c (Al Stone)
>    5. [PATCH] Linux-specific header: Add support for s390x
>       compilation (Colin King)
>    6. [PATCH] Linux-specific header: Add support for s390x
>       compilation. (Colin King)
>    7. Re: [PATCH] acpi: Fix format string type mistakes (Zheng, Lv)
> =

> =

> ----------------------------------------------------------------------
> =

> Message: 1
> Date: Tue, 15 Nov 2016 09:36:05 -0700
> From: Al Stone <ahs3(a)redhat.com>
> To: "Moore, Robert" <robert.moore(a)intel.com>, "linux-
> acpi(a)vger.kernel.org" <linux-acpi(a)vger.kernel.org>, "devel(a)acpica.o=
rg"
> <devel(a)acpica.org>, "linux-kernel(a)vger.kernel.org"
> <linux-kernel(a)vger.kernel.org>
> Cc: "Rafael J . Wysocki" <rjw(a)rjwysocki.net>, Len Brown
> <lenb(a)kernel.org>, "Zheng, Lv" <lv.zheng(a)intel.com>
> Subject: Re: [Devel] [PATCH] ACPI: allow compilation with bare metal
> compilers
> Message-ID: <ac74e311-8482-9336-83c7-0eb5e84d81a5(a)redhat.com>
> Content-Type: text/plain; charset=3Dwindows-1252
> =

> On 11/15/2016 08:43 AM, Moore, Robert wrote:
> > The design for all of this is as follows:
> >
> > 1) OS-dependent includes
> > 2) Compiler-specific includes
> > 3) acenv.h is the master file that pulls in the correct headers (one
> > compiler, and one OS)
> =

> Sure, that's understood from the current structure.  The issue is #3 --
> there is no OS, in the sense of a run-time environment, so that
> assumption is incorrect in this case.  All we know is that we're
> compiling the kernel and it needs to be able to run in complete
> isolation.
> =

> > So, I think I see a couple of possible solutions for you:
> >
> > 1) If you are using GCC, the __GNUC__ symbol should already be
> defined.
> =

> Right, which is what this patch is relying on.
> =

> > 2) If "aclinux.h" works for you, we can either add a conditional case
> that would apply to your environment, or:
> =

> I'm confused; I thought that was what this patch was doing.  What is
> being suggested instead?
> =

> > 2a) You could define _LINUX in your gcc invocations.
> =

> This option might force changes in the kernel build which is otherwise
> not affected; this is only an issue with drivers/acpi/acpica/*.  It may
> also cause ACPICA to build incorrectly for other OSs, but I'll have to
> look at that.  Off hand, it seems like this would cause more problems
> with acenv.h.
> =

> >
> > Because ACPICA supports many different environments, we don't want to
> have a "default" case which in a sense would only be an attempt to guess
> what the user intended. We want to have a clear error that tells the
> user that something important needs to be done before the code can be
> compiled.
> =

> Understood, which is why I left the #error case; the intent is only to
> have a default when compiling Linux for bare-metal environments using
> GCC.  Perhaps this is just a Linux-only modification...
> =

> > Bob
> >
> >
> >> -----Original Message-----
> >> From: Al Stone [mailto:ahs3(a)redhat.com]
> >> Sent: Monday, November 14, 2016 3:09 PM
> >> To: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-
> >> kernel(a)vger.kernel.org
> >> Cc: Al Stone <ahs3(a)redhat.com>; Rafael J . Wysocki
> >> <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.org>; Moore, Robert
> >> <robert.moore(a)intel.com>; Zheng, Lv <lv.zheng(a)intel.com>
> >> Subject: [PATCH] ACPI: allow compilation with bare metal compilers
> >>
> >> The ACPICA subsystem of the ACPI driver sets up a compilation
> >> environment for itself, adding in multiple typedefs unique to ACPICA
> >> that depend on where ACPICA will be used.
> >>
> >> The vast majority of such environments (Linux, QNX, ...) have an
> >> environment defined by the acenv.h header file.  When using a Linaro
> >> compiler [1] specifically built to be used in an embedded environment
> >> with perhaps a kernel and an init process as the only things running,
> >> there is no environment defined for ACPICA so the typedefs it needs
> >> are not set up, causing compilation to fail badly unless ACPI is
> >> completely disabled.
> >> Since ACPI is enabled in the default config for the kernel, the
> >> compilation failure is fairly obvious.
> >>
> >> This may not be the optimal solution, but add in to the ACPI header
> >> file include/acpi/platform/acenv.h a default so that if GCC is being
> >> used, and all else fails, assume that we are going to be in a
> >> Linux-like environment and re-use the environment definition for
> >> Linux.  This allows us to build a kernel using this compiler [1] with
> >> or without ACPI.
> >>
> >> [1]
> >> https://releases.linaro.org/components/toolchain/binaries/latest/aarc
> >> h64 -elff/gcc-linaro-6.1.1-2016-08-x86_64_aarch64-elf.tar.xz
> >>
> >> Signed-off-by: Al Stone <ahs3(a)redhat.com>
> >> Cc: Rafael J. Wysocki <rjw(a)rjwysocki.net>
> >> Cc: Len Brown <lenb(a)kernel.org>
> >> Cc: Robert Moore <robert.moore(a)intel.com>
> >> Cc: Lv Zheng <lv.zheng(a)intel.com>
> >> ---
> >>  include/acpi/platform/acenv.h | 15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >>
> >> diff --git a/include/acpi/platform/acenv.h
> >> b/include/acpi/platform/acenv.h index 34cce72..cdd1cd6 100644
> >> --- a/include/acpi/platform/acenv.h
> >> +++ b/include/acpi/platform/acenv.h
> >> @@ -234,6 +234,21 @@
> >>  #elif defined(_AED_EFI) || defined(_GNU_EFI) || defined(_EDK2_EFI)
> >> #include "acefi.h"
> >>
> >> +/*
> >> + * Up to this point, we've been looking for specific environments.
> >> +In
> >> + * some cases, there is no environment, and we're just working on
> >> +bare
> >> + * metal.  However, since we're compiling the Linux kernel, let's
> >> +just
> >> + * pretend we're in a Linux environment.
> >> + */
> >> +#elif defined(__GNUC__) && !defined(__INTEL_COMPILER) #if
> >> +!defined(_LINUX) #define _LINUX #endif #if !defined(__linux__)
> >> +#define __linux__ #endif #include <acpi/platform/aclinux.h>
> >> +
> >>  #else
> >>
> >>  /* Unknown environment */
> >> --
> >> 2.10.2
> >
> =

> =

> --
> ciao,
> al
> -----------------------------------
> Al Stone
> Software Engineer
> Red Hat, Inc.
> ahs3(a)redhat.com
> -----------------------------------
> =

> =

> ------------------------------
> =

> Message: 2
> Date: Mon, 14 Nov 2016 08:58:57 -0800
> From: scole_mail <scole_mail(a)gmx.com>
> To: devel(a)acpica.org
> Subject: [Devel] patch request for tbxfload.c
> Message-ID: <87poly0zhq.fsf(a)gmx.com>
> Content-Type: text/plain
> =

> I was hoping this patch could be added.  I am trying to run
> netbsd/ia64 on a simulator (ski).  Without the patch, I get a segfault.
> With it, I get the same messages as previous acpica versions with no
> seg-faulting.
> =

> I'm not sure if it is a just a ia64/ski issue, but it seems like
> AcpiGbl_DsdtIndex is never getting set.  It looks like only
> AcpiTbInstallFixedTable() sets it, but I'm not seeing that called.
> AcpiTbInstallTableWithOverride() has a comment saying it sets it, but I
> don't see AcpiGbl_DsdtIndex passed to it either.
> =

> Output with the patch is below.
> =

> Thanks
> =

> *** ./acpica-unix-20160930/source/components/tables/tbxfload.c.origMon
> Nov 14 08:44:43 2016
> --- ./acpica-unix-20160930/source/components/tables/tbxfload.cMon Nov 14
> 08:47:04 2016
> ***************
> *** 236,241 ****
> --- 236,250 ----
>       (void) AcpiUtAcquireMutex (ACPI_MTX_TABLES);
> =

>       /*
> +      * If AcpiGbl_DsdtIndex uninitialized, give up.
> +      */
> +     if (AcpiGbl_DsdtIndex =3D=3D ACPI_INVALID_TABLE_INDEX)
> +     {
> +         Status =3D AE_NO_ACPI_TABLES;
> +         goto UnlockAndExit;
> +     }
> +
> +     /*
>        * Load the namespace. The DSDT is required, but any SSDT and
>        * PSDT tables are optional. Verify the DSDT.
>        */
> =

> ACPI: RSDP 0x0000000000120420 00002C (v02 FBSD  )
> ACPI: XSDT 0x0000000000120444 00002C (v00 FBSD   SKI      00000000 FBSD
> 00000000)
> ACPI BIOS Warning (bug): Incorrect checksum in table [APIC] - 0x00,
> should be 0x0C (20160930/tbprint-233)
> ACPI: APIC 0x0000000000120470 000080 (v00 FBSD   SKI      00000000 FBSD
> 00000000)
> ACPI Exception: AE_NO_ACPI_TABLES, While loading namespace from ACPI
> tables (20160930/tbxfload-111) ACPI Warning: AcpiEnable failed
> (20160930/utxfinit-184)
> acpi_probe: failed to enable subsystem
> ACPI Error: Could not remove SCI handler (20160930/evmisc-312)
> acpi0 at mainbus0: Intel ACPICA 20160930
> acpi0: X/RSDT: OemId <  FBSD,     SKI,00000000>, AslId <FBSD,00000000>
> ACPI Warning: AcpiEnable failed (20160930/utxfinit-184)
> acpi_attach: failed to initialize ACPI: AE_NO_ACPI_TABLES
> =

> =

> ------------------------------
> =

> Message: 3
> Date: Thu, 17 Nov 2016 17:42:39 +0000
> From: "Moore, Robert" <robert.moore(a)intel.com>
> To: acpica.org list <devel(a)acpica.org>
> Subject: [Devel] ACPICA version 20161117 released
> Message-ID:
> <94F2FBAB4432B54E8AACC7DFDE6C92E37E52E0B6(a)ORSMSX110.amr.corp.intel.com>
> =

> Content-Type: text/plain; charset=3D"us-ascii"
> =

> 17 November 2016. Summary of changes for version 20161117:
> =

> This release is available at https://acpica.org/downloads
> =

> =

> 1) ACPICA kernel-resident subsystem:
> =

> Table Manager: Fixed a regression introduced in 20160729, "FADT support
> cleanup". This was an attempt to remove all references in the source to
> the FADT version 2, which never was a legal version number. It was
> skipped because it was an early version of 64-bit support that was
> eventually abandoned for the current 64-bit support.
> =

> Interpreter: Fixed a problem where runtime implicit conversion was
> incorrectly disabled for the ASL operators below. This brings the
> behavior into compliance with the ACPI specification:
>     FromBCD
>     ToBCD
>     ToDecimalString
>     ToHexString
>     ToInteger
>     ToBuffer
> =

> Table Manager: Added a new public interface, AcpiPutTable, used to
> release and free an ACPI table returned by AcpiGetTable and related
> interfaces. Lv Zheng.
> =

> Example Code and Data Size: These are the sizes for the OS-independent
> acpica.lib produced by the Microsoft Visual C++ 9.0 32-bit compiler. The
> debug version of the code includes the debug output trace mechanism and
> has a much larger code and data size.
> =

>   Current Release:
>     Non-Debug Version: 140.5K Code, 58.5K Data, 198.9K Total
>     Debug Version:     201.3K Code, 82.7K Data, 284.0K Total
>   Previous Release:
>     Non-Debug Version: 140.4K Code, 58.1K Data, 198.5K Total
>     Debug Version:     200.7K Code, 82.1K Data, 282.8K Total
> =

> =

> 2) iASL Compiler/Disassembler and Tools:
> =

> Disassembler: Fixed a regression for disassembly of Resource Template.
> Detection of templates in the AML stream missed some types of templates.
> =

> iASL: Fixed a problem where an Access Size error was returned for the
> PCC address space when the AccessSize of the GAS register is greater
> than a DWORD. Hoan Tran.
> =

> iASL: Implemented several grammar changes for the operators below. These
> changes are slated for the next version of the ACPI specification:
>     RefOf        - Disallow method invocation as an operand
>     CondRefOf    - Disallow method invocation as an operand
>     DerefOf      - Disallow operands that use the result from operators
> that
>                    do not return a reference (Changed TermArg to
> SuperName).
> =

> iASL: Control method invocations are now allowed for Target operands, as
> per the ACPI specification. Removed error for using a control method
> invocation as a Target operand.
> =

> Disassembler: Improved detection of Resource Templates, Unicode, and
> Strings within Buffer objects. These subtypes do not contain a specific
> opcode to indicate the originating ASL code, and they must be detected
> by other means within the disassembler.
> =

> iASL: Implemented an optimization improvement for 32-bit ACPI tables
> (DSDT/SSDT). For the 32-bit case only, compute the optimum integer
> opcode only after 64-bit to 32-bit truncation. A truncation warning
> message is still emitted, however.
> =

> AcpiXtract: Implemented handling for both types of line terminators (LF
> or CR/LF) so that it can accept AcpiDump output files from any system.
> Peter Wu.
> =

> AcpiBin: Added two new options for comparing AML files:
>     -a: compare and display ALL mismatches
>     -o: start compare at this offset into the second file
> =

> =

> =

> ------------------------------
> =

> Message: 4
> Date: Mon, 21 Nov 2016 12:46:52 -0700
> From: Al Stone <ahs3(a)redhat.com>
> To: Kein Yuan <kein.yuan(a)yahoo.com>, "devel(a)acpica.org"
> <devel(a)acpica.org>
> Subject: Re: [Devel] Question about the code in
> source/components/hardware/hwxfsleep.c
> Message-ID: <08d8e4d2-bc84-52bf-f8af-c7fbd469754f(a)redhat.com>
> Content-Type: text/plain; charset=3Dwindows-1252
> =

> On 11/11/2016 04:53 PM, Kein Yuan wrote:
> > Hi ACPICA experts,
> >    A quick question,
> >
> > File: source/components/hardware/hwxfsleep.c
> > Function: AcpiHwSetFirmwareWakingVector
> >
> > static ACPI_STATUS
> > AcpiHwSetFirmwareWakingVector (
> >     ACPI_TABLE_FACS         *Facs,
> >     ACPI_PHYSICAL_ADDRESS   PhysicalAddress,
> >     ACPI_PHYSICAL_ADDRESS   PhysicalAddress64)
> > {
> >     ACPI_FUNCTION_TRACE (AcpiHwSetFirmwareWakingVector);
> >
> >
> >     /*
> >      * According to the ACPI specification 2.0c and later, the 64-bit
> >      * waking vector should be cleared and the 32-bit waking vector
> should
> >      * be used, unless we want the wake-up code to be called by the
> BIOS in
> >      * Protected Mode. Some systems (for example HP dv5-1004nr) are
> known
> >      * to fail to resume if the 64-bit vector is used.
> >      */
> >
> >     /* Set the 32-bit vector */
> >
> >     Facs->FirmwareWakingVector =3D (UINT32) PhysicalAddress;
> >
> >     if (Facs->Length > 32)   // ---------------------> Question for
> this compare
> >     {
> >         if (Facs->Version >=3D 1)
> >         {
> >             /* Set the 64-bit vector */
> >
> >             Facs->XFirmwareWakingVector =3D PhysicalAddress64;
> >         }
> >         else
> >         {
> >             /* Clear the 64-bit vector if it exists */
> >
> >             Facs->XFirmwareWakingVector =3D 0;
> >         }
> >     }
> >
> >     return_ACPI_STATUS (AE_OK);
> > }
> >
> > Since the FACS structure defined as:
> > typedef struct acpi_table_facs
> > {
> >     char                    Signature[4];           /* ASCII table
> signature */
> >     UINT32                  Length;                 /* Length of
> structure, in
> > bytes */
> >     UINT32                  HardwareSignature;      /* Hardware
> configuration
> > signature */
> >     UINT32                  FirmwareWakingVector;   /* 32-bit physical
> address
> > of the Firmware Waking Vector */
> >     UINT32                  GlobalLock;             /* Global Lock for
> shared
> > hardware resources */
> >     UINT32                  Flags;
> >     UINT64                  XFirmwareWakingVector;  /* 64-bit version
> of the
> > Firmware Waking Vector (ACPI 2.0+) */
> >     UINT8                   Version;                /* Version of this
> table
> > (ACPI 2.0+) */
> >     UINT8                   Reserved[3];            /* Reserved, must
> be zero */
> >     UINT32                  OspmFlags;              /* Flags to be set
> by OSPM
> > (ACPI 4.0) */
> >     UINT8                   Reserved1[24];          /* Reserved, must
> be zero */
> >
> > } ACPI_TABLE_FACS;
> >
> >
> > May I know in what case Facs->Length < 32?
> >
> > If looks to me that Facs->XFirmwareWakingVector =3D PhysicalAddress64;
> > will always be executed?
> >
> > Thanks,
> > Kein
> =

> IIRC, very old versions of the FACS were < 32 bytes long; those old
> versions did not have a XFirmwareWakingVector field, or a proper Version
> field.  For that case, the function just returns after doing nothing.
> If the FACS is larger than 32 bytes, it should have a Version field, but
> it looks like version
> 1 does not have a usable XFirmwareWakingVector field -- i.e., it is
> defined in the struct, but is not valid until a later version of the
> ACPI specification where Facs->Version >=3D 2.  So, for Version =3D=3D 1,
> ignore the field, but for versions > 1, set the field.
> =

> Does that help?
> =

> --
> ciao,
> al
> -----------------------------------
> Al Stone
> Software Engineer
> Red Hat, Inc.
> ahs3(a)redhat.com
> -----------------------------------
> =

> =

> ------------------------------
> =

> Message: 5
> Date: Wed, 30 Nov 2016 13:16:26 +0000
> From: Colin King <colin.king(a)canonical.com>
> To: devel(a)acpica.org
> Subject: [Devel] [PATCH] Linux-specific header: Add support for s390x
> compilation
> Message-ID: <20161130131627.25030-1-colin.king(a)canonical.com>
> Content-Type: text/plain; charset=3D"utf-8"
> =

> From: Colin Ian King <colin.king(a)canonical.com>
> =

> While porting ACPCIA integrated into fwts I discovered that I get build
> issues on s390x because ACPCIA does not know it is a 64 bit
> architecture.
> Update aclinux.h to support this architecture.
> =

> Colin Ian King (1):
>   Linux-specific header: Add support for s390x compilation.
> =

>  source/include/platform/aclinux.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> =

> --
> 2.10.2
> =

> =

> =

> ------------------------------
> =

> Message: 6
> Date: Wed, 30 Nov 2016 13:16:27 +0000
> From: Colin King <colin.king(a)canonical.com>
> To: devel(a)acpica.org
> Subject: [Devel] [PATCH] Linux-specific header: Add support for s390x
> compilation.
> Message-ID: <20161130131627.25030-2-colin.king(a)canonical.com>
> Content-Type: text/plain; charset=3D"utf-8"
> =

> From: Colin Ian King <colin.king(a)canonical.com>
> =

> Adds s390x as a 64-bit architecture.
> =

> Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
> ---
>  source/include/platform/aclinux.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> =

> diff --git a/source/include/platform/aclinux.h
> b/source/include/platform/aclinux.h
> index 6f7c577..9d0927b 100644
> --- a/source/include/platform/aclinux.h
> +++ b/source/include/platform/aclinux.h
> @@ -265,7 +265,8 @@
>  #define ACPI_CAST_PTHREAD_T(Pthread) ((ACPI_THREAD_ID) (Pthread))
> =

>  #if defined(__ia64__)    || defined(__x86_64__) ||\
> -    defined(__aarch64__) || defined(__PPC64__)
> +    defined(__aarch64__) || defined(__PPC64__) ||\
> +    defined(__s390x__)
>  #define ACPI_MACHINE_WIDTH          64
>  #define COMPILER_DEPENDENT_INT64    long
>  #define COMPILER_DEPENDENT_UINT64   unsigned long
> --
> 2.10.2
> =

> =

> =

> ------------------------------
> =

> Message: 7
> Date: Mon, 19 Dec 2016 06:05:09 +0000
> From: "Zheng, Lv" <lv.zheng(a)intel.com>
> To: Kees Cook <keescook(a)chromium.org>, "Moore, Robert"
> <robert.moore(a)intel.com>
> Cc: "linux-kernel(a)vger.kernel.org" <linux-kernel(a)vger.kernel.org>,
> "Wysocki, Rafael J" <rafael.j.wysocki(a)intel.com>, Len Brown
> <lenb(a)kernel.org>, "linux-acpi(a)vger.kernel.org"
> <linux-acpi(a)vger.kernel.org>, Emese Revfy <re.emese(a)gmail.com>,
> "devel(a)acpica.org" <devel(a)acpica.org>
> Subject: Re: [Devel] [PATCH] acpi: Fix format string type mistakes
> Message-ID:
> <1AE640813FDE7649BE1B193DEA596E886CDFF331(a)SHSMSX101.ccr.corp.intel.com>
> =

> Content-Type: text/plain; charset=3D"us-ascii"
> =

> Hi,
> =

> > From: Kees Cook [mailto:keescook(a)chromium.org]
> > Subject: [PATCH] acpi: Fix format string type mistakes
> >
> > From: Emese Revfy <re.emese(a)gmail.com>
> >
> > This adds the missing __printf attribute which allows compile time
> > format string checking (and will be used by the coming initify gcc
> > plugin). Additionally, this fixes the warnings exposed by the
> attribute.
> >
> > Signed-off-by: Emese Revfy <re.emese(a)gmail.com>
> > [kees: split scsi/acpi, merged attr and fix, new commit messages]
> > Signed-off-by: Kees Cook <keescook(a)chromium.org>
> > ---
> >  drivers/acpi/acpica/dbhistry.c |  2 +-  drivers/acpi/acpica/dbinput.c
> > | 10 ++---  drivers/acpi/acpica/dbstats.c  | 88
> > +++++++++++++++++++++---------------------
> >  drivers/acpi/acpica/utdebug.c  |  2 +-
> >  include/acpi/acpiosxf.h        |  3 +-
> >  5 files changed, 53 insertions(+), 52 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/dbhistry.c
> > b/drivers/acpi/acpica/dbhistry.c index 46bd65d38df9..ec9da4830f6a
> > 100644
> > --- a/drivers/acpi/acpica/dbhistry.c
> > +++ b/drivers/acpi/acpica/dbhistry.c
> > @@ -155,7 +155,7 @@ void acpi_db_display_history(void)
> >
> >  for (i =3D 0; i < acpi_gbl_num_history; i++) {  if
> > (acpi_gbl_history_buffer[history_index].command) {
> > -acpi_os_printf("%3ld %s\n",
> > +acpi_os_printf("%3u %s\n",
> >         acpi_gbl_history_buffer[history_index].
> >         cmd_num,
> >         acpi_gbl_history_buffer[history_index].
> > diff --git a/drivers/acpi/acpica/dbinput.c
> > b/drivers/acpi/acpica/dbinput.c index 068214f9cc9d..43be06bdb790
> > 100644
> > --- a/drivers/acpi/acpica/dbinput.c
> > +++ b/drivers/acpi/acpica/dbinput.c
> > @@ -608,7 +608,7 @@ static u32 acpi_db_get_line(char *input_buffer)
> >      (acpi_gbl_db_parsed_buf, sizeof(acpi_gbl_db_parsed_buf),
> >       input_buffer)) {
> >  acpi_os_printf
> > -    ("Buffer overflow while parsing input line (max %u
> characters)\n",
> > +    ("Buffer overflow while parsing input line (max %lu
> > + characters)\n",
> >       sizeof(acpi_gbl_db_parsed_buf));  return (0);  } @@ -864,24
> > +864,24 @@ acpi_db_command_dispatch(char *input_buffer,
> >
> >  if (param_count =3D=3D 0) {
> >  acpi_os_printf
> > -    ("Current debug level for file output is:    %8.8lX\n",
> > +    ("Current debug level for file output is:    %8.8X\n",
> >       acpi_gbl_db_debug_level);
> >  acpi_os_printf
> > -    ("Current debug level for console output is: %8.8lX\n",
> > +    ("Current debug level for console output is: %8.8X\n",
> >       acpi_gbl_db_console_debug_level);  } else if (param_count =3D=3D =
2)
> > {  temp =3D acpi_gbl_db_console_debug_level;
> > acpi_gbl_db_console_debug_level =3D
> >      strtoul(acpi_gbl_db_args[1], NULL, 16);  acpi_os_printf
> > -    ("Debug Level for console output was %8.8lX, now %8.8lX\n",
> > +    ("Debug Level for console output was %8.8X, now %8.8X\n",
> >       temp, acpi_gbl_db_console_debug_level);  } else {  temp =3D
> > acpi_gbl_db_debug_level;  acpi_gbl_db_debug_level =3D
> >      strtoul(acpi_gbl_db_args[1], NULL, 16);  acpi_os_printf
> > -    ("Debug Level for file output was %8.8lX, now %8.8lX\n",
> > +    ("Debug Level for file output was %8.8X, now %8.8X\n",
> >       temp, acpi_gbl_db_debug_level);
> >  }
> >  break;
> > diff --git a/drivers/acpi/acpica/dbstats.c
> > b/drivers/acpi/acpica/dbstats.c index a414e1fa6f9d..de7023024b12
> > 100644
> > --- a/drivers/acpi/acpica/dbstats.c
> > +++ b/drivers/acpi/acpica/dbstats.c
> > @@ -377,17 +377,17 @@ acpi_status acpi_db_display_statistics(char
> *type_arg)
> >         "ACPI_TYPE", "NODES", "OBJECTS");
> >
> >  for (i =3D 0; i < ACPI_TYPE_NS_NODE_MAX; i++) {
> > -acpi_os_printf("%16.16s % 10ld% 10ld\n",
> > +acpi_os_printf("%16.16s % 10d% 10d\n",
> >         acpi_ut_get_type_name(i),
> >         acpi_gbl_node_type_count[i],
> >         acpi_gbl_obj_type_count[i]);
> >  }
> >
> > -acpi_os_printf("%16.16s % 10ld% 10ld\n", "Misc/Unknown",
> > +acpi_os_printf("%16.16s % 10d% 10d\n", "Misc/Unknown",
> >         acpi_gbl_node_type_count_misc,
> >         acpi_gbl_obj_type_count_misc);
> >
> > -acpi_os_printf("%16.16s % 10ld% 10ld\n", "TOTALS:",
> > +acpi_os_printf("%16.16s % 10d% 10d\n", "TOTALS:",
> >         acpi_gbl_num_nodes, acpi_gbl_num_objects);  break;
> >
> > @@ -415,16 +415,16 @@ acpi_status acpi_db_display_statistics(char
> > *type_arg)  case CMD_STAT_MISC:
> >
> >  acpi_os_printf("\nMiscellaneous Statistics:\n\n");
> > -acpi_os_printf("Calls to AcpiPsFind:.. ........% 7ld\n",
> > +acpi_os_printf("Calls to AcpiPsFind:.. ........% 7u\n",
> >         acpi_gbl_ps_find_count);
> > -acpi_os_printf("Calls to AcpiNsLookup:..........% 7ld\n",
> > +acpi_os_printf("Calls to AcpiNsLookup:..........% 7u\n",
> >         acpi_gbl_ns_lookup_count);
> >
> >  acpi_os_printf("\n");
> >
> >  acpi_os_printf("Mutex usage:\n\n");
> >  for (i =3D 0; i < ACPI_NUM_MUTEX; i++) {
> > -acpi_os_printf("%-28s:     % 7ld\n",
> > +acpi_os_printf("%-28s:     % 7u\n",
> >         acpi_ut_get_mutex_name(i),
> >         acpi_gbl_mutex_info[i].use_count);
> >  }
> > @@ -434,87 +434,87 @@ acpi_status acpi_db_display_statistics(char
> > *type_arg)
> >
> >  acpi_os_printf("\nInternal object sizes:\n\n");
> >
> > -acpi_os_printf("Common         %3d\n",
> > +acpi_os_printf("Common         %3lu\n",
> >         sizeof(struct acpi_object_common));
> > -acpi_os_printf("Number         %3d\n",
> > +acpi_os_printf("Number         %3lu\n",
> >         sizeof(struct acpi_object_integer));
> > -acpi_os_printf("String         %3d\n",
> > +acpi_os_printf("String         %3lu\n",
> >         sizeof(struct acpi_object_string));
> > -acpi_os_printf("Buffer         %3d\n",
> > +acpi_os_printf("Buffer         %3lu\n",
> >         sizeof(struct acpi_object_buffer));
> > -acpi_os_printf("Package        %3d\n",
> > +acpi_os_printf("Package        %3lu\n",
> >         sizeof(struct acpi_object_package));
> > -acpi_os_printf("BufferField    %3d\n",
> > +acpi_os_printf("BufferField    %3lu\n",
> >         sizeof(struct acpi_object_buffer_field));
> > -acpi_os_printf("Device         %3d\n",
> > +acpi_os_printf("Device         %3lu\n",
> >         sizeof(struct acpi_object_device));
> > -acpi_os_printf("Event          %3d\n",
> > +acpi_os_printf("Event          %3lu\n",
> >         sizeof(struct acpi_object_event));
> > -acpi_os_printf("Method         %3d\n",
> > +acpi_os_printf("Method         %3lu\n",
> >         sizeof(struct acpi_object_method));
> > -acpi_os_printf("Mutex          %3d\n",
> > +acpi_os_printf("Mutex          %3lu\n",
> >         sizeof(struct acpi_object_mutex));
> > -acpi_os_printf("Region         %3d\n",
> > +acpi_os_printf("Region         %3lu\n",
> >         sizeof(struct acpi_object_region));
> > -acpi_os_printf("PowerResource  %3d\n",
> > +acpi_os_printf("PowerResource  %3lu\n",
> >         sizeof(struct acpi_object_power_resource));
> > -acpi_os_printf("Processor      %3d\n",
> > +acpi_os_printf("Processor      %3lu\n",
> >         sizeof(struct acpi_object_processor));
> > -acpi_os_printf("ThermalZone    %3d\n",
> > +acpi_os_printf("ThermalZone    %3lu\n",
> >         sizeof(struct acpi_object_thermal_zone));
> > -acpi_os_printf("RegionField    %3d\n",
> > +acpi_os_printf("RegionField    %3lu\n",
> >         sizeof(struct acpi_object_region_field));
> > -acpi_os_printf("BankField      %3d\n",
> > +acpi_os_printf("BankField      %3lu\n",
> >         sizeof(struct acpi_object_bank_field));
> > -acpi_os_printf("IndexField     %3d\n",
> > +acpi_os_printf("IndexField     %3lu\n",
> >         sizeof(struct acpi_object_index_field));
> > -acpi_os_printf("Reference      %3d\n",
> > +acpi_os_printf("Reference      %3lu\n",
> >         sizeof(struct acpi_object_reference));
> > -acpi_os_printf("Notify         %3d\n",
> > +acpi_os_printf("Notify         %3lu\n",
> >         sizeof(struct acpi_object_notify_handler));
> > -acpi_os_printf("AddressSpace   %3d\n",
> > +acpi_os_printf("AddressSpace   %3lu\n",
> >         sizeof(struct acpi_object_addr_handler));
> > -acpi_os_printf("Extra          %3d\n",
> > +acpi_os_printf("Extra          %3lu\n",
> >         sizeof(struct acpi_object_extra));
> > -acpi_os_printf("Data           %3d\n",
> > +acpi_os_printf("Data           %3lu\n",
> >         sizeof(struct acpi_object_data));
> >
> >  acpi_os_printf("\n");
> >
> > -acpi_os_printf("ParseObject    %3d\n",
> > +acpi_os_printf("ParseObject    %3lu\n",
> >         sizeof(struct acpi_parse_obj_common));
> > -acpi_os_printf("ParseObjectNamed %3d\n",
> > +acpi_os_printf("ParseObjectNamed %3lu\n",
> >         sizeof(struct acpi_parse_obj_named));
> > -acpi_os_printf("ParseObjectAsl %3d\n",
> > +acpi_os_printf("ParseObjectAsl %3lu\n",
> >         sizeof(struct acpi_parse_obj_asl));
> > -acpi_os_printf("OperandObject  %3d\n",
> > +acpi_os_printf("OperandObject  %3lu\n",
> >         sizeof(union acpi_operand_object));
> > -acpi_os_printf("NamespaceNode  %3d\n",
> > +acpi_os_printf("NamespaceNode  %3lu\n",
> >         sizeof(struct acpi_namespace_node));
> > -acpi_os_printf("AcpiObject     %3d\n",
> > +acpi_os_printf("AcpiObject     %3lu\n",
> >         sizeof(union acpi_object));
> >
> >  acpi_os_printf("\n");
> >
> > -acpi_os_printf("Generic State  %3d\n",
> > +acpi_os_printf("Generic State  %3lu\n",
> >         sizeof(union acpi_generic_state));
> > -acpi_os_printf("Common State   %3d\n",
> > +acpi_os_printf("Common State   %3lu\n",
> >         sizeof(struct acpi_common_state)); -acpi_os_printf("Control
> > State  %3d\n",
> > +acpi_os_printf("Control State  %3lu\n",
> >         sizeof(struct acpi_control_state));
> > -acpi_os_printf("Update State   %3d\n",
> > +acpi_os_printf("Update State   %3lu\n",
> >         sizeof(struct acpi_update_state));
> > -acpi_os_printf("Scope State    %3d\n",
> > +acpi_os_printf("Scope State    %3lu\n",
> >         sizeof(struct acpi_scope_state));
> > -acpi_os_printf("Parse Scope    %3d\n",
> > +acpi_os_printf("Parse Scope    %3lu\n",
> >         sizeof(struct acpi_pscope_state)); -acpi_os_printf("Package
> > State  %3d\n",
> > +acpi_os_printf("Package State  %3lu\n",
> >         sizeof(struct acpi_pkg_state));
> > -acpi_os_printf("Thread State   %3d\n",
> > +acpi_os_printf("Thread State   %3lu\n",
> >         sizeof(struct acpi_thread_state)); -acpi_os_printf("Result
> > Values  %3d\n",
> > +acpi_os_printf("Result Values  %3lu\n",
> >         sizeof(struct acpi_result_values));
> > -acpi_os_printf("Notify Info    %3d\n",
> > +acpi_os_printf("Notify Info    %3lu\n",
> >         sizeof(struct acpi_notify_info));  break;
> >
> > diff --git a/drivers/acpi/acpica/utdebug.c
> > b/drivers/acpi/acpica/utdebug.c index 044df9b0356e..b4cdb9c14a87
> > 100644
> > --- a/drivers/acpi/acpica/utdebug.c
> > +++ b/drivers/acpi/acpica/utdebug.c
> > @@ -189,7 +189,7 @@ acpi_debug_print(u32 requested_debug_level,
> >   * Display the module name, current line number, thread ID (if
> requested),
> >   * current procedure nesting level, and the current procedure name
> >   */
> > -acpi_os_printf("%9s-%04ld ", module_name, line_number);
> > +acpi_os_printf("%9s-%04u ", module_name, line_number);
> >
> >  #ifdef ACPI_APPLICATION
> >  /*
> =

> Please split above changes into a separate patch.
> I'm not sure if the changes can break other compilers.
> Please clone https://github.com/acpica/acpica, and submit a pull request
> there to have more ACPICA reviewers.
> =

> > diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h index
> > f3414c83abb1..48b21490bbeb 100644
> > --- a/include/acpi/acpiosxf.h
> > +++ b/include/acpi/acpiosxf.h
> > @@ -337,11 +337,12 @@ acpi_status acpi_os_signal(u32 function, void
> *info);
> >   * Debug print routines
> >   */
> >  #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_printf
> > +__printf(1, 2)
> >  void ACPI_INTERNAL_VAR_XFACE acpi_os_printf(const char *format, ...);
> > #endif
> >
> >  #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_vprintf
> > -void acpi_os_vprintf(const char *format, va_list args);
> > +__printf(1, 0) void acpi_os_vprintf(const char *format, va_list
> > +args);
> >  #endif
> >
> >  #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_redirect_output
> =

> You can use ACPI_PRINTF_LIKE macro instead.
> This can directly go into Linux upstream.
> You can prepare a different pull request for ACPICA upstream or I can
> help to back port the change.
> =

> Thanks
> Lv
> =

> > --
> > 2.7.4
> >
> >
> > --
> > Kees Cook
> > Nexus Security
> =

> =

> ------------------------------
> =

> Subject: Digest Footer
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel
> =

> ------------------------------
> =

> End of Devel Digest, Vol 72, Issue 1
> ************************************
> IMPORTANT NOTICE: The contents of this email and any attachments are
> confidential and may also be privileged. If you are not the intended
> recipient, please notify the sender immediately and do not disclose the
> contents to any other person, use it for any purpose, or store or copy
> the information in any medium. Thank you.
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============8362105171193557795==--

