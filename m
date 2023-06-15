Return-Path: <20210240143@fudan.edu.cn>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BEB5941F2F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF88241F28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fudan.edu.cn; s=dkim; h=Received:From:Subject:Message-ID:Date:
 References:In-Reply-To:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding; bh=4+nWnPU80IgvT4DYe2yqbTI3Z+k5+DbTdW
 L6p8vhu/A=; b=5R1eU6cjjN/gJ+9WAHYt1mh/wayOYgEk4riL82mWxx7zwi8a/J
 +6fvETUoy8NUk8ttI8aLu7YquCVzHW4h7ZfjqY1ZaNj7Ij8lTiHlkZoaCvKTWl2e
 tdsLj1T+ipO+U5RPLs5znCrsOCPjhfWxwCU2vQSZx7uvjU3lT4N1+Ueqs=
From: 20210240143 <20210240143@fudan.edu.cn>
Message-ID: <4A499E9B-F394-499F-8F6A-5B584A99376C@fudan.edu.cn>
Date: Thu, 15 Jun 2023 15:41:07 +0800
References: <20230614162112.122816-1-cymi20@fudan.edu.cn>
In-Reply-To: <CAJZ5v0iZMHmgGE7ZTmOghHtWPXECx5HFt2a1NBNwABBX0CQBeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH] ACPICA: Fix missing check for return
 value of acpi_ns_get_attached_object()
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Chenyuan Mi <cymi20@fudan.edu.cn>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "robert.moore@intel.com" <robert.moore@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "acpica-devel@lists.linuxfoundation.org" <acpica-devel@lists.linuxfoundation.org>, "lenb@kernel.org" <lenb@kernel.org>

<span>Hi,</span><div>If the following call trace hanppens:</div><div><br>=
</div><div>acpi=5Fds=5Fcreate=5Ffield</div><div>acpi=5Fds=5Fget=5Ffield=5F=
names</div><div>acpi=5Fex=5Fprep=5Ffield=5Fvalue</div><div>acpi=5Fns=5Fge=
t=5Fattached=5Fobject</div><div><br></div><div>We would get an ACPI=5FTYP=
E=5FREGION type region node by acpi=5Fns=5Flookup() in acpi=5Fds=5Fcreate=
=5Ffield(), and pass it to acpi=5Fns=5Fget=5Fattached=5Fobject(). However=
, the node-&gt;object-&gt;common.type may not equal to &nbsp; ACPI=5FDESC=
=5FTYPE=5FOPERAND, which lead to return Null.</div><br><div id=3D=22imail=
=5Fsignature=22 class=3D=22ntes-signature=22></div><div class=3D=22ntes-m=
ailmaster-quote=22 style=3D=22padding-top: 1px; padding-bottom: 1px=22><d=
iv style=3D=22margin-top: 2em;margin-bottom: 1em;font-size: 14px;line-hei=
ght: 1.25;color: =2378787a;=22>---- Replied Message ----</div><div style=3D=
=22margin-bottom: 1em;font-size: 12px;line-height: 1.25;color: =23232324;=
padding: 0.5em 0.25em;border-radius: 0.67em;background-color: =23f0f0f0;=22=
><table width=3D=22100%=22 cellpadding=3D=220=22 cellspacing=3D=229=22 bo=
rder=3D=220=22><tbody><tr><td valign=3D=22top=22 style=3D=22width: 4.25em=
;font-size: 12px;line-height: 1.25;color: =2378787a;=22><span style=3D=22=
color:=238b8d94=22>=46rom</span></td><td valign=3D=22top=22 style=3D=22fo=
nt-size: 12px;line-height: 1.25;color: =23232324;word-break: break-all;=22=
><a class=3D=22mail-from=22 style=3D=22color: =230886e8; text-decoration:=
 none=22 href=3D=22mailto:rafael=40kernel.org=22>Rafael J. Wysocki&lt;raf=
ael=40kernel.org&gt;</a></td></tr><tr><td valign=3D=22top=22 style=3D=22w=
idth: 4.25em;font-size: 12px;line-height: 1.25;color: =2378787a;=22><span=
 style=3D=22color:=238b8d94=22>Date</span></td><td class=3D=22mail-date=22=
 valign=3D=22top=22 style=3D=22font-size: 12px;line-height: 1.25;color: =23=
232324;word-break: break-all;=22><span class=3D=22mail-date=22 style=3D=22=
color:black=22>06/15/2023 00:43</span></td></tr><tr><td valign=3D=22top=22=
 style=3D=22width: 4.25em;font-size: 12px;line-height: 1.25;color: =23787=
