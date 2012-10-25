# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

#inherit eutils git-2

DESCRIPTION="The Non Things: Non-DAW, Non-Mixer, Non-Sequencer and Non-Session-Manager"
HOMEPAGE="http://non.tuxfamily.org"
#EGIT_REPO_URI="git://git.tuxfamily.org/gitroot/non/non.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="**"
IUSE="-debug -non-daw -non-mixer -non-sequencer"

RDEPEND=">=media-sound/jack-audio-connection-kit-0.103.0
	>=media-libs/liblrdf-0.1.0
	>=media-libs/liblo-0.26
	>=dev-libs/libsigc++-2.2.0
	"
DEPEND="${RDEPEND}
	x11-libs/cairo 
	x11-libs/libXft 
	media-libs/libpng 
	x11-libs/pixman 
	x11-libs/libXpm 
	virtual/jpeg 
	x11-libs/libXinerama
	x11-libs/libxcb 
	non-daw? ( media-sound/non-daw )
	non-mixer? ( media-sound/non-mixer )
	non-sequencer? ( media-sound/non-sequencer )
	media-sound/non-session-manager
"


#pkg_postinst() {
#	ewarn "If it is the first time you install ${PN},"
#	ewarn "You should review the value of BROWSER in /etc/env.d/61browser"
#	ewarn ""
#	ewarn "If running X, the best is to log-out and re-login."
#	ewarn "As alternative, you can run in a terminal"
#	ewarn "  env-update && source /etc-profile"
#	ewarn "and run the Non Things from the same terminal."
#	ewarn "Otherwise, Help -> Manual will do nothing."
#}
