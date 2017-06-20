Content-Type: multipart/mixed; boundary="===============5613839599258278659=="
MIME-Version: 1.0
From: Will Deacon <will.deacon at arm.com>
Subject: Re: [Devel] [PATCH v8 1/3] ACPI/IORT: Fixup SMMUv3 resource size for
 Cavium ThunderX2 SMMUv3 model
Date: Tue, 20 Jun 2017 19:01:02 +0100
Message-ID: <20170620180101.GD28035@arm.com>
In-Reply-To: 1497968259-16390-2-git-send-email-gakula@caviumnetworks.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5613839599258278659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2017 at 07:47:37PM +0530, Geetha sowjanya wrote:
> From: Linu Cherian <linu.cherian(a)cavium.com>
> =

> Cavium ThunderX2 implementation doesn't support second page in SMMU
> register space. Hence, resource size is set as 64k for this model.
> =

> Signed-off-by: Linu Cherian <linu.cherian(a)cavium.com>
> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula(a)cavium.com>
> ---
>  drivers/acpi/arm64/iort.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)

Looks fine to me, but I need Lorenzo's ack on this.

Will

--===============5613839599258278659==--

