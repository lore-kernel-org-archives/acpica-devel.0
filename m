Content-Type: multipart/mixed; boundary="===============2946995389479593830=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: Re: [Devel] GPE blocks in reduced hardware mode
Date: Tue, 03 Dec 2013 18:39:16 -0700
Message-ID: <529E87C4.7020307@redhat.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37C7A5FD1@ORSMSX103.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2946995389479593830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/03/2013 05:18 PM, Moore, Robert wrote:
> The first thing is that there are no GPE block devices in the field, neve=
r have been. I don't think ACPICA actually supports them fully. It is a bit=
 of an "orphan" feature of ACPI.

I see.  Yeah, I did find GPE block device support confusing in the
code.  It seems like the infrastructure to handle them is present,
but there is no code to handle the "ACPI0006" ID anywhere I can find
(that may be a Linux limitation, though).

> I'll have to take a look closer at the spec for an exact reference, but b=
asically one of the things that ACPI_REDUCED_HARDWARE means is no GPEs, IIR=
C.

Right -- that's what ACPI_REDUCED_HARDWARE means in the ACPICA code;
that seems pretty clear.  I just can't seem to find anything that clear
in the spec :/...

I'll continue to look in the spec but if you find something before I
do, do let me know.

Thanks!

>> -----Original Message-----
>> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Al Stone
>> Sent: Tuesday, December 03, 2013 2:38 PM
>> To: devel(a)acpica.org
>> Subject: [Devel] GPE blocks in reduced hardware mode
>>
>> Howdy.
>>
>> I've been trying to do some clean-up on the Linux ACPI driver with regard
>> to the reduced hardware profile introduced in ACPI 5.0.
>>
>> In thinking about GPE block devices, I was looking through the functions
>> in source/components/events/evxfgpe.c and noticed that they are all
>> #ifdef'd out for ACPI_REDUCED_HARDWARE.  When I look back through the
>> specification, however, I cannot find any place where they are prohibite=
d.
>>
>> Clearly, the gpe0/1 blocks in the FADT are not to be used; this is
>> explicitly stated in section 5.2.9 of the spec.  Could someone please
>> point me to a similar statement for a GPE block device?  I just cannot
>> seem to find it.
>>
>> The closest thing I can find is section 9.10 implying that a GPE block
>> device is an extension of the gpe0/1 blocks from the FADT, but there is =
no
>> explicit statement there so it is ambiguous to me.
>>
>> Thanks in advance for any pointers; I'm just puzzled at this point and
>> trying to understand how the conclusion came to be.
>>
>> --
>> ciao,
>> al
>> -----------------------------------
>> Al Stone
>> Software Engineer
>> Red Hat, Inc.
>> ahs3(a)redhat.com
>> -----------------------------------
>> _______________________________________________
>> Devel mailing list
>> Devel(a)acpica.org
>> https://lists.acpica.org/mailman/listinfo/devel


-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============2946995389479593830==--

