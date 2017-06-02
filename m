Content-Type: multipart/mixed; boundary="===============2739771162267836498=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Concatenate() operator
Date: Fri, 02 Jun 2017 14:48:35 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5BD5A8@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 679bcec8-c7bc-6bc9-873d-4500d327e9ee@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2739771162267836498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


There are a few things going on here.

1) The version of the DSDT is 1, so integers are 32 bits (as per ACPI speci=
fication). So, any integers larger than 32 bits are truncated to 32 bits. C=
hange the version to 2, and you will get 64-bit integers.

2) Yes, the strings will be converted to integers

2) The compiler is folding both Concatenate operators to simple constants (=
buffers). =


3)The string-to-integer implicit conversion is in fact covered by the ACPI =
spec, and the strings are always treated as hex constants, as below:

19.3.5.7 Data Type Conversion Rules

From String-to-Integer conversion section from the table:

"the ASCII string is interpreted as a hexadecimal constant"
"a 0x prefix is not allowed"

There are no octal constants in all of ACPI, BTW.


I think this covers your questions.
Bob



--===============2739771162267836498==--

