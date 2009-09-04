Content-Type: multipart/mixed; boundary="===============4231183642114015757=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] FW:  [PATCH] Repair predefined Package -> Buffer
Date: Fri, 04 Sep 2009 15:37:25 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308583748BB31@orsmsx503.amr.corp.intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4231183642114015757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



-----Original Message-----
From: Moore, Robert =

Sent: Friday, September 04, 2009 3:37 PM
To: 'Jung-uk Kim'
Cc: Lin, Ming M
Subject: RE: [Devel] [PATCH] Repair predefined Package -> Buffer

Sounds like a good idea. I'll look at it next week.

In general, we now have the capability to add these kinds of fixes easily, =
so keep your eye out for anything that can be repaired like this.

Thanks,
Bob


>-----Original Message-----
>From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On Be=
half
>Of Jung-uk Kim
>Sent: Friday, September 04, 2009 3:10 PM
>To: devel(a)acpica.org
>Subject: [Devel] [PATCH] Repair predefined Package -> Buffer
>
>One of the most common mistake of _FDE is returning Package instead of
>Buffer of five 32-bit integers.  The attached patch repairs the case.
>Do you think it is a reasonable fix?  Basically, I want to get rid of
>a quirk handling in FreeBSD. :-)
>
>Thanks!
>
>Jung-uk Kim

--===============4231183642114015757==--

