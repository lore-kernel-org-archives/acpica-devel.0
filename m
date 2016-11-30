Content-Type: multipart/mixed; boundary="===============7680474908370810292=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] Linux-specific header: Add support for s390x
 compilation
Date: Wed, 30 Nov 2016 13:16:26 +0000
Message-ID: <20161130131627.25030-1-colin.king@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7680474908370810292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

While porting ACPCIA integrated into fwts I discovered that I get build
issues on s390x because ACPCIA does not know it is a 64 bit architecture.
Update aclinux.h to support this architecture.

Colin Ian King (1):
  Linux-specific header: Add support for s390x compilation.

 source/include/platform/aclinux.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- =

2.10.2


--===============7680474908370810292==--

