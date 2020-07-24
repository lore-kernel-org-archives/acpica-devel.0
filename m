Content-Type: multipart/mixed; boundary="===============0764589645466648461=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH] trivial: acpi: replace some bitshifts with BIT
 macro
Date: Fri, 24 Jul 2020 16:50:55 +0000
Message-ID: <BYAPR11MB32563CE55D8019DA86861A7387770@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 20200724184738.ce10d8db0bbe138e2b24f7a6@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0764589645466648461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Well, since BIT is a linux macro only, we can't use it in ACPICA, because t=
he code is compiler/environment independent.
Bob


-----Original Message-----
From: Garrit Franke <garritfranke(a)gmail.com> =

Sent: Friday, July 24, 2020 9:48 AM
To: Moore, Robert <robert.moore(a)intel.com>
Cc: Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; lenb(a)kernel.org; tr=
ivial(a)kernel.org; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; kerne=
l-janitors(a)vger.kernel.org
Subject: Re: [PATCH] trivial: acpi: replace some bitshifts with BIT macro

On Fri, 24 Jul 2020 16:29:14 +0000
"Moore, Robert" <robert.moore(a)intel.com> wrote:

> Where is "BIT" defined?

It is defined in multiple places (see include/vdso/bits.h for example), the=
refore I blatently assumed that it would be defined. I'm quite new to kerne=
l development, and I'm learning along the way. Thank you for pointing this =
out.

Would it make sense to copy this file to this drivers root, or is it not wo=
rth the effort?

Thanks for your time
Garrit
--===============0764589645466648461==--

