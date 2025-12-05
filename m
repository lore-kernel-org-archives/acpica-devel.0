Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75E13019C3;
	Fri,  5 Dec 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764929986; cv=none; b=dcGu7l+sepOxxnY7tJfbmFqzEBV4q3vAoeAEkPD4MTmd+lDoRHLXxxhBRpiO+ktptopolBJodk+u4/ABhmgCsCVILTj99yQqKTcdZcpVri9FXzNmn1yC1QNXyzbKxgCuKE5ceRO+VNUTy/JHZNMAk+FZAZBj5CT2b3YELEWoDGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764929986; c=relaxed/simple;
	bh=ib/gXzDeZgu4FUShYtzIvwmGMZaUQaAKTv4WQMFhflg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lfpHGeS3MgTlZoGyyf7Z3ihoBROEkGc1C5QGe4ZVxFpPldkQqdhaihdW6fgC4cMgOPm0ElkqVu1zwodiss1/bRdPKJzUcIzETBE4PKseJf+W3ZAK2FwsUFzkfdCPt9VGmZjUbuQMOHDbgSzJO2Y9RtdmpDMG9UeNufnMlGce0hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=EY2EmnZa; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="EY2EmnZa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764929971; x=1765534771; i=spasswolf@web.de;
	bh=Hu6ZisbcUmOSh32SfFnw6/u6mGFtMWRMVLqKx6Oixhk=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EY2EmnZautb5Nap0pqGqI0WJQ08OCuOaUdxU89TpbeKvajAJ6FQuQrY2BpG1tYPu
	 gwUD/LS7Bw4QkL6xMeQa2tavojJfSawY4zc/dWBT/dUiWhWOS4rxIomrgoplBarKs
	 HEfRKAqs29A82KzD+SjhXawO81oFWK4mVdY7zEZsnKzeel6mHIe1W6tfqmdtoumZs
	 GtchRyL59pfGjzqdlerMXbKADiYXxOVD7eCApTdM7EpOiIoX9jHUlhgfs9Zl8YCQj
	 BdOqnbWoljCQOhDVH3O+5YhTu7hwOgQbhTKr5Qm1gjJBvd0XiktNi5+f1okxvLKF7
	 QMHXpdA6g7o70FEJtA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwA1O-1wJHlB43aW-00zaBK; Fri, 05
 Dec 2025 11:05:18 +0100
Message-ID: <ec99725df78fdd0fd9d4398d00fdebb84cb38ee6.camel@web.de>
Subject: Re: Crash during resume of pcie bridge due to incorrect error
 handling
From: Bert Karwatzki <spasswolf@web.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "Mario
 Limonciello (AMD) (kernel.org)"	 <superm1@kernel.org>,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	regressions@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, 	acpica-devel@lists.linux.dev, Robert Moore
 <robert.moore@intel.com>, Saket Dumbre <saket.dumbre@intel.com>,
 spasswolf@web.de, Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 05 Dec 2025 11:05:16 +0100
