Content-Type: multipart/mixed; boundary="===============6091266675417898827=="
MIME-Version: 1.0
From: Dean Nelson <dnelson at redhat.com>
Subject: Re: [Devel] [PATCH] eliminate use after free in
 AcpiOsGetNextFilename()
Date: Tue, 19 Nov 2013 12:06:08 -0600
Message-ID: <528BA890.5060503@redhat.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37C7A349E@ORSMSX103.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6091266675417898827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 11/19/2013 10:54 AM, Moore, Robert wrote:
> Could you open a bugzilla on this? Thanks.
>
> https://bugs.acpica.org/

Just did.

Sorry, if I'm not doing things in the manner desired. I'm quite a
novice to acpica. If you prefer that we open BZs and not post patches
to the mailing list, I'm fine with that. Just let me know the protocol
to follow.

I'm pulling acpica-unix2 into RHEL and Coverity Scan (a static analysis
tool for C source code) flagged 164 potential 'defects'. A number are
false-positives, but some are legit. (I've not been through them all,
so I don't know the numbers.)

This was one of the legit ones, though the likelihood of it ever
showing up is about NIL. I posted the patch because it was trivial
and from it I hoped to learn how your process works.

As time allows, I hope to deal with the other legitimately flagged
'defects'. But it will probably be awhile, as there are other pressing
needs to attend to.

Thanks,
Dean

--===============6091266675417898827==--

