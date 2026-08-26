Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116C43F6613
	for <acpica-devel@lists.linux.dev>; Wed, 26 Aug 2026 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756012; cv=none; b=tH1sPN63FBWJu1Ogz4mBPoGOxa4qULEAqG+nTjFBuNh5ggC97r4snQAYdKDqqtv8VKvoy7QdgFcJRCFv5xHu2xrNwJr63QI9dJ7mUwCTuBi68yxBTrjTWHQog/Z6J3GExEm7Smv1T835CCZwL3/q4MR/i5MArPAY1TKNX9kOkH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756012; c=relaxed/simple;
	bh=vi3S6o/aCX6InBuOsTN52Sk60siVGMjgF514ONXxk5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFEE5cpaqZFYEZ2aIWWEX+TZ7w2JvmULWjknmRaGB0WZhDtYm1QRL6CKsyuovXCvy1FPDJLT5bc8Vm15hmq4Y9PqI4SQKF+vdYG3W9WaTimhOTbSFsCAfjAHb9zjWASGRp27DCpVpYUmV+MJ3mXBjz9uSnkfvB0WPXM1XbO3/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZXAWjUO2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X/640hB8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZXAWjUO2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X/640hB8"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QDv5mq4137669
	for <acpica-devel@lists.linux.dev>; Wed, 26 Aug 2026 14:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xgITQOLCNa8poMm2HFJ4MO8AYZclvE5sM2FJ5XQeS38=; b=ZXAWjUO2tCeY5iwi
	MWAoRQf0doU2qOQ52qZIaqbuhIWW1zYZY8f1F2/dZLVh6r/kYQ33yTHtGcfIybWu
	gvEPOHRjXMeWGI9HO7iWY/TytmwvQdlDuKQdEa6RzuG2lIK/I5Gq1fXS0u8pxhuo
	7U9an6EY2n2ZnldTRjEN5iLiZ80LHC4nmA/gPREAAjXmP3bVHCI6Btbl75nj+Dex
	EGoFVBCwwO+DvjGuw0ZVb8VOtmtd8wpSfNLxru2akPB0QI96nQrj6dRk7DUWG1L/
	UFvLOIBVv1328lLjlkq+Gx8kakdDia4bHESmloC9z3yHNAh7U+Dxgy+9LP1nY5K8
	LkoopQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uthsqm9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Wed, 26 Aug 2026 14:53:22 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90284139cceso20232176d6.0
        for <acpica-devel@lists.linux.dev>; Wed, 26 Aug 2026 07:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787756002; x=1788360802; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xgITQOLCNa8poMm2HFJ4MO8AYZclvE5sM2FJ5XQeS38=;
        b=X/640hB8GuZQQUB8ATA0rc8YhpXYH/ZZYTUxRyps3Z+HyChrl4zcf1vElKCXM3IjZl
         3lWWG3viVBlo7/1V5NbRtbtXMU+KlNljltWzV9KaFnu8Du0vvxyJtd1IzeEPHxKZ9o6T
         oQbHgVfA6lf3TIBYS9LyzDFka4n4g6+29njaOYFxMNDJgMymPLaK5ednEzrhM5wZQN8Q
         Nd+yGu5KTzwaKhVmtVlcqwb7PpDFVxVhHK07cxNnyU0thbzcsPVaQb/Q+2Ck1DQGfimW
         VU90J3Pw8FWtm3kiOwOw3bhId8XsonBXM08cRpHXL7aIrhpS4I19w8uKYtPJ2u5/1l+f
         /XWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787756002; x=1788360802;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xgITQOLCNa8poMm2HFJ4MO8AYZclvE5sM2FJ5XQeS38=;
        b=OEGhkol2Mqw7foUG+fmvY71KvybDNSxw0m419dxMBfj7I1KVfJGa7rNYUOyqvv+nnt
         I1mPNTbem67cSCOR2THOT5id3RFJEAeYAnLo/JAcLm7QsXlAKwfLuO9OvII5xHBXWSAO
         Epkk+LZBs1DLDVC7hH4pgdZhnoqgdYcw/iJvOGTT03FAHVzqXd1/xRCcTi066FNTUzr0
         L+lBWM/rul2vZYTZ2XVv/Vp8Qd03eG7/hdl/8SrAYVxi7b5tjNGlqKjh+Q4DC+nVdvXo
         PAAmjaQmwGfgvaed/YPZNmQnQh9a7Um7S1Fl8Q0rJkKfX0RUZiV2oX4BhedQIwZj4W79
         IByQ==
X-Forwarded-Encrypted: i=1; AHgh+RqE7w63LhzJE75ptBrK9hFv4cegeHlexIE4HnO6AQNfPhq6tl1+uOfwak6fiuRU42psg9fgS0doXzcm5Ro=@lists.linux.dev
X-Gm-Message-State: AFuF++kGD/i31F3m9JZR0e/gZA8GwidSOt5xPb9kqyM/3DEzQdUQ02cz
	6Y/DKi4d2MZY6yGOj24XTx7Ghtk4uTpilp6Cgp8qQzyG5xShTw1RPjZGra3QsJs7KDn23919UmZ
	EPALS3ibqJ6KsV5VfCgADIl7m6Eu0GT7ux86Jhv1QvfjwiW8iKTBHMX3BppzywznUzhg=
