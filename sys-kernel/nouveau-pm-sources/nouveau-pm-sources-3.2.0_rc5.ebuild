# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/git-sources/git-sources-3.1_rc9.ebuild,v 1.2 2011/10/06 18:50:38 mpagano Exp $

EAPI="4"
#UNIPATCH_STRICTORDER="yes"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_NOUSEPR="yes"
K_SECURITY_UNSUPPORTED="yes"
K_DEBLOB_AVAILABLE=0
ETYPE="sources"
inherit kernel-2 git-2
detect_version

DESCRIPTION="nouveau-pm kernel git"
HOMEPAGE="http://lists.freedesktop.org/archives/nouveau/"
EGIT_REPO_URI="https://git.gitorious.org/linux-nouveau-pm/linux-nouveau-pm.git"
EGIT_BRANCH="thermal"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

K_EXTRAEINFO="This kernel is not supported by Gentoo due to its unstable and
experimental nature. If you have any issues, try a matching vanilla-sources
ebuild -- if the problem is not there, please contact the upstream kernel
developers at http://bugzilla.kernel.org and on the linux-kernel mailing list to
report the problem so it can be fixed in time for the next kernel release."

src_prepare () {
	epatch_user
}
pkg_postinst() {
	postinst_sources
}
