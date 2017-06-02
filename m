Content-Type: multipart/mixed; boundary="===============4661824297329124431=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: [Devel] Concatenate() operator
Date: Thu, 01 Jun 2017 18:47:24 -0600
Message-ID: <679bcec8-c7bc-6bc9-873d-4500d327e9ee@redhat.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4661824297329124431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm a little confused by what the spec is telling me and what the code is
actually doing for the Concatenate() operator.

Here's the ASL I'm working with (it's an iasl test, so it doesn't really
have to make a lot of sense):

DefinitionBlock ("", "DSDT", 1, "Intel", "Many", 0x00000001)
{
	Method (M64G, 0, NotSerialized)
        {
            Local0 =3D Concatenate (0x0321, "0321")
            Local0 =3D Concatenate (0x0321, "FE7CB391D650A284")
	    Return(Local0)
	}
}

The resulting AML looks like this (from hexdump -C):

00000000  44 53 44 54 49 00 00 00  01 21 49 6e 74 65 6c 00  |DSDTI....!Inte=
l.|
00000010  4d 61 6e 79 00 00 00 00  01 00 00 00 49 4e 54 4c  |Many........IN=
TL|
00000020  03 03 17 20 14 24 4d 36  34 47 00 70 11 0b 0a 08  |... .$M64G.p..=
..|
00000030  21 03 00 00 21 03 00 00  60 70 11 0b 0a 08 21 03  |!...!...`p....=
!.|
00000040  00 00 91 b3 7c fe 60 a4  60                       |....|.`.`|
00000049

Bytes 0x0030-0x0038 are the first use of Concatenate():

	Concatenate (0x0321, "0321")

If I understand the spec correctly (19.6.12), since the first operand is an
Integer, the second is to be "implicitly converted if necessary (and possib=
le)
to match" -- hence, to an Integer.  The String "0321", *if* it is assumed t=
o be
a hex value, seems okay.

So, my first question is: is that a reasonable assumption?  I suspect the a=
nswer
is "probably" but I don't recall seeing anything in the spec that says that=
 a
string conversion to an integer will always assume the string represents a =
hex
value; as someone who spends more time with C than ASL, I assumed that woul=
d be
an octal value.  And, because of section 19.3.2.1, I was surprised it was n=
ot
treated as octal, so the AML is looking wrong to me (0321 should be 0xd1)

The second usage (bytes 0x003e-0x0046 is even stranger to me:

	Local0 =3D Concatenate (0x0321, "FE7CB391D650A284")

If we assume the String is hex again -- though it should be "0xFE7CB391D650=
A284"
to be proper -- it is a valid 64-bit integer but it gets truncated to 32-bi=
ts in
the AML.

So, the second question is: why?  Since the operator is returning a Buffer =
or a
String, there doesn't seem to be any reason to truncate the value -- or at =
least
nothing I'm finding in the spec; in fact, quite the contrary.

This all leads to the third question: which one is correct -- iasl or the s=
pec?
Or am I just missing something obvious?

Thanks.

-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============4661824297329124431==--

