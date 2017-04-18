Content-Type: multipart/mixed; boundary="===============7955883993622662667=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] Remove redundant assignment to NamepathOffset
Date: Tue, 18 Apr 2017 22:30:47 +0100
Message-ID: <20170418213047.18143-1-colin.king@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7955883993622662667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

NamepathOffset is being assigned and not used and the a few
statements later it is being re-assigned, hence the earlier
assignment is redundant and can be removed.  Remove it.

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 source/compiler/asloffset.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/source/compiler/asloffset.c b/source/compiler/asloffset.c
index e3fdf1c91..0964d4fea 100644
--- a/source/compiler/asloffset.c
+++ b/source/compiler/asloffset.c
@@ -250,7 +250,6 @@ LsAmlOffsetWalk (
         }
 =

         Length =3D Op->Asl.FinalAmlLength;
-        NamepathOffset =3D Gbl_CurrentAmlOffset + Length;
 =

         /* Get to the NameSeg/NamePath Op (and length of the name) */
 =

-- =

2.11.0


--===============7955883993622662667==--

