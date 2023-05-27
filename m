Return-Path: <ardb@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4995F401B7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8240740112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685224123;
 bh=Vm5/RmUcnEK73zeR+XV3P+M+ZQNPsr35kUTRoGQH2Ak=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=IlRR9K/iSeiwMxZsnkKtAKw+FzR8F640PZNRtZy4jL2z8G/LQxeUKTZZulxRs5pwb
 vzHJP2IAivX7dq6e9dhIttasrfBUJSSyQWmLAg9dAO1y0OQxh2oNxwFcj7o0sjkzqM
 cTq5roEB18oDJURqIhgIGZF934TMnZoNcHzo1y8HukJ6nhUQQauwg9Zu/hMCExfG75
 Q3kPVMR8yBhX4Uw7bHwbmJaBCdZl4iB1yezgggdCU4fWg7mwxuHXt+MLc5Tn2gQZfF
 CwgZEjnLYrgCzZmz5bsynQeirqOJlIu547xVJ4ohsFRrqr7r6y7DryfyUqcsGyJIa/
 sEl7eXRxr/mNg==
MIME-Version: 1.0
References: <efd6f2d4-547c-1378-1faa-53c044dbd297@gmail.com>
 <CAG8fp8SaHi0X-tZHnji_93wBADp1_=brjauWCVXuLaG7iP0p=A@mail.gmail.com>
 <CAG8fp8QXoEkndCzyaYZmg6+ZrszKOfh_YSi0o2_weV7y1_xYkQ@mail.gmail.com>
 <CAMj1kXGjkKK-oHm64Y9P-AbYQWd9jnEdsNucRbY_-7mgJ_4yAA@mail.gmail.com>
 <CAG8fp8ReYLaNYO9LYE1WeeSDg1pO1hz3f-8_WPZkLVWbzzyCvg@mail.gmail.com>
 <CAMj1kXEGTJufrrcrqjjKqeR-FN+nLsbzx8xGgO+gPfc2YPsy2w@mail.gmail.com>
 <CAHk-=whKJoDVuUNhf3U7gPXKu4EeZRv-iwwhL0prQ=U3n8PHiw@mail.gmail.com>
In-Reply-To: <CAHk-=whKJoDVuUNhf3U7gPXKu4EeZRv-iwwhL0prQ=U3n8PHiw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 27 May 2023 23:48:29 +0200
Message-ID: <CAMj1kXHmRYkmJyfW5+B74dPyA1+yHvt9majpZ9Ut1p0i8zM+DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] mix of ACPICA regression and EFISTUB regression
 (Was: kernel >= v6.2 no longer boots on Apple's Virtualization.framework
 (x86_64); likely to be related to ACPICA)
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Akihiro Suda <suda.kyoto@gmail.com>, linux-efi@vger.kernel.org, Linux Regressions <regressions@lists.linux.dev>, Linux x86 <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Stable <stable@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Jianmin Lv <lvjianmin@loongson.cn>, Bagas Sanjaya <bagasdotme@gmail.com>, Linux ACPICA <acpica-devel@lists.linuxfoundation.org>, Huacai Chen <chenhuacai@loongson.cn>

On Sat, 27 May 2023 at 21:40, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, May 27, 2023 at 11:42=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org>=
 wrote:
> >
> > Yes, that makes the most sense. If the existing virtual machine BIOS
> > has a hardcoded check that the EFI stub version is 1.0 even if it does
> > not boot via EFI to begin with, I don't see how we can reasonably
> > treat this as a regression that needs fixing on the Linux side.
>
> Well, we consider firmware issues to be the same as any hardware
> issue. If firmware has a bug that requires us to do things certain
> ways, that's really no different from hardware that requires some
> insane init sequence.
>
> So why not just say that LINUX_EFISTUB_MINOR_VERSION should be 0, and
> just add the comment that versioning doesn't work?
>

Fair enough. Or we could try bumping it from v1.1 to v2.0 (or v3.0 if
we make it a bit mask).

Akihiro, would you mind checking if changing the major/minor to any of
these values results in the same problem?

Unfortunately, the only data point we have is that a non-EFI
bootloader (which is unlikely to carry a PE/COFF loader) needs the
byte at that specific offset to be 0x0, and we really have no idea
why, or whether we could hit this in other ways (i.e., by changing the
PE/COFF header to comply with new MS requirements for secure boot,
which is another thing that is in progress)

> I'm not sure why this was tied into always enabling the initrd command
> line loader.
>

For x86, it doesn't actually make a difference, but on other
architectures, the command line initrd=3D loader could be disabled, but
that possibility was removed. The idea was that by bumping the version
to v1.1 at the same time, generic EFI loaders would be able to
identify this capability without arch specific conditionals in the
logic.

Currently, GRUB and systemd-stub check this version field, but only
for v1.0 or higher. Upstream GRUB  switched to this generic version of
the EFI loader just this week, but does not actually use initrd=3D at
all for EFI boot (on any architecture).

> Numbered version checks are a fundamentally broken and stupid concept
> anyway. Don't do them. Just leave it at zero, and maybe some day there
> is a sane model that actually has a bitfield of capabilities and
> requirements.
>

Yeah, maybe you're right. Currently, only a single feature is tied to
LINUX_EFISTUB_MAJOR_VERSION=3D=3D1 (LoadFile2 support for initrd loading),
and this PE/COFF version field has no meaning to UEFI firmware itself,
so we could simply treat these fields as bit masks if we wanted to
(and setting the initrd command line loader bit for x86 would be
redundant anyway)

But not being able to freely set such a bit because some rarely used
non-EFI BIOS implementation imposes requirements on the contents of
the EFI specific image header is rather disappointing.
