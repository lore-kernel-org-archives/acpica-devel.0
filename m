Content-Type: multipart/mixed; boundary="===============8240340425640661291=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] acpi: update struct acpi_table_tpm2
Date: Tue, 09 Jun 2015 16:12:52 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F2C83@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 20150609154230.GA5750@jsakkine-mobl1
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8240340425640661291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Well, you don't have to use it. ACPICA has done this in several other place=
s. Anyway, I'm hesitant to just remove it at this point.


> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen(a)linux.intel.com]
> Sent: Tuesday, June 09, 2015 8:43 AM
> To: Moore, Robert
> Cc: Zheng, Lv; Wysocki, Rafael J; Len Brown; open list:ACPI COMPONENT
> AR...; open list:ACPI COMPONENT AR...; open list
> Subject: Re: [PATCH] acpi: update struct acpi_table_tpm2
> =

> On Tue, Jun 09, 2015 at 06:19:19PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Jun 09, 2015 at 02:21:12PM +0000, Moore, Robert wrote:
> > > ACPICA usually defines any "related" data structures, just for user
> > > convenience.
> >
> > If you want to keep it, it's fine for me but we still probably use the
> > internal structure for it in tpm_crb driver (as tpm_tis uses internal
> > structure for CRB).
> =

> Let me open this a little bit. Everytime we want to do some small change
> to control area (lets say TCG adds some flag) we would have to cycle them
> through you.
> =

> And the changes are not coupled with ACPI in any possible way. This is
> only adds more maintenance burden to you and also to us. This structure is
> the main control structure for the CRB driver and will be refined many
> times in the future. There is no any kind of use to its fields outside of
> the CRB driver.
> =

> /Jarkko

--===============8240340425640661291==--

