Content-Type: multipart/mixed; boundary="===============7779128945778906848=="
MIME-Version: 1.0
From: =?utf-8?q?Gr=C3=A9goire_Sutre_=3Cgregoire=2Esutre_at_gmail=2Ecom=3E?=
Subject: Re: [Devel] Why are empty packages invalid for predefined ACPI
 objects?
Date: Mon, 08 Nov 2010 10:54:15 +0100
Message-ID: <4CD7C8C7.7060500@gmail.com>
In-Reply-To: 4911F71203A09E4D9981D27F9D830858BC4F53A1@orsmsx503.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7779128945778906848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 11/08/2010 05:23, Moore, Robert wrote:
> I'd have to go through the spec, but thinking about it, I'm not sure that
> any predefined name allows an empty package. All the definitions are
> either 1) Fixed length package, or 2) Variable length package that is
> defined as "one or more..."

The practical example that triggered this question is the method _DOD
(ACPI 4.0a, Appendix B, p. 698). For this method, the return value is:

     "A package containing a variable-length list of Integers, each of
      which contains the 32-bit device attribute of a child device".

As far as I can see, the specification does not require the list to be
non-empty.


On some laptop (see report [1]), the BIOS declares a device as follows:

              Device (VID2)
              {
                  Name (_ADR, 0x00020001)
                  Method (_DOS, 1, NotSerialized)
                  {
                  }


                  Method (_DOD, 0, NotSerialized)
                  {
                      Return (Package (0x00) {})
                  }
              }

The device may appear useless since _DOS does nothing and _DOD returns an
empty package. But VID2 is notified in the rest of the BIOS ASL. Maybe
the methods _DOS and _DOD under VID2 are there to identify VID2 as a display
adapter device?

On this laptop, the _DOD method triggers an ACPICA warning

ACPI Warning for \_SB_.PCI0.VID2._DOD: Return Package has no elements
(empty) (20100528/nspredef-572)

but, since VID2 conforms to the spec (afaics), is this warning really
deserved?

Best regards,

Gr=C3=A9goire

[1] http://gnats.netbsd.org/cgi-bin/query-pr-single.pl?number=3D44042

--===============7779128945778906848==--

