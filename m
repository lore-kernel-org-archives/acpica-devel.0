Content-Type: multipart/mixed; boundary="===============0287120026551028069=="
MIME-Version: 1.0
From: Rudolf Marek <r.marek at assembler.cz>
Subject: [Devel] AcpiOsAllocate with zero argument
Date: Wed, 27 Jul 2016 18:53:53 +0200
Message-ID: <5798E721.9010306@assembler.cz>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0287120026551028069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I could not find in the "ACPICA Overview and Programmer Reference" any clue=
s =

what to do if someone calls AcpiOsAllocate() with size of zero. I checked t=
he =

Linux implementation and it just calls kmalloc() which after bit of googlin=
g =

seems to return non-NULL for this case. I also tried to walk through the AC=
PICA =

sources and it seems to me that at least on some places it looks like that =
it =

could be called with 0 (num_gpe * sizeof(something))
I also tried to look to the "osdeps" of what the UEFI or unix stub do, but =
they =

simply pass it on. I could not find what UEFI does with zero, I only know
that malloc can either return NULL (and success) or return also non-null po=
inter.

What is the correct way to handle the zero size allocations? Return non-NUL=
L ?

Thanks
Rudolf



--===============0287120026551028069==--