In-Reply-To: <CAJZ5v0gfRmr=q=SYLSWO9px6uUq5ZPQxJ=peo7JHDP926niB8A@mail.gmail.com>
References: <20251006120944.7880-1-spasswolf@web.de>
	 <8edcc464-c467-4e83-a93b-19b92a2cf193@kernel.org>
	 <4903e7c36adf377bcca289dbd3528055dc6cfb32.camel@web.de>
	 <4a8302a0-209f-446a-9825-36cb267c1718@kernel.org>
	 <25f36fa7-d1d6-4b81-a42f-64c445d6f065@amd.com>
	 <1853e2af7f70cf726df278137b6d2d89d9d9dc82.camel@web.de>
	 <f18bafacbd8316c9623658e2935f8fc3b276af64.camel@web.de>
	 <26bf82303f661cdd34e4e8c16997e33eb21d1ee4.camel@web.de>
	 <635b6cb19b5969bed7432dfd1cd651124e63aebb.camel@web.de>
	 <18e472a0489ee5337465d5dc26685cebaf7c4f8d.camel@web.de>
	 <3772b8f5-6d1a-403e-ad27-99a711e78902@kernel.org>
	 <0cb75fae3a9cdb8dd82ca82348f4df919d34844d.camel@web.de>
	 <ab51bd58919a31107caf8f8753804cb2dbfa791d.camel@web.de>
	 <0719d985-1c09-4039-84c1-8736a1ca5e2d@amd.com>
	 <3f790ee59129e5e49dd875526cb308cc4d97b99d.camel@web.de>
	 <CAJZ5v0iRaYBU+1S4rqYR7D6XC+rfQ2+0hgbodweV5JsFr8EEnQ@mail.gmail.com>
	 <b1fadb15d1869bde81315be7488c50dbbc9f7dbd.camel@web.de>
	 <CAJZ5v0iAJN4eTdp9S=CKbMnVn78R7UnBKbLjBTdRhHebE0i7dA@mail.gmail.com>
	 <8273a7755f90a3e41782f1d820dd9f0c22be78b7.camel@web.de>
	 <CAJZ5v0i2T7HpV4jN6NJk=ruBvjecPRU2PyuYf0_TSPQU6FZ5rg@mail.gmail.com>
	 <e807ca71fdef97c931fd9f92eda0f7551aa3ef7b.camel@web.de>
	 <CAJZ5v0heOKxk8=4kwXcRLFfKhxYBX+ze_Dc2w90xrM14jvCirg@mail.gmail.com>
	 <a3e1729912a94d10d7dd211efe837d4d6c7a3eaf.camel@web.de>
	 <CAJZ5v0gfRmr=q=SYLSWO9px6uUq5ZPQxJ=peo7JHDP926niB8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XjVvLQ27gkGkBmOxjgnqXswS31xITpv9Bf5mEjTER9fvGdTnTgJ
 4rPM7VtgbeYYEw+Hbq2oliMThIVDBuRIKt0lckXxrlVEEzCN4WCtWjTeBpicgL/shz6d508
 kdpyb/hmj8s5WgXJzzgC6ZPJLB3ALN+5OxCztujqESCu5eGrmGGwFaNZ+z41x5QfUcArlq8
 vDMxiptlCxSJYusSDJROQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uYsECJRqvtI=;5dDdS1lwBJGJHg3mNiup5mdIAWK
 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
 vt8/2vs+8spZfRO3++Of5itnHZabs

I've got good and bad news on this. The good news first:

I was able to get through a failed resume without a crash with the followi=
ng
changes to the pci resume process:

1: pci_pm_bridge_power_up_actions() returns -ENODV when pci_bridge_wait_fo=
r_secondary()
returns an error (pci_walk_bus_debug() is just pci_walk_bus() with added p=
rintk()s),
and also sets state to PCI_D3cold on failure:

static int pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
{
	int ret;

	dev_info(&pci_dev->dev, "%s %d\n", __func__, __LINE__);
	ret =3D pci_bridge_wait_for_secondary_bus(pci_dev, "resume");
	dev_info(&pci_dev->dev, "%s %d: ret =3D %d\n", __func__, __LINE__, ret);
	if (ret) {
		/*
		 * The downstream link failed to come up, so mark the
		 * devices below as disconnected to make sure we don't
		 * attempt to resume them.
		 */
		pci_walk_bus_debug(pci_dev->subordinate, pci_dev_set_disconnected,
			     NULL);
		pci_update_current_state(pci_dev, PCI_D3cold);
		dev_info(&pci_dev->dev, "%s: bridge failed to power up\n", __func__);
		return -ENODEV;
	}

	/*
	 * When powering on a bridge from D3cold, the whole hierarchy may be
	 * powered on into D0uninitialized state, resume them to give them a
	 * chance to suspend again
	 */
	pci_resume_bus(pci_dev->subordinate);
	return 0;
}

2. pci_pm_runtime_resume() has an early exit if pci_pm_bridge_power_up_act=
ions() fails:


static int pci_pm_runtime_resume(struct device *dev)
{
	struct pci_dev *pci_dev =3D to_pci_dev(dev);
	const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : NULL;
	pci_power_t prev_state =3D pci_dev->current_state;
	int error =3D 0;

	/*
	 * Restoring config space is necessary even if the device is not bound
	 * to a driver because although we left it in D0, it may have gone to
	 * D3cold when the bridge above it runtime suspended.
	 */
	pci_pm_default_resume_early(pci_dev);
	pci_resume_ptm(pci_dev);

	if (!pci_dev->driver)
		return 0;

	pci_fixup_device(pci_fixup_resume_early, pci_dev);
	pci_pm_default_resume(pci_dev);

	if (prev_state =3D=3D PCI_D3cold) {
		error =3D pci_pm_bridge_power_up_actions(pci_dev);
		if (error)
			return error;
	}
	[...]
}

