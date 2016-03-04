Content-Type: multipart/mixed; boundary="===============5677796239039428982=="
MIME-Version: 1.0
From: Will Miles <wmiles at sgl.com>
Subject: Re: [Devel] QNX port?
Date: Fri, 04 Mar 2016 12:55:02 -0500
Message-ID: <56D9CBF6.3010205@sgl.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37E44F0B6@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5677796239039428982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bob,

Awesome, thank you!   I did need to add QNX ifdefs in the =

os_specific/service_layers C code, but that was it - I don't think =

that's what you mean by the actual modules, though, and there were =

already many such ifdefs in there.   Otherwise it was, just like you =

say, adding a new acqnx.h header with the corresponding acenv.h entry =

and Makefile changes only.

Would you prefer a patch sent to this mailing list, or a pull request on =

github?

Thanks,
-Will

On 2016-03-04 12:45 PM, Moore, Robert wrote:
> We would be happy to accept an OS-specific header and integrate it into t=
he acenv.h header. We do in fact support many "unusual" operating systems i=
n this way.
>
> However, we do not want any OS-specific code (#ifdefs) in the actual C mo=
dules.
>
> Bob
>
>> -----Original Message-----
>> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Will Miles
>> Sent: Friday, March 04, 2016 9:23 AM
>> To: devel(a)acpica.org
>> Subject: [Devel] QNX port?
>>
>> Hi ACPICA developers,
>>
>> Do you have any interest in accepting patches for unusual target
>> platforms?   I've made a small patch to port the ACPICA package to QNX
>> 6.6 for use as part of a device enumerator for my company's data
>> acquisition systems, and I'd be happy to send a pull request if there's
>> any interest in including such support to the upstream distribution.
>>
>> Thanks,
>> -Will Miles
>> Sander Geophysics Ltd.
>>
>> _______________________________________________
>> Devel mailing list
>> Devel(a)acpica.org
>> https://lists.acpica.org/mailman/listinfo/devel


--===============5677796239039428982==--

