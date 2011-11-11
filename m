Content-Type: multipart/mixed; boundary="===============5580961143297078984=="
MIME-Version: 1.0
From: Barry R Cisna <brcisna at gmail.com>
Subject: [Devel] build error Centos 5
Date: Fri, 11 Nov 2011 07:25:44 -0600
Message-ID: <1321017944.16573.92.camel@localhost.localdomain>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5580961143297078984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello All,

New to the list here.
Downloaded latest ACPICA.tar.gz.
When trying to do a make on Centos 5 i get the following error.
I Googled and can not find the workaround for this error.

ERROR:

[root(a)server1 compiler]# make
cc -c -D_LINUX -D_GNU_SOURCE -DACPI_ASL_COMPILER -I../include
-I../compiler -ansi -Wall -Wbad-function-cast
-Wdeclaration-after-statement -Werror -Wformat=3D2 -Wmissing-declarations
-Wmissing-prototypes -Wstrict-aliasing=3D0 -Wstrict-prototypes
-Wswitch-default -Wpointer-arith -Wundef -Waddress -Waggregate-return
-Wchar-subscripts -Wempty-body -Wlogical-op -Wmissing-declarations
-Wmissing-field-initializers -Wmissing-parameter-type -Wnested-externs
-Wold-style-declaration -Wold-style-definition -Wredundant-decls
-Wtype-limits -oadfile.o ../common/adfile.c
cc1: error: unrecognized command line option "-Waddress"
cc1: error: unrecognized command line option "-Wempty-body"
cc1: error: unrecognized command line option "-Wlogical-op"
cc1: error: unrecognized command line option "-Wmissing-parameter-type"
cc1: error: unrecognized command line option "-Wold-style-declaration"
cc1: error: unrecognized command line option "-Wtype-limits"
make: *** [adfile.o] Error 1


Anyone have any ideas? Appreciated.

Thanks,
Barry


--===============5580961143297078984==--

