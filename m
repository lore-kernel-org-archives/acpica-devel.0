Return-Path: <ardb@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D901683BD4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2DD2083BC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685210647;
 bh=+2DbhJhzR6mabBBjwgNw5rSlRJnUbBZQeef15wiBopk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=gFJRY4ToEHKyLjvVmlgO5FefszpZZ86hBwg3vRKCuiWtAbtLHlt2bhg6XNvAv8Op1
 8a3pVpOAeIaPYzO7BZdGtdWjoSq4EZJU9/lfVogOL2C77x1MNXdSJ/OIK7krB5djWi
 0BkGrXOAVUGvF0wAwK9DWfC01qet5cQSvcxur9JhzTDoMKDqluC/SM+s/Hi0q6fBLt
 vwuSEc8CigkxLTprxWOgjS/jQjGeM98mndcoSEmcP4eUsN+TnIRk5TZJrpb1uRrb5o
 T+td+EMgfDDNxubj22cYrV1tvzPFQaMpfZ84TLhrgsKrF9zb9YiH5KTxMDXKZcKL0h
 sPB2Ux1BEyVPQ==
MIME-Version: 1.0
References: <efd6f2d4-547c-1378-1faa-53c044dbd297@gmail.com>
 <CAG8fp8SaHi0X-tZHnji_93wBADp1_=brjauWCVXuLaG7iP0p=A@mail.gmail.com>
 <CAG8fp8QXoEkndCzyaYZmg6+ZrszKOfh_YSi0o2_weV7y1_xYkQ@mail.gmail.com>
In-Reply-To: <CAG8fp8QXoEkndCzyaYZmg6+ZrszKOfh_YSi0o2_weV7y1_xYkQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 27 May 2023 20:03:53 +0200
Message-ID: <CAMj1kXGjkKK-oHm64Y9P-AbYQWd9jnEdsNucRbY_-7mgJ_4yAA@mail.gmail.com>
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

On Sat, 27 May 2023 at 20:00, Akihiro Suda <suda.kyoto@gmail.com> wrote:
>
> [Resending as a plain text email]
>
> Turned out that this is a mixture of an ACPICA issue and an EFISTUB issue.
>
> Kernel v6.2 can boot by reverting the *both* of the following two commits:
> - 5c62d5aab8752e5ee7bfbe75ed6060db1c787f98 "ACPICA: Events: Support
> fixed PCIe wake event"
> - e346bebbd36b1576a3335331fed61bb48c6d8823 "efi: libstub: Always
> enable initrd command line loader and bump version"
>
> Kernel v6.3 can boot by just reverting e346bebb, as 5c62d5a has been
> already reverted in 8e41e0a575664d26bb87e012c39435c4c3914ed9.
> The situation is the same for v6.4-rc3 too.
>
> Note that in my test I let Virtualization.framework directly load
> bzImage without GRUB (akin to `qemu-system-x86_64 -kernel bzImage`).
> Apparently, reverting e346bebb is not necessary for loading bzImage via GRUB.
>

Are you using OVMF? Which versions of qemu and OVMF are you using?
