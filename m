Content-Type: multipart/mixed; boundary="===============7893291009343621242=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [RFC] proposed patch for some segfaults encountered
Date: Tue, 02 Jun 2015 16:26:56 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F130A@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 556CC7AA.4010000@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7893291009343621242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Please send the ssdt9.dat file, it wasn't attached.
Bob


> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Al Stone
> Sent: Monday, June 01, 2015 1:59 PM
> To: devel(a)acpica.org
> Subject: [Devel] [RFC] proposed patch for some segfaults encountered
> =

> It's not clear to me that this is the correct way to handle a segfault
> that was reported to me via Fedora.
> =

> Using the ssdt9.dat file attached, a simple "iasl -d ssdt9.dat" will
> segfault around calls to AcpiDmPromoteTarget -- and it turns out that the
> Target pointer being passed into that function was sometimes null but not
> being checked in the calling function, AcpiDmCheckForSymbolicOpcode.  So,
> this patch adds in some checks for null pointers and can now get through
> this particular problem.
> =

> However, I did not study AcpiDmCheckForSymbolicOpcode long enough to
> determine if the Target pointer in that function should or should not ever
> be null.  So, this patch fixes this issue, but it may not be the proper
> long term solution.
> =

> --
> ciao,
> al
> -----------------------------------
> Al Stone
> Software Engineer
> Red Hat, Inc.
> ahs3(a)redhat.com
> -----------------------------------

--===============7893291009343621242==--

