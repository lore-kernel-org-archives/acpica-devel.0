Content-Type: multipart/mixed; boundary="===============7805398533218393829=="
MIME-Version: 1.0
From: Lin Ming <lin at ming.vg>
Subject: Re: [Devel] System Address Map
Date: Tue, 21 Sep 2010 08:49:59 +0800
Message-ID: <AANLkTikgK5jhdnX8m2b4eWNWUsFjhB1hEd0=LtgUfXAH@mail.gmail.com>
In-Reply-To: 184268.20081.qm@web113207.mail.gq1.yahoo.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7805398533218393829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 21, 2010 at 8:05 AM, Bogdan <love4boobies(a)yahoo.com> wrote:
> Hi,
>
> This may not be the best place to ask; I've sent an e-mail to info(a)acpi=
.info,
> which is the questions/feedback e-mail listed on the ACPI website.
>
> Regarding the specification, particularly to an addition made in ACPI 4.0=
, what
> is the purpose of the AddressRangeSlowAccess mnemonic listed in table 14-2
> (Input to the INT 15h E820h Call)? Could you give an example when this mi=
ght be
> used? I thought perhaps looking at the Linux source code might clear thin=
gs up
> but they don't use it.

I'm not that clear, just have a look at ACPI 4.0a spec, it says
AddressRangeSlowAccess, If set, accesses to the described range may
incur considerable latencies.

AddressRangeSlowAccess is an Extended Attributes for Address Range
Descriptor Structure.
Address range descriptor is the output from the INT 15h E820h Call.

Lin Ming

>
> Cheers,
> Bogdan
>
>
>
>
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> http://lists.acpica.org/listinfo/devel
>

--===============7805398533218393829==--

