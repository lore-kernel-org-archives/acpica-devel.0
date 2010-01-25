Content-Type: multipart/mixed; boundary="===============3796274192379531339=="
MIME-Version: 1.0
From: Joerg Sonnenberger <joerg at britannica.bec.de>
Subject: Re: [Devel] Help!!!! Help on wake up from S3.
Date: Mon, 25 Jan 2010 08:54:11 +0100
Message-ID: <20100125075411.GA11773@britannica.bec.de>
In-Reply-To: 316f56811001242253h3e7c0972o778ef0847b7c433f@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3796274192379531339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2010 at 02:53:46PM +0800, Sean Shoufu Luo wrote:
> But the problem comes, when I pressed the power button at the
> second time, I found the the light of power button become yellow but still
> flash, lasting about 3/4 seconds, it turned to be green again, and monitor
> is lighted, system goes up. But, it does't jump to the WakingVector that I
> install with AcpiSetFirmwareWakingVecotr() before I put it into S3, inste=
ad,
> it booted from IDE ...

The symptoms you are descriping sound like a triple fault, which is very
easy to trigger from wake up code. Are you sure your wake up code is not
called? I would strongly suggest you to start with a simple infinite
loop using a near jump to check if it actually reached your vector.

Joerg

--===============3796274192379531339==--

