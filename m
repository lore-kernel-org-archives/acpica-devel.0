Content-Type: multipart/mixed; boundary="===============2326908948346683519=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v4 15/15] ipu3-cio2: Add cio2-bridge to ipu3-cio2
 driver
Date: Mon, 04 Jan 2021 13:37:59 +0000
Message-ID: <CAHp75VcU7DcRZD_eK+B1-CX7tVtsR5YLPdrA6oULk187xhApCw@mail.gmail.com>
In-Reply-To: 2f64873d-0413-3614-34e2-139b4a4d9da6@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2326908948346683519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 4, 2021 at 3:02 PM Daniel Scally <djrscally(a)gmail.com> wrote:
> On 04/01/2021 12:09, Andy Shevchenko wrote:
> > On Sun, Jan 03, 2021 at 11:12:35PM +0000, Daniel Scally wrote:

...

> >> +#define NODE_SENSOR(_HID, _PROPS)           \
> >> +    ((const struct software_node) {         \
> >> +            .name =3D _HID,                   \
> >> +            .properties =3D _PROPS,           \
> >> +    })
> >> +
> >> +#define NODE_PORT(_PORT, _SENSOR_NODE)              \
> >> +    ((const struct software_node) {         \
> >> +            .name =3D _PORT,                  \
> >> +            .parent =3D _SENSOR_NODE,         \
> >> +    })
> >> +
> >> +#define NODE_ENDPOINT(_EP, _PORT, _PROPS)   \
> >> +    ((const struct software_node) {         \
> >> +            .name =3D _EP,                    \
> >> +            .parent =3D _PORT,                \
> >> +            .properties =3D _PROPS,           \
> >> +    })
> > In all three I didn't get why you need outer parentheses. Without them =
it will
> > be well defined compound literal and should work as is.
> The code works fine, but checkpatch complains that macros with complex
> values should be enclosed in parentheses. I guess now that I'm more
> familiar with the code I'd call that a false-positive though, as nowhere
> else in the kernel that I've seen encloses them the same way.

I guess it is yet another false positive from checkpatch.
I would ignore its complaints.

-- =

With Best Regards,
Andy Shevchenko
--===============2326908948346683519==--

