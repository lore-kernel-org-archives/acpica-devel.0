Content-Type: multipart/mixed; boundary="===============2117055970375201466=="
MIME-Version: 1.0
From: Andi Kleen <andi at firstfloor.org>
Subject: Re: [Devel] acpi_os_read_memory() from interrupt context
Date: Wed, 11 Aug 2010 11:25:25 +0200
Message-ID: <87y6cd7b7e.fsf@basil.nowhere.org>
In-Reply-To: 201008041119.23633.bjorn.helgaas@hp.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2117055970375201466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Bjorn Helgaas <bjorn.helgaas(a)hp.com> writes:
> require some redesign in the CA.
>
> Any suggestions?

pre-map. Ying developed a pre map infrastructure for this for the ERST
code. You could probably reuse that.

-Andi

-- =

ak(a)linux.intel.com -- Speaking for myself only.

--===============2117055970375201466==--

