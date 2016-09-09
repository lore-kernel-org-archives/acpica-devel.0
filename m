Content-Type: multipart/mixed; boundary="===============4072383025922453015=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Fri, 09 Sep 2016 18:46:20 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F3504@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 20160909184042.srv6jrio6s5umear@pd.tnic
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4072383025922453015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


> Please do not top-post.


You're not going to get a lot of help by scolding me.
Bob




> -----Original Message-----
> From: Borislav Petkov [mailto:bp(a)alien8.de]
> Sent: Friday, September 9, 2016 11:41 AM
> To: Moore, Robert <robert.moore(a)intel.com>
> Cc: LKML <linux-kernel(a)vger.kernel.org>; Zheng, Lv <lv.zheng(a)intel.co=
m>;
> Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; Len Brown
> <lenb(a)kernel.org>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> Subject: Re: [PATCH] ACPICA / Interpreter: Remove redundant newline
> =

> On Fri, Sep 09, 2016 at 06:26:17PM +0000, Moore, Robert wrote:
> > Is this a big deal?
> >
> > We do this on purpose for AcpiExec, to make the screen output more
> readable.
> =

> Please do not top-post.
> =

> What do you mean "big deal"? All other ACPI_INFO calls don't have a "\n"
> at the end except this one. How does one "\n" make some output more
> readable?
> =

> (Btw, I have no idea what AcpiExec is. Grepping the kernel tree doesn't
> give any results).
> =

> --
> Regards/Gruss,
>     Boris.
> =

> ECO tip #101: Trim your mails when you reply.

--===============4072383025922453015==--

