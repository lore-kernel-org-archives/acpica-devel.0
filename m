Content-Type: multipart/mixed; boundary="===============8740020492746389318=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 05/14] software_node: unregister software_nodes
 in reverse order
Date: Mon, 28 Dec 2020 12:15:26 +0200
Message-ID: <20201228101526.GV4077@smile.fi.intel.com>
In-Reply-To: fcb07dea193b4b99b11f2a8e684d8acf@AcuMS.aculab.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8740020492746389318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 24, 2020 at 06:36:10PM +0000, David Laight wrote:
> From: Daniel Scally =

> > Sent: 24 December 2020 14:14
> ...
> > >> The array will be unwound in reverse order (i.e. last entry first). =
If
> > >> any member of the array is a child of another member then the child =
must
> > > children ?
> > =

> > Yes, you are right of course.
> =

> The second 'child' is a back-reference to 'any member' so is singular
> so 'child' is correct.
> 'the child' could be replaced by 'it'
> =

> You could have:
>    If any members of the array are children of another member then the
>    children must appear later in the list.

Works for me!
Dan, can you consider David's proposal?

-- =

With Best Regards,
Andy Shevchenko


--===============8740020492746389318==--

