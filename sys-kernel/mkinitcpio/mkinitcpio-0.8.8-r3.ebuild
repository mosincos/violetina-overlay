# Copyright 1999-2010 Gentoo Foundation 
# Distributed under the terms of the GNU General Public License v2 
# $Header: mkinitcpio-0.8.8-r3 $ 
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

   check_extra_config 
} 


src_prepare() { 
   cd "${WORKDIR}/${P}/install" 
} 

src_install() { 
     #insinto /usr/lib/initcpio/hooks/ 

     if use udev; then 
       insinto /usr/lib/initcpio/hooks/ 

       doins ${FILESDIR}/hooks/udev || die 
     
       insinto /usr/lib/initcpio/install/ 
     
       doins ${FILESDIR}/install/udev || die 
       
       insinto /usr/lib/initcpio/udev/ 
       
       doins ${FILESDIR}/udev/11-dm-initramfs.rules || die 
     fi 
     
     if use clvm; then 
       insinto /usr/lib/initcpio/hooks/ 
       
       doins ${FILESDIR}/hooks/lvm2 || die 
       
       insinto /usr/lib/initcpio/install/ 
       
       doins ${FILESDIR}/install/lvm2 || die 
     fi 
     
     if use mdadm; then 
       insinto /usr/lib/initcpio/hooks/ 
       
       doins ${FILESDIR}/hooks/mdadm || die 
       dosym /usr/lib/initcpio/hooks/mdadm /usr/lib/initcpio/hooks/raid 
       
       insinto /usr/lib/initcpio/install/ 
       
       doins ${FILESDIR}/install/mdadm || die 
       doins ${FILESDIR}/install/mdadm_udev || die 
     fi 
     
     if use cryptsetup; then 
       insinto /usr/lib/initcpio/hooks/ 
       
       doins ${FILESDIR}/hooks/encrypt || die 
       
       insinto /usr/lib/initcpio/install/ 
       
       doins ${FILESDIR}/install/encrypt || die 
    fi    
       
    if use pcmcia; then 
       insinto /usr/lib/initcpio/install/ 

       doins ${FILESDIR}/install/pcmcia || die 
       
     
     fi 
    
   insinto /etc/mkinitcpio.d/ 
     doins ${FILESDIR}/preset/gentoo.preset || die 
    
   insinto /etc/modprobe.d/ 
     doins ${FILESDIR}/usb-load-ehci-first.conf || die 
    
   emake DESTDIR="${D}" install || die "Install Failed" 
} 
