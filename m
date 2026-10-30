Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.138
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793366914;
	b=4ZFjd4KEmPq4J+gtqyRs1DOyoFkfILKtEWziQEEXcbks3uT2fS4Zz4cGKIvyqniHoDLO
	 CecT5C66hoHFNcl3kMrOIA5AqK2n7oMvCHjOyUJ/XE9I0E3kHPmJ65SWGKw2gwoYxVncI
	 O+Srk7Cl73PVQd0GWS3dkeq58VmlPaUNsLcUb/DDJ0Yyb+pCW6ekv9AUdR6d2ouyzgfsa
	 t5ZteA1vJQ2hFl8QnHyCvNBXQJ/VDXDzWJoWQ3SePVwInpVfsj1c3q3QdLLS0agpStaI4
	 EU7VD8+1fmXwgj6/9W6kuq24zQvGcrRhaLHRPaRjoHSSCTRMFRQ299YecnofhThtYgg==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793366914;
	h=Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
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
	bh=zH5g64fjOLMbJ38z0p2aYus+q+wNYUqewdU9R66a5Aw=;
	b=F8b8DSYx+c0r7a6UIbeGqQV/NHMK6Bp7D3XFtd20mEIJJYoY8JSyi5vop8MBM0t38Ghx
	 3lQ76h7lqzzic3Wu+ELX0z89/ExJ1c6mJA2vcnWQq+AoO/92rtXO9BoLM4Lg1bJ4pry6p
	 y46HFOCv/n7y/HAy9E6nn0XdmSOv2jXGQW2s4XXoeuIpR1FikYylfnpYuo0wghM66nzsN
	 Ee83S/otHSiDF19tgEtNBcMpajnVauje2H0xn0lmRr4+h8kbTcbRDDjGP+ZItDuGTHgF5
	 jmjkX7z56e931JuuKCI56TlBd9S2lE3VitoBNwolB+L19p0tER7jECD/9olNcA7Npbw==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nTk4iojr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.138
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF022606A31C
	for <acpica-devel@lists.linuxfoundation.org>; Fri, 30 Oct 2026 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nTk4iojr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5927A806A9
	for <acpica-devel@lists.linuxfoundation.org>; Fri, 30 Oct 2026 13:28:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.693
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gl3MDlaCfQg0 for <acpica-devel@lists.linuxfoundation.org>;
 Fri, 30 Oct 2026 13:28:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7EE99810F5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c110::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793366912;
	b=IUrCKUHAHGZTtDvnYJ22/US1g5jD3yp6tpFrE5OJegJof1obGYDoxwYxzlZgUDR/1LRI
	 vOt8rxDCbBmoFVIPhYmnAMYffZwp9S99aG+VUNMb+tqfPvA1Prb7Cuf3C/2zB9bl9EleX
	 mkFUWiiDRr8LNHaxXQ2B/x4pTPHribbSTY/akxVHEZBos6GU8P5o/WFcVI7h0166adKaU
	 LHP2y1w1WUkUKmjjhTISw20KEEKmHVwiB/V92afIpXCGjliht5CvKLrjhxAdajw/oWGBP
	 exk1Nkfj0WjJ5p4/xYLYS1OFfVk+kVsfcYAtxGCBQ/dvvZbAK+poApNpEKNXoXTcPpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793366912;
	h=Received-SPF:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=zH5g64fjOLMbJ38z0p2aYus+q+wNYUqewdU9R66a5Aw=;
	b=G3ue6xQ8t8KMNFepWnHsLp9B7QosqYbVmmIpw7kuxJ84Qk3IFy9T7AsFuqpq6jD01X7+
	 o3SNW/xNKqG+ijLBLx6opjyygdUdcoUsCri/nQiqFHL52gSySlV3wmnppJJm42HbG52C2
	 hg4cUrBMMENSO35hX65tAgqyU+ZRKD11COEWQfoo/ndvCL+8O9nGN3TmAbFxmUWtS6QJk
	 2D5H9Bl5gOw7O6FGDDi98eQM7aOrGs5I6eW22/ip+LJk1r6X+6uLkAVefyu+InE5z+jou
	 U9nLpKDE50GimXTpQqBfgoSCj9X9siWoaZr7CCBu8KEXj3TCZatSPCzf7pivylsNm+w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nTk4iojr;
	arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c110::3"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c110::3; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=baorui.liu@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nTk4iojr
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::3])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7EE99810F5
	for <acpica-devel@lists.linuxfoundation.org>; Fri, 30 Oct 2026 13:28:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH5QPEOZhXCUNbFAiicouXjVhT62QQLp/WkaQy79ajvsQcrxlkY3UHkJOEtp/Z+09XV1o7myhd07lgBfTmErUBBJ/WQ9Z6TMJ6e6nrSqA2LiKKI50dHl7gmH6td1/5M4I1tUW2PXbNIw5actY3povNfGHNmMOPKb03vPqZ1LYyHrok33ll/P1UANhDvng5TnLvHQkS++K5XKxpKv9M6WGZvQyUIm9vfV2PndQUUcSuUOoKdAJokHAsLZDrGtfjp3bgKaM5N4bXq+UuQCie7KbrXP068oLnr03DaPYj4hSVWIEtgMW8GlOuTpKRVesefMubobcQMXd0yvZWAMh1PIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zH5g64fjOLMbJ38z0p2aYus+q+wNYUqewdU9R66a5Aw=;
 b=mQP2SAiSrBq79aby7Q59WJ9nH7SWX0Sg/pkENaqZtZ7r9fZSeqN3xeBDGrxdcWj+lxmmA45NjMLRWNMksINBMlMMIknNDmOqD5zlYS9gk//CXTjsmLsuVZguCvqiq4VVyv7Rni3/bDDK5r25Lzjkr+Ls4IgmvBO3nm2Hmzzn/f7XrYdOQ3UP9x8KN/MQ2XYXE9cvAAf9Qu+rDr8MOjS6qE5vGlxFbwxt6D9D6xzJ9K9X0dJBj+CILcuTtN1fczfpbfyYKEJ5y+syu8+bCajpTuurJBuWLxqRlN7MAY9bp3RvMk0s3bO5sunZVsEhrILZPquaaqEKG+dMGZhX9Lwtmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zH5g64fjOLMbJ38z0p2aYus+q+wNYUqewdU9R66a5Aw=;
 b=nTk4iojrUbdFp3G+nREy7f5/AEI7zAlVvzU2vmKjHmIVRSd9M/j0Ym0oIBfY6gZX9jNVsC/e7TweGgsd01rH3n9Vh5Ae0tBDIi9E3T3leFECbt6b8i+aXM/2UTFcaLbr1W28oaLN6qlMAMddJD0pzQXWY4AzxcE8ddUb1DwGO+E=
