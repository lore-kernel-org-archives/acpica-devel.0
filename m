Return-Path: <regressions@leemhuis.info>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F3BAB41EE0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A233641DC1
Message-ID: <13aea525-108a-e018-987d-2447ff1d42df@leemhuis.info>
MIME-Version: 1.0
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <e6aaddb9-afec-e77d-be33-570f9f10a9c2@leemhuis.info>
 <53e8b4db-e8dd-4dfa-f873-7dcbeac09149@leemhuis.info>
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
Date: Fri, 14 Apr 2023 12:48:43 -0000
To: Jianmin Lv <lvjianmin@loongson.cn>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>, Huacai Chen <chenhuacai@kernel.org>, Bob Moore <robert.moore@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, acpica-devel@lists.linuxfoundation.org, Huacai Chen <chenhuacai@loongson.cn>

On 19.03.23 08:20, Linux regression tracking (Thorsten Leemhuis) wrote:
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

Jianmin did get close to a proper fix a while ago
(https://bugzilla.kernel.org/show_bug.cgi?id=217069#c46 ), but it
appears there wasn't any progress to fix this during the last week. Or
did I miss it?

This is kinda unsatisfying, as the culprit is now known for nearly four
weeks; especially as this is a issue that is present in 6.2 since it was
released and would have been possible to fix there and in mainline with
a simple revert. We even got close to one two weeks ago already
(https://bugzilla.kernel.org/show_bug.cgi?id=217069#c49 ).

#sigh

I'd say we should revert this. Rafael, what's your opinion here?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
