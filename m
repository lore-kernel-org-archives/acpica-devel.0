Content-Type: multipart/mixed; boundary="===============4291011546122577460=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: [Devel] [PATCH] explicit licensing file?
Date: Tue, 20 Aug 2013 17:48:46 -0600
Message-ID: <5214005E.10208@redhat.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4291011546122577460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Greetings.

Would it be possible to use the following patch?  Or, a file
very similar to it -- I do not know if the wording of the first
paragraph would be acceptable or not, so it may need changing.

The reason I ask is that this makes life much simpler for the
various Linux distributions.  In the Unix(tm) versions provided
at acpica.org, _most_ files have a nicely done header that lays
out the licensing.  In fact, in the patch below, everything from
"Copyright..." to the end is from that header.

However, not all files have the header (e.g., the AAPITS tests,
and some of the .sh or Makefiles used) which makes both Debian
and Fedora a little nervous.  The FAQ clearly states the GPL
can be used, but the source code does not always repeat it.

I am currently the primary uploader for Debian of a package called
'acpica-tools' that provides all of the user space commands from
the ACPICA source trees.  Further, when the package is built, the
ASLTS and AAPITS tests are run against the commands to help with
QA.  I am doing the same work for Fedora, and trying to keep both
distributions (and in turn, their derivatives) as up-to-date as
possible.

Having this one file in the ACPICA provided source trees for
Unix(tm) would help make things much clearer for both of these
Linux distributions.

Thanks in advance for your consideration.

---
  LICENSE | 44 ++++++++++++++++++++++++++++++++++++++++++++
  1 file changed, 44 insertions(+)
  create mode 100644 LICENSE

diff --git a/LICENSE b/LICENSE
new file mode 100644
index 0000000..7a39325
--- /dev/null
+++ b/LICENSE
@@ -0,0 +1,44 @@
+Licensing for Linux Systems:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+Whether explicitly stated in the source code for this software or not,
+this software is distributed under the terms of the GNU General Public
+License ("GPL") version 2 as published by the Free Software Foundation.
+This is in accordance with the following license from Intel Corporation
+that should be a part of all source code files:
+
+
+   Copyright (C) 2000 - 2013, Intel Corp.
+   All rights reserved.
+
+   Redistribution and use in source and binary forms, with or without
+   modification, are permitted provided that the following conditions
+   are met:
+   1. Redistributions of source code must retain the above copyright
+      notice, this list of conditions, and the following disclaimer,
+      without modification.
+   2. Redistributions in binary form must reproduce at minimum a disclaimer
+      substantially similar to the "NO WARRANTY" disclaimer below
+      ("Disclaimer") and any redistribution must be conditioned upon
+      including a substantially similar Disclaimer requirement for further
+      binary redistribution.
+   3. Neither the names of the above-listed copyright holders nor the names
+      of any contributors may be used to endorse or promote products =

derived
+      from this software without specific prior written permission.
+
+   Alternatively, this software may be distributed under the terms of the
+   GNU General Public License ("GPL") version 2 as published by the Free
+   Software Foundation.
+
+   NO WARRANTY
+   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+   HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR =

CONSEQUENTIAL
+   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+   OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+   HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+   STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+   IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+   POSSIBILITY OF SUCH DAMAGES.
+
-- =

1.8.3.1



-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============4291011546122577460==--

