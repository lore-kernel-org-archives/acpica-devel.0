Content-Type: multipart/mixed; boundary="===============6083821739643999566=="
MIME-Version: 1.0
From: Schmauss, Erik <erik.schmauss at intel.com>
Subject: Re: [Devel] PROBLEM: Calling ObjectType on buffer field reports type
 integer
Date: Tue, 19 Mar 2019 20:19:18 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C5942CA@ORSMSX122.amr.corp.intel.com>
In-Reply-To: fe4bcc1c-5c15-caa6-ce01-a5df962ff008@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6083821739643999566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Maximilian Luz [mailto:luzmaximilian(a)gmail.com]
> Sent: Tuesday, March 19, 2019 9:30 AM
> To: Schmauss, Erik <erik.schmauss(a)intel.com>; Moore, Robert
> <robert.moore(a)intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki(a)intel.com>
> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> Subject: Re: PROBLEM: Calling ObjectType on buffer field reports type
> integer
> =

> =

> =

> On 3/18/19 11:28 PM, Schmauss, Erik wrote:
> >
> >
> >> -----Original Message-----
> >> From: linux-acpi-owner(a)vger.kernel.org [mailto:linux-acpi-
> >> owner(a)vger.kernel.org] On Behalf Of Schmauss, Erik
> >> Sent: Thursday, March 14, 2019 10:19 AM
> >> To: Maximilian Luz <luzmaximilian(a)gmail.com>; Moore, Robert
> >> <robert.moore(a)intel.com>; Wysocki, Rafael J
> >> <rafael.j.wysocki(a)intel.com>
> >> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> >> Subject: RE: PROBLEM: Calling ObjectType on buffer field reports
> type
> >> integer
> >>
> >>
> >>
> >>> -----Original Message-----
> >>> From: Maximilian Luz [mailto:luzmaximilian(a)gmail.com]
> >>> Sent: Thursday, March 14, 2019 7:24 AM
> >>> To: Moore, Robert <robert.moore(a)intel.com>; Schmauss, Erik
> >>> <erik.schmauss(a)intel.com>; Wysocki, Rafael J
> >>> <rafael.j.wysocki(a)intel.com>
> >>> Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> >>> Subject: PROBLEM: Calling ObjectType on buffer field reports type
> >>> integer
> >>>
> >>> Hi all,
> >>>
> >>> it seems that buffer fields (created via CreateField) are
> >>> incorrectly reported as being of type integer (via ObjectType)
> when
> >>> they are
> >> small
> >>> enough to allow for that.
> >>>
> >>> As far as I know all kernel versions are affected by this, I have
> >>> specifically checked 5.0 (5.0.2), 4.20, 4.19 and 4.18.
> >>>
> >>> In more detail: On the Microsoft Surface Book 2, Surface Pro
> (2017),
> >>> Surface Pro 6, Surface Laptop and Surface Laptop 2 devices there
> is
> >>> the following piece of AML code:
> >>>
> >>>       Local0 =3D ^^_SAN.RQST (0x02, One, One, Zero, One)
> >>>       If ((ObjectType (Local0) !=3D 0x03))
> >>>       {
> >>>           // Error path
> >>>       }
> >>>       Else
> >>>       {
> >>>           // Success path
> >>>       }
> >>>
> >>> Which executes a command (RQST) and then checks the type of
> the
> >>> returned field to determine if that command was successful (i.e.
> >>> returned a buffer object) or failed (i.e. returned any other type,
> >>> including integer). The buffer field that is being returned by RQST
> >>> is crated as
> >>> follows:
> >>>
> >>>       CreateField (RQBF, 0x20, Local3, ARB)
> >>>       Local4 =3D ARB /* \_SB_._SAN.RQSX.ARB_ */
> >>>       ...
> >>>       Return (Local4)
> >>>
> >>> If the returned buffer field is small enough (smaller than
> >>> acpi_gbl_integer_byte_width), the error-path will always be
> >> executed.
> >>>
> >>> The full DSDT for the Surface Book 2 can be found here:
> >>> https://github.com/qzed/surfacebook2-
> >>>
> >>
> dsdt/blob/fa0ca7c7cba8fb0da1e79c282f9a9f4a12eaaa17/dsdt.dsl#L153
> >>> 96
> >>>
> >>> I have attached a patch (for 5.0) that fixes this issue and has been
> >>> in use on the affected devices for a few months now via
> >>>
> >>>       https://github.com/qzed/linux-surfacegen5-acpi and
> >>>       https://github.com/jakeday/linux-surface/
> >>>
> >>> I'm not aware of any issues regarding the patch, but then again
> this
> >>> has, to my knowledge, only been tested on Microsoft Surface
> >> devices.
> >>
> >> I'll take a look at this and test the behavior on windows OS. Surface
> >> laptops tend to have interesting firmware that expose these
> >> differences.
> >
> > I decided to run the following code on windows
> >
> >      Name (BUF1, Buffer() {0x32, 0x56, 0x12, 0xff, 0x12, 0xd1, 0xd0,
> 0xd6, 0x54})
> >      Name (BUF2, Buffer(0x09) {})
> >      Method (DS00)
> >      {
> >          CreateField (BUF1, 1, 1, FLD0)
> >          local0 =3D FLD0
> >          return (ObjectType(Local0))
> >      }
> >      Method (DS01)
> >      {
> >          CreateField (BUF1, 0, 72, FLD1)
> >          local1 =3D FLD1
> >          return (ObjectType(Local1))
> >      }
> >      Method (DS02)
> >      {
> >          CreateField (BUF2, 0, 72, FLD2)
> >          local2 =3D FLD2
> >          return (ObjectType(Local2))
> >      }
> >
> > Here's an output from windbg
> >
> > AMLI(? for help)-> run \ds00
> > run \ds00
> >
> > \DS00 completed successfully with object data:
> > Integer(:Value=3D0x3[3])
> >
> > AMLI(? for help)-> run \ds01
> > run \ds01
> >
> > \DS01 completed successfully with object data:
> > Integer(:Value=3D0x3[3])
> >
> > AMLI(? for help)-> run \ds02
> > run \ds02
> >
> > \DS02 completed successfully with object data:
> > Integer(:Value=3D0x3[3])
> >
> > AMLI(? for help)->
> >
> > So it does seem like windows AML interpreter is doing what you
> expect it to do.
> > After I applied your patch with a small modification below and it
> > causes some regressions in our AML test suite. I would like to take
> > time to look at each of these to make sure that all of the behavioral
> Differences are expected. Bob will be back in the office so I'll discuss
> this with him as well.
> =

