# Copyright 1999-2009 Gentoo Foundation
# Authors: Bruno Marmol & Emilien Kia & David Christensen
# Distributed under the terms of the GNU General Public License v2

# bugs:
# - can use variable for version number: for re-use after new version

inherit libtool eutils

S=${WORKDIR}/Amaya/LINUX-ELF

DESCRIPTION="The W3C Web-Browser"
HOMEPAGE="http://www.w3.org/Amaya/"
SRC_URI="http://www.w3.org/Amaya/Distribution/${PN}-fullsrc-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug opengl"

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
        local myconf="--enable-system-raptor"
        mkdir ${S}
        cd ${S}

        if use opengl
        then
                myconf="${myconf} --with-gl --enable-system-raptor"
        fi
        if use debug
        then
                myconf="${myconf} --with-debug --enable-system-raptor"
        fi

        ../configure \
                ${myconf} \
                --prefix=/usr \
#               --host=${CHOST}
        make || die
}

src_install () {
        dodir /usr
        make prefix=${D}/usr install || die
        PREFIX="/usr" ./script_install_gnomekde . ${D}/usr/share /usr

        rm ${D}/usr/bin/amaya
        rm ${D}/usr/bin/print
        dosym /usr/Amaya/wx/bin/amaya /usr/bin/amaya
        dosym /usr/Amaya/wx/bin/print /usr/bin/print

        domenu share/applications/amaya.desktop
        newicon ${WORKDIR}/Amaya/resources/bundle/logo.png amaya.png
}
