Content-Type: multipart/mixed; boundary="===============1510694946728505969=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] How to build acpica on Mac?
Date: Tue, 10 Jan 2012 16:33:13 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3256CF3A3@ORSMSX101.amr.corp.intel.com>
In-Reply-To: CAHceRrhW-x_hLqwWLzVbUWcDksMU_4VzQSszYOXZcV-FSfkJPg@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1510694946728505969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

You should be able to grab the source from the git tree, and use the generi=
c unix makefiles under generate/unix.

Need to set __APPLE__ for all compiles.
Bob


> -----Original Message-----
> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On
> Behalf Of Liang Qi
> Sent: Tuesday, January 10, 2012 2:21 AM
> To: devel(a)acpica.org
> Subject: [Devel] How to build acpica on Mac?
> =

> I only found Linux in OS field in bugzilla, could you let me know
> where I could found the info about building acpica(at least iasl) on
> Mac?
> =

> Regards,
> Liang
> =

> --
> http://www.qiliang.net
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> http://lists.acpica.org/listinfo/devel

--===============1510694946728505969==--

