Content-Type: multipart/mixed; boundary="===============4740466888209883832=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v2 0/8] ACPI: unify _UID handling as integer
Date: Sat, 10 Sep 2022 18:32:10 +0200
Message-ID: <CAJZ5v0j5FO+OcX6VdiR-tuDCrHFwErquxzZGUu3ZLQ1G57T-+Q@mail.gmail.com>
In-Reply-To: YxnwMLvgQAPOkeeK@smile.fi.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4740466888209883832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 8, 2022 at 3:38 PM Andy Shevchenko
<andriy.shevchenko(a)linux.intel.com> wrote:
>
> On Thu, Sep 08, 2022 at 04:29:02PM +0300, Andy Shevchenko wrote:
> > This series is about unification on how we handle ACPI _UID when
> > it's known to be an integer-in-the-string.
> >
> > The idea of merging either all via ACPI tree, or taking ACPI stuff
> > for the v6.1 while the rest may be picked up later on by respective
> > maintainers separately
>
> >(currently all depends on Wolfram, other
> > patches have got the tags from the maintainers).
>
> I stand corrected, the perf patch is not tagged yet.
>
> > Partially compile-tested (x86-64).

Tentatively applied as 6.1 material.

If there are updates, we'll make changes as they go.

Thanks!
--===============4740466888209883832==--

