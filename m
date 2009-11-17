Content-Type: multipart/mixed; boundary="===============0749950039492906476=="
MIME-Version: 1.0
From: Lin Ming <ming.m.lin at intel.com>
Subject: Re: [Devel] Problem in compilation of ACPI test suite
Date: Tue, 17 Nov 2009 09:04:03 +0800
Message-ID: <1258419843.17765.36.camel@minggr.sh.intel.com>
In-Reply-To: 6b4365880911161615x76180a1fi397d190b4317cef1@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0749950039492906476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-11-17 at 08:15 +0800, nisha jain wrote:
> Hi All,
> =

> I am new to ACPI development. I have downloaded the UNIX Format Source
> Code and Build Environment of the ACPI =

> and successfully compiled it. I am facing problem in UNIX Format Test
> Suite installation as i am getting following compilation errors.
> After looking into Make file i am still unable to figure what is the
> reason of the error. =

> Please if some one can tell me what is going wrong here? =


Hi, Nisha

Run "make install" directly would cause error.
You can use the scripts under aslts/bin.

Suppose you put acpica and aslts under /tmp

export ASL=3D/tmp/acpica/compiler/iasl
export acpiexec=3D/tmp/acpica/tools/acpiexec/acpiexec
export ASLTSDIR=3D/tmp/aslts
chmod +x /tmp/aslts/bin/*
/tmp/aslts/bin/Do 0 aslts

See the aslts/HOW_TO_USE file for more detail.

> =

> root(a)utd-desktop:/home/utd/ACPI/acpica-unix-20091112/tests/aslts# make
> install
> /home/utd/ACPI/acpica-unix-20091112/tests/aslts/src
> make[1]: Entering directory
> `/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src'
> /home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime
> make[2]: Entering directory
> `/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime'
> /home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections
> make[3]: Entering directory
> `/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections'
> /home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections/b=
demo
> make[4]: Entering directory
> `/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections/=
bdemo'
> /home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections/b=
demo/ACPICA
> make[5]: Entering directory
> `/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections/=
bdemo/ACPICA'
> /home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections/b=
demo/ACPICA/bdemo
> make[6]: Entering directory
> `/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections/=
bdemo/ACPICA/bdemo'
> Bad iASL 1: <>
> make[6]: *** [install_test_case] Error 1
> make[6]: Leaving directory
> `/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections/=
bdemo/ACPICA/bdemo'
> /home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections/b=
demo/ACPICA/bdemof
> make[6]: Entering directory
> `/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime/collections/=
bdemo/ACPICA/bdemof'
> Bad iASL 1: <>
> ...........
> =

> ........... so on
> ............
> =

> =

> make[2]: *** [install] Error 2
> make[2]: Leaving directory
> `/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src/runtime'
> make[1]: *** [install] Error 2
> make[1]: Leaving directory
> `/home/utd/ACPI/acpica-unix-20091112/tests/aslts/src'
> make: *** [install] Error 2
> =

> =

> I want to use the ACPI library for writing a small application for
> power management and display.
> My understanding is that in through test code i can understand the
> sequence for API call and =

> their functionality. I have gone through the Programmer reference for
> API functionality but =

> not sure if there is any specific sequence to call them. I am using

See the main function at acpica/tools/acpiexec/aemain.c for the call
sequence.

Cheers,
Lin Ming

>  Intel dual core and Ubuntu platform. =

> I have enabled the BIOS settings for ACPI and i am able to run some of
> applications to see the power =

> state of the CPU...
> =

> =

> Thanks and Regards,
> Nisha


--===============0749950039492906476==--

