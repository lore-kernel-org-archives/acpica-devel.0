Return-Path: <suda.kyoto@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 78DD642085
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6451C42071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685212480; x=1687804480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TzEHMKPZ9fj/sSTbrr++Mdb6c3+qROgUK5bksEJMA/A=;
 b=R7EkvIHbW6jHBVSEZdi6c6B8Oco6L/mnlGh6SNeKvBZY5TdmZ4uOQMe+4AESV6+Fb0
 qgIEMxWUsz8b5JVcjGc0njrbo1Mz6VQFCyFYgF8jyycqmyajiRiddSEP6kZjV8Em4F9J
 PGZfidDmbXXdC60HuxaWa72oab7RbVjJeiTr9z28CWMXISaNj9y3OpcqQJiML+kotLUB
 1J7UwAXdeiFXqoEyJH/mcgJyxJZkkq6cnohLtaFAhrt8G+7+TUYUTisJeBES40VKoNFZ
 h6dwN8Fgfb2An2qRF5KLceAj/aEuR0FMEwkiSRBx7zIUeotkF+fEwrCcYZuTNJgrShQ0
 /LLA==
MIME-Version: 1.0
References: <efd6f2d4-547c-1378-1faa-53c044dbd297@gmail.com>
 <CAG8fp8SaHi0X-tZHnji_93wBADp1_=brjauWCVXuLaG7iP0p=A@mail.gmail.com>
 <CAG8fp8QXoEkndCzyaYZmg6+ZrszKOfh_YSi0o2_weV7y1_xYkQ@mail.gmail.com>
 <CAMj1kXGjkKK-oHm64Y9P-AbYQWd9jnEdsNucRbY_-7mgJ_4yAA@mail.gmail.com>
In-Reply-To: <CAMj1kXGjkKK-oHm64Y9P-AbYQWd9jnEdsNucRbY_-7mgJ_4yAA@mail.gmail.com>
From: Akihiro Suda <suda.kyoto@gmail.com>
Date: Sun, 28 May 2023 03:34:28 +0900
Message-ID: <CAG8fp8ReYLaNYO9LYE1WeeSDg1pO1hz3f-8_WPZkLVWbzzyCvg@mail.gmail.com>
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
Cc: linux-efi@vger.kernel.org, Linux Regressions <regressions@lists.linux.dev>, Linux x86 <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Stable <stable@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Jianmin Lv <lvjianmin@loongson.cn>, Bagas Sanjaya <bagasdotme@gmail.com>, Linux ACPICA <acpica-devel@lists.linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Huacai Chen <chenhuacai@loongson.cn>

> Are you using OVMF? Which versions of qemu and OVMF are you using?

I'm using Apple's Virtualization.framework, not QEMU.

It doesn't use UEFI when it directly loads bzImage.
( dmesg: https://bugzilla.kernel.org/attachment.cgi?id=3D304323 )

Despite that, it still expects LINUX_EFISTUB_MINOR_VERSION
(include/linux/pe.h) referred from arch/x86/boot/header.S to be 0x0.
I confirmed that the kernel can boot by just setting
LINUX_EFISTUB_MINOR_VERSION to 0x0.

Would it be possible to revert the LINUX_EFISTUB_MINOR_VERSION value
(not the actual code) to 0x0?
Or will it break something else?

Anyway, I'll try to make a request to Apple to remove the
LINUX_EFISTUB_MINOR_VERSION check.

2023=E5=B9=B45=E6=9C=8828=E6=97=A5(=E6=97=A5) 3:04 Ard Biesheuvel <ardb@ker=
nel.org>:
>
> On Sat, 27 May 2023 at 20:00, Akihiro Suda <suda.kyoto@gmail.com> wrote:
> >
> > [Resending as a plain text email]
> >
> > Turned out that this is a mixture of an ACPICA issue and an EFISTUB iss=
ue.
> >
> > Kernel v6.2 can boot by reverting the *both* of the following two commi=
ts:
> > - 5c62d5aab8752e5ee7bfbe75ed6060db1c787f98 "ACPICA: Events: Support
> > fixed PCIe wake event"
> > - e346bebbd36b1576a3335331fed61bb48c6d8823 "efi: libstub: Always
> > enable initrd command line loader and bump version"
> >
> > Kernel v6.3 can boot by just reverting e346bebb, as 5c62d5a has been
> > already reverted in 8e41e0a575664d26bb87e012c39435c4c3914ed9.
> > The situation is the same for v6.4-rc3 too.
> >
> > Note that in my test I let Virtualization.framework directly load
> > bzImage without GRUB (akin to `qemu-system-x86_64 -kernel bzImage`).
> > Apparently, reverting e346bebb is not necessary for loading bzImage via=
 GRUB.
> >
>
> Are you using OVMF? Which versions of qemu and OVMF are you using?
