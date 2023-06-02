Return-Path: <david.e.box@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 58AE440280
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8ACCB401B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685668141; x=1717204141;
 h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=chfMVfnhp5j03xinVitce1S1i2pv18p9kLtJKoM0g+I=;
 b=FJfxuU0rSHVWF3g0zgzEv1POgrCZfBow08kSo2MhTh1G1HuPBxrr5RId
 94JT5DCXCWIVRJlXQVWHgITzwdOCZBwPSTFQ9BQrhQ0nHvqUxCuoFD7RB
 c3pgpZgGEnk1r2wBv4F4NUvzWNTkCAA3h27IlLCfwdyQrdFhvVE3++MU0
 TXHZVE/DUWEpSth7ZenwGAz70JgWQTkBq5lJuFwC5GcWLofQizOANG2zW
 /R0xzshOf7wYCmwnVbPtre0o0mHE2ViEema5axsohcY+VGCZ68Oeai/P0
 yQKZPvToQrUv77a16AcHoGWetMrqjNEFPzo/hPsvBnZ2F+N2hox3Qg4j8 g==;
Message-ID: <b067f6990c7e6e58c487770126a804500ce8a54a.camel@linux.intel.com>
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
Date: Thu, 01 Jun 2023 18:08:57 -0700
In-Reply-To: <20230601132137.301802-1-michal.wilczynski@intel.com>
References: <20230601132137.301802-1-michal.wilczynski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Acpica-devel] [PATCH v4 35/35] acpi/bus: Remove notify
	callback and flags
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Michal Wilczynski <michal.wilczynski@intel.com>, rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com, ira.weiny@intel.com, rui.zhang@intel.com, jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org, lars@metafoo.de, bleung@chromium.org, yu.c.chen@intel.com, hdegoede@redhat.com, markgross@kernel.org, luzmaximilian@gmail.com, corentin.chary@gmail.com, jprvita@gmail.com, cascardo@holoscopio.com, don@syst.com.br, pali@kernel.org, jwoithe@just42.net, matan@svgalib.org, kenneth.t.chan@gmail.com, malattia@linux.it, jeremy@system76.com, productdev@system76.com, herton@canonical.com, coproscefalo@gmail.com, tytso@mit.edu, Jason@zx2c4.com, robert.moore@intel.com
Cc: linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev, nvdimm@lists.linux.dev, linux-iio@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org

Hi Michal,

On Thu, 2023-06-01 at 15:21 +0200, Michal Wilczynski wrote:
> As callback has been replaced by drivers installing their handlers in
> .add it's presence is not useful anymore.
>=20
> Remove .notify callback and flags variable from struct acpi_driver,
> as they're not needed anymore.
>=20
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
> =C2=A0include/acpi/acpi_bus.h | 3 ---
> =C2=A01 file changed, 3 deletions(-)
>=20
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 7fb411438b6f..3326794d5b70 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -151,12 +151,10 @@ struct acpi_hotplug_context {
> =C2=A0
> =C2=A0typedef int (*acpi_op_add) (struct acpi_device * device);
> =C2=A0typedef void (*acpi_op_remove) (struct acpi_device *device);
> -typedef void (*acpi_op_notify) (struct acpi_device * device, u32 event);
> =C2=A0
> =C2=A0struct acpi_device_ops {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_op_add add;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_op_remove remove;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_op_notify notify;
> =C2=A0};
> =C2=A0
> =C2=A0#define ACPI_DRIVER_ALL_NOTIFY_EVENTS=C2=A0=C2=A00x1=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0/* system AND device events */
> @@ -165,7 +163,6 @@ struct acpi_driver {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char name[80];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char class[80];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct acpi_device_=
id *ids; /* Supported Hardware IDs */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int flags;

Can ACPI_DRIVER_ALL_NOTIFY_EVENTS be removed as well?

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct acpi_device_ops op=
s;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device_driver drv;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct module *owner;

