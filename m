Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A316610A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BED2D60B32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688635662; x=1720171662;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=JArIM2HKqC9QBC+pTllM7eQ+KGMVlg+PycBfFpwwyJU=;
 b=B8Dnw8lMzx14F4i7TmO0/UOqfFqdZ83gynZY8o3UTpHo9xS75fTiSATu
 UmlWr5BKSOOOJ9P+JF9VaqQ7RvLMowUmJG3eStKQo+7m6Fpj/LOqsyilH
 ZhLTXD3yDrqRa/cI203RCFpJ/6M1b1Ll0jreBQiJDRWxIk0htJE1AWtOa
 XI0+SocvPFIJiDAuoX9q+uYnWRHeMjLk1VqHU7orZc4PIYysMJ6mk05Ad
 38LUdO3wOKm4JCvOP9vuMj2DyEhD55MQHwaZQUz5owXVcu59WBdW+w2hL
 0AhwMepokklIIt+BuxQGaTMchtNVHIbFv7ywKl43BXefODWAXpIJXI3LB Q==;
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <ZKaI+XeYZkdGyFxF@smile.fi.intel.com>
References: <20230703121411.69606-1-andriy.shevchenko@linux.intel.com>
 <20230703121411.69606-3-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0iZzvdkxe3NjHbiZzDjea=CoK-pGw3hjSoa9u8f87TLtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iZzvdkxe3NjHbiZzDjea=CoK-pGw3hjSoa9u8f87TLtg@mail.gmail.com>
Subject: Re: [Acpica-devel] [PATCH v4 2/5] ACPI: platform: Ignore SMB0001
 only when it has resources
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Thu, 06 Jul 2023 09:27:43 -0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Wolfram Sang <wsa@kernel.org>, linux-acpi@vger.kernel.org, Michael Walle <michael@walle.cc>, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>

On Tue, Jul 04, 2023 at 07:32:43PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jul 3, 2023 at 2:14 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> Applied as 6.5-rc material along with the rest of the series (except
> for the last patch that has been superseded), but I moved the
> has_resources definition to the block where it is used and added a
> 'false' initial value to it. as the code might not work as expected
> without initializing it.
> 
> Please double check the bleeding-edge branch of linux-pm.

Now it's in Linux Next and everything looks fine to me,
thank you!

-- 
With Best Regards,
Andy Shevchenko


