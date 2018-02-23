Content-Type: multipart/mixed; boundary="===============5667520456438849590=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH 2/2] acpi: Avoid that acpi_ns_evaluate() triggers
 a soft lockup complaint
Date: Fri, 23 Feb 2018 11:08:03 +0100
Message-ID: <CAJZ5v0i8TZ7BRh0-sxPDd5iCkaDfqZbGSXrKHkj6XUcN0sDQjw@mail.gmail.com>
In-Reply-To: 20180223002219.21266-3-bart.vanassche@wdc.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5667520456438849590==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 1:22 AM, Bart Van Assche <bart.vanassche(a)wdc.com>=
 wrote:
> This patch avoids that the following is reported during boot with
> kmemleak and other kernel debugging options enabled:

Again, it would be sort of nice to explain why you want to fix the
issue this particular way.

We actually can't add cond_resched() to these code paths directly,
because the code in question comes from an external project, so we
need to understand the issue and see if it can be fixed differently.

> watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper:1]
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc7-00645-g248c211 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/0=
1/2014
> RIP: 0010:_raw_spin_unlock_irqrestore+0x43/0x51
> Call Trace:
>  free_debug_processing+0x273/0x35a
>  __slab_free+0x9d/0x613
>  qlist_free_all+0x68/0x89
>  quarantine_reduce+0x17c/0x1ad
>  kasan_kmalloc+0x23/0x8e
>  kmem_cache_alloc+0x143/0x1b4
>  acpi_ut_create_generic_state+0x54/0x8c
>  acpi_ut_create_update_state+0xe/0x9c
>  acpi_ut_create_update_state_and_push+0x13/0x31
>  acpi_ut_update_object_reference+0x243/0x40e
>  acpi_ds_clear_operands+0x8c/0xc4
>  acpi_ds_exec_end_op+0x5d3/0xbef
>  acpi_ps_parse_loop+0x107f/0x1108
>  acpi_ps_parse_aml+0x1e0/0x6a6
>  acpi_ps_execute_method+0x48d/0x4ea
>  acpi_ns_evaluate+0x665/0x857
>  acpi_ut_evaluate_object+0xdc/0x32a
>  acpi_rs_get_prt_method_data+0x64/0xa5
>  acpi_get_irq_routing_table+0x72/0x94
>  acpi_pci_irq_find_prt_entry+0x155/0x7f4
>  acpi_pci_irq_lookup+0x6e/0x46c
>  acpi_pci_irq_enable+0x161/0x461
>  do_pci_enable_device+0x85/0x143
>  pci_enable_device_flags+0x206/0x23c
>  virtio_pci_probe+0x17a/0x232
>  pci_device_probe+0x1a8/0x292
>  driver_probe_device+0x30c/0x644
>  __driver_attach+0xfa/0x139
>  bus_for_each_dev+0xf8/0x12e
>  bus_add_driver+0x29b/0x44e
>  driver_register+0x252/0x2c6
>  do_one_initcall+0xfc/0x212
>  kernel_init_freeable+0x25a/0x2ea
>  kernel_init+0x7/0xef
>  ret_from_fork+0x24/0x30
>
> Reported-by: Fenguang Wu <fengguang.wu(a)intel.com>
> Signed-off-by: Bart Van Assche <bart.vanassche(a)wdc.com>
> Cc: Fenguang Wu <fengguang.wu(a)intel.com>
> ---
>  drivers/acpi/acpica/psparse.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
> index 2474ff961294..482d7d5ac021 100644
> --- a/drivers/acpi/acpica/psparse.c
> +++ b/drivers/acpi/acpica/psparse.c
> @@ -694,6 +694,8 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state =
*walk_state)
>                 }
>
>                 acpi_ds_delete_walk_state(previous_walk_state);
> +
> +               cond_resched();
>         }
>
>         /* Normal exit */
> --
> 2.16.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo(a)vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--===============5667520456438849590==--

