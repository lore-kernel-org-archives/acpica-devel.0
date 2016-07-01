Content-Type: multipart/mixed; boundary="===============7673462713176291610=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 3/6] ACPICA: make use of new strtolower() function
Date: Fri, 01 Jul 2016 02:59:44 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4C381C@ORSMSX110.amr.corp.intel.com>
In-Reply-To: CAGt4E5uqbjaubPWE4rq-T7MvqAmwpUhvakM+jv+Sen8est9U5g@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7673462713176291610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is linux-specific code, ACPICA is os-independent. So we cannot accept =
such patch.



From: Markus Mayer [mailto:markus.mayer(a)broadcom.com]
Sent: Thursday, June 30, 2016 7:50 PM
To: Moore, Robert
Cc: Zheng, Lv; Wysocki, Rafael J; Len Brown; linux-acpi(a)vger.kernel.org; =
devel(a)acpica.org; linux-kernel(a)vger.kernel.org; Box, David E
Subject: Re: [PATCH 3/6] ACPICA: make use of new strtolower() function

On Thursday, 30 June 2016, Moore, Robert <robert.moore(a)intel.com<mailto:r=
obert.moore(a)intel.com>> wrote:
Where is "strtolower" implemented?

First patch of the series:
https://lkml.org/lkml/2016/6/30/733

