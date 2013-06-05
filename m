Content-Type: multipart/mixed; boundary="===============8111113745904835062=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: Re: [Devel] [PATCH] ACPICA: acpidump -- provide initial
 implementation for Linux
Date: Wed, 05 Jun 2013 16:12:06 -0600
Message-ID: <51AFB7B6.1010109@redhat.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E36FE7A3FD@ORSMSX103.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8111113745904835062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 06/04/2013 06:56 PM, Moore, Robert wrote:
>
>
>> -----Original Message-----
>> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On =
Behalf
>> Of Al Stone
>> Sent: Sunday, June 02, 2013 1:04 PM
>> To: devel(a)acpica.org
>> Subject: Re: [Devel] [PATCH] ACPICA: acpidump -- provide initial
>> implementation for Linux
>>
[snip...]
>>
>> 2) I've seen at least a few systems with more than one UEFI
>>      table instance.  Whether allowed or not, it looks like
>>      the acpidump code will only allow this for SSDTs.
>>
>
> If you find such a system, we would like to see the acpidump.
> Thanks,
> Bob

Sure.  It's my Lenovo T420s laptop -- my daily driver.  I see
three UEFI tables in /sys/firmware/acpi/tables: UEFI1, UEFI2
and UEFI3.  It seemed a bit odd, but I have not investigated
it any further.  The tables are attached.

-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============8111113745904835062==
Content-Type: application/gzip
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="uefi.tar.gz"

H4sIAJe3r1EAAytNTcvUZ6AtMAACc1NTEG1obmqATMMAg6GRoamxubGxqakZg4GhgZG5GYOCKY3d
BQalxSWJRQoKDIkZxcb41BGSH6KgFBT/oa5unjT0HCiCzUxMcMW/oZGJGVr8GxoYmzMoGNDOSQgw
wuMfFPXLmBgYGPt9XP38w/xDAnTdzRUUFAQEGRgCQnwUgFIM0zfO5/1zbqLfmo2qpjefrnAxY5AH
ijoBsTMQuwCxKxC7AbE7EHsAsScQewGxNxD7AnEgEH8C4o9AHATEL4GYEYhBpq8GYmYgVgBiFiBm
BWI2ID4IxOxAzAHEnEDMBcTcQMwDxM08v/iuM+90mdObb/TM7sCMihlPJoeu/eu2TSzHL3NW9ryX
lb8PKGoo+szaPa9u0ynRL5ZC+uc0aj85bxWNS5gvwMazI695XltXglfzyiuOL7PUWZMcKn7sTb7n
sl79h/rf9E62owdY1vl4N7ksDj5ooe3F4fHW7M2pdcdv+m19+NhP9HQ/i9f9lRHvf5/wXTy/d9s+
/uYC2U0sd0RjA3wX3YiV9m9aI9jPNe+U6A9Nr+Vir9e5nkrOS77tfWbxWiePXTwBEWvFL994ZPZd
+s8XS595s8+tMLU8LDVnzvEjnPMDHWceCV7A5TVlGsOK5PdtU387tax+Fcn90XFVxJ31N5TyfjjN
TDP7X9EzZ/354usZm37fdV9zUbHvp+RSnTjZOUl7vwX5d8VPnvZcY/abgwGR9rvmlPltWtXsfyuO
/WQqw+xIg7ZC7y1zuIXWh7E3pBXHBWm2pHpvLLeuZLm7v7X+neuFfTNe++81uFZmXnvux0puzi1p
l5j99pmv3bunNfmvauCG3N0dfY5L9rw/Iu6bucdiy8Rb7t1cvmvDjmus9KmPmFMzLc+pL9Vjbo5/
A6u+Dt9Jdd4Nd84Iu0yoEOlYwLPt35tZE3fMmeztvlJCc/6m1Mk5XT02Khd2r/TaJ35+doShwRvW
eQ/fzWIX9+13O98olHBb7XjZ/Nm/NLRdp8sfVHg7P24mrXPByAXw8t+IdnYQKP9B1T2i/DcxB5f/
Riaj5T89ACjqQSU5YxuotFdQcPb3dQp1g5TOIBEQvW/aC9H7PI/cZ09f1GXZfTzVDFxurwjz3zGw
bh8FlAN4/jeknR2E8r+BOVL7z8QQkv9H2390AaCotwPSjKq4238vkqdeenje0bcv5Jaz0r97MWYM
DBO+7hpol4+CUTAKRsEoGAWjYBSMglEwCkbBKBgFo2AUjIJRMApGwSgYBaNgFIwCbAAAHHzv8AAo
AAA=
--===============8111113745904835062==--

