Content-Type: multipart/mixed; boundary="===============3660791082456749005=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: [Devel] GPE blocks in reduced hardware mode
Date: Tue, 03 Dec 2013 15:38:23 -0700
Message-ID: <529E5D5F.0@redhat.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3660791082456749005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Howdy.

I've been trying to do some clean-up on the Linux ACPI driver with
regard to the reduced hardware profile introduced in ACPI 5.0.

In thinking about GPE block devices, I was looking through the
functions in source/components/events/evxfgpe.c and noticed that
they are all #ifdef'd out for ACPI_REDUCED_HARDWARE.  When I look
back through the specification, however, I cannot find any place
where they are prohibited.

Clearly, the gpe0/1 blocks in the FADT are not to be used; this
is explicitly stated in section 5.2.9 of the spec.  Could someone
please point me to a similar statement for a GPE block device?  I
just cannot seem to find it.

The closest thing I can find is section 9.10 implying that a GPE
block device is an extension of the gpe0/1 blocks from the FADT,
but there is no explicit statement there so it is ambiguous to me.

Thanks in advance for any pointers; I'm just puzzled at this point
and trying to understand how the conclusion came to be.

-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============3660791082456749005==--

