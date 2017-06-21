Content-Type: multipart/mixed; boundary="===============5989503333652928740=="
MIME-Version: 1.0
From: Robert Richter <robert.richter at cavium.com>
Subject: Re: [Devel] [PATCH v8 3/3] iommu/arm-smmu-v3: Add workaround for
 Cavium ThunderX2 erratum #126
Date: Wed, 21 Jun 2017 20:19:47 +0200
Message-ID: <20170621181947.GH16981@rric.localdomain>
In-Reply-To: 1497968259-16390-4-git-send-email-gakula@caviumnetworks.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5989503333652928740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 20.06.17 19:47:39, Geetha sowjanya wrote:
> From: Geetha Sowjanya <geethasowjanya.akula(a)cavium.com>
> =

> Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
> lines for gerror, eventq and cmdq-sync.
> =

> SHARED_IRQ option is set as a errata workaround, which allows to share th=
e irq
> line by register single irq handler for all the interrupts.

I found the entry in silicon-errata.txt missing, is that on purpose?

-Robert

> =

> Signed-off-by: Geetha sowjanya <gakula(a)caviumnetworks.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    5 ++
>  drivers/iommu/arm-smmu-v3.c                        |   73 ++++++++++++++=
++----
>  2 files changed, 64 insertions(+), 14 deletions(-)

--===============5989503333652928740==--

