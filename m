Return-Path: <suda.kyoto@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8507B41783
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 41CB6400A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685210200; x=1687802200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1tnQGM8TDratjvDdvV40wFGsSvtok3SKpCtzoKGVTnI=;
 b=NEsdKj2pftrf+BGTT3E7+owCFkcdrNmLK2FS7LWPRiejlpxrTc3bPJwQgfkLu73op2
 PMlRHcaiJhUkbvvpkKawcglR37Up9J+h167UF+B+EnorHDhX7XS20jeJo8u6yr55tHqA
 jOMbFfFJE+cB5RA8TCHi4YCahXmZLO8fuUfpYlJ+MPR+N1amyjxJfr6VJnTqa+kc4Rnp
 OVBfTDV3bjWylUe99YBswCcLKrn4jcNZVK2Ye8lEo3qATzVaBp8jqc5NW/o4LxrCEuSJ
 w1PjUzKMHc2LS7WHX4m1b15A+AztcQLywDNpL8KZ60taGQ6sC/H+elklsrtc13uzihh0
 wNNg==
MIME-Version: 1.0
References: <efd6f2d4-547c-1378-1faa-53c044dbd297@gmail.com>
In-Reply-To: <efd6f2d4-547c-1378-1faa-53c044dbd297@gmail.com>
From: Akihiro Suda <suda.kyoto@gmail.com>
Date: Sun, 28 May 2023 02:56:28 +0900
Message-ID: <CAG8fp8SaHi0X-tZHnji_93wBADp1_=brjauWCVXuLaG7iP0p=A@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000057c71b05fcb093be"
Subject: [Acpica-devel] mix of ACPICA regression and EFISTUB regression
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

--00000000000057c71b05fcb093be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Turned out that this is a mixture of an ACPICA issue and an EFISTUB issue.

Kernel v6.2 can boot by reverting the *both* of the following two commits:
- 5c62d5aab8752e5ee7bfbe75ed6060db1c787f98 "ACPICA: Events: Support fixed
PCIe wake event"
- e346bebbd36b1576a3335331fed61bb48c6d8823 "efi: libstub: Always enable
initrd command line loader and bump version"

Kernel v6.3 can boot by just reverting e346bebb, as 5c62d5a has been
already reverted in 8e41e0a575664d26bb87e012c39435c4c3914ed9.
The situation is the same for v6.4-rc3 too.

Note that in my test I let Virtualization.framework directly load bzImage
without GRUB (akin to `qemu-system-x86_64 -kernel bzImage`).
Apparently, reverting e346bebb is not necessary for loading bzImage via
GRUB.


> Also, the reporter can't provide dmesg log (forget to attach serial
console?).

Uploaded v6.1 dmesg in the bugzilla.
v6.2 dmesg can't be provided, as it hangs before printing something in
console=3Dhvc0.
(IIUC, console=3DttyS0 (RS-232C) is not implemented in
Virtualization.framework.)

2023=E5=B9=B45=E6=9C=8825=E6=97=A5(=E6=9C=A8) 21:46 Bagas Sanjaya <bagasdot=
me@gmail.com>:

