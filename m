Content-Type: multipart/mixed; boundary="===============5451206041773965213=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: Re: [Devel] [RFC] proposed patch for some segfaults encountered
Date: Tue, 02 Jun 2015 14:13:14 -0600
Message-ID: <556E0E5A.6020207@redhat.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37D2F1418@ORSMSX112.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5451206041773965213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 06/02/2015 01:06 PM, Moore, Robert wrote:
> I'll need to disassemble with the DSDT and all SSDTs.
> =

> Do you have an acpidump for the machine? Otherwise, the binary files will=
 be ok.
> =

> There are a lot of externals to other tables, and this may be a part of t=
he problem.

Aha.  So noted from the follow-on message.

I'll see if I can get the full tables.  All that was provided to me was the
one SSDT, but I'll ask the bug reporter.

>> -----Original Message-----
>> From: Moore, Robert
>> Sent: Tuesday, June 02, 2015 11:55 AM
>> To: 'Al Stone'; devel(a)acpica.org
>> Subject: RE: [Devel] [RFC] proposed patch for some segfaults encountered
>>
>> Ok, I've been able to reproduce the problem. I'll let you know how things
>> progress.
>> Bob
>>
>>
>>> -----Original Message-----
>>> From: Al Stone [mailto:ahs3(a)redhat.com]
>>> Sent: Tuesday, June 02, 2015 9:48 AM
>>> To: Moore, Robert; devel(a)acpica.org
>>> Subject: Re: [Devel] [RFC] proposed patch for some segfaults encountered
>>>
>>> On 06/02/2015 10:26 AM, Moore, Robert wrote:
>>>> Please send the ssdt9.dat file, it wasn't attached.
>>>> Bob
>>>>
>>>
>>> Ooops.  Sorry about that.
>>>
>>> --
>>> ciao,
>>> al
>>> -----------------------------------
>>> Al Stone
>>> Software Engineer
>>> Red Hat, Inc.
>>> ahs3(a)redhat.com
>>> -----------------------------------


-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============5451206041773965213==--

