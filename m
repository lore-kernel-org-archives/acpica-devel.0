Content-Type: multipart/mixed; boundary="===============6921518244161764898=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: [Devel] [PATCH] ACPICA: Do not hang at mutex forever if BIOS tries to
 release global lock
Date: Fri, 08 Oct 2010 12:40:14 +0200
Message-ID: <201010081240.15203.trenn@suse.de>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6921518244161764898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

find the code against the Linux kernel pasted at the end
of the mail for review.
Find the code adjusted for ACPICA inclusion in the
attachement.

Bob: If you are ok with the patch, it would be great
if you could push it. Be aware that I did not compile
tested it in ACPICA environment.

Thanks,

       Thomas

From: Stuart Hayes <stuart_hayes(a)dell.com>

ACPICA: Do not hang at mutex forever if BIOS tries to release global lock

and OS did not request the lock (means the pending bit was not set).
Which in fact is a BIOS/HW bug (compare with ACPI Spec 3.0b):

5.2.10.1 Global Lock:
..
This signal only occurs when the other environment attempted to acquire
ownership while the lock was owned.
..
or
4.7.3.1.1 PM1 Status Registers
GBL_STS:
..
This bit is set in response to the BIOS releasing control of the Global Lock
and having seen the pending bit set.
..

There seem to be chipsets which can get this wrong (especially after a kexec
boot on Linux).

Also one could theoretically run into this if a new kernel got booted witho=
ut
proper reboot and BIOS re-initialization (like kexec) while:
  1) The OS hold the global lock
  2) The BIOS hold the global lock
This patch would handle condition 1.

To make sure condition 2. cannot happen, it should get stated in the ACPI s=
pec
that the global lock needs to be zeroed by BIOS everytime the OS tries to
(re-)enable ACPI mode.

Modifications by trenn:
  - Add a message -> This should not happen and if it happens it should not
    be ignored/handled silently
  - Adjusted from Linux kernel to acpica sources


Signed-off-by: Thomas Renninger <trenn(a)suse.de>

diff -purN '--exclude=3D*orig' linux-2.6.36-rc6_orig/drivers/acpi/acpica/ac=
global.h linux-2.6.36-rc6/drivers/acpi/acpica/acglobal.h
--- linux-2.6.36-rc6_orig/drivers/acpi/acpica/acglobal.h	2010-06-02 09:16:1=
4.000000000 -0500
+++ linux-2.6.36-rc6/drivers/acpi/acpica/acglobal.h	2010-06-02 09:24:44.000=
000000 -0500
@@ -213,6 +213,7 @@ ACPI_EXTERN acpi_semaphore acpi_gbl_glob
 ACPI_EXTERN u16 acpi_gbl_global_lock_handle;
 ACPI_EXTERN u8 acpi_gbl_global_lock_acquired;
 ACPI_EXTERN u8 acpi_gbl_global_lock_present;
+ACPI_EXTERN u32 acpi_gbl_global_lock_pending;
 =

 /*
  * Spinlocks are used for interfaces that can be possibly called at
diff -purN '--exclude=3D*orig' linux-2.6.36-rc6_orig/drivers/acpi/acpica/ev=
misc.c linux-2.6.36-rc6/drivers/acpi/acpica/evmisc.c
--- linux-2.6.36-rc6_orig/drivers/acpi/acpica/evmisc.c	2010-06-02 09:16:11.=
000000000 -0500
+++ linux-2.6.36-rc6/drivers/acpi/acpica/evmisc.c	2010-06-02 09:24:45.00000=
0000 -0500
@@ -297,6 +297,17 @@ static u32 acpi_ev_global_lock_handler(v
 {
 	u8 acquired =3D FALSE;
 =

+	/* This must not happen: BIOS must only release the lock if OS has set
+	 * it pending. Such inconsistancies could happen if the global lock bits
+	 * survived through a kexec boot. */
+
+	if (!acpi_gbl_global_lock_pending) {
+		u8 pending;
+		/* Clear lock bits. BIOS released lock and OS isn't waiting. */
+		ACPI_RELEASE_GLOBAL_LOCK(acpi_gbl_FACS, pending);
+		return (ACPI_INTERRUPT_HANDLED);
+	}
+
 	/*
 	 * Attempt to get the lock.
 	 *
@@ -309,6 +320,7 @@ static u32 acpi_ev_global_lock_handler(v
 		/* Got the lock, now wake all threads waiting for it */
 =

 		acpi_gbl_global_lock_acquired =3D TRUE;
