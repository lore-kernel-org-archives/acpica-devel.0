Content-Type: multipart/mixed; boundary="===============4459759734656179377=="
MIME-Version: 1.0
From: Ross Zwisler <ross.zwisler at linux.intel.com>
Subject: Re: [Devel] [RFC v2 0/5] surface heterogeneous memory performance
 information
Date: Fri, 07 Jul 2017 10:30:58 -0600
Message-ID: <20170707163058.GB22856@linux.intel.com>
In-Reply-To: 7cb3b9c4-9082-97e9-ebfd-542243bf652b@nvidia.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4459759734656179377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 10:30:46PM -0700, John Hubbard wrote:
> On 07/06/2017 02:52 PM, Ross Zwisler wrote:
> [...]
> > =

> > The naming collision between Jerome's "Heterogeneous Memory Management
> > (HMM)" and this "Heterogeneous Memory (HMEM)" series is unfortunate, bu=
t I
> > was trying to stick with the word "Heterogeneous" because of the naming=
 of
> > the ACPI 6.2 Heterogeneous Memory Attribute Table table.  Suggestions f=
or
> > better naming are welcome.
> > =

> =

> Hi Ross,
> =

> Say, most of the places (file names, function and variable names, and even
> print statements) where this patchset uses hmem or HMEM, it really seems =
to
> mean, the Heterogeneous Memory Attribute Table. That's not *always* true,=
 but
> given that it's a pretty severe naming conflict, how about just changing:
> =

> hmem --> hmat
> HMEM --> HMAT
> =

> ...everywhere? Then you still have Heterogeneous Memory in the name, but
> there is enough lexical distance (is that a thing? haha) between HMM and =
HMAT
> to keep us all sane. :)
> =

> With or without the above suggestion, there are a few places (Kconfig, co=
mments,
> prints) where we can more easily make it clear that HMM !=3D HMEM (or HMA=
T), =

> so for those I can just comment on them separately in the individual patc=
hes.
> =

> thanks,
> john h

Hi John,

Sure, that change makes sense to me.  I had initially tried to make this
enabling more generic so that other, non-ACPI systems could use the same sy=
sfs
representation even if they got their performance numbers from some other
source, but while implementing it pretty quickly became very tightly tied to
the ACPI HMAT.

- Ross

--===============4459759734656179377==--

