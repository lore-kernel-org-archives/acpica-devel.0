Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4588E28A2B1
	for <acpica-devel@lists.linux.dev>; Thu, 13 Feb 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465327; cv=none; b=NQ3INR7PFNdtbxspaUPNo47kzmsEHHJ/f6ZlmotxMPbkuwRVjCEZiRCZ8n0j4y7RZhH8zTeS9Incn7slEYT0xCNBM9vSoROn517mYFOJlaQ2+0QGRsQwiW2L1v07XCa7tK4BkS5iFPdtjTv1c0bkjhxp76KvGzeAnSWCBgXROqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465327; c=relaxed/simple;
	bh=YH9gANKyS3GL4QBxsM8+mtS8ct7PrMUyuEHLml5E1zE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nvcp4tyZJ49nSQNsrRwuuXga3wL6I1c4zZbRMw2oVXxYQ5Z1kCE/l0CjKSKJk4o4df6Yg/bxRlvw+iZjNcVYwVZ33LAvxiycQT1OtmTtceeZmkw+pBovnINkaIkBMoPkLVUHHM2kMQL9maC/vXxaYR/3DlJJVRKyPl82IFJmH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neXfeNTG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neXfeNTG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739465326; x=1771001326;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=YH9gANKyS3GL4QBxsM8+mtS8ct7PrMUyuEHLml5E1zE=;
  b=neXfeNTG2zOV3wxNoWgX7U9RJrGybbILWRuCwdT8WcuXq5evCO/yYwED
   w/lC4TUbuyCUNNAI3MJTBKyYsdJyc+IS9nUBCGBX2tUEeZscZD1c0QY+7
   Box2mnf/2jXtpEA5CPask6Y8O/Ifws6iLbq2YORvQxz9TXHAWuv8OJM09
   IpDXSbIZ+D+AZaAuY90CLtTCxFTCpzQi2cq903CYHuzTR6wI0LPMsr8Mq
   AKfZnvlxFIgglvXzYtQQl5G2DzWSCY4gDbbtn3ir2zNau9KUY7nKUNHO2
   zLjE+fmc3PHFaATXx7H7jBIOXEeKsQZq6g5JizG4f3oPSWdEizTxzYWcc
   g==;
X-CSE-ConnectionGUID: 3kIjwkr3RPGiTjknxEoq3Q==
X-CSE-MsgGUID: uJVVZSITSSOOsTKf+wJQjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="51162481"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="51162481"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 08:48:19 -0800
X-CSE-ConnectionGUID: MRJ5twcjT1St9QbOHO5F+g==
X-CSE-MsgGUID: uG2HUAFKR2qS4mIZhhdZgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117819604"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 08:48:18 -0800
Date: Thu, 13 Feb 2025 08:48:16 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"Moore, Robert" <robert.moore@intel.com>
Cc: acpica-devel@lists.linux.dev
Subject: ACPICA MRRM support
Message-ID: <Z64iUD8EeF82k9Nt@agluck-desk3>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

[Resnd in plain text for mailing list]

I’m making a stab at support for the MRRM table (needed for “region aware” perf and RDT).
Described in the RDT architecture specification. Public version here: https://cdrdv2.intel.com/v1/dl/getContent/789566

I think I’m 95% of the way there in this tree:

https://github.com/aegl/acpica

This code can “-d” decompile the MRRM table from Simics (and the output look right to me).

It can create a template with the “-T MRRM” option (creates the table).

But I’m stuck on the “compile” section. Input from a .dsl file seems to be parsed correctly.
But output of the first subsection doesn’t fill in the “Length” field (which I thought the DT_LENGTH “type” should do).

None of the other 4 subsections make it into the output file.

My code is based around how the SRAT DtCompileSrat() function is written.

Did I miss something while simplifying that down to what is needed?

Any pointers gratefully received.

-Tony

