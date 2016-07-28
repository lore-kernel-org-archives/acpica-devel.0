Content-Type: multipart/mixed; boundary="===============4414402824176901795=="
MIME-Version: 1.0
From: Rudolf Marek <r.marek at assembler.cz>
Subject: Re: [Devel] AcpiOsAllocate with zero argument
Date: Thu, 28 Jul 2016 10:06:36 +0200
Message-ID: <5799BD0C.6060706@assembler.cz>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E883BC07BF4@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4414402824176901795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lv,

Thanks for the quick response. I checked the Linux kmalloc() and also UEFI =

AllocatePool() and they accept the zero size. No NULL is returned.

Therefore I would like to ask if it can be documented in the Programming Ma=
nual =

that zero size should be OK and
non-NULL value should be returned. Otherwise, it may happen that if =

implementation of  AcpiOsAllocate() returns NULL and maybe there is some ch=
eck =

in the ACPICA code which will complain and break things.

As for the free() you mean that NULL should be ignored?

Thanks
Rudolf


--===============4414402824176901795==--

