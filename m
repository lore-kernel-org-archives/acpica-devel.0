Content-Type: multipart/mixed; boundary="===============5741618639821896545=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] Re: [PATCH v3 14/14] ipu3-cio2: Add cio2-bridge to ipu3-cio2
 driver
Date: Mon, 28 Dec 2020 23:55:16 +0000
Message-ID: <CAHp75Vdzk7i+QzkTxLJUUkw3xZot9F7QT8pyu6b5yjkCVzMXEA@mail.gmail.com>
In-Reply-To: X+plTyUFhfHi7eIE@pendragon.ideasonboard.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5741618639821896545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 29, 2020 at 1:08 AM Laurent Pinchart
<laurent.pinchart(a)ideasonboard.com> wrote:
>
> On Tue, Dec 29, 2020 at 12:55:44AM +0200, Andy Shevchenko wrote:
> > On Mon, Dec 28, 2020 at 10:37:38PM +0000, Daniel Scally wrote:
> > > On 28/12/2020 17:05, Sakari Ailus wrote:

...

> > > Which do you prefer?
> >
> > Actually ipu3-cio2.h misses a lot of inclusions (like mutex.h which I
> > immediately noticed when scrolled over data types).
>
> Then ipu3-cio2.h should be fixed :-)

Below is a draft patch (it is possible mangled, due to Gmail). Can you
look at it and tell me what you think?
I believe some headers can be removed, but I have no idea about header
inclusion guarantees that v4l2 provides.

From 10fa6c7ff66ded35a246677ffe20c677e8453f5b3 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko(a)linux.intel.com>
Date: Tue, 29 Dec 2020 01:42:03 +0200
Subject: [PATCH 1/1] media: ipu3-cio2: Add headers that ipu3-cio2.h is dire=
ct
 user of

Add headers that ipu3-cio2.h is direct user of.

Signed-off-by: Andy Shevchenko <andriy.shevchenko(a)linux.intel.com>
---
 drivers/media/pci/intel/ipu3/ipu3-cio2.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.h
b/drivers/media/pci/intel/ipu3/ipu3-cio2.h
index ccf0b85ae36f..9ea154c50ba1 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.h
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.h
@@ -4,8 +4,25 @@
 #ifndef __IPU3_CIO2_H
 #define __IPU3_CIO2_H

+#include <linux/bits.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
 #include <linux/types.h>

+#include <asm/page.h>
+
+#include <linux/videodev2.h>
+
+#include <media/media-device.h>
+#include <media/media-entity.h>
+#include <media/v4l2-async.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-subdev.h>
+#include <media/videobuf2-core.h>
+#include <media/videobuf2-v4l2.h>
+
 #define CIO2_NAME "ipu3-cio2"
 #define CIO2_DEVICE_NAME "Intel IPU3 CIO2"
 #define CIO2_ENTITY_NAME "ipu3-csi2"
@@ -325,6 +342,8 @@ struct csi2_bus_info {
  u32 lanes;
 };

+struct cio2_fbpt_entry;
+
 struct cio2_queue {
  /* mutex to be used by vb2_queue */
  struct mutex lock;
@@ -355,6 +374,8 @@ struct cio2_queue {
  atomic_t bufs_queued;
 };

+struct pci_dev;
+
 struct cio2_device {
  struct pci_dev *pci_dev;
  void __iomem *base;
-- =

2.29.2


-- =

With Best Regards,
Andy Shevchenko
--===============5741618639821896545==--

