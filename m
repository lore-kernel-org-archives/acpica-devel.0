Content-Type: multipart/mixed; boundary="===============5343342749204507902=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Correct ACPI setup sequence
Date: Fri, 04 Sep 2009 13:28:48 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308583748B9AB@orsmsx503.amr.corp.intel.com>
In-Reply-To: 20090904202524.GB8443@britannica.bec.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5343342749204507902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sorry, I'm not an expert on the interrupt routing and MADT stuff.

Perhaps someone else here can answer this.


>-----Original Message-----
>From: Joerg Sonnenberger [mailto:joerg(a)britannica.bec.de]
>Sent: Friday, September 04, 2009 1:25 PM
>To: Moore, Robert
>Cc: devel(a)acpica.org
>Subject: Re: [Devel] Correct ACPI setup sequence
>
>On Fri, Sep 04, 2009 at 01:23:30PM -0700, Moore, Robert wrote:
>> >- If the MADT exists and contains IOAPICs, I can expect \_PIC to be
>> >  successful.
>>
>>
>> I don't know the answer to this.
>
>What would be the most sensible behavior if it fails and the MADT listed
>an entry for the SCI?
>
>> >PS: ACPI 4.0 has a bad cross-reference in 5.2.12.4, 5.2.10.8 no longer
>> >exists. Who is the right person for that?
>>
>>
>> I just forwarded this to the ACPI 4.0 editor. Thanks. You can send any
>> such errors directly to me. We own the ACPI specification here.
>
>Good to know, thanks.
>
>Joerg

--===============5343342749204507902==--

