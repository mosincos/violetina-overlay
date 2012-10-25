# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="JACK based, GTK (2.x) host for LV2 synths"
HOMEPAGE="http://home.gna.org/zynjacku/"
SRC_URI="http://pkgs.fedoraproject.org/repo/pkgs/zynjacku/zynjacku-6.tar.bz2/4fe6bb1322ee5784280c7e71c77b636c//${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"

IUSE="+lv2dynparam"
DEPEND=">=media-sound/jack-audio-connection-kit-0.109.0
	media-libs/lv2
	>=dev-python/pygtk-2.0
	>=dev-lang/python-2.4
	>=dev-python/pycairo-1.8.2
	lv2dynparam? ( =media-libs/lv2dynparam1-2 )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_configure() {
	econf || die "Configure failed"
}

src_compile() {
	emake || die "Make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc README AUTHORS NEWS
}
