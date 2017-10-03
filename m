Content-Type: multipart/mixed; boundary="===============8226676965693213084=="
MIME-Version: 1.0
From: Colin Ian King <colin.king at canonical.com>
Subject: Re: [Devel] [PATCH 15/18] acpi: use ARRAY_SIZE
Date: Tue, 03 Oct 2017 13:34:23 +0100
Message-ID: <e0ab5224-1120-4b06-b625-822491d6b926@canonical.com>
In-Reply-To: 5437275.MVdmGJ04h3@aspire.rjw.lan
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8226676965693213084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/10/17 12:39, Rafael J. Wysocki wrote:
> On Tuesday, October 3, 2017 3:16:22 AM CEST J=C3=A9r=C3=A9my Lefaure wrot=
e:
>> On Mon, 02 Oct 2017 14:27:52 +0200
>> "Rafael J. Wysocki" <rjw(a)rjwysocki.net> wrote:
>>
>>> ACPICA is soewhat special code, though and I'm not taking or ACKing pat=
ches
>>> for it directly as a rule.
>>>
>>> For one, I'm not sure if ACPICA can use ARRAY_SIZE at all.
>> Why is it special code that can't use ARRAY_SIZE ? Is it because this
>> macro is defined in linux/kernel.h ?

However, ACPICA does have ACPI_ARRAY_LENGTH(x), see source/include/actypes.h

> =

> Basically, yes.
> =

> ACPICA is a separate project and the kernel acquires its source code from
> the upstream (which is used by other OSes too).  That is not the case for
> any other code in the kernel I know about.
> =

> =

> We strive to keep the ACPICA code in the kernel as close to the upstream =
as
> reasonably possible for maintenance reasons, so we avoid doing Linux-spec=
ific
> things in it.
> =

> As a rule of thumb, if you do cleanups like this one, better avoid the AC=
PICA
> code. :-)
> =

> Thanks,
> Rafael
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel
> =



--===============8226676965693213084==--

