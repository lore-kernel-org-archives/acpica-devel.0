Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020080.outbound.protection.outlook.com [52.101.193.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6626F219CB2
	for <acpica-devel@lists.linux.dev>; Thu, 17 Oct 2024 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197229; cv=fail; b=aXW7YgVYg5qNSMmTTK+sWwIzmO3ohPKu33WiCJdPnO4prc38x1gQlNcSbGMv4ISxIR5DTwMuPOVJaUam2xBiLQikIZQ1AvNqEeDc2HUBR5m5s0YMa3V4a2lu+xgLYyC7OW3PXH6VqnusVqCoBCqDn98++DlsdisQWgV5jNj6EGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197229; c=relaxed/simple;
	bh=mEymAZXoRa/y5MD0pwApClwmdxfnK0vfFigrwOHRl4U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ltw6UIOpQKJWKCMF9M0+etDeQMxQqH7bMjr2+DkW6fdcBeTpfbKfZw9mdASH8uxpYI9JglGm2bTEmrGs+JqqUqUkJHeZnh1oYkkUZ4iyip76N2sqV2G4fchD5+2nK2RvyVFP3DE+w6z9AYzRCnnE1i0iw2bKd3Mz0tPSbqVUeKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZpMKDMZm; arc=fail smtp.client-ip=52.101.193.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZpMKDMZm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFifmCRTWI3rBEL2NfG1uMI3GUUWsLyvpMeofU+3SWJgoA64tDW9fVj6IoEwbXQ+oC3Nh1nNmuA5hcCJJ/oskrJklycacnrJsMM8bV9gHIuPX+4neQM4ZwslhzFuT/HzY+1NNTbm6GTDtSTFrzMFN9J6Op+LXg8qkBEuV4CtYyfg65ki76bGrlO7xXjA8jUIRsPAudjrHkP425Pv4iIbf+H6i7gwL74gag8Z32g+EVmefHkAXRL1tRlxT3MoTE4HVZJmNdKhI6raRbd1uflL4f+0Dwb5A3eLUu1vYqpDQp7D686EM/67ABw6RsS58z0nIQ0WMDQfup6JPy4NpmJY9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkgfC9XKC+eoHkp2pzYfdj25AjNmjB3tX3jR2+AwSoo=;
 b=CweKYn513U+hOT/JFr6R+sfwm3rFdRr4MSuadH2sBwvFvGVd8D+3dDEae40KbpqDp2c19TBhZJB9JSlFZnv0bgkhm2SABE1k86vixWl64OGsJO1k+VDywL3NF5Y/hn4nnpT6M4snZ5GdEZmHsYSC8TrhxqVg9epSfwn274tGedIjh5HHmgfO7wjdSk687NgUxH7WzTg01zopWw/yKLmXoega2EbbQvwMZvTIJDS+oxcbQXY/05IN3BruJ+kA8jnEhyp9mg8SXjxZ8ER1ZC7ipwKGVyfWPyx9vi4FarXAmPFuMoVpfoYDPkk3232qLk9YFC7HxFmEGZn+ebuKSs8CeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkgfC9XKC+eoHkp2pzYfdj25AjNmjB3tX3jR2+AwSoo=;
 b=ZpMKDMZmI2Xx45v4OCEuHM7z+g5MPxwbsFoKlIP5N34kG3/sBuR9xHMSBO9F3f614GnKMCJYXTO4BSwIFfbyAJtMTPMkQewZwASFyl+WcJNd/O9/lkdxlhpzgw/OeJ1nQ9wRDnFC0RCijpBpMrKsL465fKZrsRl49p1HSLMokyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BY3PR01MB6609.prod.exchangelabs.com (2603:10b6:a03:360::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Thu, 17 Oct 2024 20:33:35 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%4]) with mapi id 15.20.7982.022; Thu, 17 Oct 2024
 20:33:35 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: acpica-devel@lists.linux.dev
