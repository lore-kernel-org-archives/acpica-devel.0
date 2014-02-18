Content-Type: multipart/mixed; boundary="===============3527134258227821885=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] [PATCH 1/4] ACPI: Provide support for ACPI table adding
 via OS
Date: Tue, 18 Feb 2014 19:44:26 +0100
Message-ID: <1568883.1dLS7uNIC1@skinner>
In-Reply-To: 7af8855f-8055-467c-89c0-bcab453f3969@email.android.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3527134258227821885==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, February 18, 2014 10:27:23 AM H. Peter Anvin wrote:
> Why can't you add SSDTs? It would be particularly useful.

There are 2 ways how ACPI tables get added:
   - Via pointer from a root table (XSDT or RSDT iirc)
   - Via load statement inside of ACPI context when ACPI BIOS
     code gets executed (iirc the physical address is passed).

The latter is only for SSDTs.
The problem is that you if you add an SSDT early, it might
have been intended for overriding when an SSDT gets dynamically
loaded later when the system is up which is particular useful as
well if you want to debug this specific BIOS table.

This could be workarounded via a boot param:
acpi=3Dallow_ssdt_adding
But this is not nice. Maybe someone has a more elegant idea.
Something could still be added if someone is really needing this.

     Thomas

--===============3527134258227821885==--

