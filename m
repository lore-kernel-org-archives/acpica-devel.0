Return-Path: <rebecca@bsdio.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8FDD7415F0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ECB614159D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
 :content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to; s=fm1; t=1691501408; x=1691587808; bh=za
 e1CSgEKqxBn4L9ZDjH2GNUJPeOLwrNU8YJz1xSiCo=; b=JDdT4jGZgcjTPClTDi
 sL5+DCTTMpqeISeI2xs+xRzfGaoAxg3APGxWEDTMjLmt2AFJmVEhf06Ld48bUUq/
 kNaL9XjkPnbrCR/Cyjg7JCpEoi3QUMJLaBKhsH39VKCS5hm5QVPOwULpHItvs/0k
 l8jt4g52qHpeyyhqfmtrknSOgHHBLOyqD7HtnGrOI2B7BroqjhwfeWRQ+lk0R/BA
 1WbVDwa1QoiIlA+jje+gylYEUd03VcfnxToJ7MoEBs7Bctn/T5951uma1e7OLmQa
 RJOZczio7C1eLBF/Sv22udebeMOzXaYojigJ3Qyz0FVClgE+y0TpXhxER3tm+h/i
 680g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1691501408; x=1691587808; bh=zae1CSgEKqxBn
 4L9ZDjH2GNUJPeOLwrNU8YJz1xSiCo=; b=i/2glSfZM5FB2JyUmWVikD77ZsxUT
 0Cyd9SCgDo+rSTTbEwnjbpdhvgVQX6LmLWqEG95GxwSehJJC772MMSCmKEf1h/3A
 MNAU6bDhDk+her1xfBCd+9zSwRh+Tab0OyNkl04UpFfBDwQrVT6K2bhFS2KKY6r/
 yYVocvhDSuuXhHkYHvPs9ooTBtQ/x5AZ8j+oMbwvH2T8j29RCThYLq3LdwL4Eqr0
 QynzLgwp+QURRfRIhSJpsG0AxYTR+ob2S8Rbfa3Oj1EwWfyrx/PjbgU1E/WYkdhG
 sDZSyS9Ny8g7zVwqsTBKdmikJk9vXD36yxpbT+enGAbLtYxFpc/pH8K7Q==
Message-ID: <198e04f7-6283-11c5-c0fb-fe61adaa3512@bsdio.com>
Date: Tue, 8 Aug 2023 07:29:56 -0600
MIME-Version: 1.0
Content-Language: en-US
From: Rebecca Cran <rebecca@bsdio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Acpica-devel] acpica website: Git Repository link is invalid
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: acpica-devel@lists.linuxfoundation.org

I see that the old acpica.org website now redirects to 
https://www.intel.com/content/www/us/en/developer/topic-technology/open/acpica/overview.html 
.

However, the Download page still has the same problem I noticed a while 
ago. It says:


The Git repository can be directly accessed via 
git://github.com/acpica/acpica.git

For example:

|git clone git://github.com/acpica/acpica.git Github however disabled 
git:// access back in 2021 
(https://github.blog/2021-09-01-improving-git-protocol-security-github/), 
so all references to git:// should be changed to https:// . -- Rebecca Cran |

