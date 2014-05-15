Content-Type: multipart/mixed; boundary="===============1532315178004961231=="
MIME-Version: 1.0
From: David E. Box <david.e.box at linux.intel.com>
Subject: Re: [Devel] Clarification request about AcpiDbgLevel and
 AcpiGbl_EnableAmlDebugObject
Date: Wed, 14 May 2014 18:08:18 -0700
Message-ID: <20140515010818.GA30239@linux.intel.com>
In-Reply-To: CABC13nEwZqrCUwfKCH_X08R34OhMA-H+dLMehPfYvFp5syTs8A@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1532315178004961231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2014 at 10:53:30PM +0200, Sascha Wildner wrote:
> Hello,
> =

> here is an issue I don't understand.
> =

> * In acpixf.h, if ACPI_DEBUG_OUTPUT is not set, AcpiDbgLevel is defined to
> ACPI_NORMAL_DEFAULT, and ACPI_LV_DEBUG_OBJECT is part of that.
> =

> * In exdebug.c, function AcpiExDoDebugObject(), it returns early without
> printing when neither AcpiGbl_EnableAmlDebugObject is set nor
> ACPI_LV_DEBUG_OBJECT is in AcpiDbgLevel, else it proceeds with printing.
> But by default, ACPI_LV_DEBUG_OBJECT is in AcpiDbgLevel (see above).
> AcpiExDoDebugObject() is the only place where AcpiGbl_EnableAmlDebugObject
> is referenced.
> =

> The reference manual says (at least that's how I read it) that when
> AcpiGbl_EnableAmlDebugObject is FALSE, output from the AML "Debug Object"
> is disabled, but given the definition of ACPI_NORMAL_DEFAULT together with
> the check in AcpiExDoDebugObject(), that doesn't seem to be the case.
>

I agree the spec isn't clear here. The comment description in the code for
AcpiExDoDebugObject() is correct however. Debug Object output can be enable=
d by
_either_ having the global switch set, AcpiGbl_EnableAmlDebugObject, or by
setting the bit for ACPI_DEBUG_OUTPUT in AcpiDbgLevel. By default we turn o=
f the
global switch, but Debug Object gets enabled anyway by bit field selection
through ACPI_NORMAL_DEFAULT as you mentioned.

We'll see about making this clearer in the spec.

> So my question is: How should the host OS properly handle this? I saw that
> FreeBSD for example initializes AcpiDbgLevel to 0 (when their ACPI_DEBUG
> switch isn't set) but the reference manual doesn't mention that anything
> other than AcpiGbl_EnableAmlDebugObject being FALSE is necessary.

How should the host OS handle what exactly? I think you misunderstand what =
Debug
Object is. In ASL you can use the Store operator to print debug messages li=
ke
this:

	// The contents of name will be output using AcpiOsPrintf
	Store(NAME, Debug) =


It's like printk's for BIOS developers. It's a simply way of printing custom
"debug" messages directly from the ASL code and has no effect on whether
messages will be printed for warnings, errors, etc. Each of these are contr=
olled
by a single bit in the 32 bit AcpiDbgLevel bit field. You can see these in
acoutput.h

Setting AcpiDbgLevel to 0 is the way to turn of all debug output. However y=
ou
can still use the the global switch, AcpiGbl_EnableAmlDebugObject, to see j=
ust
the Debug Object (the BIOS developers printk's) that may exist in the AML.

-- Dave Box

--===============1532315178004961231==--

