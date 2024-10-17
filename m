Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020080.outbound.protection.outlook.com [52.101.193.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030BF227B81
	for <acpica-devel@lists.linux.dev>; Thu, 17 Oct 2024 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197224; cv=fail; b=onDxE1/Qh3J1TGiUzrCdtMEaydgV7rHo7hPK2nxLVkJ3Xczc2CDz58L/145y0/1lZtQoozD/uQivrQ2PpLLrTl9vxUIJtaOGwUH0reGXoPov60AzTTdQyf4v7Yq61PForqY3wXdmIseZJ7NUbTMR3eyuLyikru3dqd7GAakSTkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197224; c=relaxed/simple;
	bh=3ds97bmB5u8a6+fTqZhRzmVVyH0aLzmxZxw2mqSa17w=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XDVkgVGAeAYUjdYruE9t8+SuVsiYWQghVh+yWbozCdUZMFLZt844Fyu5IsjJW8oOcuu8OMb1g+Tnn4in+Ufvgv3nrA++NPehHQj7onsCBTn/Hg27jCAS8/Vuuwrzlh6mR6VMefQ7/k4oWUNSaU2zQrsnDQGDZSbgnNjjtUbZUD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=NlXTOlbI; arc=fail smtp.client-ip=52.101.193.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="NlXTOlbI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSaIonHEKeIUMW57OQSdmFqSu0v4jXXVeDyXoWVJJ4QI9ofg3QlGhTRsgsrnb1C4hqcxgZiI5J3ORFyM+0ASzAymNlXsG01wPaamq0jcJADLYVTJnat/ABzi5pTvvoRWOxg1JTHoLxU4fJxV+BwAb207xrXdJ81MWjaV/JFeFYgRMeVM7GSuuJEa5Qn4rwz04FqB553SmbtMFP5CiTk0nm4tWk2wLQawAgbX9vn0k0aK1kPbril37BbYxIyBKfDm7Vc2S2sB2ZeXBjWNBM6DFfZJ8Dw+stczVksQTgtLZ6nbG6dPHxiNGcGGITNs0/fQFQJhxyX1FVvToFc9qeQ/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9T3/w3oiI81mgJ0RYC5vFr50VbcqS7euLLMCHNhzRA=;
 b=DGgMT1JVZMkGuGsJSvZME7OeZ2VA/tHu1VCfmrkld+pFAi/SKlCdoUU2X1/ByAYfF9TDCPPGk3U1n/a9pnQwYYVcXdFbu3CZYu0wkX7HC7DR8D605FdClgs19sJgf/LjMqscHYK1pGGTGcOn34g81zetlHp61kaySJ8bbUjknx5kGYzEGqEGFD1EDyXrORpVHRfH+UXeH34tmEYj3Nwj3cucsbCbmOI72VfoxkEraUPTzy6QP12fXBzfILJZdIMxUOZOIYgGZIR2SlwQeTr0wfyaHWyOc8gjWlFopycy61TxwtrEI9hvRv04ZswVwHDgPCKj1wsAjTB1XDv7KBeJKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9T3/w3oiI81mgJ0RYC5vFr50VbcqS7euLLMCHNhzRA=;
 b=NlXTOlbI66OggOK0Jnu5gYP8ULiD6GB7jdQ59PlQySq+eQa/Dc/z8RCnSbzb32lQ1UayH91iSMxHi6WiaVJJYd1Qx4AL0LlA+2/L6+g/0aurZGaNcV5VKiJowcHzhrfK93EIBLhn6jNl41DN3zz2LyW5JsiI52BHtfkqgTEbC9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BY3PR01MB6609.prod.exchangelabs.com (2603:10b6:a03:360::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Thu, 17 Oct 2024 20:33:35 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%4]) with mapi id 15.20.7982.022; Thu, 17 Oct 2024
 20:33:34 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: acpica-devel@lists.linux.dev
