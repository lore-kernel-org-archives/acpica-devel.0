Content-Type: multipart/mixed; boundary="===============1347790805521646459=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPICA: Common: Fix a typo
Date: Mon, 25 Jan 2021 17:37:03 +0100
Message-ID: <CAJZ5v0hooTkVjXg-Emsr49aqV3PukEJYSJw03PEXxPYtSu+j0w@mail.gmail.com>
In-Reply-To: 20210124113252.733716-1-christophe.jaillet@wanadoo.fr
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1347790805521646459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 24, 2021 at 12:35 PM Christophe JAILLET
<christophe.jaillet(a)wanadoo.fr> wrote:
>
> This module is 'cmfsize', not 'cfsize'.
> Fix it.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet(a)wanadoo.fr>

I'm leaving this one to Bob and Erik, thanks!

> ---
>  tools/power/acpi/common/cmfsize.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/power/acpi/common/cmfsize.c b/tools/power/acpi/common/=
cmfsize.c
> index 9ea2c0aeb86c..185b8c588e1d 100644
> --- a/tools/power/acpi/common/cmfsize.c
> +++ b/tools/power/acpi/common/cmfsize.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
>  /***********************************************************************=
*******
>   *
> - * Module Name: cfsize - Common get file size function
> + * Module Name: cmfsize - Common get file size function
>   *
>   * Copyright (C) 2000 - 2021, Intel Corp.
>   *
> --
> 2.27.0
>
--===============1347790805521646459==--

