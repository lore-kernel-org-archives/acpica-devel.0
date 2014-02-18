Content-Type: multipart/mixed; boundary="===============5923820065648246454=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] ACPI: Also allow ACPI table adding via initrd not
 only	overriding
Date: Tue, 18 Feb 2014 18:38:45 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37C7D7846@ORSMSX103.amr.corp.intel.com>
In-Reply-To: 1392747763-3384-1-git-send-email-trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5923820065648246454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

acpi_load_table won't work?



> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Thomas
> Renninger
> Sent: Tuesday, February 18, 2014 10:23 AM
> Cc: x86(a)kernel.org; ck(a)conrad-kostecki.de; linux-kernel(a)vger.kernel=
.org;
> mingo(a)redhat.com; hpa(a)zytor.com; tglx(a)linutronix.de; devel(a)acpica=
.org
> Subject: [Devel] ACPI: Also allow ACPI table adding via initrd not only
> overriding
> =

> The ACPICA patches have to go into separate acpica repository first.
> It should also be checked in acpica whether the table signature the OS
> likes to add already exists (from BIOS). In this case the table must not
> be added.
> =

> Worked here by trying to override a DSDT and addind a BGRT table.
> =

>      Thomas
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============5923820065648246454==--