> -----Original Message-----
> From: Markus Mayer [mailto:mmayer(a)broadcom.com<javascript:;>]
> Sent: Thursday, June 30, 2016 4:50 PM
> To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len Brown
> Cc: Markus Mayer; linux-acpi(a)vger.kernel.org<javascript:;>; devel(a)acp=
ica.org<javascript:;>; linux-
> kernel(a)vger.kernel.org<javascript:;>
> Subject: [PATCH 3/6] ACPICA: make use of new strtolower() function
>
> Call strtolower() rather than walking the string explicitly to convert it
> to lowercase.
>
> Signed-off-by: Markus Mayer <mmayer(a)broadcom.com<javascript:;>>
> ---
>
> *** Please note that there don't seem to be any callers of
> acpi_ut_strlwr().
> *** It may be possible to remove the function altogether.
>
>  drivers/acpi/acpica/utnonansi.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/acpi/acpica/utnonansi.c
> b/drivers/acpi/acpica/utnonansi.c index 3465fe2..b6e11dc 100644
> --- a/drivers/acpi/acpica/utnonansi.c
> +++ b/drivers/acpi/acpica/utnonansi.c
> @@ -64,19 +64,8 @@ ACPI_MODULE_NAME("utnonansi")
>
> **************************************************************************
> ****/
>  void acpi_ut_strlwr(char *src_string)
>  {
> -     char *string;
> -
>       ACPI_FUNCTION_ENTRY();
> -
> -     if (!src_string) {
> -             return;
> -     }
> -
> -     /* Walk entire string, lowercasing the letters */
> -
> -     for (string =3D src_string; *string; string++) {
> -             *string =3D (char)tolower((int)*string);
> -     }
> +     strtolower(src_string);
>  }
>
>
> /*************************************************************************
> ******
> --
> 2.7.4

--===============7673462713176291610==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTQgKGZpbHRlcmVkIG1lZGl1bSkiPg0KPHN0eWxl
PjwhLS0NCi8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6
Q2FsaWJyaTsNCglwYW5vc2UtMToyIDE1IDUgMiAyIDIgNCAzIDIgNDt9DQpAZm9udC1mYWNlDQoJ
e2ZvbnQtZmFtaWx5OlRhaG9tYTsNCglwYW5vc2UtMToyIDExIDYgNCAzIDUgNCA0IDIgNDt9DQov
KiBTdHlsZSBEZWZpbml0aW9ucyAqLw0KcC5Nc29Ob3JtYWwsIGxpLk1zb05vcm1hbCwgZGl2Lk1z
b05vcm1hbA0KCXttYXJnaW46MGluOw0KCW1hcmdpbi1ib3R0b206LjAwMDFwdDsNCglmb250LXNp
emU6MTIuMHB0Ow0KCWZvbnQtZmFtaWx5OiJUaW1lcyBOZXcgUm9tYW4iLCJzZXJpZiI7fQ0KYTps
aW5rLCBzcGFuLk1zb0h5cGVybGluaw0KCXttc28tc3R5bGUtcHJpb3JpdHk6OTk7DQoJY29sb3I6
Ymx1ZTsNCgl0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lO30NCmE6dmlzaXRlZCwgc3Bhbi5Nc29I
eXBlcmxpbmtGb2xsb3dlZA0KCXttc28tc3R5bGUtcHJpb3JpdHk6OTk7DQoJY29sb3I6cHVycGxl
Ow0KCXRleHQtZGVjb3JhdGlvbjp1bmRlcmxpbmU7fQ0Kc3Bhbi5FbWFpbFN0eWxlMTcNCgl7bXNv
LXN0eWxlLXR5cGU6cGVyc29uYWwtcmVwbHk7DQoJZm9udC1mYW1pbHk6IkNhbGlicmkiLCJzYW5z
LXNlcmlmIjsNCgljb2xvcjojMUY0OTdEO30NCi5Nc29DaHBEZWZhdWx0DQoJe21zby1zdHlsZS10
eXBlOmV4cG9ydC1vbmx5Ow0KCWZvbnQtZmFtaWx5OiJDYWxpYnJpIiwic2Fucy1zZXJpZiI7fQ0K
QHBhZ2UgV29yZFNlY3Rpb24xDQoJe3NpemU6OC41aW4gMTEuMGluOw0KCW1hcmdpbjoxLjBpbiAx
LjBpbiAxLjBpbiAxLjBpbjt9DQpkaXYuV29yZFNlY3Rpb24xDQoJe3BhZ2U6V29yZFNlY3Rpb24x
O30NCi0tPjwvc3R5bGU+PCEtLVtpZiBndGUgbXNvIDldPjx4bWw+DQo8bzpzaGFwZWRlZmF1bHRz
IHY6ZXh0PSJlZGl0IiBzcGlkbWF4PSIxMDI2IiAvPg0KPC94bWw+PCFbZW5kaWZdLS0+PCEtLVtp
ZiBndGUgbXNvIDldPjx4bWw+DQo8bzpzaGFwZWxheW91dCB2OmV4dD0iZWRpdCI+DQo8bzppZG1h
cCB2OmV4dD0iZWRpdCIgZGF0YT0iMSIgLz4NCjwvbzpzaGFwZWxheW91dD48L3htbD48IVtlbmRp
Zl0tLT4NCjwvaGVhZD4NCjxib2R5IGxhbmc9IkVOLVVTIiBsaW5rPSJibHVlIiB2bGluaz0icHVy
cGxlIj4NCjxkaXYgY2xhc3M9IldvcmRTZWN0aW9uMSI+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48
c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1
b3Q7LCZxdW90O3NhbnMtc2VyaWYmcXVvdDs7Y29sb3I6IzFGNDk3RCI+VGhpcyBpcyBsaW51eC1z
cGVjaWZpYyBjb2RlLCBBQ1BJQ0EgaXMgb3MtaW5kZXBlbmRlbnQuIFNvIHdlIGNhbm5vdCBhY2Nl
cHQgc3VjaCBwYXRjaC48bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxpYnJp
JnF1b3Q7LCZxdW90O3NhbnMtc2VyaWYmcXVvdDs7Y29sb3I6IzFGNDk3RCI+PG86cD4mbmJzcDs8
L286cD48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQt
c2l6ZToxMS4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OywmcXVvdDtzYW5zLXNl
cmlmJnF1b3Q7O2NvbG9yOiMxRjQ5N0QiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTEuMHB0O2ZvbnQtZmFt
aWx5OiZxdW90O0NhbGlicmkmcXVvdDssJnF1b3Q7c2Fucy1zZXJpZiZxdW90Oztjb2xvcjojMUY0
OTdEIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2IHN0eWxlPSJib3JkZXI6bm9u
ZTtib3JkZXItbGVmdDpzb2xpZCBibHVlIDEuNXB0O3BhZGRpbmc6MGluIDBpbiAwaW4gNC4wcHQi
Pg0KPGRpdj4NCjxkaXYgc3R5bGU9ImJvcmRlcjpub25lO2JvcmRlci10b3A6c29saWQgI0I1QzRE
RiAxLjBwdDtwYWRkaW5nOjMuMHB0IDBpbiAwaW4gMGluIj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PjxhIG5hbWU9Il9fX19fcmVwbHlzZXBhcmF0b3IiPjwvYT48Yj48c3BhbiBzdHlsZT0iZm9udC1z
aXplOjEwLjBwdDtmb250LWZhbWlseTomcXVvdDtUYWhvbWEmcXVvdDssJnF1b3Q7c2Fucy1zZXJp
ZiZxdW90OyI+RnJvbTo8L3NwYW4+PC9iPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTAuMHB0O2Zv
bnQtZmFtaWx5OiZxdW90O1RhaG9tYSZxdW90OywmcXVvdDtzYW5zLXNlcmlmJnF1b3Q7Ij4gTWFy
a3VzIE1heWVyIFttYWlsdG86bWFya3VzLm1heWVyQGJyb2FkY29tLmNvbV0NCjxicj4NCjxiPlNl
bnQ6PC9iPiBUaHVyc2RheSwgSnVuZSAzMCwgMjAxNiA3OjUwIFBNPGJyPg0KPGI+VG86PC9iPiBN
b29yZSwgUm9iZXJ0PGJyPg0KPGI+Q2M6PC9iPiBaaGVuZywgTHY7IFd5c29ja2ksIFJhZmFlbCBK
OyBMZW4gQnJvd247IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBkZXZlbEBhY3BpY2Eub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBCb3gsIERhdmlkIEU8YnI+DQo8Yj5TdWJq
ZWN0OjwvYj4gUmU6IFtQQVRDSCAzLzZdIEFDUElDQTogbWFrZSB1c2Ugb2YgbmV3IHN0cnRvbG93
ZXIoKSBmdW5jdGlvbjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPk9uIFRodXJzZGF5LCAzMCBKdW5lIDIwMTYsIE1vb3JlLCBSb2JlcnQgJmx0OzxhIGhyZWY9
Im1haWx0bzpyb2JlcnQubW9vcmVAaW50ZWwuY29tIj5yb2JlcnQubW9vcmVAaW50ZWwuY29tPC9h
PiZndDsgd3JvdGU6PG86cD48L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5XaGVyZSBp
cyAmcXVvdDtzdHJ0b2xvd2VyJnF1b3Q7IGltcGxlbWVudGVkPzxvOnA+PC9vOnA+PC9wPg0KPGRp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPC9kaXY+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+Rmlyc3QgcGF0Y2ggb2YgdGhlIHNlcmllczo8bzpw
PjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxhIGhyZWY9
Imh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE2LzYvMzAvNzMzIj5odHRwczovL2xrbWwub3JnL2xr
bWwvMjAxNi82LzMwLzczMzwvYT48bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPC9kaXY+DQo8YmxvY2txdW90
ZSBzdHlsZT0iYm9yZGVyOm5vbmU7Ym9yZGVyLWxlZnQ6c29saWQgI0NDQ0NDQyAxLjBwdDtwYWRk
aW5nOjBpbiAwaW4gMGluIDYuMHB0O21hcmdpbi1sZWZ0OjQuOHB0O21hcmdpbi1yaWdodDowaW4i
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1hcmdpbi1ib3R0b206MTIuMHB0Ij4mZ3Q7
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tPGJyPg0KJmd0OyBGcm9tOiBNYXJrdXMgTWF5ZXIg
W21haWx0bzo8YSBocmVmPSJqYXZhc2NyaXB0OjsiPm1tYXllckBicm9hZGNvbS5jb208L2E+XTxi
cj4NCiZndDsgU2VudDogVGh1cnNkYXksIEp1bmUgMzAsIDIwMTYgNDo1MCBQTTxicj4NCiZndDsg
VG86IE1vb3JlLCBSb2JlcnQ7IFpoZW5nLCBMdjsgV3lzb2NraSwgUmFmYWVsIEo7IExlbiBCcm93
bjxicj4NCiZndDsgQ2M6IE1hcmt1cyBNYXllcjsgPGEgaHJlZj0iamF2YXNjcmlwdDo7Ij5saW51
eC1hY3BpQHZnZXIua2VybmVsLm9yZzwvYT47IDxhIGhyZWY9ImphdmFzY3JpcHQ6OyI+DQpkZXZl
bEBhY3BpY2Eub3JnPC9hPjsgbGludXgtPGJyPg0KJmd0OyA8YSBocmVmPSJqYXZhc2NyaXB0Ojsi
Pmtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc8L2E+PGJyPg0KJmd0OyBTdWJqZWN0OiBbUEFUQ0ggMy82
XSBBQ1BJQ0E6IG1ha2UgdXNlIG9mIG5ldyBzdHJ0b2xvd2VyKCkgZnVuY3Rpb248YnI+DQomZ3Q7
PGJyPg0KJmd0OyBDYWxsIHN0cnRvbG93ZXIoKSByYXRoZXIgdGhhbiB3YWxraW5nIHRoZSBzdHJp
bmcgZXhwbGljaXRseSB0byBjb252ZXJ0IGl0PGJyPg0KJmd0OyB0byBsb3dlcmNhc2UuPGJyPg0K
Jmd0Ozxicj4NCiZndDsgU2lnbmVkLW9mZi1ieTogTWFya3VzIE1heWVyICZsdDs8YSBocmVmPSJq
YXZhc2NyaXB0OjsiPm1tYXllckBicm9hZGNvbS5jb208L2E+Jmd0Ozxicj4NCiZndDsgLS0tPGJy
Pg0KJmd0Ozxicj4NCiZndDsgKioqIFBsZWFzZSBub3RlIHRoYXQgdGhlcmUgZG9uJ3Qgc2VlbSB0
byBiZSBhbnkgY2FsbGVycyBvZjxicj4NCiZndDsgYWNwaV91dF9zdHJsd3IoKS48YnI+DQomZ3Q7
ICoqKiBJdCBtYXkgYmUgcG9zc2libGUgdG8gcmVtb3ZlIHRoZSBmdW5jdGlvbiBhbHRvZ2V0aGVy
Ljxicj4NCiZndDs8YnI+DQomZ3Q7Jm5ic3A7IGRyaXZlcnMvYWNwaS9hY3BpY2EvdXRub25hbnNp
LmMgfCAxMyAmIzQzOy0tLS0tLS0tLS0tLTxicj4NCiZndDsmbmJzcDsgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCYjNDM7KSwgMTIgZGVsZXRpb25zKC0pPGJyPg0KJmd0Ozxicj4NCiZndDsg
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvdXRub25hbnNpLmM8YnI+DQomZ3Q7IGIv
ZHJpdmVycy9hY3BpL2FjcGljYS91dG5vbmFuc2kuYyBpbmRleCAzNDY1ZmUyLi5iNmUxMWRjIDEw
MDY0NDxicj4NCiZndDsgLS0tIGEvZHJpdmVycy9hY3BpL2FjcGljYS91dG5vbmFuc2kuYzxicj4N
CiZndDsgJiM0MzsmIzQzOyYjNDM7IGIvZHJpdmVycy9hY3BpL2FjcGljYS91dG5vbmFuc2kuYzxi
cj4NCiZndDsgQEAgLTY0LDE5ICYjNDM7NjQsOCBAQCBBQ1BJX01PRFVMRV9OQU1FKCZxdW90O3V0
bm9uYW5zaSZxdW90Oyk8YnI+DQomZ3Q7PGJyPg0KJmd0OyAqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKjxicj4N
CiZndDsgKioqKi88YnI+DQomZ3Q7Jm5ic3A7IHZvaWQgYWNwaV91dF9zdHJsd3IoY2hhciAqc3Jj
X3N0cmluZyk8YnI+DQomZ3Q7Jm5ic3A7IHs8YnI+DQomZ3Q7IC0mbmJzcDsgJm5ic3A7ICZuYnNw
O2NoYXIgKnN0cmluZzs8YnI+DQomZ3Q7IC08YnI+DQomZ3Q7Jm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7QUNQSV9GVU5DVElPTl9FTlRSWSgpOzxicj4NCiZndDsgLTxicj4NCiZndDsgLSZuYnNw
OyAmbmJzcDsgJm5ic3A7aWYgKCFzcmNfc3RyaW5nKSB7PGJyPg0KJmd0OyAtJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7cmV0dXJuOzxicj4NCiZndDsgLSZu
YnNwOyAmbmJzcDsgJm5ic3A7fTxicj4NCiZndDsgLTxicj4NCiZndDsgLSZuYnNwOyAmbmJzcDsg
Jm5ic3A7LyogV2FsayBlbnRpcmUgc3RyaW5nLCBsb3dlcmNhc2luZyB0aGUgbGV0dGVycyAqLzxi
cj4NCiZndDsgLTxicj4NCiZndDsgLSZuYnNwOyAmbmJzcDsgJm5ic3A7Zm9yIChzdHJpbmcgPSBz
cmNfc3RyaW5nOyAqc3RyaW5nOyBzdHJpbmcmIzQzOyYjNDM7KSB7PGJyPg0KJmd0OyAtJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7KnN0cmluZyA9IChjaGFy
KXRvbG93ZXIoKGludCkqc3RyaW5nKTs8YnI+DQomZ3Q7IC0mbmJzcDsgJm5ic3A7ICZuYnNwO308
YnI+DQomZ3Q7ICYjNDM7Jm5ic3A7ICZuYnNwOyAmbmJzcDtzdHJ0b2xvd2VyKHNyY19zdHJpbmcp
Ozxicj4NCiZndDsmbmJzcDsgfTxicj4NCiZndDs8YnI+DQomZ3Q7PGJyPg0KJmd0OyAvKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKjxicj4NCiZndDsgKioqKioqPGJyPg0KJmd0OyAtLTxicj4NCiZndDsgMi43LjQ8
bzpwPjwvbzpwPjwvcD4NCjwvYmxvY2txdW90ZT4NCjwvZGl2Pg0KPC9kaXY+DQo8L2JvZHk+DQo8
L2h0bWw+DQo=

--===============7673462713176291610==--

