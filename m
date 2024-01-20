Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F525381
	for <acpica-devel@lists.linuxfoundation.org>; Sat, 20 Jan 2024 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705733431; cv=pass; b=ccKfk2K0BW9yLRQqb6jnOqlVFnL82n03aLbS1oV/q/BwnPkXEMRoCsstVmOTZaxCczGr88w7KDr1wnd3lcTjgMb68j9RL06Y8FIVS0FrhgqIuSvNVpYSRvjYBv6KrjqhRyCevADT0K+IU+jTAdPnLe1jS8PKT99ng9pbMxgfpoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705733431; c=relaxed/simple;
	bh=qavK5bzSYxa1fVDNA3aTxIyj51S9VFOKVAmPMTZ5PzQ=;
	h=Date:Subject:MIME-Version:Content-Type:From:To:Message-ID; b=LP0gDqmsOFeTxpjfDh831a5pet975fuvZgfAe71xYoPrUNdJ4VhKe8fRidmJWJZcSbNtOfbH7yrr7scBd5IMSCVf8V4W+FN5pAs3MOLEu0gPV4TTHh2mRfULbxs0cxCDe7PaPp5u2rELCRrriMmNPMwE783LLvT7TtkQAPhgGGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; arc=pass smtp.client-ip=140.211.166.137
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A715842E69
	for <acpica-devel@lists.linuxfoundation.org>; Sat, 20 Jan 2024 06:50:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A715842E69
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.902
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EDmUn7KhsO8E
	for <acpica-devel@lists.linuxfoundation.org>;
	Sat, 20 Jan 2024 06:50:28 +0000 (UTC)
X-Greylist: delayed 564 seconds by postgrey-1.37 at util1.osuosl.org; Sat, 20 Jan 2024 06:50:28 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 027C642E3F
Received: from mail-200160.simplelogin.co (mail-200160.simplelogin.co [176.119.200.160])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 027C642E3F
	for <acpica-devel@lists.linuxfoundation.org>; Sat, 20 Jan 2024 06:50:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1705732862;
	cv=none; b=CnqwA3e8YlnxPiEHV0lUeuz1grugFnmLu3knKp/I9yzCc8n3dYAzBsyO1ICupdrQQL6eTeUOquHnIeJEgoJ8x1K40SLjMfu8vGxIfI4cuKDiVViGE9jHuyAzNVEmJ17yE0O4yzf9v5X114TZnO30rn89WHwT65VOEGFFSg9qReTIx4mIihylSTVc/dKFzg0Ouw0+MB3o3R253uDqTrbpfgLzPc6YiV+mkE9oMjLdKPlB1UJ2YZ6FdgqS+JvvA+hrzlTxtd7ld7cMu4RmmDjLvaInDO+Wsg8hEt5wuT6xRfaRbnpOZk1jz/mKapp0jtA9NHoBWLzWMWro0P/2+GBEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1705732862; c=relaxed/simple;
	bh=qavK5bzSYxa1fVDNA3aTxIyj51S9VFOKVAmPMTZ5PzQ=;
	h=Date:Subject:From:To; b=aTT1UTtBPbFSZXfR+/NP0bWYgrUgGekJBRlZhYHIWsBu8foVSzSd2T5kidLz1+Hh2GXjzOmdu6ss20j/9HB7DFOUCfqbr2bNYkE4FxxeR+mCpIOtpNFJHKrsg67rRxuS4t3JJmkjR/OMAkBWuOLWGfTy7Z3REp5WJJVAx6GPd/K/Qpn8KMSz1d9E6HfYInk4YWjdkSqcyoHeRBK3ZIqwO53ECVQ3JXlz0+4dUmbpvL3PyP5hn4VOpTUZX2YC1YklhSye9nLwwjGweiiP9NdpekpucfCxCenTLgpPnUiMn0Mixi1w7YdckOxNvytqboAZtxeqW4OdKcCarrk6+oqO1A==
ARC-Authentication-Results: i=1; mail.protonmail.ch
Date: Sat, 20 Jan 2024 06:40:55 +0000
Subject: GCC 13.2.0 gives Werror=dangling-pointer= on
 components/utilities/utdebug.c
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: github826@4forl1st5.slmail.me
To: acpica-devel@lists.linuxfoundation.org
Message-ID: <170573286176.7.4536512995308409384.251813674@4forl1st5.slmail.me>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 251813674

Apologies for the noise here, however, I tried to
add the following as a comment into the GitHub issue

 https://github.com/acpica/acpica/issues/806

but I can't see that that comment has ever been added=20
into the issue?

So I thought join the list, and post my experince here,=20
in case no-one has seen it.

The text of my comment at GitHub was

----8<--------8<--------8<--------8<--------8<----
I just tried to build, against a gcc-13.2.0, from the acpica-unix-20230628 =
tarball
and see the same error, albeit at slightly different line numbers

...
obj/acpiexec ../../../source/components/utilities/utdebug.c
../../../source/components/utilities/utdebug.c: In function 'AcpiUtTrackSta=
ckPtr':
../../../source/components/utilities/utdebug.c:110:36: error: storing the a=
ddress of local variable 'CurrentSp' in 'AcpiGbl_LowestStackPointer' [-Werr=
or=3Ddangling-pointer=3D]
  110 |         AcpiGbl_LowestStackPointer =3D &CurrentSp;
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
../../../source/components/utilities/utdebug.c:105:29: note: 'CurrentSp' de=
clared here
  105 |     ACPI_SIZE               CurrentSp;
      |                             ^~~~~~~~~
In file included from ../../../source/include/acpi.h:65,
                 from ../../../source/components/utilities/utdebug.c:46:
../../../source/include/acglobal.h:229:41: note: 'AcpiGbl_LowestStackPointe=
r' declared here
  229 | ACPI_GLOBAL (ACPI_SIZE *,               AcpiGbl_LowestStackPointer)=
;
      |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
../../../source/include/acpixf.h:80:17: note: in definition of macro 'ACPI_=
GLOBAL'
   80 |     extern type name

      |                 ^~~~
cc1: all warnings being treated as errors
make[1]: *** [../Makefile.rules:20: obj/utdebug.o] Error 1
make[1]: Leaving directory '/sources/acpica-unix2-20230628/generate/unix/ac=
piexec'
make: *** [Makefile.common:7: acpiexec] Error 2

however I do note that the

source/components/utilities/utdebug.c

does have the pragma modification, as mentioned in the Jan 20, 2023 comment=
,
applied in the source

void
AcpiUtInitStackPtrTrace (
    void)
{
    ACPI_SIZE               CurrentSp;


#pragma GCC diagnostic push
#if defined(__GNUC__) && __GNUC__ >=3D 12
#pragma GCC diagnostic ignored "-Wdangling-pointer=3D"
#endif
    AcpiGbl_EntryStackPointer =3D &CurrentSp;
#pragma GCC diagnostic pop
}

All I did after unpacking the tarball was

cd generate/unix/
make

Have I missed something?
----8<--------8<--------8<--------8<--------8<----


although I have since realised that the error message I pasted
came from when I was using the=20

acpica-unix2-20230628

tarball, not acpica-unix-20230628 as I originally wrote, although=20
suffice it to say that I've seen the same message using the sources=20
from either.




