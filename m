Content-Type: multipart/mixed; boundary="===============2631730645121125411=="
MIME-Version: 1.0
From: Seunghun Han <kkamagui at gmail.com>
Subject: Re: [Devel] [PATCH] acpi: acpica: fix acpi parse and parseext cache
 leaks
Date: Thu, 15 Jun 2017 20:46:14 +0000
Message-ID: <CAHjaAcQpA7uB0dKXTMk-60Ju_jSG7EBJOFVD7U0BWCaBzQighQ@mail.gmail.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37E5C0D49@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2631730645121125411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello, Robert.

My research system are based on virtual machine and Intel NUC machine,
and they are still working despite of ACPI subsystem shutdown.
So, I can find the acpi memory leaks by using "dmesg" command.

Best regards.

2017=EB=85=84 6=EC=9B=94 16=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 4:53, M=
oore, Robert <robert.moore(a)intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:

> This might be a dumb question, but isn't the system basically hosed once
> the ACPI subsystem is shutdown?
>
>
> > -----Original Message-----
> > From: Seunghun Han [mailto:kkamagui(a)gmail.com]
> > Sent: Wednesday, June 14, 2017 4:08 AM
> > To: Zheng, Lv <lv.zheng(a)intel.com>; Moore, Robert
> > <robert.moore(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel=
.com>
> > Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-
> > kernel(a)vger.kernel.org; Seunghun Han <kkamagui(a)gmail.com>
> > Subject: [PATCH] acpi: acpica: fix acpi parse and parseext cache leaks
> >
> > I'm Seunghun Han, and I work for National Security Research Institute of
> > South Korea.
> >
> > I have been doing a research on ACPI and found an ACPI cache leak in
> > ACPI early abort cases.
> >
> > Boot log of ACPI cache leak is as follows:
> > [    0.352414] ACPI: Added _OSI(Module Device)
> > [    0.353182] ACPI: Added _OSI(Processor Device)
> > [    0.353182] ACPI: Added _OSI(3.0 _SCP Extensions)
> > [    0.353182] ACPI: Added _OSI(Processor Aggregator Device)
> > [    0.356028] ACPI: Unable to start the ACPI Interpreter
> > [    0.356799] ACPI Error: Could not remove SCI handler
> > (20170303/evmisc-281)
> > [    0.360215] kmem_cache_destroy Acpi-State: Slab cache still has
> > objects
> > [    0.360648] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
> > 4.12.0-rc4-next-20170608+ #10
> > [    0.361273] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
> > VirtualBox 12/01/2006
> > [    0.361873] Call Trace:
> > [    0.362243]  ? dump_stack+0x5c/0x81
> > [    0.362591]  ? kmem_cache_destroy+0x1aa/0x1c0
> > [    0.362944]  ? acpi_sleep_proc_init+0x27/0x27
> > [    0.363296]  ? acpi_os_delete_cache+0xa/0x10
> > [    0.363646]  ? acpi_ut_delete_caches+0x6d/0x7b
> > [    0.364000]  ? acpi_terminate+0xa/0x14
> > [    0.364000]  ? acpi_init+0x2af/0x34f
> > [    0.364000]  ? __class_create+0x4c/0x80
> > [    0.364000]  ? video_setup+0x7f/0x7f
> > [    0.364000]  ? acpi_sleep_proc_init+0x27/0x27
> > [    0.364000]  ? do_one_initcall+0x4e/0x1a0
> > [    0.364000]  ? kernel_init_freeable+0x189/0x20a
> > [    0.364000]  ? rest_init+0xc0/0xc0
> > [    0.364000]  ? kernel_init+0xa/0x100
> > [    0.364000]  ? ret_from_fork+0x25/0x30
> >
> > I analyzed this memory leak detailed. I found that =E2=80=9CAcpi-State=
=E2=80=9D cache
> > and =E2=80=9CAcpi-Parse=E2=80=9D cache were merged because the size of =
cache objects was
> > same slab cache size.
> >
> > I finally found =E2=80=9CAcpi-Parse=E2=80=9D cache and =E2=80=9CAcpi-Pa=
rseExt=E2=80=9D cache were leaked
> > using SLAB_NEVER_MERGE flag in kmem_cache_create() function.
> >
> > Real ACPI cache leak point is as follows:
> > [    0.360101] ACPI: Added _OSI(Module Device)
> > [    0.360101] ACPI: Added _OSI(Processor Device)
> > [    0.360101] ACPI: Added _OSI(3.0 _SCP Extensions)
> > [    0.361043] ACPI: Added _OSI(Processor Aggregator Device)
> > [    0.364016] ACPI: Unable to start the ACPI Interpreter
> > [    0.365061] ACPI Error: Could not remove SCI handler
> > (20170303/evmisc-281)
> > [    0.368174] kmem_cache_destroy Acpi-Parse: Slab cache still has
> > objects
> > [    0.369332] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W
> > 4.12.0-rc4-next-20170608+ #8
> > [    0.371256] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
> > VirtualBox 12/01/2006
> > [    0.372000] Call Trace:
> > [    0.372000]  ? dump_stack+0x5c/0x81
> > [    0.372000]  ? kmem_cache_destroy+0x1aa/0x1c0
> > [    0.372000]  ? acpi_sleep_proc_init+0x27/0x27
> > [    0.372000]  ? acpi_os_delete_cache+0xa/0x10
> > [    0.372000]  ? acpi_ut_delete_caches+0x56/0x7b
> > [    0.372000]  ? acpi_terminate+0xa/0x14
> > [    0.372000]  ? acpi_init+0x2af/0x34f
> > [    0.372000]  ? __class_create+0x4c/0x80
> > [    0.372000]  ? video_setup+0x7f/0x7f
> > [    0.372000]  ? acpi_sleep_proc_init+0x27/0x27
> > [    0.372000]  ? do_one_initcall+0x4e/0x1a0
> > [    0.372000]  ? kernel_init_freeable+0x189/0x20a
> > [    0.372000]  ? rest_init+0xc0/0xc0
> > [    0.372000]  ? kernel_init+0xa/0x100
> > [    0.372000]  ? ret_from_fork+0x25/0x30
> > [    0.388039] kmem_cache_destroy Acpi-ParseExt: Slab cache still has
> > objects
> > [    0.389063] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W
> > 4.12.0-rc4-next-20170608+ #8
> > [    0.390557] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
> > VirtualBox 12/01/2006
> > [    0.392000] Call Trace:
> > [    0.392000]  ? dump_stack+0x5c/0x81
> > [    0.392000]  ? kmem_cache_destroy+0x1aa/0x1c0
> > [    0.392000]  ? acpi_sleep_proc_init+0x27/0x27
> > [    0.392000]  ? acpi_os_delete_cache+0xa/0x10
> > [    0.392000]  ? acpi_ut_delete_caches+0x6d/0x7b
> > [    0.392000]  ? acpi_terminate+0xa/0x14
> > [    0.392000]  ? acpi_init+0x2af/0x34f
> > [    0.392000]  ? __class_create+0x4c/0x80
> > [    0.392000]  ? video_setup+0x7f/0x7f
> > [    0.392000]  ? acpi_sleep_proc_init+0x27/0x27
> > [    0.392000]  ? do_one_initcall+0x4e/0x1a0
> > [    0.392000]  ? kernel_init_freeable+0x189/0x20a
> > [    0.392000]  ? rest_init+0xc0/0xc0
> > [    0.392000]  ? kernel_init+0xa/0x100
> > [    0.392000]  ? ret_from_fork+0x25/0x30
> >
> > When early abort is occurred due to invalid ACPI information, Linux
> > kernel terminates ACPI by calling acpi_terminate() function. The
> > function calls
> > acpi_ut_delete_caches() function to delete local caches
> > (acpi_gbl_namespace_ cache, state_cache, operand_cache, ps_node_cache,
> > ps_node_ext_cache).
> >
> > But the deletion codes in acpi_ut_delete_caches() function only delete
> > slab caches using kmem_cache_destroy() function, therefore the cache
> > objects should be flushed before acpi_ut_delete_caches() function.
> >
> > =E2=80=9CAcpi-Parse=E2=80=9D cache and =E2=80=9CAcpi-ParseExt=E2=80=9D =
cache are used in an AML parse
> > function, acpi_ps_parse_loop(). The function should have flush codes to
> > handle an error state due to invalid AML codes.
> >
> > This cache leak has a security threat because an old kernel (<=3D 4.9)
> > shows memory locations of kernel functions in stack dump. Some malicious
> > users could use this information to neutralize kernel ASLR.
> >
> > To fix ACPI cache leak for enhancing security, I made a patch which has
> > flush codes in acpi_ps_parse_loop() function.
> >
> > I hope that this patch improves the security of Linux kernel.
> >
> > Thank you.
> >
> > Signed-off-by: Seunghun Han <kkamagui(a)gmail.com>
> > ---
> >  drivers/acpi/acpica/psloop.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
> > index b422400..5d06383 100644
> > --- a/drivers/acpi/acpica/psloop.c
> > +++ b/drivers/acpi/acpica/psloop.c
> > @@ -658,5 +658,18 @@ acpi_status acpi_ps_parse_loop(struct
> > acpi_walk_state *walk_state)
> >       }                       /* while parser_state->Aml */
> >
> >       status =3D acpi_ps_complete_final_op(walk_state, op, status);
> > +     if (ACPI_FAILURE(status)) {
> > +             /* Flush pushed op objects */
> > +
> > +             do {
> > +                     acpi_ps_pop_scope(&(walk_state->parser_state), &o=
p,
> > +                                       &walk_state->arg_types,
> > +                                       &walk_state->arg_count);
> > +                     if (op) {
> > +                             acpi_ps_complete_this_op(walk_state, op);
> > +                     }
> > +             } while (op);
> > +     }
> > +
> >       return_ACPI_STATUS(status);
> >  }
> > --
> > 2.1.4
>
>

