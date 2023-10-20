Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 500864EE9C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3BDE4EE9F
MIME-Version: 1.0
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-5-raag.jadav@intel.com>
 <ZTJYK02w8HZg26eI@smile.fi.intel.com> <ZTJmnv6CsZUt0pIS@black.fi.intel.com>
In-Reply-To: <ZTJmnv6CsZUt0pIS@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Oct 2023 19:11:53 +0200
Message-ID: <CAJZ5v0jvAeibnXSq92CBd1uXUgRnvsP0kEqfL8Du552=LT1dog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH v1 4/8] ACPI: utils: use
	acpi_dev_uid_match() for matching _UID
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Raag Jadav <raag.jadav@intel.com>
Cc: mark.rutland@arm.com, len.brown@intel.com, linux-hwmon@vger.kernel.org, will@kernel.org, linux-gpio@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, acpica-devel@lists.linuxfoundation.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, mika.westerberg@linux.intel.com, linux@roeck-us.net

On Fri, Oct 20, 2023 at 1:38=E2=80=AFPM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> On Fri, Oct 20, 2023 at 01:36:27PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 20, 2023 at 02:17:28PM +0530, Raag Jadav wrote:
> > > Convert manual _UID references to use standard ACPI helpers.
> >
> > Yes, while not so obvious this is the correct replacement.
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> I think this is the only case which would suffer from the more obvious
> behaviour, i.e.
>
> bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
> {
>         const char *uid1 =3D acpi_device_uid(adev);
>
>         return uid1 && uid2 && !strcmp(uid1, uid2);
> }
>
> That said, we can't be particularly sure about it's potential future user=
s,
> especially when the usage will not be limited to just ACPI core since we'=
re
> exporting it.

I actually agree with this, so please switch over to the above.

The above is straightforward and easy to understand and if somebody
wants to treat uid2 =3D=3D NULL as a match, let them check that explicitly
before calling this function.
