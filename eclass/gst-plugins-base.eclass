# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gst-plugins-base.eclass,v 1.18 2010/08/12 10:53:57 pva Exp $

# Author : foser <foser@gentoo.org>

# gst-plugins eclass
#
# eclass to make external gst-plugins emergable on a per-plugin basis
# to solve the problem with gst-plugins generating far too much unneeded deps
#
# 3rd party applications using gstreamer now should depend on a set of plugins as
# defined in the source, in case of spider usage obtain recommended plugins to use from
# Gentoo developers responsible for gstreamer <gnome@gentoo.org>, the application developer
# or the gstreamer team.

inherit eutils gst-plugins10

GST_EXPF="src_unpack src_compile src_install"
case ${EAPI:-0} in
	2|3) GST_EXPF="${GST_EXPF} src_prepare src_configure" ;;
	1|0) ;;
	*) die "Unknown EAPI" ;;
esac
EXPORT_FUNCTIONS ${GST_EXPF}

###
# variable declarations
###

MY_PN=gst-plugins-base
MY_P=${MY_PN}-${PV}
# All relevant configure options for gst-plugins
# need a better way to extract these
# gst-plugins-base 0.9
my_gst_plugins_base="x xvideo xshm gst_v4l alsa cdparanoia gnome_vfs
gio libvisual ogg oggtest theora ivorbis vorbis vorbistest examples
freetypetest pango"

#SRC_URI="mirror://gnome/sources/gst-plugins/${PV_MAJ_MIN}/${MY_P}.tar.bz2"
SRC_URI="http://gstreamer.freedesktop.org/src/gst-plugins-base/${MY_P}.tar.bz2"

S=${WORKDIR}/${MY_P}

# added to remove circular deps
# 6/2/2006 - zaheerm
if [ "${PN}" != "${MY_PN}" ]; then
RDEPEND=">=media-libs/gst-plugins-base-${PV}"
DEPEND="${RDEPEND}
	~media-libs/gst-plugins-base-${PV}
	>=sys-apps/sed-4
	dev-util/pkgconfig"
RESTRICT=test
fi

###
# public functions
###

gst-plugins-base_src_configure() {

	# disable any external plugin besides the plugin we want
	local plugin gst_conf

	einfo "Configuring to build ${GST_PLUGINS_BUILD} plugin(s) ..."

	for plugin in ${my_gst_plugins_base}; do
		gst_conf="${gst_conf} --disable-${plugin} "
	done

	for plugin in ${GST_PLUGINS_BUILD}; do
		gst_conf="${gst_conf} --enable-${plugin} "
	done

	cd "${S}"
	econf ${@} --with-package-name="Gentoo GStreamer Ebuild" --with-package-origin="http://www.gentoo.org" ${gst_conf}

}

###
# public inheritable functions
###

gst-plugins-base_src_unpack() {

	unpack ${A}

	cd "${S}"
	has src_prepare ${GST_EXPF} || gst-plugins-base_src_prepare

}

gst-plugins-base_src_prepare() {

	# Link with the syswide installed gst-libs if needed
	gst-plugins10_find_plugin_dir
	sed -e "s:\$(top_builddir)/gst-libs/gst/interfaces/libgstinterfaces-\$(GST_MAJORMINOR).la:-lgstinterfaces-\$(GST_MAJORMINOR):" \
		-e "s:\${top_builddir}/gst-libs/gst/interfaces/libgstinterfaces-\$(GST_MAJORMINOR).la:-lgstinterfaces-\$(GST_MAJORMINOR):" \
		-e "s:\$(top_builddir)/gst-libs/gst/audio/libgstaudio-\$(GST_MAJORMINOR).la:-lgstaudio-\$(GST_MAJORMINOR):" \
		-e "s:\${top_builddir}/gst-libs/gst/audio/libgstaudio-\$(GST_MAJORMINOR).la:-lgstaudio-\$(GST_MAJORMINOR):" \
		-e "s:\$(top_builddir)/gst-libs/gst/cdda/libgstcdda-\$(GST_MAJORMINOR).la:-lgstcdda-\$(GST_MAJORMINOR):" \
		-e "s:\${top_builddir}/gst-libs/gst/cdda/libgstcdda-\$(GST_MAJORMINOR).la:-lgstcdda-\$(GST_MAJORMINOR):" \
		-e "s:\$(top_builddir)/gst-libs/gst/riff/libgstriff-\$(GST_MAJORMINOR).la:-lgstriff-\$(GST_MAJORMINOR):" \
		-e "s:\${top_builddir}/gst-libs/gst/riff/libgstriff-\$(GST_MAJORMINOR).la:-lgstriff-\$(GST_MAJORMINOR):" \
		-e "s:\$(top_builddir)/gst-libs/gst/tag/libgsttag-\$(GST_MAJORMINOR).la:-lgsttag-\$(GST_MAJORMINOR):" \
		-e "s:\${top_builddir}/gst-libs/gst/tag/libgsttag-\$(GST_MAJORMINOR).la:-lgsttag-\$(GST_MAJORMINOR):" \
		-e "s:\$(top_builddir)/gst-libs/gst/video/libgstvideo-\$(GST_MAJORMINOR).la:-lgstvideo-\$(GST_MAJORMINOR):" \
		-e "s:\${top_builddir}/gst-libs/gst/video/libgstvideo-\$(GST_MAJORMINOR).la:-lgstvideo-\$(GST_MAJORMINOR):" \
		-e "s:\$(top_builddir)/gst-libs/gst/netbuffer/libgstnetbuffer-\$(GST_MAJORMINOR).la:-lgstnetbuffer-\$(GST_MAJORMINOR):" \
		-e "s:\${top_builddir}/gst-libs/gst/netbuffer/libgstnetbuffer-\$(GST_MAJORMINOR).la:-lgstnerbuffer-\$(GST_MAJORMINOR):" \
		-e "s:\$(top_builddir)/gst-libs/gst/rtp/libgstrtp-\$(GST_MAJORMINOR).la:-lgstrtp-\$(GST_MAJORMINOR):" \
		-e "s:\${top_builddir}/gst-libs/gst/rtp/libgstrtp-\$(GST_MAJORMINOR).la:-lgstrtp-\$(GST_MAJORMINOR):" \
		-i Makefile.in
#	cd ${S}

	# Remove generation of any other Makefiles except the plugin's Makefile
#	if [ -d "${S}/sys/${GST_PLUGINS_BUILD_DIR}" ]; then
#		makefiles="Makefile sys/Makefile sys/${GST_PLUGINS_BUILD_DIR}/Makefile"
#	elif [ -d "${S}/ext/${GST_PLUGINS_BUILD_DIR}" ]; then
#		makefiles="Makefile ext/Makefile ext/${GST_PLUGINS_BUILD_DIR}/Makefile"
#	fi
#	sed -e "s:ac_config_files=.*:ac_config_files='${makefiles}':" \
#		-i ${S}/configure

}



gst-plugins-base_src_compile() {

	has src_configure ${GST_EXPF} || gst-plugins-base_src_configure ${@}
	gst-plugins10_find_plugin_dir
	emake || die "compile failure"

}

gst-plugins-base_src_install() {

	gst-plugins10_find_plugin_dir
	einstall || die

	[[ -e README ]] && dodoc README
}
