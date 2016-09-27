Content-Type: multipart/mixed; boundary="===============3598728293529090579=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] Turning iasl's "-oe" option into a documented,
 regular option?
Date: Tue, 27 Sep 2016 21:25:03 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E503A74@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37E503A5D@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3598728293529090579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From our code:

    /*
     * March, 2015:
     * The _REV object is in the process of being deprecated, because
     * other ACPI implementations permanently return 2. Thus, it
     * has little or no value. Return 2 for compatibility with
     * other ACPI implementations.
     */
    {"_REV",    ACPI_TYPE_INTEGER,          ACPI_CAST_PTR (char, 2)},



> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Moore, Robert
> Sent: Tuesday, September 27, 2016 2:24 PM
> To: Michael S. Tsirkin <mst(a)redhat.com>
> Cc: Box, David E <david.e.box(a)intel.com>; Laszlo Ersek
> <lersek(a)redhat.com>; devel(a)acpica.org
> Subject: Re: [Devel] Turning iasl's "-oe" option into a documented,
> regular option?
> =

> I believe \_REV is deprecated because some operating systems did not
> keep it updated.
> =

> We have a big issue concerning the External() opcode, because we would
> rather not have firmware vendors disabling it. This would bypass the
> entire reason for the existence of this opcode.
> =

> =

> =

> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst(a)redhat.com]
> > Sent: Tuesday, September 27, 2016 10:11 AM
> > To: Moore, Robert <robert.moore(a)intel.com>
> > Cc: Laszlo Ersek <lersek(a)redhat.com>; devel(a)acpica.org; Box, David E
> > <david.e.box(a)intel.com>
> > Subject: Re: Turning iasl's "-oe" option into a documented, regular
> > option?
> >
> > On Tue, Sep 27, 2016 at 10:36:11AM +0000, Moore, Robert wrote:
> > > We will take a look at this.
> > >
> > > The "module-level code" (executable AML outside of any control
> > > method)
> > was made legal again around ACPI 3.0, and ACPICA supports it.
> >
> > Absolutely. The issue for us is that unlike other code where we need
> > to actually add the code in ASL in order to get something in AML, in
> > this case the module-level code seems to be added unconditionally.
> > So producing compatible code is easy - just don't call things from
> > newer ACPI versions.
> > In other cases, in ASL we can do things like looking at \_REV and
> > supplying compatibility code.
> >
> > However in this case, there seems to literally be nothing we can do in
> > ASL if we want to get ACPI 2.0 and back compatibility, because we care
> > about supporting old OSPMs.
> >
> > Our work-around for now is just using an old version of iasl or a new
> > one with -oe, but if -oe will be gone I'm not sure what we can do.
> >
> >
> >
> > > The External opcode is very important in order to easily parse
> > > control
> > method invocations -- especially noticeable in the disassembler, but
> > can also assist with "normal" AML parsing.
> > >
> > > Bob
> >
> > Sure.
> > It makes sense to me that ACPI 3.0 is old enough that the default you
> > chose is reasonable.
> > But being able to produce code that's compatible with historical ACPI
> > versions and can run on old OSPMs also has value IMO.
> >
> > Does this make sense?
> >
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Laszlo Ersek [mailto:lersek(a)redhat.com]
> > > > Sent: Tuesday, September 27, 2016 3:30 AM
> > > > To: Moore, Robert
> > > > Cc: devel(a)acpica.org; Michael Tsirkin; Box, David E
> > > > Subject: Re: Turning iasl's "-oe" option into a documented,
> > > > regular option?
> > > >
> > > > On 09/27/16 09:11, Laszlo Ersek wrote:
> > > > > On 09/27/16 03:56, Moore, Robert wrote:
> > > > >>
> > > > >>
> > > > >>> -----Original Message-----
> > > > >>> From: Laszlo Ersek [mailto:lersek(a)redhat.com]
> > > > >>> Sent: Monday, September 26, 2016 3:11 PM
> > > > >>> To: Moore, Robert
> > > > >>> Cc: devel(a)acpica.org; Michael Tsirkin; Box, David E
> > > > >>> Subject: Re: Turning iasl's "-oe" option into a documented,
> > > > >>> regular option?
> > > > >>>
> > > > >>> On 09/26/16 23:34, Moore, Robert wrote:
> > > > >>>>
> > > > >>>>
> > > > >>>>> -----Original Message-----
> > > > >>>>> From: Laszlo Ersek [mailto:lersek(a)redhat.com]
> > > > >>>>> Sent: Monday, September 26, 2016 2:23 PM
> > > > >>>>> To: Moore, Robert <robert.moore(a)intel.com>
> > > > >>>>> Cc: devel(a)acpica.org; Michael Tsirkin <mtsirkin(a)redhat.co=
m>
> > > > >>>>> Subject: Turning iasl's "-oe" option into a documented,
> > > > >>>>> regular
> > > > option?
> > > > >>>>>
> > > > >>>>> Hi,
> > > > >>>>>
> > > > >>>>> the addition of the External() opcode (i.e., 0x15), from
> > > > >>>>> ACPI v6.0, causes iASL to generate AML that breaks old
> > > > >>>>> versions of ACPICA's AML interpreter that are shipped with
> > > > >>>>> old (but still variably supported) Linux distributions, for
> > > > >>>>> example, RHEL-
> > 5.11.
> > > > >>>>> The breakage happens despite the If(0) conditional that
> > > > >>>>> surrounds the opcode and is supposed to hide it.
> > > > >>
> > > > >>
> > > > >> Please explain further. The design of the External opcode was
> > > > specifically chosen as to not break existing interpreters.
> > > > >
> > > > > At the moment I can provide only the following info: when we
> > > > > boot the
> > > > > RHEL-5.11 kernel against AML that was generated with recent iASL
> > > > > (without passing the -oe switch), the kernel logs
> > > > >
> > > > >> ACPI: Core revision 20060707
> > > > >> ACPI Error (psloop-0196): Found unknown opcode 15 at AML
> > > > >> address
> > > > >> ffffc20000008da8 offset 4, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 15 at AML address
> > > > >> ffffc20000008daf offset B, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 15 at AML address
> > > > >> ffffc20000008db6 offset 12, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 15 at AML address
> > > > >> ffffc20000008dbd offset 19, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 3 at AML address
> > > > >> ffffc20000008dc2 offset 1E, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 15 at AML address
> > > > >> ffffc20000008dc4 offset 20, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 3 at AML address
> > > > >> ffffc20000008dc9 offset 25, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 15 at AML address
> > > > >> ffffc20000008dcb offset 27, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 3 at AML address
> > > > >> ffffc20000008dd0 offset 2C, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 15 at AML address
> > > > >> ffffc20000008dd2 offset 2E, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 15 at AML address
> > > > >> ffffc20000008da8 offset 4, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 15 at AML address
> > > > >> ffffc20000008daf offset B, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 15 at AML address
> > > > >> ffffc20000008db6 offset 12, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 15 at AML address
> > > > >> ffffc20000008dbd offset 19, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 3 at AML address
> > > > >> ffffc20000008dc2 offset 1E, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 15 at AML address
> > > > >> ffffc20000008dc4 offset 20, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 3 at AML address
> > > > >> ffffc20000008dc9 offset 25, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 15 at AML address
> > > > >> ffffc20000008dcb offset 27, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 3 at AML address
> > > > >> ffffc20000008dd0 offset 2C, ignoring [20060707] ACPI Error
> > > > >> (psloop-0196): Found unknown opcode 15 at AML address
> > > > >> ffffc20000008dd2 offset 2E, ignoring [20060707] ACPI Error
> > > > >> (dsobject-0134): [ON^D] Namespace lookup failure, AE_NOT_FOUND
> > > > >> ACPI Exception (tbxface-0113): AE_NOT_FOUND, Could not load
> > namespace [20060707] ACPI Exception (tbxface-0120):
> > > > >> AE_NOT_FOUND, Could not load tables [20060707]
> > > > >> ACPI: Unable to load the System Description Tables
> > > > >
> > > > > I haven't looked into the "[ON^D] Namespace lookup failure"
> > > > specifically, but I think it's a consequence of the earlier
> > > > parsing errors (the parser assumes that unknown opcodes are 1 byte
> > > > in size, which I think isn't correct for External(), so I think
> > > > the parser gets out of sync with the AML byte stream).
> > > > >
> > > > > With the RHEL-6 (our currently closest data point, in time), we
> > > > > get
> > > > >
> > > > >> ACPI: Core revision 20090903
> > > > >
> > > > > and no error messages; the tables are parsed and they work fine.
> > > > >
> > > > > So, it seems that the interpreter in RHEL-5.11 tries to parse
> > > > > the
> > > > package that is conditional on If(0). As Michael said this is not
> > > > for execution (yet), just for interpretation, but it breaks the
> > > > interpreter nonetheless.
> > > > >
> > > > > Here's a memory dump from the guest kernel, around virtual
> > > > > address
> > > > 0xffffc20000008da8 (for which the first error message is printed):
> > > > >
> > > > >   crash> rd -8 ffffc20000008d80 100
> > > > >   ffffc20000008d80:  44 53 44 54 8b 11 00 00 01 b5 42 4f 43 48
> > > > > 53
> > > > > 20
> > > > DSDT......BOCHS
> > > > >   ffffc20000008d90:  42 58 50 43 44 53 44 54 01 00 00 00 42 58
> > > > > 50
> > > > > 43
> > > > BXPCDSDT....BXPC
> > > > >   ffffc20000008da0:  01 00 00 00 a0 43 05 00 15 50 30 53 5f 01
> > > > > 00
> > > > > 15
> > > > .....C...P0S_...
> > > > >                                  ^  ^  ^  ^  ^
> > > > >                                  |  |  |  |  ExternalOp (@
> > > > 0xffffc20000008da8)
> > > > >                                  |  |  |  Predicate
> > > > >                                  |  |  ByteData =3D 0x05
> > > > >                                  |  PkgLeadByte =3D 67 dec =3D
> > > > > 0100_0011
> > > > bin;
> > > > >                                  |  PkgLength =3D 0x53 =3D 83 dec
> > > > >                                  IfOp
> > > > >   ffffc20000008db0:  50 30 45 5f 01 00 15 50 31 56 5f 01 00 15
> > > > > 50
> > > > > 31
> > > > P0E_...P1V_...P1
> > > > >   ffffc20000008dc0:  53 5f 03 00 15 50 31 45 5f 03 00 15 50 31
> > > > > 4c 5f
> > > > S_...P1E_...P1L_
> > > > >   ffffc20000008dd0:  03 00 15 5c 2f 03 5f 53 42 5f 50 43 49 30
> > > > > 50
> > > > > 43
> > > > ...\/._SB_PCI0PC
> > > > >   ffffc20000008de0:  4e 54 08 02
> > > > NT..
> > > > >
> > > > > I believe that the interpreter must have seen a change, between
> > > > > 20060707
> > > > and 20090903, that makes it skip a conditional package *even for
> > > > parsing* if it can determine that the predicate is constant false.
> > > > (This skipping is possible because the package length is encoded
> > > > at a fixed position within DefIfElse, so it can be parsed before /
> > > > independently of the conditional block ("TermList") itself:
> > > > >
> > > > >   DefIfElse :=3D IfOp PkgLength Predicate TermList DefElse
> > > > > )
> > > >
> > > > I think I've found it.
> > > >
> > > > Using various historical Fedora kernels, I first narrowed it down
> > > > to v2.6.31..v2.6.32. (The former breaks, the latter works, with
> > > > the
> > > > External() opcodes in the AML.)
> > > >
> > > > Then, using a RHEL-6 virtual machine, I performed an inverse
> > > > bisection on this range. The bisection was restricted to the
> > > > drivers/acpi/ subdirectory.
> > > >
> > > > Here's the bisection log (again, note that "bad" means "working",
> > > > and "good" means "broken", because I was looking for a commit that
> > > > fixed things, not for a commit that regressed things):
> > > >
> > > > > git bisect start '--' 'drivers/acpi/'
> > > > > # good: [74fca6a42863ffacaf7ba6f1936a9f228950f657] Linux 2.6.31
> > > > > git bisect good 74fca6a42863ffacaf7ba6f1936a9f228950f657
> > > > > # bad: [22763c5cf3690a681551162c15d34d935308c8d7] Linux 2.6.32
> > > > > git bisect bad 22763c5cf3690a681551162c15d34d935308c8d7
> > > > > # bad: [53de5356be3ac62c22ae1da266943059b169d9b1] ACPI: don't
> > > > > pass handle for fixed hardware notifications git bisect bad
> > > > > 53de5356be3ac62c22ae1da266943059b169d9b1
> > > > > # bad: [985f38781d19101aba121df423f92c87b208c6df] Merge branch
> > > > > 'acpica' into release git bisect bad
> > > > > 985f38781d19101aba121df423f92c87b208c6df
> > > > > # bad: [e678902ee899f6b0ab48166b410cdc9f1c27a350] ACPICA: Remove
> > > > > error message for Store(Localx,Localx) git bisect bad
> > > > > e678902ee899f6b0ab48166b410cdc9f1c27a350
> > > > > # good: [0444e8f6d72d6e38f92d48884bc90bbc6c22fd5a] ACPICA: Fix:
> > > > > Predefined object repair executed only once git bisect good
> > > > > 0444e8f6d72d6e38f92d48884bc90bbc6c22fd5a
> > > > > # good: [d9adc2e031bd22d5d9607a53a8d3b30e0b675f39] ACPICA:
> > > > > reformat predefined method table, no functional change git
> > > > > bisect good
> > > > > d9adc2e031bd22d5d9607a53a8d3b30e0b675f39
> > > > > # bad: [8a964236800839263b3dddd7f7851d666e7d53e1] ACPICA:
> > acpi_reset:
> > > > > Bypass port validation mechanism git bisect bad
> > > > > 8a964236800839263b3dddd7f7851d666e7d53e1
> > > > > # bad: [7f0c826a437157d2b19662977e9cf3b472cf24a6] ACPICA: Add
> > > > > support for module-level executable AML code git bisect bad
> > > > > 7f0c826a437157d2b19662977e9cf3b472cf24a6
> > > > > # good: [999e08f99846a1fd6ee9642ec306a2d318925116] ACPICA: ACPI
> 4:
> > > > > Add
> > > > validation for new predefined names.
> > > > > git bisect good 999e08f99846a1fd6ee9642ec306a2d318925116
> > > >
> > > > and the result is
> > > >
> > > > > 7f0c826a437157d2b19662977e9cf3b472cf24a6 is the first bad commit
> > > > > commit 7f0c826a437157d2b19662977e9cf3b472cf24a6
> > > > > Author: Lin Ming <ming.m.lin(a)intel.com>
> > > > > Date:   Thu Aug 13 14:03:15 2009 +0800
> > > > >
> > > > >     ACPICA: Add support for module-level executable AML code
> > > > >
> > > > >     Add limited support for executable AML code that exists
> > outside
> > > > >     of any control method. This type of code has been illegal
> > since
> > > > >     ACPI 2.0.  The code must exist in an If/Else/While block.
> > > > > All
> > AML
> > > > >     tables are supported, including tables that are dynamically
> > loaded.
> > > > >     ACPICA BZ 762.
> > > > >
> > > > >     http://acpica.org/bugzilla/show_bug.cgi?id=3D762
> > > > >
> > > > >     Signed-off-by: Lin Ming <ming.m.lin(a)intel.com>
> > > > >     Signed-off-by: Bob Moore <robert.moore(a)intel.com>
> > > > >     Signed-off-by: Len Brown <len.brown(a)intel.com>
> > > > >
> > > > > :040000 040000 53420ff22ed1d5b42867eb0b7690bef936e59448
> > > > e73f6a01af9a9f3d4ae58c856ce77305997d697e M      drivers
> > > >
> > > > Now, if we re-investigate the AML code dumped from the guest, it
> > > > seems that the If(0) statement is placed directly in the root
> > > > scope
> > of the DSDT:
> > > >
> > > > >   crash> rd -8 ffffc20000008d80 100
> > > > >   ffffc20000008d80:  44 53 44 54 8b 11 00 00 01 b5 42 4f 43 48
> > > > > 53
> > > > > 20
> > > > DSDT......BOCHS
> > > > >   ffffc20000008d90:  42 58 50 43 44 53 44 54 01 00 00 00 42 58
> > > > > 50
> > > > > 43
> > > > BXPCDSDT....BXPC
> > > > >   ffffc20000008da0:  01 00 00 00 a0 43 05 00 15 50 30 53 5f 01
> > > > > 00
> > > > > 15
> > > > .....C...P0S_...
> > > >
> > > > Therefore the bisection result makes sense: the If(0) construct in
> > > > question exists outside of any control method.
> > > >
> > > > The problem is -- as long as we can believe the commit message of
> > > > 7f0c826a43 --, this is invalid AML, and has been invalid since
> > > > ACPI
> > 2.0.
> > > >
> > > > In other words, the "hiding" logic for the External() opcode
> > > > produces executable AML code (i.e., If(0)) outside of any control
> > > > method, which is
> > > > -- apparently -- invalid, and only works where it works because
> > > > commit
> > > > 7f0c826a4371 added a compat (?) fallback.
> > > >
> > > > ... The ACPICA bugzilla has been relocated to a different URL
> > > > since the above commit; the currently valid URL for the BZ
> > > > referenced in the commit message is:
> > > >
> > > > https://bugs.acpica.org/show_bug.cgi?id=3D762
> > > >
> > > > For reference, the DSDT ASL that defines the P0S method as
> > > > External
> > > > -- that is, the ASL that now breaks for RHEL-5.11 -- goes like
> this:
> > > >
> > > > Scope(\_SB.PCI0) {
> > > > ...
> > > >     Method(_CRS, 0) {
> > > >         /* Fields provided by dynamically created ssdt */
> > > >         External(P0S, IntObj)
> > > >
> > > > See
> > > > <http://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/i386/acpi-dsdt-p=
ci-
> > > > crs.dsl;h=3Db375a19cf604c3f8d02ee5edd799fdacab4f14f9;hb=3Dstable-
> > 1.7#l75>.
> > > >
> > > > I believe if iASL added the If(0) construct in the scope of the
> > > > _CRS method, rather than in the root scope of the DSDT, then
> > > > things should work even with kernels that don't have commit
> 7f0c826a43.
> > > >
> > > > Thanks
> > > > Laszlo
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============3598728293529090579==--

