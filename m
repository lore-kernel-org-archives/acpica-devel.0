Content-Type: multipart/mixed; boundary="===============0777537649622421164=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] PATCH proposal removing use of strtoul in
 events/evgpeinit.c
Date: Fri, 11 Sep 2015 15:49:48 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D34459F@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 55F2F4FA.3030504@netbsd.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0777537649622421164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Agreed

> -----Original Message-----
> From: Richard PALO [mailto:richard(a)netbsd.org]
> Sent: Friday, September 11, 2015 8:36 AM
> To: Moore, Robert; devel(a)acpica.org
> Cc: Box, David E; Zheng, Lv
> Subject: Re: [Devel] PATCH proposal removing use of strtoul in
> events/evgpeinit.c
> =

> Le 11/09/15 16:57, Moore, Robert a =C3=A9crit :
> > Not to mention that every compiler is different, and you need to put
> your own "ignore error" types of things in your platform-specific or
> compiler-specific header. Such is the price of attempting to build OS- and
> compiler-independent code.
> >
> =

> >>> not to mention kludge needed when linting global crosschecks in the
> >>> illumos gate, for the later
> >>>> "/home/richard/src/illumos-gate/usr/src/common/acpica/components/di
> >>>> s pa tcher/dsobject.c", line 351: warning: function returns value
> >>>> which is sometimes ignored: memcpy (E_FUNC_RET_MAYBE_IGNORED2)
> >>>> "/home/richard/src/illumos-gate/usr/src/common/acpica/components/di
> >>>> s pa tcher/dsutils.c", line 608: warning: function returns value
> >>>> which is sometimes ignored: strncpy (E_FUNC_RET_MAYBE_IGNORED2)
> >>>> "/home/richard/src/illumos-gate/usr/src/common/acpica/components/ex
> >>>> e cu ter/exmisc.c", line 370: warning: function returns value which
> >>>> is sometimes ignored: strcpy (E_FUNC_RET_MAYBE_IGNORED2)
> >>>> "/home/richard/src/illumos-gate/usr/src/common/acpica/components/ex
> >>>> e cu ter/exnames.c", line 224: warning: function returns value
> >>>> which is sometimes ignored: strcat (E_FUNC_RET_MAYBE_IGNORED2)
> >>>
> =

> ? Sorry, I guess I don't follow. for example, posix, and various c
> standards define memcpy as
> >  void *memcpy(void *restrict s1, const void *restrict s2, size_t n);
> =

> the first reference above, components/dispatcher/dsobject.c does:
> =

> > 349         if (ByteList)
> > 350         {
> > 351             memcpy (ObjDesc->Buffer.Pointer, ByteList->Named.Data,
> > 352                          ByteListLength);
> > 353         }
> =

> what would make most static analyzers happy is a simple void cast --
> (void) memcpy(...)
> =

> Then, at least, ignoring the return value is explicit instead of possibly
> just being forgotten..
> =

> This should also be the most portable form of C (at least for the cases at
> hand).
> =


Agreed. Some of these have apparently slipped in, so we will put it on our =
list.


> There are numerous examples of this sort of thing over and above what I
> listed above...
> =

> cheers,
> --
> Richard PALO


--===============0777537649622421164==--

