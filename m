Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A5F2060AB5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 402D860739
MIME-Version: 1.0
References: <20230703121411.69606-1-andriy.shevchenko@linux.intel.com>
 <20230703121411.69606-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230703121411.69606-6-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <CAJZ5v0hytwzAPBpnPZnvdU7GhK12P0PJbe9aD+eVrVJhkq1ayA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH v4 5/5] ACPI: scan: Provide symbol
	declarations
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Tue, 04 Jul 2023 17:21:56 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Wolfram Sang <wsa@kernel.org>, linux-acpi@vger.kernel.org, Michael Walle <michael@walle.cc>, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>

On Mon, Jul 3, 2023 at 2:14=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Compiler is not happy about a couple of symbols that, it thinks,
> are not declared:
>
>   warning: symbol 'acpi_device_lock' was not declared. Should it be stati=
c?
>   warning: symbol 'acpi_wakeup_device_list' was not declared. Should it b=
e static?
>
> Include "sleep.h" to have them explicitly declared and make
> the compiler happy.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I've just applied a patch from Ben Dooks making the exact same change.

> ---
>  drivers/acpi/scan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index ec1c9bec8bae..5b145f1aaa1b 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -23,6 +23,7 @@
>  #include <linux/dma-direct.h>
>
>  #include "internal.h"
> +#include "sleep.h"
>
>  #define ACPI_BUS_CLASS                 "system_bus"
>  #define ACPI_BUS_HID                   "LNXSYBUS"
> --
