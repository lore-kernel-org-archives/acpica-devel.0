Content-Type: multipart/mixed; boundary="===============3260868757457027557=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH 4.20 regression fix] ACPICA: Fix handling of
 buffer-size in acpi_ex_write_data_to_field()
Date: Thu, 29 Nov 2018 12:57:14 +0100
Message-ID: <CAJZ5v0hTtUojmLsdzUGAEhyfAhzJgf6A8ZP8YCBatLDa_gjEcA@mail.gmail.com>
In-Reply-To: CAO-hwJKyEp9Um5=kehM0Ps-pa6dUUxs5oz7f4ogWE6m+Tqac5w@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3260868757457027557==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2018 at 12:10 PM Benjamin Tissoires <btissoir(a)redhat.com>=
 wrote:
>
> On Wed, Nov 28, 2018 at 6:48 PM Hans de Goede <hdegoede(a)redhat.com> wro=
te:
> >
> > Hi,
> >
> > On 28-11-18 18:18, Schmauss, Erik wrote:
> >
> > <big snip>
> >
> > >> Repeating myself I'm somewhat surprised by your and Bob's objections
> > >> against my approach, since it gets acpica out of the game of having =
to guess
> > >> what the LEN field means / when to use then LEN field and I expected=
 that
> > >> both you and Bob would actually be quite happy to no longer having t=
o do
> > >> that.
> > > This is a good point..
> > >
> > > Bob and I have talked it over. We'll accept your patch as long as you=
r surface 3 also
> > > boots and behaves as expected with this patch
> >
> > I don't have a surface 3, I got involved in the whole surface 3 discuss=
ion
> > because I was trying to help to get the battery monitoring support for =
it
> > upstream, but I don't have one myself.
> >
> > Still I don't see how this can break the surface 3, since we simply end=
 up
> > potentially copying more data to the tmp-buffer then before my patch and
> > if the Surface 3's opregion driver does not expect that data to be there
> > it will simply ignore it.
> >
> > I will ask Benjamin Tissoires to test 4.20 + my patch on his Surface 3
> > to double-check, but in the mean time I believe it is really time to get
> > this fix into 4.20 now.
>
> Thanks Hans for all of this work. And thanks everybody for taking care
> of this problem.
>
> I just tested the patch on top of 4.20-rc, and I can confirm that this
> doesn't regress on the Surface 3.
> So it is fine from my HW point of view to apply it.

Thank you for the confirmation.

I'm going to send a pull request including this patch later today.

--===============3260868757457027557==--

