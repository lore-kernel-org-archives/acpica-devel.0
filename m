Content-Type: multipart/mixed; boundary="===============6341368271059617623=="
MIME-Version: 1.0
From: Naresh Bhat <naresh.bhat at linaro.org>
Subject: [Devel] [PATCH 0/2] ACPI ASL test suite compilation fix for 32bit ARM
 architecture
Date: Wed, 08 May 2013 19:23:34 +0530
Message-ID: <1368021217-19585-1-git-send-email-naresh.bhat@linaro.org>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6341368271059617623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The following patches do compilation errors fix for 32bit ARM architecture

Naresh Bhat (2):
  Fix config so it will compile with GCC versions that do not have
    -m32/-m64
  Resolve problem where -Werror fails to build when compiling iasl

 generate/unix/Makefile.config |    1 -
 source/compiler/dtio.c        |    4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

-- =

1.7.9.5


--===============6341368271059617623==--

