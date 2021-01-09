Content-Type: multipart/mixed; boundary="===============5716417784780151358=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v5 09/15] lib/test_printf.c: Use helper function
 to unwind array of software_nodes
Date: Sat, 09 Jan 2021 09:07:34 +0000
Message-ID: <CAHp75VeLiMdzXL3Awhco-w6JwJhZNVao_uj7F6bmuty_aW0SNQ@mail.gmail.com>
In-Reply-To: X/kOYeZtkCspoAC5@pendragon.ideasonboard.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5716417784780151358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Saturday, January 9, 2021, Laurent Pinchart <
laurent.pinchart(a)ideasonboard.com> wrote:

> Hi Peter, Steven and Sergey,
>
> Could you please let us know if you're fine with this patch getting
> merged in v5.12 through the linux-media tree ? The cover letter contains
> additional details (in a nutshell, this is a cross-tree series and we
> would like to avoid topic branches if possible).


There is already a tag by Petr.


>
> On Thu, Jan 07, 2021 at 01:28:32PM +0000, Daniel Scally wrote:
> > Use the software_node_unregister_nodes() helper function to unwind this
> > array in a cleaner way.
> >
> > Acked-by: Petr Mladek <pmladek(a)suse.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko(a)linux.intel.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart(a)ideasonboard.com>
> > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky(a)gmail.com>
> > Suggested-by: Andy Shevchenko <andriy.shevchenko(a)linux.intel.com>
> > Signed-off-by: Daniel Scally <djrscally(a)gmail.com>
> > ---
> > Changes in v5:
> >
> >       - None
> >
> >  lib/test_printf.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/lib/test_printf.c b/lib/test_printf.c
> > index 7ac87f18a10f..7d60f24240a4 100644
> > --- a/lib/test_printf.c
> > +++ b/lib/test_printf.c
> > @@ -644,9 +644,7 @@ static void __init fwnode_pointer(void)
> >       test(second_name, "%pfwP", software_node_fwnode(&softnodes[1]));
> >       test(third_name, "%pfwP", software_node_fwnode(&softnodes[2]));
> >
> > -     software_node_unregister(&softnodes[2]);
> > -     software_node_unregister(&softnodes[1]);
> > -     software_node_unregister(&softnodes[0]);
> > +     software_node_unregister_nodes(softnodes);
> >  }
> >
> >  static void __init
>
> --
> Regards,
>
> Laurent Pinchart
>


-- =

With Best Regards,
Andy Shevchenko

