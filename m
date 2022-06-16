Content-Type: multipart/mixed; boundary="===============2741048620816884879=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [RFC 2/4] ACPICA: Add \_SB.PC00,
 \SB.PCI0 to acpi_ns_early_initialize_devices()
Date: Thu, 16 Jun 2022 13:27:25 +0200
Message-ID: <CAHp75VeD5Ej3jvV=MtAB9fNxgyd8V8Wr+MZZnvbgzy2v3+eJmQ@mail.gmail.com>
In-Reply-To: e1647dae-cde2-868d-458d-ffe969203566@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2741048620816884879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 16, 2022 at 11:13 AM Hans de Goede <hdegoede(a)redhat.com> wrot=
e:
> On 6/15/22 23:31, Andy Shevchenko wrote:
> > On Wed, Jun 15, 2022 at 9:57 PM Hans de Goede <hdegoede(a)redhat.com> w=
rote:

...

> >> -       char path[ACPI_PATH_SEGMENT_LENGTH + 2];
> >> +       char path[ACPI_PATH_SEGMENT_LENGTH * 2 + 2];
> >
> > Strictly speaking this should be, IIUC,
> >
> > 1 + ACPI_PATH_SEGMENT_LENGTH + ACPI_NAMESEG_SIZE + 1
> >
> > \\ + path segment length (with a separator) + name + \0
> >
> > That said, it seems the original code adds 1 unneeded byte.
>
> Right I already knew I needed the " * 2" when writing the
> original code, so I decided to do things this way for KISS
> reasons.

Yeah, but then you don't need + 2, it should be +1.
I believe the initial use of ACPI_PATH_SEGMENT_LENGTH vs.
ACPI_NAMESEG_SIZE is a bit misleading.

> > Perhaps a comment in the code?
>
> I've added a comment to my local version now.
>
> After this thread has had some more time to gather feedback
> I will turn the ACPICA patches into a acpica github pull-req
> with the comment added.
>
> (or if necessary rework the entire series)


-- =

With Best Regards,
Andy Shevchenko
--===============2741048620816884879==--

