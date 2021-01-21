Content-Type: multipart/mixed; boundary="===============9136718890398816150=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPICA: fix -Wfallthrough
Date: Thu, 21 Jan 2021 20:03:23 +0100
Message-ID: <CAJZ5v0it3KfdNo7kwq-7__C+Kvr4Eo7x8-3rBi09B5rHfNv-hQ@mail.gmail.com>
In-Reply-To: 031790d7-ee26-f919-9338-b135e9b94635@nvidia.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9136718890398816150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2021 at 11:08 AM Jon Hunter <jonathanh(a)nvidia.com> wrote:
>
>
> On 11/11/2020 02:11, Nick Desaulniers wrote:
> > The "fallthrough" pseudo-keyword was added as a portable way to denote
> > intentional fallthrough. This code seemed to be using a mix of
> > fallthrough comments that GCC recognizes, and some kind of lint marker.
> > I'm guessing that linter hasn't been run in a while from the mixed use
> > of the marker vs comments.
> >
> > Signed-off-by: Nick Desaulniers <ndesaulniers(a)google.com>
>
>
> I know this is not the exact version that was merged, I can't find it on
> the list, but looks like the version that was merged [0],

It would be this patch:

https://patchwork.kernel.org/project/linux-acpi/patch/20210115184826.2250-4=
-erik.kaneda(a)intel.com/

Nick, Erik?

> is causing build errors with older toolchains (GCC v6) ...
>
> /dvs/git/dirty/git-master_l4t-upstream/kernel/drivers/acpi/acpica/dscontr=
ol.c: In function =E2=80=98acpi_ds_exec_begin_control_op=E2=80=99:
> /dvs/git/dirty/git-master_l4t-upstream/kernel/drivers/acpi/acpica/dscontr=
ol.c:65:3: error: =E2=80=98ACPI_FALLTHROUGH=E2=80=99 undeclared (first use =
in this function)
>    ACPI_FALLTHROUGH;
>    ^~~~~~~~~~~~~~~~
> /dvs/git/dirty/git-master_l4t-upstream/kernel/drivers/acpi/acpica/dscontr=
ol.c:65:3: note: each undeclared identifier is reported only once for each =
function it appears in
> /dvs/git/dirty/git-master_l4t-upstream/kernel/scripts/Makefile.build:287:=
 recipe for target 'drivers/acpi/acpica/dscontrol.o' failed
>
> Cheers
> Jon
>
> [0] https://github.com/acpica/acpica/commit/4b9135f5
>
> --
> nvpublic
--===============9136718890398816150==--

