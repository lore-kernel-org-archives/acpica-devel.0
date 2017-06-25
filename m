Content-Type: multipart/mixed; boundary="===============5535932933044036990=="
MIME-Version: 1.0
From: Seunghun Han <kkamagui at gmail.com>
Subject: Re: [Devel] [PATCH V4] acpi: acpica: fix acpi parse and parseext
 cache leaks
Date: Sun, 25 Jun 2017 22:12:18 +0000
Message-ID: <CAHjaAcRH6qnS8Fpkj4DC7ON7foBp0EQ1_w6YCnEu-BYhBP-O6w@mail.gmail.com>
In-Reply-To: CAHp75VfssiqaMG0Qm_0EG1pMotGg5pMt1_bZobAFYkoRUv1W3w@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5535932933044036990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello, Andy.

Thank you for your reply.

Patch V4 is the last patch which is applied all changes from original code.
Due to reviewer's advice, Patch V1, V2, V3 has reverted and I made the
latest patch, Patch V4.
Therefore, it seems that incremental patch is not needed.

If you have any requests, please let me know.

Best regards.


2017=EB=85=84 6=EC=9B=94 26=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 1:13, A=
ndy Shevchenko <andy.shevchenko(a)gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:

> On Fri, Jun 23, 2017 at 12:36 PM, Seunghun Han <kkamagui(a)gmail.com> wro=
te:
> > I'm Seunghun Han, and I work for National Security Research Institute of
> > South Korea.
>
>
> > -                                       /* Clean up */
> > -                                       do {
> > -                                               if (op) {
> > -                                                       status2 =3D
> > -
>  acpi_ps_complete_this_op
> > -                                                           (walk_state,
> op);
> > -                                                       if (ACPI_FAILURE
> > -                                                           (status2)) {
> > -
>  return_ACPI_STATUS
> > -
>  (status2);
> > -                                                       }
> > -                                               }
> > -
> > -                                               acpi_ps_pop_scope(&
> > -
>  (walk_state->
> > -
> parser_state),
> > -                                                                 &op,
> > -
>  &walk_state->
> > -
>  arg_types,
> > -
>  &walk_state->
> > -
>  arg_count);
> > -
> > -                                       } while (op);
>
> I didn't get, do you send an incremental patch as a new version?!
>
> --
> With Best Regards,
> Andy Shevchenko
>

--===============5535932933044036990==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdj48ZGl2PkhlbGxvLCBBbmR5LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmsgeW91
IGZvciB5b3VyIHJlcGx5LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UGF0Y2ggVjQgaXMgdGhl
IGxhc3QgcGF0Y2ggd2hpY2ggaXMgYXBwbGllZCBhbGwgY2hhbmdlcyBmcm9tIG9yaWdpbmFsIGNv
ZGUuPC9kaXY+PGRpdj5EdWUgdG8gcmV2aWV3ZXImIzM5O3MgYWR2aWNlLCBQYXRjaCBWMSwgVjIs
IFYzIGhhcyByZXZlcnRlZCBhbmQgSSBtYWRlIHRoZSBsYXRlc3QgcGF0Y2gsIFBhdGNoIFY0Ljwv
ZGl2PjxkaXY+VGhlcmVmb3JlLCBpdCBzZWVtcyB0aGF0IGluY3JlbWVudGFsIHBhdGNoIGlzIG5v
dCBuZWVkZWQuPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SWYgeW91IGhhdmUgYW55IHJl
cXVlc3RzLCBwbGVhc2UgbGV0IG1lIGtub3cuPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
QmVzdCByZWdhcmRzLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjxkaXYgY2xhc3M9Imdt
YWlsX3F1b3RlIj48ZGl2PjIwMTfrhYQgNuyblCAyNuydvCAo7JuUKSDsmKTsoIQgMToxMywgQW5k
eSBTaGV2Y2hlbmtvICZsdDs8YSBocmVmPSJtYWlsdG86YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNv
bSIgdGFyZ2V0PSJfYmxhbmsiPmFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb208L2E+Jmd0O+uLmOyd
tCDsnpHshLE6PGJyPjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjxkaXY+PGRpdj48ZGl2IGNsYXNz
PSJnbWFpbF9xdW90ZSI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFl
eCI+T24gRnJpLCBKdW4gMjMsIDIwMTcgYXQgMTI6MzYgUE0sIFNldW5naHVuIEhhbiAmbHQ7PGEg
aHJlZj0ibWFpbHRvOmtrYW1hZ3VpQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmtrYW1hZ3Vp
QGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj4NCiZndDsgSSYjMzk7bSBTZXVuZ2h1biBIYW4s
IGFuZCBJIHdvcmsgZm9yIE5hdGlvbmFsIFNlY3VyaXR5IFJlc2VhcmNoIEluc3RpdHV0ZSBvZjxi
cj4NCiZndDsgU291dGggS29yZWEuPGJyPg0KPGJyPg0KPGJyPg0KJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBDbGVhbiB1
cCAqLzxicj4NCiZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZG8gezxicj4NCiZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKG9wKSB7
PGJyPg0KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGF0dXMyID08YnI+DQomZ3Q7
IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFjcGlfcHNfY29tcGxldGVfdGhpc19v
cDxicj4NCiZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHdhbGtfc3RhdGUs
IG9wKTs8YnI+DQomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChBQ1BJX0ZBSUxV
UkU8YnI+DQomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChzdGF0dXMyKSkg
ezxicj4NCiZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJu
X0FDUElfU1RBVFVTPGJyPg0KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAoc3RhdHVzMik7PGJyPg0KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB9PGJyPg0KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KJmd0OyAtPGJyPg0KJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBhY3BpX3BzX3BvcF9zY29wZSgmYW1wOzxicj4NCiZndDsgLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHdhbGtfc3RhdGUtJmd0Ozxicj4NCiZndDsg
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBhcnNlcl9zdGF0ZSks
PGJyPg0KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1w
O29wLDxicj4NCiZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
JmFtcDt3YWxrX3N0YXRlLSZndDs8YnI+DQomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGFyZ190eXBlcyw8YnI+DQomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7d2Fsa19zdGF0ZS0mZ3Q7PGJyPg0KJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhcmdfY291bnQpOzxicj4NCiZn
dDsgLTxicj4NCiZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfSB3aGlsZSAob3ApOzxicj4NCjxicj4NCkkgZGlkbiYjMzk7dCBn
ZXQsIGRvIHlvdSBzZW5kIGFuIGluY3JlbWVudGFsIHBhdGNoIGFzIGEgbmV3IHZlcnNpb24/ITxi
cj4NCjxicj4NCi0tPGJyPg0KV2l0aCBCZXN0IFJlZ2FyZHMsPGJyPg0KQW5keSBTaGV2Y2hlbmtv
PGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PjwvZGl2Pg0K

--===============5535932933044036990==--

