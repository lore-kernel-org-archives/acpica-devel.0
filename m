Return-Path: <wsa@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B9D718230D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B842C82304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687499688;
 bh=4x5m2NOkm1ONDQeEAk8U0GRj1u+DD6HZrCVOefa7O8M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GN/DoF3jS29lcU/sishaTObRTVn/oy4Ud/smQzbtCGRZwcnCjteGPVGPnxvpTbn0J
 4z/HcpHAgbR+ywgupRY1BTSdUMvAUztIxwyuKqoDP+w1J3OCdm2IiSEo1SEakOtqpQ
 nqqPl+9UiDFv16Z4o9XmeBADIf0RY9gJvRZERIe/dUzPXe8h0LpiZkVJ7PeSM9ShzG
 y1AzNBUn6bb4fWf/9pKfeyqAYkwYQRGgaEboQhQdK90KKt8+BaSKTj/4qNKQEnHf2d
 yyTnRmfG0KL+NjMbofhke/5iaeDfaef2yvW/Ih3H1XJy62oAZOEusqw+mU21ANENpn
 4fFJTkgJ5x5YQ==
From: Wolfram Sang <wsa@kernel.org>
Message-ID: <ZJUzpKZhxbMQGxIs@shikoro>
References: <20230621151652.79579-1-andriy.shevchenko@linux.intel.com>
 <20230621151652.79579-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gSCcacDj0iRH67vA"
Content-Disposition: inline
In-Reply-To: <20230621151652.79579-2-andriy.shevchenko@linux.intel.com>
Subject: Re: [Acpica-devel] [PATCH v2 2/2] ACPI: platform: Move SMB0001 HID
 to the header and reuse
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Fri, 23 Jun 2023 05:54:51 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>


--gSCcacDj0iRH67vA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 06:16:52PM +0300, Andy Shevchenko wrote:
> There are at least two places in the kernel that are using
> the SMB0001 HID. Make it to be available via acpi_drivers.h
> header file. While at it, replace hard coded one with a
> definition.
>=20
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> Link: https://lore.kernel.org/r/20230620163534.1042-2-andriy.shevchenko@l=
inux.intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Wolfram Sang <wsa@kernel.org> # for I2C


--gSCcacDj0iRH67vA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmSVM6QACgkQFA3kzBSg
KbZMaBAAj1LX4jZ3OETdw1s8CLGCo5c/TWL6kqnV3KBLSvLK56w707AqjY2AmUP8
3aCHS0EQWr/xsgr/CRsbxS8fV7Bo9O8f3MwI0TvL0TXNZ+e0aYZsMzd8X5cldcSc
g/4pVzFb6sMX1hK9q2u+i5Cvkv1e9LO5znvFaUzfkbq4qVpOjNMaTHC+SPyXNNh+
Qcl4wTLzZ4SoQUfujrK73P2mlXu66AH5z4E05l6lsQvsERkb2WTYf3tDDfwg6arT
cwaLNxg85B4k0u5md117Or4mXa5+yprYk/Im2JYLNUs8+KsjVUzGYdjgLCNJmuf6
Pno+kFehoxJ3h5g3+Vtsv/vG6pMBn5/2G3CXoufy5zSvWEZND+DO0s+zazAqBok9
hkeFkwVxnlQuDoEFtM/RtnfJMEs3+h43sgALO0tsSvfuyMbKJnVswvkTFqn7wqBD
5OMlclP+WPfvz7nKTvVupWkN9Fuiss70EzTllDLZfldL2567JIWa3ODrdcLc4Y2S
GZc55h1UeB5oPAyAI+KJgtQe91VeGgKhKoqnXAUb9vUtZtk1DriYkCZXjP8zfcpB
ct5Qdl6QvYpijEg9L74+OYklgUJM9TwsPuMzviR741b7/bfTVPfon16pizt+VwAB
5GUcXDp1Ur9hv+QZROq02qzNg+YwZNwlF7KaYlR87U1RUbDg6cA=
=+g1q
-----END PGP SIGNATURE-----

--gSCcacDj0iRH67vA--
