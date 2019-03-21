Content-Type: multipart/mixed; boundary="===============4840298193195098065=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] KASAN: slab-out-of-bounds Read in _decode_session6 (2)
Date: Fri, 22 Mar 2019 00:21:51 +0100
Message-ID: <CAJZ5v0jVquKnFHrQ+=AyZM2rwOx3CkdGng1z2g2UX30+PJaKDQ@mail.gmail.com>
In-Reply-To: 000000000000461a4c0584a2cfd2@google.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4840298193195098065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2019 at 12:08 AM syzbot
<syzbot+240f9766d6be3d69431e(a)syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 64fd1c7040880292710e6592ddc88d0d73cfb6fb
> Author: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>
> Date:   Mon Jun 12 20:48:41 2017 +0000
>
>      ACPI / PM: Run wakeup notify handlers synchronously
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1555b12b20=
0000
> start commit:   64fd1c70 ACPI / PM: Run wakeup notify handlers synchronou=
sly
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=3D1755b12b20=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1355b12b200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D93932074d01b4=
a5
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D240f9766d6be3d6=
9431e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13f35e4d400=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1280edbd400000
>
> Reported-by: syzbot+240f9766d6be3d69431e(a)syzkaller.appspotmail.com
> Fixes: 64fd1c704088 ("ACPI / PM: Run wakeup notify handlers synchronously=
")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

I don't see how the commit turned up by the bisection can be related
to the reported crash.

--===============4840298193195098065==--

