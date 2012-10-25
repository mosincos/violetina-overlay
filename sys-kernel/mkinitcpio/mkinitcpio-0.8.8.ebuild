# Copyright 1999-2012 Gentoo Foundation 
# Distributed under the terms of the GNU General Public License v2 
# $Header: mkinitcpio-0.8.8.ebuild $ 
EAPI=3 
inherit eutils 

DESCRIPTION="Modular initramfs image creation utility ported from Arch Linux" 
HOMEPAGE="http://www.archlinux.org/" 
SRC_URI="ftp://ftp.archlinux.org/other/${PN}/${PN}-${PV}.tar.gz" 

LICENSE="GPL" 
SLOT="0" 
KEYWORDS="~amd64 ~x86" 
IUSE="" 

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
   app-arch/libarchive" 
RDEPEND="${DEPEND}" 

src_prepare() { 
   cd "${WORKDIR}/${P}/install" 
   epatch "${FILESDIR}/${P}-base.patch" 
   epatch "${FILESDIR}/${P}-consolefont.patch" 
   epatch "${FILESDIR}/${P}-keymap.patch" 
} 

src_install() { 
   emake DESTDIR="${D}" install || die "Install Failed" 
}
