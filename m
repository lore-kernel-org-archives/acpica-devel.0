Return-Path: <michael.brunner@kontron.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D770A831FB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86DE28321B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+gK5lxHggi6XM8QH7wGYCeRVtdvdEw/0UFE067mnhc=;
 b=bDGoYRentvxRc1kNjUA4GXwrZnm7/Tnxt3hoH4Q3rB1tjY16CbNOXTfiKi3LhVRcOhxFPNWyg9MzW/er0oEfVE/DoRFMIKO5lxc8h1LOo+ij6DF8yI2as1QaL/UtPczGePF7D3QMnUVHj0eIMjbuX2ig1se7gTkpa7hxcZqpAG8=
From: Michael Brunner <michael.brunner@kontron.com>
Message-ID: <b9af5a068cc0b5e785c8e2ddfc70d811fd5929cd.camel@kontron.com>
References: <20230620163534.1042-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230620163534.1042-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <9998B04AC020E84CAE51280A9DA4449A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Acpica-devel] [PATCH v1 1/2] ACPI: platform: Ignore SMB0001
 only when it has resources
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Wed, 21 Jun 2023 07:46:48 -0000
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "acpica-devel@lists.linuxfoundation.org" <acpica-devel@lists.linuxfoundation.org>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "wsa@kernel.org" <wsa@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "andi.shyti@kernel.org" <andi.shyti@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "robert.moore@intel.com" <robert.moore@intel.com>

On Tue, 2023-06-20 at 19:35 +0300, Andy Shevchenko wrote:
> After switchind i2c-scmi driver to be a plaform one it stopped
> being enumerated on number of Kontron platformsm, because it's
> listed in the forbidden_id_list.
>=20
> To resolve the situation, split the list to generic one and
> another that holds devices that has to be skiped if and only if
> they have bogus resources attached (_CRS method returns some).
>=20
> Fixes: 03d4287add6e ("i2c: scmi: Convert to be a platform driver")
> Closes: https://lore.kernel.org/r/60c1756765b9a3f1eab0dcbd84f59f00fe1caf4=
8.camel@kontron.com
> Reported-by: Michael Brunner <michael.brunner@kontron.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Works as expected - the SMB0001 device shows up as platform device and
the i2c-scmi driver is enumerated again on the affected boards.
Thanks a lot!

Best regards,
  Michael Brunner
