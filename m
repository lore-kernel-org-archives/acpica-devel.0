Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A47E94015F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E60ED400DA
MIME-Version: 1.0
References: <20230626110026.65825-1-andriy.shevchenko@linux.intel.com>
 <20230626110026.65825-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jqP0N3=TB3w+HMwGMzctpRCjKa3a5iHKePP113T3CK-g@mail.gmail.com>
 <ZJ1KHJW6Jhma/rHc@smile.fi.intel.com>
In-Reply-To: <ZJ1KHJW6Jhma/rHc@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <CAJZ5v0hf49hneyE7a-qjcdUBBhtvPUhkM6XorecaOrSjn=PbAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH v3 1/4] ACPI: bus: Constify
 acpi_companion_match() returned value
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Thu, 29 Jun 2023 09:43:45 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Michael Walle <michael@walle.cc>, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>

On Thu, Jun 29, 2023 at 11:08=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jun 29, 2023 at 10:49:17AM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jun 26, 2023 at 1:00=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > acpi_companion_match() doesn't alter the contents of the passed
> > > parameter, so we don't expect that returned value can be altered
> > > either. So constify it.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > This makes sense even without the rest of the series, so I can queue
> > it up right away if you want me to do that.
>
> Please, go ahead and thank you!

Done, thanks!
