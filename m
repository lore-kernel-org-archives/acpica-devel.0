Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E16634169B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABB8A415EB
MIME-Version: 1.0
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-6-raag.jadav@intel.com>
 <ZTJYgnugWHwBhtxv@smile.fi.intel.com>
In-Reply-To: <ZTJYgnugWHwBhtxv@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Oct 2023 19:05:37 +0200
Message-ID: <CAJZ5v0gqFgkhPHudqYUdg8ZgbEtF0Jf1ATbYACYEq3fNyaDW2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH v1 5/8] ACPI: x86: use
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: mark.rutland@arm.com, len.brown@intel.com, will@kernel.org, linux-gpio@vger.kernel.org, Raag Jadav <raag.jadav@intel.com>, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mallikarjunappa.sangannavar@intel.com, acpica-devel@lists.linuxfoundation.org, linux-hwmon@vger.kernel.org, mika.westerberg@linux.intel.com, linux@roeck-us.net

On Fri, Oct 20, 2023 at 12:38=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Oct 20, 2023 at 02:17:29PM +0530, Raag Jadav wrote:
> > Convert manual _UID references to use standard ACPI helpers.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> ...
>
> > -                     if (!adev->pnp.unique_id ||
> > -                         strcmp(adev->pnp.unique_id, override_status_i=
ds[i].uid))
> > +                     if (!acpi_dev_uid_match(adev, override_status_ids=
[i].uid))
>
> The check for NULL argument inside that API does not affect the behaviour=
 as
> otherwise it will be a crash with the current implementation.

What current implementation do you mean, exactly?
