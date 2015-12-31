Content-Type: multipart/mixed; boundary="===============3655565641298635610=="
MIME-Version: 1.0
From: waddlesplash <waddlesplash at gmail.com>
Subject: [Devel] Upgraded Haiku to ACPICA 20151218,
 now crashes on various systems
Date: Thu, 31 Dec 2015 13:05:00 -0500
Message-ID: <CAEesM74MUHvo=izm78N8s4Qb9dDHbW8UZYO5gB-_QQZG00XSZw@mail.gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3655565641298635610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm one of the developers of the Haiku operating system, which uses
ACPICA as the backend for its ACPI bus manager. We recently updated to
ACPICA 20151218 from 20150818 (merge commit: [1], update commit: [2]).
However, since the update, a select few systems now crash on boot [3].
I and the other developers are a bit stumped as to what's going on
here.

Is this our fault in some way? Or is ACPICA to blame here?

-waddlesplash

[1]: http://cgit.haiku-os.org/haiku/commit/?id=3D4dffc0abb95bbf20160457b40c=
d2466393836b0e&context=3D3&ignorews=3D1&ss=3D0
[2]: http://cgit.haiku-os.org/haiku/commit/?id=3Dd4fb4ebd675bcb3b6a3b307b17=
2cdafd43b58710
[3]: https://dev.haiku-os.org/ticket/12549#ticket

--===============3655565641298635610==--

