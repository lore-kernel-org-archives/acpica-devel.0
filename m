Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.133
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794899844;
	b=x5o1XPJQbUs+ichXyAs9lpWQ0lnsOAsLIGbuWFjqil+sQFmI3HpNqxi2CKcWWgcITIP+
	 nvAuFQfJpLTsglXNM5hQp+crDEBAwiPpHMGwbZSk5qb3d+tHUYARMURSvjTmYvogTSzJo
	 pWnsPdPvut3qC4jIGUr1wNT3HkTyFb1iDp5IjvcIF6PHH+z4Uxix4Q1C+r3t2K/5xsLgK
	 iCAlViAhKgaz1jAB/dAOo7MA70Jc6p1edpQ7mg4kcOFnUU5PTFvMZcHybovg2/7IA5ESl
	 yYHhrDs8m1RVrofylLMJbJj2nEYEa84d+exYtIG5AbKLeOO28a5vQ2bS33FEni4Y4cA==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899844;
	h=Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=jC+7tR67qPnvbeyKQ7U6GLlz7BRySjJmNMZ5NqYZ8x4=;
	b=kD2nmyZzYLfJkaZfnF63DmQJD83Vhk+9sK1/7qoEfSFkZ5DDPMA44/6dt275xEttTjc2
	 VLfUhnR+BmZ9pYTKJI5EJpCOZqBekCUTra0SiCYUeC6RexorKTeRUtLqmCw+zofztCevZ
	 sCufz7W3L5LNSNd8DPcJ0gAjc0vfp3rIMtwMah+PYE56S64DEE6xG6Skk3Zgr5H2ZGTi0
	 buh8iTIYmIGLityKNPNCBe8xiVRFf3Cod+b/O8Z1tCVFC3ZXKTG6i/iKN/6F16C0ysYPK
	 MewYfH3F7EZiUWkweOYAuWv0frbjNXKfOCPXHSCneisV0kJciyWi4lH8VYQlY3+dEEA==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=G1tJror4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.133
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F7E606A333
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 17 Nov 2026 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=G1tJror4
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 241774017B
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 17 Nov 2026 07:17:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.353
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CsLMNKdadZ4C for <acpica-devel@lists.linuxfoundation.org>;
 Tue, 17 Nov 2026 07:17:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B019540048
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c001::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1794899842;
	b=G76W7JuChdfvzV6SuLIk64Xr54SiRIF3R+bg/Fdf99vlGZxJvtTVDs5FLHpTy3SVjICX
	 vw/NBIS6++LJ/PKQYpY2Xph/r4NEY+QK2V3aWtVjmqlPCQJnak3Zwh2g+PoTueXDTvBDG
	 enSpqE3bYJQZ0aW/BNO3rpl2c217mBkad8rgZ9T23dD2R9IvKh2r3B10I0AMCNTsJO85P
	 h36utDUmQfKbNeQHosI+ci7mOwRb93o1+wYaYwdvoPLZYOebZjJS3em30oKifVGscFhfd
	 tH4xV1WMPZrIpItcZVrdSjh7rgpNkh4cp47/yEnxsLFtNxz7iDbYgIv5FkfJsnahuDw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794899842;
	h=Received-SPF:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=jC+7tR67qPnvbeyKQ7U6GLlz7BRySjJmNMZ5NqYZ8x4=;
	b=LI+5zq8frniBPhTDeLRFKje15azj7IjwMBZLsJY6MM24UjUnfLqYagfwbznbu8syT+8Y
	 jywsF+Zu2oLVbPD7yGrgPkJK/7jWJ4lAfSLOMIUNoYPxRD3PbPHYxcILtCdyoXZ804xqi
	 RvHU7HMZIfODJ4V2Zggq+oiShq4V1gsFDWTcdWtVz4bHOXylUqEEvPqVccfsFs/ZzBM/l
	 i7Fn5oMD3He0ThpA0YpbxFu2RSCHNVLGDgECYlMHo/b5RToTLYNMvk1d2v2ADEuOJY81X
	 JeCWPKhJt7beoDjRL769OzpHs52A7SKwnAzbgIkhN7zP/prOMwhmfm39MfnmHak2JXw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=G1tJror4;
	arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c001::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=baorui.liu@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=G1tJror4
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c001::2])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B019540048
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 17 Nov 2026 07:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jb61I6v8Eb+rWPYOX+J7cgcy+dFGG8Osra9rQn2dseQhXEK8mhFSPWr0/dgJWIG0YVTsDlMCqSu9FMSL6K83P/cbbQYEMuHrMBrlqqHoTSga5TSZD6V0qXl7mn0x+KWwfOd+oEwnz+Xy6Z914LFylZSGbZzlixrmIFj+f8SaoHDbdtk7NTismnmuOQ0/17cHKiKiXiQ8fqrLYjB6qAacW/Roh0hqoycdSrRPbov2CQ9o/9ImF54gpiv31OV/rZGuC1Dmv2wdJ8JIUI3VrGyi77WdJ/WVS2jB07rJTOETy4RLEowKdW6G42IFkzktopgmX63JGTwJj492XGJFCEujDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jC+7tR67qPnvbeyKQ7U6GLlz7BRySjJmNMZ5NqYZ8x4=;
 b=OP+bTicIGsW61rYARDx5r/nFXQczRvrp29t/IMxrbg6M8p9WxOkw/zVsHPvuD3hgdtRgP9vG9KrGruN8Ip9hPrHCcfe/CDocqqJNa1TVSR1yX7kQLb1tRGqS58ZzZ0WWGzjJDeXCiH46stCJOd4iY6RnxPdY/Pw5BHHTW0bBa9Kr8x190u7biiOd/zghtEVReDQ4XwfBIRPnakJC/r8j0IKDE/iHqRmlYb5NtAmqKCRKXymGTr2JOIxZsY3J7Oq0g59KGi/Fk7oR0XBRV3oFI2WuI3URZmp8pkMDXfoEopY3eGU71VnTWYOXw6biJ3YTf8zvrUI7LUCvtcoXsbuwtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC+7tR67qPnvbeyKQ7U6GLlz7BRySjJmNMZ5NqYZ8x4=;
 b=G1tJror42B1CpmN0UXqygh/0LAUzIhTltOgtTBwlf0GBqvVuPDSG1Gh++doKl/iDVGgkVZCw1J5j4/8gQ07M4zRCWfdLvwzKgzfZSPem1L5lfwqRn11xGvk5uYrRKddan3LxvUYhoFMWUVC46lQObyEywkMPDTMy1U/dz1/vY5s=
