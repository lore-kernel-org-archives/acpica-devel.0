Return-Path: <lvjianmin@loongson.cn>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF6F941DC6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E5D5240558
References: <e6aaddb9-afec-e77d-be33-570f9f10a9c2@leemhuis.info>
 <53e8b4db-e8dd-4dfa-f873-7dcbeac09149@leemhuis.info>
 <3089214d-292b-885d-9bc1-c81d0101d5f0@leemhuis.info>
 <CAAhV-H5j29CnCN+F8Oz0qh1UCqp+CmL=aQXCSjqgX8CZ5sXTtg@mail.gmail.com>
From: Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <b39064e3-4f8b-f607-b270-1e0c8539d391@loongson.cn>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5j29CnCN+F8Oz0qh1UCqp+CmL=aQXCSjqgX8CZ5sXTtg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Date: Fri, 24 Mar 2023 10:18:11 -0000
To: Huacai Chen <chenhuacai@kernel.org>, Linux regressions mailing list <regressions@lists.linux.dev>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Bob Moore <robert.moore@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, acpica-devel@lists.linuxfoundation.org, Huacai Chen <chenhuacai@loongson.cn>

Please try the following patch:

https://github.com/acpica/acpica/pull/784/commits/0e66e6aae972dac3833bdcbd223aa6a8b1733176


On 2023/3/24 下午5:50, Huacai Chen wrote:
> Hi, Thorsten,
> 
> I'm sorry I ignored this email, and Jianmin, could you please
> investigate this problem? Thank you.
> 
> Huacai
> 
> On Fri, Mar 24, 2023 at 5:46 PM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>>
>> On 19.03.23 08:20, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> Hi, Thorsten here, the Linux kernel's regression tracker.
>>>
>>> On 22.02.23 08:57, Thorsten Leemhuis wrote:
>>>>
>>>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>>>> kernel developer don't keep an eye on it, I decided to forward it by
>>>> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217069 :
>>>
>>> An issue that looked like a network bug was now bisected and it turns
>>> out it's cause by 5c62d5aab875 ("ACPICA: Events: Support fixed PCIe wake
>>> event") which Huacai Chen provided. Could you take a look at the ticket
>>> linked above?
>>
>> Huacai Chen, did you look into this? Would be good to have this
>> regression fixed rather sooner than later, as it seems to annoy quite a
>> few people.
>>
>> Should we maybe simply revert the problematic change for now and reapply
>> it later once the root-issue was found and fixed?
>>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>> --
>> Everything you wanna know about Linux kernel regression tracking:
>> https://linux-regtracking.leemhuis.info/about/#tldr
>> If I did something stupid, please tell me, as explained on that page.
>>
>> #regzbot poke
>>
>>> FWIW, the whole story started like this:
>>>
>>>>> Ivan Ivanich 2023-02-22 00:51:52 UTC
>>>>>
>>>>> After upgrade to 6.2 having issues with wake on lan on 2 systems: -
>>>>> first is an old lenovo laptop from 2012(Ivy Bridge) with realtek
>>>>> network adapter - second is a PC(Haswell refresh) with PCIE realtek
>>>>> network adapter
>>>>>
>>>>> Both uses r8169 driver for network.
>>>>>
>>>>> On laptop it's not possible to wake on lan after poweroff On PC it's
>>>>> not possible to wake on lan up after hibernate but works after
>>>>> poweroff
>>>>>
>>>>> In both cases downgrade to 6.1.x kernel fixes the issue.
>>>
>>> Meanwhile a few others that ran into the same problem with NICs from
>>> different vendors joined the ticket
>>>
>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>> --
>>> Everything you wanna know about Linux kernel regression tracking:
>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>> If I did something stupid, please tell me, as explained on that page.

