Content-Type: multipart/mixed; boundary="===============6832086632556586480=="
MIME-Version: 1.0
From: Schmauss, Erik <erik.schmauss at intel.com>
Subject: Re: [Devel] [PATCH 4.20 regression fix] ACPICA: Fix handling of
 buffer-size in acpi_ex_write_data_to_field()
Date: Wed, 28 Nov 2018 00:05:41 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C55135B@ORSMSX122.amr.corp.intel.com>
In-Reply-To: 374a397d-9726-b078-bd5b-3401a6084980@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6832086632556586480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Hans de Goede [mailto:hdegoede(a)redhat.com]
> Sent: Tuesday, November 27, 2018 11:21 AM
> To: Rafael J. Wysocki <rafael(a)kernel.org>
> Cc: Moore, Robert <robert.moore(a)intel.com>; Schmauss, Erik
> <erik.schmauss(a)intel.com>; Rafael J. Wysocki <rjw(a)rjwysocki.net>; Len
> Brown <lenb(a)kernel.org>; ACPI Devel Maling List <linux-
> acpi(a)vger.kernel.org>; devel(a)acpica.org
> Subject: Re: [PATCH 4.20 regression fix] ACPICA: Fix handling of buffer-s=
ize in
> acpi_ex_write_data_to_field()
> =

> Hi,
> =

> On 27-11-18 17:40, Rafael J. Wysocki wrote:
> > On Tue, Nov 27, 2018 at 9:39 AM Hans de Goede <hdegoede(a)redhat.com>
> wrote:
> >>
> >> Hi,
> >>
> >> On 27-11-18 04:11, Moore, Robert wrote:
> >>> Also, please send the acpidump for whatever machine is showing a
> problem.
> >>>
> >>> We want to look closely at the surface 3 code vs. the code for this
> machine.
> >>
> >> Bob, I know you are unhappy with / frustrated about this part of the
> >> ACPI specification (*), but please read the !@#$ patch description /
> >> commit message.
> >>
> >> The current problem has very little to do with the specification
> >> being ambiguous, the code currently in 4.20 is using a struct field
> >> which is
> >> *clearly* marked in the specification as "reserved" as length
> >> argument to a memcpy without checking that either the source or the
> >> destination buffer is big enough.
> >>
> >> Nor does it guarantee that we copy *enough* data when doing a write
> >> to an i2c device through the GSB code, resulting in the OpRegion
> >> handler writing whatever was in the tmp-buffer when we got it from
> >> acpi_ut_create_buffer_object to the i2c-device, crashing the machine.
> >
> > The description of the problem is clear to me and and the patch does
> > make it go away.
> >
> > Question is if the patch as is clashes with any future ACPICA work,
> > because if it does, it may be better to do something else in
> > principle.  So far this is still unclear, but this regression needs to
> > go away before final 4.20 and the patch still is there in my
> > linux-next branch.
> >
> >> I can give you the acpidump of the non-booting device but it is not
> >> doing anything special,
> >
> > Sending it over wouldn't hurt though IMO, would it?
> =

> True, here it is: https://fedorapeople.org/~jwrdegoede/acpidump.acer-
> One-S1003
> =

> >> it is only using AttribByte accesses, the problem is not the DSDT,
> >> the problem is the 4.20 code clearly, *obviously*, being buggy, so
> >> please review the patch first.
> >>
> >> *) IMHO this mostly is about the Surface line of products abusing the
> >> specification, all other uses I've seen are very straight forward
> >
> > So until recently it has not been clear to Bob/Erik if there are any
> > other production users of GenericSerialBus AFAICS and it would help to
> > give them ASL with it from whatever machines you have access to.
> =


Hi Hans,

Thanks for your patience

> I do not think that is the case. A lot of laptops out there use the
> GenericSerialBus interface in the form of an I2cSerialBus for Battery
> monitoring, but all these laptops pretty much exclusively use
> GenericSerialBus OpRegion accesses with AccessAs set to either AttribByte
> or AttribBytes and that has been working fine for years and the spec is c=
lear
> enough on how to interpret these (esp. in combination with the DSTDs using
> them which make the intention clear).
> =

