Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2111.outbound.protection.outlook.com [40.107.94.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAD6181304
	for <acpica-devel@lists.linux.dev>; Tue, 14 May 2024 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712134; cv=fail; b=U32BFqDP5IfmkWCuem1/Bkq8IUmRF+pV6CmbnhZcyXbjH3pS17BdAlmlS0Zb2n7olSslt1t1yi77To8ZPzBbYdt2sHMxsezkdeVGeG7tHV6Hx3+PAeF1eNu5iKvGfBOoVkSLO7KBcB28InhNg51rcaQoiUmrMM47Qbbg2kPSYwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712134; c=relaxed/simple;
	bh=QT5aBcrbXw/WW5Eh8Ln18B14vhrVscbWR7exX3Uej5k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qvB5TAS15tP1DkcMc05dd8pdeQp/b1t5MKS0lryTqQL276TofAyMEF4srGCad4/xZkiP8q4hh/f1AVcXC7PtvHHufq9APQjm7aW1iCoVacTV1Y+t3Cc9jwtbLqC02bfbFKN/p2+fskK9ZACnIvd/6FWUSKysOyYRvfw0D8He9jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=vcDMQ4+l; arc=fail smtp.client-ip=40.107.94.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="vcDMQ4+l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3M24HCBZUUHY8fJ8qIOXnhnlLovtcfcTCpZnJDknD7+0KJgKpO1UMaQIAjbCSJRpKfkdEtSrxUP59jQNW2TxxufOxkeY+DtOf0UEruqfQkOdkDZTDWweQrLYgVYSUAIl9LJKTHktm8Az6etaXEquPjjWVxf+93EQI1XLERQyPY2/rwCk43HMI9HGCNAswv2iyikHT+AjNOeZNpGIPJi1/H+YDceVJmJblbPft3rbE401FtSk2R6ovMeHdO7YRQPzmGl8/euvQfRtgiyClBnLgUe2h003tVScv1iF928rNE0850RlWJvjtpM3+6PRVadC41XkSMr4zsIwDxMhFm1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWsGfUyEnUCxejGCUVh2XqfqZdU9h3VcpJjY9oaeWfI=;
 b=ZwrC+uXKNI/ZBMhyU61eV982DgzjsZSFJBkraq4GyuZBImKblnkJeU7Snw87+8Uba9nzCr5nz4WX64h/DNomQiYVzc6nIo6MbuCrJ2C+/ge7/vhB4dwrPpxY5BGleiL/1kk8QcuXrIb8lEsIV7GCdnlTlHkEPqIT0wmxdjdy+Sg9k3UxyXj6oOHQrFdChu3ZcWtDjsbWAOzvZ/++uGa9jA+EQWceBtzyXunOtkTR4BeSQMw4RNa5POJlJum484MRSXXXI83U5xD4osDZgjhfic1vVevjuarLwx+FwdkpCglT5O9VVnWeRFptUgdJCeDsGouTbdE7jx+vwXiSC5vAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWsGfUyEnUCxejGCUVh2XqfqZdU9h3VcpJjY9oaeWfI=;
 b=vcDMQ4+ljEgq3Ap3F6u1cbjLprCehUPCit48FZQfasxzNZ//0h77RN6VxJh+lt9QpUeBPhBMKyTIIjZ33DkAzuGDqAgxdhkVHaOl9WX/FXl76XIOtzECwh2qyDfE2GYJA2afZjwxi3SzSnO4XmeCwWtH+4Zyj+xeMV0J2KahlsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 MW4PR01MB6402.prod.exchangelabs.com (2603:10b6:303:77::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Tue, 14 May 2024 18:42:08 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 18:42:07 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: acpica-devel@lists.linux.dev
Subject: [RFC PATCH 2/2] actbl1: Add EINJv2 get error type action
Date: Tue, 14 May 2024 11:41:50 -0700
Message-Id: <20240514184150.6285-2-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514184150.6285-1-zaidal@os.amperecomputing.com>
References: <20240514184150.6285-1-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0fafd53a-9da4-4d39-423a-08dc74458bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|52116005|1800799015|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mrqSKrN2XPV29w/QrInp6sUMztqIvGjB63q0mU8t2dp0WOiMHUDSrc/jaIUN?=
 =?us-ascii?Q?3UYKIYJM1m9XMzC0ZZOtw80/VrE0y5mhhFz9vHewSG+m+DdoJd7LIfvz6LaL?=
 =?us-ascii?Q?AAj5aglN6bd4F0lPSNAZ+1GO4OEWVE2HBjsUbC8jaxIzYzQTT5AQNDvjqzdn?=
 =?us-ascii?Q?kL/blimSgqhQw7XPctTf7ZI1sNK1z3SGmTikF8K74zud470xaCubxokCLFBc?=
 =?us-ascii?Q?VpD2HFipQIDRBN8qnYTsHpeTqZk8FzjSXjwrKkDLNZiHn1cw9kYMjbs1UImt?=
 =?us-ascii?Q?94fgp+WIUXICKrDiGawo6DCdRQFuhdJr2cuwLIDg7PMUzW/e+ijVQEAs0lTF?=
 =?us-ascii?Q?WZsv/nMfrwiLC7swuwAv2RBVCNijGEdMiXJS/5XdQ05N64P97Odp2t4VyVp3?=
 =?us-ascii?Q?OxytIdzCt2/iU69VL11hyIXUL0GLzCSuP5yhMTPsB4dDnw7NrbTMPtv1og1U?=
 =?us-ascii?Q?0FXJVoa5fNd2/QbQAXRWHNu5kdSafsZ9Y7r+HH2qaH4Z4udug5/oUFU2AMJI?=
 =?us-ascii?Q?wEe1ZCF90iAuft7uHDPvrWOjh/zfOo8YUcc78QjjvU79z+gdivt+lH8T6R+z?=
 =?us-ascii?Q?4M1mp9mRjvddisKpIBNj80ouGwES+3ciZm8GNpEPODKgHprTII10KSCjAklr?=
 =?us-ascii?Q?+RZ7dBCIxrDrEPa44OAUh7bm6d1eN5eRzKI2JxQoLKbb/qbIhs4FoIUu8akl?=
 =?us-ascii?Q?iEl7YmKBBHlsBssh5PTeuLPQY7pNaTaiGz8Tis8wOmQA3f/YGC/EE9/I+If1?=
 =?us-ascii?Q?zhHvfhGW4zD9KE698uI8hv97227fur66y0OepfoWJpniv/FXKXkb/+nrhk26?=
 =?us-ascii?Q?8WFRNG68qo668cdPvgYCzEg06SNWK88enjDKdo37jTTwkqjOFsYLpLowii2a?=
 =?us-ascii?Q?KqUNBeUP23gmok6xc+rPTbJ/dylbRsx2JEuuR2QwXL/MVbU8uY0tYQPsqH41?=
 =?us-ascii?Q?GQQums3DZbZLUI+YLJJMip0474k2mKN5m2rmPjkwdteHuPoGnjMHELR9JVe3?=
 =?us-ascii?Q?UObJk8zkoQdVerEXiITkwPbnTyljIKflqsD0WOAkajMibrOQrkfVb/H/8TXE?=
 =?us-ascii?Q?hIMPMKY/3rjlhKrEs7nBaHjLlYQL1Y48Dh4Ne0nL+IlRHlZqZLJ/N1rKEAB4?=
 =?us-ascii?Q?HCPZhsLJ9LYaIqPe1YwSRznBIvxha8e+aVQvYFmpwghlwnawY8r2UWIwC2uP?=
 =?us-ascii?Q?Wa1+QwC+FMpmyoXSpvRYShOQcHIY9xMhPJarn4GgupkP3PbGwP9io1zXAica?=
 =?us-ascii?Q?8p1H5mTe61gF1OAKNtcebNZWkg3LM4oj5uyIU/ruHxxGBYHzewiMG2Hl1Nud?=
 =?us-ascii?Q?rVg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8xoK4ExrokTE2LWw3xlR45qWle06wuOVoi7fL8k0aBXh4pISdARD7OC3TkEL?=
 =?us-ascii?Q?fWL1lcQyTjvnd0x5p3O2lJ3toHupqNIeopT/sS3S9oLhI+3QOCqyl7NRaZEU?=
 =?us-ascii?Q?NQt/O0BF077WdBY3bKZtjppLT+rR7APQBw5L/OJ4S19ztjV/JeKjhMWuJIVc?=
 =?us-ascii?Q?0moSaTuoDvnI0u5ZvyrOxQ4z+eVETDJNfJp1nLXMRTz3Y3lDHFJZ6kQfsJ75?=
 =?us-ascii?Q?/NG21qqRFKR0znKkeXE/uNCPItghi5/KR5IkPZLwiMQ7Hd+3b9qKhJEtN6Hy?=
 =?us-ascii?Q?WieLbl/SevelCl7iashU3KtpyOG4dzRXJSJ2gXCuGNNUL1LyLoHF+tMzF0jD?=
 =?us-ascii?Q?gJeizdYGvyiqlzYkscTg+Rq9WN9RFMCdTm/vEjKm3AuErBLcln8U6pfz2wqM?=
 =?us-ascii?Q?PbWboAvZwjlsjCMSnIeoLe5pSzyzubjGIipGjDdi9+yDDz2SLohpS1JHxyeQ?=
 =?us-ascii?Q?B4AHlwYAEInoq7N9tTcS3YtWjsSTVd8iMvcL9N05spvaWv/lc45HaGGv402Z?=
 =?us-ascii?Q?pvn5NlDHna7DW+mzUXzRAxF3b7Hoqp2UFTaRcqSlX/EwR8ZfgjrXNoWsMw+g?=
 =?us-ascii?Q?UBVHWFTcIYV8t8+760M+xi+5T+DviTBSpFb0Yk4OqT6rQmmggVWeG2F2nU76?=
 =?us-ascii?Q?2J7gkKuL9PpiFNwJoI4Phm3zG5IS62anpfZi+ho9nxnVrFOMyO9uOsxZf3s/?=
 =?us-ascii?Q?ZTTO4/ZGMYzkiN/YBcvvZUmAcAkFCMuNrEiVd3QOt+JpC4OhF/D43jX4yXQL?=
 =?us-ascii?Q?/NrZdorjcQeIN6drzFoTssOeQe/eDtlnNqOzz5qOHQbG6D3PawyOGeihqk2D?=
 =?us-ascii?Q?y37l43fBzvhQuSxAfMPtmX+Gg8a1fSBWB6DkoRqwobre2TdueSuNWTGRVAs9?=
 =?us-ascii?Q?LGhdYcYUaODqSCpRRM1kuwqvHKnTPyGqsCb4Aklvzf+7Pd4SFQfmShyeo+ti?=
 =?us-ascii?Q?JIz3VYSxVRXIUJY1nXVKKvLQPrFCGLyVa+TmQd9tN3ClRBivEXdNV9Xhw0Ia?=
 =?us-ascii?Q?d6oksP+clP/Nk1oCszcRvncfnstXLiGFy3euQRPnCxX70tBd7kaNPNXFvxgK?=
 =?us-ascii?Q?gXPKk+QDT9816QnWsD9RLMy5KotKRl56wsAtrQRaZZCfC6ht7VflN9Cqymfa?=
 =?us-ascii?Q?i7Q10ISIEVCNOgXzwji82yPfrTFizool58GWkfw4R9QxYG71cgjl++K5BPca?=
 =?us-ascii?Q?bdwIqx09zKuz4n2/aPaq5aQFDx/uyrRjX2laFa2aO4rbr2nQZoYrPZiyz+uY?=
 =?us-ascii?Q?KymZioib+6k75Zw+9IUzz+KbnmruL5hoSuaRJqnd9NtpwEZ75N7cCIq0+fad?=
 =?us-ascii?Q?pxd7kraku4gqk+JqphSC6GsHMTintstWW5drWbSIl6yG/n5ykJygDqniOSR/?=
 =?us-ascii?Q?LJU0Kdk0cKu655Fvo3qj6oM63WY0WM/txu1wwBFeeGZn6CtCPLkDMxTWj4vM?=
 =?us-ascii?Q?aOWfWFnQCYKe4G9TmpiuWJfvjwtB/qghZwLlzEVYEHvB8EaCVjxlUJMxhMPn?=
 =?us-ascii?Q?4Bn/Vcl4d/JE3cGzHeRFtnN4fq7Q5J5k9WTx2i+POK3KP1LOPkXYcsrq3SzD?=
 =?us-ascii?Q?5UTfjrcz39AIX6WLMAJrp4Lgkg1PK0hVSehKl7YFKmNO72E5hrS3xfT7aMWn?=
 =?us-ascii?Q?wA3oMJPSVTFiVfUtvGHdnxI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fafd53a-9da4-4d39-423a-08dc74458bea
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 18:42:03.0512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: my/T7P5tj4/kuh/V85qyqXw8iMA6AuEaMDA22FqUkxaaV3+l3VYNp4cXbjMkijIHBD2oGmxSWN+v9NZAyhobrE852AkuZE2Rot3/fzKCfgjb8FQlFLLBZXX6aAfSETX8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6402

This commit adds EINJV2_GET_ERROR_TYPE as defined in the proposed
specs(1)(2).

Proposed ACPI spces for EINJv2:
(1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615
(2) https://bugzilla.tianocore.org/attachment.cgi?id=1446

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 source/include/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/source/include/actbl1.h b/source/include/actbl1.h
index b6ad18940..ebee9b0f1 100644
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

