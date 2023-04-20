Return-Path: <yijiangshan@kylinos.cn>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 18EB283EC2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E5E6783EA3
From: Jiangshan Yi <yijiangshan@kylinos.cn>
Message-Id: <20230420091102.39835-1-yijiangshan@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Acpica-devel] [PATCH v2] drivers/acpi/acpica/exserial.c: replace
	ternary operator with min()
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Thu, 20 Apr 2023 09:11:57 -0000
To: rafael@kernel.org, robert.moore@intel.com
Cc: 13667453960@163.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, lenb@kernel.org, Jiangshan Yi <yijiangshan@kylinos.cn>

Fix the following coccicheck warning:

drivers/acpi/acpica/exserial.c:346: WARNING opportunity for min().

min() macro is defined in include/linux/minmax.h. It avoids
multiple evaluations of the arguments when non-constant and performs
strict type-checking.

Link: https://github.com/acpica/acpica/pull/871
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/acpi/acpica/exserial.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exserial.c b/drivers/acpi/acpica/exseria=
l.c
index fd63f2042514..dfe507e0a09a 100644
--- a/drivers/acpi/acpica/exserial.c
+++ b/drivers/acpi/acpica/exserial.c
@@ -343,8 +343,7 @@ acpi_ex_write_serial_bus(union acpi_operand_object *s=
ource_desc,
 	/* Copy the input buffer data to the transfer buffer */
=20
 	buffer =3D buffer_desc->buffer.pointer;
-	data_length =3D (buffer_length < source_desc->buffer.length ?
-		       buffer_length : source_desc->buffer.length);
+	data_length =3D min(buffer_length, source_desc->buffer.length);
 	memcpy(buffer, source_desc->buffer.pointer, data_length);
=20
 	/* Lock entire transaction if requested */
--=20
2.27.0

