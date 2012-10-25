# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# TODO: QA: verbose build log, flags, stripping	

EAPI=4

inherit multilib 

DESCRIPTION="Cross-Platform Audio Plugins, using Juce and Qt4"
HOMEPAGE="http://distrho.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/Source/${P}.tar.bz2"

# check all licenses for all plugins
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	=dev-util/premake-3.7
	media-libs/alsa-lib
	media-libs/freetype:2
	media-sound/jack-audio-connection-kit
	sci-libs/fftw:3.0
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXrender
	x11-libs/qt-core:4"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/distrho

src_configure() {
	./scripts/premake-update.sh linux || die
}

src_compile() {
	make standalone lv2
	make gen
}

src_install() {
	dobin bin/standalone/*

	dolib.a libs/*.a

	insinto /usr/$(get_libdir)
	doins -r bin/lv2

	insinto /etc/HybridReverb2
	doins ports/hybridreverb2/data/HybridReverb2.conf

	insinto /usr/share
	doins -r ports/hybridreverb2/data/HybridReverb2
}
