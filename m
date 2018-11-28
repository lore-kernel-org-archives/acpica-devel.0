Content-Type: multipart/mixed; boundary="===============0998503280013027183=="
MIME-Version: 1.0
From: Schmauss, Erik <erik.schmauss at intel.com>
Subject: Re: [Devel] [PATCH 4.20 regression fix] ACPICA: Fix handling of
 buffer-size in acpi_ex_write_data_to_field()
Date: Wed, 28 Nov 2018 17:18:17 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C5515C5@ORSMSX122.amr.corp.intel.com>
In-Reply-To: 97ba3a26-48a3-4f2b-5825-2473a19b28bc@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0998503280013027183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: linux-acpi-owner(a)vger.kernel.org [mailto:linux-acpi-
> owner(a)vger.kernel.org] On Behalf Of Hans de Goede
> Sent: Wednesday, November 28, 2018 3:16 AM
> To: Schmauss, Erik <erik.schmauss(a)intel.com>; Rafael J. Wysocki
> <rafael(a)kernel.org>
> Cc: Moore, Robert <robert.moore(a)intel.com>; Rafael J. Wysocki
> <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.org>; ACPI Devel Maling L=
ist
> <linux-acpi(a)vger.kernel.org>; devel(a)acpica.org
> Subject: Re: [PATCH 4.20 regression fix] ACPICA: Fix handling of buffer-s=
ize in
> acpi_ex_write_data_to_field()
> =

> Hi Erik,
> =

> On 28-11-18 01:05, Schmauss, Erik wrote:
> =

> <snip>
> =

> > Hi Hans,
> >
> > Thanks for your patience
> >
> >> I do not think that is the case. A lot of laptops out there use the
> >> GenericSerialBus interface in the form of an I2cSerialBus for Battery
> >> monitoring, but all these laptops pretty much exclusively use
> >> GenericSerialBus OpRegion accesses with AccessAs set to either
> >> AttribByte or AttribBytes and that has been working fine for years
> >> and the spec is clear enough on how to interpret these (esp. in
> >> combination with the DSTDs using them which make the intention clear).
> >>
> >> The problem with the Surface line of devices is that the use AccessAs
> >> AttribRawProcessBytes on which the spec is a bit handwavy, the patch
> >> in 4.20 to fix AttribRawProcessBytes breaks AttribByte and
> >> AttribBytes accesses, because for those the length field of the ACPI
> >> buffer passed when writing the field is reserved, so we should not use=
 it.
> >
> > Thanks for this data point
> >
> >>
> >> Frankly given that using GenericSerialBus OpRegion accesses with
> >> AccessAs set to either AttribByte or AttribBytes is very common, I'm
> >> amazed that there have not been more regressions reported against
> >> 4.20. Note these do not necessarily have to end up as system not
> >> booting, but could also e.g. be battery monitoring behaving weirdly.
> >>
> >> Note I was involved in the acpica discussion surrounding the patches
> >> to deal with AttribRawProcessBytes, only I was so focused on
> >> AttribRawProcessBytes that I failed to see they would break
> >> AttribByte and AttribBytes accesses at that time, only to have it
> >> poetically bite myself in the ass and at the end of a long bisect end
> >> up at the very patch I was sideways involved with.
> >
> > We looked at the spec and your patch and we came to the following
> conclusions:
> >
> > I will refer to the contents of the original patch using the #
> > character to avoid confusion with >. In the original patch you stated t=
his:
> >
> > #The ACPI 6.0 spec (ACPI_6.0.pdf) "5.5.2.4.5.2 Declaring and Using a
> > #GenericSerialBusData Buffer" (page 232) states that the
> > GenericSerialBus Data #Buffer Length field is only valid when doing a
> > Read/Write Block (AttribBlock) transfer, #but since the troublesome
> > commit we unconditionally use the len field to determine #how much
> > data to copy from the source-buffer into the temp-buffer passed to the
> #OpRegion.
> >
> > The spec is wrong on this part. LEN is used in AttribBlock,
> > AttribBlockProcessCall, and AttribRawProcessBytes,
> =

> Right, but it is NOT used for AttribByte or AttribBytes which are way more
> common and currently broken in 4.20 because of this.
> =

> > we need to know how much data to copy.
> =

> But do we really? The tmp-buffer allocated to pass to the OpRegion handler
> is sized by acpi_ex_get_protocol_buffer_length() at 255 to which 2 bytes =
get
> added for the header.
> =

> This is correct, since this may be an in/out buffer and the LEN field may=
 be
> changed to indicate that more data was returned then passed in, since we =
do
> not know the size of the returned data when the buffer is also used as an=
 out
> buffer, we must make it large enough that the data should always fit, jus=
t as
> we do in the read paths.
> =

> I really don't see why the exfield.c / exserial.c code needs to check LEN=
, it can
> simply copy all data it has in the src buffer (or as much as will fit if =
the source
> buffer is bigger then the tmp-buffer) and let the OpRegion handler figure=
 out
> how to interpret LEN without worrying about the ambiguity in the spec
> surrounding AttribBlockProcessCall and AttribRawProcessBytes.
> =

> Note that how much data has been decided to copy is not passed to the
> OpRegion handler at all.
> =

> I would expect Bob and you to actually like my approach because it delega=
tes
> the problem of interpreting LEN to the OpRegion handler which has more
> domain specific knowledge (and may be custom to the device such as in the
> Surface 3 battery monitoring case).
> =

