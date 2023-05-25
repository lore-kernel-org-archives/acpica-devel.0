Return-Path: <bagasdotme@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 45DCB4270B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 148C942709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685018816; x=1687610816;
 h=content-transfer-encoding:cc:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rsp+ooFC9A3hWuO7X2DuDaXuAcIvAuRjOpppctZ/9JY=;
 b=gW6oLronwV/BZTKxBkSlNXGKnDhG+vEHmEEGuQ0FnkkDYMOh5Nt5TzaKflaTKeXaPT
 2zIKYGCW4kuGOg+VCFRObTwcU4z7X6yeG7zmY3Kd8YZmHDVf1e0pg3mAwN491wwn7/lw
 51RZ/7hm0jFDaBw7B5lZEm+jjgOVR63wkjtl5raBpLa/i5zfWeNmfjH/mjHSBt7KG7iG
 IFE0sWX+M8PVFE4KDZgnTIGUxoq2/UVWALPQHsnEd210SqGS8/yAJoEI8w2ex3Vk4tqK
 v/V3ZkuO22NCCppngswi5QkURJ98qI/1fYHCqeKczrkxxhxzsH2ikmX8P3y+uPoP02yO
 sjdg==
Message-ID: <efd6f2d4-547c-1378-1faa-53c044dbd297@gmail.com>
Date: Thu, 25 May 2023 19:46:47 +0700
MIME-Version: 1.0
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Acpica-devel] Fwd: kernel >= v6.2 no longer boots on Apple's
 Virtualization.framework (x86_64); likely to be related to ACPICA
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Regressions <regressions@lists.linux.dev>, Linux x86 <x86@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux ACPICA <acpica-devel@lists.linuxfoundation.org>, Linux Stable <stable@vger.kernel.org>
Cc: Akihiro Suda <suda.kyoto@gmail.com>, Robert Moore <robert.moore@intel.com>, Jianmin Lv <lvjianmin@loongson.cn>, Linus Torvalds <torvalds@linux-foundation.org>, Huacai Chen <chenhuacai@loongson.cn>

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Linux kernel >= v6.2 no longer boots on Apple's Virtualization.framework (x86_64).
> 
> It is reported that the issue is not reproducible on ARM64: https://github.com/lima-vm/lima/issues/1577#issuecomment-1561577694
> 
> 
> ## Reproduction
> - Checkout the kernel repo, and run `make defconfig bzImage`.
> 
> - Create an initrd (see the attached `initrd-example.txt`)
> 
> - Transfer the bzImage and initrd to an Intel Mac.
> 
> - On Mac, download `RunningLinuxInAVirtualMachine.zip` from https://developer.apple.com/documentation/virtualization/running_linux_in_a_virtual_machine , and build the `LinuxVirtualMachine` binary with Xcode.
>   Building this binary with Xcode requires logging in to Apple.
>   If you do not like logging in, a third party equivalent such as https://github.com/Code-Hex/vz/blob/v3.0.6/example/linux/main.go can be used.
> 
> - Run `LinuxVirtualMachine /tmp/bzImage /tmp/initrd.img`.
>   v6.1 successfully boots into the busybox shell.
>   v6.2 just hangs before printing something in the console.
> 
> 
> ## Tested versions
> ```
> v6.1: OK
> ...
> v6.1.0-rc2-00002-g60f2096b59bc (included in v6.2-rc1): OK
> v6.1.0-rc2-00003-g5c62d5aab875 (included in v6.2-rc1): NG <-- This commit caused a regression
> ...
> v6.2-rc1: NG
> ...
> v6.2: NG
> ...
> v6.3.0-rc7-00181-g8e41e0a57566 (included in v6.3): NG     <-- Reverts 5c62d5aab875 but still NG
> ...
> v6.3: NG
> v6.4-rc3: NG
> ```
> 
> Tested on MacBookPro 2020 (Intel(R) Core(TM) i7-1068NG7 CPU @ 2.30GHz) running macOS 13.4.
> 
> 
> The issue seems a regression in [5c62d5aab8752e5ee7bfbe75ed6060db1c787f98](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5c62d5aab8752e5ee7bfbe75ed6060db1c787f98) "ACPICA: Events: Support fixed PCIe wake event".
> 
> This commit was introduced in v6.2-rc1, and apparently reverted in v6.3 ([8e41e0a575664d26bb87e012c39435c4c3914ed9](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e41e0a575664d26bb87e012c39435c4c3914ed9)).
> However, v6.3 and the latest v6.4-rc3 still don't boot.

See bugzilla for the full thread.

Interestingly, this regression still occurs despite the culprit is
reverted in 8e41e0a575664d ("Revert "ACPICA: Events: Support fixed
PCIe wake event""), so this (obviously) isn't wake-on-lan regression,
but rather early boot one.

Also, the reporter can't provide dmesg log (forget to attach serial
console?).

Anyway, I'm adding it to regzbot:

#regzbot introduced: 5c62d5aab8752e https://bugzilla.kernel.org/show_bug.cgi?id=217485
#regzbot title: Linux v6.2+ (x86_64) no longer boots on Apple's Virtualization framework (ACPICA issue)

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217485

-- 
An old man doll... just what I always wanted! - Clara
