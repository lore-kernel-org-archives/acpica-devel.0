Content-Type: multipart/mixed; boundary="===============5200094050508948858=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] [PATCH] x86: HPET force enable for Soekris net6501
Date: Mon, 17 Feb 2014 20:25:18 +0100
Message-ID: <4233973.R9Tf84J4Ne@skinner>
In-Reply-To: 53025956.40505@zytor.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5200094050508948858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Monday, February 17, 2014 10:47:50 AM H. Peter Anvin wrote:
> On 02/17/2014 10:23 AM, Thomas Renninger wrote:
> > Easiest I can think of instead of trying to modify RSDP or similar, is
> > to still pass the tables via unzipped, glued cpio which the kernel
> > can access early. The same way it is done for current ACPI table
> > overriding
> > and early microcode passing.
> =

> We shouldn't *need* an RSDP and RSDT/XSDT, though, since all they are
> are pointers to the actual tables.  Rather than hacking around it we
> should probably just fix the fundamental problem.

That is what I described.
If something similar what I wrote gets implemented, you can simply
add ACPI tables to initrd as described here:
Documentation/acpi/initrd_table_override.txt
and if BIOS already provides them they get overridden, otherwise
they get added.

     Thomas

--===============5200094050508948858==--

