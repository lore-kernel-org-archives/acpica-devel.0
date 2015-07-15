Content-Type: multipart/mixed; boundary="===============7382610614962811398=="
MIME-Version: 1.0
From: Colin Ian King <colin.king at canonical.com>
Subject: [Devel] Can't build IASL on today's ACPICA tip
Date: Wed, 15 Jul 2015 18:58:00 +0100
Message-ID: <55A69F28.2010501@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7382610614962811398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi there,

Building of IASL on Ubuntu 15.10 Wily fails on today's ACPICA tip
(commit b9677e910888b35f27746f97567950f9157f63a6)

make[1]: Entering directory '/home/king/repos/acpica/generate/unix/iasl'
make[1]: *** No rule to make target 'obj/dmobject.o', needed by
'obj/iasl'. Stop.
make[1]: Leaving directory '/home/king/repos/acpica/generate/unix/iasl'
generate/unix/Makefile.common:21: recipe for target 'iasl' failed
make: *** [iasl] Error 2

I think the root cause is the following commit:

commit 7dca7e02d1f10f096233358096a4578225f207a7
Merge: 1389ac5 2164923
Author: Robert Moore <Robert.Moore(a)intel.com>
Date:   Fri Jul 10 12:56:35 2015 -0700

    Merge pull request #78 from zetalog/acpica-debug

    Acpica debugger

Colin.

--===============7382610614962811398==--

