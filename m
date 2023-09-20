Return-Path: <lkp@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D33D831D6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29FF482331
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695187090; x=1726723090;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vgocaKsbmdpjMaJx3xBQwNzNeJ/8n5uXEO7B6NpSHU4=;
 b=CNlUD5L0riL+e4fzypdQ6g1vr84CDqmkln3RRu+KRfhdIAolbF9AmxwH
 XOGCdSSJFCYlZ4XsKqYRMoJpcdicOnPIRFhOT+hb/37rLhYk2lPl3xJ6r
 V3Mlrf5fyPydNOkjR4nM96JdovBd8QyeBhImL3B0uJQidgIz9IkOv+zNg
 mH9A9OIxmTI4crWPRh6PxY3w1OELYquphE1L6WrLRXm1/1km+ho/oHUpO
 fyjZjcRxt3DwIy1qz7reePwdMyrdwQlwPfyg5A4t5p0+jd4QdcdzL1jy6
 QylcY2+WPdDQ7A6pdzbShazpXwbq5oZHW+8dJm6+AkcvCG9yiFtyHN+G5 w==;
From: kernel test robot <lkp@intel.com>
Message-ID: <202309201331.S2c1JL2h-lkp@intel.com>
References: <20230920000139.15533-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920000139.15533-1-mirsad.todorovac@alu.unizg.hr>
Subject: Re: [Acpica-devel] [PATCH v1 1/1] acpica: use spinlocks to fix the
 data-races reported by the KCSAN
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Wed, 20 Sep 2023 05:18:11 -0000
To: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Erik Kaneda <erik.kaneda@intel.com>, Robert Moore <robert.moore@intel.com>, oe-kbuild-all@lists.linux.dev, Jung-uk Kim <jkim@freebsd.org>, Len Brown <lenb@kernel.org>

Hi Mirsad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc2 next-20230920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mirsad-Goran-Todorovac/acpica-use-spinlocks-to-fix-the-data-races-reported-by-the-KCSAN/20230920-080345
base:   linus/master
patch link:    https://lore.kernel.org/r/20230920000139.15533-1-mirsad.todorovac%40alu.unizg.hr
patch subject: [PATCH v1 1/1] acpica: use spinlocks to fix the data-races reported by the KCSAN
config: i386-randconfig-003-20230920 (https://download.01.org/0day-ci/archive/20230920/202309201331.S2c1JL2h-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309201331.S2c1JL2h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309201331.S2c1JL2h-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/acpi/acpica/utdebug.c: In function 'acpi_debug_print':
>> drivers/acpi/acpica/utdebug.c:145:13: warning: unused variable 'nesting_level' [-Wunused-variable]
     145 |         u32 nesting_level;
         |             ^~~~~~~~~~~~~


vim +/nesting_level +145 drivers/acpi/acpica/utdebug.c

   113	
   114	/*******************************************************************************
   115	 *
   116	 * FUNCTION:    acpi_debug_print
   117	 *
   118	 * PARAMETERS:  requested_debug_level - Requested debug print level
   119	 *              line_number         - Caller's line number (for error output)
   120	 *              function_name       - Caller's procedure name
   121	 *              module_name         - Caller's module name
   122	 *              component_id        - Caller's component ID
   123	 *              format              - Printf format field
   124	 *              ...                 - Optional printf arguments
   125	 *
   126	 * RETURN:      None
   127	 *
   128	 * DESCRIPTION: Print error message with prefix consisting of the module name,
   129	 *              line number, and component ID.
   130	 *
   131	 ******************************************************************************/
   132	
   133	void ACPI_INTERNAL_VAR_XFACE
   134	acpi_debug_print(u32 requested_debug_level,
   135			 u32 line_number,
   136			 const char *function_name,
   137			 const char *module_name,
   138			 u32 component_id, const char *format, ...)
   139	{
   140		acpi_thread_id thread_id;
   141		va_list args;
   142	#ifdef ACPI_APPLICATION
   143		int fill_count;
   144	#endif
 > 145		u32 nesting_level;
   146	
   147		/* Check if debug output enabled */
   148	
   149		if (!ACPI_IS_DEBUG_ENABLED(requested_debug_level, component_id)) {
   150			return;
   151		}
   152	
   153		/*
   154		 * Thread tracking and context switch notification
   155		 */
   156		thread_id = acpi_os_get_thread_id();
   157		if (thread_id != acpi_gbl_previous_thread_id) {
   158			if (ACPI_LV_THREADS & acpi_dbg_level) {
   159				acpi_os_printf
   160				    ("\n**** Context Switch from TID %u to TID %u ****\n\n",
   161				     (u32)acpi_gbl_previous_thread_id, (u32)thread_id);
   162			}
   163	
   164			acpi_gbl_previous_thread_id = thread_id;
   165			WRITE_ONCE(acpi_gbl_nesting_level, 0);
   166		}
   167	
   168		/*
   169		 * Display the module name, current line number, thread ID (if requested),
   170		 * current procedure nesting level, and the current procedure name
   171		 */
   172		acpi_os_printf("%9s-%04d ", module_name, line_number);
   173	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
