Content-Type: multipart/mixed; boundary="===============4073911838452646644=="
MIME-Version: 1.0
From: Bjorn Helgaas <bjorn.helgaas at hp.com>
Subject: [Devel] acpi_os_read_memory() from interrupt context
Date: Wed, 04 Aug 2010 11:19:23 -0600
Message-ID: <201008041119.23633.bjorn.helgaas@hp.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4073911838452646644==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Linux reads some ACPI registers from interrupt context.  For example,
we read the PM1 Status register in the SCI interrupt handler via
this path:

    acpi_irq
      acpi_ev_sci_xrupt_handler
        acpi_ev_fixed_event_detect
          acpi_hw_register_read
            acpi_hw_read_multiple
              acpi_read

But acpi_read() takes a generic address structure, and if that
address happens to be in memory space (not I/O port space), we use
acpi_os_read_memory().  In Linux, that uses ioremap() to map the
address, and that doesn't work from interrupt context.

I can imagine fixing this by doing the ioremap() at boot-time
rather than at interrupt-time, but most of this interrupt path
is in the ACPI CA, not in Linux itself, so it would probably
require some redesign in the CA.

Any suggestions?

Bjorn

--===============4073911838452646644==--

