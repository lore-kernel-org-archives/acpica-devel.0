Content-Type: multipart/mixed; boundary="===============1586737388787497993=="
MIME-Version: 1.0
From: Zhang Rui <rui.zhang at intel.com>
Subject: Re: [Devel] [ACPI] Need ACPI table examples
Date: Fri, 17 Jul 2009 08:59:31 +0800
Message-ID: <1247792371.26272.207.camel@rzhang-dt>
In-Reply-To: 4911F71203A09E4D9981D27F9D8308582ECF6AD9@orsmsx503.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1586737388787497993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-07-17 at 01:11 +0800, Moore, Robert wrote:
> We are implementing support for new ACPI 4.0 tables in ACPICA, and we nee=
d examples of the new tables to help implement and test the disassembler su=
pport and related headers.
> =

> If you have any examples of the tables below, we would appreciate it if y=
ou would send them. Any format is acceptable. Please mail to me.
> =

> Thanks,
> Bob
> =

> =

> Tables needed:
> =

> IVRS
> MSCT
> UEFI
> WAET
> WDAT
> WDRT
> =


# find -name WDRT*
./13529/WDRT.dsl
./9879/WDRT.dat
./13417/WDRT.dsl
./11135/WDRT.dsl
# find -name WDAT*
./13263/WDAT.dsl
./13023/WDAT.dsl
./13410/WDAT.dsl

I don't find any other tables

the number here stands for the bugzilla entry in bugzilla.kernel.org.
you can get the acpidump there. :)

thanks,
rui


> _______________________________________________
> acpi mailing list
> acpi(a)linux.intel.com
> http://linux.intel.com/mailman/listinfo/acpi


--===============1586737388787497993==--

