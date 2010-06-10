Content-Type: multipart/mixed; boundary="===============2814097548897195632=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] AcpiClearGpe() and recent changes
Date: Thu, 10 Jun 2010 13:09:38 -0700
Message-ID: <4911F71203A09E4D9981D27F9D83085870DEC8AD@orsmsx503.amr.corp.intel.com>
In-Reply-To: 20100606091726.GA27517@marx.bitnet
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2814097548897195632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm not entirely sure at the moment, but we are about to make some addition=
al GPE changes since some issues with the reference count mechanism have be=
en uncovered.

Do you have a need to call AcpiClearGpe from interrupt level?


>-----Original Message-----
>From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On Be=
half
>Of Jukka Ruohonen
>Sent: Sunday, June 06, 2010 2:17 AM
>To: devel(a)acpica.org
>Subject: [Devel] AcpiClearGpe() and recent changes
>
>Hello.
>
>I have a question about this recent change:
>
>        31 March 2010. Summary of changes for version 20100331:
>
>        1) ACPI CA Core Subsystem:
>
>        Completed a major update for the GPE support in order to improve
>        support for shared GPEs and to simplify both host OS and ACPICA
>        code. Added a reference count mechanism to support shared GPEs that
>        require multiple device drivers.  Several external interfaces have
>        changed. One external interface has been removed. One new external
>        interface was added. Most of the GPE external interfaces now use
>the
>        GPE spinlock instead of the events mutex (and the Flags parameter
>        for many GPE interfaces has been removed.) See the updated ACPICA
>        Programmer Reference for details. Matthew Garrett, Bob Moore,
>Rafael
>        Wysocki. ACPICA BZ 831.
>
>Now the AcpiClearGpe() function operates with a spin mutex on
>AcpiGbl_GpeLock.
>Previously it was possible to avoid getting a lock if the ACPI_NOT_ISR was
>not specified, and thus it was possible to also call AcpiClearGpe() from a
>GPE handler. If my reading is correct, this is no longer possible because
>the GPE dispatch functions obtain the same AcpiGbl_GpeLock already before
>calling the custom handler installed via AcpiInstallGpeHandler().
>
>The documentation however claims that "this function [AcpiClearGpe()] may
>be
>called from an interrupt service routine (typically a GPE handler) or a
>device driver".
>
>Am I missing or misinterpreting something?
>
>- Jukka.
>_______________________________________________
>Devel mailing list
>Devel(a)acpica.org
>http://lists.acpica.org/listinfo/devel

--===============2814097548897195632==--

