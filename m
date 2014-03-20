Content-Type: multipart/mixed; boundary="===============6651892923795193798=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: Re: [Devel] Possible issue with iasl on big endian machines.
Date: Thu, 20 Mar 2014 11:19:57 -0600
Message-ID: <532B233D.3040608@redhat.com>
In-Reply-To: 1395335011.3100.7.camel@localhost.localdomain
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6651892923795193798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/20/2014 11:03 AM, Marcel Apfelbaum wrote:
> Hi,
>
> Should iasl running on a big endian machine be able to
> disassemble a DSDT(and any other acpi table) taken from a
> little endian machine?
>
> I tried to do it and I receive:
> Error [...] TableHeader length [0xBB040000] greater than the input file s=
ize [0x4BB].
> As you can see the length bytes are swapped.
>
> The question is, shouldn't it work, ACPI protocol being always little-end=
ian?
>
> Thanks,
> Marcel
>
>
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel
>

Which version of iasl are you using?  If you're using the version
straight from ACPICA, it needs patching to handle big-endian.

If you're using one of the recent Fedora/Debian versions, they have
been patched for big-endian support, but of course there could be an
issue with those patches.

Regardless, the ACPI data _should_ be in little-endian form.

-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============6651892923795193798==--

