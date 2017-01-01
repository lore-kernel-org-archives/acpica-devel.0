Content-Type: multipart/mixed; boundary="===============7971105558281538433=="
MIME-Version: 1.0
From: Anthony Jenkins <Scoobi_doo at yahoo.com>
Subject: [Devel] Missing _BQC method
Date: Sun, 01 Jan 2017 17:01:22 -0500
Message-ID: <8036e82a-c79b-6824-1245-bf5fb027a1fa@yahoo.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7971105558281538433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What may the OSPM assume/do about a missing _BQC (Brightness Query
Current level) method?  The last two HP ENVY laptops I owned do not have
this method, and FreeBSD's acpi_video driver (currently) requires it to
control screen brightness - unless I can assume _only_ the OSPM can set
the screen brightness.  My current workaround is a patch to the DSDT to
add a simple method that copies and returns a variable used by _BCM
(Brightness Control Method).

Thanks in advance,

-- =

Anthony Jenkins



--===============7971105558281538433==--

