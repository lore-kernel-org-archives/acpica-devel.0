Return-Path: <suda.kyoto@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F287942529
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 94FD9424F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685210448; x=1687802448;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vt+eQc1s6uNliAWjWvTTIC49OP6lTjf/+SrnhMuXg0Y=;
 b=W0erXj+RPbnpcW7ElzKwBZltmDVaGYCicAuWq+OAyL0yswL83fU2bBCw+5eXBHMBTO
 +RwSKHFTEFeuLuIjfb4kPw8/OQmqHEma3ioO+QoWzUxz7DmxBkaeQM6hKZCcpg+SeMmP
 b1vPotZKQZwDq06In1Eml8jPsi1ziDMTFYK088eo3yKUr5xRTsS7UYmbucITaOMlcfu+
 zCo3LLCc/F7jdmA8wT4E4r6s49UPyR0mncJIbWV9/6XWwkFlQS5PcTy0VOO9aAwAlu/H
 nVj5/CC9mbJ/soa79kWzF0xTui7QLfPOpK9veEoQD6/Dv1Ofa49jffPiUcQkvFCC6aCq
 Wm4A==
MIME-Version: 1.0
References: <efd6f2d4-547c-1378-1faa-53c044dbd297@gmail.com>
 <CAG8fp8SaHi0X-tZHnji_93wBADp1_=brjauWCVXuLaG7iP0p=A@mail.gmail.com>
In-Reply-To: <CAG8fp8SaHi0X-tZHnji_93wBADp1_=brjauWCVXuLaG7iP0p=A@mail.gmail.com>
From: Akihiro Suda <suda.kyoto@gmail.com>
Date: Sun, 28 May 2023 03:00:37 +0900
Message-ID: <CAG8fp8QXoEkndCzyaYZmg6+ZrszKOfh_YSi0o2_weV7y1_xYkQ@mail.gmail.com>
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
To: Bagas Sanjaya <bagasdotme@gmail.com>, ardb@kernel.org, linux-efi@vger.kernel.org
Cc: Linux Regressions <regressions@lists.linux.dev>, Linux x86 <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Stable <stable@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Jianmin Lv <lvjianmin@loongson.cn>, Linux ACPICA <acpica-devel@lists.linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Huacai Chen <chenhuacai@loongson.cn>

[Resending as a plain text email]

Turned out that this is a mixture of an ACPICA issue and an EFISTUB issue.

Kernel v6.2 can boot by reverting the *both* of the following two commits:
- 5c62d5aab8752e5ee7bfbe75ed6060db1c787f98 "ACPICA: Events: Support
fixed PCIe wake event"
- e346bebbd36b1576a3335331fed61bb48c6d8823 "efi: libstub: Always
enable initrd command line loader and bump version"

Kernel v6.3 can boot by just reverting e346bebb, as 5c62d5a has been
already reverted in 8e41e0a575664d26bb87e012c39435c4c3914ed9.
The situation is the same for v6.4-rc3 too.

Note that in my test I let Virtualization.framework directly load
bzImage without GRUB (akin to `qemu-system-x86_64 -kernel bzImage`).
Apparently, reverting e346bebb is not necessary for loading bzImage via GRU=
B.


> Also, the reporter can't provide dmesg log (forget to attach serial conso=
le?).

Uploaded v6.1 dmesg in the bugzilla.
v6.2 dmesg can't be provided, as it hangs before printing something in
console=3Dhvc0.
(IIUC, console=3DttyS0 (RS-232C) is not implemented in Virtualization.frame=
work.)


> 2023=E5=B9=B45=E6=9C=8825=E6=97=A5(=E6=9C=A8) 21:46 Bagas Sanjaya <bagasd=
otme@gmail.com>:
>>
>> Hi,
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>
>> > Linux kernel >=3D v6.2 no longer boots on Apple's Virtualization.frame=
work (x86_64).
>> >
>> > It is reported that the issue is not reproducible on ARM64: https://gi=
thub.com/lima-vm/lima/issues/1577#issuecomment-1561577694
>> >
>> >
>> > ## Reproduction
>> > - Checkout the kernel repo, and run `make defconfig bzImage`.
>> >
>> > - Create an initrd (see the attached `initrd-example.txt`)
>> >
>> > - Transfer the bzImage and initrd to an Intel Mac.
>> >
>> > - On Mac, download `RunningLinuxInAVirtualMachine.zip` from https://de=
veloper.apple.com/documentation/virtualization/running_linux_in_a_virtual_m=
achine , and build the `LinuxVirtualMachine` binary with Xcode.
>> >   Building this binary with Xcode requires logging in to Apple.
>> >   If you do not like logging in, a third party equivalent such as http=
s://github.com/Code-Hex/vz/blob/v3.0.6/example/linux/main.go can be used.
>> >
>> > - Run `LinuxVirtualMachine /tmp/bzImage /tmp/initrd.img`.
>> >   v6.1 successfully boots into the busybox shell.
>> >   v6.2 just hangs before printing something in the console.
>> >
>> >
>> > ## Tested versions
>> > ```
>> > v6.1: OK
>> > ...
>> > v6.1.0-rc2-00002-g60f2096b59bc (included in v6.2-rc1): OK
>> > v6.1.0-rc2-00003-g5c62d5aab875 (included in v6.2-rc1): NG <-- This com=
mit caused a regression
>> > ...
>> > v6.2-rc1: NG
>> > ...
>> > v6.2: NG
>> > ...
>> > v6.3.0-rc7-00181-g8e41e0a57566 (included in v6.3): NG     <-- Reverts =
5c62d5aab875 but still NG
>> > ...
>> > v6.3: NG
>> > v6.4-rc3: NG
>> > ```
>> >
>> > Tested on MacBookPro 2020 (Intel(R) Core(TM) i7-1068NG7 CPU @ 2.30GHz)=
 running macOS 13.4.
>> >
>> >
>> > The issue seems a regression in [5c62d5aab8752e5ee7bfbe75ed6060db1c787=
f98](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D5c62d5aab8752e5ee7bfbe75ed6060db1c787f98) "ACPICA: Events: Suppor=
t fixed PCIe wake event".
>> >
>> > This commit was introduced in v6.2-rc1, and apparently reverted in v6.=
3 ([8e41e0a575664d26bb87e012c39435c4c3914ed9](https://git.kernel.org/pub/sc=
m/linux/kernel/git/torvalds/linux.git/commit/?id=3D8e41e0a575664d26bb87e012=
c39435c4c3914ed9)).
>> > However, v6.3 and the latest v6.4-rc3 still don't boot.
>>
>> See bugzilla for the full thread.
>>
>> Interestingly, this regression still occurs despite the culprit is
>> reverted in 8e41e0a575664d ("Revert "ACPICA: Events: Support fixed
>> PCIe wake event""), so this (obviously) isn't wake-on-lan regression,
>> but rather early boot one.
>>
>> Also, the reporter can't provide dmesg log (forget to attach serial
>> console?).
>>
>> Anyway, I'm adding it to regzbot:
>>
>> #regzbot introduced: 5c62d5aab8752e https://bugzilla.kernel.org/show_bug=
.cgi?id=3D217485
>> #regzbot title: Linux v6.2+ (x86_64) no longer boots on Apple's Virtuali=
zation framework (ACPICA issue)
>>
>> Thanks.
>>
>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217485
>>
>> --
>> An old man doll... just what I always wanted! - Clara
