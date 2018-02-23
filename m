Content-Type: multipart/mixed; boundary="===============2894730496781992367=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH 1/2] acpi: Avoid soft lockup complaints during boot
Date: Fri, 23 Feb 2018 11:05:47 +0100
Message-ID: <CAJZ5v0g+4JzFVQTxkNagbYMvQ6X5=aGUVg1BsmUGB4b4m2Xuog@mail.gmail.com>
In-Reply-To: 20180223002219.21266-2-bart.vanassche@wdc.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2894730496781992367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 1:22 AM, Bart Van Assche <bart.vanassche(a)wdc.com>=
 wrote:
> Avoid that the following is reported during boot with kmemleak
> enabled:

OK, so why is this fix the right one in your view?

> NMI watchdog: BUG: soft lockup - CPU#0 stuck for 21s! [swapper/0:1]
> Modules linked in:
> irq event stamp: 18944138
> hardirqs last  enabled at (18944137): [<ffffffff810ac8ac>] __raw_spin_loc=
k_init+0x1c/0x50
> hardirqs last disabled at (18944138): [<ffffffff815b2fe4>] apic_timer_int=
errupt+0x84/0x90
> softirqs last  enabled at (18940166): [<ffffffff8105e59b>] __do_softirq+0=
x1cb/0x230
> softirqs last disabled at (18940161): [<ffffffff8105e788>] irq_exit+0xa8/=
0xb0
> RIP: print_context_stack+0x7b/0xc0
> Call Trace:
>  [<ffffffff8101ccb6>] dump_trace+0x116/0x300
>  [<ffffffff81028726>] save_stack_trace+0x26/0x50
>  [<ffffffff811939f7>] create_object+0x137/0x2d0
>  [<ffffffff815a7509>] kmemleak_alloc+0x49/0xa0
>  [<ffffffff811789c5>] kmem_cache_alloc+0xd5/0x190
>  [<ffffffff8137d204>] acpi_ut_allocate_object_desc_dbg+0x57/0x101
>  [<ffffffff8137d399>] acpi_ut_create_internal_object_dbg+0x4e/0x10f
>  [<ffffffff8134f2df>] acpi_ds_build_internal_object+0x201/0x2b3
>  [<ffffffff8134f4fa>] acpi_ds_build_internal_package_obj+0x169/0x281
>  [<ffffffff81350043>] acpi_ds_eval_data_object_operands+0x13d/0x1db
>  [<ffffffff81351877>] acpi_ds_exec_end_op+0x41f/0x6be
>  [<ffffffff81371876>] acpi_ps_parse_loop+0x7e8/0x884
>  [<ffffffff81372ade>] acpi_ps_parse_aml+0x1ab/0x48e
>  [<ffffffff8134b762>] acpi_ds_execute_arguments+0x183/0x1ca
>  [<ffffffff8134bbf6>] acpi_ds_get_package_arguments+0xf3/0x11c
>  [<ffffffff8136b142>] acpi_ns_init_one_object+0xb0/0xfc
>  [<ffffffff8136f140>] acpi_ns_walk_namespace+0x120/0x271
>  [<ffffffff8136fa20>] acpi_walk_namespace+0xf4/0x13f
>  [<ffffffff8136b4fa>] acpi_ns_initialize_objects+0x103/0x1f0
>  [<ffffffff81af548a>] acpi_load_tables+0xa5/0xf4
>  [<ffffffff81af3ec0>] acpi_init+0x7e/0x29c
>  [<ffffffff81000418>] do_one_initcall+0x38/0x150
>  [<ffffffff81ac7076>] kernel_init_freeable+0x1b1/0x239
>  [<ffffffff815a4c39>] kernel_init+0x9/0x100
>  [<ffffffff815b25ef>] ret_from_fork+0x1f/0x40
>
> Signed-off-by: Bart Van Assche <bart.vanassche(a)sandisk.com>
> ---
>  drivers/acpi/acpica/nswalk.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
> index dd7ae1bc8af8..358969f5afe1 100644
> --- a/drivers/acpi/acpica/nswalk.c
> +++ b/drivers/acpi/acpica/nswalk.c
> @@ -350,6 +350,7 @@ acpi_ns_walk_namespace(acpi_object_type type,
>
>                         node_previously_visited =3D TRUE;
>                 }
> +               cond_resched();
>         }
>
>         /* Complete walk, not terminated by user function */
> --
> 2.16.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo(a)vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--===============2894730496781992367==--

