Content-Type: multipart/mixed; boundary="===============3699031305060483672=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH 4.20 regression fix] ACPICA: Fix handling of
 buffer-size in acpi_ex_write_data_to_field()
Date: Wed, 21 Nov 2018 00:48:40 +0100
Message-ID: <CAJZ5v0gGCgg4yAUD19rEPrQD+SaEjDs+5KTnQg3OLteu_s_jXQ@mail.gmail.com>
In-Reply-To: CF6A88132359CE47947DB4C6E1709ED53C5505FB@ORSMSX122.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3699031305060483672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2018 at 11:39 PM Schmauss, Erik <erik.schmauss(a)intel.com>=
 wrote:

[cut]

> Hi,
>
> > I've queued this up, but I would like Bob and Erik to speak up too.
>
> Sorry for the late response.
>
> With the US holiday approaching, we need a little more time for us to loo=
k at this.
>
> There is a Kernel Bugzilla report on a similar issue and it would be nice=
 for us to have more time to look at this.
>
> Here are my thoughts so far:
>
> a.) I'm not sure about the changes for the IPMI and SMBus cases... It mig=
ht be fine.
> b.) This part of the specification needs a lot of work and we have reques=
ted for this portion to be re-written. The spec is incorrect and referencin=
g this as a part of the commit message might be confusing to people who loo=
k at it in the future...
>
> It would be better for us to hold off on this patch until next week when =
Bob and I can discuss in person.

OK, fair enough.

--===============3699031305060483672==--

