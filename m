Received: from emma.ndcode.org (mail.ndcode.org [93.95.229.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239831F995
	for <acpica-devel@lists.linux.dev>; Wed, 22 Apr 2026 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.95.229.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776879662; cv=none; b=Xgv7sEKeIVOswH2axvWLXClLM9jQmzm2rq58psoTiF+SRcHV7nUPKEmqnnx7/Mt7u2g7z3MrqHafpfkCsgnIqnleIrAMaYIsoY2x5DqOh/1bydIW9mZVw4waE8rnKuADfg7ASCusx9BVSQYJbC2glSrNzusRA15gSB2uR/iB6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776879662; c=relaxed/simple;
	bh=Q0c4z7IvehgsSZMDn9Zg+EiZLp2dfybag7ZNWdaARXM=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=W2UQkSLSVTekrTHJBYixbNmyPg1byaTNOzXgOLNOgVus/wRfSOpfZKBMQButeUTJj1V7VTi7VHCFRLyHwWOZgnDj94yXUq3wNEcKGr+7pCrp606ExwEb/Q7jF4CMoxQEqVzFTSJz2SuTOSSbN33rs4kjplvrOI+0J+C8vOvgEkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndcode.org; spf=pass smtp.mailfrom=ndcode.org; dkim=pass (2048-bit key) header.d=ndcode.org header.i=@ndcode.org header.b=BmtQHfdd; arc=none smtp.client-ip=93.95.229.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndcode.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndcode.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndcode.org header.i=@ndcode.org header.b="BmtQHfdd"
Received: from emma.ndcode.org (localhost [127.0.0.1])
	by emma.ndcode.org (Postfix) with ESMTP id 4g162f5WFLzWl0J
	for <acpica-devel@lists.linux.dev>; Wed, 22 Apr 2026 17:40:58 +0000 (GMT)
Authentication-Results: emma.ndcode.org (amavisd-new);
	dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
	header.d=ndcode.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ndcode.org; h=
	content-transfer-encoding:content-type:message-id:user-agent
	:subject:to:from:date:mime-version; s=dkim; t=1776879658; x=
	1779471659; bh=Q0c4z7IvehgsSZMDn9Zg+EiZLp2dfybag7ZNWdaARXM=; b=B
	mtQHfddypaT/PHOP4cx+pOtGTsTq375LFuOURFon5vH2upT40b97Fz17xTwij8z8
	xvNmIRfFIIlZTwNqKLZkm0GzCRAqu30e5SiEH8Lm4IBxgB7MtN8T7J7hxaOPy3P0
	Oj3VTN7/L+woXTmrxME8zUhTXtbjWEWLEmKfK0pGnjYjWHQvMxXij74bqm6Y21Pq
	Rt20C2wIY0/pmeHmKr21ysVy1urOf09EqYHy68XDD4iRs5CW6BJmpVteIW2/QGBe
	T32GtCUvZd1CtELRBYW6jtCyVa3zSB8fXa8BTyGliM7IuWrbhuQqYzVNZrCRtrb2
	0E+EN5Mg5MGvf0eXFdGYw==
X-Virus-Scanned: Debian amavisd-new at emma.ndcode.org
Received: from emma.ndcode.org ([127.0.0.1])
	by emma.ndcode.org (emma.ndcode.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0NAVdRQHfzyt for <acpica-devel@lists.linux.dev>;
	Wed, 22 Apr 2026 17:40:58 +0000 (GMT)
Received: from mail.ndcode.org (localhost [127.0.0.1])
	by emma.ndcode.org (Postfix) with ESMTPSA id 4g162f1gQdzWl0H
	for <acpica-devel@lists.linux.dev>; Wed, 22 Apr 2026 17:40:58 +0000 (GMT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 23 Apr 2026 03:40:58 +1000
From: nick@ndcode.org
To: acpica-devel@lists.linux.dev
Subject: RFC: Patch for stricter parsing to fix crash on broken hardware
User-Agent: Roundcube Webmail
Message-ID: <ea13751830b669aea70d226fbabbee5a@ndcode.org>
X-Sender: nick@ndcode.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi team,

First time posting here -- sorry I don't know how to use git send-email 
yet, so I'm just going to include the patch inline, it's only an RFC and 
not suitable to merge directly in any case. It would need a command-line 
option added to make it useful.

The problem I'm working on is, getting linux to boot on a new Asus M1502 
laptop model released late 2025 -- symptom was a blank screen and 
apparently nobody is using this model yet, because there weren't any 
suggestions online. I found that acpi=off helps. But strangely, noacpi 
doesn't help. I guess the older syntax noacpi does something different 
than the newer syntax acpi=off.

I spent some time trying to find a workaround for the blank screen, 
because I couldn't see any error messages -- and eventually came up with 
the incantation: earlycon=efifb keep_bootcon (I found that other options 
like earlyprintk=vga or vga=0xf00 do not work on this hardware, not sure 
why).

Okay so with this in place I can see that the ACPI tables are broken, 
the errors are approximately (transcribing from a screenshot I took by 
phone):
ACPI BIOS Error (bug): Failure creating named object [\ASMI], 
AE_ALREADY_EXISTS ...
ACPI Error: AE_ALREADY_EXISTS, during lookup/catalog ...
ACPI BIOS Error (bug): Failure creating named object [\RESV], 
AE_ALREADY_EXISTS ...
ACPI Warning: NsLookup: Type mismatch on RESV (IndexField), searching 
for (RegionField) ...

Shortly afterwards it gets a NULL pointer dereference and crashes. I did 
try putting NULL tests on this line but then it just crashed further 
down, so the problem is apparently that due to the type mismatch, it's 
trying to interpret the wrong kind of object and this object has NULLs 
in the wrong places.

So what I decided to do was make the NsLookup stricter, so it would 
return a failure instead of returning the wrong kind of object. 
Additionally, I had to remove some other error recovery code later on, 
which was accepting the table despite errors parsing it. With these two 
fixes, I can boot.

The following patch applies to linux tag v6.19 and implements the 
stricter checking:
```patch
diff --git a/drivers/acpi/acpica/nsaccess.c 
b/drivers/acpi/acpica/nsaccess.c
index a0c1a665dfc1..a758acf90fa3 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -700,6 +700,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
  								    type),
  					      acpi_ut_get_type_name
  					      (type_to_check_for)));
+ return_ACPI_STATUS(AE_NOT_EXIST);
  			}

  			/*
diff --git a/drivers/acpi/acpica/psobject.c 
b/drivers/acpi/acpica/psobject.c
index 496a1c1d5b0b..4235fd98869a 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -588,6 +588,7 @@ acpi_ps_complete_op(struct acpi_walk_state 
*walk_state,
  		walk_state->prev_op = NULL;
  		walk_state->prev_arg_types = walk_state->arg_types;

+#if 0
  		if (walk_state->parse_flags & ACPI_PARSE_MODULE_LEVEL) {
  			/*
  			 * There was something that went wrong while executing code at the
@@ -600,6 +601,7 @@ acpi_ps_complete_op(struct acpi_walk_state 
*walk_state,
  			ACPI_INFO(("Ignoring error and continuing table load"));
  			return_ACPI_STATUS(AE_OK);
  		}
+#endif
  		return_ACPI_STATUS(status);
  	}

```

I realize that in a majority of cases, ignoring type mismatch errors and 
accepting a table despite errors in it, is the right thing to do. So I 
believe that adopting this patch unconditionally would cause breakage 
and complaints with previously working systems. But perhaps it could be 
a kernel command-line option? Like acpi.strict=on or similar. There are 
guides that suggest you try acpi=ht and similar, this could be another 
one to try.

If agreed, I could try to work up a formal patch. But I think we would 
also run into difficulties getting it accepted upstream. So I'm not 
sure. Hmm.

Kind regards, Nick
