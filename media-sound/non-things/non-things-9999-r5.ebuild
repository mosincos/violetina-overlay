# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils git-2

DESCRIPTION="The Non Things: Non-DAW, Non-Mixer, Non-Sequencer and Non-Session-Manager"
HOMEPAGE="http://non.tuxfamily.org"
EGIT_REPO_URI="git://git.tuxfamily.org/gitroot/non/non.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="**"
IUSE="-debug non-daw non-mixer non-sequencer non-session-manager"

RDEPEND=">=media-sound/jack-audio-connection-kit-0.103.0
	>=media-libs/liblrdf-0.1.0
	>=media-libs/liblo-0.26
	>=dev-libs/libsigc++-2.2.0
	"
DEPEND="${RDEPEND}"


src_prepare() {
	for i in mixer sequencer session-manager timeline
	do
		cd ${S}/$i
		sed -i -e 's;@BIN_PATH@:$(prefix)/bin;@BIN_PATH@/:;' makefile.inc || die "sed $i/makefile.inc failed"
	done
#	epatch "${FILESDIR}/Makefile.patch"
}

src_configure() {
	#git submodule update --init 
	#./configure --prefix=/usr --enable-debug=no && make -C lib && 
	#make -C lib && ./configure --prefix=/usr --enable-debug=no || die
	./configure --prefix=/usr --enable-debug=no || die
}

src_compile() {
make # builds everything else
}

src_install() {
	emake DESTDIR="${D}" install
}

