Content-Type: multipart/mixed; boundary="===============3064201622288191614=="
MIME-Version: 1.0
From: kbuild test robot <fengguang.wu at intel.com>
Subject: [Devel] [pm:idle-tick 6/7] drivers/cpuidle//governors/menu.c:317:36:
 error: too many arguments to function 'tick_nohz_get_sleep_length'
Date: Tue, 20 Mar 2018 07:47:28 +0800
Message-ID: <201803200724.HeKmrWzp%fengguang.wu@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3064201622288191614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 idle-tick
head:   40331e907dcafa83382cdda585d9bf5a9e6b8a67
commit: e5233f0d22c78a47563c9c49d2ee4fe836772899 [6/7] cpuidle: menu: Refin=
e idle state selection for running tick
config: x86_64-randconfig-h0-03200551 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout e5233f0d22c78a47563c9c49d2ee4fe836772899
        # save the attached .config to linux build tree
        make ARCH=3Dx86_64 =


All errors (new ones prefixed by >>):

   drivers/cpuidle//governors/menu.c: In function 'menu_select':
>> drivers/cpuidle//governors/menu.c:317:36: error: too many arguments to f=
unction 'tick_nohz_get_sleep_length'
     data->next_timer_us =3D ktime_to_us(tick_nohz_get_sleep_length(&tick_t=
ime));
                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/cpuidle//governors/menu.c:19:0:
   include/linux/tick.h:145:23: note: declared here
    static inline ktime_t tick_nohz_get_sleep_length(void)
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/tick_nohz_get_sleep_length +317 drivers/cpuidle//governors/menu.c

   279	=

   280	/**
   281	 * menu_select - selects the next idle state to enter
   282	 * @drv: cpuidle driver containing state data
   283	 * @dev: the CPU
   284	 * @nohz_ret: indication on whether or not to stop the tick
   285	 */
   286	static int menu_select(struct cpuidle_driver *drv, struct cpuidle_de=
vice *dev,
   287			       bool *nohz_ret)
   288	{
   289		struct menu_device *data =3D this_cpu_ptr(&menu_devices);
   290		struct device *device =3D get_cpu_device(dev->cpu);
   291		int latency_req =3D pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
   292		int i;
   293		int first_idx;
   294		int idx;
   295		unsigned int interactivity_req;
   296		unsigned int expected_interval;
   297		unsigned long nr_iowaiters, cpu_load;
   298		int resume_latency =3D dev_pm_qos_raw_read_value(device);
   299		ktime_t tick_time;
   300	=

   301		if (data->needs_update) {
   302			menu_update(drv, dev);
   303			data->needs_update =3D 0;
   304		}
   305	=

   306		if (resume_latency < latency_req &&
   307		    resume_latency !=3D PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
   308			latency_req =3D resume_latency;
   309	=

   310		/* Special case when user has set very strict latency requirement */
   311		if (unlikely(latency_req =3D=3D 0)) {
   312			*nohz_ret =3D false;
   313			return 0;
   314		}
   315	=

   316		/* determine the expected residency time, round up */
 > 317		data->next_timer_us =3D ktime_to_us(tick_nohz_get_sleep_length(&tic=
k_time));
   318	=

   319		get_iowait_load(&nr_iowaiters, &cpu_load);
   320		data->bucket =3D which_bucket(data->next_timer_us, nr_iowaiters);
   321	=

   322		/*
   323		 * Force the result of multiplication to be 64 bits even if both
   324		 * operands are 32 bits.
   325		 * Make sure to round up for half microseconds.
   326		 */
   327		data->predicted_us =3D DIV_ROUND_CLOSEST_ULL((uint64_t)data->next_t=
imer_us *
   328						 data->correction_factor[data->bucket],
   329						 RESOLUTION * DECAY);
   330	=

   331		expected_interval =3D get_typical_interval(data);
   332		expected_interval =3D min(expected_interval, data->next_timer_us);
   333	=

   334		first_idx =3D 0;
   335		if (drv->states[0].flags & CPUIDLE_FLAG_POLLING) {
   336			struct cpuidle_state *s =3D &drv->states[1];
   337			unsigned int polling_threshold;
   338	=

   339			/*
   340			 * We want to default to C1 (hlt), not to busy polling
   341			 * unless the timer is happening really really soon, or
   342			 * C1's exit latency exceeds the user configured limit.
   343			 */
   344			polling_threshold =3D max_t(unsigned int, 20, s->target_residency);
   345			if (data->next_timer_us > polling_threshold &&
   346			    latency_req > s->exit_latency && !s->disabled &&
   347			    !dev->states_usage[1].disable)
   348				first_idx =3D 1;
   349		}
   350	=

   351		/*
   352		 * Use the lowest expected idle interval to pick the idle state.
   353		 */
   354		data->predicted_us =3D min(data->predicted_us, expected_interval);
   355	=

   356		/*
   357		 * Use the performance multiplier and the user-configurable
   358		 * latency_req to determine the maximum exit latency.
   359		 */
   360		interactivity_req =3D data->predicted_us / performance_multiplier(n=
r_iowaiters, cpu_load);
   361		if (latency_req > interactivity_req)
   362			latency_req =3D interactivity_req;
   363	=

   364		expected_interval =3D TICK_USEC_HZ;
   365		/*
   366		 * Find the idle state with the lowest power while satisfying
   367		 * our constraints.
   368		 */
   369		idx =3D -1;
   370		for (i =3D first_idx; i < drv->state_count; i++) {
   371			struct cpuidle_state *s =3D &drv->states[i];
   372			struct cpuidle_state_usage *su =3D &dev->states_usage[i];
   373	=

   374			if (s->disabled || su->disable)
   375				continue;
   376			if (idx =3D=3D -1)
   377				idx =3D i; /* first enabled state */
   378			if (s->target_residency > data->predicted_us) {
   379				/*
   380				 * Retain the tick if the selected state is shallower
   381				 * than the deepest available one with target residency
   382				 * within the tick period range.
   383				 *
   384				 * This allows the tick to be stopped even if the
   385				 * predicted idle duration is within the tick period
   386				 * range to counter the effect by which the prediction
   387				 * may be skewed towards lower values due to the tick
   388				 * bias.
   389				 */
   390				expected_interval =3D s->target_residency;
   391				break;
   392			}
   393			if (s->exit_latency > latency_req) {
   394				/*
   395				 * If we break out of the loop for latency reasons,
   396				 * retain the tick unless the target residency of the
   397				 * selected state is too high.
   398				 */
   399				expected_interval =3D drv->states[idx].target_residency;
   400				break;
   401			}
   402			idx =3D i;
   403		}
   404	=

   405		if (idx =3D=3D -1)
   406			idx =3D 0; /* No states enabled. Must use 0. */
   407	=

   408		/*
   409		 * Don't stop the tick if the selected state is a polling one or it=
 is
   410		 * not deep enough.
   411		 */
   412		if (drv->states[idx].flags & CPUIDLE_FLAG_POLLING) {
   413			*nohz_ret =3D false;
   414		} else if (expected_interval < TICK_USEC_HZ) {
   415			*nohz_ret =3D false;
   416	=

   417			if (!tick_nohz_tick_stopped()) {
   418				unsigned int tick_us =3D ktime_to_us(tick_time);
   419	=

   420				/*
   421				 * Because the tick is not going to be stopped, make
   422				 * sure that the target residency of the state to be
   423				 * returned is within the time to the next timer event
   424				 * including the tick.
   425				 */
   426				while (idx > 0 &&
   427				    (drv->states[idx].target_residency > tick_us ||
   428				     drv->states[idx].disabled ||
   429				     dev->states_usage[idx].disable))
   430					idx--;
   431			}
   432		}
   433	=

   434		data->last_state_idx =3D idx;
   435	=

   436		return data->last_state_idx;
   437	}
   438	=


---
0-DAY kernel test infrastructure                Open Source Technology Cent=
er
https://lists.01.org/pipermail/kbuild-all                   Intel Corporati=
on

--===============3064201622288191614==
Content-Type: application/gzip
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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
AQA=
--===============3064201622288191614==--

