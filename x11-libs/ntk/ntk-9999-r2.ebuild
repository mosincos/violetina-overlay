# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit waf-utils git-2 python flag-o-matic

DESCRIPTION="The Non Things: Non-DAW, Non-Mixer, Non-Sequencer and Non-Session-Manager"
HOMEPAGE="http://non.tuxfamily.org"
#EGIT_REPO_URI="git://git.tuxfamily.org/gitroot/non/non.git"
EGIT_REPO_URI="git://git.tuxfamily.org/gitroot/non/fltk.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="**"
IUSE="-debug"

RDEPEND=">=media-sound/jack-audio-connection-kit-0.103.0
        >=media-libs/liblrdf-0.1.0
        >=media-libs/liblo-0.26
        >=dev-libs/libsigc++-2.2.0
        "
DEPEND="${RDEPEND}"

#pkg_setup(){
#	python_set_active_version 2
#}

src_configure() {
	${WAF_BINARY:="${S}/waf"}
	#./waf configure --prefix=/usr 
	waf-utils_src_configure 
}

src_compile() {
	#./waf  build
	append-ldflags $(no-as-needed)		
	#waf-utils_src_compile
	./waf  build || die
}
src_install() {
	waf-utils_src_install	
}

