Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89777330B26
	for <acpica-devel@lists.linux.dev>; Fri,  9 Jan 2026 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949384; cv=none; b=W0salc+lYoVb0ay2xgs+Tr+LfgDHuVofKRu8kpVwtmIBzwTNaKyvmimxU8PCP7lfyp5EK4OK+1aZPcm8Cc7epEKwTYONwjNeWQ8Bf1wXO8dvvy/Yzoytgn94T6Zg8HyKfm16i1BwQysO3+I7vklmYMAJdPbQAOVRThsk+bTEIyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949384; c=relaxed/simple;
	bh=lI3vWvKnic19vdOGJ+3N9CWmKDFS54Hz3RuRyiIM/kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwky+jNg4Lu0QLFdpCKy2We2/QKZY3Rz3OnLZjd0iW99OxHixdgEx/NBB+YpSFJsGbpGP+FIjX4JCWOu1TAXi3dX4gKCmxszmd5h17E5fWzn1D0cgadsBu2Bi4jDQV+S15aTMdvNAWG8eucObwWERp7yMdx4H/aOCAiST+8gU54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VfLTVZBP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=POWKHKZe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VfLTVZBP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="POWKHKZe"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6094t2YE2706815
	for <acpica-devel@lists.linux.dev>; Fri, 9 Jan 2026 09:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7thsI61iVOv
	UNh22HCK2qAPj5NTxS3xwSRoZruWKBf8=; b=VfLTVZBPEPJTcnh8S3GgsofRT+w
	K2VnuXxT19d5er1dKE9/9I/YhEwfzUD5geAJdKo7jmY73ZnBBBrRp6JTHEuRfcTe
	KmhB2Wi1azzpWV7B01AYUJzcW6U5Ofjz6uucaD+OhfAw4IFouAbN5NaD6PUcdQpS
	6GkKhzUzOTfO21wj8QzAR6HeMtqFoPbRb9Zbwr/otMxGvh1fGgh5xFMZRDb+MxSm
	cOHUvwY5QHy9ffHxrjUBCHJgLd5QR2TPGF2sdGhkfF3c3WCJoDhD3FftveWjw/TR
	oLv+KdDFX2nM9zSkGzPMmMX/3OZzZaImIHhdt0vmQfdHn6WrUzozXtyegvg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj9hquy4q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 09:03:00 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b952a966d7so7575490b3a.3
        for <acpica-devel@lists.linux.dev>; Fri, 09 Jan 2026 01:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949380; x=1768554180; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7thsI61iVOvUNh22HCK2qAPj5NTxS3xwSRoZruWKBf8=;
        b=POWKHKZeeKrt1mBVKgvqGW9U9wse4jn+17GaQ7taiEQd/WTLIgp1jInUT2+ZWV0iCb
         yhtX3gyJuxR+riEy5UsTtPpkycpGR/hQryAchbmNoDx78G8J4K5QrEzNAEvzNbhZbzVE
         JDPrJJusxcFWCGbHFiON1DT6e8mEKpWum7kLePRT9yEMkgOJWO+JY1EDzoJ5wd8+jDCv
         G4bdCIWV7Vs8GTAuMqk39bd9EUmpwsutASujUgobJ3CFCHd1IX540cA7xvYIJX9JQcgN
         vmY6hp31Dab0wLfgG0UlL+91FxhGUJI4Llds/KtevGu9z+QvE0DDtn5L7c4neoA8DtNO
         rmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949380; x=1768554180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7thsI61iVOvUNh22HCK2qAPj5NTxS3xwSRoZruWKBf8=;
        b=V/XGEy4/FbDvxRcky2US7oxNgEuVX48Icq5TeYF4DpOsfstBLAf522oP3JFZU1faaw
         LTMI70GsJJj2QTLdQEMiGH0I3yRN1LKkeAvPKZBpN1w5OsuqE8toTtsMUAYMRZ9co5c9
         4AUPMwCHG/aoKNaLeFXuVsCePdwrZ77lAplNN4RMkzlJZxT/u/AyCxyDf9Eg+0omnnY0
         bn2YhgUhmAQbTZkYu9irucxGN44qSLgZ6JK+u8xTKldWN6ZVYmec0ldo0ZlyjMEcOB2P
         4k0yeW5vOCNIl8WkJe7zoHHGn1k7l2SDJ61e6F5/Gec/IXX8EfsjmX9iuexIJk/xZk+E
         LT/g==
