Content-Type: multipart/mixed; boundary="===============5452049864842326212=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] PATCH proposal removing use of strtoul in
 events/evgpeinit.c
Date: Fri, 11 Sep 2015 14:53:54 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D34455B@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 55F2B361.6060404@netbsd.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5452049864842326212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Richard PALO [mailto:richard(a)netbsd.org]
> Sent: Friday, September 11, 2015 3:57 AM
> To: Moore, Robert; devel(a)acpica.org
> Subject: Re: [Devel] PATCH proposal removing use of strtoul in
> events/evgpeinit.c
> =

> Le 09/09/15 20:01, Moore, Robert a =C3=A9crit :
> > I've got a better question:
> >
> >> which is to say that strtoul, strictly speaking is unavailable in the
> >> Solaris kernel (excepting kmdb).
> >
> > Why not?
> >
> >
> =

> Given numerous other build problems involving ACPI_DISASSEMLER in _KERNEL,
> those are disabled for now (issues with MpSave* which I believe other
> platforms are experiencing as well, just like the visibility of
> AcpiUtConvertStringToUuid).
> =

> I believe other uses of strtoul may tend to be concentrated there...
> =

> As to the history of decisions involving ddi_strtoul/strtoul, a veteran
> sun kernel developer needs to be asked...
> =

> In any event, currently the wrapper around ddi_strtoul seems reasonable
> enough.
> =

> BTW, have things been linted recently (we use sun studio lint)?

Every lint is different, unfortunately. And there are lots of things that w=
e need to ignore, which in itself depends on which lint. So, it is mostly u=
seless for us.


> =

> I had to add the following to acsolaris.h
> > #ifdef __SUNPRO_C
> > #pragma error_messages(off, E_STATIC_UNUSED) #pragma
> > error_messages(off, E_FUNC_ARG_UNUSED) #pragma error_messages(off,
> > E_END_OF_LOOP_CODE_NOT_REACHED) #pragma error_messages(off,
> > E_FUNC_RET_MAYBE_IGNORED2) #endif
> =

> not to mention kludge needed when linting global crosschecks in the
> illumos gate, for the later
> > "/home/richard/src/illumos-gate/usr/src/common/acpica/components/dispa
> > tcher/dsobject.c", line 351: warning: function returns value which is
> > sometimes ignored: memcpy (E_FUNC_RET_MAYBE_IGNORED2)
> > "/home/richard/src/illumos-gate/usr/src/common/acpica/components/dispa
> > tcher/dsutils.c", line 608: warning: function returns value which is
> > sometimes ignored: strncpy (E_FUNC_RET_MAYBE_IGNORED2)
> > "/home/richard/src/illumos-gate/usr/src/common/acpica/components/execu
> > ter/exmisc.c", line 370: warning: function returns value which is
> > sometimes ignored: strcpy (E_FUNC_RET_MAYBE_IGNORED2)
> > "/home/richard/src/illumos-gate/usr/src/common/acpica/components/execu
> > ter/exnames.c", line 224: warning: function returns value which is
> > sometimes ignored: strcat (E_FUNC_RET_MAYBE_IGNORED2)
> =

> --
> Richard PALO


--===============5452049864842326212==--

