Content-Type: multipart/mixed; boundary="===============8225104004609865270=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] MP configuration table construction
Date: Fri, 18 Sep 2009 13:03:30 -0700
Message-ID: <4911F71203A09E4D9981D27F9D83085837743BB4@orsmsx503.amr.corp.intel.com>
In-Reply-To: 335B0C82582BE54F91285BC9E7D6558B01A3108F@ala-mail10.corp.ad.wrs.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8225104004609865270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rich,

I can't help with the IOAPIC stuff, but as far as interrupt levels and trig=
gering, take a look at the resource descriptors as returned by the _CRS met=
hods.

There are 2 descriptors: IRQ and ExtendedIRQ. IRQ contains the INT value an=
d the triggering mode. The Extended version contains additional information.

Bob


>-----Original Message-----
>From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On Be=
half
>Of Carter, Richard
>Sent: Friday, September 18, 2009 10:29 AM
>To: devel(a)acpica.org
>Subject: [Devel] MP configuration table construction
>
>
>I work for a commercial OS vendor.  I've been asked to use ACPI to
>construct MP tables for some pentium boards that either lack a table or
>have errors in it.  I have some questions and hope someone out in the
>community can answer them.
>
>As noted in the ACPI spec (par 5.2.11.7), should the MP table always
>have entries for the 16 ISA interrupts when dual-8259 support is
>indicated in the MADT?
>
>If dual-8259 support is not indicated, how do I determine which ISA
>interrupts are available?
>
>The PCI routing table reported by acpiGetIrqRoutingTable doesn't
>indicate interrupt level and triggering.  Do PCI interrupts always
>conform to the bus specification or is there some other method for ACPI
>to report differences?
>
>When there is more tha 1 IOAPIC, how does one determine which IOAPIC an
>interrupt reported by the _PRT belongs to?  I see a GlobalIrqBase
>reported in the MADT IOAPIC record.  Is this normally used to lookup
>which IOAPIC the IRQ is connected to?
>
>Thanks in advance
>Rich Carter
>603-897-2071
>_______________________________________________
>Devel mailing list
>Devel(a)acpica.org
>http://lists.acpica.org/listinfo/devel

--===============8225104004609865270==--

