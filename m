Content-Type: multipart/mixed; boundary="===============2637240599575100442=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH] ACPICA: Fix indentation
Date: Wed, 13 Dec 2017 23:27:08 +0100
Message-ID: <CAJZ5v0gFRa991=zs=7DoyLWzVtEBp2XqoEbmxwzgEd55Nw4Nnw@mail.gmail.com>
In-Reply-To: CF6A88132359CE47947DB4C6E1709ED539668D71@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2637240599575100442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2017 at 10:53 PM, Schmauss, Erik
<erik.schmauss(a)intel.com> wrote:
>
>> -----Original Message-----
>> From: rjwysocki(a)gmail.com [mailto:rjwysocki(a)gmail.com] On Behalf Of =
Rafael
>> J. Wysocki
>> Sent: Friday, December 8, 2017 9:06 AM
>> To: Vasyl Gomonovych <gomonovych(a)gmail.com>
>> Cc: Moore, Robert <robert.moore(a)intel.com>; Zheng, Lv
>> <lv.zheng(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>=
; Len
>> Brown <lenb(a)kernel.org>; ACPI Devel Maling List <linux-acpi(a)vger.ker=
nel.org>;
>> devel(a)acpica.org; Linux Kernel Mailing List <linux-kernel(a)vger.kerne=
l.org>;
>> Schmauss, Erik <erik.schmauss(a)intel.com>
>> Subject: Re: [PATCH] ACPICA: Fix indentation
>>
>> On Fri, Dec 8, 2017 at 5:29 PM, Vasyl Gomonovych <gomonovych(a)gmail.com>
>> wrote:
>> > This patch avoids that smatch reports the following:
>> > drivers/acpi/acpica/exdump.c:623 acpi_ex_dump_operand() warn:
>> > inconsistent indenting
>> >
>> > Signed-off-by: Vasyl Gomonovych <gomonovych(a)gmail.com>
>>
>> This is ACPICA code, so changes like this should go in via the upstream.
>>
>
> Hi,
>> Erik may want to pick this up, however.
>>
>
> Thanks for pointing this out. I found  solution to fix the indentation is=
sue. It will be in the next release.

Cool, thanks!

--===============2637240599575100442==--

