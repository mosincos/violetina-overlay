# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# ebuild for darktable by jo hanika (hanatos@gmail.com)

EAPI=2
inherit git

DESCRIPTION="Utility to organize and develop raw images"
HOMEPAGE="http://darktable.sf.net/"
EGIT_REPO_URI="git://darktable.git.sf.net/gitroot/darktable/darktable"
EGIT_BRANCH="master"
EGIT_COMMIT="master"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+lensfun openmp gnome-keyring nls"

RDEPEND=">=dev-db/sqlite-3.6.11
	>=dev-util/intltool-0.40.5
	>=gnome-base/gconf-2.24.0
	gnome-keyring? ( >=gnome-base/gnome-keyring-2.28.0 )
	>=gnome-base/libglade-2.6.3
	>=media-gfx/exiv2-0.18.1
	>=media-libs/jpeg-6b-r8
	>=media-libs/lcms-1.17
	lensfun? ( >=media-libs/lensfun-0.2.4 )
	>=media-libs/libpng-1.2.38
	>=media-libs/openexr-1.6.1
	>=media-libs/tiff-3.9.2
	>=x11-libs/cairo-1.8.6
	>=x11-libs/gtk+-2.18.0"
DEPEND="${RDEPEND}"

src_unpack() {
	git_src_unpack
	cd "${S}"
}

src_configure() {
	./build.sh
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README TODO
}

