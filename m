Content-Type: multipart/mixed; boundary="===============1934272171437568484=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: [Devel] FreeBSD _KERNEL Build
Date: Sun, 24 Jul 2016 01:24:14 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC063AC@SHSMSX101.ccr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1934272171437568484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Jung-uk Kim

I have a pull request here to correct EFI builds of ACPICA tools:
https://github.com/acpica/acpica/pull/154

The original branch is here:
https://github.com/zetalog/acpica
acpica-efi2 branch.

Especially, in this pull request,
I've moved <stdarg.h> to acgcc.h.
And moved ACPI_USE_SYSTEM_CLIBRARY/ACPI_USE_STANDARD_HEADERS =

Definitions to the very first lines of the platform specific files.
(in order to:
1. allow EFI builds to define both via Makefiles
2. allow Clib header inclusions to be protected in the following style for =
-nostdinc targets:
#ifdef ACPI_USE_STANDARD_HEADER
#include <unistd.h>
#endif

However I didn't do anything to the BSD headers.
It seems some of them using <machine/stdarg.h> instead of <stdarg.h>.
I guess they are the same file so nothing will be broken, but I'm not sure.

Could you help to confirm if the will break BSD builds?
Especially _KERNEL builds.
Thanks in advance. =


Best regards
-Lv

--===============1934272171437568484==--

