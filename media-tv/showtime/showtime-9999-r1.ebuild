# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 eutils

DESCRIPTION="hts media center for tvheadend and upnp"
SRC_URI=""
EGIT_REPO_URI="git://github.com/andoma/showtime.git"
KEYWORDS="**"
IUSE="pulseaudio ccache"

DEPEND="ccache? ( dev-util/ccache )
	net-dns/avahi 
	media-libs/freetype 
	pulseaudio? ( media-sound/pulseaudio )
	x11-libs/gtk+:2
	x11-libs/pango"
SLOT="0"
src_configure() {
 ./configure --disable-cddb --disable-cdda --prefix=/usr \
                $(use_enable pulseaudio libpulse) \
                $(usex ccache "--ccache" "")
                    
}
src_compile() {
        
        emake V=1
}


src_install() {
        emake DESTDIR="${D}" install
}

