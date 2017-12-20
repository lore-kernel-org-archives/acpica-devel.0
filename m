Content-Type: multipart/mixed; boundary="===============4282894234902469058=="
MIME-Version: 1.0
From: Ross Zwisler <ross.zwisler at linux.intel.com>
Subject: Re: [Devel] [PATCH v3 0/3] create sysfs representation of ACPI HMAT
Date: Wed, 20 Dec 2017 09:41:07 -0700
Message-ID: <20171220164107.GA29103@linux.intel.com>
In-Reply-To: 20171218203547.GA2366@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4282894234902469058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 01:35:47PM -0700, Ross Zwisler wrote:
> On Thu, Dec 14, 2017 at 02:00:32PM +0100, Michal Hocko wrote:
<>
> > What is the testing procedure? How can I setup qemu to simlate such HW?
> =

> Well, the QEMU table simulation is gross, so I'd rather not get everyone
> testing with that.  Injecting custom HMAT and SRAT tables via initrd/init=
ramfs
> is a much better way:
> =

> https://www.kernel.org/doc/Documentation/acpi/initrd_table_override.txt
> =

> Dan recently posted a patch that lets this happen for the HMAT:
> =

> https://lists.01.org/pipermail/linux-nvdimm/2017-December/013545.html
> =

> I'm working right now on getting an easier way to generate HMAT tables - =
I'll
> let you know when I have something working.

I've posted details on how to set up test configurations using injected HMAT
and SRAT tables here:

https://github.com/rzwisler/hmat_examples

So far I've got two different sample configs, and we can add more as they a=
re
useful.  Having the sample configs in github is also nice because if someone
finds a config that causes a kernel issue it can be reported then added to
this list of example configs for future testing.

Please let me know if you have trouble getting this working.

--===============4282894234902469058==--

