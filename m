Content-Type: multipart/mixed; boundary="===============7829620671956506566=="
MIME-Version: 1.0
From: Jukka Ruohonen <jruohonen at iki.fi>
Subject: [Devel] AcpiClearGpe() and recent changes
Date: Sun, 06 Jun 2010 12:17:26 +0300
Message-ID: <20100606091726.GA27517@marx.bitnet>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7829620671956506566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello.

I have a question about this recent change:

        31 March 2010. Summary of changes for version 20100331:

        1) ACPI CA Core Subsystem:

        Completed a major update for the GPE support in order to improve
        support for shared GPEs and to simplify both host OS and ACPICA
        code. Added a reference count mechanism to support shared GPEs that
        require multiple device drivers.  Several external interfaces have
        changed. One external interface has been removed. One new external
        interface was added. Most of the GPE external interfaces now use the
        GPE spinlock instead of the events mutex (and the Flags parameter
        for many GPE interfaces has been removed.) See the updated ACPICA
        Programmer Reference for details. Matthew Garrett, Bob Moore, Rafael
        Wysocki. ACPICA BZ 831.

Now the AcpiClearGpe() function operates with a spin mutex on AcpiGbl_GpeLo=
ck.
Previously it was possible to avoid getting a lock if the ACPI_NOT_ISR was
not specified, and thus it was possible to also call AcpiClearGpe() from a
GPE handler. If my reading is correct, this is no longer possible because
the GPE dispatch functions obtain the same AcpiGbl_GpeLock already before
calling the custom handler installed via AcpiInstallGpeHandler().

The documentation however claims that "this function [AcpiClearGpe()] may be
called from an interrupt service routine (typically a GPE handler) or a
device driver".

Am I missing or misinterpreting something?

- Jukka.

--===============7829620671956506566==--

