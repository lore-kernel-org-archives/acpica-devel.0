Content-Type: multipart/mixed; boundary="===============7014175998890571468=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] Re: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
Date: Thu, 25 Mar 2021 15:54:51 +0000
Message-ID: <acfab98e75434a59910cf56336c54ba2@huawei.com>
In-Reply-To: CABdtJHtZPyWpXN9JZbgdu=HswreTc2o2pRhrwHFzQJqz-kFSBw@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7014175998890571468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Jon Nettleton [mailto:jon(a)solid-run.com]
> Sent: 25 March 2021 08:40
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>
> Cc: erik.kaneda(a)intel.com; linux-arm-kernel(a)lists.infradead.org;
> linux-acpi(a)vger.kernel.org; iommu(a)lists.linux-foundation.org;
> devel(a)acpica.org; Lorenzo Pieralisi <lorenzo.pieralisi(a)arm.com>;
> robert.moore(a)intel.com; Linuxarm <linuxarm(a)huawei.com>;
> steven.price(a)arm.com; Guohanjun (Hanjun Guo) <guohanjun(a)huawei.com>;
> Sami.Mujawar(a)arm.com; robin.murphy(a)arm.com; wanghuiqiang
> <wanghuiqiang(a)huawei.com>
> Subject: Re: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E

[...]

> Well it was a released revision, although it was found to have issues.
> Currently
> HoneyComb Systems Ready certified firmware does include support for this
> table,
> although incomplete.  Without agreement on mainline support I am fine to
> update
> to the latest spec bump.

Ok. Sorry didn=E2=80=99t know that you already had a firmware with that rev=
ision.
Thanks for agreeing to update to latest.

> >
> > So could you please revert the merge and I am planning to work on the E=
.b
> soon.
> > Please let me know if I need to explicitly send a revert pull request o=
r not.
> =

> Can you please CC. me on your next release.  I was planning on spending t=
ime
> on this regardless.  I already have a patchset for the fsl-mc-bus driver =
that
> needs to change in order to function properly with RMR support.

Sure. Will CC you.

Hi All,

I have send pull requests to acpica git for reverting rev E and to update i=
t with E.b,

https://github.com/acpica/acpica/pull/682

Please take a look and let me know.

Thanks,
Shameer

--===============7014175998890571468==--

