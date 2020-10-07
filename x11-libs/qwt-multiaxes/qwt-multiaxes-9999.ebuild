# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils subversion

DESCRIPTION="2D plotting library for Qt5"
HOMEPAGE="https://qwt.sourceforge.net/"
ESVN_REPO_URI="https://svn.code.sf.net/p/qwt/code/branches/qwt-6.1-multiaxes"

LICENSE="qwt"
SLOT="6/1.9999"
IUSE="designer doc examples opengl svg"

DEPEND="
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
	designer? ( dev-qt/designer:5 )
	opengl? (
		dev-qt/qtopengl:5
		virtual/opengl
	)
	svg? ( dev-qt/qtsvg:5 )
"
RDEPEND="${DEPEND}"

DOCS=( README )

src_prepare() {
	default
	mv qwtconfig.pri qwt-multiaxesconfig.pri || die
	sed -e 's#qwtconfig.pri#qwt-multiaxesconfig.pri#' -i qwt.pro qwt.prf tests/tests.pri tests/tests.pro src/src.pro src/src.pri src/qwt_plot_canvas.h playground/playground.pri playground/playground.pro examples/examples.pri examples/examples.pro doc/install.dox doc/doc.pro designer/designer.pro classincludes/classincludes.pro admin/svn2package.sh || die

	cat > qwt-multiaxesconfig.pri <<-EOF
		QWT_INSTALL_LIBS = "${EPREFIX}/usr/$(get_libdir)"
		QWT_INSTALL_HEADERS = "${EPREFIX}/usr/include/qwt6-multiaxes"
		QWT_INSTALL_DOCS = "${EPREFIX}/usr/share/doc/${PF}"
		QWT_CONFIG += QwtPlot QwtWidgets QwtPkgConfig
		VERSION = ${PV/_*}
		QWT_VERSION = ${PV/_*}
	EOF

	use designer && echo "QWT_CONFIG += QwtDesigner" >> qwt-multiaxesconfig.pri
	use opengl && echo "QWT_CONFIG += QwtOpenGL" >> qwt-multiaxesconfig.pri
	use svg && echo "QWT_CONFIG += QwtSvg" >> qwt-multiaxesconfig.pri

	cat > qwt-multiaxesbuild.pri <<-EOF
		QWT_CONFIG += qt warn_on thread release no_keywords
	EOF

	echo "QWT_CONFIG += QwtDll" >> qwt-multiaxesconfig.pri

	cat >> qwt-multiaxesconfig.pri <<-EOF
		QWT_INSTALL_PLUGINS   = "${EPREFIX}$(qt5_get_plugindir)/designer"
		QWT_INSTALL_FEATURES  = "${EPREFIX}$(qt5_get_mkspecsdir)/features"
	EOF
	sed \
		-e 's/target doc/target/' \
		-e "/^TARGET/s:(qwt):(qwt6-qt5-multiaxes):g" \
		-e "/^TARGET/s:qwt):qwt6-qt5-multiaxes):g" \
		-i src/src.pro || die

	sed \
		-e '/qwtAddLibrary/s:(qwt):(qwt6-qt5-multiaxes):g' \
		-e '/qwtAddLibrary/s:qwt):qwt6-qt5-multiaxes):g' \
		-i qwt.prf designer/designer.pro examples/examples.pri || die

	sed -i 's#QMAKE_PKGCONFIG_NAME = Qwt#QMAKE_PKGCONFIG_NAME = Qwt-multiaxes#' src/src.pro || die
	sed -i 's#qwtconfig.pri qwtfunctions.pri qwt.prf#qwt-multiaxesconfig.pri qwt-multiaxesfunctions.pri qwt-multiaxes.prf#' qwt.pro || die
	mv qwt.prf qwt-multiaxes.prf || die
	mv qwtfunctions.pri qwt-multiaxesfunctions.pri || die
	sed -e 's#qwt.prf#qwt-multiaxes.prf#' -i qwt.pro admin/svn2package.sh classincludes/classincludes.pro designer/designer.pro playground/playground.pri examples/examples.pri tests/tests.pri src/src.pro || die
	sed -e 's#qwtfunctions.pri#qwt-multiaxesfunctions.pri#' -i qwt-multiaxes.prf tests/tests.pri src/src.pro playground/playground.pri examples/examples.pri designer/designer.pro classincludes/classincludes.pro || die
	sed -e 's#libqwt.so.$${VER_MAJ}.$${VER_MIN}#libqwt6-qt5-multiaxes.so.9999#' -i src/src.pro
}

src_configure() {
	eqmake5
}

src_compile() {
	default
}

src_test() {
	cd examples || die
	eqmake5 examples.pro
	emake
}

src_install() {
	emake INSTALL_ROOT="${D}" install

	einstalldocs

	if use examples; then
		# don't build examples - fix the qt files to build once installed
		cat > examples/examples.pri <<-EOF
			include( qwtconfig.pri )
			TEMPLATE     = app
			MOC_DIR      = moc
			INCLUDEPATH += "${EPREFIX}/usr/include/qwt6"
			DEPENDPATH  += "${EPREFIX}/usr/include/qwt6"
			LIBS        += -lqwt6
		EOF
		sed -i -e 's:../qwtconfig:qwtconfig:' examples/examples.pro || die
		cp *.pri examples/ || die
		insinto /usr/share/${PN}6
		doins -r examples
	fi
}
