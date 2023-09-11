Return-Path: <LeoLiu-oc@zhaoxin.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C29081393
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C96081390
Message-ID: <a3a603ef-b813-4798-bb54-62076d53bd3a@zhaoxin.com>
MIME-Version: 1.0
References: <20230810232041.GA50619@bhelgaas>
From: LeoLiu-oc <leoliu-oc@zhaoxin.com>
In-Reply-To: <20230810232041.GA50619@bhelgaas>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Acpica-devel] [PATCH v3 0/5] Parse the PCIe AER and set to
	relevant registers
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Mon, 11 Sep 2023 09:20:45 -0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: tony.luck@intel.com, linux-pci@vger.kernel.org, robert.moore@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ErosZhang@zhaoxin.com, bp@alien8.de, bhelgaas@google.com, james.morse@arm.com, acpica-devel@lists.linuxfoundation.org, lenb@kernel.org



在 2023/8/11 7:20, Bjorn Helgaas 写道:
> On Tue, Jul 04, 2023 at 08:04:53PM +0800, LeoLiu-oc wrote:
>> From: leoliu-oc <leoliu-oc@zhaoxin.com>
>>
>> According to the sec 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI r6.5, the
>> register values form HEST PCI Express AER Structure should be written to
>> relevant PCIe Device's AER Capabilities. So the purpose of the patch set
>> is to extract register values from HEST PCI Express AER structures and
>> program them into AER Capabilities.
>> Refer to the ACPI Spec r6.5 for a more detailed description.
>> Considering that HEST AER patch is an effective supplement to _HPP/_HPX
>> method when the Firmware does not support the _HPP/_HPX method and can be
>> specially configured for the AER register of a specific device.
>> The question about whether OS has control of AER to write the information
>> in the HEST AER structure to the AER register of the corresponding device
>> is similar to the question about _HPX/_HPP method to write the AER
>> information to the AER register of the corresponding device.I looked in
>> ACPI Spec for a description of the relationship between writing to the AER
>> register through the _HPP/_HPX method and whether the OS requires AER
>> control:
>> 1.OSPM uses the information returned by _HPX to determine how to
>> configure PCI Functions that are hot- plugged into the system, to
>> configure Functions not configured by the platform firmware during initial
>> system boot, and to configure Functions any time they lose configuration
>> space settings (e.g. OSPM issues a Secondary Bus Reset/Function Level
>> Reset or Downstream Port Containment is triggered).
>>
>> 2._HPX may return multiple types or Record Settings (each setting in a
>> single sub-package.) OSPM is responsible for detecting the type of
>> Function and for applying the appropriate settings. OSPM is also
>> responsible for detecting the device / port type of the PCI Express
>> Function and applying the appropriate settings provided.
>> For example, the Secondary Uncorrectable Error Severity and Secondary
>> Uncorrectable Error Mask settings of Type 2 record are only applicable to
>> PCI Express to PCI-X/PCI Bridge whose device / port type is 1000b.
>> Similarly, AER settings are only applicable to hot plug PCI Express
>> devices that support the optional AER capability.
>>
>> 3.Note: OSPM may override the settings provided by the _HPX object's Type2
>> record (PCI Express Settings) or Type3 record (PCI Express Descriptor
>> Settings) when OSPM has assumed native control of the corresponding
>> feature. For example, if OSPM has assumed ownership of AER (via _OSC),
>> OSPM may override AER related settings returned by _HPX. This means that
>> writing the AER register value by _HPX does not require the OS to gain
>> control of the AER. Also from the usage description of _HPX, I think
>> ownership of AER means who decides the configuration value of the AER
>> register rather than who can write the configuration value. Even though
>> the OS does not have control or ownership of the AER, it should still
>> write the configuration values determined by the firmware to the AER
>> register at the request of the firmware.
>> Therefore, the ownership of AER is not considered in this patch.
> 
> There's a lot of good information above, but this is the cover letter,
> so it won't make it into the git history.  Can you move this
> information to the relevant patches, where it will help justify the
> need for the patch?
> 
> Also, if at all possible, can you arrange for the patches themselves
> to be sent as *responses* to the cover letter?  This makes the series
> thread nicely and makes it much easier to download and apply it.
> 
> Bjorn

OK. I will modify in next version.

LeoLiu-oc
