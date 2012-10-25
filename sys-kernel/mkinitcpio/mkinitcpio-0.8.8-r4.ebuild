# Copyright 1999-2012 Gentoo Foundation 
# Distributed under the terms of the GNU General Public License v2 
# $Header: mkinitcpio-0.8.8-r4 $ 
EAPI=3 
inherit eutils linux-info 

DESCRIPTION="Modular initramfs image creation utility ported from Arch Linux" 
HOMEPAGE="http://www.archlinux.org/" 
SRC_URI="ftp://ftp.archlinux.org/other/${PN}/${PN}-${PV}.tar.gz" 

LICENSE="GPL" 
SLOT="0" 
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 sh ~sparc ~x86" 
IUSE="udev clvm cryptsetup mdadm pcmcia custom_kernel" 
USE="udev clvm -cryptsetup -mdadm -pcmcia custom_kernel" 

DEPEND=">=sys-apps/busybox-1.19.3-r1[static] 
   app-arch/cpio 
   >=sys-apps/util-linux-2.21 
   >=sys-apps/kmod-7 
   sys-apps/grep 
   sys-apps/sed 
   sys-apps/findutils 
   app-shells/bash 
   sys-apps/file 
   app-arch/gzip 
   sys-apps/coreutils 
   app-arch/libarchive 
   udev? ( sys-fs/udev ) 
   mdadm? ( sys-fs/mdadm[static] ) 
   cryptsetup? ( sys-fs/cryptsetup[static] ) 
   clvm? ( sys-fs/lvm2[static] ) 
   pcmcia? ( sys-apps/pcmciautils )" 
RDEPEND="${DEPEND}" 

pkg_setup() { 

  if kernel_is -lt 2 6 32; then 
      die "Sorry, your kernel must be 2.6.32-r103 or newer!" 
  fi 
    
   check_extra_config 
} 

src_prepare() { 
   cd "${WORKDIR}/${P}/install" 
} 

src_install() { 

     if use udev; then 
       insinto /usr/lib/initcpio/hooks/ 

       doins "${FILESDIR}/hooks/udev" || die "udev hook install failed" 
     
       insinto /usr/lib/initcpio/install/ 
     
       doins "${FILESDIR}/install/udev" || die "udev install failed" 
       
       insinto /usr/lib/initcpio/udev/ 
       
       doins "${FILESDIR}/udev/11-dm-initramfs.rules" || die "udev rule install failed" 
     fi 
     
     if use clvm; then 
       insinto /usr/lib/initcpio/hooks/ 
       
       doins "${FILESDIR}/hooks/lvm2" || die"lvm2 hook install failed" 
       
       insinto /usr/lib/initcpio/install/ 
       
       doins "${FILESDIR}/install/lvm2" || die "lvm2 install failed" 
     fi 
     
     if use mdadm; then 
       insinto /usr/lib/initcpio/hooks/ 
       
       doins "${FILESDIR}/hooks/mdadm" || die "mdadm hook install failed" 
       dosym /usr/lib/initcpio/hooks/mdadm /usr/lib/initcpio/hooks/raid 
       
       insinto /usr/lib/initcpio/install/ 
       
       doins "${FILESDIR}/install/mdadm" || die "mdadm install failed" 
       doins "${FILESDIR}/install/mdadm_udev" || die "mdadm_udev install failed" 
     fi 
     
     if use cryptsetup; then 
       insinto /usr/lib/initcpio/hooks/ 
       
       doins "${FILESDIR}/hooks/encrypt" || die "encrypt hook install failed" 
       
       insinto /usr/lib/initcpio/install/ 
       
       doins "${FILESDIR}/install/encrypt" || die "encrypt install failed" 
    fi    
       
    if use pcmcia; then 
       insinto /usr/lib/initcpio/install/ 

       doins "${FILESDIR}/install/pcmcia" || die "pcmcia install failed"    
   fi 
    
   insinto /etc/mkinitcpio.d/ 
     doins "${FILESDIR}/preset/gentoo.preset" || die "gentoo.preset install failed" 
    
   insinto /etc/modprobe.d/ 
     doins "${FILESDIR}/usb-load-ehci-first.conf" || die "usb-load-ehci-first install failed" 
    
   emake DESTDIR="${D}" install || die "Install Failed" 
} 

