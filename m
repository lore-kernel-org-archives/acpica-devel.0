Content-Type: multipart/mixed; boundary="===============2469657970134854535=="
MIME-Version: 1.0
From: master chief <mail4chief at yahoo.com>
Subject: [Devel] Name object change produces unexpected errors.
Date: Sun, 07 Mar 2010 00:43:54 -0800
Message-ID: <508889.22399.qm@web62005.mail.re1.yahoo.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2469657970134854535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I was kind of expecting this to happen:

----------------------------------------------------------------------
ssdt.dsl    80:             Name (_ADR, Zero)
Error    4080 -                            ^ Invalid object type for reserv=
ed name, must be (Integer)

ssdt.dsl    81:             Name (_SUN, One)
Error    4080 -                           ^ Invalid object type for reserve=
d name, must be (Integer)

ASL Input:  ssdt.dsl - 328 lines, 9645 bytes, 79 keywords
Compilation complete. 2 Errors, 0 Warnings, 0 Remarks, 0 Optimizations
----------------------------------------------------------------------

But aren't the constants 'Zero' and 'One' supposed to be of type integer al=
ready?

We can't use 0x00 and 0x01 here, because then we are stuck with two "Optimi=
zations".  That is a no go since I have to deliver a product without errors=
, warnings and optimizations.  I am confused.  What are we supposed to use =
now?

Regards,

Chief


     =20

--===============2469657970134854535==--

