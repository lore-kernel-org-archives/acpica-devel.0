Content-Type: multipart/mixed; boundary="===============7253034444953712858=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH v7 0/3] acpi: apei: Drop panic() on fatal errors
 policy
Date: Sun, 27 May 2018 11:36:49 +0200
Message-ID: <CAJZ5v0g_wQ0zhjbohQaU1GNxpri_Nkm=bOXyMQ8zi8dOGTxmYA@mail.gmail.com>
In-Reply-To: 20180525155352.22350-1-mr.nuke.me@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7253034444953712858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 5:53 PM, Alexandru Gagniuc <mr.nuke.me(a)gmail.com>=
 wrote:
> FFS (firmware-first) handling through APEI seems to have developed a
> policy to panic() on any fatal errors. This policy is completely
> independent of the non-FFS case. It is also inconsistent with how the
> native error handlers, a number of which will recover the system from
> fatal errors.
>
> The purpose of this series is to obsolete this idiotic policy, with
> the motivation to enable identical handling of PCIe errors to native
> reporting.
>
>
> Rafael, this is copypaste from the previous patch series. I suspect
> you might have missed it last time, because you asked questions which
> were answered here. I've included it so you don't have to go digging
> old emails:

I didn't miss it, but I didn't like your answers.

Anyway, as a rule, no GHES/APEI patches are applied without an ACK
from either Boris or Tony, so you need to talk to them about the
patches.

Thanks,
Rafael

--===============7253034444953712858==--

