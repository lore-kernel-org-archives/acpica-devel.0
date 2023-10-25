Return-Path: <peterz@infradead.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B2F94095F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A20054046F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=4jXfSAs/OUT6Ayj3tW7CYh3Hb2UaHX2D+jHjYtfb32k=; b=lYi0G2ACqlktbPLMIQ3Mqzp/sf
 cy6joSVmmS/2yikTEosSVY/MI/R++s0XcXjSX7w4zZ4SCFDB6sPbjP5lhobDLhdw3gVfeCRS06MKS
 KWOaC2WU3qT/5lNPmxsZ+gsxoH9XO87+flkxO+keRCTdFm1mLFuG+OVk+vISH//hN3Ve4NGnVIN+B
 saztQZWZK7M50YEHcPhAH9A8XFUQfYqlJvCxQNdKanntFGg4+kHQA9KNjjEcYG++CL2n3cm/yhW4F
 z8Pr8syoW/k6+JdqAYY2e1oz7wAWhqw3xmcZp5AtZFoEbZD0ipetCVyeYNn0+79DalbFnTN9tgN3J
 lGZnckJw==;
Date: Wed, 25 Oct 2023 14:11:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
Message-ID: <20231025121143.GA28289@noisy.programming.kicks-ass.net>
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-5-vincent.guittot@linaro.org>
 <20231025115456.GD31201@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025115456.GD31201@noisy.programming.kicks-ass.net>
Subject: Re: [Acpica-devel] [PATCH v3 4/6] energy_model: use a fixed
	reference frequency
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: juri.lelli@redhat.com, catalin.marinas@arm.com, robert.moore@intel.com, bsegall@google.com, conor.dooley@microchip.com, pierre.gondois@arm.com, linux-riscv@lists.infradead.org, will@kernel.org, acpica-devel@lists.linuxfoundation.org, vschneid@redhat.com, ajones@ventanamicro.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, mingo@redhat.com, bristot@redhat.com, lftan@kernel.org, viresh.kumar@linaro.org, mgorman@suse.de, aou@eecs.berkeley.edu, linux-pm@vger.kernel.org, rostedt@goodmis.org, paul.walmsley@sifive.com, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, palmer@dabbelt.com, sudeep.holla@arm.com, suagrfillet@gmail.com, lenb@kernel.org, ionela.voinescu@arm.com, lukasz.luba@arm.com

On Wed, Oct 25, 2023 at 01:54:56PM +0200, Peter Zijlstra wrote:

Also, can we pretty please not cross-post to moderated lists, that's
rude.

Rafael, can you please mark this acpica-devel crap as moderated in
MAINTAINERS so that it can be auto-magically excluded from receiving
mail?
