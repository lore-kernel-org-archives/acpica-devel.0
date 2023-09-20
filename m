Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3936B61382
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D414461373
MIME-Version: 1.0
References: <20230920162222.3614-1-mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230920162222.3614-1-mirsad.todorovac@alu.unizg.hr>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <CAJZ5v0iLjOYBGcANrziRghZTPqHrPhJksB=oV9tRJYctWJ=CvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH v3 1/1] ACPICA: utdebug: use spinlocks to
 fix the data-races reported by the KCSAN
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Wed, 20 Sep 2023 17:03:41 -0000
To: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Erik Kaneda <erik.kaneda@intel.com>, kernel test robot <lkp@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Jung-uk Kim <jkim@freebsd.org>, Len Brown <lenb@kernel.org>

On Wed, Sep 20, 2023 at 6:30=E2=80=AFPM Mirsad Goran Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:
>
> KCSAN reported hundreds of instances of data-races in ACPICA like this on=
e:
>
> [    6.994149] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    6.994443] BUG: KCSAN: data-race in acpi_ut_status_exit / acpi_ut_tra=
ce
>
> [    6.994795] write to 0xffffffffbae5a884 of 4 bytes by task 0 on cpu 2:
> [    6.994944] acpi_ut_status_exit (/home/marvin/linux/kernel/torvalds2/d=
rivers/acpi/acpica/utdebug.c:467)
> [    6.994957] acpi_hw_register_read (/home/marvin/linux/kernel/torvalds2=
/drivers/acpi/acpica/hwregs.c:563)
> [    6.994968] acpi_read_bit_register (/home/marvin/linux/kernel/torvalds=
2/drivers/acpi/acpica/hwxface.c:171)
> [    6.994980] acpi_idle_bm_check (/home/marvin/linux/kernel/torvalds2/dr=
ivers/acpi/processor_idle.c:511)
> [    6.994990] acpi_idle_enter_bm (/home/marvin/linux/kernel/torvalds2/dr=
ivers/acpi/processor_idle.c:644 (discriminator 1))
> [    6.995000] acpi_idle_enter (/home/marvin/linux/kernel/torvalds2/drive=
rs/acpi/processor_idle.c:695)
> [    6.995010] cpuidle_enter_state (/home/marvin/linux/kernel/torvalds2/d=
rivers/cpuidle/cpuidle.c:267)
> [    6.995019] cpuidle_enter (/home/marvin/linux/kernel/torvalds2/drivers=
/cpuidle/cpuidle.c:390)
> [    6.995027] call_cpuidle (/home/marvin/linux/kernel/torvalds2/kernel/s=
ched/idle.c:135)
> [    6.995038] do_idle (/home/marvin/linux/kernel/torvalds2/kernel/sched/=
idle.c:219 /home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:282)
> [    6.995046] cpu_startup_entry (/home/marvin/linux/kernel/torvalds2/ker=
nel/sched/idle.c:378 (discriminator 1))
> [    6.995055] start_secondary (/home/marvin/linux/kernel/torvalds2/arch/=
x86/kernel/smpboot.c:210 /home/marvin/linux/kernel/torvalds2/arch/x86/kerne=
l/smpboot.c:294)
> [    6.995066] secondary_startup_64_no_verify (/home/marvin/linux/kernel/=
torvalds2/arch/x86/kernel/head_64.S:433)
>
> [    6.995121] read to 0xffffffffbae5a884 of 4 bytes by task 0 on cpu 9:
> [    6.995267] acpi_ut_trace (/home/marvin/linux/kernel/torvalds2/drivers=
/acpi/acpica/utdebug.c:263)
> [    6.995279] acpi_hw_validate_io_request (/home/marvin/linux/kernel/tor=
valds2/drivers/acpi/acpica/hwvalid.c:101)
> [    6.995291] acpi_hw_read_port (/home/marvin/linux/kernel/torvalds2/dri=
vers/acpi/acpica/hwvalid.c:202)
> [    6.995303] acpi_hw_read (/home/marvin/linux/kernel/torvalds2/drivers/=
acpi/acpica/hwregs.c:251)
> [    6.995313] acpi_hw_register_read (/home/marvin/linux/kernel/torvalds2=
/drivers/acpi/acpica/hwregs.c:725 /home/marvin/linux/kernel/torvalds2/drive=
rs/acpi/acpica/hwregs.c:499)
> [    6.995325] acpi_read_bit_register (/home/marvin/linux/kernel/torvalds=
2/drivers/acpi/acpica/hwxface.c:171)
> [    6.995336] acpi_idle_bm_check (/home/marvin/linux/kernel/torvalds2/dr=
ivers/acpi/processor_idle.c:511)
> [    6.995346] acpi_idle_enter_bm (/home/marvin/linux/kernel/torvalds2/dr=
ivers/acpi/processor_idle.c:644 (discriminator 1))
> [    6.995356] acpi_idle_enter (/home/marvin/linux/kernel/torvalds2/drive=
rs/acpi/processor_idle.c:695)
> [    6.995366] cpuidle_enter_state (/home/marvin/linux/kernel/torvalds2/d=
rivers/cpuidle/cpuidle.c:267)
> [    6.995375] cpuidle_enter (/home/marvin/linux/kernel/torvalds2/drivers=
/cpuidle/cpuidle.c:390)
> [    6.995383] call_cpuidle (/home/marvin/linux/kernel/torvalds2/kernel/s=
ched/idle.c:135)
> [    6.995394] do_idle (/home/marvin/linux/kernel/torvalds2/kernel/sched/=
idle.c:219 /home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:282)
> [    6.995402] cpu_startup_entry (/home/marvin/linux/kernel/torvalds2/ker=
nel/sched/idle.c:378 (discriminator 1))
> [    6.995411] start_secondary (/home/marvin/linux/kernel/torvalds2/arch/=
x86/kernel/smpboot.c:210 /home/marvin/linux/kernel/torvalds2/arch/x86/kerne=
l/smpboot.c:294)
> [    6.995422] secondary_startup_64_no_verify (/home/marvin/linux/kernel/=
torvalds2/arch/x86/kernel/head_64.S:433)
>
> [    6.995476] value changed: 0x00000004 -> 0x00000002
>
> [    6.995629] Reported by Kernel Concurrency Sanitizer on:
> [    6.995748] CPU: 9 PID: 0 Comm: swapper/9 Not tainted 6.6.0-rc2-kcsan-=
00003-g16819584c239-dirty #21
> [    6.995758] Hardware name: ASRock X670E PG Lightning/X670E PG Lightnin=
g, BIOS 1.21 04/26/2023
> [    6.995765] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Please find the complete list at: https://domac.alu.unizg.hr/~mtodorov/li=
nux/patches/acpica_utdebug/acpi_ut_status_exit.log.xz
>
> A number of unprotected increments:
>
>         acpi_gbl_nesting_level++;
>
> and conditional statements:
>
>         if (acpi_gbl_nesting_level) {
>                 acpi_gbl_nesting_level--;
>         }
>
> no longer work in SMP environment.
>
> Proper locking like
>
>         spin_lock(&acpi_utdebug_lock);
>         acpi_gbl_nesting_level++;
>         spin_unlock(&acpi_utdebug_lock);
>
> and
>
>         spin_lock(&acpi_utdebug_lock);
>         if (acpi_gbl_nesting_level) {
>                 acpi_gbl_nesting_level--;
>         }
>         spin_unlock(&acpi_utdebug_lock);
>
> makes these data-races go away.
>
> Additionally, READ_ONCE() or WRITE_ONCE() is required with the global var=
iable
> acpi_gbl_nesting_level to prevent unwanted read or write reordering or ot=
her funny
> stuff the optmisers do.
>
> The patch eliminates KCSAN BUG warnings.
>
> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Fixes: 6be2d72b18649 ("ACPICA: Update for a few debug output statements")
> Fixes: bf9b448ef8430 ("ACPICA: Debug output: Do not emit function nesting=
 level for kernel build.")
> Fixes: 6e875fa0480c1 ("ACPICA: Debugger: fix slight indentation issue")
> Fixes: ^1da177e4c3f4 ("Initial git repository build.")
> Cc: Jung-uk Kim <jkim@FreeBSD.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Erik Kaneda <erik.kaneda@intel.com>
> Cc: Bob Moore <robert.moore@intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: acpica-devel@lists.linuxfoundation.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309201331.S2c1JL2h-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202309201308.5ZBJFbjh-lkp@i=
ntel.com/
> Link: https://github.com/acpica/acpica/pull/893
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---
> v2 -> v3:
>  Made the pull request at the ACPICA github.
>  Fixed DEFINE_SPINLOCK() undefined warning by putting it inside #ifdef AC=
PI_DEBUG_OUTPUT
>  ... #endif
>  Capitalised ACPICA according to the convention.
>
> v1 -> v2:
>  Moved the declaration of 'u32 nesting_level' inside #ifdef ACPI_APPLICAT=
ION ... #endif
>  according to the unused variable warning of the kernel test robot.
>
> v1:
>  Preliminary RFC version of the patch.
>
>  drivers/acpi/acpica/utdebug.c | 49 +++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.=
c
> index c5f6c85a3a09..594eee294f0f 100644
> --- a/drivers/acpi/acpica/utdebug.c
> +++ b/drivers/acpi/acpica/utdebug.c
> @@ -15,8 +15,9 @@
>
>  #define _COMPONENT          ACPI_UTILITIES
>  ACPI_MODULE_NAME("utdebug")
> -
>  #ifdef ACPI_DEBUG_OUTPUT
> +static DEFINE_SPINLOCK(acpi_utdebug_lock);

No, you can't do that in the ACPICA code.  Likewise for other
Linux-specific pieces of code in the patch below.

I'd very much prefer you to send a proper problem report instead of
sending patches like this.

As it stands, I'm not even sure what problem exactly this is
attempting to address.

Thanks!
