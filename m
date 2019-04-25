Content-Type: multipart/mixed; boundary="===============1985628038416450507=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] Update to acpica (20190405 broke VirtualBox, patch avail)
Date: Thu, 25 Apr 2019 11:41:29 +0200
Message-ID: <1784526.72sEhOmWi1@house>
In-Reply-To: 0f9f8411-a5a3-617d-cf22-2429074fab55@lwfinger.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1985628038416450507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Larry,

+ acpica list
+ Erik, author of the patch

while there is a tested patch, there has not been a pull request or a mail
patch submission on the acpcia mailing list to get the fix mainline.

I like to wait until the patch is submitted and reviewed, best accepted.

Once this has happened, I can grab it.
Or better, if the patch is unmodified, you may want to create a submit
request via the Open SUSE Build Servcie (OBS) with a tiny changelog mention=
ing
the patch and I can simply accept it.

Thanks Larry for the bug identifying, testing and all the details!

     Thomas

Background:


On Monday, April 22, 2019 11:03:09 PM CEST Larry Finger wrote:
> Thomas,
> =

> I am writing to you as the maintainer of the acpica package.
> =

> The recent update to acpica-20190405 broke iASL for the VirtualBox packag=
e.
> With it, Windows 7 VM's fail with a Blue Screen complaining about the BIO=
S.
> As far as I know, no other OS fails. The bug was posted as bsc#1132941,
> which has been assigned to me.
> =

> There is a discussion of this bug at
> https://github.com/acpica/acpica/issues/462, where a patch was posted. I
> checked out the package at home:lwfinger:branches:openSUSE:Factory/acpica,
> added the patch, and built the package locally using osc. I then applied
> that package to a rebuild of VB. Once I did that, then Windows 7 VM's work
> again.
> =

> I have committed my changes to my copy of acpica. How do you want to proc=
eed
> from here? Should I send an MR on that project? Please advise.
> =

> Larry



--===============1985628038416450507==--

