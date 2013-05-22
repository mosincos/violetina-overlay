# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 autotools-utils eutils

DESCRIPTION="hts media center for tvheadend and upnp"
SRC_URI=""
EGIT_REPO_URI="git://github.com/andoma/showtime.git"
KEYWORDS="**"
IUSE="pulseaudio ccache systemlibav"

DEPEND="net-dns/avahi 
	x11-libs/pango 
	media-libs/freetype 
	x11-libs/gtk+:2
	pulseaudio? ( media-sound/pulseaudio )
	ccache? ( dev-util/ccache )"
#RDEPEND="${DEPEND}"
PDEPEND=""
SLOT="0"
src_configure() {
    prefix=/usr
	if use ccache ; then
	./configure --prefix=$prefix --ccache
	fi
	if ! use pulseaudio ; then
	./configure --prefix=$prefix --disable-libpulse
	fi
       #./configure --prefix=$prefix 
#econf
}

src_compile() {
	make || die
}
src_install() {
        emake DESTDIR="${D}" install || die

      
}

