Content-Type: multipart/mixed; boundary="===============4034244497230077960=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: Re: [Devel] [PATCH 0/2] Make cppc acpi driver aware of pcc subspace
 ids
Date: Wed, 28 Jun 2017 23:20:13 +0200
Message-ID: <2438938.qNZk1AErMU@aspire.rjw.lan>
In-Reply-To: 1497363431-10002-1-git-send-email-george.cherian@cavium.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4034244497230077960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, June 13, 2017 02:17:09 PM George Cherian wrote:
> The current cppc acpi driver works with only one pcc subspace id.
> It maintains and registers only one pcc channel even if the acpi table ha=
s =

> different pcc subspace ids. =

> =

> As per ACPI 6.2 spec  all PCC registers, for all processors in the same =

> performance domain (as defined by _PSD), must be defined to be in the same
> subspace. The series tries to address the same by making cppc acpi driver =

> aware of multiple possible pcc subspace ids.
> =

> Patch 1 : In preparation to share the MAX_PCC_SUBSPACE definition with cp=
pc acpi
>           driver
> Patch 2 : Make the cppc acpi driver aware of multiple pcc subspace ids.
> =

> =

> George Cherian (2):
>   mailbox: PCC: Move the MAX_PCC_SUBSPACES definition to header file
>   ACPI / CPPC: Make cppc acpi driver aware of pcc subspace ids
> =

>  drivers/acpi/cppc_acpi.c | 179 +++++++++++++++++++++++++----------------=
------
>  drivers/mailbox/pcc.c    |   1 -
>  include/acpi/pcc.h       |   1 +
>  3 files changed, 97 insertions(+), 84 deletions(-)

I need Ashwing and Prashanth to look at this series and let me know what th=
ey
think.

Thanks,
Rafael


--===============4034244497230077960==--

