Return-Path: <konstantin@linuxfoundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F14670453
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C09D4703CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1698873965;
 bh=jcuWpD0iyT9Jlknv+dlM/XnHlnNg23eaFCEMAWEkxDI=;
 h=Date:From:To:Subject:From;
 b=FlzNFZ3FCS2K4MkGpoRmqJFzzZQTOz00FYYsdw3RGNwBed2eps9+NzFZEJBpyCVxO
 825EOZWH5baeTKUvbk8fRFV3G/PajHeb7rkZlzjmZl7I8ozOo6LcuZ3OXNLvQHSOBn
 Zg7Uh9a/ZqWDTOM8BlHpzHIcFe4KqQVASyfRIvus=
Date: Wed, 1 Nov 2023 17:26:03 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Message-ID: <20231101-judicious-uakari-of-debate-f5aefc@nitro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Acpica-devel] PSA: the acpica-devel list is migrating to
	lists.linux.dev
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

Hello, all:

The mailman-2 system running on lists.linuxfoundation.org is being
decommissioned, so all lists currently hosted there will be found new homes.
*On November 7*, The acpica-devel list will be migrated to live on
lists.linux.dev, but the impact of this move should be minor:

1. The new canonical list address will be acpica-devel@lists.linux.dev.

2. *The old address will continue to work* for the foreseeable future, so any
   existing conversations can continue and any new messages sent to the old
   list address will be properly delivered to all subscribers.

3. All members will be automatically subscribed to the new list, so no action
   is required on anyone's part to keep receiving list mail.

4. The list will be archived on https://lore.kernel.org/acpica-devel/ with all
   prior archives automatically imported.

5. The List-ID header will change, regardless to which address the message is
   sent:

   before: List-Id: <acpica-devel.lists.linuxfoundation.org>
    after: List-Id: <acpica-devel.lists.linux.dev>

   You will need to update your filtering rules if you filter based on the
   contents of that header (on or after November 7).

6. The mailman footer will no longer be added to message bodies and the
   subject will no longer be modified to insert [acpica-devel] (because this
   violates DMARC).

7. Subscribing and unsubscribing will be done using the mlmmj supported
   commands, documented at https://subspace.kernel.org/subscribing.html

Please let me know if you have any questions or concerns. Otherwise, I will
follow up on November 7 after the move has been completed.

Best regards,
-K
