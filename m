Content-Type: multipart/mixed; boundary="===============5752969045758238792=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: [Devel] Can a userspace tool to read the Embedded Controller get
 added to acpica sources?
Date: Fri, 27 Aug 2010 15:31:21 +0200
Message-ID: <201008271531.21589.trenn@suse.de>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5752969045758238792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

next kernel will have EC read/write support.
A userspace tool is needed to make use of the interface.

As the Embedded Controller is tightly bound to ACPI
(devel/debugging/testing), the best package this tool would fit in is =

acpica.
A new package is not worth it, if not accepted I'd still package
this together with acpica.rpm. But if it gets included, there is some
guarantee that this binary shows up in the same way on different
distros.

Thus it would be great if this code:
ftp://ftp.suse.com/pub/people/trenn/sources/ec/ec_access.c
Could get integrated into the acpica repository.

Not sure where this best could fit into if accepted, possibly:
acpica/source/os_specific/ec_access
or
acpica/source/os_specific/tools/ec_access
?

Thanks,

     Thomas

--===============5752969045758238792==--

