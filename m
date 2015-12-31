Content-Type: multipart/mixed; boundary="===============7669300657119936782=="
MIME-Version: 1.0
From: Colin Ian King <colin.king at canonical.com>
Subject: Re: [Devel] Upgraded Haiku to ACPICA 20151218,
 now crashes on various systems
Date: Thu, 31 Dec 2015 18:29:36 +0000
Message-ID: <56857410.8090602@canonical.com>
In-Reply-To: CAEesM74MUHvo=izm78N8s4Qb9dDHbW8UZYO5gB-_QQZG00XSZw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7669300657119936782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 31/12/15 18:05, waddlesplash wrote:
> Hi,
> =

> I'm one of the developers of the Haiku operating system, which uses
> ACPICA as the backend for its ACPI bus manager. We recently updated to
> ACPICA 20151218 from 20150818 (merge commit: [1], update commit: [2]).
> However, since the update, a select few systems now crash on boot [3].
> I and the other developers are a bit stumped as to what's going on
> here.
> =

> Is this our fault in some way? Or is ACPICA to blame here?

When I upgraded fwts to using ACPICA 20151218 I had some crashes on
startup and I tracked it down to having now to set
AcpiGbl_OverrideDefaultRegionHandlers =3D TRUE before
AcpiInitializeSubsystem() is called.  Maybe your issue is related to
that change.

Colin

> =

> -waddlesplash
> =

> [1]: http://cgit.haiku-os.org/haiku/commit/?id=3D4dffc0abb95bbf20160457b4=
0cd2466393836b0e&context=3D3&ignorews=3D1&ss=3D0
> [2]: http://cgit.haiku-os.org/haiku/commit/?id=3Dd4fb4ebd675bcb3b6a3b307b=
172cdafd43b58710
> [3]: https://dev.haiku-os.org/ticket/12549#ticket
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel
> =



--===============7669300657119936782==--

