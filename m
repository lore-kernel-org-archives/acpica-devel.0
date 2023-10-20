Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8CEE7705E7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0267D705E6
MIME-Version: 1.0
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-7-raag.jadav@intel.com>
In-Reply-To: <20231020084732.17130-7-raag.jadav@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Oct 2023 19:22:28 +0200
Message-ID: <CAJZ5v0g7kkFhk8tNp1PMxuKkS7jv5rp16X-jvK0kc1TO0NTwFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH v1 6/8] perf: qcom: use acpi_device_uid()
	for fetching _UID
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
Cc: mark.rutland@arm.com, len.brown@intel.com, linux-hwmon@vger.kernel.org, will@kernel.org, linux-gpio@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, robert.moore@intel.com, bala.senthil@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, acpica-devel@lists.linuxfoundation.org, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux@roeck-us.net

On Fri, Oct 20, 2023 at 10:48=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> =
wrote:
>
> Convert manual _UID references to use standard ACPI helpers.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/perf/qcom_l3_pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
> index 2887edb4eb0b..f16783d03db7 100644
> --- a/drivers/perf/qcom_l3_pmu.c
> +++ b/drivers/perf/qcom_l3_pmu.c
> @@ -742,8 +742,8 @@ static int qcom_l3_cache_pmu_probe(struct platform_de=
vice *pdev)
>
>         l3pmu =3D devm_kzalloc(&pdev->dev, sizeof(*l3pmu), GFP_KERNEL);
>         name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "l3cache_%s_%s",
> -                     acpi_dev_parent(acpi_dev)->pnp.unique_id,
> -                     acpi_dev->pnp.unique_id);
> +                     acpi_device_uid(acpi_dev_parent(acpi_dev)),
> +                     acpi_device_uid(acpi_dev));
>         if (!l3pmu || !name)
>                 return -ENOMEM;
>
> --

Applied as 6.7 material.

QCom perf maintainers, if you'd rather take this yourselves, please let me =
know.

Thanks!
