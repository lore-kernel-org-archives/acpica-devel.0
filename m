Content-Type: multipart/mixed; boundary="===============2474398716719458817=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] handle Linux systems without /dev/mem
Date: Tue, 09 Jun 2015 06:16:43 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88027264E2@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 556F9F23.6020808@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2474398716719458817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

The patch is wrong.
If we want to dump tables without accessing /dev/mem, we have acpidump -c.
The only problem here is:
There is a bug that even with -c specified, acpidump cannot work without ac=
cessing /dev/mem.
So we shouldn't introduce a new portable acpidump OSL but should fix the ve=
ry problem.

We've noticed the similar issue in handling this kernel bug:
https://bugzilla.kernel.org/show_bug.cgi?id=3D87971
The fix for this issue can be found here:
https://github.com/acpica/acpica/pull/77

Thanks and best regards
-Lv

> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Al Stone
> Sent: Thursday, June 04, 2015 8:43 AM
> =

> On arm64 systems in particular, the use of /dev/mem is not recommended.  =
The
> contents may or may not be valid depending on the memory map being used, =
since
> they are not standardized.
> =

> The attached patch will cause arm64 (aka ARMv8 or AArch64) Linux systems =
to
> use a new file called source/os_specific/service_layers/oslinuxtbl_nodevm=
em.c
> (a subset of the oslinuxtbl.c code) that allows acpidump to read all ACPI
> tables from /sys/firmware/acpi instead of from /dev/mem.  This will help =
ensure
> that the tables retrieved are the ones actually being used and that their
> content is correct.
> =

> This patch applies on top of the 20150515 version, and I have included it=
 in
> the 20150515-2 versions of the Fedora and Debian packages.  I've tried the
> resulting acpidump on x86, x86_64 and arm64 systems and it seems to work =
well.
> =

> Signed-off-by: Al Stone <ahs3(a)redhat.com>
> =

> --
> ciao,
> al
> -----------------------------------
> Al Stone
> Software Engineer
> Red Hat, Inc.
> ahs3(a)redhat.com
> -----------------------------------

--===============2474398716719458817==--

