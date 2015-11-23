Content-Type: multipart/mixed; boundary="===============3327804753749729785=="
MIME-Version: 1.0
From: Lukas Wunner <lukas at wunner.de>
Subject: [Devel] [PATCH 5/5] ASoC: Intel: Use acpi_dev_present
Date: Mon, 23 Nov 2015 15:34:55 +0100
Message-ID: <b7bd5f48fd254fb743b99d5c3e63f95ea8dfd8a7.1448282995.git.lukas@wunner.de>
In-Reply-To: cover.1448282995.git.lukas@wunner.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3327804753749729785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use shiny new acpi_dev_present and remove all the boilerplate to search
for a particular ACPI device. No functional change.

Cc: Mark Brown <broonie(a)kernel.org>
Cc: Takashi Iwai <tiwai(a)suse.de>
Signed-off-by: Lukas Wunner <lukas(a)wunner.de>
---
 sound/soc/intel/atom/sst/sst_acpi.c          | 12 +-----------
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 17 ++---------------
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 13 +------------
 sound/soc/intel/common/sst-acpi.c            | 12 +-----------
 4 files changed, 5 insertions(+), 49 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst=
/sst_acpi.c
index bb19b58..ca12aa5 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -223,23 +223,13 @@ static int sst_platform_get_resources(struct intel_ss=
t_drv *ctx)
 	return 0;
 }
 =

-static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
-				       void *context, void **ret)
-{
-	*(bool *)context =3D true;
-	return AE_OK;
-}
-
 static struct sst_machines *sst_acpi_find_machine(
 	struct sst_machines *machines)
 {
 	struct sst_machines *mach;
-	bool found =3D false;
 =

 	for (mach =3D machines; mach->codec_id; mach++)
-		if (ACPI_SUCCESS(acpi_get_devices(mach->codec_id,
-						  sst_acpi_mach_match,
-						  &found, NULL)) && found)
+		if (acpi_dev_present(mach->codec_id))
 			return mach;
 =

 	return NULL;
diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel=
/boards/cht_bsw_max98090_ti.c
index 4e2fcf1..4036f01 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -278,33 +278,20 @@ static struct snd_soc_card snd_soc_card_cht =3D {
 	.num_controls =3D ARRAY_SIZE(cht_mc_controls),
 };
 =

-static acpi_status snd_acpi_codec_match(acpi_handle handle, u32 level,
-						void *context, void **ret)
-{
-	*(bool *)context =3D true;
-	return AE_OK;
-}
-
 static int snd_cht_mc_probe(struct platform_device *pdev)
 {
 	int ret_val =3D 0;
-	bool found =3D false;
 	struct cht_mc_private *drv;
 =

 	drv =3D devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
 	if (!drv)
 		return -ENOMEM;
 =

-	if (ACPI_SUCCESS(acpi_get_devices(
-					"104C227E",
-					snd_acpi_codec_match,
-					&found, NULL)) && found) {
-		drv->ts3a227e_present =3D true;
-	} else {
+	drv->ts3a227e_present =3D acpi_dev_present("104C227E");
+	if (!drv->ts3a227e_present) {
 		/* no need probe TI jack detection chip */
 		snd_soc_card_cht.aux_dev =3D NULL;
 		snd_soc_card_cht.num_aux_devs =3D 0;
-		drv->ts3a227e_present =3D false;
 	}
 =

 	/* register the soc card */
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boar=
ds/cht_bsw_rt5645.c
index 38d65a3..5e539cd 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -324,20 +324,12 @@ static struct cht_acpi_card snd_soc_cards[] =3D {
 	{"10EC5650", CODEC_TYPE_RT5650, &snd_soc_card_chtrt5650},
 };
 =

-static acpi_status snd_acpi_codec_match(acpi_handle handle, u32 level,
-				       void *context, void **ret)
-{
-	*(bool *)context =3D true;
-	return AE_OK;
-}
-
 static int snd_cht_mc_probe(struct platform_device *pdev)
 {
 	int ret_val =3D 0;
 	int i;
 	struct cht_mc_private *drv;
 	struct snd_soc_card *card =3D snd_soc_cards[0].soc_card;
-	bool found =3D false;
 	char codec_name[16];
 =

 	drv =3D devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
@@ -345,10 +337,7 @@ static int snd_cht_mc_probe(struct platform_device *pd=
ev)
 		return -ENOMEM;
 =

 	for (i =3D 0; i < ARRAY_SIZE(snd_soc_cards); i++) {
-		if (ACPI_SUCCESS(acpi_get_devices(
-						snd_soc_cards[i].codec_id,
-						snd_acpi_codec_match,
-						&found, NULL)) && found) {
+		if (acpi_dev_present(snd_soc_cards[i].codec_id)) {
 			dev_dbg(&pdev->dev,
 				"found codec %s\n", snd_soc_cards[i].codec_id);
 			card =3D snd_soc_cards[i].soc_card;
diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst=
-acpi.c
index 67b6d3d..bc14826 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -88,23 +88,13 @@ static void sst_acpi_fw_cb(const struct firmware *fw, v=
oid *context)
 	return;
 }
 =

-static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
-				       void *context, void **ret)
-{
-	*(bool *)context =3D true;
-	return AE_OK;
-}
-
 static struct sst_acpi_mach *sst_acpi_find_machine(
 	struct sst_acpi_mach *machines)
 {
 	struct sst_acpi_mach *mach;
-	bool found =3D false;
 =

 	for (mach =3D machines; mach->id[0]; mach++)
-		if (ACPI_SUCCESS(acpi_get_devices(mach->id,
-						  sst_acpi_mach_match,
-						  &found, NULL)) && found)
+		if (acpi_dev_present(mach->id))
 			return mach;
 =

 	return NULL;
-- =

1.8.5.2 (Apple Git-48)


--===============3327804753749729785==--

