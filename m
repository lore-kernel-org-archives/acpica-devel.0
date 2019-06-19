Content-Type: multipart/mixed; boundary="===============1158497322121927237=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH v2 1/3] ACPI: Resolve objects on host-directed
 table loads
Date: Wed, 19 Jun 2019 15:59:33 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B95FC28D@ORSMSX110.amr.corp.intel.com>
In-Reply-To: alpine.DEB.2.20.1906191123400.34742@fox.voss.local
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1158497322121927237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Nikolaus Voss [mailto:nv(a)vosn.de]
> Sent: Wednesday, June 19, 2019 2:31 AM
> To: Moore, Robert <robert.moore(a)intel.com>
> Cc: Rafael J. Wysocki <rafael(a)kernel.org>; Rafael J. Wysocki
> <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.org>; Schmauss, Erik
> <erik.schmauss(a)intel.com>; Jacek Anaszewski
> <jacek.anaszewski(a)gmail.com>; Pavel Machek <pavel(a)ucw.cz>; Dan Murphy
> <dmurphy(a)ti.com>; Thierry Reding <thierry.reding(a)gmail.com>; ACPI Dev=
el
> Maling List <linux-acpi(a)vger.kernel.org>; open list:ACPI COMPONENT
> ARCHITECTURE (ACPICA) <devel(a)acpica.org>; linux-leds(a)vger.kernel.org;
> Linux PWM List <linux-pwm(a)vger.kernel.org>; Linux Kernel Mailing List
> <linux-kernel(a)vger.kernel.org>; nikolaus.voss(a)loewensteinmedical.de
> Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
> loads
> =

> Hi Bob,
> =

> On Tue, 18 Jun 2019, Moore, Robert wrote:
> >
> >
> >> -----Original Message-----
> >> From: Moore, Robert
> >> Sent: Tuesday, June 18, 2019 1:25 PM
> >> To: 'Nikolaus Voss' <nv(a)vosn.de>
> >> Cc: 'Rafael J. Wysocki' <rafael(a)kernel.org>; 'Rafael J. Wysocki'
> >> <rjw(a)rjwysocki.net>; 'Len Brown' <lenb(a)kernel.org>; Schmauss, Erik
> >> <erik.schmauss(a)intel.com>; 'Jacek Anaszewski'
> >> <jacek.anaszewski(a)gmail.com>; 'Pavel Machek' <pavel(a)ucw.cz>; 'Dan
> >> Murphy' <dmurphy(a)ti.com>; 'Thierry Reding'
> >> <thierry.reding(a)gmail.com>; 'ACPI Devel Maling List'
> >> <linux-acpi(a)vger.kernel.org>; 'open list:ACPI COMPONENT ARCHITECTURE
> >> (ACPICA)' <devel(a)acpica.org>; 'linux- leds(a)vger.kernel.org' <linux-
> leds(a)vger.kernel.org>; 'Linux PWM List'
> >> <linux-pwm(a)vger.kernel.org>; 'Linux Kernel Mailing List' <linux-
> >> kernel(a)vger.kernel.org>
> >> Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed
> >> table loads
> >>
> >> If it is in fact the AcpiLoadTable interface that is incorrect, that
> >> of course is different. I'll check that out next.
> >>
> > [Moore, Robert]
> >
> > Yes, this is the issue, not specifically the Load() operator, but the
> > AcpiLoadTable interface only.
> =

> thanks for checking this out. So what is the conclusion? Is my fix of
> AcpiLoadTable() sufficient or do we need a different solution?
> =

> Niko
> =



Your change is in the correct area. We want to do something like this, howe=
ver:

diff --git a/source/components/executer/exconfig.c b/source/components/exec=
uter/exconfig.c
index 84a058ada..eba1a6d28 100644
--- a/source/components/executer/exconfig.c
+++ b/source/components/executer/exconfig.c
@@ -342,10 +342,9 @@ AcpiExLoadTableOp (
         return_ACPI_STATUS (Status);
     }
 =

-    /* Complete the initialization/resolution of package objects */
+    /* Complete the initialization/resolution of new objects */
 =

-    Status =3D AcpiNsWalkNamespace (ACPI_TYPE_PACKAGE, ACPI_ROOT_OBJECT,
-        ACPI_UINT32_MAX, 0, AcpiNsInitOnePackage, NULL, NULL, NULL);
+    AcpiNsInitializeObjects ();
 =

     /* Parameter Data (optional) */
 =

@@ -620,10 +619,11 @@ AcpiExLoadOp (
         return_ACPI_STATUS (Status);
     }
 =

-    /* Complete the initialization/resolution of package objects */
+    /* Complete the initialization/resolution of new objects */
 =

-    Status =3D AcpiNsWalkNamespace (ACPI_TYPE_PACKAGE, ACPI_ROOT_OBJECT,
-        ACPI_UINT32_MAX, 0, AcpiNsInitOnePackage, NULL, NULL, NULL);
+    AcpiExExitInterpreter ();
+    AcpiNsInitializeObjects ();
+    AcpiExEnterInterpreter ();
 =

     /* Store the DdbHandle into the Target operand */
 =

diff --git a/source/components/tables/tbxfload.c b/source/components/tables=
/tbxfload.c
index 217d54bf0..1e17db6c8 100644
--- a/source/components/tables/tbxfload.c
+++ b/source/components/tables/tbxfload.c
@@ -479,6 +479,13 @@ AcpiLoadTable (
     ACPI_INFO (("Host-directed Dynamic ACPI Table Load:"));
     Status =3D AcpiTbInstallAndLoadTable (ACPI_PTR_TO_PHYSADDR (Table),
         ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL, FALSE, &TableIndex);
+    if (ACPI_SUCCESS (Status))
+    {
+        /* Complete the initialization/resolution of new objects */
+
+        AcpiNsInitializeObjects ();
+    }
+
     return_ACPI_STATUS (Status);
 }



> [...]

--===============1158497322121927237==--

