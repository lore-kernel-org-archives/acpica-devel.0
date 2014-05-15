Content-Type: multipart/mixed; boundary="===============4142751367413587981=="
MIME-Version: 1.0
From: Sascha Wildner <swildner at gmail.com>
Subject: Re: [Devel] Clarification request about AcpiDbgLevel and
 AcpiGbl_EnableAmlDebugObject
Date: Thu, 15 May 2014 21:21:33 +0200
Message-ID: <CABC13nE9gguL8ZWUskE8Wn1s-F=+tV7nxOxFtNP1xPVuA23=Ew@mail.gmail.com>
In-Reply-To: 20140515010818.GA30239@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4142751367413587981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2014 at 3:08 AM, David E. Box
<david.e.box(a)linux.intel.com> wrote:
> On Wed, May 14, 2014 at 10:53:30PM +0200, Sascha Wildner wrote:
>> So my question is: How should the host OS properly handle this? I saw th=
at
>> FreeBSD for example initializes AcpiDbgLevel to 0 (when their ACPI_DEBUG
>> switch isn't set) but the reference manual doesn't mention that anything
>> other than AcpiGbl_EnableAmlDebugObject being FALSE is necessary.
>
> How should the host OS handle what exactly? I think you misunderstand wha=
t Debug
> Object is. In ASL you can use the Store operator to print debug messages =
like
> this:

David,

sorry for not being clear enough the first time.

After a recent ACPICA upgrade in DragonFly BSD we've had some reports
of (mostly temperature related) Debug Object output like for example
http://lists.dragonflybsd.org/pipermail/users/2014-February/109309.html,
which I was investigating. I checked the reference and I
(mis)understood it as saying that with AcpiGbl_EnableAmlDebugObject
being FALSE alone, Debug Object output would not be printed, which
confused me, so I asked etc.

But I understand now that if I wanted to disable them, I would need to
modify AcpiDbgLevel, too. I'll study the ASL first, though.

Sascha

--===============4142751367413587981==--

