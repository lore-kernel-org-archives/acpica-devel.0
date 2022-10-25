Content-Type: multipart/mixed; boundary="===============2451366078788124450=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] apei/ghes: Use xchg_release() for updating new
 cache slot instead of cmpxchg()
Date: Tue, 25 Oct 2022 20:28:37 +0200
Message-ID: <CAJZ5v0gvHZ7WwyC5F2y3NTEno8J-VLdAOp-JjohON7MNnbmt6g@mail.gmail.com>
In-Reply-To: Y1ayrYZgLqjp7WOG@zn.tnic
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2451366078788124450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 24, 2022 at 5:43 PM Borislav Petkov <bp(a)alien8.de> wrote:
>
> Ok,
>
> here's what I've done to it, holler if something's still missing.
>
> @rjw, if you wanna take this through your tree, it should work too - it
> is unrelated to the ghes_edac changes we're doing. Or I can carry it,
> whatever you prefer.

I think I can take it.

Is this urgent or is it OK to queue it up for 6.2?

> ---
> From: Ard Biesheuvel <ardb(a)kernel.org>
>
> Some documentation first, about how this machinery works:
>
> It seems, the intent of the GHES error records cache is to collect
> already reported errors - see the ghes_estatus_cached() checks. There's
> even a sentence trying to say what this does:
>
>   /*
>    * GHES error status reporting throttle, to report more kinds of
>    * errors, instead of just most frequently occurred errors.
>    */
>
> New elements are added to the cache this way:
>
>   if (!ghes_estatus_cached(estatus)) {
>           if (ghes_print_estatus(NULL, ghes->generic, estatus))
>                   ghes_estatus_cache_add(ghes->generic, estatus);
>
> The intent being, once this new error record is reported, it gets cached
> so that it doesn't get reported for a while due to too many, same-type
> error records getting reported in burst-like scenarios. I.e., new,
> unreported error types can have a higher chance of getting reported.
>
> Now, the loop in ghes_estatus_cache_add() is trying to pick out the
> oldest element in there. Meaning, something which got reported already
> but a long while ago, i.e., a LRU-type scheme.
>
> And the cmpxchg() is there presumably to make sure when that selected
> element slot_cache is removed, it really *is* that element that gets
> removed and not one which replaced it in the meantime.
>
> Now, ghes_estatus_cache_add() selects a slot, and either succeeds in
> replacing its contents with a pointer to a newly cached item, or it just
> gives up and frees the new item again, without attempting to select
> another slot even if one might be available.
>
> Since only inserting new items is being done here, the race can only
> cause a failure if the selected slot was updated with another new item
> concurrently, which means that it is arbitrary which of those two items
> gets dropped.
>
> And "dropped" here means, the item doesn't get added to the cache so
> the next time it is seen, it'll get reported again and an insertion
> attempt will be done again. Eventually, it'll get inserted and all those
> times when the insertion fails, the item will get reported although the
> cache is supposed to prevent that and "ratelimit" those repeated error
> records. Not a big deal in any case.
>
> This means the cmpxchg() and the special case are not necessary.
> Therefore, just drop the existing item unconditionally.
>
> Move the xchg_release() and call_rcu() out of rcu_read_lock/unlock
> section since there is no actually dereferencing the pointer at all.
>
>   [ bp:
>     - Flesh out and summarize what was discussed on the thread now
>       that that cache contraption is understood;
>     - Touch up code style. ]
>
> Co-developed-by: Jia He <justin.he(a)arm.com>
> Signed-off-by: Jia He <justin.he(a)arm.com>
> Signed-off-by: Ard Biesheuvel <ardb(a)kernel.org>
> Signed-off-by: Borislav Petkov <bp(a)suse.de>
> Link: https://lore.kernel.org/r/20221010023559.69655-7-justin.he(a)arm.com
> ---
>  drivers/acpi/apei/ghes.c | 60 ++++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 249cd01cb920..6164bf737ee6 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -154,7 +154,7 @@ struct ghes_vendor_record_entry {
>  static struct gen_pool *ghes_estatus_pool;
>  static unsigned long ghes_estatus_pool_size_request;
>
> -static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHE=
S_SIZE];
> +static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS=
_CACHES_SIZE];
>  static atomic_t ghes_estatus_cache_alloced;
>
>  static int ghes_panic_timeout __read_mostly =3D 30;
> @@ -789,48 +789,42 @@ static struct ghes_estatus_cache *ghes_estatus_cach=
e_alloc(
>         return cache;
>  }
>
> -static void ghes_estatus_cache_free(struct ghes_estatus_cache *cache)
> +static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
>  {
> +       struct ghes_estatus_cache *cache;
>         u32 len;
>
> +       cache =3D container_of(head, struct ghes_estatus_cache, rcu);
>         len =3D cper_estatus_len(GHES_ESTATUS_FROM_CACHE(cache));
>         len =3D GHES_ESTATUS_CACHE_LEN(len);
>         gen_pool_free(ghes_estatus_pool, (unsigned long)cache, len);
>         atomic_dec(&ghes_estatus_cache_alloced);
>  }
>
> -static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
> -{
> -       struct ghes_estatus_cache *cache;
> -
> -       cache =3D container_of(head, struct ghes_estatus_cache, rcu);
> -       ghes_estatus_cache_free(cache);
> -}
> -
> -static void ghes_estatus_cache_add(
> -       struct acpi_hest_generic *generic,
> -       struct acpi_hest_generic_status *estatus)
> +static void
> +ghes_estatus_cache_add(struct acpi_hest_generic *generic,
> +                      struct acpi_hest_generic_status *estatus)
>  {
> -       int i, slot =3D -1, count;
>         unsigned long long now, duration, period, max_period =3D 0;
> -       struct ghes_estatus_cache *cache, *slot_cache =3D NULL, *new_cach=
e;
> +       struct ghes_estatus_cache *cache, *new_cache;
> +       struct ghes_estatus_cache __rcu *victim;
> +       int i, slot =3D -1, count;
>
>         new_cache =3D ghes_estatus_cache_alloc(generic, estatus);
> -       if (new_cache =3D=3D NULL)
> +       if (!new_cache)
>                 return;
> +
>         rcu_read_lock();
>         now =3D sched_clock();
>         for (i =3D 0; i < GHES_ESTATUS_CACHES_SIZE; i++) {
>                 cache =3D rcu_dereference(ghes_estatus_caches[i]);
>                 if (cache =3D=3D NULL) {
>                         slot =3D i;
> -                       slot_cache =3D NULL;
>                         break;
>                 }
>                 duration =3D now - cache->time_in;
>                 if (duration >=3D GHES_ESTATUS_IN_CACHE_MAX_NSEC) {
>                         slot =3D i;
> -                       slot_cache =3D cache;
>                         break;
>                 }
>                 count =3D atomic_read(&cache->count);
> @@ -839,18 +833,30 @@ static void ghes_estatus_cache_add(
>                 if (period > max_period) {
>                         max_period =3D period;
>                         slot =3D i;
> -                       slot_cache =3D cache;
>                 }
>         }
> -       /* new_cache must be put into array after its contents are writte=
n */
> -       smp_wmb();
> -       if (slot !=3D -1 && cmpxchg(ghes_estatus_caches + slot,
> -                                 slot_cache, new_cache) =3D=3D slot_cach=
e) {
> -               if (slot_cache)
> -                       call_rcu(&slot_cache->rcu, ghes_estatus_cache_rcu=
_free);
> -       } else
> -               ghes_estatus_cache_free(new_cache);
>         rcu_read_unlock();
> +
> +       if (slot !=3D -1) {
> +               /*
> +                * Use release semantics to ensure that ghes_estatus_cach=
ed()
> +                * running on another CPU will see the updated cache fiel=
ds if
> +                * it can see the new value of the pointer.
> +                */
> +               victim =3D xchg_release(&ghes_estatus_caches[slot],
> +                                     RCU_INITIALIZER(new_cache));
> +
> +               /*
> +                * At this point, victim may point to a cached item diffe=
rent
> +                * from the one based on which we selected the slot. Inst=
ead of
> +                * going to the loop again to pick another slot, let's ju=
st
> +                * drop the other item anyway: this may cause a false cac=
he
> +                * miss later on, but that won't cause any problems.
> +                */
> +               if (victim)
> +                       call_rcu(&unrcu_pointer(victim)->rcu,
> +                                ghes_estatus_cache_rcu_free);
> +       }
>  }
>
>  static void __ghes_panic(struct ghes *ghes,
> --
> 2.35.1
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
--===============2451366078788124450==--

