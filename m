Content-Type: multipart/mixed; boundary="===============9123450578508615364=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v1 1/1] ACPI: utils: Fix reference counting in
 for_each_acpi_dev_match()
Date: Wed, 26 May 2021 11:35:13 +0300
Message-ID: <CAHp75VeON6netzJAw0YR=wQBBabvQNpqSpY8MwDSxsTabpMZow@mail.gmail.com>
In-Reply-To: 50903d09-96f8-0dc9-a1f7-21bf1543b15a@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9123450578508615364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 26, 2021 at 1:29 AM Daniel Scally <djrscally(a)gmail.com> wrote:
> On 20/05/2021 20:40, Rafael J. Wysocki wrote:
> > On Thu, May 20, 2021 at 9:13 PM Rafael J. Wysocki <rafael(a)kernel.org>=
 wrote:
> >> On Wed, May 19, 2021 at 11:19 PM Andy Shevchenko
> >> <andy.shevchenko(a)gmail.com> wrote:
> >>> Currently it's possible to iterate over the dangling pointer in case =
the device
> >>> suddenly disappears. This may happen becase callers put it at the end=
 of a loop.
> >>>
> >>> Instead, let's move that call inside acpi_dev_get_next_match_dev().
> >> Not really.
> > OK, I see what you want to achieve and the macro is actually buggy,
> > because it leaves unbalanced references behind.
>
>
> Yeah; I guess the originally intended use (which was "get all these
> devices") doesn't really tally with the naming or with the operation of
> similar functions in the kernel like the fwnode_handle ops; sorry about
> that. Anyway; I think Andy's fix is the right way to do it, so the
> calling code's responsible for holding onto a reference if it wants to
> keep it.

I think we need to postpone the fix till v5.14-rc1 is out. It appears
that some code has been changed in EFI and media subsystems so that
patch will be in conflict with.


-- =

With Best Regards,
Andy Shevchenko
--===============9123450578508615364==--

