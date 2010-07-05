Content-Type: multipart/mixed; boundary="===============0209108341739840527=="
MIME-Version: 1.0
From: malattia at linux.it
Subject: [Devel] [patch 0/5] iASL patches in Debian
Date: Mon, 05 Jul 2010 21:03:24 +0900
Message-ID: <20100705120324.581857151@linux.it>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0209108341739840527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello again (this time on the correct mailing list)!
Please Cc me on replies as I'm not subscribed to this list.

Here's a re-send of the patches incorrectly sent to linux-acpi@ and with
(hopefully better descriptions).

I've been carrying these patches in the iasl Debian package for some time. =
They
are all refreshed and reworked to apply cleanly on top of acpica-unix-20100=
528.                                                                       =
                            =

The series consists a couple of trivial patches to fix building on the     =
                                                               =

FreeBSD and Hurd kernel flavours of Debian and some larger ones to enable  =
                                                               =

compiling ASL on big endian architectures.                                 =
                                                               =

It would be great if you could apply the patches to your source tree and   =
                                                               =

ship new release with this work included.                                  =
                                                               =

Let me know if you want me to run more tests or change something in the    =
                                                               =

patches.                                                                   =
                                                               =

                                                                           =
                                                               =

I tested building tests/misc/grammar.asl (plus a number or other DSDTs I   =
                                                               =

have here) with the whole set applied and the results were identical on    =
                                                               =

BE and LE machines as well as being identical to what a clean iasl         =
                                                               =

produces on x86[1].                                                        =
                                                               =

You can see build logs for all the architectures supported here:           =
                                                               =

https://buildd.debian.org/status/package.php?p=3Dacpica-unix               =
                                                                 =


[1]: checked with (1) an hex dump of the AML file, (2) the C file        =

generated with -tc and (3) by decompiling the AML to DSL on x86 and
comparing the results.                                            =

As a side note pristine iasl on x86 sefaults when building                 =
                                                                 =

test/misc/grammar.asl, with these patches applied it doesn't.              =
                                                                 =


Thanks
-- =

mattia

--===============0209108341739840527==--