> Thank you for the update!
> =

> I mainly choose this solution because it was the first one I came up
> with, I'm not that experienced with acpica so yours may very well be
> better. What I found a bit odd though and why I stuck with this
> solution was that AML_FIELD_ACCESS_BUFFER did not seem to be
> used anywhere (in contrast to the other field access types).
> =

> I've tried your modification. However, just replacing the check with
> =

>      obj_desc->common.type =3D=3D ACPI_TYPE_BUFFER_FIELD
> =

> did seem to break things for me, but I may be missing something.
> =

> More specifics on what is being broken: The communication via the
> OperationRegion does not seem to work properly any more. There is a

Yeah, that's what I was thinking... After discussions with Bob, this whole
Behavior is an issue with Winodws AML interpreter not following the spec.

Page 927 of ACPI 6.3 specification states the following:

"If the Buffer Field is smaller than or equal to the size of an Integer (in=
 bits), it will be treated as an Integer. Otherwise, it will be treated as =
a Buffer."

So windows is not following this rule here. This rule is also the same for
field units so our next step is to check windows behavior for this. It would
be nice to file a bug against windows but they've never responded to these
reports in the past....

For the record, windows does detect the object type of CreateField correctl=
y.

Method (SS02)
{
        CreateField (BUF2, 0, 72, FLD2)
        return (ObjectType(FLD2))
}

This method returns 0xE as expected.

> status flag in the communication buffer that should get cleared and it
> looks like it isn't. My current theory is:
> =

> The flag being checked is a byte field in the communication buffer,
> created via CreateByteField (RQBF, 0x00, VSTS). Thus it should have
> type ACPI_TYPE_BUFFER_FIELD (?). Due to this, your change seems to
> create a buffer instead of an integer object in
> acpi_ex_read_data_from_field.
> When this field is now evaluated for the communication check via
> =

