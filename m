Content-Type: multipart/mixed; boundary="===============8332231250372902106=="
MIME-Version: 1.0
From: Carter, Richard <richard.carter at windriver.com>
Subject: [Devel] MP configuration table construction
Date: Fri, 18 Sep 2009 10:29:29 -0700
Message-ID: <335B0C82582BE54F91285BC9E7D6558B01A3108F@ala-mail10.corp.ad.wrs.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8332231250372902106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


I work for a commercial OS vendor.  I've been asked to use ACPI to
construct MP tables for some pentium boards that either lack a table or
have errors in it.  I have some questions and hope someone out in the
community can answer them.

As noted in the ACPI spec (par 5.2.11.7), should the MP table always
have entries for the 16 ISA interrupts when dual-8259 support is
indicated in the MADT?

If dual-8259 support is not indicated, how do I determine which ISA
interrupts are available?

The PCI routing table reported by acpiGetIrqRoutingTable doesn't
indicate interrupt level and triggering.  Do PCI interrupts always
conform to the bus specification or is there some other method for ACPI
to report differences?

When there is more tha 1 IOAPIC, how does one determine which IOAPIC an
interrupt reported by the _PRT belongs to?  I see a GlobalIrqBase
reported in the MADT IOAPIC record.  Is this normally used to lookup
which IOAPIC the IRQ is connected to?

Thanks in advance
Rich Carter
603-897-2071

--===============8332231250372902106==--