X-Forwarded-Encrypted: i=1; AJvYcCXqV9+dZGxOOjztHvxplgs1zMjU870yKhLyCy3O5kySiyMgKA+/C9Mlc7/Np1ntX5Ag1vi42UnKobd5qXI=@lists.linux.dev
X-Gm-Message-State: AOJu0YyGfIEBm0z40i20nqI0ZF/lL4rdQivxcQYlM21TWse4ZyIQ9kmq
	100YNaeCqNw5iaoIr49sZ/uwYJRNnk3RtTcpyt3TF786VlcL+r1zBZUvgaBoAK5I/EQrqAJKtHZ
	BOvXGC0CrT+i6CAKNovjG743Bfn3CmEKspe3zPjY6ABhls/ZeZChXcARmatDH9PWRLdg=
X-Gm-Gg: AY/fxX4U7QwnCv+923lkYnKFvMtMZ/KHFn94x8ACZpMsct8CiifdMyPlZTIGPAtgHkg
	kLq7ESexuNLTQHekcdFH6bO4oDoBJMfLM2sXt+EXr448lRlvvaaO4x7KU6Vz/GYNrzu+vHJrULW
	4m40iqs1JgFvdtRQcdfNIUpHBf3igGG0SynXQ62dzwLaiz3tl00DZEFtpzq8LSHzAjEJwZ+jjYB
	SI4UqPP54nY9r8mwJP0zfgG1fefBbfJbZc4KMF2rchjBXbUQqZ0vtz1mA6XZ3pZn2an8RspFCz3
	8KWOF7+11F1Pdc+Q6+KKahjWxY1OYNK7EykvZtakJcdkU4xA1QpLIbll4o60EgolJPsVXbyROrT
	XhR/btSsUIHi4YtFnnHuMVygdmxVF0NdhduZ+xNUpTFSyfr8x7dRCjJ/OR0tna5cBmmb+j2TM2y
	tHx8bnJx2pRhh3IJ/hOn86SnOsw0H6WldIlQ==
X-Received: by 2002:a05:6a00:348d:b0:7f7:3749:d97c with SMTP id d2e1a72fcca58-81b7dc56e8bmr8974790b3a.22.1767949380066;
        Fri, 09 Jan 2026 01:03:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTMYGiUv7Wddy4gOxN3iVSD4nKGS7B9cg7aceUCQy0Uhht1CbC13+ZGNry/QY+i6KtaL7fHQ==
X-Received: by 2002:a05:6a00:348d:b0:7f7:3749:d97c with SMTP id d2e1a72fcca58-81b7dc56e8bmr8974749b3a.22.1767949379557;
        Fri, 09 Jan 2026 01:02:59 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:02:59 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 06/10] riscv: Add functions to register ghes having SSE notification