X-Gm-Gg: AR+sD13AYYM5YJmWCmrK2OfRb+sJ0YSYsIWuMx+gU62fpvVzuX7Loq+xv7nhb9yieKj
	9qLIrViyzDuWuvY06wqt+Y2cneDpAw2Z/0cxbFDGWseTLIpTj4SygislNm/Uld5n9G0zxLEOYjB
	xBtPegmxk5eAPPoOJlhMOL9iZ+qdN2O0gMMahc+K8TrYzZaSh+zMTBUXQpJiL0JkVpYEN9GrBDI
	nCb36ObskCCCuG9E4MV3VbSnOAXtXhTRGNhNO5pZMui/4kFXmA5jYggCBDjhvmDbjAjr8/HnxiJ
	Z4Lyy0e4WWX5dgZjHAz0r5K36/RyM8se5cCoGXuTG13EYALb1m8SAh7sV6bEuLCXa7vj7ZQ326F
	tC7FKsZLLC3Xl0ei+MCIxcY5ASmY=
X-Received: by 2002:ac8:6f05:0:b0:52d:d12c:3ee0 with SMTP id d75a77b69052e-52e2ecc086fmr172470071cf.11.1787756002069;
        Wed, 26 Aug 2026 07:53:22 -0700 (PDT)
X-Received: by 2002:ac8:6f05:0:b0:52d:d12c:3ee0 with SMTP id d75a77b69052e-52e2ecc086fmr172469401cf.11.1787756001627;
        Wed, 26 Aug 2026 07:53:21 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:dfd4:a0a3:2df2:7724])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28dc3f5sm2972592f8f.21.2026.08.26.07.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:53:20 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com,
        mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org,
        laurent.pinchart@ideasonboard.com, linusw@kernel.org, brgl@kernel.org,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
        nuno.sa@analog.com, andy@kernel.org, dmitry.torokhov@gmail.com,
        hansg@kernel.org, ilpo.jarvinen@linux.intel.com, W_Armin@gmx.de,
        ukleinek@kernel.org, fabio.m.de.francesco@linux.intel.com,
        kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org,
        pedro.pbg@usp.br, paulmck@kernel.org, frederic@kernel.org,
        kees@kernel.org, saket.dumbre@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpica-devel@lists.linux.dev, Eliav Farber <farbere@amazon.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 00/13] notifier: add device-managed registration APIs and convert drivers
Date: Wed, 26 Aug 2026 16:53:17 +0200
Message-ID: <178775599400.65906.5565986908119438731.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260816060648.4030-1-farbere@amazon.com>
References: <20260816060648.4030-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EMA2FVZC c=1 sm=1 tr=0 ts=6a8efde2 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Oj9lYo1IyMao6333VE4A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: DZBK1CANmZWGvFPWSsTfun5vHIfYP4-Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfX+k59a7CeH4/c
 7vZsPvWDFRMhnUMzAobk22oxD3F61bOrNDUMhTzDhxkgzpTzPR2ldcttaviqK50ZTVq7401OlTg
 6gnupIU8WPOagY7FplpPXzKD8OxJqJ+iw4RosTbUdb8913DOjhxsO2kw88fVumiPaW2qunH3po+
 k5PLrN7QhEwTJ/tO4Mt7L0mniBV5Xv5oS1LgXWdyXMDk5yK5NR0yiAnPt4xEwb95MG0ZVhwyAGT
 nfyrbGv+wOTQhj/6z75NQI/BLSHdWsZAoBR+StEyITszkmkYNNwMzmCKaVtFQYSox8NOyhVz3N8
 klj55Ta9gHGPuRBBKim8Rv+C74MZ/iseCnwtolav6OJYC2DG0m2y9fgt0K7Ztd2JfCVpkrjDKCt
 FOLUJmUrNw/qVtdaKia4POUlgVyXd5WE/b+3VMOWP9eGm3OdAzCwEAGu8dUyaiHtrCCiwJQk6pp
 UVrMla6H5W5/k69ZDZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfX4z4cNNmH6RGL
 eHZ4sacwJ1MrLFvgTOPioBleIwRjEfmnkCzAl3mF8kXq1W4AiCuoyQgoLaBCyCeXanOM2yFxkB2
 JWAu/sRnjlW0jKOfNjCK8neJO6xFR00=
X-Proofpoint-GUID: DZBK1CANmZWGvFPWSsTfun5vHIfYP4-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1011 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260124


On Sun, 16 Aug 2026 06:05:59 +0000, Eliav Farber wrote:
> Many drivers repeat the same boilerplate when registering notifiers with
> device lifetime:
> 
>   1. Register the notifier with *_notifier_chain_register()
>   2. Check for error
>   3. Register a devm action to unregister on teardown
>   4. Implement a per-driver static unregister callback
> 
> [...]

Applied, thanks!

[05/13] gpio: adp5585: use devm_blocking_notifier_chain_register()
        https://git.kernel.org/brgl/c/870f46a42afdc65d39587d2c56cf35eca294d201
[11/13] gpio: eic-sprd: use devm_atomic_notifier_chain_register()
        https://git.kernel.org/brgl/c/32390690610190f63a31f92ca555077f7861657c
[12/13] gpio: gpiolib-kunit: use devm_blocking_notifier_chain_register()
        https://git.kernel.org/brgl/c/df6501bf6fc4b16c9f502a7ab8e785ec91f3f7e3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
