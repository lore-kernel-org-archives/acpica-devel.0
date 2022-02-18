Content-Type: multipart/mixed; boundary="===============7849634250446512349=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH][next] ACPICA: iASL: Replace zero-length array
 with flexible-array member
Date: Fri, 18 Feb 2022 20:47:15 +0100
Message-ID: <CAJZ5v0j0+oAG3s_ZrhmG+1WaTTc-hogiKv9ZuKDiCkH8JtZ0YA@mail.gmail.com>
In-Reply-To: 202202161236.FBD5D268@keescook
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7849634250446512349==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 16, 2022 at 9:36 PM Kees Cook <keescook(a)chromium.org> wrote:
>
> On Wed, Feb 16, 2022 at 02:32:40PM -0600, Gustavo A. R. Silva wrote:
> > There is a regular need in the kernel to provide a way to declare
> > having a dynamically sized set of trailing elements in a structure.
> > Kernel code should always use =E2=80=9Cflexible array members=E2=80=9D[=
1] for these
> > cases. The older style of one-element or zero-length arrays should
> > no longer be used[2].
> >
> > [1] https://en.wikipedia.org/wiki/Flexible_array_member
> > [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-=
length-and-one-element-arrays
> >
> > Link: https://github.com/KSPP/linux/issues/78
> > Signed-off-by: Gustavo A. R. Silva <gustavoars(a)kernel.org>
>
> Reviewed-by: Kees Cook <keescook(a)chromium.org>

I've created an upstream ACPICA pull request for this change, thanks!
--===============7849634250446512349==--

