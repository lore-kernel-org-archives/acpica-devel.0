Return-Path: <michael.brunner@kontron.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A35A81F8A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3AC1B81F77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWIHgjsj2Su0hQLjtNlAFWaXlhkWN8rxSwfV9gyv09M=;
 b=CtaVX1ZMuIkJ0otRDJvst97bz0uB2pQsF1Rmj27SGiA/6MbRvqLsErq0ORQhQ50kjqy3ZxUt3gfXbxjsVgdBoti750rhJFqyG3RnlQMqUVE8ANedoVLdRaN1lCp8/Mrs0Y4fGwdlrfUbp3TL4ZVwF+UtYlRP32dhHfJRIn8yOWo=
From: Michael Brunner <michael.brunner@kontron.com>
Message-ID: <fcee65cded553de501a4b22380e49c1914f63799.camel@kontron.com>
References: <20230620163534.1042-1-andriy.shevchenko@linux.intel.com>
 <b9af5a068cc0b5e785c8e2ddfc70d811fd5929cd.camel@kontron.com>
 <20230621093056.5qfa3kn7ldgwsyeg@intel.intel>
 <ZJL4/X1Z9gCdESxp@smile.fi.intel.com>
In-Reply-To: <ZJL4/X1Z9gCdESxp@smile.fi.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <FA38881922A2C74B9499C211422F61AB@EURPRD10.PROD.OUTLOOK.COM>
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
Date: Wed, 21 Jun 2023 13:28:53 -0000
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "andi.shyti@kernel.org" <andi.shyti@kernel.org>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robert.moore@intel.com" <robert.moore@intel.com>, "wsa@kernel.org" <wsa@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "acpica-devel@lists.linuxfoundation.org" <acpica-devel@lists.linuxfoundation.org>, "lenb@kernel.org" <lenb@kernel.org>

On Wed, 2023-06-21 at 16:19 +0300, andriy.shevchenko@linux.intel.com
wrote:
> On Wed, Jun 21, 2023 at 11:30:56AM +0200, Andi Shyti wrote:
> > On Wed, Jun 21, 2023 at 07:46:42AM +0000, Michael Brunner wrote:
> > > On Tue, 2023-06-20 at 19:35 +0300, Andy Shevchenko wrote:
> > > > After switchind i2c-scmi driver to be a plaform one it stopped
> > > > being enumerated on number of Kontron platformsm, because it's
> > > > listed in the forbidden_id_list.
> > > >
> > > > To resolve the situation, split the list to generic one and
> > > > another that holds devices that has to be skiped if and only if
> > > > they have bogus resources attached (_CRS method returns some).
> > > >
> > > > Fixes: 03d4287add6e ("i2c: scmi: Convert to be a platform
> > > > driver")
> > > > Closes:
> > > > https://lore.kernel.org/r/60c1756765b9a3f1eab0dcbd84f59f00fe1caf48.=
camel@kontron.com
> > > > Reported-by: Michael Brunner <michael.brunner@kontron.com>
> > > > Signed-off-by: Andy Shevchenko <
> > > > andriy.shevchenko@linux.intel.com>
> > >
> > > Works as expected - the SMB0001 device shows up as platform
> > > device and
> > > the i2c-scmi driver is enumerated again on the affected boards.
> > > Thanks a lot!
> >
> > is this a "Tested-by: Michael Brunner <michael.brunner@kontron.com>
> > " :)
>
> Michael, indeed, it would be nice to have a formal tag.
> After that I will send a v2 with tags and fixed typos
> as Andi noticed (thank you, Andi!).

No problem:

Tested-by: Michael Brunner <michael.brunner@kontron.com>

Best regards,
  Michael
