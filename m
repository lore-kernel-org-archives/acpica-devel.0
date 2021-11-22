Content-Type: multipart/mixed; boundary="===============0986975737444857337=="
MIME-Version: 1.0
From: Sudeep Holla <sudeep.holla at arm.com>
Subject: [Devel] Re: [PATCH 0/3] ACPI: Add support for PCC Operation Region
Date: Mon, 22 Nov 2021 17:59:08 +0000
Message-ID: <20211122175908.uprdvok2kruj4qko@bogus>
In-Reply-To: CAJZ5v0jL2+1rzqB2aAJ0T6w3md2dyuHWZNKOk+AbioeD-4ccDA@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0986975737444857337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rafael,


Thanks for the response, sorry for the delay as I was away.

On Fri, Nov 05, 2021 at 03:58:14PM +0100, Rafael J. Wysocki wrote:
> Hi Sudeep,
> =

> On Tue, Nov 2, 2021 at 7:26 PM Sudeep Holla <sudeep.holla(a)arm.com> wrot=
e:
> >
> > Hi,
> >
> > This series adds support for ACPI PCC OpRegion added in ACPI 6.3
> > I understand that the ACPICA changes need to go via different route,
> > but I am posting it together to give complete narative/picture for
> > the review/discussion.
> >
> > Regards,
> > Sudeep
> >
> > Sudeep Holla (3):
> >   ACPICA: Fix wrong interpretation of PCC address
> >   ACPICA: Add support for PCC Opregion special context data
> =

> The above two need to be submitted to the upstream project via GitHub
> at https://github.com/acpica/acpica
> =


Thanks for the info, I had a rough idea but posted these for reference here
anyways.

> The will be applicable to the Linux code base only after they have
> been accepted by the upstream.
>

Sure, I have now sent the pull request(https://github.com/acpica/acpica/pul=
l/735)

> >   ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subty=
pe
> =

> And this one will be applied when the above happens.
>

Make sense.

-- =

Regards,
Sudeep
--===============0986975737444857337==--

