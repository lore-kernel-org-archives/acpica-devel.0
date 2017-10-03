Content-Type: multipart/mixed; boundary="===============1717158692729143326=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 15/18] acpi: use ARRAY_SIZE
Date: Tue, 03 Oct 2017 16:38:17 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E613032@ORSMSX110.amr.corp.intel.com>
In-Reply-To: CAJZ5v0j+UPDJrWfiZzE26=PGSzmqZnQwMwCkei9N8+M1JkEmyg@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1717158692729143326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Rafael J.
> Wysocki
> Sent: Tuesday, October 3, 2017 9:05 AM
> To: Colin Ian King <colin.king(a)canonical.com>
> Cc: Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; Rafael J. Wysocki
> <rjw(a)rjwysocki.net>; Linux Kernel Mailing List <linux-
> kernel(a)vger.kernel.org>; ACPI Devel Maling List <linux-
> acpi(a)vger.kernel.org>; J=C3=A9r=C3=A9my Lefaure <jeremy.lefaure(a)lse.e=
pita.fr>;
> devel(a)acpica.org
> Subject: Re: [Devel] [PATCH 15/18] acpi: use ARRAY_SIZE
> =

> On Tue, Oct 3, 2017 at 2:34 PM, Colin Ian King
> <colin.king(a)canonical.com> wrote:
> > On 03/10/17 12:39, Rafael J. Wysocki wrote:
> >> On Tuesday, October 3, 2017 3:16:22 AM CEST J=C3=A9r=C3=A9my Lefaure w=
rote:
> >>> On Mon, 02 Oct 2017 14:27:52 +0200
> >>> "Rafael J. Wysocki" <rjw(a)rjwysocki.net> wrote:
> >>>
> >>>> ACPICA is soewhat special code, though and I'm not taking or ACKing
> >>>> patches for it directly as a rule.
> >>>>
> >>>> For one, I'm not sure if ACPICA can use ARRAY_SIZE at all.
> >>> Why is it special code that can't use ARRAY_SIZE ? Is it because
> >>> this macro is defined in linux/kernel.h ?
> >
> > However, ACPICA does have ACPI_ARRAY_LENGTH(x), see
> > source/include/actypes.h
> =

> Fair enough, but that cleanup should go in via ACPICA upstream anyway.
[Moore, Robert] =


This would be acceptable, as long as it will work properly in the cases tha=
t were presented earlier (using ARRAY_SIZE).


> =

> Thanks,
> Rafael
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============1717158692729143326==--