> Hi,
>
> I notice a regression report on Bugzilla [1]. Quoting from it:
>
> > Linux kernel >=3D v6.2 no longer boots on Apple's Virtualization.framew=
ork
> (x86_64).
> >
> > It is reported that the issue is not reproducible on ARM64:
> https://github.com/lima-vm/lima/issues/1577#issuecomment-1561577694
> >
> >
> > ## Reproduction
> > - Checkout the kernel repo, and run `make defconfig bzImage`.
> >
> > - Create an initrd (see the attached `initrd-example.txt`)
> >
> > - Transfer the bzImage and initrd to an Intel Mac.
> >
> > - On Mac, download `RunningLinuxInAVirtualMachine.zip` from
> https://developer.apple.com/documentation/virtualization/running_linux_in=
_a_virtual_machine
> , and build the `LinuxVirtualMachine` binary with Xcode.
> >   Building this binary with Xcode requires logging in to Apple.
> >   If you do not like logging in, a third party equivalent such as
> https://github.com/Code-Hex/vz/blob/v3.0.6/example/linux/main.go can be
> used.
> >
> > - Run `LinuxVirtualMachine /tmp/bzImage /tmp/initrd.img`.
> >   v6.1 successfully boots into the busybox shell.
> >   v6.2 just hangs before printing something in the console.
> >
> >
> > ## Tested versions
> > ```
> > v6.1: OK
> > ...
> > v6.1.0-rc2-00002-g60f2096b59bc (included in v6.2-rc1): OK
> > v6.1.0-rc2-00003-g5c62d5aab875 (included in v6.2-rc1): NG <-- This
> commit caused a regression
> > ...
> > v6.2-rc1: NG
> > ...
> > v6.2: NG
> > ...
> > v6.3.0-rc7-00181-g8e41e0a57566 (included in v6.3): NG     <-- Reverts
> 5c62d5aab875 but still NG
> > ...
> > v6.3: NG
> > v6.4-rc3: NG
> > ```
> >
> > Tested on MacBookPro 2020 (Intel(R) Core(TM) i7-1068NG7 CPU @ 2.30GHz)
> running macOS 13.4.
> >
> >
> > The issue seems a regression in
> [5c62d5aab8752e5ee7bfbe75ed6060db1c787f98](
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D5c62d5aab8752e5ee7bfbe75ed6060db1c787f98)
> "ACPICA: Events: Support fixed PCIe wake event".
> >
> > This commit was introduced in v6.2-rc1, and apparently reverted in v6.3
> ([8e41e0a575664d26bb87e012c39435c4c3914ed9](
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D8e41e0a575664d26bb87e012c39435c4c3914ed9)
> ).
> > However, v6.3 and the latest v6.4-rc3 still don't boot.
>
> See bugzilla for the full thread.
>
> Interestingly, this regression still occurs despite the culprit is
> reverted in 8e41e0a575664d ("Revert "ACPICA: Events: Support fixed
> PCIe wake event""), so this (obviously) isn't wake-on-lan regression,
> but rather early boot one.
>
> Also, the reporter can't provide dmesg log (forget to attach serial
> console?).
>
> Anyway, I'm adding it to regzbot:
>
> #regzbot introduced: 5c62d5aab8752e
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217485
> #regzbot <https://bugzilla.kernel.org/show_bug.cgi?id=3D217485#regzbot>
> title: Linux v6.2+ (x86_64) no longer boots on Apple's Virtualization
> framework (ACPICA issue)
>
> Thanks.
>
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217485
>
> --
> An old man doll... just what I always wanted! - Clara
>

--00000000000057c71b05fcb093be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Turned out that this is a mixture of an A=
CPICA issue and an EFISTUB issue.<br><br>Kernel v6.2 can boot by reverting =
the *both* of the following two commits:<br>- 5c62d5aab8752e5ee7bfbe75ed606=
0db1c787f98 &quot;ACPICA: Events: Support fixed PCIe wake event&quot;<br>- =
e346bebbd36b1576a3335331fed61bb48c6d8823 &quot;efi: libstub: Always enable =
initrd command line loader and bump version&quot;<br><br>Kernel v6.3 can bo=
ot by just reverting e346bebb, as 5c62d5a has been already reverted in 8e41=
e0a575664d26bb87e012c39435c4c3914ed9.<br>The situation is the same for v6.4=
-rc3 too.<br><br>Note that in my test I let Virtualization.framework direct=
ly load bzImage without GRUB (akin to `qemu-system-x86_64 -kernel bzImage`)=
.<br>Apparently, reverting e346bebb is not necessary for loading bzImage vi=
a GRUB.<br><br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">&gt; Also,=
 the reporter can&#39;t provide dmesg log (forget to attach serial console?=
).</div><div dir=3D"ltr"><br></div><div>Uploaded v6.1 dmesg in the bugzilla=
.</div><div>v6.2 dmesg can&#39;t be provided, as it hangs before printing s=
omething in console=3Dhvc0.</div><div>(IIUC, console=3DttyS0 (RS-232C) is n=
ot implemented in Virtualization.framework.)</div><div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">2023=E5=B9=B45=E6=9C=8825=
=E6=97=A5(=E6=9C=A8) 21:46 Bagas Sanjaya &lt;<a href=3D"mailto:bagasdotme@g=
mail.com">bagasdotme@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">Hi,<br>
<br>
I notice a regression report on Bugzilla [1]. Quoting from it:<br>
<br>
&gt; Linux kernel &gt;=3D v6.2 no longer boots on Apple&#39;s Virtualizatio=
n.framework (x86_64).<br>
&gt; <br>
&gt; It is reported that the issue is not reproducible on ARM64: <a href=3D=
"https://github.com/lima-vm/lima/issues/1577#issuecomment-1561577694" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/lima-vm/lima/issues/15=
77#issuecomment-1561577694</a><br>
&gt; <br>
&gt; <br>
&gt; ## Reproduction<br>
&gt; - Checkout the kernel repo, and run `make defconfig bzImage`.<br>
&gt; <br>
&gt; - Create an initrd (see the attached `initrd-example.txt`)<br>
&gt; <br>
&gt; - Transfer the bzImage and initrd to an Intel Mac.<br>
&gt; <br>
&gt; - On Mac, download `RunningLinuxInAVirtualMachine.zip` from <a href=3D=
"https://developer.apple.com/documentation/virtualization/running_linux_in_=
a_virtual_machine" rel=3D"noreferrer" target=3D"_blank">https://developer.a=
pple.com/documentation/virtualization/running_linux_in_a_virtual_machine</a=
> , and build the `LinuxVirtualMachine` binary with Xcode.<br>
&gt;=C2=A0 =C2=A0Building this binary with Xcode requires logging in to App=
le.<br>
&gt;=C2=A0 =C2=A0If you do not like logging in, a third party equivalent su=
ch as <a href=3D"https://github.com/Code-Hex/vz/blob/v3.0.6/example/linux/m=
ain.go" rel=3D"noreferrer" target=3D"_blank">https://github.com/Code-Hex/vz=
/blob/v3.0.6/example/linux/main.go</a> can be used.<br>
&gt; <br>
&gt; - Run `LinuxVirtualMachine /tmp/bzImage /tmp/initrd.img`.<br>
&gt;=C2=A0 =C2=A0v6.1 successfully boots into the busybox shell.<br>
&gt;=C2=A0 =C2=A0v6.2 just hangs before printing something in the console.<=
br>
&gt; <br>
&gt; <br>
&gt; ## Tested versions<br>
&gt; ```<br>
&gt; v6.1: OK<br>
&gt; ...<br>
&gt; v6.1.0-rc2-00002-g60f2096b59bc (included in v6.2-rc1): OK<br>
&gt; v6.1.0-rc2-00003-g5c62d5aab875 (included in v6.2-rc1): NG &lt;-- This =
commit caused a regression<br>
&gt; ...<br>
&gt; v6.2-rc1: NG<br>
&gt; ...<br>
&gt; v6.2: NG<br>
&gt; ...<br>
&gt; v6.3.0-rc7-00181-g8e41e0a57566 (included in v6.3): NG=C2=A0 =C2=A0 =C2=
=A0&lt;-- Reverts 5c62d5aab875 but still NG<br>
&gt; ...<br>
&gt; v6.3: NG<br>
&gt; v6.4-rc3: NG<br>
&gt; ```<br>
&gt; <br>
&gt; Tested on MacBookPro 2020 (Intel(R) Core(TM) i7-1068NG7 CPU @ 2.30GHz)=
 running macOS 13.4.<br>