Received: from CH0PR03CA0239.namprd03.prod.outlook.com (2603:10b6:610:e7::34)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 07:17:13 +0000
Received: from BN7PEPF000000A7.namprd05.prod.outlook.com
 (2603:10b6:610:e7:cafe::6d) by CH0PR03CA0239.outlook.office365.com
 (2603:10b6:610:e7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 07:17:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN7PEPF000000A7.mail.protection.outlook.com (10.167.245.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 07:17:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 01:17:11 -0600
Received: from localhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 01:17:09 -0600
From: Baorui.Liu <baorliu@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<acpica-devel@lists.linuxfoundation.org>, kernel test robot <lkp@intel.com>,
	Baorui.Liu <baorliu@amd.com>
Subject: [PATCH v8] ACPI: button: Report wakeup key only for power button wakeups
Date: Tue, 17 Nov 2026 15:17:09 +0800
Message-ID: <20261117071709.428-1-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261109082832.496-1-baorliu@amd.com>
References: <20261109082832.496-1-baorliu@amd.com>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A7:EE_|IA1PR12MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8d0a19-2c6c-4a20-bbd7-08df447acd45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|18002099003|22082099003|6133799003|13003099007|11063799006|10067099003|261026140227099003|261022075727099003|261026121527099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|56012099006|261009223027099003|261102130727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	rFFQV3EXY2xl0yxKO2gq3MxFjqyz/e2ruVs5bDp/OC1JtdHbARqumSeMaQRG7eItgxsp//SON648pjIND2jvQ6bENoDSlO2D0no/HKheNXJscKaSydacBbnMik4MEkKbhRzpBkdLShuRGN2I7VBWyzinMOWKpoXUCOiDL4MclG2N6sQuyILQ2aNAcROgqvY/h014K6C3vyz+1G2lGBFJGV00wgRQ0b7U8edpArutNPt10RB11KQYvWtoIAsKbegMbHTalkwcXzsoyOCmh/zcFTUhtxpHQTyNDM64Oha1VhinyPoMKyxoveaIqDes9Y1XWKTlhcvsl0/r0bHYSr4k47ETSg1CNWkTT3mhs0FwLwuVS5yExsJtEx/rKctO0LhmW7aQxQNKGSDcD7ma+S1eJBD2Gl6PVfEiAmRx6Bg51M3/AmQG5HwZ9wZo5k6iQ+1ej6RCzWTKCiP8Ow5Ck+UyGkZSK7J5p8af1HRruKWrOlE0XrPTLIGDaqxrp7H/0FWBGY0+nhNlSzX8wzGubcEjYTqr8sDRiMi+7sul8DltB5lRrmQGHhYiwaCfh8knRSEKPbPz4Fs2bK4Jd1rwfwKm2PQUKRn6uovujoF6MtOjQz6dhKgplB2P3JRGHcN4aZ0BWB+p+5sAmlvZZBUYqvmNRA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(13003099007)(11063799006)(10067099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261102130727099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t6eVQN9reUQ8QtLmQ/V5JZrLh8DLB9n2VXMT/jMuWFbnoKYefSuN6b4USyXmF5Hm+UbFAYIlcTnIXEFvdNGsjA+VRJfaPXL1jBlfRTcuRQhqpuWw3G0dqz2o9OIRlduXBQhC6dZM/HMvUWkYub8UdS23pWs3pibrUYQEB9pHgPKGHG+Fm5XF0hBcROFW/eFSKkPxH8M7DjXCGXNDZLFCx4Ukv7Ro/r+QlcujLkg2y1gYbJrjuulssJdtBF1iKygSJYKELfn/UqwOWVxidakaHyZ+Dd+1TU44AtS9HJP8pbz+ggv4vFI+KzEK6qTFjpLRJagRXgtRu2KXMYgZJ/VQuLjTCPDSdrJkpbjGLVZOKD/tHaFWj9D4M4/mmXlFy2+6gIacC+zyouIlAsk+bqrVoi6bqa857Iq37hKyK18rl9HUcg5mMaCqQkQWNJhmzg49
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:17:13.0057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8d0a19-2c6c-4a20-bbd7-08df447acd45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757

The ACPI button driver reports KEY_WAKEUP from the Power Button input
device to let userspace know that the system was resumed by a power
button wakeup.

However, reporting KEY_WAKEUP from generic system resume paths can make
userspace observe a Power Button wakeup even when the system was resumed
by a different wake source.

This is reproducible on an AMD Android 15 Xen guest. With a kernel
without this fix, a non-power-button S3 resume:

  echo mem > /sys/power/state
  xl trigger android s3resume

makes the Power Button input device report KEY_WAKEUP. The same test on
a kernel with this fix no longer reports KEY_WAKEUP from the Power Button
input device.

Track whether a power button event/notify is observed while the ACPI
button device is suspended, and report KEY_WAKEUP on resume only in that
case.

When the fixed power-button status bit is set during early S3 resume,
clear it to avoid a deferred KEY_POWER delivery to userspace, and set a
sleep.c-owned flag so button resume can still report KEY_WAKEUP. Do not
call into the button driver from that IRQ-disabled path. Also clear
wakeup_pending before setting suspended, with a compiler barrier, and
drain ACPI notify work before clearing suspended on resume. Report
KEY_WAKEUP before clearing suspended so a late notify cannot drop both
KEY_WAKEUP and KEY_POWER.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202609290454.LJrhMCb3-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202611030112.cVsBZFFE-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202611030545.3st9p1ha-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202611100542.1xljQv20-lkp@intel.com/
Signed-off-by: Baorui.Liu <baorliu@amd.com>

Changes since v7:
- Guard acpi_sleep_pwr_btn_wakeup_pending() with CONFIG_ACPI_SLEEP,
  matching its definition in sleep.c, so button resume does not link
  against a missing symbol when CONFIG_PM_SLEEP=y and CONFIG_ACPI_SLEEP
  is unset (0day/LKP ERROR on x86_64 randconfig).

Changes since v6:
- Include <linux/types.h> in include/acpi/button.h so the bool
  declaration/stub of acpi_sleep_pwr_btn_wakeup_pending() builds when
  the header is included without prior bool typedefs (0day/LKP ERROR
  via nouveau_connector.c on parisc64-defconfig and arm64-randconfig).
---
 drivers/acpi/button.c | 63 ++++++++++++++++++++++++++++++++++++-------
 drivers/acpi/sleep.c  | 47 +++++++++++++++++++++-----------
 include/acpi/button.h | 19 +++++++++++++
 3 files changed, 104 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index c41fba556030..9a80a27e4297 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -203,6 +203,7 @@ struct acpi_button {
 	bool last_state;
 	ktime_t last_time;
 	bool suspended;
+	bool wakeup_pending;
 	bool lid_state_initialized;
 	bool gpe_enabled;
 };
@@ -488,7 +489,11 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 
 	acpi_pm_wakeup_event(button->dev);
 
-	if (button->suspended || event == ACPI_BUTTON_NOTIFY_WAKE)
+	if (button->type == ACPI_BUTTON_TYPE_POWER &&
+	    READ_ONCE(button->suspended))
+		WRITE_ONCE(button->wakeup_pending, true);
+
+	if (READ_ONCE(button->suspended) || event == ACPI_BUTTON_NOTIFY_WAKE)
 		return;
 
 	input = button->input;
@@ -510,6 +515,12 @@ static void acpi_button_notify_run(void *data)
 
 static u32 acpi_button_event(void *data)
 {
+	struct acpi_button *button = data;
+
+	if (button->type == ACPI_BUTTON_TYPE_POWER &&
+	    READ_ONCE(button->suspended))
+		WRITE_ONCE(button->wakeup_pending, true);
+
 	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data);
 	return ACPI_INTERRUPT_HANDLED;
 }
@@ -519,7 +530,15 @@ static int acpi_button_suspend(struct device *dev)
 {
 	struct acpi_button *button = dev_get_drvdata(dev);
 
-	button->suspended = true;
+	/*
+	 * Clear wakeup_pending before marking suspended. Otherwise a power
+	 * button SCI between the two stores could set wakeup_pending and then
+	 * be overwritten here, losing a real wakeup. barrier() prevents the
+	 * compiler from reordering the stores relative to that IRQ handler.
+	 */
+	WRITE_ONCE(button->wakeup_pending, false);
+	barrier();
+	WRITE_ONCE(button->suspended, true);
 	return 0;
 }
 
@@ -527,21 +546,45 @@ static int acpi_button_resume(struct device *dev)
 {
 	struct acpi_button *button = dev_get_drvdata(dev);
 	struct input_dev *input;
+	bool report_wakeup = false;
+
+	/*
+	 * Drain notify work queued while suspended so a late power-button
+	 * notify still observes suspended == true, sets wakeup_pending, and
+	 * does not synthesize KEY_POWER for userspace.
+	 */
+	acpi_os_wait_events_complete();
+
+	/*
+	 * Sample and report KEY_WAKEUP before clearing suspended. Otherwise a
+	 * notify that arrives after sampling but before suspended is cleared
+	 * can set wakeup_pending and then be dropped without KEY_WAKEUP or
+	 * KEY_POWER. Clear suspended before wakeup_pending so a new SCI sees
+	 * suspended == false and takes the normal KEY_POWER path; barrier()
+	 * keeps that store order.
+	 */
+	if (button->type == ACPI_BUTTON_TYPE_POWER) {
+		report_wakeup = READ_ONCE(button->wakeup_pending) ||
+				acpi_sleep_pwr_btn_wakeup_pending();
+		if (report_wakeup) {
+			input = button->input;
+			input_report_key(input, KEY_WAKEUP, 1);
+			input_sync(input);
+			input_report_key(input, KEY_WAKEUP, 0);
+			input_sync(input);
+		}
+	}
+
+	WRITE_ONCE(button->suspended, false);
+	barrier();
+	WRITE_ONCE(button->wakeup_pending, false);
 
-	button->suspended = false;
 	if (button->type == ACPI_BUTTON_TYPE_LID) {
 		button->last_state = !!acpi_lid_evaluate_state(ACPI_HANDLE(dev));
 		button->last_time = ktime_get();
 		acpi_lid_initialize_state(button);
 	}
 
-	if (button->type == ACPI_BUTTON_TYPE_POWER) {
-		input = button->input;
-		input_report_key(input, KEY_WAKEUP, 1);
-		input_sync(input);
-		input_report_key(input, KEY_WAKEUP, 0);
-		input_sync(input);
-	}
 	return 0;
 }
 #endif
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 7c1fb5b844be..a17318a7a3d6 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -22,6 +22,7 @@
 #include <linux/syscore_ops.h>
 #include <asm/io.h>
 #include <trace/events/power.h>
+#include <acpi/button.h>
 
 #include "internal.h"
 #include "sleep.h"
@@ -105,6 +106,23 @@ u32 acpi_target_system_state(void)
 EXPORT_SYMBOL_GPL(acpi_target_system_state);
 
 static bool pwr_btn_event_pending;
+static bool pwr_btn_wakeup_pending;
+
+/**
+ * acpi_sleep_pwr_btn_wakeup_pending - Consume fixed power-button wake hint.
+ *
+ * Returns true once if acpi_suspend_enter() observed and cleared the fixed
+ * power-button status bit during early S3 resume. Used by the button driver
+ * to report KEY_WAKEUP without sleeping in that IRQ-disabled path.
+ */
+bool acpi_sleep_pwr_btn_wakeup_pending(void)
+{
+	bool pending = READ_ONCE(pwr_btn_wakeup_pending);
+
+	WRITE_ONCE(pwr_btn_wakeup_pending, false);
+	return pending;
+}
+EXPORT_SYMBOL_GPL(acpi_sleep_pwr_btn_wakeup_pending);
 
 /*
  * The ACPI specification wants us to save NVS memory regions during hibernation
@@ -504,12 +522,12 @@ static void acpi_pm_finish(void)
 
 	acpi_resume_power_resources();
 
-	/* If we were woken with the fixed power button, provide a small
-	 * hint to userspace in the form of a wakeup event on the fixed power
-	 * button device (if it can be found).
-	 *
-	 * We delay the event generation til now, as the PM layer requires
-	 * timekeeping to be running before we generate events. */
+	/*
+	 * If woken by the fixed power button, provide a wakeup event on that
+	 * device. KEY_WAKEUP input reporting is handled by the button driver
+	 * via acpi_sleep_pwr_btn_wakeup_pending() / wakeup_pending; do not
+	 * synthesize KEY_POWER here.
+	 */
 	if (!pwr_btn_event_pending)
 		return;
 
@@ -625,14 +643,13 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	/* Reprogram control registers */
 	acpi_leave_sleep_state_prep(acpi_state);
 
-	/* ACPI 3.0 specs (P62) says that it's the responsibility
-	 * of the OSPM to clear the status bit [ implying that the
-	 * POWER_BUTTON event should not reach userspace ]
-	 *
-	 * However, we do generate a small hint for userspace in the form of
-	 * a wakeup event. We flag this condition for now and generate the
-	 * event later, as we're currently too early in resume to be able to
-	 * generate wakeup events.
+	/*
+	 * ACPI 3.0 (P62): OSPM should clear the fixed power-button status bit
+	 * so the event does not reach userspace as KEY_POWER. Only set plain
+	 * flags here: this path runs with IRQs disabled, so do not call into
+	 * the button driver (it may take sleeping locks). Button resume later
+	 * consumes pwr_btn_wakeup_pending for KEY_WAKEUP; acpi_pm_finish()
+	 * uses pwr_btn_event_pending for the PM wakeup event.
 	 */
 	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3)) {
 		acpi_event_status pwr_btn_status = ACPI_EVENT_FLAG_DISABLED;
@@ -641,8 +658,8 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 
 		if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET) {
 			acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
-			/* Flag for later */
 			pwr_btn_event_pending = true;
+			WRITE_ONCE(pwr_btn_wakeup_pending, true);
 		}
 	}
 
