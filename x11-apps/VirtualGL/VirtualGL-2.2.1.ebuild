# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
inherit eutils bash-completion flag-o-matic autotools

DESCRIPTION="VirtualGL redirects 3D commands from a Unix/Linux OpenGL application onto a server-side 3D graphics card and converts the rendered 3D images into a video stream with which remote clients can interact to view and control the 3D application in real time."
HOMEPAGE="http://sourceforge.net/projects/virtualgl/"
SRC_URI="http://sourceforge.net/projects/virtualgl/files/VirtualGL/2.2.1/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

src_compile() {
    cd vgl
#    econf --with-posix-regex
    replace-flags -O3 -O2
    emake || die
}

src_install() {
    emake DESTDIR="${D}" install || die

    dodoc FAQ NEWS README || die
    dohtml EXTENDING.html ctags.html
}
