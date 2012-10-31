# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit  cmake-utils git-2 jackmidi
RESTRICT="mirror"

#MY_P=ZynAddSubFX-${PV}
DESCRIPTION="ZynAddSubFX is an opensource software synthesizer."
HOMEPAGE="http://zynaddsubfx.sourceforge.net/"
EGIT_REPO_URI="git://repo.or.cz/zynaddsubfx.git"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="oss alsa jack jackmidi lash"

DEPEND="x11-libs/ntk
	=sci-libs/fftw-3*
	jackmidi? ( >=media-sound/jack-audio-connection-kit-0.100.0-r3 )
	!jackmidi? ( media-sound/jack-audio-connection-kit )
	>=dev-libs/mini-xml-2.2.1
	lash? ( >=media-sound/lash-0.5 )"

RDEPEND="media-libs/zynaddsubfx-banks
	!media-sound/zynaddsubfx-cvs"


pkg_setup() {
	# jackmidi.eclass
	use jackmidi && need_jackmidi
}


src_configure() {
cmake-utils_src_configure
}

src_compile() {
cmake-utils_src_compile
}
src_install() {
cmake-utils_src_install
}

pkg_postinst() {
	einfo "Banks are now provided with the package zynaddsubfx-banks"
	einfo "To get some nice sounding parameters emerge zynaddsubfx-extras"
}
