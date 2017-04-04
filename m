Content-Type: multipart/mixed; boundary="===============6054400164637314282=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: use designated initializers
Date: Tue, 04 Apr 2017 15:02:08 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E58F7BB@ORSMSX110.amr.corp.intel.com>
In-Reply-To: CAGXu5jJLQmxEcG6nLKn6fsib5meNpw4y1ZLO2F4ezA+jqF-6DA@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6054400164637314282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: keescook(a)google.com [mailto:keescook(a)google.com] On Behalf Of K=
ees
> Cook
> Sent: Monday, April 3, 2017 10:29 AM
> To: Moore, Robert <robert.moore(a)intel.com>
> Cc: Zheng, Lv <lv.zheng(a)intel.com>; linux-kernel(a)vger.kernel.org;
> Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; Len Brown
> <lenb(a)kernel.org>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> Subject: Re: [PATCH] ACPICA: use designated initializers
> =

> On Fri, Mar 31, 2017 at 5:45 PM, Moore, Robert <robert.moore(a)intel.com>
> wrote:
> > Acpica is built with many compilers, even very old ones. It runs on at
> least 12 known operating systems, and very probably more.
> >
> > I'm sorry, but no, we are not going to start adding compiler-specific
> ifdefs/code in the base ACPICA code.
> >
> > I don't care what you do in the Linux-specific or gcc-specific
> headers, however. If this breaks a customer build, we (you) will hear
> about it rather quickly.
> =

> Since the change is specific to the one place ACPICA uses an all-
> function-pointer structure, I made the change local:
> =

> https://github.com/acpica/acpica/pull/248
> =

> would you rather this is in the .h files instead?
> =

> -Kees
> =

> --
> Kees Cook
> Pixel Security




[Moore, Robert] =


I have some questions about this entire issue:

+ * Some compilers can handle designated initializers, which is needed  =

+ * under Linux kernel builds for structures that are entirely function  =

  * pointers.  =


I don't understand why this is coming up now, since ACPICA has been integra=
ted with Linux for something like the last 15 years. It's the "which is nee=
ded under Linux kernel builds" wording that concerns me the most. Are you s=
aying that the ACPICA build for Linux is broken and does not work?

Further, there are quite a few similar dispatch tables in ACPICA, why are t=
hese not a problem?

Bob




--===============6054400164637314282==--

