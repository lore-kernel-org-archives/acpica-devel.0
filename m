Content-Type: multipart/mixed; boundary="===============8226846823973749776=="
MIME-Version: 1.0
From: Zhang Rui <rui.zhang at intel.com>
Subject: Re: [Devel] Battery Presence
Date: Tue, 06 Jul 2010 10:37:17 +0800
Message-ID: <1278383837.4537.6487.camel@rzhang1-desktop>
In-Reply-To: AANLkTikgUUV_E8Q5uFkTadZljGD2QWDTQoReSvzMIapl@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8226846823973749776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-07-06 at 10:29 +0800, Sean Shoufu Luo wrote:
> Previously, I have ported ACPICA to our system. These days, I wonna to
> write ACPI driver for battery with Netbsd's version as guide, but I
> found when I initialized battery driver, it would issue a command to
> query _STA for battery presence. But its return value is 0xf, that
> indicates PRESENCE bit is not set (0x00000010).  I'm puzzled. I'm
> using battery ....Why the battery not present? =

> Anyone can give any hint?
> =

please attach the acpidump output of this machine.

thanks,
rui



--===============8226846823973749776==--

