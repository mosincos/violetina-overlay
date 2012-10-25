# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4



inherit subversion 
#   epatch "${FILESDIR}"/patch-name-here
#
# eclasses tend to list descriptions of how to use their functions properly.
# take a look at /usr/portage/eclasses/ for more examples.

# Short one-line description of this package.
DESCRIPTION="Razor-qt is an advanced, easy-to-use, and fast desktop environment based on Qt technologies."

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://www.umplayer.com/"

# Point to any required sources; these will be automatically downloaded by
# Portage.
#SRC_URI="https://umplayer.svn.sourceforge.net/svnroot/umplayer"
ESVN_REPO_URI="https://umplayer.svn.sourceforge.net/svnroot/umplayer/"
#ESVN_PROJECT="umplayer/trunk"
ESVN_STORE_DIR="${DISTDIR}/svn-src"

# Licensehttps://umplayer.svn.sourceforge.net/svnroot/umplayer umplayer of the package.  This must match the name of file(s) in
# /usr/portage/licenses/.  For complex license combination see the developer
# docs on gentoo.org for details.
LICENSE="GPL2"


SLOT="0"


KEYWORDS="~x86 ~amd64"

# Comprehensive list of any and all USE flags leveraged in the ebuild,
# with the exception of any ARCH specific flags, i.e. "ppc", "sparc",
# "x86" and "alpha".  This is a required variable.  If the ebuild doesn't
# use any USE flags, set to "".
IUSE=""

# A space delimited list of portage features to restrict. man 5 ebuild
# for details.  Usually not needed.
#RESTRICT="strip"


# Build-time dependencies, such as
#    ssl? ( >=dev-libs/openssl-0.9.6b )
#    >=dev-lang/perl-5.6.1-r1
# It is advisable to use the >= syntax show above, to reflect what you
# had installed on your system when you tested the package.  Then
# other users hopefully won't be caught without the right version of
# a dependency.
DEPEND="dev-util/cmake \
	sys-devel/gcc \
	media-gfx/imagemagick"

# Run-time dependencies. Must be defined to whatever this depends on to run.
# The below is valid if the same run-time depends are required to compile.
RDEPEND="${DEPEND} \
sys-auth/polkit-qt \
x11-base/xorg-server \
sys-fs/udev \
x11-libs/qt-core \
x11-libs/qt-dbus \
x11-libs/qt-declarative \
x11-libs/qt-gui \
x11-libs/qt-multimedia \
x11-libs/qt-opengl \
x11-libs/qt-qt3support \
x11-libs/qt-script \
x11-libs/qt-sql \
x11-libs/qt-svg \
x11-libs/qt-test \
x11-libs/qt-webkit \
x11-libs/qt-xmlpatterns"


#S="${WORKDIR}/${P}"

src_configure() {
        # Most open-source packages use GNU autoconf for configuration.
        # The default, quickest (and preferred) way of running configure is:
        econf
        #
        # You could use something similar to the following lines to
        # configure your package before compilation.  The "|| die" portion
        # at the end will stop the build process if the command fails.
        # You should use this at the end of critical commands in the build
        # process.  (Hint: Most commands are critical, that is, the build
        # process should abort if they aren't successful.)
        #./configure \
        #       --host=${CHOST} \
        #       --prefix=/usr \
        #       --infodir=/usr/share/info \
        #       --mandir=/usr/share/man || die
        # Note the use of --infodir and --mandir, above. This is to make
        # this package FHS 2.2-compliant.  For more information, see
        #   http://www.pathname.com/fhs/
}



src_compile() {
        # emake (previously known as pmake) is a script that calls the
        # standard GNU make with parallel building options for speedier
        # builds (especially on SMP systems).  Try emake first.  It might
        # not work for some packages, because some makefiles have bugs
        # related to parallelism, in these cases, use emake -j1 to limit
        # make to a single process.  The -j1 is a visual clue to others
        # that the makefiles have bugs that have been worked around.

        emake || die
}



src_install() {
        # You must *personally verify* that this trick doesn't install
        # anything outside of DESTDIR; do this by reading and
        # understanding the install part of the Makefiles.
        # This is the preferred way to install.
        #emake DESTDIR="${D}" install || die

        # When you hit a failure with emake, do not just use make. It is
        # better to fix the Makefiles to allow proper parallelization.
        # If you fail with that, use "emake -j1", it's still better than make.

        # For Makefiles that don't make proper use of DESTDIR, setting
        # prefix is often an alternative.  However if you do this, then
        # you also need to specify mandir and infodir, since they were
        # passed to ./configure as absolute paths (overriding the prefix
        # setting).
        #emake \
        #       prefix="${D}"/usr \
        #       mandir="${D}"/usr/share/man \
        #       infodir="${D}"/usr/share/info \
        #       libdir="${D}"/usr/$(get_libdir) \
        #       install || die
        # Again, verify the Makefiles!  We don't want anything falling
        # outside of ${D}.

        # The portage shortcut to the above command is simply:
        #
        einstall || die
}

