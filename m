Content-Type: multipart/mixed; boundary="===============4771455679503320098=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [RFC PATCH v2 0/5] ACPICA: Tables: Add deferred
 verification support
Date: Fri, 19 May 2017 07:59:29 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CEA5F31@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 71329223-dbb4-2845-a14e-3db579ca552b@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4771455679503320098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Hans

> From: Hans de Goede [mailto:hdegoede(a)redhat.com]
> Subject: Re: [RFC PATCH v2 0/5] ACPICA: Tables: Add deferred verification=
 support
> =

> Hi,
> =

> On 16-05-17 09:13, Lv Zheng wrote:
> > On linux, we can not verify ACPI tables before installing them into the
> > global table list in early stage due to the number of slot limitations =
for
> > early ioremap. This leaves a problem that we cannot detect duplicated
> > tables in early stage, causing unwanted error messages seen when the
> > duplicated tables are failed to be loaded [link #1].
> >
> > This patchset as ACPICA PR [link #2] adds support to verify tables in
> > acpi_reallocate_root_tables() which is invoked after installing tables =
in
> > early stage, being ready for late ioremap and beofre loading table in l=
ate
> > stage. If duplicated tables are detected, acpi_reallocate_root_tables()
> > stops installing them to the final reallocated global table list.
> >
> > In v1 patchset [link #3], problems can be seen for dynamic loading tabl=
es
> > which are allocated as virtuall allocated tables. Such tables are
> > incremented in the global table list as the sanity check done in install
> > step only compares the table addresses while the virtual allocated
> > addresses are not stable.
> > In v2 patchset, we follow original design discussion made in ACPICA dev=
el
> > mailing list, implements deferred table verification so that duplicate
> > tables are still can be detected in install step rather than in load st=
ep.
> > Also we removed table signature check according to verified windows
> > behavior [link #4] and reported issues [link #5].
> >
> > Link: http://www.spinics.net/lists/linux-acpi/msg72215.html [#1]
> > Link: https://github.com//acpica/acpica/pull/265            [#2]
> > Link: http://www.spinics.net/lists/linux-acpi/msg72589.html [#3]
> > Link: https://github.com//acpica/acpica/pull/121            [#4]
> >        https://bugzilla.kernel.org/show_bug.cgi?id=3D118601    [#5]
> >
> > Lv Zheng (5):
> >    ACPICA: Tables: Cleanup table handler invokers
> >    ACPICA: Tables: Do not validate signature for dynamic table load
> >    ACPICA: Tables: Change table duplication check to be related to
> >      acpi_gbl_verify_table_checksum
> >    ACPICA: Tables: Combine checksum/duplication verification together
> >    ACPICA: Tables: Add deferred table verification support
> =

> I've tested these patches and can confirm that they fix the ACPI
> errors on the system which started this all.
> =

> Note I've tested "v2" of the patch-set, I was on the Cc for the
> cover letter for v3, but I did not receive the actual patches,
> if you want me test v3 please send me the patches (or point
> me to a git branch with them).

What I added is:
		*table_index =3D i;
In acpi_tb_install_standard_table().
Without this line, Load a table 2nd time after the 1st time Load/Unload wil=
l fail.
Other changes are not functional. I'm sorry for that mistake.

Testing v2 can be sufficient as what v3 improves is not strictly related to=
 your issue.
And we can ensure the v3 improvement's quality locally while for your issue=
 I cannot.

So it's OK if you don't do any further testing, but if you want to try:
You can reach the code via the following git repository:
https://github.com/zetalog/linux/
They are top 5 commits in acpica-tables2 branch:
https://github.com/zetalog/linux/commits/acpica-tables2

# git remote add linux-acpica https://github.com/zetalog/linux/
# git fetch linux-acpica
# git checkout acpica-tables2

Thanks and best regards
Lv

--===============4771455679503320098==--

