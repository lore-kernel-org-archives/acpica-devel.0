Return-Path: <regressions@leemhuis.info>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E15DA8405C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 615958405B
Message-ID: <3089214d-292b-885d-9bc1-c81d0101d5f0@leemhuis.info>
MIME-Version: 1.0
From: Thorsten Leemhuis <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <e6aaddb9-afec-e77d-be33-570f9f10a9c2@leemhuis.info>
 <53e8b4db-e8dd-4dfa-f873-7dcbeac09149@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <53e8b4db-e8dd-4dfa-f873-7dcbeac09149@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Acpica-devel] [regression] Bug 217069 - Wake on Lan is broken
 on r8169 since 6.2
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Fri, 24 Mar 2023 09:46:51 -0000
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Bob Moore <robert.moore@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jianmin Lv <lvjianmin@loongson.cn>, acpica-devel@lists.linuxfoundation.org, Huacai Chen <chenhuacai@loongson.cn>

On 19.03.23 08:20, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> On 22.02.23 08:57, Thorsten Leemhuis wrote:
>>
>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>> kernel developer don't keep an eye on it, I decided to forward it by
>> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217069 :
> 
> An issue that looked like a network bug was now bisected and it turns
> out it's cause by 5c62d5aab875 ("ACPICA: Events: Support fixed PCIe wake
> event") which Huacai Chen provided. Could you take a look at the ticket
> linked above?

Huacai Chen, did you look into this? Would be good to have this
regression fixed rather sooner than later, as it seems to annoy quite a
few people.

Should we maybe simply revert the problematic change for now and reapply
it later once the root-issue was found and fixed?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

> FWIW, the whole story started like this:
> 
>>> Ivan Ivanich 2023-02-22 00:51:52 UTC
>>>
>>> After upgrade to 6.2 having issues with wake on lan on 2 systems: -
>>> first is an old lenovo laptop from 2012(Ivy Bridge) with realtek
>>> network adapter - second is a PC(Haswell refresh) with PCIE realtek
>>> network adapter
>>>
>>> Both uses r8169 driver for network.
>>>
>>> On laptop it's not possible to wake on lan after poweroff On PC it's
>>> not possible to wake on lan up after hibernate but works after
>>> poweroff
>>>
>>> In both cases downgrade to 6.1.x kernel fixes the issue.
> 
> Meanwhile a few others that ran into the same problem with NICs from
> different vendors joined the ticket
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