diff --git a/include/acpi/button.h b/include/acpi/button.h
index af2fce5d2ee3..83f5dd373f39 100644
--- a/include/acpi/button.h
+++ b/include/acpi/button.h
@@ -2,6 +2,8 @@
 #ifndef ACPI_BUTTON_H
 #define ACPI_BUTTON_H
 
+#include <linux/types.h> /* for bool */
+
 #define ACPI_BUTTON_HID_POWER	"PNP0C0C"
 #define ACPI_BUTTON_HID_LID	"PNP0C0D"
 #define ACPI_BUTTON_HID_SLEEP	"PNP0C0E"
@@ -15,4 +17,21 @@ static inline int acpi_lid_open(void)
 }
 #endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
 
+/*
+ * Set in acpi_suspend_enter() when the fixed power-button status bit is
+ * observed (IRQ-disabled context). Consumed by the button driver on resume
+ * so KEY_WAKEUP can be reported without calling into the button driver from
+ * that early path. Defined in sleep.c under CONFIG_ACPI_SLEEP. CONFIG_PM_SLEEP
+ * can be enabled without CONFIG_ACPI_SLEEP, so the stub keeps button.o
+ * linkable in that case. Safe when CONFIG_ACPI_BUTTON=m.
+ */
+#if IS_ENABLED(CONFIG_ACPI_SLEEP)
+bool acpi_sleep_pwr_btn_wakeup_pending(void);
+#else
+static inline bool acpi_sleep_pwr_btn_wakeup_pending(void)
+{
+	return false;
+}
+#endif
+
 #endif /* ACPI_BUTTON_H */

base-commit: 0069320cef67ba6ca745a05868c40e4c46b61284
-- 
2.34.1