Date: Fri,  9 Jan 2026 14:32:20 +0530
Message-ID: <20260109090224.3105465-7-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GN8F0+NK c=1 sm=1 tr=0 ts=6960c444 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=2d44Z0_5zRK2QUa08RUA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: grQHSIRo8B0J3tCBrhzhJkZ3FeZkeAdU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfX/o5KtQH8HJ8J
 fNeDnMR2DHIdDH3B9B7ALCw1lTYlaaatbJE4hm68OPh3N0lYPyIZsYI3PUOjKgoHe9kdJzWUv+l
 FfeRE40m4q92GF99OU5Iz7zQKrOS/djH+yKv8sXnhaROhlaZSyvzuqz3M582+WO9reKYeL5BW80
 z5rKEoIsZEokY13QJ3yDDviara4gAENssiv1RoYtYQImLNESknDtmBTCIX7JYWqMBTM1KHkD3BH
 VbHPvuahqabU6MZa9EZJLxGHcDu183P02Z9RiOQFz1902m5oHFEmNIMeGhL0YH8m9+eaQ+E68U/
 rNa32x6NCJlI1Ee/CWihATdAAYyAvuU0gH0/B+wNJ/CsbrdTKCYQLle/HOdg244F1UZSBBKtG09
 4TanLARQQQKNN2JCPwdhq3jlvwVxhdNAmIjIu4N6LGB0qX/wg5UrFWCMITl7XKZ2IAK/hBIupFk
 IQDV1p1R3V3vKofXDZw==
X-Proofpoint-ORIG-GUID: grQHSIRo8B0J3tCBrhzhJkZ3FeZkeAdU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090064

Add functions to register the ghes entries which have SSE as
notification type. The vector inside the ghes is the SSE event
ID that should be registered.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 drivers/firmware/riscv/riscv_sbi_sse.c | 146 +++++++++++++++++++++++++
 include/linux/riscv_sbi_sse.h          |  16 +++
 2 files changed, 162 insertions(+)

diff --git a/drivers/firmware/riscv/riscv_sbi_sse.c b/drivers/firmware/riscv/riscv_sbi_sse.c
index c7f29b10cdfb..ee288a0c1680 100644
--- a/drivers/firmware/riscv/riscv_sbi_sse.c
+++ b/drivers/firmware/riscv/riscv_sbi_sse.c
@@ -5,6 +5,8 @@
 
 #define pr_fmt(fmt) "sse: " fmt
 
+#include <acpi/ghes.h>
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
 #include <linux/cpu_pm.h>
@@ -692,3 +694,147 @@ static int __init sse_init(void)
 	return ret;
 }
 arch_initcall(sse_init);