87a;=22> <span style=3D=22color:=238b8d94=22>To</span></td><td valign=3D=22=
top=22 style=3D=22font-size: 12px;line-height: 1.25;color: =23232324;word=
-break: break-all;=22><a class=3D=22mail-to=22 style=3D=22color: =230886e=
8; text-decoration: none=22 href=3D=22mailto:cymi20=40fudan.edu.cn=22>Che=
nyuan Mi&lt;cymi20=40fudan.edu.cn&gt;</a></td></tr><tr><td valign=3D=22to=
p=22 style=3D=22width: 4.25em;font-size: 12px;line-height: 1.25;color: =23=
78787a;=22> <span style=3D=22color:=238b8d94=22>Cc</span></td><td valign=3D=
=22top=22 style=3D=22font-size: 12px;line-height: 1.25;color: =23232324;w=
ord-break: break-all;=22><a class=3D=22mail-cc=22 style=3D=22color: =2308=
86e8; text-decoration: none=22 href=3D=22mailto:robert.moore=40intel.com=22=
>robert.moore=40intel.com&lt;robert.moore=40intel.com&gt;</a>,<br><a clas=
s=3D=22mail-cc=22 style=3D=22color: =230886e8; text-decoration: none=22 h=
ref=3D=22mailto:rafael.j.wysocki=40intel.com=22>rafael.j.wysocki=40intel.=
com&lt;rafael.j.wysocki=40intel.com&gt;</a>,<br><a class=3D=22mail-cc=22 =
style=3D=22color: =230886e8; text-decoration: none=22 href=3D=22mailto:le=
nb=40kernel.org=22>lenb=40kernel.org&lt;lenb=40kernel.org&gt;</a>,<br><a =
class=3D=22mail-cc=22 style=3D=22color: =230886e8; text-decoration: none=22=
 href=3D=22mailto:linux-acpi=40vger.kernel.org=22>linux-acpi=40vger.kerne=
l.org&lt;linux-acpi=40vger.kernel.org&gt;</a>,<br><a class=3D=22mail-cc=22=
 style=3D=22color: =230886e8; text-decoration: none=22 href=3D=22mailto:a=
cpica-devel=40lists.linuxfoundation.org=22>acpica-devel=40lists.linuxfoun=
dation.org&lt;acpica-devel=40lists.linuxfoundation.org&gt;</a>,<br><a cla=
ss=3D=22mail-cc=22 style=3D=22color: =230886e8; text-decoration: none=22 =
href=3D=22mailto:linux-kernel=40vger.kernel.org=22>linux-kernel=40vger.ke=
rnel.org&lt;linux-kernel=40vger.kernel.org&gt;</a></td></tr><tr><td valig=
n=3D=22top=22 style=3D=22width: 4.25em;font-size: 12px;line-height: 1.25;=
color: =2378787a;=22><span style=3D=22color:=238b8d94=22>Subject</span></=
td><td class=3D=22mail-subject=22 valign=3D=22top=22 style=3D=22font-size=
: 12px;line-height: 1.25;color: =23232324;word-break: break-all;=22><span=
 class=3D=22mail-subject=22 style=3D=22color:black=22>Re: =5BPATCH=5D ACP=
ICA: =46ix missing check for return value of acpi=5Fns=5Fget=5Fattached=5F=
object()</span></td></tr></tbody></table></div><div>On Wed, Jun 14, 2023 =
at 6:21=E2=80=AFPM Chenyuan Mi &lt;cymi20=40fudan.edu.cn&gt; wrote:
<br>&gt;
<br>&gt; The acpi=5Fns=5Fget=5Fattached=5Fobject() function may return
<br>&gt; NULL, which may cause null pointer deference, and most
<br>&gt; other callsites of acpi=5Fns=5Fget=5Fattached=5Fobject() do
<br>&gt; Null check. Add Null check for return value of
<br>&gt; acpi=5Fns=5Fget=5Fattached=5Fobject().
<br>
<br>But may acpi=5Fex=5Fprep=5Ffield=5Fvalue() be called in a code path w=
here
<br>acpi=5Fns=5Fget=5Fattached=5Fobject(i) can return NULL=3F
<br>
<br>I mean, if the given attached object is guaranteed to exist when this=

<br>function is called, NULL will not be returned, so the new check will
<br>be redundant then.
<br>
<br>&gt; =46ound by our static analysis tool.
<br>&gt;
<br>&gt; Signed-off-by: Chenyuan Mi &lt;cymi20=40fudan.edu.cn&gt;
<br>&gt; ---
<br>&gt; &nbsp;drivers/acpi/acpica/exprep.c =7C 7 +++++++
<br>&gt; &nbsp;1 file changed, 7 insertions(+)
<br>&gt;
<br>&gt; diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/=
exprep.c
<br>&gt; index 08196fa17080..d9c006ec1ac8 100644
<br>&gt; --- a/drivers/acpi/acpica/exprep.c
<br>&gt; +++ b/drivers/acpi/acpica/exprep.c
<br>&gt; =40=40 -431,6 +431,13 =40=40 acpi=5Fstatus acpi=5Fex=5Fprep=5Ffi=
eld=5Fvalue(struct acpi=5Fcreate=5Ffield=5Finfo *info)
<br>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;obj=5Fdesc-&gt;field.region=5Fobj =3D
<br>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;acpi=5Fns=5Fget=5F=
attached=5Fobject(info-&gt;region=5Fnode);
<br>&gt;
<br>&gt; + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;if (=21obj=5Fdesc-&gt;field.region=5Fobj) =7B
<br>&gt; + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ACP=
I=5FERROR((AE=5FIN=46O,
<br>&gt; + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=22N=
ull Region Object during field prep=22));
<br>&gt; + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;acp=
i=5Fut=5Fdelete=5Fobject=5Fdesc(obj=5Fdesc);
<br>&gt; + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret=
urn=5FACPI=5FSTATUS(AE=5FAML=5FINTERNAL);
<br>&gt; + &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=7D
<br>&gt; +
<br>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* =46ields specific to generic=5Fserial=5F=
bus fields */
<br>&gt;
<br>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;obj=5Fdesc-&gt;field.access=5Flength =3D =
info-&gt;access=5Flength;
<br>&gt; --
<br>&gt; 2.17.1
<br>&gt;
<br></div></div>

