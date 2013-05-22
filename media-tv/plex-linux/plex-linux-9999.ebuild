# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/xbmc/xbmc-9999.ebuild,v 1.129 2012/12/29 20:12:18 vapier Exp $

EAPI="4"

# Does not work with py3 here
# It might work with py:2.5 but I didn't test that
PYTHON_DEPEND="2:2.6"

inherit eutils python multiprocessing git-2 autotools

	EGIT_REPO_URI="git://github.com/gewalker/plex-linux.git"

DESCRIPTION=""

LICENSE="GPL-2"
SLOT="0"

#S=${WORKDIR}/${MY_P}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_unpack() {
	git-2_src_unpack 
}


src_configure() {
	./bootstrap
	econf 
}
src_compile() {
	make
	make -C lib/addons/script.module.pil
	make -C lib/addons/script.module.pysqlite
}

