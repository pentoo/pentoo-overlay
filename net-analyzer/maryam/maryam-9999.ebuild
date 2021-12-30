# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9,10,11} )

inherit distutils-r1

#S="${WORKDIR}/${PV}" 

# maryam-2.5.0/work/Maryam-v.2.5.0 # fixme... 

DESCRIPTION="OWASP Maryam is a modular open-source framework based on OSINT and data gathering. "
HOMEPAGE="https://owasp.org/www-project-maryam/"

#KEYWORDS="~amd64 ~arm ~arm64 ~x86" 

# maryam-2.2.6.post1.tar.gz post1/post2 whish for r1 r2 handelinng for pypi mirrors but... bumps often and with weird revision reposts.
# saeeddhqan ${PV} +1 or 2 on minor revs as if using pypi ${PN}-${PV}.post1.tar.gz" or 2 throws some hairballs. 

#  
#PYPI_URI SRC_URI=" ,PYPI_URI for mirrors perhaps" 

	
#PYPI_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz
# fix the minor rev's on pypi ? find some means of taking .post1. .post#. > ${PN}-${PV}-.tar.gz" spitting out a clean version or version-r# / else use newer rev..
#PYPI_URI2="mirror://pypi/${P:0:1}/${PN}/${P}.post1.tar.gz > ${PN}-${PV}-r1.tar.gz 
#PYPI_URI3="mirror://pypi/${P:0:1}/${PN}/${P}.post2.tar.gz > ${PN}-${PV}-r2.tar.gz 

# no eapi/eclass  to automove ebuild bin to an revision version , a nice arry to

if [[ ${PV} == *9999 ]]; the

	inherit git-r3

	EGIT_REPO_URI="https://github.com/saeeddhqan/Maryam.git"

else

	SRC_URI="https://github.com/saeeddhqan/Maryam/archive/refs/tags/v.${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

S="${WORKDIR}/${PV}"
src_prepare() {

# maryam-2.5.0/work/Maryam-v.2.5.0 # fixme... mv ${PN}-${PV} fix path tarball keeps path on unpack maryam fits gentoo M(*)armyam in M caped is orig product. 
# Fix  example Maryam-v.2.5.0 to maryam.2.5.0 dir so python builds if symlinked.  to satable 

cd ${WORKDIR}/ 
mv M*v.*  ${PN}-${PV}

}

fi 



LICENSE="GPL-2"
SLOT="0"



RDEPEND="dev-python/requests
	dev-python/cloudscraper  
	dev-python/beautifulsoup:4
	dev-python/flask 
	dev-python/lxml
	dev-python/matplotlib
	dev-python/nltk
	dev-python/pandas
	dev-python/plotly
	media-gfx/word_cloud
	"
	# more recent deps added 
	#dev-python/vaderSentiment https://github.com/cjhutto/vaderSentiment recently add to do.. 

#### more deps as project grows. 
#Test_DEPEND # test? (dev-python/flake8 #   dev-python/black

#### gentoo-guru eselect repository enable guru ....
