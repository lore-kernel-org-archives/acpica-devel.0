Content-Type: multipart/mixed; boundary="===============8106559771656285620=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] build error Centos 5
Date: Fri, 11 Nov 2011 14:25:21 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E316EDD9AA@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 1321017944.16573.92.camel@localhost.localdomain
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8106559771656285620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These options are specific to newer versions of gcc. Either update your com=
piler or comment out the use of these options in the master makefile (Makef=
ile.config):

#
# gcc 4+ flags
#
CWARNINGFLAGS +=3D \
    -Waddress \
    -Waggregate-return \
    -Wchar-subscripts \
    -Wempty-body \
    -Wlogical-op \
    -Wmissing-declarations \
    -Wmissing-field-initializers \
    -Wmissing-parameter-type \
    -Wnested-externs \
    -Wold-style-declaration \
    -Wold-style-definition \
    -Wredundant-decls \
    -Wtype-limits



>-----Original Message-----
>From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On Be=
half
>Of Barry R Cisna
>Sent: Friday, November 11, 2011 5:26 AM
>To: ACPICA
>Subject: [Devel] build error Centos 5
>
>Hello All,
>
>New to the list here.
>Downloaded latest ACPICA.tar.gz.
>When trying to do a make on Centos 5 i get the following error.
>I Googled and can not find the workaround for this error.
>
>ERROR:
>
>[root(a)server1 compiler]# make
>cc -c -D_LINUX -D_GNU_SOURCE -DACPI_ASL_COMPILER -I../include
>-I../compiler -ansi -Wall -Wbad-function-cast
>-Wdeclaration-after-statement -Werror -Wformat=3D2 -Wmissing-declarations
>-Wmissing-prototypes -Wstrict-aliasing=3D0 -Wstrict-prototypes
>-Wswitch-default -Wpointer-arith -Wundef -Waddress -Waggregate-return
>-Wchar-subscripts -Wempty-body -Wlogical-op -Wmissing-declarations
>-Wmissing-field-initializers -Wmissing-parameter-type -Wnested-externs
>-Wold-style-declaration -Wold-style-definition -Wredundant-decls
>-Wtype-limits -oadfile.o ../common/adfile.c
>cc1: error: unrecognized command line option "-Waddress"
>cc1: error: unrecognized command line option "-Wempty-body"
>cc1: error: unrecognized command line option "-Wlogical-op"
>cc1: error: unrecognized command line option "-Wmissing-parameter-type"
>cc1: error: unrecognized command line option "-Wold-style-declaration"
>cc1: error: unrecognized command line option "-Wtype-limits"
>make: *** [adfile.o] Error 1
>
>
>Anyone have any ideas? Appreciated.
>
>Thanks,
>Barry
>
>_______________________________________________
>Devel mailing list
>Devel(a)acpica.org
>http://lists.acpica.org/listinfo/devel

--===============8106559771656285620==--

