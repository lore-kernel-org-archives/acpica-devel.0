Content-Type: multipart/mixed; boundary="===============4108754007562919794=="
MIME-Version: 1.0
From: Lin Ming <ming.m.lin at intel.com>
Subject: Re: [Devel] [PATCH] Fix iasl on Mac OS X
Date: Mon, 24 May 2010 16:44:46 +0800
Message-ID: <1274690686.19283.28.camel@minggr.sh.intel.com>
In-Reply-To: AANLkTinQgzO49myJ2J2gi1y3GGVQCRQ_H32gVeu2lUIg@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4108754007562919794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


> From: Stefan Reinauer <stefan.reinauer(a)coresystems.de>
> Date: Sat, May 15, 2010 at 12:53 AM
> Subject: [Devel] [PATCH] Fix iasl on Mac OS X
> To: devel(a)acpica.org
> =

> =

> Hi,
> =

> Mac OS X does not support unnamed semaphores, which breaks iasl. The
> attached patch tries a named semaphore in case sema_init claims that it
> is not implemented.

Hi,

I got below error, need to add "#include <fcntl.h>" to fix it.

cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../include =
-I../compiler   -c -o ../osunixxf.o ../osunixxf.c
../osunixxf.c: In function =E2=80=98AcpiOsCreateSemaphore=E2=80=99:
../osunixxf.c:543: error: =E2=80=98O_EXCL=E2=80=99 undeclared (first use in=
 this function)
../osunixxf.c:543: error: (Each undeclared identifier is reported only once
../osunixxf.c:543: error: for each function it appears in.)
../osunixxf.c:543: error: =E2=80=98O_CREAT=E2=80=99 undeclared (first use i=
n this function)
make: *** [../osunixxf.o] Error 1

And another warning is,

../osunixxf.o: In function `AcpiOsCreateSemaphore':
osunixxf.c:(.text+0x518): warning: the use of `tmpnam' is dangerous, better=
 use `mkstemp'

As gcc suggests, better to use "mkstemp".

Thanks,
Lin Ming

> =

> Best regards,
> =

> Stefan Reinauer
> =

> --
> coresystems GmbH =E2=80=A2 Brahmsstr. 16 =E2=80=A2 D-79104 Freiburg i. Br.
>      Tel.: +49 761 7668825 =E2=80=A2 Fax: +49 761 7664613
> Email: info(a)coresystems.de  =E2=80=A2 http://www.coresystems.de/
> Registergericht: Amtsgericht Freiburg =E2=80=A2 HRB 7656
> Gesch=C3=A4ftsf=C3=BChrer: Stefan Reinauer =E2=80=A2 Ust-IdNr.: DE2456748=
66
> =

> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> http://lists.acpica.org/listinfo/devel


--===============4108754007562919794==--