--===============2631730645121125411==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdj5IZWxsbywgUm9iZXJ0LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+TXkgcmVzZWFyY2gg
c3lzdGVtIGFyZSBiYXNlZCBvbiB2aXJ0dWFsIG1hY2hpbmUgYW5kIEludGVsIE5VQyBtYWNoaW5l
LMKgPC9kaXY+PGRpdj5hbmQgdGhleSBhcmUgc3RpbGwgd29ya2luZyBkZXNwaXRlIG9mIEFDUEkg
c3Vic3lzdGVtIHNodXRkb3duLjwvZGl2PjxkaXY+U28sIEkgY2FuIGZpbmQgdGhlIGFjcGkgbWVt
b3J5IGxlYWtzIGJ5IHVzaW5nICZxdW90O2RtZXNnJnF1b3Q7IGNvbW1hbmQuPGJyPjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+QmVzdCByZWdhcmRzLjwvZGl2PjxkaXY+PGJyPjxkaXYgY2xhc3M9
ImdtYWlsX3F1b3RlIj48ZGl2PjIwMTfrhYQgNuyblCAxNuydvCAo6riIKSDsmKTsoIQgNDo1Mywg
TW9vcmUsIFJvYmVydCAmbHQ7PGEgaHJlZj0ibWFpbHRvOnJvYmVydC5tb29yZUBpbnRlbC5jb20i
PnJvYmVydC5tb29yZUBpbnRlbC5jb208L2E+Jmd0O+uLmOydtCDsnpHshLE6PGJyPjwvZGl2Pjxi
bG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2Jv
cmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPlRoaXMgbWlnaHQgYmUg
YSBkdW1iIHF1ZXN0aW9uLCBidXQgaXNuJiMzOTt0IHRoZSBzeXN0ZW0gYmFzaWNhbGx5IGhvc2Vk
IG9uY2UgdGhlIEFDUEkgc3Vic3lzdGVtIGlzIHNodXRkb3duPzxicj4KPGJyPgo8YnI+CiZndDsg
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS08YnI+CiZndDsgRnJvbTogU2V1bmdodW4gSGFuIFtt
YWlsdG86PGEgaHJlZj0ibWFpbHRvOmtrYW1hZ3VpQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsi
PmtrYW1hZ3VpQGdtYWlsLmNvbTwvYT5dPGJyPgomZ3Q7IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAx
NCwgMjAxNyA0OjA4IEFNPGJyPgomZ3Q7IFRvOiBaaGVuZywgTHYgJmx0OzxhIGhyZWY9Im1haWx0
bzpsdi56aGVuZ0BpbnRlbC5jb20iIHRhcmdldD0iX2JsYW5rIj5sdi56aGVuZ0BpbnRlbC5jb208
L2E+Jmd0OzsgTW9vcmUsIFJvYmVydDxicj4KJmd0OyAmbHQ7PGEgaHJlZj0ibWFpbHRvOnJvYmVy
dC5tb29yZUBpbnRlbC5jb20iIHRhcmdldD0iX2JsYW5rIj5yb2JlcnQubW9vcmVAaW50ZWwuY29t
PC9hPiZndDs7IFd5c29ja2ksIFJhZmFlbCBKICZsdDs8YSBocmVmPSJtYWlsdG86cmFmYWVsLmou
d3lzb2NraUBpbnRlbC5jb20iIHRhcmdldD0iX2JsYW5rIj5yYWZhZWwuai53eXNvY2tpQGludGVs
LmNvbTwvYT4mZ3Q7PGJyPgomZ3Q7IENjOiA8YSBocmVmPSJtYWlsdG86bGludXgtYWNwaUB2Z2Vy
Lmtlcm5lbC5vcmciIHRhcmdldD0iX2JsYW5rIj5saW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzwv
YT47IDxhIGhyZWY9Im1haWx0bzpkZXZlbEBhY3BpY2Eub3JnIiB0YXJnZXQ9Il9ibGFuayI+ZGV2
ZWxAYWNwaWNhLm9yZzwvYT47IGxpbnV4LTxicj4KJmd0OyA8YSBocmVmPSJtYWlsdG86a2VybmVs
QHZnZXIua2VybmVsLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc8
L2E+OyBTZXVuZ2h1biBIYW4gJmx0OzxhIGhyZWY9Im1haWx0bzpra2FtYWd1aUBnbWFpbC5jb20i
IHRhcmdldD0iX2JsYW5rIj5ra2FtYWd1aUBnbWFpbC5jb208L2E+Jmd0Ozxicj4KJmd0OyBTdWJq
ZWN0OiBbUEFUQ0hdIGFjcGk6IGFjcGljYTogZml4IGFjcGkgcGFyc2UgYW5kIHBhcnNlZXh0IGNh
Y2hlIGxlYWtzPGJyPgomZ3Q7PGJyPgomZ3Q7IEkmIzM5O20gU2V1bmdodW4gSGFuLCBhbmQgSSB3
b3JrIGZvciBOYXRpb25hbCBTZWN1cml0eSBSZXNlYXJjaCBJbnN0aXR1dGUgb2Y8YnI+CiZndDsg
U291dGggS29yZWEuPGJyPgomZ3Q7PGJyPgomZ3Q7IEkgaGF2ZSBiZWVuIGRvaW5nIGEgcmVzZWFy
Y2ggb24gQUNQSSBhbmQgZm91bmQgYW4gQUNQSSBjYWNoZSBsZWFrIGluPGJyPgomZ3Q7IEFDUEkg
ZWFybHkgYWJvcnQgY2FzZXMuPGJyPgomZ3Q7PGJyPgomZ3Q7IEJvb3QgbG9nIG9mIEFDUEkgY2Fj
aGUgbGVhayBpcyBhcyBmb2xsb3dzOjxicj4KJmd0OyBbwqAgwqAgMC4zNTI0MTRdIEFDUEk6IEFk
ZGVkIF9PU0koTW9kdWxlIERldmljZSk8YnI+CiZndDsgW8KgIMKgIDAuMzUzMTgyXSBBQ1BJOiBB
ZGRlZCBfT1NJKFByb2Nlc3NvciBEZXZpY2UpPGJyPgomZ3Q7IFvCoCDCoCAwLjM1MzE4Ml0gQUNQ
STogQWRkZWQgX09TSSgzLjAgX1NDUCBFeHRlbnNpb25zKTxicj4KJmd0OyBbwqAgwqAgMC4zNTMx
ODJdIEFDUEk6IEFkZGVkIF9PU0koUHJvY2Vzc29yIEFnZ3JlZ2F0b3IgRGV2aWNlKTxicj4KJmd0
OyBbwqAgwqAgMC4zNTYwMjhdIEFDUEk6IFVuYWJsZSB0byBzdGFydCB0aGUgQUNQSSBJbnRlcnBy
ZXRlcjxicj4KJmd0OyBbwqAgwqAgMC4zNTY3OTldIEFDUEkgRXJyb3I6IENvdWxkIG5vdCByZW1v
dmUgU0NJIGhhbmRsZXI8YnI+CiZndDsgKDIwMTcwMzAzL2V2bWlzYy0yODEpPGJyPgomZ3Q7IFvC
oCDCoCAwLjM2MDIxNV0ga21lbV9jYWNoZV9kZXN0cm95IEFjcGktU3RhdGU6IFNsYWIgY2FjaGUg
c3RpbGwgaGFzPGJyPgomZ3Q7IG9iamVjdHM8YnI+CiZndDsgW8KgIMKgIDAuMzYwNjQ4XSBDUFU6
IDAgUElEOiAxIENvbW06IHN3YXBwZXIvMCBUYWludGVkOiBHwqAgwqAgwqAgwqAgVzxicj4KJmd0
OyA0LjEyLjAtcmM0LW5leHQtMjAxNzA2MDgrICMxMDxicj4KJmd0OyBbwqAgwqAgMC4zNjEyNzNd
IEhhcmR3YXJlIG5hbWU6IGlubm90ZWsgR21iSCBWaXJ0dWFsQm94L1ZpcnR1YWxCb3gsIEJJT1M8
YnI+CiZndDsgVmlydHVhbEJveCAxMi8wMS8yMDA2PGJyPgomZ3Q7IFvCoCDCoCAwLjM2MTg3M10g
Q2FsbCBUcmFjZTo8YnI+CiZndDsgW8KgIMKgIDAuMzYyMjQzXcKgID8gZHVtcF9zdGFjaysweDVj
LzB4ODE8YnI+CiZndDsgW8KgIMKgIDAuMzYyNTkxXcKgID8ga21lbV9jYWNoZV9kZXN0cm95KzB4
MWFhLzB4MWMwPGJyPgomZ3Q7IFvCoCDCoCAwLjM2Mjk0NF3CoCA/IGFjcGlfc2xlZXBfcHJvY19p
bml0KzB4MjcvMHgyNzxicj4KJmd0OyBbwqAgwqAgMC4zNjMyOTZdwqAgPyBhY3BpX29zX2RlbGV0
ZV9jYWNoZSsweGEvMHgxMDxicj4KJmd0OyBbwqAgwqAgMC4zNjM2NDZdwqAgPyBhY3BpX3V0X2Rl
bGV0ZV9jYWNoZXMrMHg2ZC8weDdiPGJyPgomZ3Q7IFvCoCDCoCAwLjM2NDAwMF3CoCA/IGFjcGlf
dGVybWluYXRlKzB4YS8weDE0PGJyPgomZ3Q7IFvCoCDCoCAwLjM2NDAwMF3CoCA/IGFjcGlfaW5p
dCsweDJhZi8weDM0Zjxicj4KJmd0OyBbwqAgwqAgMC4zNjQwMDBdwqAgPyBfX2NsYXNzX2NyZWF0
ZSsweDRjLzB4ODA8YnI+CiZndDsgW8KgIMKgIDAuMzY0MDAwXcKgID8gdmlkZW9fc2V0dXArMHg3
Zi8weDdmPGJyPgomZ3Q7IFvCoCDCoCAwLjM2NDAwMF3CoCA/IGFjcGlfc2xlZXBfcHJvY19pbml0
KzB4MjcvMHgyNzxicj4KJmd0OyBbwqAgwqAgMC4zNjQwMDBdwqAgPyBkb19vbmVfaW5pdGNhbGwr
MHg0ZS8weDFhMDxicj4KJmd0OyBbwqAgwqAgMC4zNjQwMDBdwqAgPyBrZXJuZWxfaW5pdF9mcmVl
YWJsZSsweDE4OS8weDIwYTxicj4KJmd0OyBbwqAgwqAgMC4zNjQwMDBdwqAgPyByZXN0X2luaXQr
MHhjMC8weGMwPGJyPgomZ3Q7IFvCoCDCoCAwLjM2NDAwMF3CoCA/IGtlcm5lbF9pbml0KzB4YS8w
eDEwMDxicj4KJmd0OyBbwqAgwqAgMC4zNjQwMDBdwqAgPyByZXRfZnJvbV9mb3JrKzB4MjUvMHgz
MDxicj4KJmd0Ozxicj4KJmd0OyBJIGFuYWx5emVkIHRoaXMgbWVtb3J5IGxlYWsgZGV0YWlsZWQu
IEkgZm91bmQgdGhhdCDigJxBY3BpLVN0YXRl4oCdIGNhY2hlPGJyPgomZ3Q7IGFuZCDigJxBY3Bp
LVBhcnNl4oCdIGNhY2hlIHdlcmUgbWVyZ2VkIGJlY2F1c2UgdGhlIHNpemUgb2YgY2FjaGUgb2Jq
ZWN0cyB3YXM8YnI+CiZndDsgc2FtZSBzbGFiIGNhY2hlIHNpemUuPGJyPgomZ3Q7PGJyPgomZ3Q7
IEkgZmluYWxseSBmb3VuZCDigJxBY3BpLVBhcnNl4oCdIGNhY2hlIGFuZCDigJxBY3BpLVBhcnNl
RXh04oCdIGNhY2hlIHdlcmUgbGVha2VkPGJyPgomZ3Q7IHVzaW5nIFNMQUJfTkVWRVJfTUVSR0Ug
ZmxhZyBpbiBrbWVtX2NhY2hlX2NyZWF0ZSgpIGZ1bmN0aW9uLjxicj4KJmd0Ozxicj4KJmd0OyBS
ZWFsIEFDUEkgY2FjaGUgbGVhayBwb2ludCBpcyBhcyBmb2xsb3dzOjxicj4KJmd0OyBbwqAgwqAg
MC4zNjAxMDFdIEFDUEk6IEFkZGVkIF9PU0koTW9kdWxlIERldmljZSk8YnI+CiZndDsgW8KgIMKg
IDAuMzYwMTAxXSBBQ1BJOiBBZGRlZCBfT1NJKFByb2Nlc3NvciBEZXZpY2UpPGJyPgomZ3Q7IFvC
oCDCoCAwLjM2MDEwMV0gQUNQSTogQWRkZWQgX09TSSgzLjAgX1NDUCBFeHRlbnNpb25zKTxicj4K
Jmd0OyBbwqAgwqAgMC4zNjEwNDNdIEFDUEk6IEFkZGVkIF9PU0koUHJvY2Vzc29yIEFnZ3JlZ2F0
b3IgRGV2aWNlKTxicj4KJmd0OyBbwqAgwqAgMC4zNjQwMTZdIEFDUEk6IFVuYWJsZSB0byBzdGFy
dCB0aGUgQUNQSSBJbnRlcnByZXRlcjxicj4KJmd0OyBbwqAgwqAgMC4zNjUwNjFdIEFDUEkgRXJy
b3I6IENvdWxkIG5vdCByZW1vdmUgU0NJIGhhbmRsZXI8YnI+CiZndDsgKDIwMTcwMzAzL2V2bWlz
Yy0yODEpPGJyPgomZ3Q7IFvCoCDCoCAwLjM2ODE3NF0ga21lbV9jYWNoZV9kZXN0cm95IEFjcGkt
UGFyc2U6IFNsYWIgY2FjaGUgc3RpbGwgaGFzPGJyPgomZ3Q7IG9iamVjdHM8YnI+CiZndDsgW8Kg
IMKgIDAuMzY5MzMyXSBDUFU6IDEgUElEOiAxIENvbW06IHN3YXBwZXIvMCBUYWludGVkOiBHwqAg
wqAgwqAgwqAgVzxicj4KJmd0OyA0LjEyLjAtcmM0LW5leHQtMjAxNzA2MDgrICM4PGJyPgomZ3Q7
IFvCoCDCoCAwLjM3MTI1Nl0gSGFyZHdhcmUgbmFtZTogaW5ub3RlayBHbWJIIFZpcnR1YWxCb3gv
VmlydHVhbEJveCwgQklPUzxicj4KJmd0OyBWaXJ0dWFsQm94IDEyLzAxLzIwMDY8YnI+CiZndDsg
W8KgIMKgIDAuMzcyMDAwXSBDYWxsIFRyYWNlOjxicj4KJmd0OyBbwqAgwqAgMC4zNzIwMDBdwqAg
PyBkdW1wX3N0YWNrKzB4NWMvMHg4MTxicj4KJmd0OyBbwqAgwqAgMC4zNzIwMDBdwqAgPyBrbWVt
X2NhY2hlX2Rlc3Ryb3krMHgxYWEvMHgxYzA8YnI+CiZndDsgW8KgIMKgIDAuMzcyMDAwXcKgID8g
YWNwaV9zbGVlcF9wcm9jX2luaXQrMHgyNy8weDI3PGJyPgomZ3Q7IFvCoCDCoCAwLjM3MjAwMF3C
oCA/IGFjcGlfb3NfZGVsZXRlX2NhY2hlKzB4YS8weDEwPGJyPgomZ3Q7IFvCoCDCoCAwLjM3MjAw
MF3CoCA/IGFjcGlfdXRfZGVsZXRlX2NhY2hlcysweDU2LzB4N2I8YnI+CiZndDsgW8KgIMKgIDAu
MzcyMDAwXcKgID8gYWNwaV90ZXJtaW5hdGUrMHhhLzB4MTQ8YnI+CiZndDsgW8KgIMKgIDAuMzcy
MDAwXcKgID8gYWNwaV9pbml0KzB4MmFmLzB4MzRmPGJyPgomZ3Q7IFvCoCDCoCAwLjM3MjAwMF3C
oCA/IF9fY2xhc3NfY3JlYXRlKzB4NGMvMHg4MDxicj4KJmd0OyBbwqAgwqAgMC4zNzIwMDBdwqAg
PyB2aWRlb19zZXR1cCsweDdmLzB4N2Y8YnI+CiZndDsgW8KgIMKgIDAuMzcyMDAwXcKgID8gYWNw
aV9zbGVlcF9wcm9jX2luaXQrMHgyNy8weDI3PGJyPgomZ3Q7IFvCoCDCoCAwLjM3MjAwMF3CoCA/
IGRvX29uZV9pbml0Y2FsbCsweDRlLzB4MWEwPGJyPgomZ3Q7IFvCoCDCoCAwLjM3MjAwMF3CoCA/
IGtlcm5lbF9pbml0X2ZyZWVhYmxlKzB4MTg5LzB4MjBhPGJyPgomZ3Q7IFvCoCDCoCAwLjM3MjAw
MF3CoCA/IHJlc3RfaW5pdCsweGMwLzB4YzA8YnI+CiZndDsgW8KgIMKgIDAuMzcyMDAwXcKgID8g
a2VybmVsX2luaXQrMHhhLzB4MTAwPGJyPgomZ3Q7IFvCoCDCoCAwLjM3MjAwMF3CoCA/IHJldF9m
cm9tX2ZvcmsrMHgyNS8weDMwPGJyPgomZ3Q7IFvCoCDCoCAwLjM4ODAzOV0ga21lbV9jYWNoZV9k
ZXN0cm95IEFjcGktUGFyc2VFeHQ6IFNsYWIgY2FjaGUgc3RpbGwgaGFzPGJyPgomZ3Q7IG9iamVj
dHM8YnI+CiZndDsgW8KgIMKgIDAuMzg5MDYzXSBDUFU6IDEgUElEOiAxIENvbW06IHN3YXBwZXIv
MCBUYWludGVkOiBHwqAgwqAgwqAgwqAgVzxicj4KJmd0OyA0LjEyLjAtcmM0LW5leHQtMjAxNzA2
MDgrICM4PGJyPgomZ3Q7IFvCoCDCoCAwLjM5MDU1N10gSGFyZHdhcmUgbmFtZTogaW5ub3RlayBH
bWJIIFZpcnR1YWxCb3gvVmlydHVhbEJveCwgQklPUzxicj4KJmd0OyBWaXJ0dWFsQm94IDEyLzAx
LzIwMDY8YnI+CiZndDsgW8KgIMKgIDAuMzkyMDAwXSBDYWxsIFRyYWNlOjxicj4KJmd0OyBbwqAg
wqAgMC4zOTIwMDBdwqAgPyBkdW1wX3N0YWNrKzB4NWMvMHg4MTxicj4KJmd0OyBbwqAgwqAgMC4z
OTIwMDBdwqAgPyBrbWVtX2NhY2hlX2Rlc3Ryb3krMHgxYWEvMHgxYzA8YnI+CiZndDsgW8KgIMKg
IDAuMzkyMDAwXcKgID8gYWNwaV9zbGVlcF9wcm9jX2luaXQrMHgyNy8weDI3PGJyPgomZ3Q7IFvC
oCDCoCAwLjM5MjAwMF3CoCA/IGFjcGlfb3NfZGVsZXRlX2NhY2hlKzB4YS8weDEwPGJyPgomZ3Q7
IFvCoCDCoCAwLjM5MjAwMF3CoCA/IGFjcGlfdXRfZGVsZXRlX2NhY2hlcysweDZkLzB4N2I8YnI+
CiZndDsgW8KgIMKgIDAuMzkyMDAwXcKgID8gYWNwaV90ZXJtaW5hdGUrMHhhLzB4MTQ8YnI+CiZn
dDsgW8KgIMKgIDAuMzkyMDAwXcKgID8gYWNwaV9pbml0KzB4MmFmLzB4MzRmPGJyPgomZ3Q7IFvC
oCDCoCAwLjM5MjAwMF3CoCA/IF9fY2xhc3NfY3JlYXRlKzB4NGMvMHg4MDxicj4KJmd0OyBbwqAg
wqAgMC4zOTIwMDBdwqAgPyB2aWRlb19zZXR1cCsweDdmLzB4N2Y8YnI+CiZndDsgW8KgIMKgIDAu
MzkyMDAwXcKgID8gYWNwaV9zbGVlcF9wcm9jX2luaXQrMHgyNy8weDI3PGJyPgomZ3Q7IFvCoCDC
oCAwLjM5MjAwMF3CoCA/IGRvX29uZV9pbml0Y2FsbCsweDRlLzB4MWEwPGJyPgomZ3Q7IFvCoCDC
oCAwLjM5MjAwMF3CoCA/IGtlcm5lbF9pbml0X2ZyZWVhYmxlKzB4MTg5LzB4MjBhPGJyPgomZ3Q7
IFvCoCDCoCAwLjM5MjAwMF3CoCA/IHJlc3RfaW5pdCsweGMwLzB4YzA8YnI+CiZndDsgW8KgIMKg
IDAuMzkyMDAwXcKgID8ga2VybmVsX2luaXQrMHhhLzB4MTAwPGJyPgomZ3Q7IFvCoCDCoCAwLjM5
MjAwMF3CoCA/IHJldF9mcm9tX2ZvcmsrMHgyNS8weDMwPGJyPgomZ3Q7PGJyPgomZ3Q7IFdoZW4g
ZWFybHkgYWJvcnQgaXMgb2NjdXJyZWQgZHVlIHRvIGludmFsaWQgQUNQSSBpbmZvcm1hdGlvbiwg
TGludXg8YnI+CiZndDsga2VybmVsIHRlcm1pbmF0ZXMgQUNQSSBieSBjYWxsaW5nIGFjcGlfdGVy
bWluYXRlKCkgZnVuY3Rpb24uIFRoZTxicj4KJmd0OyBmdW5jdGlvbiBjYWxsczxicj4KJmd0OyBh
Y3BpX3V0X2RlbGV0ZV9jYWNoZXMoKSBmdW5jdGlvbiB0byBkZWxldGUgbG9jYWwgY2FjaGVzPGJy
PgomZ3Q7IChhY3BpX2dibF9uYW1lc3BhY2VfIGNhY2hlLCBzdGF0ZV9jYWNoZSwgb3BlcmFuZF9j
YWNoZSwgcHNfbm9kZV9jYWNoZSw8YnI+CiZndDsgcHNfbm9kZV9leHRfY2FjaGUpLjxicj4KJmd0
Ozxicj4KJmd0OyBCdXQgdGhlIGRlbGV0aW9uIGNvZGVzIGluIGFjcGlfdXRfZGVsZXRlX2NhY2hl
cygpIGZ1bmN0aW9uIG9ubHkgZGVsZXRlPGJyPgomZ3Q7IHNsYWIgY2FjaGVzIHVzaW5nIGttZW1f
Y2FjaGVfZGVzdHJveSgpIGZ1bmN0aW9uLCB0aGVyZWZvcmUgdGhlIGNhY2hlPGJyPgomZ3Q7IG9i
amVjdHMgc2hvdWxkIGJlIGZsdXNoZWQgYmVmb3JlIGFjcGlfdXRfZGVsZXRlX2NhY2hlcygpIGZ1
bmN0aW9uLjxicj4KJmd0Ozxicj4KJmd0OyDigJxBY3BpLVBhcnNl4oCdIGNhY2hlIGFuZCDigJxB
Y3BpLVBhcnNlRXh04oCdIGNhY2hlIGFyZSB1c2VkIGluIGFuIEFNTCBwYXJzZTxicj4KJmd0OyBm
dW5jdGlvbiwgYWNwaV9wc19wYXJzZV9sb29wKCkuIFRoZSBmdW5jdGlvbiBzaG91bGQgaGF2ZSBm
bHVzaCBjb2RlcyB0bzxicj4KJmd0OyBoYW5kbGUgYW4gZXJyb3Igc3RhdGUgZHVlIHRvIGludmFs
aWQgQU1MIGNvZGVzLjxicj4KJmd0Ozxicj4KJmd0OyBUaGlzIGNhY2hlIGxlYWsgaGFzIGEgc2Vj
dXJpdHkgdGhyZWF0IGJlY2F1c2UgYW4gb2xkIGtlcm5lbCAoJmx0Oz0gNC45KTxicj4KJmd0OyBz
aG93cyBtZW1vcnkgbG9jYXRpb25zIG9mIGtlcm5lbCBmdW5jdGlvbnMgaW4gc3RhY2sgZHVtcC4g
U29tZSBtYWxpY2lvdXM8YnI+CiZndDsgdXNlcnMgY291bGQgdXNlIHRoaXMgaW5mb3JtYXRpb24g
dG8gbmV1dHJhbGl6ZSBrZXJuZWwgQVNMUi48YnI+CiZndDs8YnI+CiZndDsgVG8gZml4IEFDUEkg
Y2FjaGUgbGVhayBmb3IgZW5oYW5jaW5nIHNlY3VyaXR5LCBJIG1hZGUgYSBwYXRjaCB3aGljaCBo
YXM8YnI+CiZndDsgZmx1c2ggY29kZXMgaW4gYWNwaV9wc19wYXJzZV9sb29wKCkgZnVuY3Rpb24u
PGJyPgomZ3Q7PGJyPgomZ3Q7IEkgaG9wZSB0aGF0IHRoaXMgcGF0Y2ggaW1wcm92ZXMgdGhlIHNl
Y3VyaXR5IG9mIExpbnV4IGtlcm5lbC48YnI+CiZndDs8YnI+CiZndDsgVGhhbmsgeW91Ljxicj4K
Jmd0Ozxicj4KJmd0OyBTaWduZWQtb2ZmLWJ5OiBTZXVuZ2h1biBIYW4gJmx0OzxhIGhyZWY9Im1h
aWx0bzpra2FtYWd1aUBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5ra2FtYWd1aUBnbWFpbC5j
b208L2E+Jmd0Ozxicj4KJmd0OyAtLS08YnI+CiZndDvCoCBkcml2ZXJzL2FjcGkvYWNwaWNhL3Bz
bG9vcC5jIHwgMTMgKysrKysrKysrKysrKzxicj4KJmd0O8KgIDEgZmlsZSBjaGFuZ2VkLCAxMyBp
bnNlcnRpb25zKCspPGJyPgomZ3Q7PGJyPgomZ3Q7IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkv
YWNwaWNhL3BzbG9vcC5jIGIvZHJpdmVycy9hY3BpL2FjcGljYS9wc2xvb3AuYzxicj4KJmd0OyBp
bmRleCBiNDIyNDAwLi41ZDA2MzgzIDEwMDY0NDxicj4KJmd0OyAtLS0gYS9kcml2ZXJzL2FjcGkv
YWNwaWNhL3BzbG9vcC5jPGJyPgomZ3Q7ICsrKyBiL2RyaXZlcnMvYWNwaS9hY3BpY2EvcHNsb29w
LmM8YnI+CiZndDsgQEAgLTY1OCw1ICs2NTgsMTggQEAgYWNwaV9zdGF0dXMgYWNwaV9wc19wYXJz
ZV9sb29wKHN0cnVjdDxicj4KJmd0OyBhY3BpX3dhbGtfc3RhdGUgKndhbGtfc3RhdGUpPGJyPgom
Z3Q7wqAgwqAgwqAgwqB9wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiB3aGls
ZSBwYXJzZXJfc3RhdGUtJmd0O0FtbCAqLzxicj4KJmd0Ozxicj4KJmd0O8KgIMKgIMKgIMKgc3Rh
dHVzID0gYWNwaV9wc19jb21wbGV0ZV9maW5hbF9vcCh3YWxrX3N0YXRlLCBvcCwgc3RhdHVzKTs8
YnI+CiZndDsgK8KgIMKgIMKgaWYgKEFDUElfRkFJTFVSRShzdGF0dXMpKSB7PGJyPgomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoC8qIEZsdXNoIHB1c2hlZCBvcCBvYmplY3RzICovPGJyPgomZ3Q7
ICs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgZG8gezxicj4KJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhY3BpX3BzX3BvcF9zY29wZSgmYW1wOyh3YWxrX3N0YXRl
LSZndDtwYXJzZXJfc3RhdGUpLCAmYW1wO29wLDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1wO3dhbGtfc3RhdGUt
Jmd0O2FyZ190eXBlcyw8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDt3YWxrX3N0YXRlLSZndDthcmdfY291bnQp
Ozxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAob3ApIHs8YnI+
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYWNwaV9w
c19jb21wbGV0ZV90aGlzX29wKHdhbGtfc3RhdGUsIG9wKTs8YnI+CiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqB9IHdo
aWxlIChvcCk7PGJyPgomZ3Q7ICvCoCDCoCDCoH08YnI+CiZndDsgKzxicj4KJmd0O8KgIMKgIMKg
IMKgcmV0dXJuX0FDUElfU1RBVFVTKHN0YXR1cyk7PGJyPgomZ3Q7wqAgfTxicj4KJmd0OyAtLTxi
cj4KJmd0OyAyLjEuNDxicj4KPGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+Cg==

--===============2631730645121125411==--