> The problem with the Surface line of devices is that the use AccessAs
> AttribRawProcessBytes on which the spec is a bit handwavy, the patch in 4=
.20
> to fix AttribRawProcessBytes breaks AttribByte and AttribBytes accesses,
> because for those the length field of the ACPI buffer passed when writing
> the field is reserved, so we should not use it.

Thanks for this data point

> =

> Frankly given that using GenericSerialBus OpRegion accesses with AccessAs
> set to either AttribByte or AttribBytes is very common, I'm amazed that t=
here
> have not been more regressions reported against 4.20. Note these do not
> necessarily have to end up as system not booting, but could also e.g. be
> battery monitoring behaving weirdly.
> =

> Note I was involved in the acpica discussion surrounding the patches to d=
eal
> with AttribRawProcessBytes, only I was so focused on
> AttribRawProcessBytes that I failed to see they would break AttribByte and
> AttribBytes accesses at that time, only to have it poetically bite myself=
 in the
> ass and at the end of a long bisect end up at the very patch I was sidewa=
ys
> involved with.

We looked at the spec and your patch and we came to the following conclusio=
ns:

I will refer to the contents of the original patch using the # character to=
 avoid
confusion with >. In the original patch you stated this:

#The ACPI 6.0 spec (ACPI_6.0.pdf) "5.5.2.4.5.2 Declaring and Using a
#GenericSerialBusData Buffer" (page 232) states that the GenericSerialBus D=
ata
#Buffer Length field is only valid when doing a Read/Write Block (AttribBlo=
ck) transfer,
#but since the troublesome commit we unconditionally use the len field to d=
etermine
#how much data to copy from the source-buffer into the temp-buffer passed t=
o the
#OpRegion.

The spec is wrong on this part. LEN is used in AttribBlock, AttribBlockProc=
essCall, and
AttribRawProcessBytes, we need to know how much data to copy. Len has to be
correct for the handler. Your solution is treating AttribBlock, AttribBlock=
ProcessCall,
and AttribRawProcessBytes in the same way as everything else. I think we ca=
n try to
attempt to "honor" the spirit of these protocols by looking at LEN in certa=
in cases.
However, LEN is not always reliable.

#3) The temp-buffer passed to the OpRegion is allocated to the size returne=
d by
#acpi_ex_get_serial_access_length(), which may be as little as 1, so potent=
ially this
#may lead to a write overflow of the temp-buffer.

The temp buffer is at least 2. We missed adding 2 to the DataLengthField.

With the new approach, we let the temporary buffer be of the max size. Sinc=
e LEN is
8 bits, we can only have a max data length of 256. Accounting for the STAT =
and LEN
fields, the Temp Buffer should be 258. In other words, we can't overflow th=
e buffer
but we definitely need to choose wisely between the two.

Anyway aside from all of those details, the primary issue here is the DataL=
ength
and also how to go about choosing the appropriate one. This will give the h=
andler the
correct data to deal with.

There are hints in the spec that imply that LEN is important for some proto=
cols but the
value of LEN cannot be trusted so we need to make sure to check to make sur=
e that
this value is sane.

Could you modify your patch so that we take the DataLength as correct as po=
ssible?

Here's what I'm thinking:

AttribQuick - data length can be one or greater but with the structure of t=
hese buffers,
                          2 might be easier for the handler to use.
AttribSendRecieve - data length can be 3 (2 for STAT/ LEN header + 1 data)
AttribByte - datalength can be 3 (same as above)
AttribWord - datalength can be 4 (2 header + 2 data)
AttribBlock - datalength should be LEN unless LEN is greater than the sourc=
e buffer.
                          In this case, DataLength should be the SourceBuff=