> > Len has to be
> > correct for the handler. Your solution is treating AttribBlock,
> > AttribBlockProcessCall, and AttribRawProcessBytes in the same way as
> > everything else. I think we can try to attempt to "honor" the spirit of=
 these
> protocols by looking at LEN in certain cases.
> > However, LEN is not always reliable.
> >
> > #3) The temp-buffer passed to the OpRegion is allocated to the size
> > returned by #acpi_ex_get_serial_access_length(), which may be as
> > little as 1, so potentially this #may lead to a write overflow of the t=
emp-
> buffer.
> >
> > The temp buffer is at least 2. We missed adding 2 to the DataLengthFiel=
d.
> =

> Right I missed that while writing the commit message, but the +2 really d=
oes
> not make a difference. Since the 4.20 code currently does a memcpy using
> the reserved LEN field for AttribByte, so whether we make the tmp-buffer 1
> or 3 bytes big, we still end up copying up to 255 bytes to it which is a =
clear
> buffer overrun.
> =

> > With the new approach, we let the temporary buffer be of the max size.
> > Since LEN is
> > 8 bits, we can only have a max data length of 256. Accounting for the
> > STAT and LEN fields, the Temp Buffer should be 258. In other words, we
> > can't overflow the buffer but we definitely need to choose wisely betwe=
en
> the two.
> >
> > Anyway aside from all of those details, the primary issue here is the
> > DataLength and also how to go about choosing the appropriate one. This
> > will give the handler the correct data to deal with.
> =

> My fix is to simply give the handler *all* data we have and let it figure=
 things
> out as I said above, this delegates the interpreting of the LEN field to =
the
> OpRegion handler nicely solving the problem without needing needing to
> worry "about choosing the appropriate one" at all.
> =

> > There are hints in the spec that imply that LEN is important for some
> > protocols but the value of LEN cannot be trusted so we need to make
> > sure to check to make sure that this value is sane.
> >
> > Could you modify your patch so that we take the DataLength as correct as
> possible?
> =

> Why? There is no need for this and it needlessly complicates things, doing
> this does not win us anything at all. On the contrary it just introduces =
the
> possibility of getting things wrong again leading to more bugs now or in =
the
> future.
> =

> > Here's what I'm thinking:
> >
> > AttribQuick - data length can be one or greater but with the structure =
of
> these buffers,
> >                            2 might be easier for the handler to use.
> =

> I've no idea what the correct data length would be for AttribQuick
> =

> > AttribSendRecieve - data length can be 3 (2 for STAT/ LEN header + 1
> > data)
> =

> Ack.
> =

> > AttribByte - datalength can be 3 (same as above)
> =

> Ack.
> =

> > AttribWord - datalength can be 4 (2 header + 2 data)
> =

> Ack.
> =

> > AttribBlock - datalength should be LEN unless LEN is greater than the
> source buffer.
> >                            In this case, DataLength should be the
> > SourceBuffer's Length or  the max (whichever one is smaller)
> =

> Ack.
> =

> > AttribProcessCall - should be 4 (2 header + 2 data)
> =

> No idea again.
> =

> > AttribBlockProcessCall - same as AttribBlock
> =

> No idea again.
> =

> > AttribBytes - ignore AttribBytesFiedl and use LEN like AttribBlock
> =

> Wrong this uses the access_length field associated with the field, not th=
e LEN
> field.
> =

> > AttribRawBytes - same as AttribBytes (this one is confusing)
> =

> No idea again.
> =

> > AtrribRawProcessBytes - same as AttribBytes
> =

> The one implementation that we know of uses LEN indeed, but no idea
> about potential future implementations.
> =

> ***
> =

> So doing what you suggest would require introducing a new
> acpi_ex_get_serial_data_length function implementing the switch-case
> you've suggested above.
> =

> Then this switch-case would contain partly guess work and to make sure we
> don't overrun anything the actual memcpy would become:
> =

> 	memcpy(buffer, source_desc->buffer.pointer,
> 	       min(buffer_length, min(source_desc->buffer.length,
> data_length)));
> =

> > I think this would be a better solution. Let me know what you think and
> apologies for the slow response.
> =

> I really do not see how adding a new acpi_ex_get_serial_data_length
> function based on a bunch of guess work, which likely will be proven wrong
> in the future, is better then my solution.
> =

> The *only* effective result of all this extra code would be that we would
> maybe memcpy some less data then for the cases where
> acpi_ex_get_serial_access_length returns 255. Nothing else would change,
> the OpRegion handlers still need to interpret LEN themselves as we don't
> pass data_length to them, only now they potentially do not have the data
> they need in the buffer we pass them because we did not copy it.
> =

> I completely fail to see how this would be better, we add extra code, bas=
ed
> on a bunch of guesses. The only thing this can do is introduce more bugs,=
 see
> e.g. how you got the data-length for AtrribBytes wrong.

Right, it really is a bunch of guesses at this point...
> =

> Repeating myself I'm somewhat surprised by your and Bob's objections
> against my approach, since it gets acpica out of the game of having to gu=
ess
> what the LEN field means / when to use then LEN field and I expected that
> both you and Bob would actually be quite happy to no longer having to do
> that.
This is a good point..

Bob and I have talked it over. We'll accept your patch as long as your surf=
ace 3 also
boots and behaves as expected with this patch

Thanks for your efforts!
Erik
> =

> Regards,
> =

> Hans

--===============0998503280013027183==--