+		acpi_gbl_global_lock_pending--;
 		/* Send a unit to the semaphore */
 =

 		if (ACPI_FAILURE
@@ -479,6 +491,8 @@ acpi_status acpi_ev_acquire_global_lock(
 =

 		acpi_gbl_global_lock_acquired =3D TRUE;
 		return_ACPI_STATUS(AE_OK);
+	} else {
+		acpi_gbl_global_lock_pending++;
 	}
 =

 	/*
diff -purN '--exclude=3D*orig' linux-2.6.36-rc6_orig/drivers/acpi/acpica/ut=
global.c linux-2.6.36-rc6/drivers/acpi/acpica/utglobal.c
--- linux-2.6.36-rc6_orig/drivers/acpi/acpica/utglobal.c	2010-06-02 09:16:1=
4.000000000 -0500
+++ linux-2.6.36-rc6/drivers/acpi/acpica/utglobal.c	2010-06-02 09:24:45.000=
000000 -0500
@@ -782,6 +782,7 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_global_lock_acquired =3D FALSE;
 	acpi_gbl_global_lock_handle =3D 0;
 	acpi_gbl_global_lock_present =3D FALSE;
+	acpi_gbl_global_lock_pending =3D 0;
 =

 	/* Miscellaneous variables */
=20

--===============6921518244161764898==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="acpi_global_lock_sanity_check.patch"

RnJvbTogU3R1YXJ0IEhheWVzIDxzdHVhcnRfaGF5ZXNAZGVsbC5jb20+CgpBQ1BJQ0E6IERvIG5v
dCBoYW5nIGF0IG11dGV4IGZvcmV2ZXIgaWYgQklPUyB0cmllcyB0byByZWxlYXNlIGdsb2JhbCBs
b2NrCgphbmQgT1MgZGlkIG5vdCByZXF1ZXN0IHRoZSBsb2NrIChtZWFucyB0aGUgcGVuZGluZyBi
aXQgd2FzIG5vdCBzZXQpLgpXaGljaCBpbiBmYWN0IGlzIGEgQklPUy9IVyBidWcgKGNvbXBhcmUg
d2l0aCBBQ1BJIFNwZWMgMy4wYik6Cgo1LjIuMTAuMSBHbG9iYWwgTG9jazoKLi4KVGhpcyBzaWdu
YWwgb25seSBvY2N1cnMgd2hlbiB0aGUgb3RoZXIgZW52aXJvbm1lbnQgYXR0ZW1wdGVkIHRvIGFj
cXVpcmUKb3duZXJzaGlwIHdoaWxlIHRoZSBsb2NrIHdhcyBvd25lZC4KLi4Kb3IKNC43LjMuMS4x
IFBNMSBTdGF0dXMgUmVnaXN0ZXJzCkdCTF9TVFM6Ci4uClRoaXMgYml0IGlzIHNldCBpbiByZXNw
b25zZSB0byB0aGUgQklPUyByZWxlYXNpbmcgY29udHJvbCBvZiB0aGUgR2xvYmFsIExvY2sKYW5k
IGhhdmluZyBzZWVuIHRoZSBwZW5kaW5nIGJpdCBzZXQuCi4uCgpUaGVyZSBzZWVtIHRvIGJlIGNo
aXBzZXRzIHdoaWNoIGNhbiBnZXQgdGhpcyB3cm9uZyAoZXNwZWNpYWxseSBhZnRlciBhIGtleGVj
CmJvb3Qgb24gTGludXgpLgoKQWxzbyBvbmUgY291bGQgdGhlb3JldGljYWxseSBydW4gaW50byB0
aGlzIGlmIGEgbmV3IGtlcm5lbCBnb3QgYm9vdGVkIHdpdGhvdXQKcHJvcGVyIHJlYm9vdCBhbmQg
QklPUyByZS1pbml0aWFsaXphdGlvbiAobGlrZSBrZXhlYykgd2hpbGU6CiAgMSkgVGhlIE9TIGhv
bGQgdGhlIGdsb2JhbCBsb2NrCiAgMikgVGhlIEJJT1MgaG9sZCB0aGUgZ2xvYmFsIGxvY2sKVGhp
cyBwYXRjaCB3b3VsZCBoYW5kbGUgY29uZGl0aW9uIDEuCgpUbyBtYWtlIHN1cmUgY29uZGl0aW9u
IDIuIGNhbm5vdCBoYXBwZW4sIGl0IHNob3VsZCBnZXQgc3RhdGVkIGluIHRoZSBBQ1BJIHNwZWMK
dGhhdCB0aGUgZ2xvYmFsIGxvY2sgbmVlZHMgdG8gYmUgemVyb2VkIGJ5IEJJT1MgZXZlcnl0aW1l
IHRoZSBPUyB0cmllcyB0bwoocmUtKWVuYWJsZSBBQ1BJIG1vZGUuCgpNb2RpZmljYXRpb25zIGJ5
IHRyZW5uOgogIC0gQWRkIGEgbWVzc2FnZSAtPiBUaGlzIHNob3VsZCBub3QgaGFwcGVuIGFuZCBp
ZiBpdCBoYXBwZW5zIGl0IHNob3VsZCBub3QKICAgIGJlIGlnbm9yZWQvaGFuZGxlZCBzaWxlbnRs
eQogIC0gQWRqdXN0ZWQgZnJvbSBMaW51eCBrZXJuZWwgdG8gYWNwaWNhIHNvdXJjZXMKCgpTaWdu
ZWQtb2ZmLWJ5OiBUaG9tYXMgUmVubmluZ2VyIDx0cmVubkBzdXNlLmRlPgoKLS0tCiBzb3VyY2Uv
Y29tcG9uZW50cy9ldmVudHMvZXZtaXNjLmMgICAgICB8ICAgMjIgKysrKysrKysrKysrKysrKysr
KystLQogc291cmNlL2NvbXBvbmVudHMvdXRpbGl0aWVzL3V0Z2xvYmFsLmMgfCAgICAxICsKIDIg
ZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9zb3VyY2UvY29tcG9uZW50cy9ldmVudHMvZXZtaXNjLmMgYi9zb3VyY2UvY29tcG9uZW50
cy9ldmVudHMvZXZtaXNjLmMKaW5kZXggYjBlMWNhYy4uOGMwZjliMSAxMDA2NDQKLS0tIGEvc291
cmNlL2NvbXBvbmVudHMvZXZlbnRzL2V2bWlzYy5jCisrKyBiL3NvdXJjZS9jb21wb25lbnRzL2V2
ZW50cy9ldm1pc2MuYwpAQCAtMzk5LDYgKzM5OSwyMyBAQCBBY3BpRXZHbG9iYWxMb2NrSGFuZGxl
ciAoCiAKIAogICAgIC8qCisgICAgICogVGhpcyBtdXN0IG5vdCBoYXBwZW46IEJJT1MgbXVzdCBv
bmx5IHJlbGVhc2UgdGhlIGxvY2sgaWYgT1MgaGFzIHNldAorICAgICAqIGl0IHBlbmRpbmcuIFN1
Y2ggaW5jb25zaXN0YW5jaWVzIGNvdWxkIGhhcHBlbiBpZiBhbm90aGVyIGtlcm5lbCBpcyBib290
ZWQKKyAgICAgKiB3aXRob3V0IGEgcHJvcGVyIHJlYm9vdCBhbmQgQklPUyByZS1pbml0aWFsaXph
dGlvbiBhbmQgdGhlIGdsb2JhbCBsb2NrIGJpdHMKKyAgICAgKiBkaWQgbm90IGdldCBjbGVhcmVk
LiBCdXQgaW4gZ2VuZXJhbCBpdCdzIGEgQklPUyBidWcgaWYgYSBnYmwgbG9jayByZWxlYXNlCisg
ICAgICogR1BFIGlzIHRyaWdnZXJlZCBhbmQgT1MgaGFzIG5vdCB0cmllZCB0byBhY3F1aXJlIHRo
ZSBsb2NrLgorICAgICAqLworICAgIAorICAgIGlmICghQWNwaUdibF9HbG9iYWxMb2NrUGVuZGlu
ZykgeworCXU4IHBlbmRpbmc7CisJLyogQ2xlYXIgbG9jayBiaXRzLiBCSU9TIHJlbGVhc2VkIGxv
Y2sgYW5kIE9TIGlzbid0IHdhaXRpbmcuICovCisJQUNQSV9SRUxFQVNFX0dMT0JBTF9MT0NLKGFj
cGlfZ2JsX0ZBQ1MsIHBlbmRpbmcpCisgICAgICAgICAgICBBQ1BJX1dBUk5JTkcgKChBRV9JTkZP
LCAiR2xvYmFsIGxvY2sgcmVsZWFzZSBHUEUsIGV2ZW4gT1MgZGlkIG5vdCB0cnkiCisJCQkgICAi
dG8gYWNxdWlyZSB0aGUgbG9jayIpKTsKKwlyZXR1cm4gKEFDUElfSU5URVJSVVBUX0hBTkRMRUQp
OworICAgIH0KKworICAgIC8qCiAgICAgICogQXR0ZW1wdCB0byBnZXQgdGhlIGxvY2suCiAgICAg
ICoKICAgICAgKiBJZiB3ZSBkb24ndCBnZXQgaXQgbm93LCBpdCB3aWxsIGJlIG1hcmtlZCBwZW5k
aW5nIGFuZCB3ZSB3aWxsCkBAIC00MTAsNyArNDI3LDcgQEAgQWNwaUV2R2xvYmFsTG9ja0hhbmRs
ZXIgKAogICAgICAgICAvKiBHb3QgdGhlIGxvY2ssIG5vdyB3YWtlIHRoZSB0aHJlYWQgd2FpdGlu
ZyBmb3IgaXQgKi8KIAogICAgICAgICBBY3BpR2JsX0dsb2JhbExvY2tBY3F1aXJlZCA9IFRSVUU7
Ci0KKwlBY3BpR2JsX0dsb2JhbExvY2tQZW5kaW5nLS07CiAgICAgICAgIC8qIFNlbmQgYSB1bml0
IHRvIHRoZSBzZW1hcGhvcmUgKi8KIAogICAgICAgICBTdGF0dXMgPSBBY3BpT3NTaWduYWxTZW1h
cGhvcmUgKEFjcGlHYmxfR2xvYmFsTG9ja1NlbWFwaG9yZSwgMSk7CkBAIC01NzksNyArNTk2LDgg
QEAgQWNwaUV2QWNxdWlyZUdsb2JhbExvY2sgKAogCiAgICAgICAgIEFjcGlHYmxfR2xvYmFsTG9j
a0FjcXVpcmVkID0gVFJVRTsKICAgICAgICAgcmV0dXJuX0FDUElfU1RBVFVTIChBRV9PSyk7Ci0g
ICAgfQorICAgIH0gZWxzZQorCUFjcGlHYmxfR2xvYmFsTG9ja1BlbmRpbmcrKzsKIAogICAgIC8q
CiAgICAgICogRGlkIG5vdCBnZXQgdGhlIGxvY2suIFRoZSBwZW5kaW5nIGJpdCB3YXMgc2V0IGFi
b3ZlLCBhbmQgd2UgbXVzdCBub3cKZGlmZiAtLWdpdCBhL3NvdXJjZS9jb21wb25lbnRzL3V0aWxp
dGllcy91dGdsb2JhbC5jIGIvc291cmNlL2NvbXBvbmVudHMvdXRpbGl0aWVzL3V0Z2xvYmFsLmMK
aW5kZXggYTdlMWJhYS4uNWYwZjI5ZiAxMDA2NDQKLS0tIGEvc291cmNlL2NvbXBvbmVudHMvdXRp
bGl0aWVzL3V0Z2xvYmFsLmMKKysrIGIvc291cmNlL2NvbXBvbmVudHMvdXRpbGl0aWVzL3V0Z2xv
YmFsLmMKQEAgLTkxNiw2ICs5MTYsNyBAQCBBY3BpVXRJbml0R2xvYmFscyAoCiAgICAgQWNwaUdi
bF9HbG9iYWxMb2NrQWNxdWlyZWQgICAgICAgICAgPSBGQUxTRTsKICAgICBBY3BpR2JsX0dsb2Jh
bExvY2tIYW5kbGUgICAgICAgICAgICA9IDA7CiAgICAgQWNwaUdibF9HbG9iYWxMb2NrUHJlc2Vu
dCAgICAgICAgICAgPSBGQUxTRTsKKyAgICBBY3BpR2JsX0dsb2JhbExvY2tQZW5kaW5nICAgICAg
ICAgICA9IDA7CiAKICAgICAvKiBNaXNjZWxsYW5lb3VzIHZhcmlhYmxlcyAqLwogCg==

--===============6921518244161764898==--