>      If ((VSTS =3D=3D Zero)) { /* success */ } Else { /* failure */ }
> =

> the check in acpi_ex_do_logical_op exmisc.c converts the second
> argument to a buffer of size acpi_gbl_integer_byte_width. The buffer
> sizes are then different as VSTS has size 1 and thus the check fails,
> getting misinterpreted as communication-failure.
> =

> Maximilian
> =

> >
> > Thanks,
> > Erik
> >>
> >> Erik
> >>>
> >>> Maximilian
> >>>
> >>> Signed-off-by: Maximilian Luz <luzmaximilian(a)gmail.com>
> >>> ---
> >>>    drivers/acpi/acpica/dsopcode.c |  2 +-
> >>>    drivers/acpi/acpica/exfield.c  | 12 +++++++++---
> >>>    2 files changed, 10 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/acpi/acpica/dsopcode.c
> >>> b/drivers/acpi/acpica/dsopcode.c index
> 78f9de260d5f..0cd858520f5b
> >>> 100644
> >>> --- a/drivers/acpi/acpica/dsopcode.c
> >>> +++ b/drivers/acpi/acpica/dsopcode.c
> >>> @@ -123,7 +123,7 @@ acpi_ds_init_buffer_field(u16
> aml_opcode,
> >>>
> >>>    		/* Offset is in bits, count is in bits */
> >>>
> >>> -		field_flags =3D AML_FIELD_ACCESS_BYTE;
> >>> +		field_flags =3D AML_FIELD_ACCESS_BUFFER;
> >>>    		bit_offset =3D offset;
> >>>    		bit_count =3D (u32) length_desc->integer.value;
> >>>
> >>> diff --git a/drivers/acpi/acpica/exfield.c
> >>> b/drivers/acpi/acpica/exfield.c index e5798f15793a..55abd9e035a0
> >>> 100644
> >>> --- a/drivers/acpi/acpica/exfield.c
> >>> +++ b/drivers/acpi/acpica/exfield.c
> >>> @@ -98,6 +98,7 @@ acpi_ex_read_data_from_field(struct
> >>> acpi_walk_state *walk_state,
> >>>    	union acpi_operand_object *buffer_desc;
> >>>    	void *buffer;
> >>>    	u32 buffer_length;
> >>> +	u8 field_flags;
> >>>
> >>>    	ACPI_FUNCTION_TRACE_PTR(ex_read_data_from_field,
> >>> obj_desc);
> >>>
> >>> @@ -146,11 +147,16 @@ acpi_ex_read_data_from_field(struct
> >>> acpi_walk_state *walk_state,
> >>>    	 * Note: Field.length is in bits.
> >>>    	 */
> >>>    	buffer_length =3D
> >>> -	    (acpi_size)ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc-
> >>>> field.bit_length);
> >>> +	    (acpi_size)ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc-
> >>>> common_field.bit_length);
> >>> +	field_flags =3D obj_desc->common_field.field_flags;
> >>>
> >>> -	if (buffer_length > acpi_gbl_integer_byte_width) {
> >>> +	if (buffer_length > acpi_gbl_integer_byte_width ||
> >>> +	    (field_flags & AML_FIELD_ACCESS_TYPE_MASK) =3D=3D
> >>> +AML_FIELD_ACCESS_BUFFER) {
> >
> > Rather than using field_flags at all, we can do something like
> >
> > if ((BufferLength > AcpiGbl_IntegerByteWidth) || (ObjDesc-
> >Common.Type
> > =3D=3D ACPI_TYPE_BUFFER_FIELD))
> >
> > This will restrict translations to the CreateField but your solution
> might also be valid...
> > I'll run a few more test cases tomorrow.
> >>>
> >>> -		/* Field is too large for an Integer, create a Buffer
> >>> instead */
> >>> +		/*
> >>> +		 * Field is either too large for an Integer, or a actually of
> >>> type
> >>> +		 * buffer, so create a Buffer.
> >>> +		 */
> >>>
> >>>    		buffer_desc =3D
> >>> acpi_ut_create_buffer_object(buffer_length);
> >>>    		if (!buffer_desc) {
> >>> --
> >>> 2.20.1
> >>>
> >

--===============6083821739643999566==--

