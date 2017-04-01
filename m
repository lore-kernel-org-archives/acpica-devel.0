Content-Type: multipart/mixed; boundary="===============7904201179483971101=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: use designated initializers
Date: Sat, 01 Apr 2017 00:45:32 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E58F104@ORSMSX110.amr.corp.intel.com>
In-Reply-To: CAGXu5j+S28jat1E+wNDE710cQ9qcHnkM12qi3HActrw-imwQGw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7904201179483971101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Acpica is built with many compilers, even very old ones. It runs on at leas=
t 12 known operating systems, and very probably more.

I'm sorry, but no, we are not going to start adding compiler-specific ifdef=
s/code in the base ACPICA code.

I don't care what you do in the Linux-specific or gcc-specific headers, how=
ever. If this breaks a customer build, we (you) will hear about it rather q=
uickly.

Bob


--===============7904201179483971101==--

