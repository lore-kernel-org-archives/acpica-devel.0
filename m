Content-Type: multipart/mixed; boundary="===============6687040973057570596=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] [PATCH 2/4] ACPICA: Introduce new
 acpi_os_physical_table_add OS callback
Date: Wed, 05 Mar 2014 16:12:12 +0000
Message-ID: <2930767.eZaJX0jVGm@skinner>
In-Reply-To: 1AE640813FDE7649BE1B193DEA596E88024BDA9C@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6687040973057570596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, March 05, 2014 06:26:54 AM Zheng, Lv wrote:
... =

> > > After the table manager cleanups are tested and shipped in the ACPICA
> > > repo,
> > > the new facilities will automatically be rolled into Linux branches.
> > =

> > I'd suggest to just wait for that.
> > Best already try to integrate the ACPI table override/add part as you
> > think
> > it should work without additional changes in drivers/acpi/acpica.
> > =

> > If this happened and things are submitted to get integrated into the Li=
nux
> > kernel, please add me to CC or point me to the patchset.
> =

> Fortunately, there is a kernel bugzilla entry requires this series.
> I've posted it on the kernel bugzilla.
> Here is the patchset:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D69711
> You need to apply 9 patches:
> attachment 128061 - attachment 128141
> The last patch has introduced an early boot API:
> acpi_install_table.
> This can be used to enhance this series.

Ok, thanks.
Be aware that I am super busy right now. This week is impossible,
I cannot promise when I will have time for that.

      Thomas

--===============6687040973057570596==--

