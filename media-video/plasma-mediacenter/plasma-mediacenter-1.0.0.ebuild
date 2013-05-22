# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwin/kwin-4.10.0.ebuild,v 1.2 2013/02/23 17:05:37 ago Exp $

EAPI=5

KMNAME="kde-workspace"
OPENGL_REQUIRED="always"
inherit cmake-utils

DESCRIPTION="plasma media center"
KEYWORDS="~amd64 ~x86"
SLOT="0"

IUSE="debug"

DEPEND="dev-qt/qt-mobility[qml,multimedia]
kde-base/kdelibs
dev-qt/qtcore
dev-qt/qtopengl
dev-qt/qtdeclarative"

SRC_URI="http://download.kde.org/stable/plasma-mediacenter/1.0.0/src/plasma-mediacenter-1.0.0-1.tar.gz"
S="${WORKDIR}/plasma-mediacenter"
