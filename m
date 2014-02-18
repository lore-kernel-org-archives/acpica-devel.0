Content-Type: multipart/mixed; boundary="===============5862076244895443861=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] ACPI: Also allow ACPI table adding via initrd not only
 overriding
Date: Tue, 18 Feb 2014 19:52:46 +0100
Message-ID: <139301482.3RWgg14omZ@skinner>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37C7D7846@ORSMSX103.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5862076244895443861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, February 18, 2014 06:38:45 PM Moore, Robert wrote:
> acpi_load_table won't work?

I guess not, there is:
        /* Must acquire the interpreter lock during this operation */
        status =3D acpi_ut_acquire_mutex(ACPI_MTX_INTERPRETER);

So the interpreter must be running already?
That would mean the adding can only happen much later.
This probably would eleminate most use cases for adding arbitrary
ACPI tables. Most tables (beside DSDT and SSDT) are needed really
early, otherwise the info could have been added as AML as well.

    Thomas =

 =

> > -----Original Message-----
> > From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Thomas
> > Renninger
> > Sent: Tuesday, February 18, 2014 10:23 AM
> > Cc: x86(a)kernel.org; ck(a)conrad-kostecki.de; linux-kernel(a)vger.kern=
el.org;
> > mingo(a)redhat.com; hpa(a)zytor.com; tglx(a)linutronix.de; devel(a)acpi=
ca.org
> > Subject: [Devel] ACPI: Also allow ACPI table adding via initrd not only
> > overriding
> > =

> > The ACPICA patches have to go into separate acpica repository first.
> > It should also be checked in acpica whether the table signature the OS
> > likes to add already exists (from BIOS). In this case the table must not
> > be added.
> > =

> > Worked here by trying to override a DSDT and addind a BGRT table.
> > =

> >      Thomas
> > =

> > _______________________________________________
> > Devel mailing list
> > Devel(a)acpica.org
> > https://lists.acpica.org/mailman/listinfo/devel


--===============5862076244895443861==--

