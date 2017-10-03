Content-Type: multipart/mixed; boundary="===============1909015240458262955=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH 15/18] acpi: use ARRAY_SIZE
Date: Tue, 03 Oct 2017 18:04:46 +0200
Message-ID: <CAJZ5v0j+UPDJrWfiZzE26=PGSzmqZnQwMwCkei9N8+M1JkEmyg@mail.gmail.com>
In-Reply-To: e0ab5224-1120-4b06-b625-822491d6b926@canonical.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1909015240458262955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 3, 2017 at 2:34 PM, Colin Ian King <colin.king(a)canonical.com>=
 wrote:
> On 03/10/17 12:39, Rafael J. Wysocki wrote:
>> On Tuesday, October 3, 2017 3:16:22 AM CEST J=C3=A9r=C3=A9my Lefaure wro=
te:
>>> On Mon, 02 Oct 2017 14:27:52 +0200
>>> "Rafael J. Wysocki" <rjw(a)rjwysocki.net> wrote:
>>>
>>>> ACPICA is soewhat special code, though and I'm not taking or ACKing pa=
tches
>>>> for it directly as a rule.
>>>>
>>>> For one, I'm not sure if ACPICA can use ARRAY_SIZE at all.
>>> Why is it special code that can't use ARRAY_SIZE ? Is it because this
>>> macro is defined in linux/kernel.h ?
>
> However, ACPICA does have ACPI_ARRAY_LENGTH(x), see source/include/actype=
s.h

Fair enough, but that cleanup should go in via ACPICA upstream anyway.

Thanks,
Rafael

--===============1909015240458262955==--

