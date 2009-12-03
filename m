Content-Type: multipart/mixed; boundary="===============4408122361747917325=="
MIME-Version: 1.0
From: master chief <mail4chief at yahoo.com>
Subject: [Devel] Base Address Granularity
Date: Thu, 03 Dec 2009 11:28:28 -0800
Message-ID: <136943.16644.qm@web62007.mail.re1.yahoo.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4408122361747917325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the ACPI specification, under IO (IO Resource Descriptor Macro) I read:

"AddressAlignment evaluates to an 8-bit integer that specifies the alignmen=
t granularity for the I/O address assigned. The field DescriptorName. _ALN =
is automatically created to refer to this portion of the resource descripto=
r."

And while the latter part about the addition of _ALN is perfectly clear to =
me, I have trouble understanding the former part.  I looked at a number of =
Apple, Asus and GigaByte DSDT's and there I find Apple and GigaByte using a=
 granularity of 0x01 and Asus 0x00.

Apparently both work, even in my own DSDT code, but I cannot for the life o=
f me find anything related to the exact meaning of this "granularity".

Please advise.  Thank you.

Chief


     =20

--===============4408122361747917325==--

