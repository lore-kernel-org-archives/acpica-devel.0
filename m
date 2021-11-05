Content-Type: multipart/mixed; boundary="===============0292853616263530717=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 0/3] ACPI: Add support for PCC Operation Region
Date: Fri, 05 Nov 2021 15:58:14 +0100
Message-ID: <CAJZ5v0jL2+1rzqB2aAJ0T6w3md2dyuHWZNKOk+AbioeD-4ccDA@mail.gmail.com>
In-Reply-To: 20211102182542.3460787-1-sudeep.holla@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0292853616263530717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sudeep,

On Tue, Nov 2, 2021 at 7:26 PM Sudeep Holla <sudeep.holla(a)arm.com> wrote:
>
> Hi,
>
> This series adds support for ACPI PCC OpRegion added in ACPI 6.3
> I understand that the ACPICA changes need to go via different route,
> but I am posting it together to give complete narative/picture for
> the review/discussion.
>
> Regards,
> Sudeep
>
> Sudeep Holla (3):
>   ACPICA: Fix wrong interpretation of PCC address
>   ACPICA: Add support for PCC Opregion special context data

The above two need to be submitted to the upstream project via GitHub
at https://github.com/acpica/acpica

The will be applicable to the Linux code base only after they have
been accepted by the upstream.

>   ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype

And this one will be applied when the above happens.

Thanks!
--===============0292853616263530717==--

