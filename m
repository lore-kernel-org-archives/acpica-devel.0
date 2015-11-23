Content-Type: multipart/mixed; boundary="===============2456298844181415253=="
MIME-Version: 1.0
From: Lukas Wunner <lukas at wunner.de>
Subject: [Devel] [PATCH 4/5] ALSA: hda - Use acpi_dev_present
Date: Mon, 23 Nov 2015 15:34:55 +0100
Message-ID: <515643b09b28cd6b4445a1ff194bf62b0d02989c.1448282995.git.lukas@wunner.de>
In-Reply-To: cover.1448282995.git.lukas@wunner.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2456298844181415253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use shiny new acpi_dev_present and remove all the boilerplate to search
for a particular ACPI device. No functional change.

Cc: Hui Wang <hui.wang(a)canonical.com>
Cc: Takashi Iwai <tiwai(a)suse.de>
Signed-off-by: Lukas Wunner <lukas(a)wunner.de>
---
 sound/pci/hda/thinkpad_helper.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/sound/pci/hda/thinkpad_helper.c b/sound/pci/hda/thinkpad_helpe=
r.c
index 0a4ad5f..59ab6ce 100644
--- a/sound/pci/hda/thinkpad_helper.c
+++ b/sound/pci/hda/thinkpad_helper.c
@@ -10,23 +10,10 @@
 static int (*led_set_func)(int, bool);
 static void (*old_vmaster_hook)(void *, int);
 =

-static acpi_status acpi_check_cb(acpi_handle handle, u32 lvl, void *contex=
t,
-				 void **rv)
-{
-	bool *found =3D context;
-	*found =3D true;
-	return AE_OK;
-}
-
 static bool is_thinkpad(struct hda_codec *codec)
 {
-	bool found =3D false;
-	if (codec->core.subsystem_id >> 16 !=3D 0x17aa)
-		return false;
-	if (ACPI_SUCCESS(acpi_get_devices("LEN0068", acpi_check_cb, &found, NULL)=
) && found)
-		return true;
-	found =3D false;
-	return ACPI_SUCCESS(acpi_get_devices("IBM0068", acpi_check_cb, &found, NU=
LL)) && found;
+	return (codec->core.subsystem_id >> 16 =3D=3D 0x17aa) &&
+	       (acpi_dev_present("LEN0068") || acpi_dev_present("IBM0068"));
 }
 =

 static void update_tpacpi_mute_led(void *private_data, int enabled)
-- =

1.8.5.2 (Apple Git-48)


--===============2456298844181415253==--

