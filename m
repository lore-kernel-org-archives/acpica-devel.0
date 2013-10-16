Content-Type: multipart/mixed; boundary="===============2148954191343917947=="
MIME-Version: 1.0
From: naresh.bhat at linaro.org
Subject: [Devel] [PATCH 0/2] Fix DBG2 compilation template issue
Date: Wed, 16 Oct 2013 13:18:38 +0530
Message-ID: <1381909720-21314-1-git-send-email-naresh.bhat@linaro.org>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2148954191343917947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Naresh Bhat <naresh.bhat(a)linaro.org>

The patches try to fix the DBG2 table compilation issue
and also tries to add a template support for DBG2 tables.

Naresh Bhat (2):
  iASL: Fix Table Info handler for DBG2
  iASL: Add template support for dbg2

 source/common/dmtable.c      |    2 +-
 source/compiler/dtcompiler.h |    1 +
 source/compiler/dttemplate.h |   10 ++++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

-- =

1.7.9.5


--===============2148954191343917947==--