+
+struct sse_ghes_callback {
+	struct list_head head;
+	struct ghes *ghes;
+	sse_event_handler_fn *callback;
+};
+
+struct sse_ghes_event_data {
+	struct list_head head;
+	u32 event_num;
+	struct list_head callback_list;
+	struct sse_event *event;
+};
+
+static DEFINE_SPINLOCK(sse_ghes_event_list_lock);
+static LIST_HEAD(sse_ghes_event_list);
+
+static int sse_ghes_handler(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	struct sse_ghes_event_data *ev_data = arg;
+	struct sse_ghes_callback *cb = NULL;
+
+	list_for_each_entry(cb, &ev_data->callback_list, head) {
+		if (cb && cb->ghes && cb->callback)
+			cb->callback(ev_data->event_num, cb->ghes, regs);
+	}
+
+	return 0;
+}
+
+int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
+		      sse_event_handler_fn *hi_cb)
+{
+	struct sse_ghes_event_data *ev_data, *evd;
+	struct sse_ghes_callback *cb;
+	u32 ev_num;
+	int err;
+
+	if (!sse_available)
+		return -EOPNOTSUPP;
+	if (!ghes || !lo_cb || !hi_cb)
+		return -EINVAL;
+
+	ev_num = ghes->generic->notify.vector;
+
+	ev_data = NULL;
+	spin_lock(&sse_ghes_event_list_lock);
+	list_for_each_entry(evd, &sse_ghes_event_list, head) {
+		if (evd->event_num == ev_num) {
+			ev_data = evd;
+			break;
+		}
+	}
+	spin_unlock(&sse_ghes_event_list_lock);
+
+	if (!ev_data) {
+		ev_data = kzalloc(sizeof(*ev_data), GFP_KERNEL);
+		if (!ev_data)
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(&ev_data->head);
+		ev_data->event_num = ev_num;
+
+		INIT_LIST_HEAD(&ev_data->callback_list);
+
+		ev_data->event = sse_event_register(ev_num, ev_num,
+						    sse_ghes_handler, ev_data);
+		if (IS_ERR(ev_data->event)) {
+			pr_err("%s: Couldn't register event 0x%x\n", __func__, ev_num);
+			kfree(ev_data);
+			return -ENOMEM;
+		}
+
+		err = sse_event_enable(ev_data->event);
+		if (err) {
+			pr_err("%s: Couldn't enable event 0x%x\n", __func__, ev_num);
+			sse_event_unregister(ev_data->event);
+			kfree(ev_data);
+			return err;
+		}
+
+		spin_lock(&sse_ghes_event_list_lock);
+		list_add_tail(&ev_data->head, &sse_ghes_event_list);
+		spin_unlock(&sse_ghes_event_list_lock);
+	}
+
+	list_for_each_entry(cb, &ev_data->callback_list, head) {
+		if (cb->ghes == ghes)
+			return -EALREADY;
+	}
+
+	cb = kzalloc(sizeof(*cb), GFP_KERNEL);
+	if (!cb)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&cb->head);
+	cb->ghes = ghes;
+	cb->callback = lo_cb;
+	list_add_tail(&cb->head, &ev_data->callback_list);
+
+	return 0;
+}
+
+int sse_unregister_ghes(struct ghes *ghes)
+{
+	struct sse_ghes_event_data *ev_data, *tmp;
+	struct sse_ghes_callback *cb;
+	int free_ev_data = 0;
+
+	if (!ghes)
+		return -EINVAL;
+
+	spin_lock(&sse_ghes_event_list_lock);
+
+	list_for_each_entry_safe(ev_data, tmp, &sse_ghes_event_list, head) {
+		list_for_each_entry(cb, &ev_data->callback_list, head) {
+			if (cb->ghes != ghes)
+				continue;
+
+			list_del(&cb->head);
+			kfree(cb);
+			break;
+		}
+
+		if (list_empty(&ev_data->callback_list))
+			free_ev_data = 1;
+
+		if (free_ev_data) {
+			spin_unlock(&sse_ghes_event_list_lock);
+
+			sse_event_disable(ev_data->event);
+			sse_event_unregister(ev_data->event);
+			ev_data->event = NULL;
+
+			spin_lock(&sse_ghes_event_list_lock);
+
+			list_del(&ev_data->head);
+			kfree(ev_data);
+		}
+	}
+
+	spin_unlock(&sse_ghes_event_list_lock);
+
+	return 0;
+}
diff --git a/include/linux/riscv_sbi_sse.h b/include/linux/riscv_sbi_sse.h
index 84165cb5f2d0..be0c9ad0a00c 100644
--- a/include/linux/riscv_sbi_sse.h
+++ b/include/linux/riscv_sbi_sse.h
@@ -11,6 +11,7 @@
 
 struct sse_event;
 struct pt_regs;
+struct ghes;
 
 typedef int (sse_event_handler_fn)(u32 event_num, void *arg,
 				   struct pt_regs *regs);
@@ -24,6 +25,10 @@ void sse_event_unregister(struct sse_event *evt);
 
 int sse_event_set_target_cpu(struct sse_event *sse_evt, unsigned int cpu);
 
+int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
+		      sse_event_handler_fn *hi_cb);
+int sse_unregister_ghes(struct ghes *ghes);
+
 int sse_event_enable(struct sse_event *sse_evt);
 
 void sse_event_disable(struct sse_event *sse_evt);
@@ -47,6 +52,17 @@ static inline int sse_event_set_target_cpu(struct sse_event *sse_evt,
 	return -EOPNOTSUPP;
 }
 
+static inline int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
+				    sse_event_handler_fn *hi_cb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int sse_unregister_ghes(struct ghes *ghes)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int sse_event_enable(struct sse_event *sse_evt)
 {
 	return -EOPNOTSUPP;
-- 
2.43.0