3. acpiphp_check_bridge() has an early exit if pm_runtime_get_sync()
returns an error (pm_runtime_get_sync() basically returns the result of
pci_pm_runtime_resume() which is called as a callback in rpm_resume())

static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
{
	struct acpiphp_slot *slot;
	int ret;

	/* Bail out if the bridge is going away. */
	if (bridge->is_going_away)
		return;

	if (bridge->pci_dev) {
		ret =3D pm_runtime_get_sync(&bridge->pci_dev->dev);
		if (ret < 0) {
			dev_info(&bridge->pci_dev->dev, "%s: pm_runtime_get_sync() failed with =
ret =3D %d\n", __func__, ret);
			return;
		}
	}

With these changes I get the following messages in dmesg when acpi_power_o=
n_list() fails
for the pci bridge:

2025-12-05T01:58:53.260991+01:00 lisa kernel: [ T1772] acpi_power_on_list_=
debug 649: result =3D -19
2025-12-05T01:58:53.260993+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: pci_pm_default_resume_early 567
2025-12-05T01:58:53.260994+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: pci_pm_bridge_power_up_actions 576
2025-12-05T01:58:54.282032+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: broken device, retraining non-functional downstream link at 2.5GT/s
2025-12-05T01:58:55.282033+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: retraining failed
2025-12-05T01:58:55.282053+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: Data Link Layer Link Active not set in 1000 msec
2025-12-05T01:58:55.282055+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: pci_pm_bridge_power_up_actions 578: ret =3D -25
2025-12-05T01:58:55.282057+01:00 lisa kernel: [ T1772] pcieport 0000:01:00=
.0: __pci_walk_bus_debug 0
2025-12-05T01:58:55.282058+01:00 lisa kernel: [ T1772] pcieport 0000:01:00=
.0: pci_dev_set_disconnected: 0
2025-12-05T01:58:55.282060+01:00 lisa kernel: [ T1772] pcieport 0000:01:00=
.0: pci_dev_set_disconnected: 1
2025-12-05T01:58:55.282063+01:00 lisa kernel: [ T1772] pcieport 0000:01:00=
.0: __pci_walk_bus_debug 1: ret =3D 0
2025-12-05T01:58:55.282065+01:00 lisa kernel: [ T1772] pcieport 0000:01:00=
.0: __pci_walk_bus_debug 1.0
2025-12-05T01:58:55.282067+01:00 lisa kernel: [ T1772] pcieport 0000:02:00=
.0: __pci_walk_bus_debug 0
2025-12-05T01:58:55.282070+01:00 lisa kernel: [ T1772] pcieport 0000:02:00=
.0: pci_dev_set_disconnected: 0
2025-12-05T01:58:55.282073+01:00 lisa kernel: [ T1772] pcieport 0000:02:00=
.0: pci_dev_set_disconnected: 1
2025-12-05T01:58:55.282101+01:00 lisa kernel: [ T1772] pcieport 0000:02:00=
.0: __pci_walk_bus_debug 1: ret =3D 0
2025-12-05T01:58:55.282103+01:00 lisa kernel: [ T1772] pcieport 0000:02:00=
.0: __pci_walk_bus_debug 1.0
2025-12-05T01:58:55.282105+01:00 lisa kernel: [ T1772] amdgpu 0000:03:00.0=
: __pci_walk_bus_debug 0
2025-12-05T01:58:55.282107+01:00 lisa kernel: [ T1772] amdgpu 0000:03:00.0=
: pci_dev_set_disconnected: 0
2025-12-05T01:58:55.282109+01:00 lisa kernel: [ T1772] amdgpu 0000:03:00.0=
: pci_dev_set_disconnected: 1
2025-12-05T01:58:55.282111+01:00 lisa kernel: [ T1772] amdgpu 0000:03:00.0=
: __pci_walk_bus_debug 1: ret =3D 0
2025-12-05T01:58:55.282113+01:00 lisa kernel: [ T1772] snd_hda_intel 0000:=
03:00.1: __pci_walk_bus_debug 0
2025-12-05T01:58:55.282115+01:00 lisa kernel: [ T1772] snd_hda_intel 0000:=
03:00.1: pci_dev_set_disconnected: 0
2025-12-05T01:58:55.282116+01:00 lisa kernel: [ T1772] snd_hda_intel 0000:=
03:00.1: pci_dev_set_disconnected: 1
2025-12-05T01:58:55.282118+01:00 lisa kernel: [ T1772] snd_hda_intel 0000:=
03:00.1: __pci_walk_bus_debug 1: ret =3D 0
2025-12-05T01:58:55.282120+01:00 lisa kernel: [ T1772] __pci_walk_bus_debu=
g: ret =3D 0
2025-12-05T01:58:55.282122+01:00 lisa kernel: [ T1772] pcieport 0000:02:00=
.0: __pci_walk_bus_debug 1.1: ret =3D 0
2025-12-05T01:58:55.282124+01:00 lisa kernel: [ T1772] __pci_walk_bus_debu=
g: ret =3D 0
2025-12-05T01:58:55.282126+01:00 lisa kernel: [ T1772] pcieport 0000:01:00=
.0: __pci_walk_bus_debug 1.1: ret =3D 0
2025-12-05T01:58:55.282128+01:00 lisa kernel: [ T1772] __pci_walk_bus_debu=
g: ret =3D 0
2025-12-05T01:58:55.282130+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: pci_pm_bridge_power_up_actions: bridge failed to power up
2025-12-05T01:58:55.282131+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 916 retval =3D -19
2025-12-05T01:58:55.282133+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 922
2025-12-05T01:58:55.282135+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 937
2025-12-05T01:58:55.282137+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 947
2025-12-05T01:58:55.282138+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 950
2025-12-05T01:58:55.282140+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -19
2025-12-05T01:58:55.282141+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T01:58:55.523974+01:00 lisa kernel: [T192257] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T01:59:21.896980+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T01:59:21.896986+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T01:59:22.141965+01:00 lisa kernel: [T192400] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T01:59:51.903964+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T01:59:51.903974+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T01:59:52.153973+01:00 lisa kernel: [T192554] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:00:21.915965+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:00:21.915971+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:00:22.161971+01:00 lisa kernel: [T192706] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:00:51.922981+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:00:51.922988+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:00:52.175975+01:00 lisa kernel: [T192899] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:00:52.931997+01:00 lisa kernel: [T180476] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:00:52.932008+01:00 lisa kernel: [T180476] pcieport 0000:00:0=
1.1: acpiphp_check_bridge: pm_runtime_get_sync() failed with ret =3D -22
2025-12-05T02:01:21.933961+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:01:21.933965+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:01:22.172962+01:00 lisa kernel: [T193054] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:01:23.001998+01:00 lisa kernel: [T192396] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:01:23.002009+01:00 lisa kernel: [T192396] pcieport 0000:00:0=
1.1: acpiphp_check_bridge: pm_runtime_get_sync() failed with ret =3D -22
2025-12-05T02:01:51.942980+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:01:51.942986+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:01:52.188969+01:00 lisa kernel: [T193209] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:01:52.958995+01:00 lisa kernel: [T188262] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:01:52.959009+01:00 lisa kernel: [T188262] pcieport 0000:00:0=
1.1: acpiphp_check_bridge: pm_runtime_get_sync() failed with ret =3D -22
2025-12-05T02:02:21.951971+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:02:21.951980+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:02:22.205974+01:00 lisa kernel: [T193359] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:02:23.117988+01:00 lisa kernel: [T192396] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:02:23.118000+01:00 lisa kernel: [T192396] pcieport 0000:00:0=
1.1: acpiphp_check_bridge: pm_runtime_get_sync() failed with ret =3D -22
2025-12-05T02:02:51.963970+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:02:51.963976+01:00 lisa kernel: [ T1772] pcieport 0000:00:01=
.1: rpm_resume 957: retval =3D -22
2025-12-05T02:02:52.209969+01:00 lisa kernel: [T193512] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:02:53.465055+01:00 lisa kernel: [T192396] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:02:53.465074+01:00 lisa kernel: [T192396] pcieport 0000:00:0=
1.1: acpiphp_check_bridge: pm_runtime_get_sync() failed with ret =3D -22
2025-12-05T02:02:57.133996+01:00 lisa kernel: [T192396] pcieport 0000:00:0=
1.1: rpm_resume 957: retval =3D -22
2025-12-05T02:02:57.134006+01:00 lisa kernel: [T192396] pcieport 0000:00:0=
1.1: acpiphp_check_bridge: pm_runtime_get_sync() failed with ret =3D -22
These lines continue, all further resumes fail but no crash occurs.

The complete debug code used is here (it's rather messy though):
https://gitlab.freedesktop.org/spasswolf/linux-stable/-/commits/amdgpu_sus=
pend_resume?ref_type=3Dheads
I've not tested yet, If the fix above also works on a pure v6.14 without a=
ll the debug patches.


The bad news is I've encountered another version of the crash. (at least 9=
0% of these crashes occur after=C2=A0
acpi_power_on() fails as above, but at least 2 crashes happened on suspend=
) Now a third version has appeared
which occured after an SMU resume failure in amdgpu (up to now SMU failure=
 have appeared but they did not
result in a crash like this)

2025-12-04T12:52:19.589753+01:00 T39596;amdgpu 0000:03:00.0: amdgpu: SMU i=
s resuming...#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:03:00.0
2025-12-04T12:52:19.589753+01:00 T39596;amdgpu 0000:03:00.0: amdgpu: smu d=
river if version =3D 0x0000000f, smu fw if version =3D 0x00000013, smu fw =
program =3D 0,
version =3D 0x003b3100 (59.49.0)#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:000=
0:03:00.0
2025-12-04T12:52:19.589753+01:00 T39596;amdgpu 0000:03:00.0: amdgpu: SMU d=
river if version not matched#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:03=
:00.0
2025-12-04T12:52:19.861952+01:00 T39596;amdgpu 0000:03:00.0: amdgpu: SMU: =
response:0xFFFFFFFF for index:6 param:0x00000000 message:EnableAllSmuFeatu=
res?#012
SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:03:00.0
2025-12-04T12:52:19.861952+01:00 T39596;amdgpu 0000:03:00.0: amdgpu: Faile=
d to enable requested dpm features!#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:=
0000:03:00.0
2025-12-04T12:52:19.861952+01:00 T39596;amdgpu 0000:03:00.0: amdgpu: Faile=
d to setup smc hw!#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:03:00.0
2025-12-04T12:52:19.861952+01:00 T39596;amdgpu 0000:03:00.0: amdgpu: resum=
e of IP block <smu> failed -121#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000=
:03:00.0
2025-12-04T12:52:19.861952+01:00 T39596;amdgpu 0000:03:00.0: amdgpu: amdgp=
u_device_ip_resume failed (-121).#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:00=
00:03:00.0
2025-12-04T12:52:19.861952+01:00 T39596;amdgpu 0000:03:00.0: pci_pm_runtim=
e_resume 1380 error =3D -121 state =3D 0x0#012 SUBSYSTEM=3Dpci#012 DEVICE=
=3D+pci:0000:03:00.0

=46rom here on the system hangs for quite a long time (9s!) while these er=
ror messages appear on netconsole:

2025-12-04T12:52:20.870639+01:00 C0;INFO: NMI handler (perf_event_nmi_hand=
ler) took too long to run: 122.609 msecs
2025-12-04T12:52:21.072400+01:00 C0;perf: interrupt took too long (958843 =
> 2500), lowering kernel.perf_event_max_sample_rate to 1000
2025-12-04T12:52:21.879308+01:00 C5;INFO: NMI handler (perf_event_nmi_hand=
ler) took too long to run: 138.016 msecs
2025-12-04T12:52:23.493066+01:00 C13;INFO: NMI handler (perf_event_nmi_han=
dler) took too long to run: 162.351 msecs
2025-12-04T12:52:23.694900+01:00 C13;perf: interrupt took too long (126845=
5 > 1198553), lowering kernel.perf_event_max_sample_rate to 1000
2025-12-04T12:52:26.318173+01:00 C11;INFO: NMI handler (perf_event_nmi_han=
dler) took too long to run: 182.852 msecs
2025-12-04T12:52:28.940844+01:00 C0;perf: interrupt took too long (2079549=
 > 1585568), lowering kernel.perf_event_max_sample_rate to 1000
[crash, no further messages]

So perhaps acpi_php_check_bridge() is not the only place where a returned =
error
is incorrectly ignored.

Bert Karwatzki
