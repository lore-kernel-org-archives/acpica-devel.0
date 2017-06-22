Content-Type: multipart/mixed; boundary="===============7911050555986565155=="
MIME-Version: 1.0
From: Will Deacon <will.deacon at arm.com>
Subject: Re: [Devel] [PATCH v9 0/3] Cavium ThunderX2 SMMUv3 errata workarounds
Date: Thu, 22 Jun 2017 19:22:57 +0100
Message-ID: <20170622182257.GI15336@arm.com>
In-Reply-To: 1498133138-20244-1-git-send-email-gakula@caviumnetworks.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7911050555986565155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2017 at 05:35:35PM +0530, Geetha sowjanya wrote:
> Cavium ThunderX2 SMMUv3 implementation has two Silicon Erratas.
> 1. Errata ID #74
>    SMMU register alias Page 1 is not implemented
> 2. Errata ID #126
>    SMMU doesnt support unique IRQ lines and also MSI for gerror,
>    eventq and cmdq-sync
> =

> The following patchset does software workaround for these two erratas.

I've picked up the first two patches, and left comments on the final patch.

Will

--===============7911050555986565155==--

