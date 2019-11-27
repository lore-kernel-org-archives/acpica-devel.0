Content-Type: multipart/mixed; boundary="===============0977078109011716490=="
MIME-Version: 1.0
From: Schmauss, Erik <erik.schmauss at intel.com>
Subject: [Devel] Re: PROBLEM: Calling ObjectType on buffer field reports type
 integer
Date: Wed, 27 Nov 2019 00:25:51 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C688D60@ORSMSX122.amr.corp.intel.com>
In-Reply-To: 20f023a8-67f2-71dd-266d-700012c05b39@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0977078109011716490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> =

> This looks like a separate problem to me. On the SB2 there is this piece =
of code,
> simplified:
> =

>      Name(RQBF, Buffer (0xFF) {})
>      CreateByteField (RQBF, 0x03, ALEN)
> =

>      // ...
>      // GenericSerialBus/AttribRawProcessBytes access to fill RQBF
>      // ...
> =

>      If (/* success and everything is valid */)
>      {
>          Local3 =3D (ALEN * 0x08)
>          CreateField (RQBF, 0x20, Local3, ARB)
>          Local4 =3D ARB /* \_SB_._SAN.RQSX.ARB_ */
>      }
>      Else
>      {
>          Local4 =3D 0x01   // or some other error code as integer
>      }
> =

>      // ...
>      // some more stuff
>      // ...
> =

>      If ((ObjectType (Local4) =3D=3D One /* Integer */))
>      {
>          // notify that an error has occurred
>      }
>      Else
>      {
>          // success and actually use data from Local4
>      }
> =

> The code in question basically unpacks a payload from some other
> management stuff sent over the OperationRegion.
> =

> Here, ALEN is the length of a dynamically sized payload in bytes, which is
> obtained from the data returned by the OperationRegion access. This can f=
or
> example be 4, making the field length 32 bit. So this is not an issue of =
the field
> length being larger than intmax bits, it actually is sometimes only 32 bi=
ts, or 8
> bits, depending on the response of the driver connected to the
> OperationRegion. Also the DSDT depends on that, see the example below.
> =

> Just to reiterate, the code works fine for payloads with ALEN > 8 (so mor=
e than
> 8 bytes), but fails for anything less.

Forget what I said in the previous email. You are correct.

They treat bufferfields that are small enough to fit inside of an integer a=
s a buffer or bufferfield.

I did a bunch of testing on windows and determined that, objects created by=
 Create(Bit|Byte|Word|DWord|Qword)Field
work the same way on both interpreters. They get converted to Integers as o=
utlined in the spec.

We simply need to stop perform the BufferField->Integer conversion for buff=
er fields created by the ASL CreateField() operators.
I'll get a solution hopefully sometime next week..

Thanks,
Erik

> =

> Also note that this is not something that can be fixed by just telling the
> GenericSerialBus/OperationRegion driver to just return 9 bytes
> instead: There are length-checks on Local4 further down the line to valid=
ate it
> actually contains what was requested.
> =

> An example of how this piece of code is actually used, if that helps (aga=
in
> simplified):
> =

>      Method (RQST, 1)
>      {
>          // pretty much the code above
>          Return (Local4)     // either payload or integer error code
>      }
> =

>      Scope (_SB.BAT1)
>      {
>          Method (_STA, 0)
>          {
>              Local0 =3D RQST(0x01)     // request battery status
> =

>              If ((ObjectType (Local0) =3D=3D 0x03))      // is buffer type
>              {
>                  If ((SizeOf (Local0) =3D=3D 0x04))      // has length 4
>                  {
>                      CreateDWordField (Local0, 0, BAST)
>                      Return (BAST)
>                  }
>              }
> =

>              Return (0x00)           // return default value
>          }
>      }
> =

> =

> Regards,
> Maximilian

--===============0977078109011716490==--

