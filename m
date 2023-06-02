Return-Path: <michal.wilczynski@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4770426B7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99F49426B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685698006; x=1717234006;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qowyfX7jdwuUaNUAzZolNHUEjSoT2Kl8hA0ojSlQA6M=;
 b=ksp+2NIQIX6nR2MdQyc9WbDjE7JYJiFD1AZHZigaC6BA7g1UhNkaITA0
 tF05j+tGa9lvW459+6mWdSbv0JerjfIua+A1eROTSuKEkE/lCK9fRVk34
 Ck28QxbMXqRb3fKXk4WM6KCf2fYlunHhSq5RF15VF8HYS79a8omZ8dTrk
 SUUYlfkiDu5MmXC7H24376T76ZHrldftlVmlJpWgzC6bPzrTqESjakVJz
 0+u4PkbUScCPyKXkMV6XqbI8jRq5L3RD+6AGZlv19uVcvxXK+xkwDl+a/
 ShD2fLEgVrobbwNSwz3WM27qNS53rvaupjdIOSSZi5XdRZC1VqrXnA1ob g==;
Message-ID: <cf385e99-de6d-b630-6ff5-94fb843feafb@intel.com>
Date: Fri, 2 Jun 2023 11:26:28 +0200
Content-Language: en-US
References: <20230601132137.301802-1-michal.wilczynski@intel.com>
 <b067f6990c7e6e58c487770126a804500ce8a54a.camel@linux.intel.com>
From: "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <b067f6990c7e6e58c487770126a804500ce8a54a.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
To: david.e.box@linux.intel.com, rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com, ira.weiny@intel.com, rui.zhang@intel.com, jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org, lars@metafoo.de, bleung@chromium.org, yu.c.chen@intel.com, hdegoede@redhat.com, markgross@kernel.org, luzmaximilian@gmail.com, corentin.chary@gmail.com, jprvita@gmail.com, cascardo@holoscopio.com, don@syst.com.br, pali@kernel.org, jwoithe@just42.net, matan@svgalib.org, kenneth.t.chan@gmail.com, malattia@linux.it, jeremy@system76.com, productdev@system76.com, herton@canonical.com, coproscefalo@gmail.com, tytso@mit.edu, Jason@zx2c4.com, robert.moore@intel.com
Cc: linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev, nvdimm@lists.linux.dev, linux-iio@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org



On 6/2/2023 3:08 AM, David E. Box wrote:
> Hi Michal,
>
> On Thu, 2023-06-01 at 15:21 +0200, Michal Wilczynski wrote:
>> As callback has been replaced by drivers installing their handlers in
>> .add it's presence is not useful anymore.
>>
>> Remove .notify callback and flags variable from struct acpi_driver,
>> as they're not needed anymore.
>>
>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>> ---
>>  include/acpi/acpi_bus.h | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index 7fb411438b6f..3326794d5b70 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -151,12 +151,10 @@ struct acpi_hotplug_context {
>>  
>>  typedef int (*acpi_op_add) (struct acpi_device * device);
>>  typedef void (*acpi_op_remove) (struct acpi_device *device);
>> -typedef void (*acpi_op_notify) (struct acpi_device * device, u32 event);
>>  
>>  struct acpi_device_ops {
>>         acpi_op_add add;
>>         acpi_op_remove remove;
>> -       acpi_op_notify notify;
>>  };
>>  
>>  #define ACPI_DRIVER_ALL_NOTIFY_EVENTS  0x1     /* system AND device events */
>> @@ -165,7 +163,6 @@ struct acpi_driver {
>>         char name[80];
>>         char class[80];
>>         const struct acpi_device_id *ids; /* Supported Hardware IDs */
>> -       unsigned int flags;
> Can ACPI_DRIVER_ALL_NOTIFY_EVENTS be removed as well?

Hi David,
Oh yeah, it should be removed as well,

Thanks !

>
>>         struct acpi_device_ops ops;
>>         struct device_driver drv;
>>         struct module *owner;