Subject: [PATCH 1/2] actbl1: Update values to hex to follow ACPI specs
Date: Thu, 17 Oct 2024 13:33:14 -0700
Message-Id: <20241017203315.866487-1-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0305.namprd04.prod.outlook.com
 (2603:10b6:303:82::10) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|BY3PR01MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b89533-bea4-4cf0-7850-08dceeeaf8c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NYHd/cfCjV4A9Oq8NUNG2jf6868ooxO8Qk8JpAcp7TkFLK8LheULvC5Edo8Q?=
 =?us-ascii?Q?z0V9jFCnJQrnjmZn/0J/waa91nYPb2pDeY5BgdezeueHXIMoN7Xi+EfzFbZb?=
 =?us-ascii?Q?20Btq2ZfbwRC8CYyjoIUH9Al3S+UT3GHbG7zxFRkV8lOPXQjCyiqk2lXZffl?=
 =?us-ascii?Q?fOO9ZQNpkdoNqND1p/VxAbKDFWr9grsECoXk7xdYkhe83UJa2yoNRiv8xrht?=
 =?us-ascii?Q?dcsX8F+/1EQyMqN+2TB6MxQqF2izuX5YYfKGKvh3bFVMjHUKl7YdlsT52v2w?=
 =?us-ascii?Q?LH9RFDUeSixYJXjyUAHtKf9jrlN4SBElCMS4aFSzsHrCS4fLUFanieB3f2MH?=
 =?us-ascii?Q?TlNp3W76T2VeE0og7ku/sVW4BeeAtQSyLCJPw5pD1pCG7r/cJXDMjyRxl4sQ?=
 =?us-ascii?Q?XJtIMw56nmZhmUn/9G7AdR+xleRl8FTmps20yFlE1+7X3BdTLhHy7a9OMCL4?=
 =?us-ascii?Q?tVdo/d9ZLRLhv87a8sVMf7fXTum9YCJG1WawEQU3c8t5xYBNr7P+HgXCeNIU?=
 =?us-ascii?Q?4080aOVc+bT12tyv0LVDf2s+AA6iBLezalTzJgQA+gRvaKOKWE4MRPEWmKuL?=
 =?us-ascii?Q?tOOKnxSM1OCbPWvDas/QrG0JNBR5Drwb7aFLYnpvAiw+aNjIMzejku+xt91v?=
 =?us-ascii?Q?uRW8ULwSxO+lsv/IwA3vQLjaB96aH+k6j/A0kOYzeOH8SmO/CN5DmxNM+oOm?=
 =?us-ascii?Q?CrBzZMd5Rg/DIBZZW1AaNNFRCVLlUjcS2TYbjyhkTczvIojQ1k2RGCO0QeUY?=
 =?us-ascii?Q?4vvbsrVXG1NC1qtNlSSEXhU9NKQP9B2k/tuMqTD5FmAQqHgGNfnGC5Uh1U7E?=
 =?us-ascii?Q?UjCV9Rgq4z5wfWo4TyA6RtCBIX4ZlmW6RF2MKj2XUuXBMLBrqf/oHUSBCD6C?=
 =?us-ascii?Q?SlCw2+dRSzH2IMSCyanAgrk3tEzQpMzcb0AksXg5TnvSWTvksMy363J7oxca?=
 =?us-ascii?Q?tn1mvgdacxgfFLZwL/CnGCemTlLOk2SUoG/5VQwI1wroUmFyHsUQrKKmH9q4?=
 =?us-ascii?Q?aY9VDGHuZk7JpVstV2v4TnLmHNK0qpgtbupgkeqyn6AsYrrSHQfzrSzAGpjq?=
 =?us-ascii?Q?pg9dMz5Qd0rNQpJ9tMNCxn+3FIL9Y7ADSU9+OTBWcbBOpVBfacLzsDyQ7UIV?=
 =?us-ascii?Q?IJ83WCsIpcJ53HTrwJe3NYD6DjbllE0uxT76TCpL9+4xZVZOTBIjVkyhg41V?=
 =?us-ascii?Q?IQnRfpj5l8zjXdJlWcNBT5rNSEYvVxsqJDCz++s9iBNLsYUuYxkat3DTtV+1?=
 =?us-ascii?Q?kMdfFJ/mW+712DHHUN2+ZJKLg4PCZXs+ZwSkEBxqJdlIcn4HtNBEHierrZs0?=
 =?us-ascii?Q?tIxAYNgdWyhMo/2ed9yME4O96T0nHh498LQDO5PLp/pSLgptGTDpwNcHG1Wg?=
 =?us-ascii?Q?L6TVJvkh5i/KOlxdOH2O0dnEf1Zz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OhgDGC/GyBBL9BVBQLt/T49MEp80ri80OP9G4dHA36gPYMjvHgBkcvUc4yd7?=
 =?us-ascii?Q?hSyKkXF2Fl6cp3mUSjLJbczwH4PofxquV3/Zo2NSbqgQPtEFN0sm6KJlnLWH?=
 =?us-ascii?Q?rxXPAmdO89TJJuhhmqj0SvuhFnYMAZBu0bzvYd6JM7rifA9SalZXWH3JMais?=
 =?us-ascii?Q?uYgGvgpMfHxya77BT26F2a6YQExFEVg7HimGikzN7OWFYfq390X6/mQJFL5w?=
 =?us-ascii?Q?drJtYkwj6/afc8p48mFljeT9NcLVQ6INItbMsle8uhxm9K0exQsyMV0cw2SX?=
 =?us-ascii?Q?AP6Iad5lIQy90Cke5cWQekz7qFgoU8Ozy0mF8IbZEppqSpDP4OzVDCy/mHkV?=
 =?us-ascii?Q?mg5AhWyLlOQiMCgP2+JkUiTeh/pVjDXBS9ByBneAya/w7stYusrKdyvnnaG8?=
 =?us-ascii?Q?NQduiwvP0PRXXoP5Hed0gNkoEZryDkMgRmLsdCr8FfJCcdK6jn8H4iOUUQvb?=
 =?us-ascii?Q?50vJYfxDM5Jtzi6lCePYPqW8LVh1C30betybk/HHDXppifeuI05wziJ3V/Zb?=
 =?us-ascii?Q?GeTMQeVjR/mkwrJ/WMR60OxlpB/Y9E70hXinwJMqIOlLVgbKEuhhpZD6BkNY?=
 =?us-ascii?Q?TWnkat1EE7aR/T/KWE6ravDZURCQKTFUtDTTMn5IlIeKhFyKxnrwjobYDDNi?=
 =?us-ascii?Q?FPqVTkF95EHbyTX9hwVIu4+ywdYv4c22ztqSqE8YzYRKo4yRLSc6TPHh+4VL?=
 =?us-ascii?Q?sbn4/A1UfnhQuOTFL3CNNjKBtJ7l4BRQ3pILw+p057tuDdV53KoGjwiEPpHY?=
 =?us-ascii?Q?xg17WeC+dabs0wrJ5HpM8M7Ypnu+BFftZEJL+eSPZ4smGSeSH9JUFU0NWe3u?=
 =?us-ascii?Q?AmM5Eqmuho18GYHSF5lahchmOzvsfgcdaUE/1QW0CIM+Cm9dgHi8DLMZKMJA?=
 =?us-ascii?Q?PEmFq+qlutNFv2++nGtUSsK7H4sxa6Xzc0sSvG+NGgisIgyitrHzAtdGXVHb?=
 =?us-ascii?Q?VRb4OenU2lepTI9+EFlW9Mwuvuv1c8qFFoqmTDNXAIx1q1+JRamj3NYSAtDf?=
 =?us-ascii?Q?ep5Kz1I5TAztkO/afsbZmPsgb9HSum/JPCEUetMubWlgwe5uPacCaOwD7h+A?=
 =?us-ascii?Q?aB71qpEX7+L2BKRpax9jyEcWLv2lM3sFNjyAgeUlLnaLpvPBra58pRPQl5Bs?=
 =?us-ascii?Q?BPV2D/m5dla4iwA4obgvyaR10Br3gsbCh+k2Z8Yv7vFOkJvCcp4+FqWr8wIi?=
 =?us-ascii?Q?aoOPdunXoyCyiSi09bJ4xtltDPo3B+b1YUQes1Ha4dZa51HwbvFvgJQxrUK2?=
 =?us-ascii?Q?n6+a52igcSNDRxGPcbjuSMVp9gal/902JAqCHDzZXuYCelyOQLglVkoE0GGC?=
 =?us-ascii?Q?dbDbzVKV+xAPeMfnjvzAlWiC9eOnpMdFlac+98EmuymB1+Zl/YJXP+Ee2zwq?=
 =?us-ascii?Q?82ny2WKP09TLP8G7G3TqvZJeT3xtB9TTlZlvE7d8YN/ML0X90KoLSaFEde6P?=
 =?us-ascii?Q?Wg/cQXI3qOIT38Mr90relEmr6jlPjZjBTbcYdmhrNNXYkMN50yVLhZdiFspQ?=
 =?us-ascii?Q?0uwz/xLHEGXY5DEjcpLJy20ZaAXs04NTo253fz2xhkFOT0NTcmVVgI3TOlRw?=
 =?us-ascii?Q?+OsMmJltBbhevKsIFPxN1mg6IH2Yt2A3xvPzkqCHBbAm+21i+W+RRGRF2OaF?=
 =?us-ascii?Q?QHs1q2/TbnzYKMKl1Sf2rsg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b89533-bea4-4cf0-7850-08dceeeaf8c0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 20:33:34.3893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAkbEH9Zxr8j2sKhFW+RtoT10E8hOnFdizp86QjHtNDlhRgVmO4+GE5r994ryPXR5xAj39+3xGq3lb3BsJdhnUA2rbIMpEeyn+NxfCxZ2WZ3x2zY7I7UvMknrQ5LEBuW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6609

