Content-Type: multipart/mixed; boundary="===============2716040164616807694=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: [Devel] ACPI: Also allow ACPI table adding via initrd not only
 overriding
Date: Tue, 18 Feb 2014 19:22:39 +0100
Message-ID: <1392747763-3384-1-git-send-email-trenn@suse.de>
In-Reply-To: 530265A3.3020302@zytor.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2716040164616807694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ACPICA patches have to go into separate acpica repository first.
It should also be checked in acpica whether the table signature the OS likes
to add already exists (from BIOS). In this case the table must not be added.

Worked here by trying to override a DSDT and addind a BGRT table.

     Thomas


--===============2716040164616807694==--

