Content-Type: multipart/mixed; boundary="===============6773822874416116321=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [PATCH v2 0/2] ACPICA: Update linuxized scripts.
Date: Sat, 12 Jan 2013 01:18:21 +0800
Message-ID: <cover.1357924466.git.lv.zheng@intel.com>
In-Reply-To: b4290bf9f1459cc36ffb785f7d59ebbc1a54bca0.1357921698.git.lv.zheng@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6773822874416116321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Update linuxized scripts to make proper genereated patches.

History:
 v1:
   1. Add header fields for linuxized patches, one per file.
   2. Fix acpisrc generation position to allow copyright patches to be crea=
ted.
 v2:
   1. Fix header fields for linuxized patches, mbox file.

Lv Zheng (2):
  ACPICA: Linuxize: Add patch header fields for linuxized patches.
  ACPICA: Linuxize: Move acpisrc generation from make-patch.pl to
    linuxize.sh.

 generate/linux/patches/linuxize.sh     |    5 +++
 generate/linux/patches/make-patches.pl |   64 ++++++++++++++++++++++++++++=
+---
 2 files changed, 64 insertions(+), 5 deletions(-)

-- =

1.7.10


--===============6773822874416116321==--

