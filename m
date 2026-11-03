Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739654;
	b=ymNTFBSCp1n/Fx+bN/jH/ODwtoMsAmZFdHYeZjmv2BM7u6mGff22ZSBx7wvsm589FnM6
	 ClsfJ3lj4VSCJiKugG7DoxYxWWmZHGbrtS2XdcTR5C34vFILq3a43blXes+b0y19xi5lS
	 bdcxmouLBDsjQJ53ne2NCS4ZArM8WlbiHuID1Md9UfVlK5dWXi6gfWgBtev0zbljJOHqJ
	 SzxH9gDPa8xk597qFgyrC9RTOBDPbWdkmXHvV7z9OtiywRwImYUOrKJXM7N5V6SVkJrIX
	 3Mwq4bLbGty5neHqvuZB3aCqGEvHjyC9UohMC6bVwfPb9uifMDwjozKkR6rpGKHbMag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739654;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8+TGSDQ9SyPrcH/PQA7dWzaDsqGof4ZchVSIqxBGMHE=;
	b=kB5SatZHZHLeKXGcJiYv9jSurWNTAvGlo9jnXyw1iGBMyMt09smhw2VgfVYQ6F4xJeR2
	 CZROEyDkFHaFTDl1ZJrtQiRmWly0xvt3ugaQD4cqaJtatAzg2HsIcLyW4uFBZgs7vvcdm
	 wGgR0sZSo6tny7XVrmB7+PAnRq4tX1GfLKTJ6VIKD+VjqgyatDjBBVE+TxWWXtb5mxYyK
	 euTkIR0k23rthWSFzrjm54a1Mmd/BLTtFMMNIvAEjS1UV0BzFaznU1h6ablQStLORlKpj
	 xkd8Ablh0d6xIQsOLKZe++eKFkKXe2RBggvmMWRwMW6bsu75CeSix9MdDLiQ9eX3zKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DQDZ6Ikd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j1BiklEU;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF704606A336
	for <acpica-devel@lists.linux.dev>; Tue,  3 Nov 2026 21:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF704606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DQDZ6Ikd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j1BiklEU
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3IYxta3675755
	for <acpica-devel@lists.linux.dev>; Tue, 3 Nov 2026 21:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8+TGSDQ9SyPrcH/PQA7dWzaDsqGof4ZchVSIqxBGMHE=; b=DQDZ6IkdTD4TfR4h
	QABB8e7VWCWMVOZKatz5cG2ZupT8OhMFcFFMfNvjLbnU2huxsEnt9PzMbYcmwcKM
	rcXOmWW9SJO1ALJ4CZePlEKys80gzfsq2L2grwlmh8AUlKdVFXWJir5s4L6f0XDE
	EUukTfuK7BC61i0YYggix5dQibhKnM6eZNfv4Vu/fgiZ+J2DUHawdtOILn+DByLj
	UzT2IVNmZdakkqpm6UABaWZwMTxa+cmy0E4TEJNLcGvFrCN1x/YAsGJSh/3sOklz
	6liZgZJpwvdrivGuzDimPxa0mduchuvgSs0uBLsNzGIkFNKmnm4941/e76DqSYCO
	k87QCg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqhyphm0d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Tue, 03 Nov 2026 21:00:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36a223755e4so17661204eec.0
        for <acpica-devel@lists.linux.dev>; Tue, 03 Nov 2026 13:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793739646; x=1794344446; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8+TGSDQ9SyPrcH/PQA7dWzaDsqGof4ZchVSIqxBGMHE=;
        b=j1BiklEUV0zSBpXEDoFvA3UvSPnRBomrD+JZlecpn29cPg4AdTXl6IjEUMBZWZlTf4
         HuBxfS8oWgoXplRDfkqrLaULzcSx2y8jEdf2jsXO1vTYLk3RVlt2umzFQnmBmZSTLO7P
         E+R6myk+s6sjzx229TbvQ2pW+pOPGVqTPZ/NMOBnkdFyVEUQcoM8Fm/tMuSYhGd2oJrS
         Qy9MpyJuAi7qSZnRqzecI7EFrBpRoU/nqs4eZo8BIl/w6tnFhJm5Jf5gJAJSQlKNEJQS
         d+2ne6IEHvAo8HB9gQi0kn+21HBV6QYN8gglL1VCN1TpJ3gR2/eTDr0JR/heH4uJV6n4
         YsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793739646; x=1794344446;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8+TGSDQ9SyPrcH/PQA7dWzaDsqGof4ZchVSIqxBGMHE=;
        b=jylII6ObFeyBHEKcdfonfKO3syCNZbHE42imwdexnMFz2H/sTr763NuVIwMG5bQwkV
         htTm1GEeRwPC1uwOEA3BUYHXoAH41wKoiYDhoHlmO0mIf7T4GXr1fCacT+lMpgO8q+b7
         vCVuHxQHSn9Q61TtaOvjwhqqu5iV2FI+nEwFjK4mPEmoqTLVA0yLu3kHvKQc+Atcf1ZQ
         xSIHjkdaGvNmuqe2Cx5CL45T6drJZ9gbe3vGa01JzZTimrHJHs+yNoZUxu+MysNOCwRF
         3PAvebAhGuEmK3PLoCEHbfxQWCKwsdnal8JoRlV0EWi4XmoraW5Ci5z2hwxiLFua3BAa
         TI3Q==