Subject: [PATCH 2/2] actbl1: Add EINJv2 get error type action
Date: Thu, 17 Oct 2024 13:33:15 -0700
Message-Id: <20241017203315.866487-2-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017203315.866487-1-zaidal@os.amperecomputing.com>
References: <20241017203315.866487-1-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: c4537b19-1764-445b-156a-08dceeeaf903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Rn9YYQgyP+FNrFJFCVHIRfX82OBdhbRpD2izzpPJqgPIjAsdh02olRuwTO3?=
 =?us-ascii?Q?u/f4pt21s0TrvrqNHgQ00F7DPIIExcYwYMT+1XbMrNyl/AQxPCzlBLKA+m4W?=
 =?us-ascii?Q?5+OdRcUNie+IUFUNP6uC77F473miDub6Nr2deS9I4TP3Hkk+o3+NHAC00DPp?=
 =?us-ascii?Q?TG4s2Ue0xCUBqv/PlXv7eSFWeSVSyiZKI8MwGNInR5SUbwokvlptF54owU8D?=
 =?us-ascii?Q?V2SBvQSAb3RjZLL6/a+LGvZRTc452S2EdQzBMRNMWwI+0mXpQM+E/r5m0m9Q?=
 =?us-ascii?Q?eyI79wCs3XZYJFvgKkLna+bySBLRHa27IZ9BCJ63upI7428y80A2sIGcac4W?=
 =?us-ascii?Q?hD8NxKaBV7kts6G8XtQa+exi78fBBKRQhbDgAp2metOkCv+GkiB7UycZJTVM?=
 =?us-ascii?Q?OQEyHI/sqG5q54NFVZKA2uSpe3rtInsyoqKnTiDtrXM0O+DfrNdqN/DwAQsv?=
 =?us-ascii?Q?W2718EjoPnU7GLGfBkMI4kwSjGKpM3SUQlEOnOAVXfeq0lwPqPbw9ecoB53y?=
 =?us-ascii?Q?n8Ps1DmphdgnqHQ9Zsm6EeCt4QmqL0dl46VmpRj9Tjql54ilAH2Ri+pixmd4?=
 =?us-ascii?Q?huHHjM844PxKvMM7+jLJApJ8Ruzr8XgN9OVGvEl/oislQeZgumM/6Y11hN1/?=
 =?us-ascii?Q?sNf9FigNYC8PZvuC3fFFhTZ6Vt+vGCHcFY59byHHXZAzij/kMbIHI3HQlnb/?=
 =?us-ascii?Q?/UunfD2IXzDkYty2UR90uYbQrTTJ3CEwIraEVPSqd4DO2iLy5UvSifQS22HM?=
 =?us-ascii?Q?Nr/iy4JLobWxaXuNv5mh+7aEifJS7M0iA4DvUP5FE8Y+hJ5Efr02dPkro9bg?=
 =?us-ascii?Q?b97m7T99EsZFyfz806B3DNPJZu7XZrvy/ydx+/wy2F5s+cnvGKWUtSd4PvBC?=
 =?us-ascii?Q?xYvvpWc+ThZMAM7qGRm2MFaAzgoldq4CabGoq/Ojt0pOiUzEE/nOAP9Itzj3?=
 =?us-ascii?Q?1ffghMq8NBVD8zm25KEAeQiPqyy7jIKd53TgxyzbcmAlwXY98yBMnY347qgY?=
 =?us-ascii?Q?GoZa1rWovQ4jlDi16UmF5RkqLtlrzluf+f6ids5BYBt+9kQVYnMemDazOfZ/?=
 =?us-ascii?Q?aqPr7O4KPKaBaO/kaISDYCMElyAYz9Q+o5LX+NoeaTtQXOQ0hiN7f/0zGLwk?=
 =?us-ascii?Q?vGIzCykl/UO2CyO6mKx56LQ0KLeOQBVan/78+1EWOoE1RVoHwQXgSIjp1GGY?=
 =?us-ascii?Q?pyeyDakHAkeWYdvxDq5luJlSYNKpifFG8sT/tZsUERfw9aGXU+zQ4sU5Xamj?=
 =?us-ascii?Q?QdO0twA4Uw0kdXFWSmfwuwT90Ve7e8yc2nrVaUrL0Xfp+FqWr4ZIKCOQk3ce?=
 =?us-ascii?Q?hvgNhRt7s3mc0FjJEX3UUkmp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EcjMVyAMbCnSLjBOLAU/83KgO76A54P/K4m5g2ZxuGWoX7RSfLnwLk8rywmm?=
 =?us-ascii?Q?RHr5fHgviZyUYPn5zW8Xgdq6w9iPDyEqt9noUbBfyxs1P5TkyYdFIlnb29JL?=
 =?us-ascii?Q?eaPVk/xs7kpezZ34nv6R7MC3o3U5hadFFxygFUZeI0DM1HAt1XQbAud/FWUc?=
 =?us-ascii?Q?BTJFr0noAa/p0Y+jkcfcfdg37TTWmW0i0KHDXe3Y0lAeJmcrwKyVyPzZ/ahU?=
 =?us-ascii?Q?/msxbuEboh7jeSyJOlKwV0ZJHnGUcxKX1LUbBo6u8VieW2PC33ttifiLa0+n?=
 =?us-ascii?Q?urkewVjTJgXUJ3Wo9uY247NgLzL9aluJS7H2mBuRZgaIvNhNlL3Syka+qKvw?=
 =?us-ascii?Q?lCnq2TpXwwlBjorwTIn13IanU2wjhKwAREqaYz+Ar0U6XrkV5PEkIzd56qqt?=
 =?us-ascii?Q?bzH/s7ylbZfmtlM/jf2I5E79JAmwDeITzXD1k7F/fKleP1sSBBobX4+EQQ2M?=
 =?us-ascii?Q?M8TwvYln0VyXcomz4hjx4NQa99lOLzZTDv8aOsVbRRcFh2bHBdObuLVL6tae?=
 =?us-ascii?Q?ZljKKkXJrHJJzi9XfVSHDltLH0nOqVCc2ARuKfYupKCZZO7uPLsq7kN/ZjIN?=
 =?us-ascii?Q?E1kvHRP6GrB/k9Diz8XEs8rRA42+SJY6YYyioQ9TnzerFIKFNxzh7OGhCHxK?=
 =?us-ascii?Q?FZttV5vPPUEdLbKZIOQiS3SVz6odaZwIUWxL/MaQq3dFgJvrjqEVvmXHt1nb?=
 =?us-ascii?Q?VhSX9cdyJKBIyjOMpqNRo4c8rYVLqK94pTp8pLHVDU9OV96yjk6rnCMqhRi3?=
 =?us-ascii?Q?wchCOSmZmJhqHoCwV0JYiBWYZ/XL0e2UIhPJxGX5QwLXWS5hhUczFmPzE4aT?=
 =?us-ascii?Q?uMpbs7DXfK+/aAMJblzUBvhAOAzVFn23caspE8VIbKWh/O0m2jYbGhLBFpj4?=
 =?us-ascii?Q?vpwGbDHXInHBuSl6nmrp6TezathMsCPMV3A6JRI7Ny2EYjCnt9hN5FpDP5I4?=
 =?us-ascii?Q?GjQB0eusi7WWm6aYOd26k4KlR0Kg45PiFt5Srqa5UCMrxtJy0juVTpeAqeGS?=
 =?us-ascii?Q?2J/pRDOfZkDQavF1T764hNYeqvQk3e5rfYZPj3RFUuhYCLk6E/rDqzO9WQxb?=
 =?us-ascii?Q?aw6EfvCWkNTJS7knxCOncmDFtKg9e6u2OeAhzppoW3Ksag7x1Cm4+WXBEgu/?=
 =?us-ascii?Q?T0Namsy/iY+jEvqjGcdwCtjluEhcJmeXOWDyD7aJHWTLf2rGvhSfMMIYEpD4?=
 =?us-ascii?Q?C0Fu0G9nfn8A0g9R1vIjq92F+E1SyOnrA1BuuT6ttmDPtSO0ez5XN3wuVNJQ?=
 =?us-ascii?Q?eb6oBAvCxGDibFGJI0/9ILCw7WzGj8khyelwxJ48uqBCR1+8ZxP83qjbh5jN?=
 =?us-ascii?Q?pTZCs+tJUmjOD6juL/0Y/YSqtw4qfPmyXGypOJLmfrYy7K37EDzUr9Act3Mj?=
 =?us-ascii?Q?/PD07Mp/W3LLnpQPdrJETTyS6R/X+7vh5ZmFeQw+Q7vK6BoZ12jYTDgjJW5E?=
 =?us-ascii?Q?9zd2zGNY8VM4MxfYUjU1X/RoXsKHjN3Ks/tM4FbpdfHxPbnk9bDrwcYlK4GR?=
 =?us-ascii?Q?bhhhSUuowHgZQuhPFPcwjxJu7fPrdVJS925Ura4sRFFxvTB4SBmd2flnQYeK?=
 =?us-ascii?Q?lu2peHR0ZQRBlddKx6WD34kk9nMZPdNMFRrEIC4DM2f6XqQn9/RbltPZ1odS?=
 =?us-ascii?Q?0zVmM3bac/9Wcnn7GhHML6g=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4537b19-1764-445b-156a-08dceeeaf903
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 20:33:34.9110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bO1d4pJ1uB6ygI6qwjyNofC946vfQpX4zgzTZFBYxtVo36v7VBo7+kNoUn4MwAGmfP86bs7gd5vGR2wNvT1IfzVSHKRi1iaK9qY8R7mfMfTdvD56WQKpGj3MXxEbpnax
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6609

Add EINJV2_GET_ERROR_TYPE as defined in the new specs(1)(2).

Approved ACPI spces for EINJv2:
(1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615
(2) https://bugzilla.tianocore.org/attachment.cgi?id=1446

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 source/include/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/source/include/actbl1.h b/source/include/actbl1.h
index c8e61677b..ba849496b 100644
--- a/source/include/actbl1.h
+++ b/source/include/actbl1.h
@@ -1379,7 +1379,8 @@ enum AcpiEinjActions
     ACPI_EINJ_GET_COMMAND_STATUS            = 0x7,
     ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS   = 0x8,
     ACPI_EINJ_GET_EXECUTE_TIMINGS           = 0x9,
-    ACPI_EINJ_ACTION_RESERVED               = 0xA,   /* 10 and greater are reserved */
+    ACPI_EINJV2_GET_ERROR_TYPE              = 0x11,
+    ACPI_EINJ_ACTION_RESERVED               = 0x12,   /* 0x12 and greater are reserved */
     ACPI_EINJ_TRIGGER_ERROR                 = 0xFF   /* Except for this value */
 };
 
-- 
2.34.1

