Content-Type: multipart/mixed; boundary="===============0168288339328055135=="
MIME-Version: 1.0
From: Stefan Reinauer <stefan.reinauer at coresystems.de>
Subject: Re: [Devel] [PATCH] Fix iasl on Mac OS X
Date: Mon, 24 May 2010 11:08:06 +0200
Message-ID: <4BFA41F6.2040907@coresystems.de>
In-Reply-To: 1274690686.19283.28.camel@minggr.sh.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0168288339328055135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 5/24/10 10:44 AM, Lin Ming wrote:
>   =

>> From: Stefan Reinauer <stefan.reinauer(a)coresystems.de>
>> Date: Sat, May 15, 2010 at 12:53 AM
>> Subject: [Devel] [PATCH] Fix iasl on Mac OS X
>> To: devel(a)acpica.org
>>
>>
>> Hi,
>>
>> Mac OS X does not support unnamed semaphores, which breaks iasl. The
>> attached patch tries a named semaphore in case sema_init claims that it
>> is not implemented.
>>     =

> Hi,
>
> I got below error, need to add "#include <fcntl.h>" to fix it.
>
> cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e -I../compiler   -c -o ../osunixxf.o ../osunixxf.c
> ../osunixxf.c: In function =E2=80=98AcpiOsCreateSemaphore=E2=80=99:
> ../osunixxf.c:543: error: =E2=80=98O_EXCL=E2=80=99 undeclared (first use =
in this function)
> ../osunixxf.c:543: error: (Each undeclared identifier is reported only on=
ce
> ../osunixxf.c:543: error: for each function it appears in.)
> ../osunixxf.c:543: error: =E2=80=98O_CREAT=E2=80=99 undeclared (first use=
 in this function)
> make: *** [../osunixxf.o] Error 1
>   =


Thank you for testing this. I will update the patch.
> And another warning is,
>
> ../osunixxf.o: In function `AcpiOsCreateSemaphore':
> osunixxf.c:(.text+0x518): warning: the use of `tmpnam' is dangerous, bett=
er use `mkstemp'
>
> As gcc suggests, better to use "mkstemp".
Not sure mkstemp is appropriate here. It creates a file while what we
need is a semaphore. I will test, however, whether creating a semaphore
by overwriting that file name works as one would hope.

Stefan

-- =

coresystems GmbH =E2=80=A2 Brahmsstr. 16 =E2=80=A2 D-79104 Freiburg i. Br.
      Tel.: +49 761 7668825 =E2=80=A2 Fax: +49 761 7664613
Email: info(a)coresystems.de  =E2=80=A2 http://www.coresystems.de/
Registergericht: Amtsgericht Freiburg =E2=80=A2 HRB 7656
Gesch=C3=A4ftsf=C3=BChrer: Stefan Reinauer =E2=80=A2 Ust-IdNr.: DE245674866


--===============0168288339328055135==--

