Content-Type: multipart/mixed; boundary="===============9064775284405906216=="
MIME-Version: 1.0
From: David E. Box <david.e.box at linux.intel.com>
Subject: [Devel]  ACPICA version 20150204 released
Date: Wed, 04 Feb 2015 13:27:21 -0800
Message-ID: <20150204212721.GA13908@pathfinder>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9064775284405906216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

04 February 2015. Summary of changes for version 20150204:

This release is available at https://acpica.org/downloads

ACPICA kernel-resident subsystem:

Updated all ACPICA copyrights and signons to 2015. Added the 2015
copyright to all module headers and signons, including the standard Linux
header. This affects virtually every file in the ACPICA core subsystem,
iASL compiler, all ACPICA utilities, and the test suites.

Events: Introduce ACPI_GPE_DISPATCH_RAW_HANDLER to fix GPE storm issues.
A raw gpe handling mechanism was created to allow better handling of GPE
storms that aren't easily managed by the normal handler. The raw handler
allows disabling/renabling of the the GPE so that interrupt storms can be
avoided in cases where events cannot be timely serviced. In this scenario,
handlers should use the AcpiSetGpe() API to disable/enable the GPE. This API
will leave the reference counts undisturbed, thereby preventing unintention=
al
clearing of the GPE when the intent in only to temporarily disable it. Raw
handlers allow enabling and disabling of a GPE by removing GPE register
locking. As such, raw handlers much provide their own locks while using
GPE API's to protect access to GPE data structures.
Lv Zheng

Events: Always modify GPE registers under the GPE lock.
Bug fix. Applies GPE lock around AcpiFinishGpe() to protect access to GPE
register values.

Unix makefiles: Separate option to disable optimizations and _FORTIFY_SOURC=
E.
This change removes the _FORTIFY_SOURCE flag from the NOOPT disable option =
and
creates a separate flag (NOFORTIFY) for this purpose. Some toolchains may
define _FORTIFY_SOURCE which leads redefined errors when building ACPICA. T=
his
allows disabling the option without also having to disable optimazations.
David Box

  Current Release:
    Non-Debug Version: 101.7K Code, 27.9K Data, 129.6K Total
    Debug Version:     199.2K Code, 82.4K Data, 281.6K Total


--===============9064775284405906216==--

