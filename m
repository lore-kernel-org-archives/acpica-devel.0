Content-Type: multipart/mixed; boundary="===============1517266533478617023=="
MIME-Version: 1.0
From: Andriy Gapon <avg at FreeBSD.org>
Subject: [Devel] ref-counting races?
Date: Fri, 09 Nov 2012 09:33:39 +0200
Message-ID: <509CB1D3.2020107@FreeBSD.org>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1517266533478617023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


It looks like the reference count manipulations performed in
AcpiUtUpdateRefCount/AcpiUtUpdateObjectReference are not protected by any l=
ock.
 Although, it is possible that I am missing some implied locking in the hig=
her
levels.

In particular, I am concerned about access to the ASL elements like Name(_H=
ID,
2) via AcpiNsEvaluate -> AcpiExResolveNodeToValue.  In this case multiple
threads can concurrently get or drop references to the value object.

The reason to inquire about this is that over the time several FreeBSD user=
s has
reported some seldom occurring, non-reproducible, ACPI-related heisen-panic=
s.
Their common element is a trap upon memory access in
AcpiOsAcquireObject(AcpiGbl_OperandCache).  Which, in my opinion, strongly =
hints
at corruption of AcpiGbl_OperandCache via double-deallocation of an object.
Which I then connect to the reference counting.

Some links:
http://lists.freebsd.org/pipermail/freebsd-current/2012-March/032637.html
http://lists.freebsd.org/pipermail/freebsd-acpi/2012-January/007406.html
http://thread.gmane.org/gmane.os.freebsd.stable/83262/focus=3D83445
https://bugs.dragonflybsd.org/issues/568


-- =

Andriy Gapon

--===============1517266533478617023==--

