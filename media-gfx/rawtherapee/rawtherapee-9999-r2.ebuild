# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit versionator cmake-utils mercurial

DESCRIPTION="THe Experimental RAw Photo Editor"
HOMEPAGE="http://www.rawtherapee.com/"
EHG_REPO_URI="https://rawtherapee.googlecode.com/hg/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
LANGS="cs da de en_US en_GB el es eu fr he hu it ja lv nl nn pl ru sk fi sv tr zh_CN zh_TW"
for lng in ${LANGS}; do
	IUSE="${IUSE} linguas_${lng}"
done

RDEPEND="dev-cpp/gtkmm:2.4
	media-libs/jpeg
	media-libs/tiff
	media-libs/libpng
	media-libs/libiptcdata
	media-libs/lcms"

RESTRICT="strip"

S=${WORKDIR}/hg

src_unpack() {
	mercurial_src_unpack
}
src_prepare() {
	sed -ie 's:${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}):\"${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}\"):g' CMakeLists.txt
#	epatch ${FILESDIR}/cxx-flags-fix.patch
}

src_install() {
	cmake-utils_src_install

	insinto "/usr/share/pixmaps"
	doins "${FILESDIR}/${PN}.png" || die
	insinto "/usr/share/applications"
	doins "${FILESDIR}/${PN}3.desktop" || die

#	insinto "/opt/${MY_PN}/languages"
#        doins "languages/english-us" || die # Always install english lang. file
#        for lng in ${LINGUAS}; do
#                case $lng in
#                        cs) doins "languages/czech" || die ;;
#                        da) doins "languages/dansk" || die ;;
#                        de) doins "languages/deutsch" || die ;;
#                        en_GB) doins "languages/english-uk" || die ;;
#                        es) doins "languages/espanol" || die ;;
#                        eu) doins "languages/euskara" || die ;;
#                        el) doins "languages/greek" || die ;;
#                        fr) doins "languages/francais" || die ;;
#                        he) doins "languages/hebrew" || die ;;
#                        hu) doins "languages/magyar" || die ;;
#                        it) doins "languages/italian" || die ;;
#                        ja) doins "languages/japanese" || die ;;
#                        lv) doins "languages/latvian" || die ;;
#                        nl) doins "languages/nederlands" || die ;;
#                        nn) doins "languages/norsk-bm" || die ;;
#                        pl) doins "languages/polish" || die ;;
#                        ru) doins "languages/russian" || die ;;
#                        sk) doins "languages/slovak" || die ;;
#                        fi) doins "languages/suomi" || die ;;
#                        sv) doins "languages/swedish" || die ;;
#                        tr) doins "languages/turkish" || die ;;
#                        zh_CN) doins "languages/chinese simplified" || die ;;
#                        zh_TW) doins "languages/chinese traditional" || die ;;
#                esac
#        done
}

