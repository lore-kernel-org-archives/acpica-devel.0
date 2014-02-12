Content-Type: multipart/mixed; boundary="===============8722981811948008977=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] Wrong license in acpica-unix2-20140114/.../aehandlers.c
Date: Wed, 12 Feb 2014 05:19:31 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88024AFB11@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: CABC13nFomVF_=JmC8amESuBoSAtjKu-KdmiX-S=nwOSswXyXeA@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8722981811948008977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Sascha

Have you modified the aehandlers.c?
I ran acpisrc -h -y manually on aehandlers.c, no false generation of dual l=
icense header could be found.

You can try:
# cd <acpica srcdir>
# make acpisrc
# generate/unix/bin/acpisrc -h -y source/tools/acpiexec/aehandlers.c aehand=
lers.c
And take a look at =E2=80=9C./aehandlers.c=E2=80=9D.

Please make sure that the header of aehandlers.c has contained the lines in=
dicated by the =E2=80=9CHeaderBegin=E2=80=9D in source/tools/acpisrc/asconv=
ert.c.
And please also make sure that there is no additional =E2=80=9C\r=E2=80=9D,=
 "\n" or spaces among these lines.

Thanks and best regards
-Lv


From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Sascha Wildner
Sent: Tuesday, February 11, 2014 5:54 PM

Hello,

in=C2=A0acpica-unix2-20140114/source/tools/acpiexec/aehandlers.c, i.e. the =
dual-licensed version, the license was (accidentally, I suppose) exchanged =
with the Intel license, when just the copyright year should have been bumpe=
d.

Regards,
Sascha


--===============8722981811948008977==--