ACPI specs(1) define Error Injection Actions in hex values.
This commit intends to update values from decimal to hex to be
consistent with ACPI specs.

(1) https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 source/include/actbl1.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/source/include/actbl1.h b/source/include/actbl1.h
index 71cbc36d3..c8e61677b 100644
--- a/source/include/actbl1.h
+++ b/source/include/actbl1.h
@@ -1369,17 +1369,17 @@ typedef struct acpi_einj_entry
 
 enum AcpiEinjActions
 {
-    ACPI_EINJ_BEGIN_OPERATION               = 0,
-    ACPI_EINJ_GET_TRIGGER_TABLE             = 1,
-    ACPI_EINJ_SET_ERROR_TYPE                = 2,
-    ACPI_EINJ_GET_ERROR_TYPE                = 3,
-    ACPI_EINJ_END_OPERATION                 = 4,
-    ACPI_EINJ_EXECUTE_OPERATION             = 5,
-    ACPI_EINJ_CHECK_BUSY_STATUS             = 6,
-    ACPI_EINJ_GET_COMMAND_STATUS            = 7,
-    ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS   = 8,
-    ACPI_EINJ_GET_EXECUTE_TIMINGS           = 9,
-    ACPI_EINJ_ACTION_RESERVED               = 10,    /* 10 and greater are reserved */
+    ACPI_EINJ_BEGIN_OPERATION               = 0x0,
+    ACPI_EINJ_GET_TRIGGER_TABLE             = 0x1,
+    ACPI_EINJ_SET_ERROR_TYPE                = 0x2,
+    ACPI_EINJ_GET_ERROR_TYPE                = 0x3,
+    ACPI_EINJ_END_OPERATION                 = 0x4,
+    ACPI_EINJ_EXECUTE_OPERATION             = 0x5,
+    ACPI_EINJ_CHECK_BUSY_STATUS             = 0x6,
+    ACPI_EINJ_GET_COMMAND_STATUS            = 0x7,
+    ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS   = 0x8,
+    ACPI_EINJ_GET_EXECUTE_TIMINGS           = 0x9,
+    ACPI_EINJ_ACTION_RESERVED               = 0xA,   /* 10 and greater are reserved */
     ACPI_EINJ_TRIGGER_ERROR                 = 0xFF   /* Except for this value */
 };
 
-- 
2.34.1

