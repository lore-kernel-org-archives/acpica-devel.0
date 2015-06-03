Content-Type: multipart/mixed; boundary="===============6681060010839494405=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: Re: [Devel] [RFC] proposed patch for some segfaults encountered
Date: Wed, 03 Jun 2015 15:26:47 -0600
Message-ID: <556F7117.9050000@redhat.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37D2F1AB8@ORSMSX112.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6681060010839494405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Awesome.  Thanks.

On 06/03/2015 03:06 PM, Moore, Robert wrote:
> Anyway, I added a check for a null target in AcpiDmIsValidTarget, and for=
 the StoreOp target case. That should at least cover all of these types of =
cases.
> =

> =

>> -----Original Message-----
>> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Al Stone
>> Sent: Monday, June 01, 2015 1:59 PM
>> To: devel(a)acpica.org
>> Subject: [Devel] [RFC] proposed patch for some segfaults encountered
>>
>> It's not clear to me that this is the correct way to handle a segfault
>> that was reported to me via Fedora.
>>
>> Using the ssdt9.dat file attached, a simple "iasl -d ssdt9.dat" will
>> segfault around calls to AcpiDmPromoteTarget -- and it turns out that the
>> Target pointer being passed into that function was sometimes null but not
>> being checked in the calling function, AcpiDmCheckForSymbolicOpcode.  So,
>> this patch adds in some checks for null pointers and can now get through
>> this particular problem.
>>
>> However, I did not study AcpiDmCheckForSymbolicOpcode long enough to
>> determine if the Target pointer in that function should or should not ev=
er
>> be null.  So, this patch fixes this issue, but it may not be the proper
>> long term solution.
>>
>> --
>> ciao,
>> al
>> -----------------------------------
>> Al Stone
>> Software Engineer
>> Red Hat, Inc.
>> ahs3(a)redhat.com
>> -----------------------------------


-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============6681060010839494405==--

