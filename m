Content-Type: multipart/mixed; boundary="===============6142316573275914000=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH v1 1/1] ACPI: Replace kernel.h with the necessary
 inclusions
Date: Tue, 23 Nov 2021 19:03:21 +0100
Message-ID: <CAJZ5v0iz-rRV8dktYCe5L-u_zG3vp5S2ZuF=gjrsfgLgcQSnow@mail.gmail.com>
In-Reply-To: YZ0XXoH05cUQ+UMj@smile.fi.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6142316573275914000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 23, 2021 at 5:31 PM Andy Shevchenko
<andriy.shevchenko(a)linux.intel.com> wrote:
>
> On Wed, Nov 10, 2021 at 01:16:40PM +0200, Andy Shevchenko wrote:
> > When kernel.h is used in the headers it adds a lot into dependency hell,
> > especially when there are circular dependencies are involved.
> >
> > Replace kernel.h inclusion with the list of what is really being used.
>
> Anybody any comments on this? I really want to shrink kernel.h usage in
> headers rather sooner than later...

Patch applied as 5.17 material, thanks!
--===============6142316573275914000==--

