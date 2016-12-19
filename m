Content-Type: multipart/mixed; boundary="===============6012634165618590059=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] acpi: Fix format string type mistakes
Date: Mon, 19 Dec 2016 21:45:44 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E547D9A@ORSMSX110.amr.corp.intel.com>
In-Reply-To: CAGXu5jKc35OzaPCR-f34THEkmE4ZbPP-cW2BVFzTgPYVmT_5dw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6012634165618590059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: keescook(a)google.com [mailto:keescook(a)google.com] On Behalf Of K=
ees
> Cook
> Sent: Friday, December 16, 2016 3:04 PM
> To: Rafael J. Wysocki <rafael(a)kernel.org>
> Cc: Moore, Robert <robert.moore(a)intel.com>; Linux Kernel Mailing List
> <linux-kernel(a)vger.kernel.org>; Zheng, Lv <lv.zheng(a)intel.com>; Wysoc=
ki,
> Rafael J <rafael.j.wysocki(a)intel.com>; Len Brown <lenb(a)kernel.org>; A=
CPI
> Devel Maling List <linux-acpi(a)vger.kernel.org>; Emese Revfy
> <re.emese(a)gmail.com>; devel(a)acpica.org
> Subject: Re: [PATCH] acpi: Fix format string type mistakes
> =

> On Fri, Dec 16, 2016 at 2:36 PM, Rafael J. Wysocki <rafael(a)kernel.org>
> wrote:
> > On Fri, Dec 16, 2016 at 10:51 PM, Kees Cook <keescook(a)chromium.org>
> wrote:
> >> From: Emese Revfy <re.emese(a)gmail.com>
> >>
> >> This adds the missing __printf attribute which allows compile time
> >> format string checking (and will be used by the coming initify gcc
> >> plugin). Additionally, this fixes the warnings exposed by the
> attribute.
> >>
> >> Signed-off-by: Emese Revfy <re.emese(a)gmail.com>
> >> [kees: split scsi/acpi, merged attr and fix, new commit messages]
> >> Signed-off-by: Kees Cook <keescook(a)chromium.org>
> >
> > This modifies code that we get from an external projiect (ACPICA) and
> > the bugs should be fixed in there in the first place.
> =

> Who should get CCed?
> =

> > Moreover, I'm not sure if adding __printf in acpiosxf.h is a good
> idea.
> =

> Why not? This is going to be needed by the initify plugin to do correct
> detection of what's being passed around to functions...
> =


[Moore, Robert] It's compiler-dependent.

> -Kees
> =

> --
> Kees Cook
> Nexus Security

--===============6012634165618590059==--

