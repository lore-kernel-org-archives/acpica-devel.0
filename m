Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2111.outbound.protection.outlook.com [40.107.94.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5285A180A8C
	for <acpica-devel@lists.linux.dev>; Tue, 14 May 2024 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712132; cv=fail; b=X0zJjxjVGZZMeNtvVExcis10x/ZKN/1z83PdGqMjfClmGZKxfMnxCTdk5x3e3+UwSOoXC+2ifnZ09Lu9HbAigbDH0LuPN6byLkO17qxuEnKyQ6SSj81n/MxyGe3x2Ey6X6olooLXQeJGEinqawi+RhxYIhqrYR7fqg+OTWQeiRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712132; c=relaxed/simple;
	bh=ttFNm8hr2FEKd+KDMcR24dWAw0oJJT5lKZxZV5Gta0s=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AWglgTm8Y8Q4eXijg7r/91jigHMkFgXddggfJOiGlwFePc9kmUu7RSPoQNCgYPTSdQ0tNsNRPYRAViVuGOeD5ulwJZhykakt/6Yu1UD3/iArrQJDf1/YWAuO1bjOqAEUiWN2ATm8U3nWYjIRBa3qW43koXGGS/2ncYhIl8ZIQtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=nw4B3dzf; arc=fail smtp.client-ip=40.107.94.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="nw4B3dzf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHYLOC0Kfw7gqI1+ohUFf/cc7/S1Pm9i5SgIW0Dc9ZoCX/12waVoLvi4M7WtXUmRitTo7RkOtjmJgWaWEPQYqSv44wqi/KTYrY473IEILTY08Rql8NfRuSulnAGYsrvitS/Wpy3xOjHRaBfQgtW4wOHqY+wvlFzxrNT/Zn5b8IM4rTSjvhQxFYsazJ3ZN9ELUkxp5UqYUjWs+ofHgmpg0LicPz30Nuzxia/Yf9qj20BQaIwkgQp8g7J7A8n/kxUAExOZtrYY0+6UrCaCpje5y+0eR/yBv3ygyRZLpkYrnvDw7SZUtDtlrjNSeNVC4vyymHqFx523W2NbWsCsJVFmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtK6cLDreddoDD4HNbHBQXdLKs4a9eEv/iVNxC3oeQQ=;
 b=BEY8ANR/hVTfxrDXxmwAyQ+/cDOUS55RhG9pdJwDE+KxLVm2lHgxZkX/p15QxQap7kd6zWApVDPX5+a4+sop5a9AyoTdifZqejPVD01xj9qmq5sPad/6qxvlRH/YCm7hsbi2A+7zpSdSMgB32uvocfYGUDRcbJi2Em4ziX/fgS6UB+83kyuMwU4boECYwEm/u8Y+odIlsxqgGO7JyIos47k4BfE3EGbQRkVnoQnFkkDu53C26eEAhQs9kkIsvZN9ciEJx01Z0a2u7kxpHOVveTZzEKOuwqlM2pqUe+E8aHGOZWji53nXjHMEfMuUJ+yYSMXnjRSRTpfcDGWwzkULYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtK6cLDreddoDD4HNbHBQXdLKs4a9eEv/iVNxC3oeQQ=;
 b=nw4B3dzf34kwcV7URwrosvSnZgV88zEC+UlIZ+QJKvBGz0/KY2JV/EwBJGwRTpue3X+N7YMq3e8ZSb+qbxePVGbeS08HL9B0d1sXjerzGkwAEqZ7B+Jv/G4lLWZBTdUrHgv6DABR3D+jialkm4DKmwGw6yea8Fawf8y7CSQ4hWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 MW4PR01MB6402.prod.exchangelabs.com (2603:10b6:303:77::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Tue, 14 May 2024 18:42:07 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 18:42:02 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: acpica-devel@lists.linux.dev
Subject: [RFC PATCH 1/2] actbl1: Update values to hex to follow ACPI specs
Date: Tue, 14 May 2024 11:41:49 -0700
Message-Id: <20240514184150.6285-1-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:303:b4::8) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|MW4PR01MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6bedc2-a655-4252-f543-08dc74458b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|52116005|1800799015|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/9oWZE04m7tsCtE3tSHoixpy+xfQcfUF/hTRTOhBpsCGexiMhNpUBqvML994?=
 =?us-ascii?Q?igzc3EdZ7rPWR5Gd7FCTQ3RxWCRZ6ZWAUPaqHh5ncW9lrLvX2Bcij07e1YU3?=
 =?us-ascii?Q?ywFGdVR56V+eKpqt7hTe11JR/peiv2m7SO664MHF9MS8wPlkEXtXLcYp59xw?=
 =?us-ascii?Q?wE9/pznih/yMOtCjBZT9PuJFGe7O+4JWIlB+D/PYPr3SdqDHbIHjDzAQJLHr?=
 =?us-ascii?Q?YHsO5nx2obM3HWnb2P2r59bgOoDTOp5ASiMqsn1pZZZUNu/bzapkZVTm/Zxo?=
 =?us-ascii?Q?cAzMIiNhsZkZRaXzfIJAlTq4MjS+lDUBxoZBTJ9kYDpuoR/C5ImH5KQrK4En?=
 =?us-ascii?Q?Et92kjJfot0VhaYYzRnNixNBNRXLO1a895Bpnh6Sw0jb8JS4oZpW3ysPCCjS?=
 =?us-ascii?Q?93IrnfylA8dQZQuokWtqPm80KVm+zecUynFCu2NxVu7zdz/F/OYt5U42/1cN?=
 =?us-ascii?Q?vgXRfP7EwGzhj2RaImzXnuvR0fdKol7kTDMKVsHl7ykFCYiBke9O61fIiFBt?=
 =?us-ascii?Q?4aZMAXCDx4RWvBoSz6h2EX5Zxe0CIAtFm9dmoO03trujKpNGFPXJCQWzE8OH?=
 =?us-ascii?Q?TMQIe1j1xS9OJ9E5BIW1vqTGX0IldesLivlZGcVf1dadJiPn9ThQZfVPuQdJ?=
 =?us-ascii?Q?ioJkfw4HTmG5CvXd78Wkv5AU8dpre4Nk+OxJwHGuUr60s0ejeZmlB1TiWjrg?=
 =?us-ascii?Q?4Sj7whlRV3T3wtGCXEunW9NA6Xw4d1OCXKwXmnJGaeuliPMoLdoTzm7EBBAi?=
 =?us-ascii?Q?IZR1rvJLfVCV78DfIzeCqn0M7FFkoP0hgJbpLOQxls2H+YcEGjnpixF+/oqT?=
 =?us-ascii?Q?1goX9dCf5/K6EvzDXyeYN+MQedNFlq9W/codJOYJZJ5mmf+JcHXNfMUTLwGk?=
 =?us-ascii?Q?kq/tTmMqMk5ed+gix/i97ufCjf97meHu1zYQyxQWxWMz5AzgfNuKPYk8Ab3W?=
 =?us-ascii?Q?bRS1O41IwDK24j1BjQcNI1xZtY5Y8nC8L8W8vd7Ryi2weux3MAwFjLrSLnR6?=
 =?us-ascii?Q?9mZhCF6y01yH5Wqi4DE5nqVUWNWcAgiFAAGzD24WquSoU2foVdktyqITGHUh?=
 =?us-ascii?Q?KWxFeHb5of4vokXh6yNc9YPIRuiHp6SPOpLGjNUwFGhEIXem72ncAiGr/FcE?=
 =?us-ascii?Q?pQghxxqPtQKHWMUxTRlZPUHrZ7QUY+RfhkXgv/5T0vgA5pM841yc55Q6Ohc7?=
 =?us-ascii?Q?XxIxGzD0hQbxm19R3XqnZnRFlfaenynO8ZxETa+3nssRX3iXzh50SMAjrY3M?=
 =?us-ascii?Q?fIcuawwSiEhD1Dn1dnS4R8GXNL5w9iQL3bVUWLThnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fPy5KINBGt67PO+cRO4Dt4Y/TQbgjcaeRuYT0dseDf/7dTm7B05Kkw29kty4?=
 =?us-ascii?Q?eltXGcC4OcBFCLt/kZU5gKwd4qI15JY14Mi7xwb1xVdLUeaNQkl04IxRtT/t?=
 =?us-ascii?Q?yEbxTGEWshfH9XtKH3fCK81LxAmljqGlhWgheJ6BshoRFJXiO/2xnWdubgAA?=
 =?us-ascii?Q?RuEb/uzoYWRjLJSLZuAh8odyoMPZn94Rk3Po/+FKpzvhLvfTIQUw12n8/AlF?=
 =?us-ascii?Q?FVmNrordtTyqIT2ClSpSnZj4DfrVqQ7sWySYiQik6eN/7mqwoM5GrdHVrdvE?=
 =?us-ascii?Q?GJFblx//O3AhSnmDErvj2TE8Xk/C/KCnuFJuRx6ny8gm2FY8npxQ5tdVhCPE?=
 =?us-ascii?Q?0i58uru1po2tHUK28s7pD00y/paXG7UnQjvvjpycdFRzLfr58lWJ9N0hUyoq?=
 =?us-ascii?Q?tiu0xQmSwW72OXPAgeMh2xs7bGtjQrIYDIvAL+kVsY7c8ZKDhOVZ/v7cCa+U?=
 =?us-ascii?Q?w/jU7MrAUZhfdIUlMv6pXrmuP+zhupKvrVK0h1SQNNTJt7ziP+bp2Jxu7cdp?=
 =?us-ascii?Q?T1ndFLgyaSVm6xOe1CUdFdyEJvjG9wvq6RWPNJbcfslWrFO5SfBALDd2AbMk?=
 =?us-ascii?Q?3nbdkjMQVXN+4ihkhgJxplVsj9eXtItOpVjjI/YQzVnKI5KPG9UdrFA+3sl2?=
 =?us-ascii?Q?4+IK3xlB8tNWqgzr/d3z55SobHKR7EUlmlLtgAqvW8zZow9RhhuT3eeGfs57?=
 =?us-ascii?Q?tnBD8mUL96hT3IefKVymlkk9Ma/E+sOWvxs2JF3Qh/5u2VZ8d80DCE6hluDt?=
 =?us-ascii?Q?UyKT9vWLnmPEJBGB7frnChepg1AzyZo6IEuKeCqaE1/BE1t98M5ZycyvkmWB?=
 =?us-ascii?Q?U07PH9PkAKs1a14gauY7GDhzqvUqq68hDhiqWM2u9TqW1U5ncmBeIyJsnsLn?=
 =?us-ascii?Q?YJ6djmMvUINoJcgLhe+IKaQ4GFsLfnpeRil5waj2bKrnQ+aEDxdUq/SASQOB?=
 =?us-ascii?Q?EGgosVGG5FR9dQIXBTFE8fWcnPq9kgPjYkvRz7TTbZ5iO7xXSDvCfMUb0UtQ?=
 =?us-ascii?Q?BkoQzPRuus1TDAcwh3yi6K9VFK857O8oBMnCYyTHsW2z7fUKS0mxUYGYEt+V?=
 =?us-ascii?Q?bEa3lTOwWdrksxU4pE2kE1+MpB12/yXKN5FVQBTxP3AMre3xTAdd5iAAM17V?=
 =?us-ascii?Q?f907/Qn59U4a2gj8PUlGjblHYCrOZgKGwERRPm3DZBymtnjTzTXnUryZiMt5?=
 =?us-ascii?Q?F7GifpDOICaz8X60QjAZmpA5VJa0DxRwdkCzEy0p6fXFhRG2/701UUINX1cx?=
 =?us-ascii?Q?kEpWt+XvLGGSMshnyTiElwK6UEp5iHRaiTOTZ0YTf+cpKPLMfXtK4gy2IxX+?=
 =?us-ascii?Q?dkjGQg+Aa9P+FvIX1EBJ+pcBZVcIzSeBn9ALNX3q4R5agBmwovIGSRNq4wb8?=
 =?us-ascii?Q?bXseUQ32ktDCg3ZIc14pLpItGp87/edogHrB40uRD3RslbUVahKfRgCXSnRm?=
 =?us-ascii?Q?Vu+WigmjMRpZDLPqBlqcpxHvZM/pYD6+E3swlxsKeTDIAUOp61oeR7TRtDZ1?=
 =?us-ascii?Q?/yQs2X9cBy1Syynr94JbjLz+mVODkQ5e0UCf37YW+pZSYMYUZp/qbuRzZqUj?=
 =?us-ascii?Q?+2Tb5iz17bbUsL1laWfxRZtzmcAgO/CO5bXgDWBudJWAJmnuB07biLVO0yRO?=
 =?us-ascii?Q?midvsdY8eEvol31T7QbPpP0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6bedc2-a655-4252-f543-08dc74458b9c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 18:42:02.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3nrum+1MjbMiiMdYojTpbBaE/7ZAZA0l6fMjhFBouuAGSuKJD4ssQsH3TRcK/9aAVYRGO4Px1iAM1if/2cx84H/26fVqSBgSDc4lA1cP763/VuZQiBiTxuXjNcUa7b/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6402

ACPI specs(1) define Error Injection Actions in hex values.
This commit intends to update values from decimal to hex to be
consistent with ACPI specs.

(1) https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 source/include/actbl1.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/source/include/actbl1.h b/source/include/actbl1.h
index 26097feb7..b6ad18940 100644
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