Received: from MW4PR03CA0086.namprd03.prod.outlook.com (2603:10b6:303:b6::31)
 by DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.10; Fri, 30 Oct 2026 13:28:24 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::57) by MW4PR03CA0086.outlook.office365.com
 (2603:10b6:303:b6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 13:28:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 13:28:24 +0000
Received: from localhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 08:28:21 -0500
From: Baorui.Liu <baorliu@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<acpica-devel@lists.linuxfoundation.org>, kernel test robot <lkp@intel.com>,
	"Baorui . Liu" <baorliu@amd.com>
Subject: Re: [PATCH v5] ACPI: button: Report wakeup key only for power button wakeups
Date: Fri, 30 Oct 2026 21:27:40 +0800
Message-ID: <20261030132740.459-1-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJZ5v0h_136ACZzxQ=MdvRx_7iYRu3L3z1tY01ONfkSz5JEXzw@mail.gmail.com>
References: <20261012060847.486-1-baorliu@amd.com> <CAJZ5v0h_136ACZzxQ=MdvRx_7iYRu3L3z1tY01ONfkSz5JEXzw@mail.gmail.com>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|DS7PR12MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: e969f6ea-575e-4c51-54a1-08df3689ac7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|261028144727099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|10067099003|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	XxTu+hKj/E87htWG2tpAsF11qoI7jDzrurSYhJ3XRcdoV/F2T6bH3hBoyFPqkPF9euBeZIwH+bSQQFjTI42EupGmXCiJ4CkIKZFW9BcVP7ps9N/qDy1neR/3NGwFzMN4jgkrN2fsww0wJ3bcZtVYaEQY3T/hAPhwRkNkiXkTflUq8fJc4564Mg3Z8wk+9QRCe1m0/SO0sZ+ZX6oLnV1D5mfZXOEJ4hgylCvm06t5ZvDGUx5XJYQE9bUs3JcFp41nbDeQltiAHXvEkNIvkKU2K4G1+Ue5V4jCAM9wnpxPrLhhUIZteDHe1HS78tz3dW3o3duxlzZtAXG3lnIqlHpG71Yft794ZXuchjMRnklxK7fvNlC9nNnDNXT3vA5A+oFr161KWLvHc6nGr74Qn6aMJDOZGnc6CUj0C5t1UFVlkoTq1F12F6PivastEIPDqCcpTOJ4lrnZhXYbx9J8V3DUxvueUmj1GIdccpSOrQV9wO64+WyOpISFjPcbuOzfdTCRXUZ3J0ttE04d4mwa6iPm8nejVnw0bhs8F7VYztLC6Xu/LjJXzefGHX9zr23yW4Uz41DMKpIsRR2lwZ8sD+BjHntaenGg9hpnmw97vfHjzQtWJbhuJ72pYPoN7eyQE+hEhgdW2IkWCqEaJMTX96kmrUiy10BlwzEPv96cmP39CJCw3c+EHRDt3HvL9XEpCcy0Nx0gU/YzwlsDjys6EEdiUw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(261028144727099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZlRMSZRgO3Wwuvi3dyZIrbmycTaIg+ePPhXuZRpbRlQmRVKp7Eav+yQKMvFGdauGCVKZnJ+g7E7h/OQL2whw77Ao317W6WiM7BH5+IbUXQWSRX7dKGtKw28XMD7EVdg/2g3PpAsrVX+O5WVmHiyOmUltzJzkLTKUMPG864h3X578oCEVdbLbzjX4NaTi0B6xPDJJf0RPZNh2dhq9AHlyEGk0J/ycnfKj83jmpg11iQDEPAlMAyYyuzAUbuKC/qPEqC0xqkPL3yKkA0EBWYfU3nr6M8iEIocl2sA/qGTdET9Q12EY/9PVG5k6JoCNWTlVyQyzrwVZ/06P57rVdSo0WU1xR4xpf9klU/XhhnmtLVd3JPkSMVYbf+ilp+Pqkt+YHdJH+cAH3/5ad2g+YpLoOmKbqPsy4j17er2rajUHLHdWVJ453BcKedHf1dqrqxmQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 13:28:24.0728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e969f6ea-575e-4c51-54a1-08df3689ac7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886

Hi Rafael,

Thank you for pointing me at the Sashiko review. I went through the four
findings and agree with all of them. I have prepared a v6 on current
linux-pm/linux-next that addresses them as follows.

1) High: sleep-in-atomic in acpi_suspend_enter()
I agree. acpi_button_power_wakeup_pending() reached
acpi_get_first_physical_node(), which takes a mutex, while
acpi_suspend_enter() runs with IRQs disabled.

In v6, that early path no longer calls into the button driver. It only
sets plain flags in sleep.c: the existing pwr_btn_event_pending for
acpi_pm_finish()'s pm_wakeup_event(), plus pwr_btn_wakeup_pending for
KEY_WAKEUP. The button driver consumes the latter from resume via
acpi_sleep_pwr_btn_wakeup_pending().

2) Medium: IS_REACHABLE stub drops KEY_WAKEUP when CONFIG_ACPI_BUTTON=m
I agree this was a real functional hole. The v5 IS_REACHABLE() stub fixed
the LKP link error, but with a modular button driver the built-in call
site became a no-op after clearing the fixed power-button status bit.

Keeping the flag in built-in sleep.c and exporting a consumer for
button.ko fixes both the link issue and the modular KEY_WAKEUP loss. The
IS_REACHABLE stub is removed. The sleep.c flag uses WRITE_ONCE/READ_ONCE.

3) Medium: missing compiler barrier between the two stores in suspend
I agree. v6 uses WRITE_ONCE()/barrier()/READ_ONCE() around
wakeup_pending and suspended in acpi_button_suspend(). The same store
ordering is used when clearing them in resume: suspended is cleared
before wakeup_pending, with a barrier() between the two WRITE_ONCE()s.

4) Medium: race between clearing suspended and a late ACPI notify
I agree. v6 calls acpi_os_wait_events_complete() first so queued notifies
still observe suspended == true. It then samples the pending state and
reports KEY_WAKEUP before clearing suspended, so a notify that arrives
after sampling cannot set wakeup_pending only to have it dropped with
neither KEY_WAKEUP nor KEY_POWER. After KEY_WAKEUP, suspended is cleared
before wakeup_pending (with barrier()) so a new SCI takes the normal
KEY_POWER path.

I will send v6 shortly unless you prefer a different approach on any of
these points.

Thanks,
Baorui
