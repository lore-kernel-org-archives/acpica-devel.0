Content-Type: multipart/mixed; boundary="===============7348591967899086601=="
MIME-Version: 1.0
From: Andriy Gapon <avg at FreeBSD.org>
Subject: Re: [Devel] ref-counting races?
Date: Fri, 09 Nov 2012 18:03:11 +0200
Message-ID: <509D293F.4090105@FreeBSD.org>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E346BBFD4B@ORSMSX101.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7348591967899086601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

on 09/11/2012 17:50 Moore, Robert said the following:
> Of course, that is not to say that there isn't a hole somewhere. However,=
 we
> have not seen any similar issues from other host operating systems at this
> time.

Unfortunately it is not easy to reproduce the condition and it is very hard=
 to
debug it postmortem.
Maybe my conjecture is completely wrong and the problem is not in the refer=
ence
counting in general, but in some code which does double-free or alike by mi=
stake.

-- =

Andriy Gapon

--===============7348591967899086601==--

