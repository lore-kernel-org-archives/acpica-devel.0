Content-Type: multipart/mixed; boundary="===============6171915476177630064=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] ACPI RASF table
Date: Fri, 04 Jan 2013 06:48:50 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BDD31C@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 3FA2EDDD157D654A9522220A2E3948267C8E5B@G1W3641.americas.hpqcorp.net
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6171915476177630064==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Can you offer a acpidump including the RASF table that can be found in the =
real machine?

Best regards
-Lv

From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On Beh=
alf Of Guo, Shuangshuan (Suney(a)CFE-CTS)
Sent: Thursday, December 20, 2012 11:23 AM
To: devel(a)acpica.org
Subject: [Devel] ACPI RASF table

Hi,
=C2=A0 I am working on the ACPI 5.0 table RASF (RAS Feature), in ACPI-CA sr=
c code there is a struct ACPI_RASF_SHARED_MEMORY to descript the RASF commu=
nication channel in actbl3.h.
/* RASF Platform Communication Channel Shared Memory Region */

typedef struct acpi_rasf_shared_memory
{
=C2=A0=C2=A0=C2=A0 UINT32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Signature;
=C2=A0=C2=A0=C2=A0 UINT16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Command;
=C2=A0=C2=A0=C2=A0 UINT16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Status;
=C2=A0=C2=A0=C2=A0 UINT64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RequestedAddress;
=C2=A0=C2=A0=C2=A0 UINT64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RequestedLength;
=C2=A0=C2=A0=C2=A0 UINT64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ActualAddress;
=C2=A0=C2=A0=C2=A0 UINT64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ActualLength;
=C2=A0=C2=A0=C2=A0 UINT16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags;
=C2=A0=C2=A0=C2=A0 UINT8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Speed;

} ACPI_RASF_SHARED_MEMORY;

=C2=A0But it seems it does not follow the ACPI spec definition in 5.2.20.3 =
RASF Communication Channel. Actually I can't understand what the mean of "R=
equestedAddress" here is. In my opinion, PATROL SCRUB block needs the Reque=
stedAddress and ActualAddress.
I am using the ACPICA version 20121018
Is there any ACPICA developer can take a look?


Regards,

shuang-shuan,guo
Center for Firmware Expertise
Business Critical Systems


--===============6171915476177630064==--

