Content-Type: multipart/mixed; boundary="===============3458599150941488006=="
MIME-Version: 1.0
From: gengdongjiu <gengdongjiu at huawei.com>
Subject: Re: [Devel] [PATCH v8 7/7] arm64: kvm: handle SError Interrupt by
 categorization
Date: Tue, 16 Jan 2018 19:19:38 +0800
Message-ID: <7eae0e8c-af91-72a1-d27d-e44daf642583@huawei.com>
In-Reply-To: 20180115083335.GC21403@cbox
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3458599150941488006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoffer

On 2018/1/15 16:33, Christoffer Dall wrote:
> On Fri, Jan 12, 2018 at 06:05:23PM +0000, James Morse wrote:
>> On 15/12/17 03:30, gengdongjiu wrote:
>>> On 2017/12/7 14:37, gengdongjiu wrote:
> =

> [...]
> =

>>
>> (I recall someone saying migration is needed for any new KVM/cpu feature=
s, but I
>> can't find the thread)
>>
> =

> I don't know of any hard set-in-stone rule for this, but I have
> certainly argued that since migration is a popular technique in data
> centers and often a key motivation behind using virtual machines as it
> provides both load-balancing and high availability, we should think
> about migration support for all features and state.  Further, experience
> has shown that retroactively trying to support migration can result in
> really complex interfaces for saving/restoring state (see the ITS
> ordering requirements in
> Documentation/virtual/kvm/devices/arm-vgic-its.txt as an example) so
> thinking about this problem when introducing functionality is a good
> idea.
> =

> Of course, if there are really good arguments for having some state that
> simply cannot be migrated, then that's fine, and we should just make
> sure that userspace (e.g. QEMU) and higher level components in the
> stack (libvirt, openstack, etc.) can detect this state being used, and
> ideally enable/disable it, so that it can predict that a particular VM
> cannot be migrated off a particular host, or between a particular set of
> two hosts.  As an example, migration is typically prohibited when using
> VFIO direct device assignment, but userspace etc. are already aware of
> this.
> =

> As a final note, if we add support for some architectural feature, which
> may be present on some particular hardware and/or implementation, if the
> KVM support for said feature is automatically enabled (and not
> selectively from userspace), I would push back quite strongly on
> something that doesn't support migration, because it would effectively
> prevent migration of VMs on ARM.
Thanks very much for this mail and reply, I will check it, please give me s=
ome time due to
recently busy with other things.

> =

> Thanks,
> -Christoffer
> =

> .
> =



--===============3458599150941488006==--

