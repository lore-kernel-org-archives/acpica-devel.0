Content-Type: multipart/mixed; boundary="===============2663250030760992450=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH 3/4] acpi: exsystem: Warn about sleeps greater
 than 50 ms
Date: Thu, 24 Feb 2022 16:19:52 +0000
Message-ID: <BYAPR11MB32563DC0413B8595D1339B37873D9@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 20220224113807.91771-3-pmenzel@molgen.mpg.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2663250030760992450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So, this is the current implementation:

    /*
     * For compatibility with other ACPI implementations and to prevent
     * accidental deep sleeps, limit the sleep time to something reasonable.
     */
    if (HowLong > ACPI_MAX_SLEEP)
    {
        HowLong =3D ACPI_MAX_SLEEP;
    }

    AcpiOsSleep (HowLong);

Where ACPI_MAX_SLEEP is: =


#define ACPI_MAX_SLEEP                  2000    /* 2000 millisec =3D=3D two=
 seconds */

-----Original Message-----
From: Paul Menzel <pmenzel(a)molgen.mpg.de> =

Sent: Thursday, February 24, 2022 3:38 AM
To: Moore, Robert <robert.moore(a)intel.com>; Wysocki, Rafael J <rafael.j.w=
ysocki(a)intel.com>; Len Brown <lenb(a)kernel.org>
Cc: Paul Menzel <pmenzel(a)molgen.mpg.de>; linux-acpi(a)vger.kernel.org; de=
vel(a)acpica.org; linux-kernel(a)vger.kernel.org
Subject: [PATCH 3/4] acpi: exsystem: Warn about sleeps greater than 50 ms

Quick boottime is important, so warn about sleeps greater than 50 ms in ACP=
I.

50 ms is still long compared to distribution Linux kernels reaching initrd =
in 350 ms, so should probably changed to 10 ms, so people are aware about t=
his.

Signed-off-by: Paul Menzel <pmenzel(a)molgen.mpg.de>
---
 drivers/acpi/acpica/exsystem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.=
c index 00f66af31ffa..bdffb8aac05c 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -167,6 +167,11 @@ acpi_status acpi_ex_system_do_sleep(u64 how_long_ms)
 =

 	acpi_ex_exit_interpreter();
 =

+	if (how_long_ms > 50) {
+		ACPI_WARNING((AE_INFO,
+		    "Time parameter %llu > 50 ms. Please contact firmware vendor for mor=
e responsive system.", how_long_ms));
+	}
+
 	/*
 	 * For compatibility with other ACPI implementations and to prevent
 	 * accidental deep sleeps, limit the sleep time to something reasonable.
--
2.35.1

--===============2663250030760992450==--

