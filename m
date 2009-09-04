Content-Type: multipart/mixed; boundary="===============1771460297512519596=="
MIME-Version: 1.0
From: Joerg Sonnenberger <joerg at britannica.bec.de>
Subject: Re: [Devel] Correct ACPI setup sequence
Date: Fri, 04 Sep 2009 22:25:24 +0200
Message-ID: <20090904202524.GB8443@britannica.bec.de>
In-Reply-To: 4911F71203A09E4D9981D27F9D8308583748B99D@orsmsx503.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1771460297512519596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2009 at 01:23:30PM -0700, Moore, Robert wrote:
> >- If the MADT exists and contains IOAPICs, I can expect \_PIC to be
> >  successful.
> =

> =

> I don't know the answer to this.

What would be the most sensible behavior if it fails and the MADT listed
an entry for the SCI?

> >PS: ACPI 4.0 has a bad cross-reference in 5.2.12.4, 5.2.10.8 no longer
> >exists. Who is the right person for that?
> =

> =

> I just forwarded this to the ACPI 4.0 editor. Thanks. You can send any
> such errors directly to me. We own the ACPI specification here.

Good to know, thanks.

Joerg

--===============1771460297512519596==--