--===============5716417784780151358==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGJyPjxicj5PbiBTYXR1cmRheSwgSmFudWFyeSA5LCAyMDIxLCBMYXVyZW50IFBpbmNoYXJ0ICZs
dDs8YSBocmVmPSJtYWlsdG86bGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tIj5sYXVy
ZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PGJsb2NrcXVv
dGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxl
ZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+SGkgUGV0ZXIsIFN0ZXZlbiBhbmQg
U2VyZ2V5LDxicj4KPGJyPgpDb3VsZCB5b3UgcGxlYXNlIGxldCB1cyBrbm93IGlmIHlvdSYjMzk7
cmUgZmluZSB3aXRoIHRoaXMgcGF0Y2ggZ2V0dGluZzxicj4KbWVyZ2VkIGluIHY1LjEyIHRocm91
Z2ggdGhlIGxpbnV4LW1lZGlhIHRyZWUgPyBUaGUgY292ZXIgbGV0dGVyIGNvbnRhaW5zPGJyPgph
ZGRpdGlvbmFsIGRldGFpbHMgKGluIGEgbnV0c2hlbGwsIHRoaXMgaXMgYSBjcm9zcy10cmVlIHNl
cmllcyBhbmQgd2U8YnI+CndvdWxkIGxpa2UgdG8gYXZvaWQgdG9waWMgYnJhbmNoZXMgaWYgcG9z
c2libGUpLjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZXJlIGlzIGFscmVhZHkg
YSB0YWcgYnkgUGV0ci48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29s
aWQ7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KT24gVGh1LCBKYW4gMDcsIDIwMjEgYXQgMDE6Mjg6
MzJQTSArMDAwMCwgRGFuaWVsIFNjYWxseSB3cm90ZTo8YnI+CiZndDsgVXNlIHRoZSBzb2Z0d2Fy
ZV9ub2RlX3VucmVnaXN0ZXJfPHdicj5ub2RlcygpIGhlbHBlciBmdW5jdGlvbiB0byB1bndpbmQg
dGhpczxicj4KJmd0OyBhcnJheSBpbiBhIGNsZWFuZXIgd2F5Ljxicj4KJmd0OyA8YnI+CiZndDsg
QWNrZWQtYnk6IFBldHIgTWxhZGVrICZsdDs8YSBocmVmPSJtYWlsdG86cG1sYWRla0BzdXNlLmNv
bSI+cG1sYWRla0BzdXNlLmNvbTwvYT4mZ3Q7PGJyPgomZ3Q7IFJldmlld2VkLWJ5OiBBbmR5IFNo
ZXZjaGVua28gJmx0OzxhIGhyZWY9Im1haWx0bzphbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRl
bC5jb20iPmFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4Ljx3YnI+aW50ZWwuY29tPC9hPiZndDs8YnI+
CiZndDsgUmV2aWV3ZWQtYnk6IExhdXJlbnQgUGluY2hhcnQgJmx0OzxhIGhyZWY9Im1haWx0bzps
YXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20iPmxhdXJlbnQucGluY2hhcnRAPHdicj5p
ZGVhc29uYm9hcmQuY29tPC9hPiZndDs8YnI+CiZndDsgUmV2aWV3ZWQtYnk6IFNlcmdleSBTZW5v
emhhdHNreSAmbHQ7PGEgaHJlZj0ibWFpbHRvOnNlcmdleS5zZW5vemhhdHNreUBnbWFpbC5jb20i
PnNlcmdleS5zZW5vemhhdHNreUBnbWFpbC5jb208L2E+Jmd0Ozxicj4KJmd0OyBTdWdnZXN0ZWQt
Ynk6IEFuZHkgU2hldmNoZW5rbyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFuZHJpeS5zaGV2Y2hlbmtv
QGxpbnV4LmludGVsLmNvbSI+YW5kcml5LnNoZXZjaGVua29AbGludXguPHdicj5pbnRlbC5jb208
L2E+Jmd0Ozxicj4KJmd0OyBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgU2NhbGx5ICZsdDs8YSBocmVm
PSJtYWlsdG86ZGpyc2NhbGx5QGdtYWlsLmNvbSI+ZGpyc2NhbGx5QGdtYWlsLmNvbTwvYT4mZ3Q7
PGJyPgomZ3Q7IC0tLTxicj4KJmd0OyBDaGFuZ2VzIGluIHY1Ojxicj4KJmd0OyA8YnI+CiZndDvC
oCDCoCDCoCDCoC0gTm9uZTxicj4KJmd0OyA8YnI+CiZndDvCoCBsaWIvdGVzdF9wcmludGYuYyB8
IDQgKy0tLTxicj4KJmd0O8KgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxl
dGlvbnMoLSk8YnI+CiZndDsgPGJyPgomZ3Q7IGRpZmYgLS1naXQgYS9saWIvdGVzdF9wcmludGYu
YyBiL2xpYi90ZXN0X3ByaW50Zi5jPGJyPgomZ3Q7IGluZGV4IDdhYzg3ZjE4YTEwZi4uN2Q2MGYy
NDI0MGE0IDEwMDY0NDxicj4KJmd0OyAtLS0gYS9saWIvdGVzdF9wcmludGYuYzxicj4KJmd0OyAr
KysgYi9saWIvdGVzdF9wcmludGYuYzxicj4KJmd0OyBAQCAtNjQ0LDkgKzY0NCw3IEBAIHN0YXRp
YyB2b2lkIF9faW5pdCBmd25vZGVfcG9pbnRlcih2b2lkKTxicj4KJmd0O8KgIMKgIMKgIMKgdGVz
dChzZWNvbmRfbmFtZSwgJnF1b3Q7JXBmd1AmcXVvdDssIHNvZnR3YXJlX25vZGVfZndub2RlKCZh
bXA7PHdicj5zb2Z0bm9kZXNbMV0pKTs8YnI+CiZndDvCoCDCoCDCoCDCoHRlc3QodGhpcmRfbmFt
ZSwgJnF1b3Q7JXBmd1AmcXVvdDssIHNvZnR3YXJlX25vZGVfZndub2RlKCZhbXA7PHdicj5zb2Z0
bm9kZXNbMl0pKTs8YnI+CiZndDvCoCA8YnI+CiZndDsgLcKgIMKgIMKgc29mdHdhcmVfbm9kZV91
bnJlZ2lzdGVyKCZhbXA7PHdicj5zb2Z0bm9kZXNbMl0pOzxicj4KJmd0OyAtwqAgwqAgwqBzb2Z0
d2FyZV9ub2RlX3VucmVnaXN0ZXIoJmFtcDs8d2JyPnNvZnRub2Rlc1sxXSk7PGJyPgomZ3Q7IC3C
oCDCoCDCoHNvZnR3YXJlX25vZGVfdW5yZWdpc3RlcigmYW1wOzx3YnI+c29mdG5vZGVzWzBdKTs8
YnI+CiZndDsgK8KgIMKgIMKgc29mdHdhcmVfbm9kZV91bnJlZ2lzdGVyXzx3YnI+bm9kZXMoc29m
dG5vZGVzKTs8YnI+CiZndDvCoCB9PGJyPgomZ3Q7wqAgPGJyPgomZ3Q7wqAgc3RhdGljIHZvaWQg
X19pbml0PGJyPgo8YnI+Ci0tIDxicj4KUmVnYXJkcyw8YnI+Cjxicj4KTGF1cmVudCBQaW5jaGFy
dDxicj4KPC9ibG9ja3F1b3RlPjxicj48YnI+LS0gPGJyPldpdGggQmVzdCBSZWdhcmRzLDxicj5B
bmR5IFNoZXZjaGVua288YnI+PGJyPjxicj4K

--===============5716417784780151358==--

