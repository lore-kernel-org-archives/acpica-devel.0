Content-Type: multipart/mixed; boundary="===============0724877292800851673=="
MIME-Version: 1.0
From: Seraphime Kirkovski <kirkseraph at gmail.com>
Subject: Re: [Devel] [PATCH] acpi:  acpica:  dsutils: fixanoff-by-one index
Date: Wed, 07 Jun 2017 19:18:14 +0200
Message-ID: <20170607171814.zjvrikbjonp5n3gd@macchiaveli>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37E5BF38C@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0724877292800851673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 03:14:46PM +0000, Moore, Robert wrote:
> I believe that the rationale for this is that at that point in the code, =
it is *guaranteed* that there is at least one operand; therefore the -1 wou=
ld always be valid.
>
> In the end, we just deleted that call to =

> acpi_db_display_argument_object.
> =

> I don't know if this change has made it into Linux yet.
> =

The latest rc actually produces the UBSAN splat in my previous message.
So I suppose, I have some buggy hardware/firmware.

Thanks,
Seraph

--===============0724877292800851673==--