&gt; <br>
&gt; <br>
&gt; The issue seems a regression in [5c62d5aab8752e5ee7bfbe75ed6060db1c787=
f98](<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/?id=3D5c62d5aab8752e5ee7bfbe75ed6060db1c787f98" rel=3D"noref=
errer" target=3D"_blank">https://git.kernel.org/pub/scm/linux/kernel/git/to=
rvalds/linux.git/commit/?id=3D5c62d5aab8752e5ee7bfbe75ed6060db1c787f98</a>)=
 &quot;ACPICA: Events: Support fixed PCIe wake event&quot;.<br>
&gt; <br>
&gt; This commit was introduced in v6.2-rc1, and apparently reverted in v6.=
3 ([8e41e0a575664d26bb87e012c39435c4c3914ed9](<a href=3D"https://git.kernel=
.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3D8e41e0a575664=
d26bb87e012c39435c4c3914ed9)" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3D8e4=
1e0a575664d26bb87e012c39435c4c3914ed9)</a>).<br>
&gt; However, v6.3 and the latest v6.4-rc3 still don&#39;t boot.<br>
<br>
See bugzilla for the full thread.<br>
<br>
Interestingly, this regression still occurs despite the culprit is<br>
reverted in 8e41e0a575664d (&quot;Revert &quot;ACPICA: Events: Support fixe=
d<br>
PCIe wake event&quot;&quot;), so this (obviously) isn&#39;t wake-on-lan reg=
ression,<br>
but rather early boot one.<br>
<br>
Also, the reporter can&#39;t provide dmesg log (forget to attach serial<br>
console?).<br>
<br>
Anyway, I&#39;m adding it to regzbot:<br>
<br>
#regzbot introduced: 5c62d5aab8752e <a href=3D"https://bugzilla.kernel.org/=
show_bug.cgi?id=3D217485#regzbot" rel=3D"noreferrer" target=3D"_blank">http=
s://bugzilla.kernel.org/show_bug.cgi?id=3D217485<br>
#regzbot</a> title: Linux v6.2+ (x86_64) no longer boots on Apple&#39;s Vir=
tualization framework (ACPICA issue)<br>
<br>
Thanks.<br>
<br>
[1]: <a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D217485" rel=
=3D"noreferrer" target=3D"_blank">https://bugzilla.kernel.org/show_bug.cgi?=
id=3D217485</a><br>
<br>
-- <br>
An old man doll... just what I always wanted! - Clara<br>
</blockquote></div></div></div>

--00000000000057c71b05fcb093be--
