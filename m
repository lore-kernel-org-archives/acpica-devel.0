Content-Type: multipart/mixed; boundary="===============1311584596971169507=="
MIME-Version: 1.0
From: kbuild test robot <lkp at intel.com>
Subject: [Devel] [RFC PATCH pm] power: avs: cpr_get_opp_hz_for_req() can be
 static
Date: Wed, 25 Dec 2019 06:18:34 +0800
Message-ID: <20191224221834.qtzuikxnnfh7twji@4978f4969bb8>
In-Reply-To: 201912250622.SScsrif7%lkp@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1311584596971169507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Fixes: bf6910abf548 ("power: avs: Add support for CPR (Core Power Reduction=
)")
Signed-off-by: kbuild test robot <lkp(a)intel.com>
---
 qcom-cpr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
index a3187973bbb5fd..98c9ee4075ae9d 100644
--- a/drivers/power/avs/qcom-cpr.c
+++ b/drivers/power/avs/qcom-cpr.c
@@ -1078,8 +1078,8 @@ static unsigned int cpr_get_fuse_corner(struct dev_pm=
_opp *opp)
 	return fuse_corner;
 }
 =

-unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
-				     struct device *cpu_dev)
+static unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
+					    struct device *cpu_dev)
 {
 	u64 rate =3D 0;
 	struct device_node *ref_np;
--===============1311584596971169507==--

