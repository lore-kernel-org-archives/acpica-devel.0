Return-Path: <ardb@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D78E042544
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9486E42537
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685212954;
 bh=ILLm7sjS2AUbgX5ZU3V6OvdwznjKgFXN4a/oNoiqZNE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ko296JPYuVFKnFXg6zT/SBM2ETEQvnpXHE02ZJ5lj/jFgH1CQ/iscv3rUc+k6Gt7l
 g4/041h0EKdaiOhCXmivi3jcZb9EoYv3wejv91mGvJWvhuJyBqTIOiw44pNcnGqlxg
 XEvUgxSy2tLe4XHafjoQbwLoi7SmfTfWLrXPZMob3jzFx6xKV5jpUyUGX0qDwLpbU3
 V84IHyfhIERxhybK/DEfB5Y744iPHcS51ioQmBlShhlLLEovoZq36h658eYcAewxBa
 l66kwrTLq/9IghYfpWxutlQf7gRWaGIpohT/bqOJmCHxFFo+OsOWsGnPBJDuHrDiqY
 yhVs4BcghCoYQ==
MIME-Version: 1.0
References: <efd6f2d4-547c-1378-1faa-53c044dbd297@gmail.com>
 <CAG8fp8SaHi0X-tZHnji_93wBADp1_=brjauWCVXuLaG7iP0p=A@mail.gmail.com>
 <CAG8fp8QXoEkndCzyaYZmg6+ZrszKOfh_YSi0o2_weV7y1_xYkQ@mail.gmail.com>
 <CAMj1kXGjkKK-oHm64Y9P-AbYQWd9jnEdsNucRbY_-7mgJ_4yAA@mail.gmail.com>
 <CAG8fp8ReYLaNYO9LYE1WeeSDg1pO1hz3f-8_WPZkLVWbzzyCvg@mail.gmail.com>
In-Reply-To: <CAG8fp8ReYLaNYO9LYE1WeeSDg1pO1hz3f-8_WPZkLVWbzzyCvg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 27 May 2023 20:42:21 +0200
Message-ID: <CAMj1kXEGTJufrrcrqjjKqeR-FN+nLsbzx8xGgO+gPfc2YPsy2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Akihiro Suda <suda.kyoto@gmail.com>
Cc: linux-efi@vger.kernel.org, Linux Regressions <regressions@lists.linux.dev>, Linux x86 <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Stable <stable@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Jianmin Lv <lvjianmin@loongson.cn>, Bagas Sanjaya <bagasdotme@gmail.com>, Linux ACPICA <acpica-devel@lists.linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Huacai Chen <chenhuacai@loongson.cn>

On Sat, 27 May 2023 at 20:34, Akihiro Suda <suda.kyoto@gmail.com> wrote:
>
> > Are you using OVMF? Which versions of qemu and OVMF are you using?
>
> I'm using Apple's Virtualization.framework, not QEMU.
>
> It doesn't use UEFI when it directly loads bzImage.
> ( dmesg: https://bugzilla.kernel.org/attachment.cgi?id=304323 )
>
> Despite that, it still expects LINUX_EFISTUB_MINOR_VERSION
> (include/linux/pe.h) referred from arch/x86/boot/header.S to be 0x0.
> I confirmed that the kernel can boot by just setting
> LINUX_EFISTUB_MINOR_VERSION to 0x0.
>

Thanks for checking that, that is very helpful/

> Would it be possible to revert the LINUX_EFISTUB_MINOR_VERSION value
> (not the actual code) to 0x0?
> Or will it break something else?
>
> Anyway, I'll try to make a request to Apple to remove the
> LINUX_EFISTUB_MINOR_VERSION check.
>

Yes, that makes the most sense. If the existing virtual machine BIOS
has a hardcoded check that the EFI stub version is 1.0 even if it does
not boot via EFI to begin with, I don't see how we can reasonably
treat this as a regression that needs fixing on the Linux side.

The version bump to PE image version v1.1 sets a baseline across all
Linux archifectures that can boot via EFI that initrd loading is
supported via the command line as well as via the LoadFile2 protocol.
Reverting that would substantially reduce the value of having this
identification embedded into the image.
