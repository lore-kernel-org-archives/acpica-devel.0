Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90ACD42563
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ACD9F4250A
MIME-Version: 1.0
References: <20230814135623.23084-1-yuehaibing@huawei.com>
In-Reply-To: <20230814135623.23084-1-yuehaibing@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Aug 2023 19:53:11 +0200
Message-ID: <CAJZ5v0j6_YFXyf7m7EVp7qNoy4RRhefsM0-VENBfJtDg09j7Sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH -next] ACPI: Remove unused declarations
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: linux-acpi@vger.kernel.org, robert.moore@intel.com, linux-kernel@vger.kernel.org, hdegoede@redhat.com, acpica-devel@lists.linuxfoundation.org, lenb@kernel.org

On Mon, Aug 14, 2023 at 3:56=E2=80=AFPM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> acpi_create_dir()/acpi_remove_dir() are never implemented since
> the beginning of git history.
> Commit f8d31489629c ("ACPICA: Debugger: Convert some mechanisms to OSPM s=
pecific")
> declared but never implemented acpi_run_debugger().
> Commit 781d737c7466 ("ACPI: Drop power resources driver")
> removed acpi_power_init() but not its declaration.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/acpi/internal.h | 1 -
>  include/acpi/acpi_bus.h | 2 --
>  include/acpi/acpixf.h   | 2 --
>  3 files changed, 5 deletions(-)
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 5f5c3a159872..866c7c4ed233 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -123,7 +123,6 @@ int __acpi_device_uevent_modalias(const struct acpi_d=
evice *adev,
>  /* ---------------------------------------------------------------------=
-----
>                                    Power Resource
>     ---------------------------------------------------------------------=
----- */
> -int acpi_power_init(void);
>  void acpi_power_resources_list_free(struct list_head *list);
>  int acpi_extract_power_resources(union acpi_object *package, unsigned in=
t start,
>                                  struct list_head *list);
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 23fbe4a16972..18203ee9096d 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -569,8 +569,6 @@ int acpi_match_device_ids(struct acpi_device *device,
>                           const struct acpi_device_id *ids);
>  void acpi_set_modalias(struct acpi_device *adev, const char *default_id,
>                        char *modalias, size_t len);
> -int acpi_create_dir(struct acpi_device *);
> -void acpi_remove_dir(struct acpi_device *);
>
>  static inline bool acpi_device_enumerated(struct acpi_device *adev)
>  {
> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
> index 0c1b69ad95d0..3d90716f9522 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -970,8 +970,6 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>                                                void **data,
>                                                void (*callback)(void *)))
>
> -void acpi_run_debugger(char *batch_buffer);
> -
>  void acpi_set_debugger_thread_id(acpi_thread_id thread_id);
>
>  #endif                         /* __ACXFACE_H__ */
> --

Applied (under edited subject) as 6.6 material, thanks!
