Content-Type: multipart/mixed; boundary="===============2043908566040881507=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: [Devel] Prefer 32 bit addresses over 64 ones
Date: Thu, 28 Oct 2010 14:56:15 +0200
Message-ID: <201010281456.15908.trenn@suse.de>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2043908566040881507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

you probably know this already, I just stumbled
over this:
http://download.microsoft.com/download/5/b/9/5b97017b-e28a-4bae-ba48-174cf4=
7d23cd/CPA002_WH06.ppt

We prefer 32 bit addresses over 64 ones if they are
not equal, which helped for some broken BIOSes
from pre-Vista times.
Now it's the other way around:

If the FADT Revision field is > 2, =

Windows Vista will use the extended =

64-bit addresses in the FADT
X_FIRMWARE_CTRL and X_DSDT
Extended addresses of ACPI fixed hardware
X_PM1a_EVT_BLK, etc.

Just for info...

    Thomas

--===============2043908566040881507==--

