Content-Type: multipart/mixed; boundary="===============3208677539492633317=="
MIME-Version: 1.0
From: Marcel Apfelbaum <marcel.a at redhat.com>
Subject: [Devel] Possible issue with iasl on big endian machines.
Date: Thu, 20 Mar 2014 19:03:31 +0200
Message-ID: <1395335011.3100.7.camel@localhost.localdomain>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3208677539492633317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Should iasl running on a big endian machine be able to
disassemble a DSDT(and any other acpi table) taken from a
little endian machine?

I tried to do it and I receive:
Error [...] TableHeader length [0xBB040000] greater than the input file siz=
e [0x4BB].
As you can see the length bytes are swapped.

The question is, shouldn't it work, ACPI protocol being always little-endia=
n?

Thanks,
Marcel



--===============3208677539492633317==--

