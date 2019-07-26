Content-Type: multipart/mixed; boundary="===============3817870837031563282=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH v2] acpica: fix -Wnull-pointer-arithmetic warnings
Date: Fri, 26 Jul 2019 19:35:49 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B9661CBD@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 20190718194846.1880-1-cai@lca.pw
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3817870837031563282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We've taken the change to ACPI_TO_POINTER.
Thanks,
Bob


-----Original Message-----
From: Qian Cai [mailto:cai(a)lca.pw] =

Sent: Thursday, July 18, 2019 12:49 PM
To: Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>
Cc: Moore, Robert <robert.moore(a)intel.com>; Schmauss, Erik <erik.schmauss=
(a)intel.com>; jkim(a)FreeBSD.org; lenb(a)kernel.org; ndesaulniers(a)google=
.com; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; clang-built-linux(a=
)googlegroups.com; linux-kernel(a)vger.kernel.org; Qian Cai <cai(a)lca.pw>
Subject: [PATCH v2] acpica: fix -Wnull-pointer-arithmetic warnings

Clang generate quite a few of those warnings.

drivers/acpi/scan.c:759:28: warning: arithmetic on a null pointer treated a=
s a cast from integer to pointer is a GNU extension [-Wnull-pointer-arithme=
tic]
		status =3D acpi_get_handle(ACPI_ROOT_OBJECT,
obj->string.pointer,
                                         ^~~~~~~~~~~~~~~~
./include/acpi/actypes.h:458:56: note: expanded from macro 'ACPI_ROOT_OBJEC=
T'
 #define ACPI_ROOT_OBJECT                ((acpi_handle) ACPI_TO_POINTER
(ACPI_MAX_PTR))
							^~~~~~~~~~~~~~~
./include/acpi/actypes.h:509:41: note: expanded from macro 'ACPI_TO_POINTER'
 #define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) 0,
(acpi_size) (i))
                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/acpi/actypes.h:503:84: note: expanded from macro 'ACPI_ADD_PTR'
 #define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t,
(ACPI_CAST_PTR (u8, (a)) + (acpi_size)(b)))
                                         ^~~~~~~~~~~~~~~~~
./include/acpi/actypes.h:501:66: note: expanded from macro 'ACPI_CAST_PTR'
 #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
                                                                 ^ This is =
because pointer arithmetic on a pointer not pointing to an array is an unde=
fined behavior (C11 6.5.6, constraint 8). Fix it by just casting the corres=
ponding pointers using ACPI_CAST_PTR() and skip the arithmetic. Also, fix a=
 checkpatch warning together.

ERROR: Macros with complex values should be enclosed in parentheses
 #45: FILE: include/acpi/actypes.h:509:
+#define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, i)

Signed-off-by: Qian Cai <cai(a)lca.pw>
---

v2: Use ACPI_CAST_PTR() in ACPI_TO_POINTER() directly without
    arithmetic.

 include/acpi/actypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index ad6892a2=
4015..163181e2d884 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -506,7 +506,7 @@ typedef u64 acpi_integer;
 =

 /* Pointer/Integer type conversions */
 =

-#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) 0, (a=
cpi_size) (i))
+#define ACPI_TO_POINTER(i)              (ACPI_CAST_PTR (void, i))
 #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
 #define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (v=
oid *) 0)
 #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
--
2.20.1 (Apple Git-117)


--===============3817870837031563282==--

