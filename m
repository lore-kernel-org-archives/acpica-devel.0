Content-Type: multipart/mixed; boundary="===============2373154710728158383=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH 4.20 regression fix] ACPICA: Fix handling of
 buffer-size in acpi_ex_write_data_to_field()
Date: Tue, 27 Nov 2018 17:40:01 +0100
Message-ID: <CAJZ5v0gPeMXJeqSjLBuLooBWXp4=5VBeK26gXwfUcRe5fZmkoQ@mail.gmail.com>
In-Reply-To: 475940bc-8a64-851d-bc31-a8ec9ee68968@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2373154710728158383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 9:39 AM Hans de Goede <hdegoede(a)redhat.com> wrote:
>
> Hi,
>
> On 27-11-18 04:11, Moore, Robert wrote:
> > Also, please send the acpidump for whatever machine is showing a proble=
m.
> >
> > We want to look closely at the surface 3 code vs. the code for this mac=
hine.
>
> Bob, I know you are unhappy with / frustrated about this part of the ACPI
> specification (*), but please read the !@#$ patch description / commit
> message.
>
> The current problem has very little to do with the specification being
> ambiguous, the code currently in 4.20 is using a struct field which is
> *clearly* marked in the specification as "reserved" as length argument
> to a memcpy without checking that either the source or the destination
> buffer is big enough.
>
> Nor does it guarantee that we copy *enough* data when doing a write to
> an i2c device through the GSB code, resulting in the OpRegion handler
> writing whatever was in the tmp-buffer when we got it from
> acpi_ut_create_buffer_object to the i2c-device, crashing the machine.

The description of the problem is clear to me and and the patch does
make it go away.

Question is if the patch as is clashes with any future ACPICA work,
because if it does, it may be better to do something else in
principle.  So far this is still unclear, but this regression needs to
go away before final 4.20 and the patch still is there in my
linux-next branch.

> I can give you the acpidump of the non-booting device but it is not doing
> anything special,

Sending it over wouldn't hurt though IMO, would it?

> it is only using AttribByte accesses, the problem is
> not the DSDT, the problem is the 4.20 code clearly, *obviously*, being
> buggy, so please review the patch first.
>
> *) IMHO this mostly is about the Surface line of products abusing the
> specification, all other uses I've seen are very straight forward

So until recently it has not been clear to Bob/Erik if there are any
other production users of GenericSerialBus AFAICS and it would help to
give them ASL with it from whatever machines you have access to.  I
would suggest opening a BZ for that and attaching some relevant
acpidump files in there, for future reference if nothing else.

If you make a claim like the above, it's rather good to support it
with some evidence. :-)


> > -----Original Message-----
> > From: Moore, Robert
> > Sent: Monday, November 26, 2018 2:33 PM
> > To: Schmauss, Erik <erik.schmauss(a)intel.com>; Rafael J. Wysocki <rjw(=
a)rjwysocki.net>; Hans de Goede <hdegoede(a)redhat.com>
> > Cc: Len Brown <lenb(a)kernel.org>; linux-acpi(a)vger.kernel.org; devel(=
a)acpica.org
> > Subject: RE: [PATCH 4.20 regression fix] ACPICA: Fix handling of buffer=
-size in acpi_ex_write_data_to_field()
> >
> > Looks like another round of issues with the completely ill-defined gene=
ric serial bus. Below is a summary of the problems we have seen with the Le=
ngth field.
> >
> > I have not had time to completely read through this thread yet, so I'm =
posting some text that I wrote a month or two ago.
> >
> > Let me say this, however:
> >
> > The biggest (and it is very big) issue is that the GenericSerialBus int=
erfaces are so poorly defined in the ACPI specification that any implementa=
tion simply must guess at the proper behavior (Both the ACPI implementation=
 and any related drivers).
> >
> > Bob
> >
> >
> >
> > Problems with these ACPI chapters:
> > 5.5.2.4.6.2 Declaring and Using a GenericSerialBus Data Buffer
> > 5.5.2.4.6.3 Using the GenericSerialBus Protocols
> >
> >
> > 1) All of the ASL code examples do not compile due to syntax errors. Th=
ere are
> > 10 such examples, often with multiple syntax errors.
> >
> >
> > 2) The basic/common data buffer format is not fully defined:
> >      typedef struct
> >      {
> >          BYTE        Status;  // Byte 0 of the data buffer
> >          BYTE        Length;  // Byte 1 of the data buffer
> >          BYTE[x-1]   Data;    // Bytes 2-x of the arbitrary length data=
 buffer,
> >      } // where x is the last index of the overall buffer
> >
> > The "Length" field is not defined. Is it the length of "Data" or the Le=
ngth of the entire structure (Status + Length + Data)?
> >
> > The example code from the spec illustrates how the "Length" term in the=
 structure above is undefined. Again, is it the "length of entire structure=
" or is it the "length of the Data element"?. The example code makes it app=
ear that it is the length of the entire structure, but it is not fully clea=
r because it is wrong in either case:
> >
> >      Name(BUFF, Buffer(34)())            // Create GenericSerialBus dat=
a buffer
> > as BUFF
> >      CreateByteField(BUFF, 0x00, STAT)   // STAT =3D Status (Byte)
> >      CreateByteField(BUFF, 0x01, LEN)    // LEN =3D Length (Byte)
> >      CreateField(BUFF, 0x10, 256, DATA)  // Data (Block)
> >
> >      Store("ACPI", DATA)  // Fill in outgoing data
> >      Store(8, LEN)        // Length of the valid data
> >          (Actually should be 6? Or should it be 4?)
> >
> >
> >

--===============2373154710728158383==--

