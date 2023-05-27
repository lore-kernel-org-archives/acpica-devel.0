Return-Path: <torvalds@linuxfoundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5A07383AFF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86A2383B23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1685216447; x=1687808447;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JcPeHx5b/Toh4k4OiN1qju08d1gnox4XXe9rs4ZJHI=;
 b=HS85D+fa8En0kAfgbIdtZbnJWVN+pLW/RsaR6iiYL9zYMAISN/x7diI/1QKaMpt5b4
 AiwiYg9Ra9YLQH46Y0SB2a585HHUjboNwyuKVqrR3JJcuptVR5UcOwuLteekmYRgeBF0
 iZiKr9tbTVoblVg3Jaaqb82n83cFmiu0oxvz4=
MIME-Version: 1.0
References: <efd6f2d4-547c-1378-1faa-53c044dbd297@gmail.com>
 <CAG8fp8SaHi0X-tZHnji_93wBADp1_=brjauWCVXuLaG7iP0p=A@mail.gmail.com>
 <CAG8fp8QXoEkndCzyaYZmg6+ZrszKOfh_YSi0o2_weV7y1_xYkQ@mail.gmail.com>
 <CAMj1kXGjkKK-oHm64Y9P-AbYQWd9jnEdsNucRbY_-7mgJ_4yAA@mail.gmail.com>
 <CAG8fp8ReYLaNYO9LYE1WeeSDg1pO1hz3f-8_WPZkLVWbzzyCvg@mail.gmail.com>
 <CAMj1kXEGTJufrrcrqjjKqeR-FN+nLsbzx8xGgO+gPfc2YPsy2w@mail.gmail.com>
In-Reply-To: <CAMj1kXEGTJufrrcrqjjKqeR-FN+nLsbzx8xGgO+gPfc2YPsy2w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 May 2023 12:40:29 -0700
Message-ID: <CAHk-=whKJoDVuUNhf3U7gPXKu4EeZRv-iwwhL0prQ=U3n8PHiw@mail.gmail.com>
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
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Akihiro Suda <suda.kyoto@gmail.com>, linux-efi@vger.kernel.org, Linux Regressions <regressions@lists.linux.dev>, Linux x86 <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Stable <stable@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Jianmin Lv <lvjianmin@loongson.cn>, Bagas Sanjaya <bagasdotme@gmail.com>, Linux ACPICA <acpica-devel@lists.linuxfoundation.org>, Huacai Chen <chenhuacai@loongson.cn>

On Sat, May 27, 2023 at 11:42=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> Yes, that makes the most sense. If the existing virtual machine BIOS
> has a hardcoded check that the EFI stub version is 1.0 even if it does
> not boot via EFI to begin with, I don't see how we can reasonably
> treat this as a regression that needs fixing on the Linux side.

Well, we consider firmware issues to be the same as any hardware
issue. If firmware has a bug that requires us to do things certain
ways, that's really no different from hardware that requires some
insane init sequence.

So why not just say that LINUX_EFISTUB_MINOR_VERSION should be 0, and
just add the comment that versioning doesn't work?

I'm not sure why this was tied into always enabling the initrd command
line loader.

Numbered version checks are a fundamentally broken and stupid concept
anyway. Don't do them. Just leave it at zero, and maybe some day there
is a sane model that actually has a bitfield of capabilities and
requirements.

              Linus
