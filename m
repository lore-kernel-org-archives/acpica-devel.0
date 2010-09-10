Content-Type: multipart/mixed; boundary="===============4482543072311027171=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] False positive iasl compiler error on resource object?
Date: Fri, 10 Sep 2010 13:59:48 +0200
Message-ID: <201009101359.48393.trenn@suse.de>
In-Reply-To: 201009101133.31663.trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4482543072311027171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday 10 September 2010 11:33:31 Thomas Renninger wrote:
> I have a machine with a _CRS function which shows:
Looks like this (wrong?) check got introduced between:
20100304 (does not show the error) and
20100702 (shows this on quite some machines).

Version 20100806 still has this check.

       Thomas

--===============4482543072311027171==--

