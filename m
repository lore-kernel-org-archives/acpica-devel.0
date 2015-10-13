Content-Type: multipart/mixed; boundary="===============5659036749617451340=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find
 \_Sx should not result in a loud warning [v2]
Date: Tue, 13 Oct 2015 20:59:53 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D98000D@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E883BAC6C12@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5659036749617451340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm a bit confused. What does the execution of the _Sx methods have to do w=
ith module-level code? Obviously, many times the _Sx objects are implemente=
d as simply named objects, but the table load doesn't care what is and what=
 isn't present.


> -----Original Message-----
> From: Zheng, Lv
> Sent: Friday, October 09, 2015 6:38 PM
> To: Prarit Bhargava; Moore, Robert; devel(a)acpica.org
> Cc: linux-acpi(a)vger.kernel.org; Wysocki, Rafael J
> Subject: RE: [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find \_Sx
> should not result in a loud warning [v2]
> =

> Hi,
> =

> > From: Prarit Bhargava [mailto:prarit(a)redhat.com]
> > Sent: Friday, October 09, 2015 7:30 PM
> >
> > On 10/09/2015 01:26 AM, Zheng, Lv wrote:
> > > Please ignore this.
> > > The fix is against the caller.
> > >
> > > Thanks and best regards
> > > -Lv
> > >
> > >> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Zheng,
> > >> Lv
> > >> Sent: Friday, October 09, 2015 10:02 AM
> > >>
> > >> Why don't you fix this in the invoker side?
> > >> For example:
> > >> If (acpi_get_handle())
> > >> 	acpi_evaluate_object()
> >
> > That seems like a sloppy workaround an actual bug in ACPICA.
> =

> So let me ignore this which is a reply for a useless question.
> =

> >
> > >> So that the AE_NOT_FOUND warning can still be kept for the real
> troubles?
> >
> > The code is warning 100% of the time on something that is optional.
> =

> Let me ignore this which is a reply for a useless question.
> =

> >
> > >> There are really scenarios that such warning is useful for catching
> bugs.
> > >>
> >
> > What scenario is possible where this causes a problem?  Issuing an
> > error on something that is optional is not a good idea.
> =

> There are several scenarios, let me say some known stuffs about the module
> level code support.
> In AML grammar, module level code (non-object-definition AML opcodes
> outside of a control method) is legal.
> While it is supported in ACPICA in a split way:
> 1. In the early stage, table loading code only executes those object
> definition opcodes and links all "if/else/while" AML fragments together.
> 2. In the late stage, object initialization code will execute such AML
> fragments before invoking all _INI methods.
> =

> 1. Since code is not executed in the Windows compliant order during the
> early table loading stage, some objects are not defined while they should.
> 2. Even worse, during the early stage, ACPICA may fail the whole table
> loading process due to AE_NOT_FOUND, leaving us partial initialized
> objects (the ACPICA AML interpreter implements 2 phases to parse a table
> to complete the table loading).
> Such issue is worked around by deleting the namespace objects created
> during the early stage if an exception (AE_NOT_FOUND) is encountered.
> =

> So you can see, such kind of error is sometime useful for catching AML
> interpreter issues or BIOS bugs.
> =

> Thanks and best regards
> -Lv

--===============5659036749617451340==--