er's Length or  the max (whichever one is smaller)
AttribProcessCall - should be 4 (2 header + 2 data)
AttribBlockProcessCall - same as AttribBlock
AttribBytes - ignore AttribBytesFiedl and use LEN like AttribBlock
AttribRawBytes - same as AttribBytes (this one is confusing)
AtrribRawProcessBytes - same as AttribBytes

I think this would be a better solution. Let me know what you think and apo=
logies for the slow response.

Erik

> =

> Regards,
> =

> Hans
> =

> =

> =

> > I would suggest opening a BZ for that and attaching some relevant
> > acpidump files in there, for future reference if nothing else.
> >
> > If you make a claim like the above, it's rather good to support it
> > with some evidence. :-)
> >
> >
> >>> -----Original Message-----
> >>> From: Moore, Robert
> >>> Sent: Monday, November 26, 2018 2:33 PM
> >>> To: Schmauss, Erik <erik.schmauss(a)intel.com>; Rafael J. Wysocki
> >>> <rjw(a)rjwysocki.net>; Hans de Goede <hdegoede(a)redhat.com>
> >>> Cc: Len Brown <lenb(a)kernel.org>; linux-acpi(a)vger.kernel.org;
> >>> devel(a)acpica.org
> >>> Subject: RE: [PATCH 4.20 regression fix] ACPICA: Fix handling of
> >>> buffer-size in acpi_ex_write_data_to_field()
> >>>
> >>> Looks like another round of issues with the completely ill-defined
> generic serial bus. Below is a summary of the problems we have seen with
> the Length field.
> >>>
> >>> I have not had time to completely read through this thread yet, so I'm
> posting some text that I wrote a month or two ago.
> >>>
> >>> Let me say this, however:
> >>>
> >>> The biggest (and it is very big) issue is that the GenericSerialBus
> interfaces are so poorly defined in the ACPI specification that any
> implementation simply must guess at the proper behavior (Both the ACPI
> implementation and any related drivers).
> >>>
> >>> Bob
> >>>
> >>>
> >>>
> >>> Problems with these ACPI chapters:
> >>> 5.5.2.4.6.2 Declaring and Using a GenericSerialBus Data Buffer
> >>> 5.5.2.4.6.3 Using the GenericSerialBus Protocols
> >>>
> >>>
> >>> 1) All of the ASL code examples do not compile due to syntax errors.
> >>> There are
> >>> 10 such examples, often with multiple syntax errors.
> >>>
> >>>
> >>> 2) The basic/common data buffer format is not fully defined:
> >>>       typedef struct
> >>>       {
> >>>           BYTE        Status;  // Byte 0 of the data buffer
> >>>           BYTE        Length;  // Byte 1 of the data buffer
> >>>           BYTE[x-1]   Data;    // Bytes 2-x of the arbitrary length d=
ata buffer,
> >>>       } // where x is the last index of the overall buffer
> >>>
> >>> The "Length" field is not defined. Is it the length of "Data" or the =
Length
> of the entire structure (Status + Length + Data)?
> >>>
> >>> The example code from the spec illustrates how the "Length" term in
> the structure above is undefined. Again, is it the "length of entire stru=
cture"
> or is it the "length of the Data element"?. The example code makes it app=
ear
> that it is the length of the entire structure, but it is not fully clear =
because it is
> wrong in either case:
> >>>
> >>>       Name(BUFF, Buffer(34)())            // Create GenericSerialBus =
data
> buffer
> >>> as BUFF
> >>>       CreateByteField(BUFF, 0x00, STAT)   // STAT =3D Status (Byte)
> >>>       CreateByteField(BUFF, 0x01, LEN)    // LEN =3D Length (Byte)
> >>>       CreateField(BUFF, 0x10, 256, DATA)  // Data (Block)
> >>>
> >>>       Store("ACPI", DATA)  // Fill in outgoing data
> >>>       Store(8, LEN)        // Length of the valid data
> >>>           (Actually should be 6? Or should it be 4?)
> >>>
> >>>
> >>>

--===============6832086632556586480==--

