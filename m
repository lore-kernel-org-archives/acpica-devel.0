Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474E62E3F2
	for <acpica-devel@lists.linux.dev>; Tue, 28 Nov 2023 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RO4OsA2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E290EC433C8;
	Tue, 28 Nov 2023 09:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701164469;
	bh=1bUB2TWqDegzRmJMIrx8/UwC8pIgyIJFkfByCMEnHqI=;
	h=From:To:Cc:Subject:Date:From;
	b=RO4OsA2OS87ttmJmwfT2xKc9By3631ZQ7H/t2eN+UvFXqHeeD5Ag6FY1D7cHgsYxf
	 EL3Jij8Dndw11//dRSLhOeZ6OSOolWhJz9s+qtTkEPaSkrrnBVYvOnbZhpH5oIChVF
	 6Aohm9IJ/X0jn9/HB56eFRr7CasKLfmEsImA4E4jUCGfsDeDlNsR4mSHkfdDkDtSbI
	 85+522F8Q/Rt+dzdujy/AQ4DKJGAw92v3HycFyiX9RTFzH5rOzwyRK16CF9VpvJ1Dy
	 DyMK4XiDRmxzwkvx3E80b2wmdzsK7f9LI5VOhn5UO45BRGrO6RXonXJZ47LhnnKLwW
	 qWifTRFFrHZ4A==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: acpica-devel@lists.linux.dev
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 0/2] ACPICA: Add Codefirst support for Mantis IDs: [3706,4557]
Date: Tue, 28 Nov 2023 10:41:00 +0100
Message-Id: <20231128094102.37662-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ACPICA support to handle Codefirst changes (Mantis ID: 3706 and 4557),
both adding flags to the ARM GIC MADT table entries.

Lorenzo Pieralisi (2):
  MADT: Add GICC online capable bit handling
  MADT: Add new MADT GICC/GICR/ITS non-coherent flags handling

 source/common/dmtbdump2.c    | 16 +++++--
 source/common/dmtbinfo2.c    | 80 +++++++++++++++++++++++++++++++++
 source/compiler/dttable2.c   | 19 ++++++--
 source/compiler/dttemplate.h | 85 ++++++++++++++++++------------------
 source/include/acdisasm.h    |  4 ++
 source/include/actbinfo.h    |  2 +
 source/include/actbl2.h      | 12 +++--
 7 files changed, 167 insertions(+), 51 deletions(-)

-- 
2.34.1