X-Forwarded-Encrypted: i=1; AKwUvBy2lzD8t9Bhfk25djoSBSQ/zjUhRcblOx5L539SBunzp8cyCqYiribST9pc5uxQIj5v4aT3L5a+pvTft5U=@lists.linux.dev
X-Gm-Message-State: APuU4Z95yGvmEtTM5AUsRCPq/CvgpN+YvPgjMpdiXMQUjm9/EmTi25qt
	t0lXYuEvX8jwkahajpYAVnDOpG7+jZ+RCUG7C5DtKEgcFd/KlN12DJeprWE3oQRihCSyMlHdA8G
	YwL70xrVSGxkpnrQiOPteyaslwDrWDPIA8NEsJnC/VzXh/Vzffng4JKgJlTtsbQPkCQA=
X-Gm-Gg: AYBFou2otzF9Zwooh8WGu2okCVP6cTkq6xn/QrU9KFYgtdfzU3+8fFe2cqP7P13fO3u
	h0tJOcRmftOcls2SyGWv9xW9TrJSECKc7qSx5IYOL4X1NtYtjxoFIGifFBKlpseiTAZDLFXqbx2
	CnfTyMAlrSfpUwegiDwNQFOP2aMPxPk+mI/hiJzNSayp3LKotLqxBRV20T2UbiKQpcFgznKpMoQ
	lFc4d92M1JmUbKN5MXJxG4JMgzBURPSw2bBMkwj7LIgoMhh+VzIvI6a8kjBibKwirpcM7nbCAUj
	OEI56QF+LYdmmZJgiqsN9rrA5fvkcgjc2hnwPbMlyp+eaJUtTt79rPlIdTavTpSBfJ8B/OAcKyv
	y6EZZOkS2zzYgZvH2NcHMkBJxvcv52kx89htURXx7ghWJ61jd/JiOd6CZGe2V9UxQnJws/N+/ga
	TtEeHaskDu6fDbcN+c+KukDo2diA==
X-Received: by 2002:a05:693c:83cf:10b0:36a:1427:3933 with SMTP id 5a478bee46e88-36a4236e7bemr23432971eec.16.1793739645655;
        Tue, 03 Nov 2026 13:00:45 -0800 (PST)
X-Received: by 2002:a05:693c:83cf:10b0:36a:1427:3933 with SMTP id 5a478bee46e88-36a4236e7bemr23432898eec.16.1793739644957;
        Tue, 03 Nov 2026 13:00:44 -0800 (PST)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm706469eec.24.2026.11.03.13.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:00:44 -0800 (PST)
Date: Tue, 3 Nov 2026 13:00:38 -0800
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
        "Rafael
 J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Tony Luck
 <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Hanjun Guo
 <guohanjun@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shuai
 Xue <xueshuai@linux.alibaba.com>,
        Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>,
        Pawel Chmielewski
 <pawel.chmielewski@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>,
        Dan Williams
 <djbw@kernel.org>, Terry Bowman <terry.bowman@amd.com>,
        Ard Biesheuvel
 <ardb@kernel.org>,
        Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 2/6] cper: add Memory Error Section 2 structures
Message-ID: <20261103130038.00000f77@oss.qualcomm.com>
In-Reply-To: <aunhE1aeSfk6YDgj@gmail.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
	<20261019203915.2019037-3-pierre.gondois@arm.com>
	<aunhE1aeSfk6YDgj@gmail.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4MyBTYWx0ZWRfX1NUOO2edIJF0
 tcRbK/rJtdphgqJKD8KwMjoeubjTEflFOxvPv4nYVmeHVp/IPnGVSUJmUTVyfjiE8nwkToekNhE
 72JrbC3NDp9QkUxoWAnoiX9uOg82T2k=
X-Proofpoint-ORIG-GUID: xIASif2uWy08YnHTq56jQG5KlexVY0wS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4MyBTYWx0ZWRfXy0Al6ujfikD3
 +cF/NB2nLuVtVyMtEBoInDlneviQ4q0zo+eOQ7LWIrQE16dEgdqYP77oCRZzQtUszBKN6OZWqTo
 HKZJJs8dp61afefCrCTk7CmEbEf4le33TtQRYIiWEInw7kiHHYsF3YtXLUeYs2tc3lHAAMNcyoP
 IrlaAqubUNF2MattmkoBj/GFk1sA0SjwuqlWtLwnwQy1bo5cnhvupXHLc5L5cOGe77C5ZQvx5TP
 SpCCwQEhgMuU12+uPGLmDS9+03hhdRyKYZCInzWKtgl7+TEDpRIq1YWSgdEL1plERoqS1GR2A3U
 zD1li8Fnv1X10xP5p42/3uKSqtO2FZAXuE15VPrXvmz9701t1z92VN0MKAENl2RdwicoIKxbdDq
 +//pYAEdI+SE9krrUgoF8xoBV76e+QrRPf2chTyxMFxMagoi/YREnD4VAbzzpYDuX3FVhibfgNU
 NZOxu3VllqD/bJP3nHg==
X-Proofpoint-GUID: xIASif2uWy08YnHTq56jQG5KlexVY0wS
X-Authority-Analysis: v=2.4 cv=T94Z3PKQ c=1 sm=1 tr=0 ts=6aea4b7f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=xNf9USuDAAAA:8 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=bZ_CbDB1LfDrNmofISYA:9
 a=CjuIK1q_8ugA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030083

On Tue, 3 Nov 2026 05:27:02 -0800
Breno Leitao <leitao@debian.org> wrote:

> On Mon, Oct 19, 2026 at 10:38:41PM +0200, Pierre Gondois wrote:
> > Add CPER Memory Error Section 2 definitions to the CPER headers.
> > 
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>  
> 
> Reviewd-by: Breno Leitao <leitao@debian.org>
Typo.  Just in case Pierre is using b4 or other automation!


