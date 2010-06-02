Content-Type: multipart/mixed; boundary="===============3277236213002587392=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Packaging
Date: Wed, 02 Jun 2010 13:36:16 -0700
Message-ID: <4911F71203A09E4D9981D27F9D83085870C1A959@orsmsx503.amr.corp.intel.com>
In-Reply-To: 4C06C004.40401@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3277236213002587392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Linux version of ACPICA is completely different from what is available =
on the ACPICA website. The native ACPICA code is translated to Linux with a=
 utility at the time ACPICA is integrated into Linux (this is done for ever=
y new release of the ACPICA code.)

So, I'm not sure what your goal is.

Bob


>-----Original Message-----
>From: Nathan O. [mailto:ndowens04(a)gmail.com]
>Sent: Wednesday, June 02, 2010 1:33 PM
>To: Moore, Robert
>Subject: Re: [Devel] Packaging
>
>The source code wouldn't be changed at all, I am not programmer. I try
>to package software for the Arch Linux community repo for others to use.
>All it does it pull from the software's site and compile it and install.
>If it does get moved to the official repo then when it compiles the
>software it will put in binary form.
>
>On 06/02/2010 03:30 PM, Moore, Robert wrote:
>> The original ACPICA source must retain the original Intel ACPICA license,
>I believe.
>>
>> Only the converted-for-linux gets the GPL license.
>>
>> Intel license:
>>
>> * 3. Conditions
>>   *
>>   * 3.1. Redistribution of Source with Rights to Further Distribute
>Source.
>>   * Redistribution of source code of any substantial portion of the
>Covered
>>   * Code or modification with rights to further distribute source must
>include
>>   * the above Copyright Notice, the above License, this list of
>Conditions,
>>
>>> -----Original Message-----
>>> From: Nathan O. [mailto:ndowens04(a)gmail.com]
>>> Sent: Wednesday, June 02, 2010 1:27 PM
>>> To: Moore, Robert
>>> Subject: Re: [Devel] Packaging
>>>
>>> On 06/02/2010 03:24 PM, Moore, Robert wrote:
>>>
>>>> Please explain what you mean by "package the source"
>>>> Bob
>>>>
>>>>
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] =
On
>>>>>
>>> Behalf
>>>
>>>>> Of Nathan O.
>>>>> Sent: Wednesday, June 02, 2010 1:19 PM
>>>>> To: devel(a)acpica.org
>>>>> Subject: [Devel] Packaging
>>>>>
>>>>> I was wondering if I would be allowed to package the source for acpica
>>>>> while including the license file from
>>>>> http://www.acpica.org/downloads/unix_source_code.php as part of the
>>>>> package.
>>>>>
>>>>> Thought I'd ask before doing this in case there would be any issues.
>>>>>
>>>>> Thanks
>>>>> _______________________________________________
>>>>> Devel mailing list
>>>>> Devel(a)acpica.org
>>>>> http://lists.acpica.org/listinfo/devel
>>>>>
>>>>>
>>> The packaging would be similar to
>>>
>>> http://aur.archlinux.org/packages/i7z/i7z/PKGBUILD
>>>
>>> Unless it gets moved from AUR to the main repo as a binary form. Though
>>> I'd copy the License page's text and include it as a License file so a
>>> user could read the license, like the license would be put in
>>> /usr/share/acpica/LICENSE
>>>


--===============3277236213002587392==--

