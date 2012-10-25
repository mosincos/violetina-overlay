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
IUSE="-debug"

RDEPEND=">=media-sound/jack-audio-connection-kit-0.103.0
	>=media-libs/liblrdf-0.1.0
	>=media-libs/liblo-0.26
	>=dev-libs/libsigc++-2.2.0
	"
DEPEND="${RDEPEND}"


src_prepare() {
	# adding fltk cflags
#	epatch "${FILESDIR}/non_makefile.patch"
	# removing of wrong and non needed path for Exec key of desktop files
	for i in mixer sequencer session-manager timeline
	do
		cd ${S}/$i
		sed -i -e 's;@BIN_PATH@:$(prefix)/bin;@BIN_PATH@/:;' makefile.inc || die "sed $i/makefile.inc failed"
	done
#find "$WORKDIR" -type -f -name configure -exec grep '^ask.*prefix /usr/local' {} \; -exec sed -i 's:^ask.*prefix /usr/local:prefix="'"$EPREFIX:" {} \;
}

src_configure() {
#find "$WORK" -type -f -name configure -exec grep '^ask.*prefix /usr/local' {} \; -exec sed -i 's:^ask.*prefix /usr/local:prefix="'"$EPREFIX:" {} \;

#cd ${S}/ntk && ./configure --prefix=/usr 
#cd ${S} ; ./configure --prefix=/usr  
#make -C ${S}/lib  || die "econf $i failed"
git submodule update --init && make -C lib && ./configure --prefix=/usr --enable-debug=no
}

src_compile() {
#find "$WORK" -type -f -name configure -exec grep '^ask.*prefix /usr/local' {} \; -exec sed -i 's:^ask.*prefix /usr/local:prefix="'"$EPREFIX:" {} \;
#cd ${S} ;./configure --prefix=/usr  # configures everything else
make # builds everything else
}

src_install() {
	#mkdir -p ${D}/usr/bin
#	for i in nonlib FL mixer sequencer session-manager timeline
#	do
#		cd ${S}/$i
#		make install || die "install failed"
#	done
	# debian specific command, fake it with a little script,
	# necessary to launch Help -> Manual
 emake DESTDIR="${D}" install


	dobin "${FILESDIR}/x-www-browser"
	doenvd "${FILESDIR}/61browser"
}

pkg_postinst() {
	ewarn "If it is the first time you install ${PN},"
	ewarn "You should review the value of BROWSER in /etc/env.d/61browser"
	ewarn ""
	ewarn "If running X, the best is to log-out and re-login."
	ewarn "As alternative, you can run in a terminal"
	ewarn "  env-update && source /etc-profile"
	ewarn "and run the Non Things from the same terminal."
	ewarn "Otherwise, Help -> Manual will do nothing."
}
